-- 1. Mostre os nomes dos produtos e de seus grupos, somente para os que não tenham sido vendidos.


select pronome, itvvencodigo
from produto
inner join grupoproduto on grpcodigo = progrpcodigo
right outer join itemvenda on procodigo = itvprocodigo
group by pronome, itvvencodigo;

-- 2. Liste os nomes dos clientes que tenham comprado mais de 2 itens na mesma venda.

select clinome
from cliente
inner join venda on venclicodigo = clicodigo
inner join itemvenda on itvvencodigo = vencodigo
group by clinome; 

/* 	
 *	9. Crie (em uma única stored procedures) opções para inserção, atualização e deleção de clientes.
 *	Defina os parâmetros de forma adequada para cada operação, e valide os campos que são chaves
 *	estrangeiras, fazendo os devidos tratamentos e envio de mensagens de erros.
 *
 *	i - insert
 *	d - delete
 *	u - update
 *	c - create
*/
delimiter $$
create procedure sp_operacao(op char(1),
							 v_clisexo varchar(1),
							 v_clirendamensal double(6,2),
							 v_clinome varchar(60),
							 v_bainome varchar(30),
							 v_clifone varchar(10),
							 v_vestadocivil varchar(40))
begin
	declare v_baicodigo unsigned int;
	set v_baicodigo = (select baicodigo
					   from bairro
					   where bainome = v_bainome);

	declare v_baicodigo unsigned int;
	set v_baicodigo = (select baicodigo
					   from bairro
					   where bainome = v_bainome);

	if op == 'i' then
		insert into cliente(clisexo, clirendamensal, clinome, clibaicodigo, clifone, cliestcodigo)
		values (v_clisexo,
				v_clirendamensal,
				v_clinome,
				(select baicodigo
				 from bairro
				 where bainome = v_bairro),
				v_clifone,
				(select
				 estcodigo
				 from estadocivil
				 where v_))
	end if;

end $$
delimiter ;

insert into cliente (clinome, clisexo, cliestcodigo, clibaicodigo, clifone, clirendamensal)
values ("Kinan Principe",
		"M",
		(select estcodigo
		 from estadocivil
		 where estdescricao = "Solteiro"),
		(select baicodigo
		 from bairro
		 where bainome = "ADRIANÓPOLIS"),
		"9294351576",
		800);

select *
from cliente
where clinome = "Kinan Principe";




