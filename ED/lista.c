#include <stdio.h>
#include <stdlib.h>

typedef struct Lista {
    float nota;
    struct Lista *prox_nota;
} Lista;

int main(void) {
    Lista inicio = {0};
    inicio.prox_nota = NULL;

    float valor;
    char resp[16];

    Lista *no = &inicio;

    do {
        no->prox_nota = malloc(sizeof(Lista));
        printf("digite a nota: ");
        scanf("%f", &valor);
        no->nota = valor;
        no = no->prox_nota;
        no->prox_nota = NULL;

        printf("deseja continuar? (s/n): ");
        getchar();
        fgets(resp, 16, stdin);

    } while (*resp == 's' || *resp == 'S');

    no = &inicio;
    while (no->prox_nota != NULL) {
        printf("Nota: %.2f\n", no->nota);
        no = no->prox_nota;
    }
} 
