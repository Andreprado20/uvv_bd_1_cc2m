-- Questão 01
select departamento.nome_departamento, avg (funcionario.salario) as MediaSalario
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
group by nome_departamento;


-- Questão 02
select sexo, avg (salario) from funcionario where sexo = 'F'
union
select sexo, avg (salario) from funcionario where sexo = 'M';


-- Questão 03
select departamento.nome_departamento, CONCAT(funcionario.primeiro_nome," ", funcionario.nome_meio, "."," ", funcionario.ultimo_nome) as Nome, funcionario.data_nascimento, TIMESTAMPDIFF(year, funcionario.data_nascimento, CURDATE()) as Idade, funcionario.salario from funcionario 
left join departamento 
on funcionario.numero_departamento = departamento.numero_departamento
order by nome_departamento;


-- Questão 04
SELECT CONCAT(primeiro_nome, " ", nome_meio, ".", " ", ultimo_nome) as NomeCompleto, salario as salarioAtual,
CASE 
	WHEN salario < 35000 THEN salario * 1.2
	ELSE salario * 1.15
END AS salarioReajuste
FROM funcionario;


-- Questão 05
select departamento.nome_departamento, departamento.cpf_gerente as cpf, funcionario.primeiro_nome, funcionario.nome_meio , funcionario.ultimo_nome, funcionario.salario 
from departamento
inner join funcionario 
on departamento.cpf_gerente = funcionario.cpf
UNION 
select departamento.nome_departamento, funcionario.cpf , funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, funcionario.salario from funcionario 
left join departamento 
on funcionario.numero_departamento = departamento.numero_departamento
order by nome_departamento asc, salario desc;


--- Questão 06
select distinct concat(funcionario.primeiro_nome," ", funcionario.nome_meio, "."," ", funcionario.ultimo_nome) as nomeFuncionario, funcionario.cpf,departamento.nome_departamento as Departamento , dependente.nome_dependente as Dependente, TIMESTAMPDIFF(year, funcionario.data_nascimento, CURDATE()) as Idade,   
case 
when dependente.sexo = 'M' then 'Masculino'
else 'Feminino'
end as Sexo
from funcionario 
inner join dependente on funcionario.cpf = dependente.cpf_funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento; 


-- Questão 07
select concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", " ", funcionario.ultimo_nome) as NomeCompleto, departamento.nome_departamento as NomeDepartamento, salario as Salário 
from funcionario
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
where funcionario.cpf not in (select cpf_funcionario from dependente);


-- Questão 08
select departamento.nome_departamento as Departamento_do_projeto,funcionario.primeiro_nome as Nome_funcionario, funcionario.nome_meio, funcionario.ultimo_nome, trabalha_em.cpf_funcionario , trabalha_em.numero_projeto , trabalha_em.horas from trabalha_em
inner join funcionario on trabalha_em.cpf_funcionario = funcionario.cpf 
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento  
order by nome_departamento asc;

-- Questão 09
select departamento.nome_departamento,  projeto.nome_projeto, sum (trabalha_em.horas) as Soma_das_horas_trabalhadas from trabalha_em
inner join projeto on projeto.numero_projeto = trabalha_em.numero_projeto
inner join departamento on projeto.numero_departamento = departamento.numero_departamento 
where projeto.nome_projeto = 'ProdutoX'
union 
select departamento.nome_departamento, projeto.nome_projeto, sum (trabalha_em.horas) from trabalha_em
inner join projeto on projeto.numero_projeto = trabalha_em.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento 
where projeto.nome_projeto = 'ProdutoY'
union 
select departamento.nome_departamento, projeto.nome_projeto, sum (trabalha_em.horas) from trabalha_em
inner join projeto on projeto.numero_projeto = trabalha_em.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento 
where projeto.nome_projeto = 'ProdutoZ'
union 
select departamento.nome_departamento, projeto.nome_projeto, sum (trabalha_em.horas) from trabalha_em
inner join projeto on projeto.numero_projeto = trabalha_em.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento 
where projeto.nome_projeto = 'Informatização'
union 
select departamento.nome_departamento, projeto.nome_projeto, sum (trabalha_em.horas) from trabalha_em
inner join projeto on projeto.numero_projeto = trabalha_em.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento 
where projeto.nome_projeto = 'Reorganização'
union 
select departamento.nome_departamento, projeto.nome_projeto, sum (trabalha_em.horas) from trabalha_em
inner join projeto on projeto.numero_projeto = trabalha_em.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento 
where projeto.nome_projeto = 'Novosbenefícios';


-- Questão 10
select departamento.nome_departamento, avg (funcionario.salario) as MediaSalario
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
group by nome_departamento ;


-- Questão 11
select concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", " ", funcionario.ultimo_nome) AS NomeCompleto, projeto.nome_projeto, trabalha_em.horas * 50 as valorReferenteAsHoras
from funcionario 
inner join trabalha_em on trabalha_em.cpf_funcionario = funcionario.cpf
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto 
order by NomeCompleto;

-- Questão 12
select departamento.nome_departamento,projeto.nome_projeto, funcionario.primeiro_nome as nomeFuncionario, funcionario.nome_meio , funcionario.ultimo_nome , trabalha_em.horas as HorasRegistradas  
from trabalha_em 
inner join funcionario on trabalha_em.cpf_funcionario = funcionario.cpf 
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento 
where horas is null ;


-- Questão 13
select CONCAT (funcionario.primeiro_nome," ", funcionario.nome_meio,"."," ", funcionario.ultimo_nome) as Nome, funcionario.sexo , TIMESTAMPDIFF(year, funcionario.data_nascimento, CURDATE()) as idade 
from funcionario
union
select dependente.nome_dependente, dependente.sexo, TIMESTAMPDIFF(year, dependente.data_nascimento, CURDATE()) as idade from dependente
order by idade desc;

-- Questão 14
select departamento.nome_departamento as NomeDepartamento, count(funcionario.cpf) as NumeroDeFuncionarios 
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
group by nome_departamento; 


-- Questão 15
select CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", " ", funcionario.ultimo_nome) as NomeCompleto, departamento.nome_departamento as NomeDepartamento, projeto.nome_projeto as NomeProjeto 
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
inner join trabalha_em on funcionario.cpf = trabalha_em.cpf_funcionario 
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto; 

