-- Role: "Andre1"
-- DROP ROLE IF EXISTS "Andre1";

CREATE ROLE "Andre1" WITH
  LOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  REPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:Dm1KDOby+MvxlK5bQE479Q==$3AKSZiGYsJULTRRxluJyjoH9K5QiZQZoB4JpijaVGts=:ctVYgKCLT0gv/PuEneuwIo6QNRlX6DR25ueJX923rPU=';
  /* Password=253649 */
 
 -- Database: uvv

-- DROP DATABASE IF EXISTS uvv;

CREATE DATABASE uvv
    WITH 
    OWNER = "Andre1"
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE uvv
    IS 'Servidor uvv onde estão criados os schemas e as tabelas';

ALTER DATABASE uvv
    SET "DateStyle" TO 'sql, dmy';
   
   
 -- SCHEMA: elmasri

-- DROP SCHEMA IF EXISTS elmasri ;

CREATE SCHEMA IF NOT EXISTS elmasri
    AUTHORIZATION "Andre1";
   
   
-- Table: elmasri.departamento

-- DROP TABLE IF EXISTS elmasri.departamento;

CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                ultimo_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                data_nascimento DATE,
                endereco VARCHAR(30),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (cpf)
);


CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)
);


CREATE UNIQUE INDEX elmasri.departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento, local)
);


CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto)
);


CREATE UNIQUE INDEX elmasri.projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente)
);


  ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION


ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION


ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION


ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION


ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION


ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION

insert into funcionario (cpf, primeiro_nome, ultimo_nome, nome_meio, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
values 
('88866555576', 'Jorge', 'Brito', 'E', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000.00, null, 1),
('33344555587', 'Fernando', 'Wong', 'F', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000.00, '88866555576', 5),
('98765432168', 'Jennifer', 'Souza', 'S', '1941-06-20','Av.Arthur de Lima, 54, Santo André, SP', 'F', 43000.00, '88866555576', 4),
('12345678966', 'João', 'Silva', 'B', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000.00, '33344555587',	5),
('66688444476',	'Ronaldo', 'Lima', 'K', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000.00, '33344555587',	5),
('45345345376',	'Joice', 'Leite', 'A', '1972-07-31', 'Av.Lucas Obes, 74, São Paulo, SP', 'F', 25000.00, '33344555587', 5),
('99988777767', 'Alice', 'Zelaya', 'J', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000.00, '98765432168', 4),
('98798798733', 'André', 'Pereira', 'V', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000.00, '98765432168', 4);


insert into departamento (numero_departamento, nome_departamento, cpf_gerente, data_inicio_gerente)
values
(5, 'Pesquisa', '33344555587', '1988-05-22'),
(4, 'Administração', '98765432168', '1995-01-01'),
(1, 'Matriz', '88866555576', '1981-06-19');

insert into localizacoes_departamento (numero_departamento, local)
values
(1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'São Paulo');	

insert into projeto (numero_projeto, nome_projeto, local_projeto, numero_departamento)
values
(1, 'ProdutoX', 'Santo André', 5),
(2, 'ProdutoY', 'Itu', 5),
(3, 'ProdutoZ', 'São Paulo', 5),
(10,'Informatização', 'Mauá', 4),
(20, 'Reorganização', 'São Paulo', 1),
(30, 'NovosBeneficios', 'Mauá', 4);

insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values 
('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
('33344555587', 'Tiago', 'M','1983-10-25', 'Filho'),
('33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filha'),
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966',	'Elizabeth', 'F', '1967-05-05', 'Esposa');

insert into trabalha_em (cpf_funcionario, numero_projeto, horas)
values
('12345678966',	1, 32.5),
('12345678966',	2, 7.5),
('66688444476',	3, 40.0),
('45345345376',	1, 20.0),
('33344555587',	2, 10.0),
('33344555587',	3, 10.0),
('33344555587',	10, 10.0),
('33344555587',	20, 10.0),
('99988777767',	30, 30.0),
('99988777767',	10, 10.0),
('98798798733',	10, 35.0),
('98798798733',	30, 5.0),
('98765432168',	30, 20.0),
('98765432168',	20, 15.0),
('88866555576',	20, null);

