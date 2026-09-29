-- Prática para prova 14/10/2026 APBD

use bd2026;

/*
*	22) Para cada gerente, mostre o tamanho da sua equipe (funcionários ativos que se reportam a ele), o
*		salário médio, o menor e o maior salário da equipe.
*/

select ger.funnome, count(*),
avg(sub.funsalario),
max(sub.funsalario),
min(sub.funsalario)
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
where sub.fundtdem is null
group by ger.funnome;

/*
*	23) Mostre a maior renda de cliente por zona;
*/

select zonnome, max(clirendamensal)
from cliente
inner join bairro on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo
group by zonnome;

/*
*	24) Para cada forma de pagamento, mostre a quantidade de vendas, o faturamento e o ticket médio
*		(faturamento dividido pelo número de vendas).
*/

select fpdescricao "Forma de Pagamento", sum(itvvencodigo) "Qtde. vendas", sum(itvqtde * propreco) "Faturamento", (sum(itvqtde * propreco) / sum(itvvencodigo)) "Ticke Médio"
from formapagamento
inner join venda on fpcodigo = venfpcodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
group by fpdescricao;

select * from produto;

/*
* 	25) Considerando apenas os clientes ativos (sem data de desativação), mostre por estado civil e sexo
* 		a quantidade de clientes, a renda média e a maior renda.
*/

select estdescricao "Estado Civil", clisexo "Sexo", count(clicodigo) "Qtde. Clientes", avg(clirendamensal) "Renda", max(clirendamensal) "Renda Média"
from cliente
inner join estadocivil on estcodigo = cliestcodigo
where clidtdesativacao is null
group by estdescricao, clisexo;