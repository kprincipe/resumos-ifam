-- 3a Lista - APBD

/*
* 	Receber 2 códigos de clientes (parâmetros), contar o número de consoantes dos respectivos
* 	clientes e retornar o nome completo e nome do bairro do cliente que tenha o maior número.
* 	Validar os 2 códigos, que devem existir e não podem ser iguais. É possível que 2 clientes
* 	diferentes possuam o mesmo número de consoantes.
*/

delimiter $$
create procedure sp_q1(p_clicodigo1 int, p_clicodigo2 int)
begin
	declare v_codigo1_existe boolean default (select count(*) from cliente where clicodigo = p_clicodigo1);
    declare v_codigo2_existe boolean default (select count(*) from cliente where clicodigo = p_clicodigo2);
    
    declare v_caractere char;
											
	declare v_contador int default 0;
	declare v_tam_clinome1 int default 0;
	declare v_tam_clinome2 int default 0;
    
    declare v_qtde_consoantes_cli1, v_qtde_consoantes_cli2 int default 0;
	
    declare p_clinome1 varchar(60) default '';
    declare p_clinome2 varchar(60) default '';
    
    select clinome, length(clinome) into p_clinome1, v_tam_clinome1 from cliente where clicodigo = p_clicodigo1;
    select clinome, length(clinome) into p_clinome2, v_tam_clinome2 from cliente where clicodigo = p_clicodigo2;
    
	/* declare p_clinome1 varchar(60) default (select clin\ome
												from cliente
												where clicodigo = p_clicodigo1);
										
	declare p_clinome2 varchar(60) default (select clinome
												from cliente
												where clicodigo = p_clicodigo2);
    */
    
    if v_codigo1_existe and v_codigo2_existe then
		if p_clicodigo1 = p_clicodigo2 then
			select "Códigos não podem ser iguais" resp;
        else
			while v_contador < v_tam_clinome1 do
				set v_caractere = substring(p_clinome1, v_contador, 1);
				if v_caractere not in ("a", "e", "i", "o", "u", " ") then
					set v_qtde_consoantes_cli1 = v_qtde_consoantes_cli1 + 1;
				end if;
				
				set v_contador = v_contador + 1;
			end while;
			
			set v_contador = 0;
			
			while v_contador < v_tam_clinome2 do
				set v_caractere = substring(p_clinome2, v_contador, 1);
				if v_caractere not in ("a", "e", "i", "o", "u") then
					set v_qtde_consoantes_cli2 = v_qtde_consoantes_cli2 + 1;
				end if;
				
				set v_contador = v_contador + 1;
			end while;
			
			if v_qtde_consoantes_cli1 > v_qtde_consoantes_cli2 then
				select clinome "Nome", bainome "Bairro"
				from cliente
				inner join bairro on baicodigo = clibaicodigo
				where clicodigo = p_clicodigo1;
			else
				select clinome "Nome", bainome "Bairro"
				from cliente
				inner join bairro on baicodigo = clibaicodigo
				where clicodigo = p_clicodigo2;
			end if;
        end if;
	else
		select "Codigo inexistente" resp;
    end if;
end$$
delimiter ;

drop procedure sp_q1;

call sp_q1(1, 2);

-- Trigger é um programa armazenado na camada do banco de dados
-- e possui a chamada automática. (gatilho)

-- Disparados por eventos da DML (update, insert, delete)

-- Triggers possuem um timing
-- 	* Before
-- 	* After
-- e devem estar vinculados a uma tabela.

/*
INSERT -> new
UPDATE -> new / old
DELETE -> old
*/

delimiter $$
create trigger tg_inc_clinone
after insert on cliente
for each row
begin
	update bairro set baiqtdepessoas = baiqtdepessoas + 1
    where baicodigo = new.clibaicodigo;
end$$
delimiter ;

delimiter $$
create trigger tg_inc_qtde_pessoas after insert on cliente
for each row
begin
	update bairro
    set baiqtdepessoas = baiqtdepessoas + 1
    where baicodigo = new.clibaicodigo;
end$$
delimiter ;

desc cliente;

insert into cliente
values(666, 'F', 7000, 'Beatrizky Baraunakov', 1, '9999-9999', 1, current_date(), null);

select * from bairro;

select *
from cliente;

-- crie trigger para atualizar o valor de baiqtdepessoas ao excluir um cliente
delimiter $$
create trigger tg_dec_qtde_pessoas after delete on cliente
for each row
begin
	update bairro
    set baiqtdepessoas = baiqtdepessoas - 1
    where baicodigo = old.clibaicodigo;
end$$
delimiter ;

delete from cliente where clicodigo = 609;

-- Crie um trigger para atualizar o valor de baiqtdepessoas de um bairro ao excluir um cliente

-- Monitore e altere a quantidade de pessoas dos respectivos bairros ao alterar o bairro de um cliente

delimiter $$
create trigger tg_atualizar_bairro after update on cliente
for each row
begin
	if new.clibaicodigo != old.clibaicodigo then
		update bairro
		set baiqtdepessoas = baiqtdepessoas - 1
		where baicodigo = old.clibaicodigo;
        
        update bairro
		set baiqtdepessoas = baiqtdepessoas + 1
		where baicodigo = new.clibaicodigo;
    end if;
end$$
delimiter ;

select *
from bairro;

update cliente
		set clibaicodigo = 2
		where clicodigo = 21;
        
insert into bairro
values (17, "NOVA FLORESTA", 1, 0);

insert into cliente
values(null, 'M', 9000, "CLIENTE NOVA FLORESTA", 17, 9999-9999, 4, current_date(), null);

delimiter $$
create trigger tg_mon_itemvenda after update on itemvenda
for each row
begin
	declare v_saldo int default 0;
    set v_saldo = (select prosaldo from produto where procodigo = new.itvprocodigo);
    
    if v_saldo >= new.itvqtde then
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Saldo Insuficiente';
    else
		update produto
		set prosaldo = prosaldo - new.itvqtde
		where procodigo = new.itvprocodigo;
	end if;
end$$
delimiter ;

drop trigger tg_mon_itemvenda;

select *
from itemvenda;

update produto
set prosaldo = 3
where procodigo = 7;

insert into itemvenda
values (null, 10, 1);
