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
    struct Aluno *pAnt;
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
    // abre arquivo
    FILE *f = fopen(arquivo, "a");
    
    // imprime dados de aluno no arquivo
    fprintf(f, "%d,%s,%f,%f\n", aluno.matricula, aluno.nome, aluno.notas[0], aluno.notas[1]);

    // fecha arquivo
    fclose(f);
}

/* funcao de carregar de arquivo */
int carregar_aluno(Aluno *aluno, FILE *f) {
    char buffer[BUFFER_MAX];
    char elemento[BUFFER_MAX];

    // leitura de uma linha do arquivo
    fgets(buffer, BUFFER_MAX, f);

    // retorna sinal negativo se fim do arquivo foi alcancado
    if (feof(f)) return -1;

    int i = 0, tamanho_elemento = 0;
    int qual_elemento = 0;

    // repete enquanto nao econtrar caractere nulo (fim da string)
    while (buffer[i] != '\0') {
        // verifica ocorrencia dos caracteres `,` e `\n` na linha onde
        // `,` e o separador de elementos
        // `\n` e o delimitador do ultimo elemento
        if (buffer[i] == ',' || buffer[i] == '\n') {
            // copia a partir da virgula uma string ate a proxima virgula
            strncpy(elemento, buffer + (i - tamanho_elemento), tamanho_elemento);
            // terminador nulo para string gerada com o elemento
            elemento[tamanho_elemento] = '\0';
            
            // verifica o indice do elemento na linha e armazena com devidas conversoes
            switch (qual_elemento) {
                case 0: aluno->matricula = atoi(elemento); break;
                case 1: strcpy(aluno->nome, elemento); break;
                case 2: aluno->notas[0] = atof(elemento); break;
                case 3: aluno->notas[1] = atof(elemento); break;
                default: printf("erro: formatacao de csv provavelmente incorreta\n");
            }
            
            // reseta o tamanho do elemento para comecar a contagem de tamanho do proximo
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
    // abre arquivo
    FILE *f = fopen("alunos.csv", "r");
    if (f == NULL) return;

    // aloca estaticamente variavel temporaria para aluno
    Aluno aluno = {0};
    
    // carrega aluno na variavel temporaria ate o fim do arquivo
    while (carregar_aluno(&aluno, f) > 0) {
        // adiciona aluno lido na lista encadeada
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
    printf("5................relatorio de aluno\n");
    printf("6................relatorio geral\n");
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
    // ponteiro auxiliar recebe endereco do primeiro elemento da dlista
    pAux = &inicio;
    // percorre lista atribuindo ao ponteiro auxiliar o endereco do proximo no
    // ate o final da lista, quando o proximo no e nulo
    while (pAux->pProx) pAux = pAux->pProx;
    
    // ao chegar no fim da lista, alocar espaco no proximo no, que deixara de ser nulo
    pAux->pProx = malloc(sizeof(Aluno));
    // guardar valor de ponteiro auxiliar
    pAnt = pAux;
    // ponteiro auxiliar recebe endereco do proximo no que acabou de ser alocado
    pAux = pAux->pProx;
    // ultimo no tem proximo no definido como nulo, se tornando o ultimo da lista
    pAux->pProx = NULL;
    // ponteiro para aluno anterior recebido de ponteiro salvado anteriormente
    pAux->pAnt = pAnt;

    // copia para ponteiro auxiliar dados de aluno
    memcpy(pAux, &aluno, sizeof(Aluno));
}

/* funcao inserir */
void inserir() {
    Aluno aluno = {0};

    do {
        system("clear");
        printf("-------------- cadastro --------------\n");

        // aloca buffer temporario
        char buffer[BUFFER_MAX];

        // recebe dados do usuario
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

        // processa media aritmetica
        aluno.notas[2] = (aluno.notas[0] + aluno.notas[1]) / 2;
        
        // adiciona aluno a lista encadeada
        adicionar(aluno);

        // salva dados de aluno em arquivo
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

    // atribui para o ponteiro auxiliar endereco do inicio da lisa
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

            if (pAux->pProx) pAux->pProx->pAnt = pAnt;

            pAux->pProx = NULL;
            pAux->pAnt = NULL;

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

    // percorrer lista enquanto a matricula do no atual nao for igual a matricula recebida do usuario
    // e o ponteiro auxiliar nao estiver no fim da lista
    while (pAux->matricula != matTemp && pAux->pProx != NULL) {
        pAnt = pAux;
        pAux = pAux->pProx;
    }

    // caso matricula tenha sido encontrada
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
    } else { // caso matricula nao encontrada
        printf("matricula inexistente\n");
        getchar();
        pAnt = NULL;
        pAux = NULL;
    }
}

/* relatorio geral */
void relatorio_geral() {
    // limpa tela
    system("clear");

    // aloca string temporaria para entrada de dados do usuario
    char buffer[BUFFER_MAX];
    FILE *f;

    printf("gerar arquivo de relatorio? sim(s) nao(n): ");
    // entrada de dados do usuario
    fgets(buffer, BUFFER_MAX, stdin);

    if (toupper(buffer[0]) == 'S') {
        f = fopen("relatorio_alunos.txt", "w");
        fprintf(f, "---------------- diario ----------------\n");
        fprintf(f, "\t professor: %s\n", professor);
        fprintf(f, "\tdisciplina: %s\n", disciplina);
        fprintf(f, "\t     turma: %s\n", turma);
        fprintf(f, "---------------- alunos ----------------\n");
    }

    printf("---------------- diario ----------------\n");
    printf("\t professor: %s\n", professor);
    printf("\tdisciplina: %s\n", disciplina);
    printf("\t     turma: %s\n", turma);
    printf("---------------- alunos ----------------\n");

    // ponteiro auxiliar recebe endereco do inicio da lista encadeada
    pAux = &inicio;

    // percorrer lista enquanto a matricula do no atual nao for igual a matricula recebida do usuario
    // e o ponteiro auxiliar nao estiver no fim da lista
    while (pAux->pProx != NULL) {
        // imprimir relatorio de aluno encontrado
        printf("+ nome: %s\n\n", pAux->nome);
        printf("\tmatricula: %d\n", pAux->matricula);
        printf("\t   nota 1: %.2f\n", pAux->notas[0]);
        printf("\t   nota 2: %.2f\n", pAux->notas[1]);
        printf("\t    media: %.2f\n", pAux->notas[2]);
        printf("----------------------------------------\n");

        if (toupper(buffer[0]) == 'S') {
            // gerar arquivo texto com o relatorio
            fprintf(f, "nome: %s\n\n", pAux->nome);
            fprintf(f, "\tmatricula: %d\n", pAux->matricula);
            fprintf(f, "\t   nota 1: %.2f\n", pAux->notas[0]);
            fprintf(f, "\t   nota 2: %.2f\n", pAux->notas[1]);
            fprintf(f, "\t    media: %.2f\n", pAux->notas[2]);
            fprintf(f, "----------------------------------------\n");
        }
    
        // ponteiro de no anterior recebe endereco do no atual
        pAnt = pAux;
        // ponteiro auxiliar recebe endereco do proximo no
        pAux = pAux->pProx;
    }

    // fecha arquivo caso o mesmo haja sido aberto previamente
    if (toupper(*buffer) == 'S') {
        printf("relatorio gerado com sucesso!\n");
        fclose(f);
    }
    
    printf("pressione qualquer tecla para continuar!\n");
    getchar();
}

/* relatorio de aluno */
void relatorio() {
    // limpa tela
    system("clear");

    printf("-------------- relatorio --------------\n");
    printf("matricula: ");

    // aloca string temporaria para entrada de dados do usuario
    char buffer[BUFFER_MAX];
    // entrada de dados do usuario
    fgets(buffer, BUFFER_MAX, stdin);
    // converte o que o usuario entra para inteiro
    matTemp = atoi(buffer);

    // ponteiro auxiliar recebe endereco do inicio da lista encadeada
    pAux = &inicio;

    // percorrer lista enquanto a matricula do no atual nao for igual a matricula recebida do usuario
    // e o ponteiro auxiliar nao estiver no fim da lista
    while (pAux->matricula != matTemp && pAux->pProx != NULL) {
        pAnt = pAux;
        pAux = pAux->pProx;
    }
    
    if (pAux->matricula == matTemp) {
        // imprimir relatorio de aluno encontrado
        printf("---------------------------------------\n");
        printf("+ nome: %s\n\n", pAux->nome);
        printf("\tmatricula: %d\n", pAux->matricula);
        printf("\t   nota 1: %.2f\n", pAux->notas[0]);
        printf("\t   nota 2: %.2f\n", pAux->notas[1]);
        printf("\t    media: %.2f\n", pAux->notas[2]);
        printf("---------------------------------------\n");

        printf("gerar arquivo de relatorio ? sim(s) nao(n): ");
        fgets(buffer, BUFFER_MAX, stdin);

        if (toupper(*buffer) == 'S') {
            // gerar arquivo texto com o relatorio
            sprintf(buffer, "relatorio_%d.txt", pAux->matricula);
            FILE *f = fopen(buffer, "w");
            fprintf(f, "---------------------------------------\n");
            fprintf(f, "relatorio de aluno\n");
            fprintf(f, "---------------------------------------\n");
            fprintf(f, "nome: %s\n\n", pAux->nome);
            fprintf(f, "\tmatricula: %d\n", pAux->matricula);
            fprintf(f, "\t   nota 1: %.2f\n", pAux->notas[0]);
            fprintf(f, "\t   nota 2: %.2f\n", pAux->notas[1]);
            fprintf(f, "\t    media: %.2f\n", pAux->notas[2]);
            fprintf(f, "---------------------------------------\n");
            fclose(f);
            printf("relatorio gerado com sucesso!\n");
            getchar();
        }
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
            if(opcao < 0 || opcao > 6){
                opcao = -1;
                printf("opcao invalida!\n");
                getchar();
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
            case 5:
                relatorio();
                break;
            case 6:
                relatorio_geral();
                break;
            default:
                printf("\nopcao invalida\n");
                getchar();
        }
    } while (opcao != 0);
}
