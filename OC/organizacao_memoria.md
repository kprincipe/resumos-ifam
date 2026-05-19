---
title: Organização de Memória
author:
- Kinan Principe
date: ??/05/2026
---

# Organização de Memória

## Por que estudar Organização de Memória?
- Impacto no desempenho;
- Melhora da eficiência;
- Entender a hierarquia de memória;
- Projetar sistemas melhores;
- Entender software e hardware;
- Solucionar problemas;
- Preparação para o futuro.

## Unidades de Memória
- **Bit**: Elemento a ser manipulado.
- **Célula**: Unidade de informação.
- **Endereço**: Código de identificação de local.

## Por que utilizamos vários tipos de memória?
- Não é possível construir e utilizar *apenas um único tipo* de memória em sistemas de computação;
- Para certas atividades, é necessário que a transferência de dados seja o mais rápido possível;
- Outras atividades os dados devem ser armazenados por longos períodos de tempo.

## Conceitos importantes
- **Tempo de acesso**: Tempo que a memória gasta para colocar uma informação no barramento após uma determinada posição ter sido endereçada.
    + Um dos parâmetros para medir o desempenho da memória;
    + Também chamado de *latência*;
    + Denomina-se *tempo de acesso* ou *tempo de leitura*.
    + **Memória eletrônica**: Acesso aleatório (direto) e tempo de acesso igual *independentemente* da distância física de um local de acesso para o outro.
    + **Dispositivos Eletromecânicos**: Tempo de acesso variável. 
\newline

- **Capacidade**: Quantidade de informação que pode ser armazenada em uma memória.
    + Unidades de medida mais comuns: células, setores e bits. 
\newline
- **Volatilidade**:
    + **Memória volátil**: se perde (ex: Registradores, RAM);
    + **Memória não-volátil**: não se perde (ex: HD, Fitas). 
\newline
- **Tecnologia de fabricação**:
    + Memórias de Semicondutores 
    + **Leitura e escrita:** OLHAR SLIDE E FAZER DIAGRAMA!!!
        * **SRAM**: Memória estática -- flip-flops
            - Geralmente utilizada para memória cache
        * **DRAM**: Memória dinâmica -- capacitores
            - Geralmente utilizada para memória principal
    + **Leitura apenas:** OLHAR SLIDE E FAZER DIAGRAMA!!!
        * **ROM**:
            - PROM
            - EPROM
            - EEPROM
            - Flash
\newline
- **Temporariedade**:

## Hierarquia de Memória
+ Registradores &rarrow Cache &rarrow Memória principal &rarrow Memória secundária &rarrow Memória terciária/externa
