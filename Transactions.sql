DELIMITER //
CREATE PROCEDURE CompraPecaExistente(IN pecaID INT, IN qtd INT)
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
		START TRANSACTION;
			INSERT INTO compra 
				(Peca_ID, Data, Quantidade)
                VALUES
                (pecaID, NOW(), qtd);
			UPDATE Peca SET QtdStock = QtdStock + qtd WHERE ID = pecaID;
		COMMIT;
	END//

-- CALL CompraPecaExistente(20,2);


DELIMITER //
CREATE PROCEDURE usarPeca(IN pecaID INT, IN qtd INT, IN servicoID INT)
	BEGIN
		DECLARE stock INT;
        DECLARE existe INT;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
		START TRANSACTION;
			SELECT qtdStock INTO stock FROM Peca WHERE ID = pecaID;
			IF qtd > stock
				THEN
					CALL CompraPecaExistente(pecaID, qtd); -- Optamos por comprar o que necessita para ficarmos com stock
			END IF;
			UPDATE Peca SET QtdStock = QtdStock - qtd WHERE ID = pecaID;
            
            SELECT QtdUsada INTO existe FROM ServicoPeca WHERE servico_id = servicoid AND peca_id = pecaid;
            IF existe IS NULL THEN
				INSERT INTO ServicoPeca
					(Servico_ID, Peca_ID, QtdUsada)
					VALUES
					(servicoID, pecaID, qtd);
			ELSE
				UPDATE servicopeca SET qtdusada = qtdusada + qtd WHERE servico_id = servicoid AND peca_id = pecaid;
            END IF;
		COMMIT;
	END//
    
-- CALL usarPeca(2, 3, 3);

DELIMITER //
CREATE PROCEDURE adicionarFuncionario(IN rua VARCHAR(45), IN localidade VARCHAR(45), IN pais VARCHAR(45), IN turnoID INT, IN nome VARCHAR(45), IN salario FLOAT, IN estagiario BOOLEAN, IN telefone VARCHAR(12))
	BEGIN
		DECLARE idRua INT;
        DECLARE idLocalidade INT;
        DECLARE idPais INT;
        DECLARE idFuncionario INT;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
		START TRANSACTION;
			SELECT ID INTO idPais FROM Pais WHERE descricao = pais;
            IF idPais IS NULL THEN
				INSERT INTO Pais
                (Descricao)
                VALUES
                (pais);
                SELECT last_insert_id() INTO idPais;
			END IF;

			SELECT ID INTO idLocalidade FROM Localidade WHERE descricao = localidade;
            IF idLocalidade IS NULL THEN
				INSERT INTO Localidade
                (Descricao, Pais)
                VALUES
                (localidade, idPais);
                SELECT last_insert_id() INTO idLocalidade;
			END IF;

			SELECT ID INTO idRua FROM Rua WHERE descricao = rua;
            IF idRua IS NULL THEN
				INSERT INTO Rua
                (Descricao, Localidade)
                VALUES
                (rua, idLocalidade);
                SELECT last_insert_id() INTO idRua;
			END IF;
            
			INSERT INTO Funcionario
            (Nome, Salario, Rua, Turno_ID, Estagiario)
            VALUES
            (nome, salario, idRua, turnoID, estagiario);
            SELECT last_insert_id() INTO idFuncionario; 
			CALL adicionarTelefone(idFuncionario, telefone);
		COMMIT;
	END//

DELIMITER //
CREATE PROCEDURE adicionarTelefone(IN funcionarioID INT, IN telefone VARCHAR(12))
	BEGIN
		INSERT INTO Telefones
		(Funcionario_ID, Telefone)
		VALUES
		(funcionarioID, telefone);
	END//
    
-- CALL adicionarFuncionario('Rua Pablo Escobar', 'Medellin', 'Colombia', 2, 'Paco Estevan', 0, true, '573007945529');
