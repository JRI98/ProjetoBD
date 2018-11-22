use sistemaenergia;

delimiter //
create procedure CompraPecaExistente(IN pecaID int, IN qtd int)
	begin
		DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
		start transaction;
			insert into compra 
				(Peca_ID, Data, Quantidade)
                values
                (pecaID, now(), qtd);
			update Peca set QtdStock = QtdStock + qtd where ID = pecaID;
		commit;
	end//

-- call CompraPecaExistente(20,2);


delimiter //
create procedure usarPeca(IN pecaID int, IN qtd int, IN servicoID int)
	begin
		declare stock int;
        declare existe int;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
		start transaction;
			select qtdStock into stock from Peca where ID = pecaID;
			if qtd > stock
				then
					call CompraPecaExistente(pecaID, qtd); -- Optamos por comprar o que necessita para ficarmos com stock
			end if;
			update Peca set QtdStock = QtdStock - qtd where ID = pecaID;
            
            select QtdUsada into existe from ServicoPeca where servico_id = servicoid and peca_id = pecaid;
            if existe is null
				then
					insert into ServicoPeca
						(Servico_ID, Peca_ID, QtdUsada)
						values
						(servicoID, pecaID, qtd);
			else update servicopeca set qtdusada = qtdusada + qtd where servico_id = servicoid and peca_id = pecaid;
            end if;
		commit;
	end//
    
-- call usarPeca(2, 3, 3);

delimiter //
create procedure adicionarFuncionario(IN rua varchar(45), IN localidade varchar(45), IN pais varchar(45), IN turnoID int, IN nome varchar(45), IN salario float, IN estagiario boolean, IN telefone varchar(12))
	begin
		declare idRua int;
        declare idLocalidade int;
        declare idPais int;
        declare idFuncionario int;
        DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
		start transaction;
			select ID into idPais from Pais where descricao = pais;
            if idPais is null then
				insert into Pais
                (Descricao)
                values
                (pais);
                select last_insert_id() into idPais;
			end if;
			select ID into idLocalidade from Localidade where descricao = localidade;
            if idLocalidade is null then
				insert into Localidade
                (Descricao, Pais)
                values
                (localidade, idPais);
                select last_insert_id() into idLocalidade;
			end if;
			select ID into idRua from Rua where descricao = rua;
            if idRua is null then
				insert into Rua
                (Descricao, Localidade)
                values
                (rua, idLocalidade);
                select last_insert_id() into idRua;
			end if;
            
			insert into Funcionario
            (Nome, Salario, Rua, Turno_ID, Estagiario)
            values
            (nome, salario, idRua, turnoID, estagiario);
            select last_insert_id() into idFuncionario; 
			call adicionarTelefone(idFuncionario, telefone);
		commit;
	end//

delimiter //
create procedure adicionarTelefone(IN funcionarioID int, IN telefone varchar(12))
	begin
		insert into Telefones
		(Funcionario_ID, Telefone)
		values
		(funcionarioID, telefone);
	end//
    
-- call adicionarFuncionario('Rua Pablo Escobar', 'Medellin', 'Colombia', 2, 'Paco Estevan', 0, true, '573007945529');
