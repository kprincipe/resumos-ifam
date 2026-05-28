#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void espacos(int n) {
    for (int i = 0; i < n; ++i) {
        printf("\t");
    }
}

void imprimir_pacote(int numero, int espaco) {
    espacos(espaco);
    printf(",,,,,,,,,\n");
    espacos(espaco);
    if (numero < 10) printf("|   %d   |\n", numero);
    else printf("|  %d   |\n", numero);
    espacos(espaco);
    if (numero < 10) printf("|  %d   |\n", numero);
    else printf("| %d/%d |\n", numero, 18);
    espacos(espaco);
    printf("|      |\n");
    espacos(espaco);
    printf("''''''''\n");
}

void ligacao() {
    printf("    |   \n");
    printf("    V   \n");
}

int main(void) {
    int frame = 0;
    int pacote = 0;

    while (1) {
        system("clear");
        imprimir_pacote(12, frame);
        if (frame == 0) ligacao();
        imprimir_pacote(5, 0);
        ligacao();
        imprimir_pacote(67, 0);
        frame++;
        sleep(1);

        if (frame == 5) break;
    }
}
