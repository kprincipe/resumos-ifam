/* Programa "LS_nota.cpp" para exemplificar uma lista simplesmente encadeada
   para guardar uma sequência de notas */
#include <stdio.h>
#include <cstdlib>
#include <stdlib.h>
#include <iostream>
using namespace std;
int main(){
    char resp;
    float valor;

    struct ListaNota {
        float nota; /* valor da nota */
        struct ListaNota *prox_nota; /* ponteiro para próxima nota */
    } inicio, *no;

    system("clear");;
    printf("PROGRAMA PARA GUARDAR NOTAS EM UMA LISTA SIMPLESMENTE ENCADEADA\n");
    inicio.prox_nota = NULL; /* lista vazia */
    no = &inicio; /* aponta para o inicio da lista */
    do{
        no->prox_nota = (struct ListaNota *) malloc(sizeof(struct ListaNota));
        no = no->prox_nota;
        printf("\nDigite a nota: ");
        scanf("%f", &valor);
        no->nota = valor;
        no->prox_nota = NULL;
        printf("Deseja continuar? Sim[S] Nao[outra tecla]---->");
        cin >> resp;
    }while (resp == 'S'||resp == 's');
    /* Exibindo as notas da lista */
    printf("VALOR DE INICIO: %.2f\n", inicio.nota);
    no = inicio.prox_nota;
    printf("\nLISTA DAS NOTAS: ");
    while(no){
        printf("%.1f\t", no->nota);
        no = no->prox_nota;
    }
    printf("\n");
    getchar();

    return 0;
}
