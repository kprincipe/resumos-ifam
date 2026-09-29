-- Estrutura de repetição

-- while
delimiter $$

create procedure sp_while()
begin
	declare i int default 0;
	
    while i < 10 do
		select i;
        set i = i + 1;
    end while;
end$$

delimiter ;

call sp_while();

delimiter $$

create procedure sp_par_impar(p_num smallint unsigned)
begin
	declare i int default 0;
    
	while i != p_num do
		if i % 2 = 0 then
			select concat(i, " é par");
		else
			select concat(i, " é impar");
		end if;
        
        set i = i + 1;
    end while;
end$$

delimiter ;

drop procedure sp_par_impar;

-- /////////////////////////////////////////

delimiter $$
create procedure sp_sep_caracteres(p_texto varchar(100))
begin
	declare v_tamanho smallint default length(p_texto);
    -- declare v_letra char(1) default '';
	declare v_contador int default 1;
    
    while v_contador <= v_tamanho do
		select substring(p_texto, v_contador, 1) "Caractere";
        set v_contador = v_contador + 1;
    end while;
end$$
delimiter ;

-- /////////////////////////////////////////

-- 1. Mostre a quantidade de vogais de um texto passado como parâmetro

delimiter $$
create procedure sp_vogais(p_texto varchar(100))
begin
	declare v_caractere char default substring(p_texto, 1, 1);
    declare v_contador int default 1;
    declare v_qtde_vogais int default 0;
    
    while v_contador <= length(p_texto) do
		if v_caractere in ('a','e','i','o','u') then
			set v_qtde_vogais = v_qtde_vogais + 1;
        end if;
        
        set v_contador = v_contador + 1;
        set v_caractere = substring(p_texto, v_contador, 1);
    end while;
    select v_qtde_vogais "Qtde. Vogais";
end$$
delimiter ;

drop procedure sp_vogais;

-- 2. Mostre a quantidade de consoantes de um parâmetro

delimiter $$
create procedure sp_consoantes(p_texto varchar(100))
begin
	declare v_caractere char default substring(p_texto, 1, 1);
    declare v_contador int default 1;
    declare v_qtde_consoantes int default 0;
    
    while v_contador <= length(p_texto) do
		if ascii(lower(substring(p_texto, v_contador, 1))) between 97 and 122 then
			if v_caractere not in ('a','e','i','o','u') then
				set v_qtde_consoantes = v_qtde_consoantes + 1;
			end if;
        end if;
        
        set v_contador = v_contador + 1;
        set v_caractere = substring(p_texto, v_contador, 1);
    end while;
    select v_qtde_consoantes "Qtde. Consoantes";
end$$
delimiter ;

drop procedure sp_consoantes;

-- //////////////////////////////////

delimiter $$
create procedure sp_consoantes(p_texto varchar(100))
begin
	declare v_caractere char default substring(p_texto, 1, 1);
    
    declare v_contador int default 1;
    declare vi_contador int default 1;
    
    declare v_qtde_consoantes int default 0;
    declare v_consoantes varchar(21) default "bcdfghjklmnpqrstvwxyz";
    
    while v_contador <= length(p_texto) do
		while vi_contador < length(v_consoantes) do
			if v_caractere = substring(v_consoantes, vi_contador, 1) then
				set v_qtde_consoantes = v_qtde_consoantes + 1;
            end if;
            set vi_contador = vi_contador + 1;
        end while;
        
        set v_contador = v_contador + 1;
        set v_caractere = substring(p_texto, v_contador, 1);
    end while;
    select v_qtde_consoantes "Qtde. Consoantes";
end$$
delimiter ;

drop procedure sp_consoantes;

-- 3. Retorne um texto passado com "-" entre cada caractere ex: sp_x("banco") -> "b-a-n-c-o"

delimiter $$
create procedure sp_traco(p_texto varchar(100))
begin
	declare v_tamanho int default length(p_texto);
	declare v_caractere char default "";
    declare v_contador int default 0;
    declare v_resp varchar(100) default v_caractere;
    
    while v_contador <= v_tamanho do
		if v_contador = 0 or v_contador = v_tamanho then
			set v_resp = concat(v_resp, v_caractere);
        else
			set v_resp = concat(v_resp, v_caractere, "-");
		end if;
        
        set v_contador = v_contador + 1;
        set v_caractere = substring(p_texto, v_contador, 1);
    end while;
    
    select v_resp resp;
end$$
delimiter ;

drop procedure sp_traco;


delimiter $$
create procedure sp_q3(p_texto varchar(100))
begin
	declare v_tamanho int default length(p_texto);
    declare v_contador int default 1;
    declare v_acumulador varchar(100) default "";
    
    while v_contador <= v_tamanho do
		if v_contador != v_tamanho then
			set v_acumulador = concat(v_acumulador, substring(p_texto, v_contador, 1), "-");
		else
			set v_acumulador = concat(v_acumulador, substring(p_texto, v_contador, 1));
        end if;
        
        set v_contador = v_contador + 1;
    end while;
    select v_acumulador resp;
end$$
delimiter ;

drop procedure sp_q3;
call sp_q3("eumemo");

-- repeat

-- loop: rep
-- leave rep
-- end loop

-- Função

set global log_bin_trust_function_creators=1;

delimiter $$
create function f_operacoes(p_n1 int, p_n2 int, p_op char(3)) returns int
begin
	if p_op = "som" then
		return p_n1 + p_n2;
    elseif p_op = "sub" then
		return p_n1 - p_n2;
	elseif p_op = "mul" then
		return p_n1 * p_n2;
	elseif p_op = "div" then
		return p_n1 / p_n2;
	end if;
end$$
delimiter ;

select f_operacoes(2, 3, "mul");

-- 1. Fazer função que pegue o caractere atual e retornar na procedure
delimiter $$
create function f_caractere_pos(p_texto varchar(100), p_pos int) returns char
begin
	return substring(p_texto, p_pos, 1);
end$$
delimiter ;

-- 2. implementar a função "my_left"

delimiter $$
create function my_left(p_texto varchar(100), p_contador int) returns varchar(100)
begin
	declare v_contador smallint default 0;
    declare v_acumulador varchar(100) default "";
    
    while v_contador <= p_contador do
		set v_acumulador = concat(v_acumulador, f_caractere_pos(p_texto, v_contador));
		set v_contador = v_contador + 1;
    end while;
    return v_acumulador;
    return substring(p_texto, 1, p_contador);
end$$
delimiter ;

delimiter $$
create function my_left2(p_texto varchar(100), p_contador int) returns varchar(100)
begin
    return substring(p_texto, 1, p_contador);
end$$
delimiter ;

select my_left2("beatriz", 0);
select left("beatriz", 3);