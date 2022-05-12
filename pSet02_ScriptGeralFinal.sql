-- Questão 01 - Gera um relatório contendo a média salarial de cada Departamento
select departamento.nome_departamento, avg (funcionario.salario) as MediaSalario
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
group by nome_departamento;


-- Questão 02 - Gera um relatório da Média salarial de acordo com o Sexo dos funcionários
select sexo, avg (salario) from funcionario where sexo = 'F'
union
select sexo, avg (salario) from funcionario where sexo = 'M';


-- Questão 03 - Gera um relatório contendo os departamentos, de acordo com o nome, e as informações dos funcionários de cada Departamento, tais como: Nome completo, idade, sexo e data de nascimento
select departamento.nome_departamento, CONCAT(funcionario.primeiro_nome," ", funcionario.nome_meio, "."," ", funcionario.ultimo_nome) as Nome, funcionario.data_nascimento, TIMESTAMPDIFF(year, funcionario.data_nascimento, CURDATE()) as Idade, funcionario.salario from funcionario 
left join departamento 
on funcionario.numero_departamento = departamento.numero_departamento
order by nome_departamento;


-- Questão 04 - Gera um relatório propondo um reajuste nos salários dos funcionários, baseado na regra: Reajuste de 20% para salário menor que 35000, e reajuste de 15% para as outras faixas salariais
SELECT CONCAT(primeiro_nome, " ", nome_meio, ".", " ", ultimo_nome) as NomeCompleto, salario as salarioAtual,
CASE 
	WHEN salario < 35000 THEN salario * 1.2
	ELSE salario * 1.15
END AS salarioReajuste
FROM funcionario;


-- Questão 05 - Gera um relatório contendo o gerente e os funcionários de cada departamento 
select departamento.nome_departamento, departamento.cpf_gerente as cpf, funcionario.primeiro_nome, 
funcionario.nome_meio , funcionario.ultimo_nome, funcionario.salario 
from departamento
inner join funcionario 
on departamento.cpf_gerente = funcionario.cpf
UNION 
select departamento.nome_departamento, funcionario.cpf , funcionario.primeiro_nome, funcionario.nome_meio, funcionario.ultimo_nome, funcionario.salario 
from funcionario 
left join departamento 
on funcionario.numero_departamento = departamento.numero_departamento
order by nome_departamento asc, salario desc;


--- Questão 06 - Gera um relatório que relaciona os funcionários com seus dependentes, contendo informações sobre os mesmos, tais como: Nome completo, sexo e idade
select distinct concat(funcionario.primeiro_nome," ", funcionario.nome_meio, "."," ", funcionario.ultimo_nome) as nomeFuncionario, funcionario.cpf,departamento.nome_departamento as Departamento , dependente.nome_dependente as Dependente, TIMESTAMPDIFF(year, funcionario.data_nascimento, CURDATE()) as Idade,   
case 
when dependente.sexo = 'M' then 'Masculino'
else 'Feminino'
end as Sexo
from funcionario 
inner join dependente on funcionario.cpf = dependente.cpf_funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento; 


-- Questão 07 - Gera um relatório exibindo os funcionários que não possuem dependentes com informações sobre os mesmos como: Nome, Departamento onde trabalham e salário
select concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", " ", funcionario.ultimo_nome) as NomeCompleto, departamento.nome_departamento as NomeDepartamento, salario as Salário 
from funcionario
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
where funcionario.cpf not in (select cpf_funcionario from dependente);


-- Questão 08 - Gera um relatório que relaciona os departamentos da empresa, os projetos em cada departamento e os funcionários que trabalham neles
select departamento.nome_departamento as Departamento_do_projeto,funcionario.primeiro_nome as Nome_funcionario, funcionario.nome_meio, funcionario.ultimo_nome, trabalha_em.cpf_funcionario , trabalha_em.numero_projeto , trabalha_em.horas from trabalha_em
inner join funcionario on trabalha_em.cpf_funcionario = funcionario.cpf 
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento  
order by nome_departamento asc;

-- Questão 09 - Gera um relatório que contem o total de horas trabalhadas em cada projeto
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


-- Questão 10 - Gera um relatório contendo a média salarial de cada Departamento
select departamento.nome_departamento, avg (funcionario.salario) as MediaSalario
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
group by nome_departamento ;


-- Questão 11 - Gera um relatório que mostra o valor a ser recebido pelos funcionários pelas horas trabalhadas nos projetos, sendo o valor de 50 reais cada hora trabalhada 
select concat(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", " ", funcionario.ultimo_nome) AS NomeCompleto, projeto.nome_projeto, trabalha_em.horas * 50 as valorReferenteAsHoras
from funcionario 
inner join trabalha_em on trabalha_em.cpf_funcionario = funcionario.cpf
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto 
order by NomeCompleto;

-- Questão 12 - Gera um relatório que monitora as horas trabalhadas por cada funcionário em cada projeto
select departamento.nome_departamento,projeto.nome_projeto, funcionario.primeiro_nome as nomeFuncionario, funcionario.nome_meio , funcionario.ultimo_nome , trabalha_em.horas as HorasRegistradas  
from trabalha_em 
inner join funcionario on trabalha_em.cpf_funcionario = funcionario.cpf 
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto 
inner join departamento on projeto.numero_departamento = departamento.numero_departamento 
where horas is null ;


-- Questão 13 - Gera um relatório que lista todas as pessoas (funcionários e dependentes) de acordo com a idade, exibindo também o nome e o sexo das pessoas
select CONCAT (funcionario.primeiro_nome," ", funcionario.nome_meio,"."," ", funcionario.ultimo_nome) as Nome, funcionario.sexo , TIMESTAMPDIFF(year, funcionario.data_nascimento, CURDATE()) as idade 
from funcionario
union
select dependente.nome_dependente, dependente.sexo, TIMESTAMPDIFF(year, dependente.data_nascimento, CURDATE()) as idade from dependente
order by idade desc;

-- Questão 14 - Gera um relatório que contabiliza o total de funcionários de cada departamento
select departamento.nome_departamento as NomeDepartamento, count(funcionario.cpf) as NumeroDeFuncionarios 
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
group by nome_departamento; 


-- Questão 15 - Gera um relatório que mostra os projetos trabalhados por cada funcionário, contendo também o departamento desse funcionário
select CONCAT(funcionario.primeiro_nome, " ", funcionario.nome_meio, ".", " ", funcionario.ultimo_nome) as NomeCompleto, departamento.nome_departamento as NomeDepartamento, projeto.nome_projeto as NomeProjeto 
from funcionario 
inner join departamento on funcionario.numero_departamento = departamento.numero_departamento 
inner join trabalha_em on funcionario.cpf = trabalha_em.cpf_funcionario 
inner join projeto on trabalha_em.numero_projeto = projeto.numero_projeto; 

-- Fim --
