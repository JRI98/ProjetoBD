use sistemaenergia;

-- E4: Saber quais os equipamentos que necessitam de reparação urgente
Select * from Dispositivo where RequerReparacao = True;

-- E6: Saber os telefones dos funcionários que estão em serviço num dado horário
SELECT Telefone FROM 
	 Turno t inner join funcionario f on t.id = f.turno_id
		 	 inner join Telefones tel on tel.funcionario_id = f.id
             where '05:00' between t.horainicio and t.horafim;

-- E31: Saber a média dos salários dos funcionários de cada país (tendo em conta que os estagiários não contam para a média)
select p.descricao, avg(f.salario) from
	 Funcionario f inner join Rua r on r.id = f.rua
		 		  inner join Localidade l on r.localidade = l.id
                  inner join Pais p on l.pais = p.id
                  where f.estagiario = false
                  group by p.id
                  order by p.descricao;

-- E32:	Saber os funcionários que ganham x
select nome from Funcionario where salario = 1500;

-- E33: Ordenar os dispositivos por quantidade de energia produzida
select ID from Dispositivo order by EnergiaProduzida;