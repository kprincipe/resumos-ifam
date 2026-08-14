use bd2026;

show databases;

select version();

-- Mostre os nomes dos bairros e nomes dos clientes, ordenando por bairro e renda dos clientes
select bainome 'Nome do Bairro', clinome 'Nome do Cliente', clirendamensal 'Renda Mensal' from bairro
inner join cliente on baicodigo = clibaicodigo
order by bainome, clirendamensal;

select bainome 'Nome do Bairro', clinome 'Nome do Cliente', clirendamensal 'Renda Mensal'
from cliente
inner join bairro on baicodigo = clibaicodigo
order by bainome, clirendamensal;

/*
	Mostre os nomes dos grupos de produtos e nomes dos clientes,
    ordenando por saldo do produto
*/
select grpdescricao, clinome, pronome, prosaldo
from venda
inner join cliente on clicodigo = venclicodigo
inner join itemvenda on venfuncodigo = vencodigo
inner join produto on itvprocodigo = procodigo
inner join grupoproduto on grpcodigo = progrpcodigo
order by prosaldo;

-- solução do professor
select grpdescricao, clinome
from grupoproduto
inner join produto on grpcodigo = progrpcodigo
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo - itvvencodigo
inner join cliente on clicodigo = venclicodigo
order by prosaldo;

/*
	Mostre os nomes dos clientes do sexo feminino e que ganhem mais de 3000 das zonas norte ou sul
*/

select clinome, clisexo, clirendamensal, zonnome, estdescricao
from cliente
inner join bairro on clibaicodigo = baicodigo
inner join zona on baizoncodigo = zoncodigo
inner join estadocivil on estcodigo = cliestcodigo
where clirendamensal > 3000
and zonnome in ("NORTE", "SUL")
and clisexo = "F"
and estdescricao = "SOLTEIRO";

-- solução do professor
select clinome 'Nome do Cliente' 
from cliente
inner join estadocivil on estcodigo = cliestcodigo
inner join bairro on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo;

/*
	Consulta com auto relacionamento
*/
select ger.funcodigo, ger.funnome, sub.funcodigo, sub.funnome
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
order by ger.funnome;

/*
	Mostrem os funcionarios que tenham iniciais a, m ou s,
    ganhem entre 2000 e 3000 e tenham gerado alguma venda.
*/

select *
from cliente
inner join venda on clicodigo = venclicodigo
where (clinome like 'a%'
	or clinome like 'm%'
    or clinome like 's%')
and clirendamensal between 2000 and 3000;

-------------------------------------------------------------------------

select *
from cliente 
where clinome REGEXP '^[ams]';

select count(*) 'Total de Clientes', sum(clirendamensal) 'Total de Rendas',
sum(clirendamensal) / count(*) 'Média de rendas'
from cliente;

-------------------------------------------------------------------------

select count(*) 'Total de Clientes', sum(clirendamensal) 'Total de Rendas',
avg(clirendamensal) 'Média de rendas'
from cliente;

select min(clirendamensal) 'Min. renda mensal',
	   max(clirendamensal) 'Max. renda mensal'
from cliente;

-------------------------------------------------------------------------

select bainome, clisexo, count(*) 'Total de Clientes',
				sum(clirendamensal) 'Total de renda'
from bairro
inner join cliente on baicodigo = clibaicodigo
group by bainome, clisexo; -- "achata" todas as linhas da tabela e chama função

-------------------------------------------------------------------------

select zonnome, clisexo, count(*) 'Total de Clientes',
				sum(clirendamensal) 'Total de renda'
from zona
inner join bairro on zoncodigo = baizoncodigo
inner join cliente on baicodigo = clibaicodigo
group by zonnome, clisexo; -- "achata" todas as linhas da tabela e chama função

-------------------------------------------------------------------------

select zonnome, clisexo, count(*) 'Total de Clientes',
				sum(clirendamensal) 'Total de renda'
from zona
inner join bairro on zoncodigo = baizoncodigo
inner join cliente on baicodigo = clibaicodigo
where clisexo = 'f'
group by zonnome, clisexo
having count(*) > 50;