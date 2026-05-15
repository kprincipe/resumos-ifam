#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define BUFFER_MAX 255

/* variaveis globais */
char professor[BUFFER_MAX], disciplina[BUFFER_MAX], turma[BUFFER_MAX];
char resp[BUFFER_MAX];

int matTemp, opcao;

typedef struct Aluno {
    int matricula; /* numeros de 1 a no maximo 40 */
    char nome[BUFFER_MAX];
    float notas[3]; /* valores das notas */
    struct Aluno *pProx; /* ponteiro para o proximo aluno */
} Aluno;

Aluno inicio, *pAux, *pAnt;

/* funcao de cabecalho */
void cabecalho(){
    system("clear");
    printf("programa para gerencia a matricula, o nome e as notas\n");
    printf("de um aluno usando uma lista simplesmente encadeada\n\n");
}

/* funcao menu */
void menu(){
    printf("--------------- menu ----------------\n");
    printf("1................exibir\n");
    printf("2................inserir\n");
    printf("3................remover\n");
    printf("0................sair\n\n");
    printf("digite a opcao: ");

    char buffer[BUFFER_MAX];
    fgets(buffer, BUFFER_MAX, stdin);
    opcao = atoi(buffer);
}

/* funcao diario */
void diario(){
    printf("preencher os dados do cabecalho do diario\n");

    printf("professor: ");
    fgets(professor, BUFFER_MAX, stdin);
    professor[strlen(professor) - 1] = '\0';
    printf("disciplina: ");
    fgets(disciplina, BUFFER_MAX, stdin);
    disciplina[strlen(disciplina) - 1] = '\0';
    printf("turma: ");
    fgets(turma, BUFFER_MAX, stdin);
    turma[strlen(turma) - 1] = '\0';
}

/* funcao exibir */
void exibir(){
    pAux = inicio.pProx; /* aponta para o inicio da lista */
    system("clear");
    printf("--------------- diario ---------------\n");
    printf("\t professor: %s\n", professor);
    printf("\tdisciplina: %s\n", disciplina);
    printf("\t     turma: %s\n", turma);
    printf("--------------------------------------\n\n");

    while(pAux){
        printf("\t matricula: %d\n", pAux->matricula);
        printf("\t      nome: %s\n", pAux->nome);
        printf("\t    nota 1: %.2f\n", pAux->notas[0]);
        printf("\t    nota 2: %.2f\n", pAux->notas[1]);
        printf("\t     media: %.2f\n\n", pAux->notas[2]);

        pAux = pAux->pProx;
    }
    printf("--------------------------------------\n");
    printf("pressione enter para continuar!");
    getchar();
}
/* funcao inserir */
void inserir(){
    pAux = &inicio; /* aponta para o inicio da lista */
    while(pAux->pProx) pAux = pAux->pProx;

    do {
        system("clear");
        printf("-------------- cadastro --------------\n");

        pAux->pProx = malloc(sizeof(Aluno));
        pAux = pAux->pProx;

        char buffer[BUFFER_MAX];


        printf("\t    matricula: ");
        fgets(buffer, BUFFER_MAX, stdin);
        pAux->matricula = atoi(buffer);

        printf("\tnome do aluno: ");
        fgets(pAux->nome, BUFFER_MAX, stdin);
        pAux->nome[strlen(pAux->nome) - 1] = '\0';

        printf("\t       nota 1: ");
        fgets(buffer, BUFFER_MAX, stdin);
        pAux->notas[0] = atoi(buffer);

        printf("\t       nota 2: ");
        fgets(buffer, BUFFER_MAX, stdin);
        pAux->notas[1] = atoi(buffer);

        pAux->notas[2] = (pAux->notas[0] + pAux->notas[1]) / 2;
        pAux->pProx = NULL;

        printf("--------------------------------------\n");

        printf("continuar inserindo dados? sim(s) nao(n): ");
        fgets(resp, BUFFER_MAX, stdin);
        *resp = toupper(*resp);
    } while (*resp == 'S');
}
/* funcao remover */
void remover(){
    *resp = '0';

    system("clear");

    printf("--------------- remover ---------------\n");
    printf("matricula: ");

    char buffer[BUFFER_MAX];
    fgets(buffer, BUFFER_MAX, stdin);
    matTemp = atoi(buffer);

    pAux = &inicio;

    while (pAux->matricula != matTemp && pAux->pProx != NULL) {
        pAnt = pAux;
        pAux = pAux->pProx;
    }

    if (pAux->matricula == matTemp) {
        printf("remover %s? sim(s) nao(n): ", pAux->nome);
        fgets(resp, BUFFER_MAX, stdin);
        *resp = toupper(*resp);

        if (*resp == 'S') {
            pAnt->pProx = pAux->pProx;
            pAux->pProx = NULL;
            pAnt = NULL;
            free(pAux);
        }
    } else {
        printf("matricula inexistente\n");
        getchar();
        pAnt = NULL;
        pAux = NULL;
    }
}

/* funcao principal */
void main (void) {
    inicio.pProx = NULL; /* lista vazia */
    cabecalho();
    diario();

    do {
        do {
            cabecalho();
            menu();
            if(opcao < 0 || opcao > 3){
                opcao = -1;
                printf("opcao invalida!\n");
            }
        } while(opcao == -1);

        switch (opcao) {
            case 0:
                break;
            case 1:
                exibir();
                break;
            case 2:
                inserir();
                break;
            case 3:
                remover();
                break;
            default:
                printf("\nopcao invalida\n");
                getchar();
        }
    } while (opcao != 0);
}
