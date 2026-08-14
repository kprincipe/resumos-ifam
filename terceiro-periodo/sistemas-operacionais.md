---
title: Sistemas Operacionais
date: 29-07-2026
---

# 1. Fundamentos
- **Peopleware**: Alto nível, usuários, pessoas que utilizam o sistema conputacional;
- **Software**: "Intérpretes";
    + Intermediário entre alto nível e baixo nível;
    + Alguns mais outros menos próximos do código de máquina;
    + Abtrações.
- **Hardware**: Baixo nível.

&emsp;O Sistema Operacional é um conjunto de programas fundamentais que atua como camada intermediária entre o hardware do computador e as aplicações do usuário. Ele simplifica o hardware, e age como um árbrito, que distribui recursos e impõe regras.

- **Drivers**: Permitem que o Sistema Operacional se comunique com dispositivos de hardware;
- **Firmware**: Software básico gravado em hardware (exemplo: BIOS/UEFI);
- **Sistem Operacional**: Gerencia recursos do sistema e fornece serviços para os programas e usuários;
- **Compiladores**: Ferramentas que traduzem o código-fonte para código de máquina ou executam instruções.

&emsp;Ao projetar um sistema operacional, três objetivos principais norteiam suas decisões de arquitetura:
- Conveniência e usabilidade;
- Eficiência;
- Capacidade de Evolução.

# 1.1 Visões do Sistema Operacional
- **Visão de Máquina Estendida (ou Virtual)**: Oferece abstrações de alto nível (arquivos, diretório)
    + Sistema Operacional é um programa que medeia o usuário e a máquina, ocultando a dificuldade do hardware
- **Visão de Gerenciamento de Recursos**
    + Programa responsável pelo gerenciamento de processos, memórias, arquivos, *input* e *output*.

# 2. Revisão sobre Memória

```
                                                (pequena/rápida)
            /\ ......... Registradores                 
           /__\                                        ^
          /    \ ....... Cache                         |
         /______\                                      | 
        /        \ ..... Memória principal             |
       /__________\                                    V
      /            \ ... Memórias secundárias   
     /______________\                            (grande/lenta)    
```

## 2.1 Tipos de memória
- Eletrônicas;
    + Registradores, cache, ssd, pendrive.
- Magnéticas;
    + HDs, disquetes.
- Ópticas;
    + CD, DVDs, BluRay.

# 3. Gerências do Sistema Operacional
- CPU (processos);
- Memórias (registradores, cache, memória principal);
- Armazenamento (arquivos);
- Dispositivos de entrada/saída (vídeo, som, teclado, mouse).

