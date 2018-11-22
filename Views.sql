CREATE VIEW NIFFornecedor AS
SELECT * FROM Fornecedor;

CREATE VIEW InfoFuncionarios AS
SELECT f.nome as Nome, t.id as Turno, tel.telefone as Telefone, r.descricao as Rua, l.descricao as Localidade, p.descricao as País FROM 
 Funcionario f inner join Rua r on r.id = f.rua
		 		  inner join Localidade l on r.localidade = l.id
                   inner join Pais p on l.pais = p.id
                   inner join Telefones tel on f.id = tel.funcionario_id
                   inner join Turno t on f.turno_id = t.id;

-- SELECT * FROM InfoFuncionarios;

CREATE VIEW Gastos AS
SELECT f.Designacao as Fornecedor, ROUND(SUM(c.quantidade * p.precoUnitario)) as Gastos
	FROM Fornecedor f inner join Peca p on p.NIF_fornecedor=f.NIF
					  inner join Compra c on c.peca_id=p.id
                      GROUP BY Fornecedor ORDER BY Gastos DESC;

