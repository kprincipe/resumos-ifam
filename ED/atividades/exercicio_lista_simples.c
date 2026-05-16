#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

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

void remover_aluno(Aluno *aluno);
void salvar_aluno(Aluno aluno, char *arquivo);
int carregar_aluno(Aluno *aluno, FILE *f);
void alunos();
void cabecalho();
void menu();
void diario();
void exibir();
void adicionar(Aluno aluno);
void inserir();
void remover();

/* remover aluno de arquivo */
void remover_aluno(Aluno *aluno) {
    FILE *f = fopen("alunos.csv", "r");
    FILE *tmp = fopen("tmp", "w");

    Aluno busca = {0};
    
    // carrega alunos do arquivo na estrutura estatica temporaria de aluno (busca)
    while (carregar_aluno(&busca, f) > 0) {
        // salvar aluno em arquivo temporario apenas se matriculas forem diferentes da que se deseja remover
        if (aluno->matricula != busca.matricula)
            salvar_aluno(busca, "tmp");
    }

    // renomeia arquivo temporario para subscrever os dados de alunos com a lista atualizada
    rename("tmp", "alunos.csv");
}

/* funcao de salvar em arquivo */
void salvar_aluno(Aluno aluno, char *arquivo) {
    FILE *f = fopen(arquivo, "a");
    fprintf(f, "%d,%s,%f,%f\n", aluno.matricula, aluno.nome, aluno.notas[0], aluno.notas[1]);
    fclose(f);
}

/* funcao de carregar de arquivo */
int carregar_aluno(Aluno *aluno, FILE *f) {
    char buffer[BUFFER_MAX];
    char elemento[BUFFER_MAX];

    // leitura de uma linha do arquivo
    fgets(buffer, BUFFER_MAX, f);

    if (feof(f)) return -1;

    int i = 0, tamanho_elemento = 0;
    int qual_elemento = 0;
    while (buffer[i] != '\0') {
        // verifica ocorrencia dos caracteres `,` e `\n` na linha
        if (buffer[i] == ',' || buffer[i] == '\n') {
            // copia a partir da virgula uma string ate a proxima virgula
            strncpy(elemento, buffer + (i - tamanho_elemento), tamanho_elemento);
            // terminador nulo para string
            elemento[tamanho_elemento] = '\0';
            
            // verifica o indice do elemento na linha e armazena com devidas conversoes
            switch (qual_elemento) {
                case 0: aluno->matricula = atoi(elemento); break;
                case 1: strcpy(aluno->nome, elemento); break;
                case 2: aluno->notas[0] = atof(elemento); break;
                case 3: aluno->notas[1] = atof(elemento); break;
                default: printf("erro: formatacao de csv provavelmente incorreta\n");
            }
            
            // reseta o tamanho do elemento para comecar a contagem do tamanho do proximo
            tamanho_elemento = 0;
            // incrementa indice de leitura da linha para pular leitura da virgula
            i++;
            // incrementa o indice do elemento na linha
            qual_elemento++;
            continue;
        }
        // incrementa tamanho do elemento atual sendo lido
        tamanho_elemento++;
        // incrementa indice de leitura da linha
        i++;
    }
    
    // processa media aritmetica das notas
    aluno->notas[2] = (aluno->notas[0] + aluno->notas[1]) / 2;
    return 1;
}

/* funcao de alunos */
void alunos() {
    FILE *f = fopen("alunos.csv", "r");

    Aluno aluno = {0};
    
    while (carregar_aluno(&aluno, f) > 0) {
        adicionar(aluno);
    }
}

/* funcao de cabecalho */
void cabecalho() {
    system("clear");
    printf("programa para gerencia a matricula, o nome e as notas\n");
    printf("de um aluno usando uma lista simplesmente encadeada\n\n");
}

/* funcao menu */
void menu() {
    printf("--------------- menu ----------------\n");
    printf("1................exibir\n");
    printf("2................inserir\n");
    printf("3................remover\n");
    printf("4................retificar\n");
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

/* adicionar no ao fim da lista */
void adicionar(Aluno aluno) {
    pAux = &inicio;
    while (pAux->pProx) pAux = pAux->pProx;
    
    pAux->pProx = malloc(sizeof(Aluno));
    pAux = pAux->pProx;
    pAux->pProx = NULL;

    memcpy(pAux, &aluno, sizeof(Aluno));
}

/* funcao inserir */
void inserir() {
    Aluno aluno = {0};

    do {
        system("clear");
        printf("-------------- cadastro --------------\n");

        char buffer[BUFFER_MAX];

        printf("\t    matricula: ");
        fgets(buffer, BUFFER_MAX, stdin);
        aluno.matricula = atoi(buffer);

        printf("\tnome do aluno: ");
        fgets(aluno.nome, BUFFER_MAX, stdin);
        aluno.nome[strlen(aluno.nome) - 1] = '\0';

        printf("\t       nota 1: ");
        fgets(buffer, BUFFER_MAX, stdin);
        aluno.notas[0] = atof(buffer);

        printf("\t       nota 2: ");
        fgets(buffer, BUFFER_MAX, stdin);
        aluno.notas[1] = atof(buffer);

        aluno.notas[2] = (aluno.notas[0] + aluno.notas[1]) / 2;
        
        adicionar(aluno);
        salvar_aluno(*pAux, "alunos.csv");

        printf("--------------------------------------\n");

        printf("continuar inserindo dados? sim(s) nao(n): ");
        fgets(resp, BUFFER_MAX, stdin);
        *resp = toupper(*resp);
    } while (*resp == 'S');
}

/* funcao remover */
void remover() {
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

            remover_aluno(pAux);

            free(pAux);
        }
    } else {
        printf("matricula inexistente\n");
        getchar();
        pAnt = NULL;
        pAux = NULL;
    }
}

/* funcao de retificacao */
void retificar() {
    *resp = '0';

    system("clear");

    printf("-------------- retificar --------------\n");
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
        system("clear");
        printf("retificar cadastro de %s:\n", pAux->nome);
        printf("1................matricula\n");
        printf("2................nome\n");
        printf("3................nota 1\n");
        printf("4................nota 2\n\n");
        printf("0................sair\n");
        printf("digite a opcao: ");

        fgets(buffer, BUFFER_MAX, stdin);
        
        switch (atoi(buffer)) {
            case 1:
                printf("nova matricula: ");
                fgets(buffer, BUFFER_MAX, stdin);
                remover_aluno(pAux);
                pAux->matricula = atoi(buffer);
                break;
            case 0:
        }

        salvar_aluno(*pAux, "alunos.csv");
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
    alunos();

    do {
        do {
            cabecalho();
            menu();
            if(opcao < 0 || opcao > 4){
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
            case 4:
                retificar();
                break;
            default:
                printf("\nopcao invalida\n");
                getchar();
        }
    } while (opcao != 0);
}
