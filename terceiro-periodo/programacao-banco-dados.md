---
title: Organização de Computadores
date: 27-07-2026
---

# 1. EMENTA DA DISCIPLINA
## 1.1 Assuntos
- Modelo lógico;
- Álgebra relacional;

## 1.2 Avaliações
- $n$ atividades individuais - peso 2
- $n$ atividades em equipe - peso 1

&emsp;Média será $(2(M_ai) + (M_ae)) / 3$

# 2. FERRAMENTAS
- MariaDB ou MySQL

# 3. ENTIDADES
&emsp;É um conjunto de elementos com as mesmas características.
- Todo atributo são dados referentes a essas características.

| cpf | nome aluno | cod disciplina | nome disciplina | semestre | nota |
| --- | --- | --- | --- | --- | --- |
1 | aluno 1 | 1 | disciplina 1 | 2026/01 | 8 |
2 | aluno 1 | 2 | disciplina 2 | 2026/01 | 4 |
1 | aluno 2 | 1 | disciplina 1 | 2026/01 | 5 |

- **Chave primária**: identificador de uma tabela
    + Nunca é nulo;
    + É único.

# 4. SQL
- *LIKE*: filtragem por padrões (como regex);
    + *LIKE* "%string"
- *INNER JOIN x ON*: União de duas tabelas relacionadas.

## 4.1 Agrupamentos
- *COUNT(\*): Contagem
    + Valores nulos são ignorados.
- SUM(n): Soma
- MAX(campo): Maior valor
- MIN(campo): Menor valor
- AVG(n): Média
- HAVING: Filtragem para funções
