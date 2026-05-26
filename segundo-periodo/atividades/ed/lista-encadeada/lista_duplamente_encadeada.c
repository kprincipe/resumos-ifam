/*
 *  Descricao: Implementacao de uma lista duplamente encadeada
 *      Autor: Kinan Principe (kprincipe)
 *       Data: 25/05/2026
 */

#include <stdio.h>
#include <stdlib.h>

typedef struct Lista_Encadeada {
    int numero;
    struct Lista_Encadeada *proximo;
    struct Lista_Encadeada *anterior;
} Lista_Encadeada;

void remover_do_inicio(Lista_Encadeada *l) {
    Lista_Encadeada *orphan;
    if (l->proximo) {
        orphan = l->proximo;
        l->proximo = orphan->proximo;
        orphan->proximo->anterior = l;
        free(orphan);
    }
}

void remover_do_final(Lista_Encadeada *l) {
    Lista_Encadeada *orphan = l;
    
    while (orphan->proximo) {
        orphan = orphan->proximo;
    }

    orphan->anterior->proximo = NULL;
    free(orphan);
}

void remover_em_indice(Lista_Encadeada *l, int indice) {
    Lista_Encadeada *orphan = l;
    for (int x = -1; x < indice; ++x) {
        if (orphan->proximo) {
            orphan = orphan->proximo;
        } else {
            break;
        }
    }

    if (orphan->proximo) {
        orphan->anterior->proximo = orphan->proximo;
        orphan->proximo->anterior = orphan->anterior;
    } else {
        orphan->anterior->proximo = NULL;
    }

    free(orphan);
}

void inserir_ao_inicio(Lista_Encadeada *node, int num) {
    Lista_Encadeada *novo = malloc(sizeof(Lista_Encadeada));
    Lista_Encadeada *proximo;

    novo->numero = num;

    if (!node->proximo) {
        node->proximo = novo;
        return;
    }

    proximo = node->proximo;
    novo->proximo = proximo;
    proximo->anterior = novo;
    node->proximo = novo;
}

void inserir_ao_final(Lista_Encadeada *node, int num) {
    Lista_Encadeada *novo = malloc(sizeof(Lista_Encadeada));
    Lista_Encadeada *temp = node;

    while (temp->proximo) {
        temp = temp->proximo;
    }

    temp->proximo = novo;
    novo->anterior = temp;
    novo->proximo = NULL;
    novo->numero = num;
}

void inserir_em_indice(Lista_Encadeada *l, int num, int indice) {
    Lista_Encadeada *novo = malloc(sizeof(Lista_Encadeada));
    Lista_Encadeada *temp = l;

    novo->numero = num;

    for (int x = -1; x < indice; ++x) {
        if (temp->proximo) {
            temp = temp->proximo;
        } else {
            break;
        }
    }

    if (temp->proximo == NULL) {
        temp->proximo = novo;
        novo->anterior = temp;
        novo->proximo = NULL;
    } else {
        novo->proximo = temp->proximo;
        novo->anterior = temp;

        temp->proximo->anterior = novo;
        temp->proximo = novo;
    }
}

Lista_Encadeada inicializar_lista() {
    return (Lista_Encadeada) {
        .numero = 0,
        .proximo = NULL,
        .anterior = NULL
    };
}

void imprimir_lista(Lista_Encadeada *l) {
    if (l->anterior == NULL && l->proximo == NULL) {
        printf("lista vazia\n");
        return;
    }

    printf("[ ");
    while (l->proximo) {
        l = l->proximo;
        if (l->proximo) printf("%d, ", l->numero);
        else printf("%d ]\n", l->numero);
    }
}

int main(void) {
    Lista_Encadeada lista = inicializar_lista();
    inserir_ao_final(&lista, 67);
    inserir_ao_final(&lista, 42);

    imprimir_lista(&lista);
    return 0;
}
