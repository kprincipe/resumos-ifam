#include <stdio.h>
#include <stdlib.h>

// pilha do tipo LIFO (last in, first out)

typedef struct Elemento {
    int dado;
    struct Elemento *proximo;
} Elemento;

// insere elemento no topo da pilha
void push(Elemento *base, int dado) {
    Elemento *tmp = base;
    while (tmp->proximo) tmp = tmp->proximo;
    tmp->proximo = malloc(sizeof(Elemento));
    tmp = tmp->proximo;
    tmp->dado = dado;
    tmp->proximo = NULL;
}

// retira elemento do topo da pilha
void pop(Elemento *base) {
    Elemento *ant, *tmp = base;
    while (tmp->proximo) {
        ant = tmp;
        tmp = tmp->proximo;
    }

    ant->proximo = NULL;
    free(tmp);
}

void dump_stack(Elemento *base) {
    Elemento *tmp = base;
    while (tmp->proximo) {
        tmp = tmp->proximo;
        printf("%d\n", tmp->dado);
    }
}

int main(void) {
    Elemento base = {
        .proximo = NULL
    };

    push(&base, 67);
    push(&base, 42);
    push(&base, 123);
    dump_stack(&base);
}
