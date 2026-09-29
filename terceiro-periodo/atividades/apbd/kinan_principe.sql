use bd2026;

-- Questão 1

select clinome "Nome", estdescricao "Estado Civil"
from cliente
left outer join venda on clicodigo = venclicodigo
inner join estadocivil on estcodigo = cliestcodigo
order by clinome, vendata;

-- Questão 2

select left(clinome, 5) "Cinco Esquerda Nome", right(clifone, 4) "Quatro Direita Fone",
	length(clinome) "Tamanho Nome",
    concat(clicodigo, "-", clinome) "Identificação"
from cliente
group by left(clinome, 5), right(clifone, 4);

-- Questão 3

select pronome "Produto", procodigo "Código",
	left(substring(pronome, length(left(pronome, locate(" ", pronome) + 1))), 1) "Primeiro Caractere",
    substring(pronome, length(left(pronome, locate(" ", pronome) + 1))) "Sem Primeira Palavra"
from produto;

-- Questão 4

select procodigo "Código", pronome "Nome",
	sum(itvqtde) "Qtde. Vendida", count(itvvencodigo) "Qtde. Vendas"
from produto
left outer join itemvenda on procodigo = itvprocodigo
group by procodigo, pronome;

-- Questão 5

select bainome, clirendamensal
from cliente
inner join bairro on baicodigo = clibaicodigo
group by bainome
having clirendamensal > avg(clirendamensal);

-- Questão 6

select pronome "Nome", fornome "Fornecedor"
from produto
inner join fornecedor on proforcnpj
where procodigo not in (select itvprocodigo from itemvenda);

-- Questão 7

delimiter $$
create procedure sp_q7()
begin
	select fpcodigo "Código", fpdescricao "Descrição",
		sum(itvqtde) "Qtde. Vendas",
		sum(itvqtde * propreco) "Valor Total"
	from venda
	left outer join formapagamento on fpcodigo = venfpcodigo
	inner join itemvenda on vencodigo = itvvencodigo
	inner join produto on procodigo = itvprocodigo
	group by fpcodigo, fpdescricao;
end $$
delimiter ;

call sp_q7();

-- Questão 8

show create table produto;

delimiter $$
create procedure sp_q8(v_procodigo int)
begin
	declare v_classificacao varchar(40);
	declare v_pro_inexistente boolean;
    declare v_prosaldo int(11);
    
    set v_pro_inexistente = (select count(procodigo)
								from produto
								where procodigo = v_procodigo);
	
    set v_prosaldo = (select prosaldo
							from produto
                            where procodigo = v_procodigo);
	
    if v_pro_inexistente then
		if v_prosaldo is null then
			set v_classificacao = "SEM ESTOQUE";
        elseif v_prosaldo >= 1 and v_prosaldo <= 5 then
			set v_classificacao = "ESTOQUE BAIXO";
        elseif v_prosaldo > 5 then
			set v_classificacao = "ESTOQUE NORMAL";
        end if;
        
        select procodigo "Código", pronome "Nome", prosaldo "Saldo", v_classificacao "Classificação"
		from produto
		where procodigo = v_procodigo;
	else
		select v_procodigo "Código", null "Nome", 0 "Saldo", "PRODUTO INEXISTENTE" Classificação;
    end if;
end$$
delimiter ;

drop procedure sp_q8;

call sp_q8(3);

-- Questão 9

delimiter $$
create procedure sp_q9(v_sexo char(1))
begin
	if v_sexo = "F" or v_sexo = "M" then
		select clinome "Nome", clirendamensal "Renda Mensal", estdescricao "Estado Civil"
		from cliente
		inner join estadocivil on estcodigo = cliestcodigo
		left outer join venda on clicodigo = venclicodigo
		where clisexo = v_sexo and venclicodigo is not null;
	elseif v_sexo = "U" then
		select clinome "Nome", clirendamensal "Renda Mensal", estdescricao "Estado Civil"
		from cliente
		inner join estadocivil on estcodigo = cliestcodigo
		left outer join venda on clicodigo = venclicodigo
		where venclicodigo is not null;
    else
		select concat("Opção de sexo '", v_sexo, "' inválida. (F/M/U)");
    end if;
end$$
delimiter ;

call sp_q9("u");

-- Questão 10

delimiter $$
create procedure sp_q10(v_zona varchar(15))
begin
	declare v_zona_existe boolean;
    set v_zona_existe = (select count(zoncodigo)
							from zona
                            where zonnome = v_zona);
    
    if v_zona_existe = True then
		select bainome "Bairro", zonnome "Zona",
			count(clicodigo) "Qutde. Clientes",
			avg(clirendamensal) "Média Salarial",
			min(clirendamensal) "Menor Salário",
			max(clirendamensal) "Maior Salário"
		from zona
		inner join bairro on zoncodigo = baizoncodigo
		inner join cliente on baicodigo = clibaicodigo
		where zonnome = v_zona
		group by bainome
		order by count(clicodigo) desc;
	else
		select concat("Zona '", v_zona, "' inexistente.") resp;
    end if;
end$$
delimiter ;

call sp_q10("NORTE");