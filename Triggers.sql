DELIMITER // 
CREATE TRIGGER criaServico AFTER UPDATE ON Dispositivo
	FOR EACH ROW
    BEGIN
        IF old.requerReparacao=False AND new.requerReparacao=True THEN 
            INSERT INTO Servico (Dispositivo_Id, Tipo, DataInicio, DataFim, CustoTotal) 
            VALUES (old.id, 2, NOW(), NULL, 0); -- O valor 2 representa uma ReparaçãoUrgente
        END IF;
    END //

-- UPDATE Dispositivo SET RequerReparacao = True WHERE id=4;

-- DROP TRIGGER criaServico;

-- SELECT * FROM Dispositivo;

-- SELECT * FROM Servico;

DELIMITER // 
CREATE TRIGGER fimDeServico AFTER UPDATE ON Servico
	FOR EACH ROW
    BEGIN
        IF old.dataFim IS NULL AND new.dataFim IS NOT NULL THEN 
            UPDATE Dispositivo SET RequerReparacao=False, UltimaManutencao=new.dataFim, 
            ProximaManutencao=DATE_ADD(new.dataFim, INTERVAL 1 MONTH) WHERE id=old.Dispositivo_id;
        END IF;
    END //

-- DROP TRIGGER fimDeServico;   

-- UPDATE Servico SET DataFim = NOW() WHERE id=16;

-- UPDATE Servico SET DataFim = NULL WHERE id=16;

-- UPDATE Dispositivo SET RequerReparacao = TRUE WHERE id=4;
    
-- SELECT * FROM Dispositivo WHERE id = 4;
-- SELECT * FROM Servico WHERE id = 16;
