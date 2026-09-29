select grpdescricao, count(procodigo)
from grupoproduto
left outer join produto on grpcodigo = progrpcodigo
-- where procodigo is null
group by grpdescricao;

-- equivalente do outer join com subconsulta
select grpdescricao
from grupoproduto
where grpcodigo not in (select progrpcodigo from produto);

-- Exercícios (com outer e subconsulta)
-- A segunda só faz sentido com OUTER JOIN!!

-- 1. Mostrar os nomes dos bairros que não tem filial e os nomes das respectivas zonas
select bainome "Bairro", zonnome "Zona"
from bairro
left outer join filial on baicodigo = filbaicodigo
inner join zona on baizoncodigo = zoncodigo
where filcodigo is null;

-- //////////

select bainome "Bairro", zonnome
from bairro
inner join zona on baizoncodigo = zoncodigo
where baicodigo not in (select filbaicodigo from filial);

-- 2. Mostre os nomes dos bairros e das quantidades de filiais de cada, incluindo no resultado todos os bairros que não tenham nenhuma filial

select bainome, count(filbaicodigo)
from bairro
left outer join filial on filbaicodigo = baicodigo
group by bainome;
