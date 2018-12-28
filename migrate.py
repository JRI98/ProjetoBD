import mysql.connector as mydb  # Importar biblioteca do MySQL
import pymongo as mondb         # Importar biblioteca do MongoDB
from datetime import datetime


### Acessos ao MySQL e ao MongoDB
# Acesso ao MySQL
mycon = mydb.connect(host='localhost', user='root', password='', database='sistemaenergia', auth_plugin='caching_sha2_password') ##### PREENCHER PASSWORD #####

# Acesso ao MongoDB
mondb = mondb.MongoClient('mongodb://localhost:27017/')['sistemaenergia']


### Dispositivos
# Extrair os dispositivos
def extrairDispositivos():
    cur = mycon.cursor()
    cur.execute("SELECT d.id, td.Designacao, d.RequerReparacao, d.EnergiaProduzida,\
                        d.UltimaManutencao, d.ProximaManutencao, d.latitude, d.longitude\
                 FROM Dispositivo d INNER JOIN TipoDispositivo td ON td.id = d.tipo")
    dispositivos = cur.fetchall()

    return dispositivos

# Inserir um dispositivo
def inserirDispositivo(dispositivo):
    (id, tipo, requerReparacao, energiaProduzida, ultimaManutencao, proximaManutencao, latitude, longitude) = dispositivo

    dispositivo = {
                    'id': id,
                    'tipo': tipo,
                    'requerReparacao': bool(requerReparacao),
                    'energiaProduzida': energiaProduzida,
                    'ultimaManutencao': ultimaManutencao,
                    'proximaManutencao': proximaManutencao,
                    'localizacao': {
                                    'latitude': float(latitude),
                                    'longitude': float(longitude)
                                   }
                    }

    mondb['Dispositivos'].insert_one(dispositivo)

    print('Dispositivo', id, 'inserido')

### Pecas
# Extrair as peças
def extrairPecas():
    cur = mycon.cursor()
    cur.execute("SELECT p.id, p.nif_fornecedor, f.designacao, p.QtdStock, p.designacao, p.precoUnitario\
                 FROM Peca p INNER JOIN Fornecedor f ON p.nif_fornecedor=f.nif")
    pecas = cur.fetchall()

    return pecas

# Extrair as compras de uma peça
def extrairComprasPeca(id_peca):
    cur = mycon.cursor()
    cur.execute("SELECT id, data, quantidade FROM Compra WHERE peca_id=%s", (id_peca,))
    aux = cur.fetchall()

    compras = []
    for c in aux:
        compra = {
            'id': c[0],
            'data': c[1],
            'quantidade': c[2]
        }
        compras.append(compra)

    return compras

# Inserir uma peça
def inserirPeca(peca):
    (id, nifFornecedor, descricaoFornecedor, qtdStock, designacao, precoUnitario) = peca

    # Extrair as compras da peça
    compras = extrairComprasPeca(id)

    peca = {
             'id': id,
             'fornecedor': {
                             'nif': nifFornecedor,
                             'descricao': descricaoFornecedor
                           },
             'qtdStock': qtdStock,
             'designacao': designacao,
             'precoUnitario': precoUnitario,
             'compras': compras
    }

    mondb['Pecas'].insert_one(peca)

    print('Peca', id, 'inserida')

### Servicos
# Extrair os servicos
def extrairServicos():
    cur = mycon.cursor()
    cur.execute("SELECT s.id, s.dispositivo_id, ts.designacao, s.datainicio, s.datafim, s.custoTotal\
                 FROM servico s INNER JOIN tiposervico ts ON ts.id=s.tipo")
    servicos = cur.fetchall()

    return servicos

# Extrair as peças usadas num serviço
def extrairPecasServico(id_servico):
    cur = mycon.cursor()
    cur.execute("SELECT peca_id, qtdUsada FROM ServicoPeca WHERE servico_id=%s", (id_servico,))
    aux = cur.fetchall()

    pecas = []
    for p in aux:
        peca = {
            'id': p[0],
            'quantidadeUsada': p[1]
        }
        pecas.append(peca)

    return pecas

# Extrair os funcionários que trabalharam num serviço
def extrairFuncionariosServico(id_servico):
    cur = mycon.cursor()
    cur.execute("SELECT f.id, f.nome FROM ServicoFuncionario sf\
                 INNER JOIN Funcionario f ON sf.funcionario_id=f.id WHERE servico_id=%s", (id_servico,))
    aux = cur.fetchall()

    funcionarios = []
    for f in aux:
        telefones = extrairTelefonesFuncionario(f[0])
        funcionario = {
            'id': f[0],
            'nome': f[1],
            'telefones': telefones
        }
        funcionarios.append(funcionario)

    return funcionarios

# Inserir um serviço
def inserirServico(servico):
    (id, dispositivo_id, tipo, datainicio, datafim, custoTotal) = servico

    # Obter as peças usadas no serviço
    pecasUsadas = extrairPecasServico(id)

    # Obter os funcionários que fizeram o serviço
    fucionariosAlocados = extrairFuncionariosServico(id)

    servico = {
                'id': id,
                'dispositivo_id': dispositivo_id,
                'tipo': tipo,
                'dataInicio': datainicio,
                'dataFim': datafim,
                'custoTotal': custoTotal,
                'pecasUsadas': pecasUsadas,
                'funcionariosAlocados': fucionariosAlocados
    }

    mondb['Servicos'].insert_one(servico)

    print ('Servico', id, 'inserido')


### Funcionarios
# Extrair os funcionários
def extrairFuncionarios():
    cur = mycon.cursor()
    cur.execute("SELECT f.id, f.nome, f.salario, f.estagiario, t.horainicio, t.horafim,\
                        r.descricao, l.descricao, p.descricao \
                 FROM Funcionario f INNER JOIN Turno t ON f.turno_id=t.id\
                                    INNER JOIN Rua r ON f.rua=r.id\
                                    INNER JOIN Localidade l ON r.localidade=l.id\
                                    INNER JOIN Pais p ON l.pais=p.id")
    funcionarios = cur.fetchall()

    return funcionarios

# Extrair os telefones de um funcionário
def extrairTelefonesFuncionario(id_funcionario):
    cur = mycon.cursor()
    cur.execute("SELECT telefone\
                 FROM Telefones WHERE funcionario_id=%s", (id_funcionario,))
    telefones = [item[0] for item in cur.fetchall()]

    return telefones

# Inserir um funcionário
def inserirFuncionario(funcionario):
    (id, nome, salario, estagiario, horaInicioTurno, horaFimTurno, rua, localidade, pais) = funcionario

    # Converter a horaInicioTurno e a horaFimTurno para datetime's
    horaInicioTurno = list(map(int, str(horaInicioTurno).split(":")))
    inicio = datetime(1, 1, 1, horaInicioTurno[0], horaInicioTurno[1], horaInicioTurno[2])
    horaFimTurno = list(map(int, str(horaFimTurno).split(":")))
    fim = datetime(1, 1, 1, horaFimTurno[0], horaFimTurno[1], horaFimTurno[2])

    # Obter os telefones do funcionario
    telefones = extrairTelefonesFuncionario(id)

    funcionario = {
                'id': id,
                'nome': nome,
                'telefones': telefones,
                'salario': salario,
                'estagiario': bool(estagiario),
                'turno': {
                            'horaInicio': inicio,
                            'horaFim': fim
                         },
                'morada': {
                            'rua': rua,
                            'localidade': localidade,
                            'pais': pais
                         }
    }

    mondb['Funcionarios'].insert_one(funcionario)

    print('Funcionario', id, 'inserido')


### Função main
def main():
    # Inserir todos os dispositivos na coleção Dispositivos
    for dispositivo in extrairDispositivos():
        inserirDispositivo(dispositivo)

    # Inserir todas as peças na coleção Pecas
    for peca in extrairPecas():
        inserirPeca(peca)

    # Inserir todos os serviços na coleção Servicos
    for servico in extrairServicos():
        inserirServico(servico)

    # Inserir todos os funcionários na coleção Funcionarios
    for funcionario in extrairFuncionarios():
        inserirFuncionario(funcionario)

main()
