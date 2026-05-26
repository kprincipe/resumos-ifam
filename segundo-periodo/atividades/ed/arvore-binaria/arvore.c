/*
 *  Descricao: Implementacao de uma arvore binaria
 *      autor: Kinan Principe <kprincipe>
 *       data: 25/05/2026
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct No {
    int tipo;
    int numero;
    struct No *direita;
    struct No *esquerda;
} No;

enum Tipo {
    EXP = 0,
    NUM
};

int nivel = 0;
// nao entendi como funciona
void inserir_expressao(No *no, enum Tipo tipo) {
    No *temp = no;
    if (!temp->esquerda && temp->direita) {
        temp = temp->direita;
        nivel++;
        inserir_expressao(temp, tipo);
    } else {
        temp->esquerda = malloc(sizeof(No));
        temp = temp->esquerda;
        temp->tipo = EXP;
        temp->esquerda = NULL;
        temp->direita = NULL;
        printf("armazenado no nivel %d\n", nivel);
    }
}

No inicializar_arvore() {
    return (No) {
        .tipo = 0,
        .esquerda = NULL,
        .direita = NULL
    };
}

int main(void) {
    No arvore = inicializar_arvore();

    char *codigo = "(2 + 2)";

    for (int i = 0; i < strlen(codigo); ++i) {
        if (codigo[i] == '(') {
            inserir_expressao(&arvore, EXP);
        }
    }

    return 0;
}
