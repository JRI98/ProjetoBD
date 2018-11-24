CREATE VIEW NIFFornecedores AS
SELECT NIF FROM Fornecedor;

CREATE VIEW InfoFuncionarios AS
SELECT f.nome AS Nome, t.id AS Turno, tel.telefone AS Telefone, r.descricao AS Rua, l.descricao AS Localidade, p.descricao AS País FROM 
        Funcionario f INNER JOIN Rua r ON r.id = f.rua
		 		      INNER JOIN Localidade l ON r.localidade = l.id
                      INNER JOIN Pais p ON l.pais = p.id
                      INNER JOIN Telefones tel ON f.id = tel.funcionario_id
                      INNER JOIN Turno t ON f.turno_id = t.id;

-- SELECT * FROM InfoFuncionarios;

CREATE VIEW FornecedoresPorGastos AS
SELECT f.Designacao AS Fornecedor, ROUND(SUM(c.quantidade * p.precoUnitario)) AS Gastos
	FROM Fornecedor f INNER JOIN Peca p ON p.NIF_fornecedor=f.NIF
					  INNER JOIN Compra c ON c.peca_id=p.id
                      GROUP BY Fornecedor
                      ORDER BY Gastos DESC;
