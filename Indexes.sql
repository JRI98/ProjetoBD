-- E4: Saber quais os equipamentos que necessitam de reparação urgente
CREATE index idx_requerReparacao ON Dispositivo (RequerReparacao);

-- E32:	Saber os funcionários que ganham x
CREATE index idx_salario ON Funcionario (salario);

-- E33: Ordenar os dispositivos por quantidade de energia produzida
CREATE index idx_energiaproduzida ON Dispositivo (energiaproduzida);
