use bd2026;

select 'BANCO DE DADOS', left('banco de dados', 5) 'LEFT';
select 'BANCO DE DADOS', left('banco de dados', 5) 'RIGHT';

select 'BANCO DE DADOS',
	substring('BANCO DE DADOS', 4) 'substr1',
    substring('BANCO DE DADOS', 4, 4) 'substr2'; -- posicao incial, numero de caractéres

select 'BANCO DE DADOS', locate('a', 'BANCO DE DADOS') locate;

select 'BANCO DE DADOS', reverse('BANCO DE DADOS') reverse;

select concat('banco', 'de', 'dados', 'e', 'mysql') concat;

select left(right('BANCO DE DADOS', 5), 2);

select clinome, left(right(clinome, 5), 2)
from cliente;

select vendata, left(vendata, 4) venano
from venda;

select filnome, left(vendata, 4) 'Ano', sum(propreco * itvqtde) 'Faturamento', count(*) 'Qtde Vendas' -- Quando tem função, o que não tiver função, colocar no 'group by'
from venda
	inner join itemvenda on itvvencodigo = vencodigo
	inner join produto on procodigo = itvprocodigo
	inner join filial on filcodigo = venfilcodigo
group by filcodigo, left(vendata, 4)
order by Faturamento desc;

-- Auto relacionamento
select ger.funnome, count(*) 'Total de subordinados',
avg(sub.funsalario) 'Salário médio',
max(sub.funsalario) 'Maior salário',
min(sub.funsalario) 'Menor salário'
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
where sub.fundtdem is null
group by ger.funnome
order by ger.funnome;

-- Junções externas

select bairro.*
from cliente
right outer join bairro on baicodigo = clibaicodigo
where clicodigo is null;

-- total clientes por bairro inclusive bairros sem clientes
select bainome 'Nome de bairro', count(clicodigo) 'Qtde. clientes'
from cliente
right outer join bairro on clibaicodigo = baicodigo
group by bainome;

-- Mais performática que um inner join
select bainome
from bairro
where baicodigo not in (select clibaicodigo
						cliente)
order by bainome desc;

/*
	1. Mostre o total de clientes, considerando somente o primeiro nome
*/

select left(clinome, locate(' ', clinome)) 'Nome', count(*) 'Qtde'
from cliente
group by Nome
order by Nome;

/*
	2. Mostre o sobrenome (último nome) de cada cliente
*/

select right(clinome, locate(' ', reverse(clinome)) - 1) 'Último Nome'
from cliente;

/*
	3. Mostre os "nome(s) do meio" de cada cliente.
    Exemplo: "João da Silva Oliveira" -> da Silva
*/

select substring(clinome, length(left(clinome, locate(' ', clinome))))
from cliente;

select clinome 'Nome',
length(clinome) 'Tam_Total',
length(right(clinome, locate(' ', reverse(clinome)) - 1)) 'Tam_Primeiro_Nome',
length(substring(clinome, length(left(clinome, locate(' ', clinome))))) 'Tam_Ultimo_Nome',
length(substring(clinome, length(left(clinome, locate(' ', clinome))))),
substring(length(substring(clinome, length(left(clinome, locate(' ', clinome))))), )
from cliente;

select clinome,
length(clinome) 'Tam_Total',
length(left(clinome, locate(' ', clinome) - 1)) 'Tam_pri_nome',
length(right(clinome, locate(' ', reverse(clinome)) - 1)) 'Tam_ult_nome',
substring(clinome, length(left(clinome, locate(' ', clinome) - 1))) 'Tam_pri_nome'
from cliente;

/*
	4. Mostre para cada data, em colunas separadas o código de venda,
    dia, mês e ano, e uma outra coluna "semestre" no formato Ano/Mês
*/

select vendata 'Data', vencodigo, right(vendata, 2) 'Dia',
substring(vendata, 6, 2) 'Mês', left(vendata, 4) 'Ano',
concat(left(vendata, 4), '/', substring(vendata, 6, 2)) 'Semestre'
from venda;

/*
	5. Retorne os nomes dos funcionários e seus bairros, para que os que não tenham gerado venda.alter
*/

select funnome 'Funcionário', bainome 'Bairro', count(venfuncodigo) 'Qtde. vendas'
from venda
right outer join funcionario on venfuncodigo = funcodigo
inner join bairro on baicodigo = funbaicodigo
where venfuncodigo is null
group by funnome, bainome;

/*
	6. Mostre os nomes dos produtos que não foram vendidos
*/

select pronome 'Produto', count(itvvencodigo) 'Quantidade'
from itemvenda
inner join venda on itvvencodigo = vencodigo
right outer join produto on itvprocodigo = procodigo
where itvvencodigo is null
group by pronome;

select pronome
from produto
where procodigo not in (select itvprocodigo from itemvenda);

/*
	7. Mostre os clientes solteiros ou divorciados que não geraram vendas
*/

select clinome 'Cliente', count(*) 'Qtde. Vendas', estdescricao 'Estado Civil'
from cliente
inner join estadocivil on estcodigo = cliestcodigo
left outer join venda on venclicodigo = clicodigo
where (estdescricao = 'Solteiro' or estdescricao = 'Divorciado')
and vencodigo is null
group by clinome, estdescricao;

-- Resolução
select clinome
from cliente
inner join estadocivil on estcodigo = cliestcodigo
left outer join venda on clicodigo = venclicodigo
where vencodigo is null and estdescricao in ('solteiro', 'divorciado');