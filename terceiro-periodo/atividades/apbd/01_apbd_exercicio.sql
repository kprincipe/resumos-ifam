-- Lista de Exercícios APBD

/*
	1) Surgiu a necessidade de registrar e manter histórico de todas as alterações salariais dos
	funcionários. Reflita esse novo requisito no modelo lógico e no banco de dados.
*/

create table funcionariosalario(
	fsfuncodigo int not null,
	fsdata date not null,
	fssalario decimal(7,2) unsigned not null,
    primary key (fsfuncodigo),
    foreign key (fsfuncodigo) references funcionario(funcodigo)
);

desc funcionario;
show create table funcionario;

select *
from funcionariosalario;

insert into funcionariosalario
values (10, '2025-12-01', 2900);

-- ///////////////////////////////////////
create table if not exists historico_salario(
	hsalfuncodigo int,
	hsalantigo float,
    hsalnovo float,
    hsalmudanca datetime,
	constraint hsalfuncodigo
    foreign key (hsalfuncodigo)
    references funcionario(funcodigo)
);

create trigger registrar_historico_salarial
after update
on funcionario
for each row
	insert into historico_salario(hsalfuncodigo, hsalantigo, hsalnovo, hsalmudanca)
	select OLD.funcodigo, OLD.funsalario, NEW.funsalario, now();

/*
	2) Escolha 3 funcionários quaisquer, e gere 3 mudanças de salários (aumento) para cada.
*/

select * from historico_salario;

update funcionario
set funsalario = funsalario + 200
where funcodigo = 1;

update funcionario
set funsalario = funsalario + 600
where funcodigo = 4;

update funcionario
set funsalario = funsalario + 1200
where funcodigo = 8;

/*
	3) Mostre os históricos de salários dos funcionários que tenham tido aumento de salário, com nome
	e salário (sem os centavos).
*/
select funnome, convert(hsalnovo, unsigned)
from historico_salario
inner join funcionario on hsalfuncodigo = funcodigo;

/*
	4) Liste o código, o nome, o preço de venda e o saldo em estoque de todos os produtos ativos cujo
	preço de venda seja superior a R$ 200,00. Ordene do produto mais caro para o mais barato.
*/

select procodigo, pronome, propreco, prosaldo
from produto
where proativo = 1
	and propreco > 200
order by propreco desc;

/*
	5) Liste o código, o nome, o telefone e a renda mensal dos clientes cujo nome comece com "Mar".
	Ordene alfabeticamente pelo nome.
*/

select clicodigo, clinome, clifone, clirendamensal
from cliente
where clinome like "mar%"
order by clinome;

/*
	6) Mostre o nome do produto, a descrição do grupo a que ele pertence e o preço de venda,
	considerando apenas produtos ativos que pertençam a grupos também ativos. Ordene pelo nome
	do grupo e, dentro de cada grupo, pelo nome do produto.
*/

select pronome, grpdescricao, propreco
from produto
inner join grupoproduto on progrpcodigo = grpcodigo
where proativo = 1 and grpativo = 1;

/*
	7) Informe quantos clientes existem de cada sexo e qual a renda mensal média de cada um desses
	grupos.
*/

select count(*) "cliquantidade", clisexo, avg(clirendamensal) "climediarendamensal"
from cliente
group by clisexo;

/*
	8) Apresente o nome, o salário e a descrição do estado civil dos funcionários que ainda não foram
	demitidos (data de demissão nula). Ordene do maior para o menor salário.
*/

select funnome, funsalario, estdescricao
from funcionario
inner join estadocivil on funestcodigo = estcodigo
where fundtdem is null
order by funsalario desc;

/*
	9) Para cada grupo de produto, mostre a quantidade de produtos, o preço médio, o menor preço e o
	maior preço. Ordene do maior preço médio para o menor.
*/

select
	count(*) "proqtd",
    avg(propreco) "proprecomedia",
    min(propreco) "prominpreco",
    max(propreco) "promaxpreco"
from produto
inner join grupoproduto on progrpcodigo = grpcodigo
group by progrpcodigo
order by avg(propreco), min(propreco);

/*
	10) Para cada grupo de produto, some o saldo em estoque considerando apenas os produtos ativos.
	Exiba somente os grupos cujo saldo total ultrapasse 50 unidades, do maior saldo para o menor.
*/

select sum(prosaldo) "grpsomasaldo", grpdescricao, grpcomissao
from grupoproduto
inner join produto on grpcodigo = progrpcodigo
where grpativo = 1
group by progrpcodigo
having sum(prosaldo) > 50
order by grpsomasaldo desc;

/*
	11) Liste os bairros que possuem mais de 48 clientes cadastrados, exibindo o nome do bairro e a
	quantidade de clientes. Ordene do bairro com mais clientes para o com menos.
*/

select bainome, count(*) "baiqtdcli" 
from bairro
inner join cliente on clibaicodigo = baicodigo
group by bainome
having count(*) > 48
order by baiqtdcli desc;

/*
	12) Liste as vendas realizadas durante o ano de 2024 que foram pagas com formas de pagamento
	atualmente ativas. Mostre o código e a data da venda, o nome do cliente, o nome da filial e a
	descrição da forma de pagamento. Ordene da venda mais recente para a mais antiga e, em caso
	de empate na data, pelo nome do cliente.
*/

select * from venda;

select vencodigo, vendata, clinome, filnome, fpdescricao
from venda
inner join formapagamento on venfpcodigo = fpcodigo
inner join cliente on venclicodigo = clicodigo
inner join filial on venfilcodigo = filcodigo
where YEAR(vendata) between 2023 and 2025
	and fpativo = 1
order by vendata asc, clinome;

/*
	13) Calcule o valor total de cada venda (quantidade do item multiplicada pelo preço do produto) e a
	quantidade total de itens, exibindo o código e a data da venda e o nome do cliente. Mostre apenas
	as vendas cujo valor total ultrapasse R$ 2.500,00, da mais cara para a mais barata.
*/

select itvvencodigo, sum(itvqtde) "itvsoma", clicodigo, clinome
from itemvenda
inner join venda on itvvencodigo = vencodigo
inner join produto on itvprocodigo = procodigo
inner join cliente on venclicodigo = clicodigo
group by itvvencodigo;

/*
	14) Apresente o faturamento por filial e por ano, com a quantidade de vendas realizadas. Ordene por
	ano e, dentro do ano, do maior faturamento para o menor.
*/

select
	filnome,
	YEAR(vendata),
    sum(itvqtde * propreco) "venfaturamento"
from venda
inner join filial on filcodigo = venfilcodigo
inner join itemvenda on itvvencodigo = vencodigo
inner join produto on procodigo = itvprocodigo
group by filnome, YEAR(vendata)
order by YEAR(vendata), sum(itvqtde * propreco) desc;

/*
	15) Mostre o total de vendas por sexo de clientes e forma de pagamento.
*/

select clisexo, count(vencodigo) "vensoma", fpdescricao from cliente
inner join venda on venclicodigo = clicodigo
inner join formapagamento on venfpcodigo = fpcodigo
group by clisexo, fpdescricao;

/*
	16) Mostre o nome e saldo do(s) produto(s) vendidos para clientes do sexo feminino.
*/

/*
	17) Mostre o nome e saldo do(s) produto(s) vendidos para clientes do sexo masculino, solteiros ou
	divorciados.
*/

/*
	18) Mostre um ranking de quantidade de vendas por forma de pagamento, o valor total vendido por
	cada uma.
*/

/*
	19) Para cada grupo de produto, calcule a margem (preço de venda menos custo) média, a maior e a
	menor margem entre os produtos ativos.
*/

/*
	20) Mostre os nomes dos vendedores que sejam gerentes de mais de 3 funcionários.
*/

/*
	21) Crie um ranking de vendas por funcionário, mostrando nome, idade e quantidade de vendas
	realizadas;
*/

/*
	22) Para cada gerente, mostre o tamanho da sua equipe (funcionários ativos que se reportam a ele), o
	salário médio, o menor e o maior salário da equipe.
*/

select ger.funnome, count(*) 'Total de subordinados',
avg(sub.funsalario) 'Salário médio',
max(sub.funsalario) 'Maior salário',
min(sub.funsalario) 'Menor salário'
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
where sub.fundtdem is null
group by ger.funnome
order by ger.funnome;

/*
	23) Mostre a maior renda de cliente por zona;
*/

/*
	24) Para cada forma de pagamento, mostre a quantidade de vendas, o faturamento e o ticket médio
	(faturamento dividido pelo número de vendas).
*/

/*
	25) Considerando apenas os clientes ativos (sem data de desativação), mostre por estado civil e sexo
	a quantidade de clientes, a renda média e a maior renda.
*/