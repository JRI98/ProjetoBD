-- E4: Saber quais os equipamentos que necessitam de reparação urgente
SELECT * FROM Dispositivo WHERE RequerReparacao = True;

-- E6: Saber os telefones dos funcionários que estão em serviço num dado horário
SELECT Telefone FROM 
	 Turno t INNER JOIN funcionario f ON t.id = f.turno_id
		 	 INNER JOIN Telefones tel ON tel.funcionario_id = f.id
             WHERE '05:00' between t.horainicio AND t.horafim;

-- E31: Saber a média dos salários dos funcionários de cada país (tendo em conta que os estagiários não contam para a média)
SELECT p.descricao, AVG(f.salario) FROM
	 Funcionario f INNER JOIN Rua r ON r.id = f.rua
		 		  INNER JOIN Localidade l ON r.localidade = l.id
                  INNER JOIN Pais p ON l.pais = p.id
                  WHERE f.estagiario = false
                  GROUP BY p.id
                  ORDER BY p.descricao;

-- E32:	Saber os funcionários que ganham X
SELECT nome FROM Funcionario WHERE salario = 1500;

-- E33: Ordenar os dispositivos por quantidade de energia produzida
SELECT ID FROM Dispositivo ORDER BY EnergiaProduzida;
