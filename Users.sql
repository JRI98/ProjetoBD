-- USERSSSSSSSSSSSSss
CREATE USER 'ChefeTurno'@'localhost' IDENTIFIED BY 'Briga';
GRANT ALL PRIVILEGES ON sistemaenergia TO 'ChefeTurno'@'localhost'
	WITH GRANT OPTION;


CREATE ROLE 'funcionario';
GRANT ALL PRIVILEGES ON sistemaenergia TO 'funcionario';
REVOKE ALL ON funcionario.* FROM 'funcionario';
REVOKE DELETE, DROP ON *.* FROM 'funcionario';

CREATE USER 'Goncalo'@'localhost' IDENTIFIED BY '123456';
GRANT 'funcionario' TO 'Goncalo'@'localhost';