create database bd2026;

show databases;

use bd2026;

show tables;

select clicodigo,clinome
from cliente
where clirendamensal > 4000;

-- projeção bainome em bairro
select bainome from bairro;

select count(*) from bairro;
select count(*) from cliente;

select 16*533;

-- produto cartesiano
select * from bairro,cliente,zona,produto;

-- inner join
select bainome 'Nome do Bairro',clinome 'Cliente',estdescricao 'Estado Civil'
from bairro
inner join cliente on baicodigo = clibaicodigo
inner join estadocivil on estcodigo = cliestcodigo
where clirendamensal > 4000;

-- produtos ativos com saldo maiores que 10
select *
from produto
where proativo = 1 and prosaldo > 10
order by propreco;

select *
from cliente
order by clirendamensal,clinome;

select * from cliente
where clirendamensal = 1207
or clirendamensal = 1360
or clirendamensal = 1700
or clirendamensal = 3400;

select *
from cliente
where clirendamensal in (1207, 1360, 1700, 3400);
