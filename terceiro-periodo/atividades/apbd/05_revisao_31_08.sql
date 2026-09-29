use bd2026;

/*
*	1) Mostre os nomes dos produtos e de seus grupos, somente para os que não tenham sido vendidos.
*/

select pronome, count(itvqtde)
from produto
inner join grupoproduto on grpcodigo = progrpcodigo
left outer join itemvenda on procodigo = itvprocodigo
group by pronome;

/*
* 	2) Liste os nomes dos clientes que tenham comprado mais de 2 itens na mesma venda.
*/

select clinome "Cliente", itvqtde "Qtd. Venda"
from cliente
inner join venda on venclicodigo = clicodigo
inner join itemvenda on itvvencodigo = vencodigo
where itvqtde > 2
group by clinome;

/*
*	3) Retorne em uma única lista os nomes dos clientes que ganhem mais de 4000 e os nomes
* 	dos funcionários que ganhem mais de 3000. Ordene a partir do maior para o menor salário.
*/

select clinome 'Nome', 'cliente' Categoria, clirendamensal 'Renda'
from cliente
where clirendamensal > 4000
union
select funnome, 'funcionario', funsalario
from funcionario
where funsalario > 3000
order by Renda desc;

/*
*	4) Mostre os nomes dos funcionários que tenham gerado a maior quantidade de vendas.
*/

select funcodigo "Código", funnome "Funcionário", count(vencodigo) "Vendas"
from funcionario
inner join venda on funcodigo = venfuncodigo
group by funcodigo
order by count(vencodigo) desc;

/*
*	5) Liste os nomes dos produtos mais vendidos.
*/

select pronome "Produto", sum(itvqtde) "Vendas"
from produto
inner join itemvenda on itvprocodigo = procodigo
group by procodigo
order by sum(itvqtde) desc;

/*
*	6) Mostre os grupos de produtos que geraram o maior lucro para a empresa, em ordem decrescente.
*/

select grpdescricao "Grupo", (sum(itvqtde) * propreco) "Lucro"
from grupoproduto
inner join produto on grpcodigo = progrpcodigo
inner join itemvenda on itvprocodigo = procodigo
group by grpcodigo
order by Lucro desc;

/*
*	7) Apresente os nomes dos clientes que tiverem o segundo nome iniciando com “a” ou “b”.
*/

select clinome "Nome"
from cliente
where substring(clinome, locate(' ', clinome) + 1, length(clinome) - locate(' ', clinome)) like "a%";


/*
*	8) Liste os nomes dos funcionários que tenham o maior tamanho de nome.
*/

select funnome -- , length(funnome)
from funcionario
order by length(funnome) desc;

-- ///////////////////////////////////

insert into cliente
values((select max(clicodigo) + 1 from cliente),
	'M',
	4000,
    'Joaquim José da Silva Xavier',
    1,
    99999-9999,
    3,
    current_date(),
    null);
    
update cliente
set clirendamensal = clirendamensal + clirendamensal * 1.1
where clicodigo = 605;

delete from cliente
where clicodigo = 605;

delimiter $$
create procedure sp_acao_cliente(p_cliente int, p_sexo char(1), p_renda decimal(6,2), p_nome varchar(60),
								p_baicodigo int, p_fone varchar(10), p_estcivil int,
                                p_acao char(1))
begin
	declare v_bairro_existe, v_estcivil, v_clienteexiste boolean default false;
    set v_bairro_existe = (select count(*) from bairro where baicodigo = p_baicodigo);
    set v_estcivil = (select count(*) from estadocivil where estcodigo = p_estcivil);
	set v_clienteexiste = (select count(*) from cliente where clicodigo = p_cliente);
    
    select concat("v_bairro_existe: ", v_bairro_existe, " - ", "v_estcivil: ", v_estcivil);
    
    if p_acao = "I" then
		if not v_bairro_existe and not v_estcivil then
			select concat("Bairro com código ", p_baicodigo, " e Estado Civil código ", p_estcivil, "não existem!") resp;
        else
			if v_bairro_existe = False then
				select concat("Bairro com código ", p_baicodigo, " não existe!") resp;
			elseif v_estcivil = False then
				select concat("Estado Civil código ", p_estcivil, " não existe!") resp;
			else
				insert into cliente
				values(null, p_sexo, p_renda, p_nome, p_baicodigo, p_fone, p_estcivil, current_date(), null);
                select "Cliente inserido!" resp;
			end if;
		end if;
	elseif  p_acao = "A" then
		if not v_clienteexiste then
			select concat("Cliente com código ", p_cliente, " não existe") resp;
		else
			update cliente
			set
			clisexo = p_sexo, clirendamensal = p_renda, clinome = p_nome,
			clibaicodigo = p_baicodigo, clifone = p_fone, cliestcodigo = p_estcivil
			where clicodigo = p_cliente;
		end if;
	elseif p_acao = "D" then
		if not v_clienteexiste then
			select concat("Cliente com código ", p_cliente, " não existe") resp;
        else
			delete
            from cliente
            where clicodigo = p_cliente;
            select "Cliente excluído!" resp;
        end if;
	else
		select "Ação inválida!";
	end if;
end$$
delimiter ;

drop procedure sp_acao_cliente;

call sp_acao_cliente(100, "F", 7000, "Maria Joaquina", 1, '99999-9999', 1, "A");
call sp_acao_cliente(100, null, null, null, null, null, null, "D");
call sp_acao_cliente(null, "I", 2500, "Maigua Marino", 1, 90000-0000, 1, "A");

select *
from cliente
where clinome = 'Maigua Marino';

/*
*	10) Mostre o total de vendas por sexo de clientes e forma de pagamento.
*/

select clisexo, count(*), fpdescricao
from cliente
inner join venda on venclicodigo = clicodigo
inner join formapagamento on venfpcodigo = fpcodigo
where clisexo = 'F' and fpcodigo = 1
group by clisexo, fpdescricao;

delimiter $$
create procedure sp_total_vendas_por_sp(p_sexo char(1), p_fpcodigo int)
begin
	select clisexo "Sexo", count(*) "Qtd. Vendas", fpdescricao "Forma de Pagamento"
	from cliente
	inner join venda on venclicodigo = clicodigo
	inner join formapagamento on venfpcodigo = fpcodigo
	where clisexo = p_sexo and fpcodigo = p_fpcodigo
	group by clisexo, fpdescricao;
end$$
delimiter ;

drop procedure sp_total_vendas_por_sp;

call sp_total_vendas_por_sp('M', 2);

/*
*	10) Mostre o total de vendas por sexo de clientes e forma de pagamento.
*/

/*
*	18) Mostre quantos produtos dos grupos "informática" e "eletroeletrônico" foram vendidos para
*	clientes do sexo masculino, casadas ou divorciadas e da zona norte;
*/

select grpdescricao, sum(itvqtde) "Total de produtos vendidos"
from grupoproduto
inner join produto on grpcodigo = progrpcodigo
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
inner join cliente on clicodigo = venclicodigo
inner join estadocivil on estcodigo = cliestcodigo
inner join bairro on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo
where clisexo = "M"
and estdescricao in ("casado", "divorciado")
and zonnome = "Sul"
group by grpdescricao
order by sum(itvqtde);

delimiter $$
create procedure sp_q18(p_grupo1 varchar(40), p_grupo2 varchar(40), 
						p_sexo char(1), p_estcivil1 varchar(40), p_estcivil2 varchar(40),
                        p_zona varchar(15))
begin
	if p_grupo1 != p_grupo2 then
		if p_estcivil1 != p_estcivil2 then
			select sum(itvqtde) "Total de produtos vendidos"
			from grupoproduto
			inner join produto on grpcodigo = progrpcodigo
			inner join itemvenda on procodigo = itvprocodigo
			inner join venda on vencodigo = itvvencodigo
			inner join cliente on clicodigo = venclicodigo
			inner join estadocivil on estcodigo = cliestcodigo
			inner join bairro on baicodigo = clibaicodigo
			inner join zona on zoncodigo = baizoncodigo
			where grpdescricao in (p_grupo1, p_grupo2)
			and clisexo = p_sexo
			and estdescricao in (p_estcivil1, p_estcivil2)
			and zonnome = p_zona;
		else
			select concat("Estado Civis ", p_estcivil1, " redundantes.") resp;
        end if;
	else
		select concat("Grupos ", p_grupo1, " redundantes.") resp;
    end if;
end $$
delimiter ;

call sp_q18("informatica", "eletro-eletronicos", "M", "casado", "divorciado", "sul");



