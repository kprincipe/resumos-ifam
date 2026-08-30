---
title: Análise de Sistemas
date: 28-07-2026
---

# 1. ANÁLISE DE SISTEMAS
&emsp;A grosso modo, o analista de sistemas deve entender o *cliente* e criar uma *documentação* para o desenvolvedor utilizar na a implementação do sistema.

# 2. PARADIGMA DA ORIENTAÇÃO A OBJETOS
&emsp;Forma de resolver o problema da construção de sistemas de software de grande complexidade;
- Sucessor do *paradigma estruturado* ou de *processos*;
- Visualiza um sistema de software como uma *coleção de agentes*;
- **Alan Kay** estabeleceu os princípios de orientação a objetos na segunda metade da década de 1960;

## 2.1 Classes e Objetos
&emsp;Coisas do mundo são objetos e classes são grupos de coisas semelhantes ou da mesma espécie.
- Classes são modelos, formas, gabaritos, templates de coisas semelhantes (do mesmo tipo);
- Objeto é uma instância de uma classe.

## 2.2 Instrumentos de Abstração
- **Encapsulamento**: não se sabe o que acontece dentro de um objeto;
- **Polimorfismo**: ferramenta em que um objeto pode ser tratado como se fosse a sua classe??;
- **Herança**: whatever he says.

# 3. UML 2.0
## 3.1 Levantamento e Análise de requisitos
&emsp;Um sistema bem modelado depende de um levantamento de requisitos de qualidade e bem validado. Deve-se compreender as necessidades do usuário e o que o usuário deseja que o sistema realize.

## 3.2 Blocos de Construção
## 3.3 Formato de Casos de Uso
### 3.3.1 Textual
- **Resumido**: Resumo de um parágrafo, apenas com cenário de sucesso principal;
- **Completo**
    + Várias secções (interessados, interesses, pré-condições, pós-condições);
    + Cenário de sucesso principal e sequências alternativas.
    + Dois tipos:
        * *Abstrato*: utilizado na fase de análise;
        * *Concreto*: utilizado na fase de projeto, com mais detalhes.

&emsp;**Exemplo**:
- *Caso de uso*: "Emprestar livro"
- *Visão geral*: A atendente da biblioteca realiza o empréstimo de um ou mais livros a um leitor apto a emprestar livros. O empréstimo é válido por um determinado período de tempo , de aacordo com o tipo de leitor.

```text
 O             +---------------+                              O
/|\  Leitor -> |Emprestar Livro| <- Atendente da Biblioteca  /|\
/ \            +---------------+                             / \
```

## 3.4 Associações
### 3.4.1 Entre casos de uso e atores
- Inclusão;
- Extensão;
- Especialização/Generalização.
    + Utilizada com equipe "azeitada";
    + Evitar se vendo pela primeira vez por gerar muita complexidade.

### 3.4.2 Associação <<include>>
- Comportamento parcial comum a vários casos de uso.
- Como se fosse uma rotina chamada por vários outros casos de uso.

### 3.4.2 Associação <<extend>>
- Descreve cenários opcionais de um caso de uso.

## 3.5 Diagrama de classe
- Todos os outros diagramas derivam do diagrama de classes;
- Construído a partir dos casos de uso;
- Persistir de maneira permanente os objetos de suas classes.

### 3.5.1
- Evitar conectar mais de duas classes
