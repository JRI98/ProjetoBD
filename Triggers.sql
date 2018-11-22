delimiter // 
create trigger criaServico after update on Dispositivo
	for each row 
    begin
    if old.requerReparacao=False and new.requerReparacao=True then 
		insert into Servico (Dispositivo_Id, Tipo, DataInicio, DataFim, CustoTotal) 
        values(old.id,old.tipo,NOW(),NULL,0);
	end if;
    end //

-- update Dispositivo set RequerReparacao = True where id=4;

-- Drop Trigger criaServico;

-- SELECT * FROM Dispositivo;

-- SELECT * FROM Servico;


delimiter // 
CREATE TRIGGER fimDeServico AFTER UPDATE ON Servico
	for each row
    BEGIN
    IF old.dataFim IS NULL and new.dataFim IS NOT NULL then 
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