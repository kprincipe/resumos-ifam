# Listas Lineares

## Declaração de Estrutura
Uma lista cadeada simples possui o dado a ser armazenado e um ponteiro que referencia o próximo _nó_ da lista. Essencialmente varios "nós" um apontando para o outro onde cada um possui um dado armazenado.
```c
struct Lista {
    float nota;
    struct Lista *prox_nota;
} Lista;
```

## Instanciação e Preenchimento
Declara-se primeiro o _nó_ inicial da lista, e atribui-se `NULL` para o ponteiro do proximo nó da lista. Desse modo, ao percorrer toda a lista, sabe-se onde interromper o loop sem acessar memória nula.
```c
// declaracao de uma lista encadeada simples que será vazia a priori
Lista inicio = {0};
inicio.prox_nota = NULL;

// valor temporario que sera armazenado em cada no
float valor;
char resp[16];

// ponteiro que ira percorrer todos os nos
Lista *no_atual = &inicio;

do {
    // aloca memoria para o proximo nodo
    no_atual->prox_nota = malloc(sizeof(Lista));
    printf("digite a nota: ");
    scanf("%f", &valor);
    // atribui o valor digitado ao nodo atual
    no_atual->nota = valor;
    // aponta ponteiro 'no' para o proximo no da lista
    no_atual = no_atual->prox_nota;
    // atribui 'NULL' para o proximo nodo, indicando que o no atual e o ultimo da lista
    no_atual->prox_nota = NULL;

    printf("deseja continuar? (s/n): ");
    getchar();
    fgets(resp, 16, stdin);
} while (*resp == 's' || *resp == 'S');
```

## Percorrer Lista
```c
// aponta 'no_atual' para o inicio da lista (primeiro nó)
no_atual = &inicio;

// enquanto proximo nó não for null (ultimo nó da lista), continuar repetição
while (no_atual->prox_nota != NULL) {
    // imprime valor do nó atual
    printf("Nota: %.2f\n", no->nota);
    // aponta 'no_atual' para o proximo nó da lista
    no_atual = no_atual->prox_nota;
}
```
