-- Users
CREATE USER 'Chefe'@'localhost' IDENTIFIED BY 'Briga';
GRANT ALL PRIVILEGES ON sistemaenergia.* TO 'Chefe'@'localhost'
	WITH GRANT OPTION;

CREATE ROLE 'funcionario';

GRANT SELECT, INSERT ON sistemaenergia.compra TO 'funcionario';
GRANT SELECT, INSERT, UPDATE, DELETE ON sistemaenergia.dispositivo TO 'funcionario';
GRANT SELECT ON sistemaenergia.fornecedor TO 'funcionario';
GRANT SELECT, INSERT, UPDATE ON sistemaenergia.peca TO 'funcionario';
GRANT SELECT, INSERT, UPDATE ON sistemaenergia.servico TO 'funcionario';
GRANT SELECT, INSERT ON sistemaenergia.servicofuncionario TO 'funcionario';
GRANT SELECT, INSERT, UPDATE ON sistemaenergia.servicopeca TO 'funcionario';
GRANT SELECT, INSERT, UPDATE ON sistemaenergia.tipodispositivo TO 'funcionario';
GRANT SELECT, INSERT, UPDATE ON sistemaenergia.tiposervico TO 'funcionario';

SHOW GRANTS FOR 'funcionario';

CREATE USER 'Goncalo'@'localhost' IDENTIFIED BY 'pass123';
GRANT 'funcionario' TO 'Goncalo'@'localhost';
REVOKE 'funcionario' FROM 'Goncalo'@'localhost';

SHOW GRANTS FOR 'Goncalo'@'localhost';
