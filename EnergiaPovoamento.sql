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

-- Povoamento da tabela "País"
INSERT INTO Pais
	(Id, Descricao)
    Values
    (1,'Portugal'),
    (2,'Espanha'),
    (3,'Brasil');

-- Povoamento da tabela "Localidade"
INSERT INTO Localidade 
	(Id, Descricao, Pais)
    Values
    (1,'Braga',1),
    (2,'Porto',1),
    (3,'Lisboa',1),
    (4,'Madrid',2),
    (5,'Rio de Janeiro',3);

-- Povoamento da tabela "Rua"
INSERT INTO Rua
	(Id, Descricao, Localidade)
    Values
    (1,'Rua Luís Barroso',1),
    (2,'Rua Eça de Queirós',2),
    (3,'Avenida das Parretas',1),
    (4,'Rua Fernando Pessoa',1),
    (5,'Rua Santiago Bernabeu',4),
    (6,'Rua ALberto Caeiro',2),
    (7,'Rua Ricardo Reis',3),
    (8,'Rua do Carnaval',5),
    (9,'Rua Montalegrense',1),
    (10,'Rua Luís de Camões',3),
    (11,'Rua Miguel Torga',2);
    
-- Povoamento da tabela "Funcionario"
INSERT INTO Funcionario
	(Id, Nome, Salario, Rua, Turno_ID, Estagiario)
    Values
    (1,'José Gonçalo Costa', 50000,1,0, False),
    (2,'Arlindo da Fonte Torres',30000,2,0,False),
    (3,'Ricardo Valadares Vieira',25000,3,1,False),
    (4,'João José Imperadeiro',25000,4,1,False),
    (5,'José Fernando Boticas',0,5,2,True),
    (6,'Nelson Teixeira Pereira',0,6,2,True),
    (7,'Bernardo Sellout Alves',27000,7,2,False),
    (8,'Ricardo Fernandes Pacheco',35000,8,0,False),
    (9,'Catarina Machado Vieira',0,9,1,True),
    (10,'Alcina da Silva Costa',15000,10,0,False),
    (11,'António Teixeira Costa',40000,10,1,False),
    (12,'Manuel José Ribeiro',10000,11,2,False);
    
 -- SELECT * FROM Funcionario;
 
 -- Povoamento da tabela "Telefones"
  INSERT INTO Telefones
	 (Id, Funcionario_ID, Telefone)
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
INSERT INTO TipoDispositivo
	(Id, Designacao)
    Values
    (1,'Painel Solar'),
    (2,'Ventoinha Eólica');

-- Povoamento da tabela "Dispositivo"
INSERT INTO Dispositivo
	(Id, Tipo, RequerReparacao, EnergiaProduzida, UltimaManutencao, ProximaManutencao, Latitude, Longitude)
    Values
    (1,1,False,500,'2018-11-18 23:17:17','2018-12-18 23:00:00','40.71727401','-70.32165498'),
    (2,1,False,464,'2018-11-10 10:34:00','2018-12-10 10:00:00','56.00256974','-51.35188724'),
    (3,1,True,400,'2018-10-25 22:10:01','2018-11-25 02:00:00','70.25635416','50.28247798'),
    (4,2,False,700,'2018-11-15 05:06:47','2018-12-15 05:00:00','15.26549873','26.35498762'),
    (5,2,False,950,'2018-11-10 12:35:14','2018-12-10 12:00:00','20.23165497','50.98765232'),
    (6,2,True,800,'2018-11-02 19:36:29','2018-12-02 19:0:00','-54.32158964','-40.32584563'),
    (7,2,True,865,'2018-10-23 18:51:02','2018-11-23 19:00:00','25.32165987','72.36985245'),
    (8,1,False,1100,'2018-11-11 15:47:02','2018-12-11 16:00:00','55.21456985','64.26598714'),
    (9,1,True,1050,'2018-11-01 17:58:00','2018-12-01 16:00:00','87.20365478','140.36589865'),
    (10,1,False,987,'2018-11-09 21:02:00','2018-12-09 21:00:00','06.78541236','101.23659874'),
    (11,2,False,870,'2018-10-31 13:21:09','2018-01-01 13:21:00','35.65874125','121.96587452'),
    (12,2,True,1340,'2018-10-29 04:37:00','2018-11-29 04:37:00','-58.23698741','-151.23699874'),
    (13,1,False,1010,'2018-11-18 05:10:00','2018-12-18 05:00:00','-10.32154789','-154.36897451'),
    (14,1,True,1300,'2018-11-20 02:50:00','2018-12-29 03:00:00','20.78521456','-169.47896321'),
    (15,2,False,1270,'2018-11-23 07:10:00','2018-12-23 07:00:00','-65.78891235','-120.12458965');

-- SELECT * FROM Dispositivo;

-- Povoamento da tabela "TipoServiço"
INSERT INTO TipoServico
	(Id, Designacao)
    Values
    (1,'Manutenção'),
    (2,'ReperaçãoUrgente');

-- Povoamento da tabela "Serviço"
INSERT INTO Servico
    (Id, Dispositivo_Id, Tipo, DataInicio, DataFim, CustoTotal)
    Values
    (1,1,1,'2018-11-18 21:17:17','2018-11-18 23:17:17',4000.0),
    (2,2,1,'2018-11-10 08:34:00','2018-11-10 10:34:00',1500.0),
    (3,5,1,'2018-11-10 10:35:00','2018-11-10 12:35:14',800.0),
    (4,3,1,'2018-10-25 20:00:00','2018-10-25 22:10:01',3550.0),
    (5,4,1,'2018-11-15 03:34:03','2018-11-15 05:06:47',200.0),
    (6,6,2,'2018-11-02 16:54:04','2018-11-02 19:36:29',3580.0),
    (7,7,2,'2018-10-23 16:55:21','2018-10-23 18:51:02',4870.0),
    (8,8,1,'2018-11-11 12:40:00','2018-11-11 14:47:02',720.0),
    (9,9,2,'2018-11-01 16:43:54','2018-11-01 17:58:00',5890.0),
    (10,10,1,'2018-11-09 17:43:21','2018-11-09 21:02:00',368.0),
    (11,11,1,'2018-10-31 11:23:42','2018-10-31 13:21:09',768.0),
    (12,12,2,'2018-10-29 02:13:11','2018-10-29 04:37:00',4640.0),
    (13,13,1,'2018-11-18 01:30:00','2018-11-18 05:10:00',560.0),
    (14,14,2,'2018-11-19 00:45:03','2018-11-20 02:50:00',1453.0),
    (15,15,1,'2018-11-23 05:23:00','2018-11-23 07:10:00',760.0);
                  
INSERT INTO ServicoFuncionario
	(Servico_Id, Funcionario_Id)
    Values
    (1,5),
    (1,6),
    (2,3),
    (2,4),
    (3,9),
    (3,4),
    (4,12),
    (4,7),
    (5,1),
    (5,2),
    (6,5),
    (6,6),
    (6,12),
    (7,7),
    (7,6),
    (8,9),
    (8,11),
    (9,5),
    (9,7),
    (9,12),
    (10,5),
    (10,6),
    (11,9),
    (11,11),
    (12,8),
    (12,1),
    (12,10),
    (13,2),
    (13,8),
    (14,1),
    (14,10),
    (15,8),
    (15,10);
    
INSERT INTO Fornecedor
	(NIF, Designacao)
    Values
    (501236984,'MERKASOL'),
    (503654852,'SKF'),
    (501245963,'Zé Maria');
    
INSERT INTO Peca
	(Id, NIF_Fornecedor, QtdStock, Designacao, PrecoUnitario)
	Values
    (1,501245963,617,'Parafuso', 0.12),
    (2,503654852,1,'Hélice',1500.0),
    (3,501236984,13,'Célula Fotovoltaica',130.0),
    (4,501245963,459,'Porca',0.10);

INSERT INTO Compra
	(Id, Peca_Id, DATA, Quantidade)
    Values
    (1,1,'2018-06-23 01:23:00',153),
    (2,1,'2018-07-22 09:38:00',300),
    (3,2,'2018-07-20 16:20:00',2),
    (4,3,'2018-10-02 06:30:00',7),
    (5,1,'2018-08-12 14:30:00',350),
    (6,4,'2018-06-22 17:15:00',200),
    (7,4,'2018-07-08 00:02:00',300),
    (8,2,'2018-09-25 15:00:00',8),
    (9,3,'2018-10-15 16:00:00',10);

INSERT INTO ServicoPeca
	(Servico_Id, Peca_Id, QtdUsada)
    Values 
    (1,4,10),
    (2,4,20),
    (3,1,15),
    (4,1,23),
    (5,1,18),
    (6,2,1),
    (6,1,13),
    (7,2,1),
    (7,1,23),
    (8,1,26),
    (9,3,2),
    (9,1,20),
    (10,2,5),
    (10,1,10),
    (11,4,3),
    (12,2,2),
    (12,1,10),
    (12,4,3),
    (13,1,16),
    (14,3,2),
    (14,1,12),
    (15,4,5);