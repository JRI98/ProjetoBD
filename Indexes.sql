-- E4: Saber quais os equipamentos que necessitam de reparação urgente
create index idx_requerReparacao on Dispositivo (RequerReparacao);

-- E32:	Saber os funcionários que ganham x
create index idx_Salario on Funcionario (salario);

-- E33: Ordenar os dispositivos por quantidade de energia produzida
create index idx_energiaproduzida on Dispositivo (energiaproduzida);