use bd2026;

select clinome 'Nome', estdescricao 'Estado Civil', 'Cliente' Tipo
from cliente
inner join estadocivil on estcodigo = cliestcodigo
UNION
select funnome, estdescricao, 'Funcionario'
from funcionario
inner join estadocivil on estcodigo = funestcodigo;

/*
 *	Identifique os produtos ativos cujo preço de venda seja superior à média
 *	geral de preços de produtos cadastrados.
 *	Mostre: código, nome, preço e quantidade total de itens vendidos.
 */

-- Solução

select procodigo 'Código', pronome 'Nome', propreco 'Preço', sum(itvqtde) 'Total de itens'
from produto
inner join itemvenda on procodigo = itvprocodigo
where proativo = 1 and propreco > (select avg(propreco)
										from produto
										where proativo = 1)
group by procodigo, pronome, propreco;
					

/*
 *	Selecione os funcionários que recebam salário superior à média salarial dos
 *	funcionários que residem no mesmo bairro.
 *	Mostr código, nome, salário e nome do bairro. 
 */

-- Solução

select fext.funcodigo, fext.funnome, fext.funsalario, bainome
from funcionario fext
inner join bairro on baicodigo = funbaicodigo
where fext.funsalario > (select avg(fint.funsalario)
							from funcionario fint
							where fint.funbaicodigo = fext.funbaicodigo);

select bainome 'Bairro', avg(funsalario) 'Média Salarial'
from funcionario
inner join bairro on baicodigo = funbaicodigo
group by bainome;

/*
 *	Mostre o ID da primeira venda de cada cliente.
 */

select *
from venda vext
where (select min(vint.vendata)
		from venda vint);

-- Solução

-- Opção 1
select cext.clicodigo, cext.clinome, vext.vencodigo 'ID', vext.vendata
from cliente cext
inner join venda vext on cext.clicodigo = vext.venclicodigo
where vext.vencodigo in (
					select (select vint.vencodigo
								from venda vint
								where vint.venclicodigo = cext.clicodigo
								order by vint.vendata, vint.vencodigo
								limit 1)
					from cliente cint);


-- Opção 2
select cext.clicodigo, cext.clinome,
		vext.vencodigo 'ID', vext.vendata
from cliente cext
inner join venda vext
		on vext.vencodigo = (
							select vint.vencodigo
							from venda vint
							where vint.venclicodigo = cext.clicodigo
							order by vint.vendata, vint.vencodigo
							limit 1);

select cliente
from (select clinome as cliente, clirendamensal, clisexo 
		from cliente)
as saida;

/* Views */

create view vw_clientes_sexo_f
as
select clinome, clisexo, clirendamensal, zonnome, estdescricao
from cliente
inner join bairro on clibaicodigo = baicodigo
inner join zona on baizoncodigo = zoncodigo
inner join estadocivil on estcodigo = cliestcodigo
where clirendamensal > 3000
and zonnome in ("NORTE", "SUL")
and clisexo = "F"
and estdescricao = "SOLTEIRO";

/* Stored Procedures */
use bd2026;
delimiter $$
create procedure sp_clientes_por_sexo (p_sexo char(1), p_est char(40), p_bai char(40))
begin
	select clicodigo 'Código', clinome 'Nome do Cliente' 
	from cliente
	inner join estadocivil on estcodigo = cliestcodigo
	inner join bairro on baicodigo = clibaicodigo
	inner join zona on zoncodigo = baizoncodigo
	where clisexo = p_sexo
		and baidescricao = p_bai
		and estdescricao = p_est;
end $$
delimiter ;

/*
 *	1. Criar outra SP, filtrando além do sexo, estado civil e bairro
 *
 *	2. Mostrar os nomes dos clientes e suas rendas, para cada bairro
 *
 *	3. Mostrar os produtos com preço maior que determinado valor (p)
 *	que foram vendidos para clientes que tenham iniciais começando com a (p)
 */

delimiter $$
create procedure sp_clientes_sexo_estcivil_bai(p_sexo char(1), p_est char(40), p_bainome char(30))
begin
select clicodigo 'Código', clinome 'Nome do Cliente' 
	from cliente
	inner join estadocivil on estcodigo = cliestcodigo
	inner join bairro on baicodigo = clibaicodigo
	inner join zona on zoncodigo = baizoncodigo
	where clisexo = p_sexo
		and estdescricao = p_est
		and bainome = p_bainome;
end $$
delimiter ;

call sp_clientes_sexo_estcivil_bai('f', 'solteiro', 'cachoeirinha');

delimiter $$
create procedure sp_clinome_bai_renda()
begin
	select clinome, bainome, clirendamensal
	from cliente
	inner join bairro on baicodigo = clibaicodigo
	group by clinome, bainome, clirendamensal;
end $$
delimiter ;

call sp_clinome_bai_renda();

delimiter $$
create procedure sp_prod_valor_cliente(p_valor double(7, 2), p_ini char(1))
begin
	select pronome, clinome
	from produto
	inner join itemvenda on procodigo = itvprocodigo
	inner join venda on vencodigo = itvvencodigo
	inner join cliente on clicodigo = venclicodigo
	where propreco > p_valor and left(clinome, 1) = p_ini;
end $$
delimiter ;

call sp_prod_valor_cliente(1000, 'a');

-- desc cliente;

delimiter $$
$$
create procedure sp_cliente_ordem(p_ordem int unsigned)
begin
	declare v_existecliente boolean
	set v_existecliente = (select count(*)
								from cliente
								where clicodigo = p_codigo);
	if v_existecliente then
		select clinome
		from cliente
		where clicodigo = p_codigo;
	else
		select concat('Cliente ', p_codigo, ' não existe!')
	end if;
end $$
delimiter ;


