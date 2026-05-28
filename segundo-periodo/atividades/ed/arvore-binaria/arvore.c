/*
 *  Descricao: Implementacao de uma arvore binaria
 *           autor: Kinan Principe <kprincipe>
 *          criado: 25/05/2026
 *                : ----------
 *      atualizado: 26/05/2026
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct No {
    int numero;
    struct No *direita;
    struct No *esquerda;
} No;

enum Tipo {
    EXP = 0,
    NUM
};

No inicializar_arvore() {
    return (No) {
        .esquerda = NULL,
        .direita = NULL
    };
}

void inserir_no(No *no, int numero) {
    if (no->esquerda) {
        inserir_no(no->esquerda, numero);
    } else {
        no->esquerda = malloc(sizeof(No));
        no->numero = numero;
        return;
    }

    if (no->direita) {
        inserir_no(no->direita, numero);
    } else {
        no->direita = malloc(sizeof(No));
        no->numero = numero;
        return;
    }
}

int main(void) {
    No arvore = inicializar_arvore();

    inserir_no(&arvore, 67);
    inserir_no(&arvore, 42);
    inserir_no(&arvore, 39);
    inserir_no(&arvore, 12);
    inserir_no(&arvore, 49);

    printf("\t  %d\n", arvore.numero);
    printf("   %d\t\t%d\n", arvore.esquerda->numero, arvore.direita->numero);
    printf("%d    %d\n", arvore.esquerda->esquerda->numero, arvore.esquerda->direita->numero);
    return 0;
}
