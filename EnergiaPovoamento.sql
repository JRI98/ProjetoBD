-- Universidade do Minho
-- Lincenciatura em Ciências da Computação
-- Unidade Curricular de Bases de Dados
-- 2018/2019

-- Sistema de Produção de Energia
USE sistemaenergia;

-- Povoamento da tabela "Turno"
 INSERT INTO Turno
	(Id, HoraInicio, HoraFim)
    Values 
    (0,'00:00:00','08:00:00'),
    (1,'08:00:00','16:00:00'),
    (2,'16:00:00','00:00:00');

-- SELECT * FROM Turno;

-- Povoamento da tabela "Funcionario"
INSERT INTO Funcionario
	(Id, Nome, Salario, País, Localidade, Rua, Turno_ID, Estagiario)
    Values
    (1,'José Gonçalo Costa', 30000, 'Portugal', 'Braga', 'Rua Luís Barroso', 0, False),
    (2,'Arlindo da Fonte Torres',30000,'Portugal','Porto','Rua Eça de Queirós',0,False),
    (3,'Ricardo Valadares Vieira',25000,'Portugal','Braga','Avenida das Parretas',1,False),
    (4,'João José Impeadeiro',25000,'Portugal','Braga','Rua Fernando Pessoa',1,False),
    (5,'José Fernando Boticas',0,'Espanha','Madrid','Rua Santiago Bernanbeu',2,True),
    (6,'Nelson Teixeira Pereira',0,'Portugal','Porto','Rua ALberto Caeiro',2,True),
    (7,'Bernardo Sellout Alves',27000,'Portugal','Lisboa','Rua Ricardo Reis',2,False),
    (8,'Ricardo Fernandes Pacheco',35000,'Brasil','Rio de Janeiro','Rua do Carnaval',0,False),
    (9,'Catarina Machado Vieira',0,'Portugal','Braga','Rua Montalegrense',1,True),
    (10,'Alcina da Silva Costa',15000,'Portugal','Lisboa','Rua Luís de Camões',0,False),
    (11,'António Teixeira Costa',40000,'Portugal','Lisboa','Rua Luís de Camões',1,False),
    (12,'Manuel José Ribeiro',10000,'Portugal','Porto','Rua Miguel Torga',2,False);
    
 -- SELECT * FROM Funcionario;
 
 -- Povoamento da tabela "Telefones"
 INSERT INTO Telefones
	 (Telefone_ID, Funcionario_ID, Telefone)
     Values
     (1,1,'912659874'),
     (2,2,'922351478'),
     (3,3,'927654237'),
     (4,4,'912845682'),
     (5,5,'934569874'),
     (6,6,'912578638'),
     (7,7,'914857289'),
     (8,8,'924563211'),
	 (9,9,'926598321'),
     (10,10,'914563254'),
     (11,11,'923651984'),
     (12,12,'926385274');
    
-- Povoamento da tabela "Tipo"
INSERT INTO Tipo
	(Id, Designacao)
    Values
    (1,'Painel Solar'),
    (2,'Ventoinha Eólica');

-- Povoamento da tabela "Dispositivo"
INSERT INTO Dispositivo
	(Id, Tipo, RequerReparacao, EnergiaProduzida, UltimaManutencao, ProximaManutencao, Latitude, Longitude)
    Values
    (1,1,False,1500,'2018-10-18 13:17:17','2018-11-18 13:00:00','40.71727401','-70.32165498'),
    (2,1,False,1464,'2018-10-10 10:34:00','2018-11-10 10:00:00','56.00256974','-51.35188724');
    
		


 
