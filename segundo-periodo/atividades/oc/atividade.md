# Atividade - Ciclo de busca e acesso à Memória

- Registradores de uso geral: 8 bits
- MAR: 16 bits
- MDR: 8 bits
- Barramento de endereços: 16 bits
- Barramento de dados: 8 bits
- Memória principal endereçada por byte
- Cada instrução possui 24 bits
- Cada dado ocupa 8 bits

## Memória Principal

|Endereço  | Conteúdo |
|----------|----------|
|300       |00010010  |
|301       |01010100  |
|302       |11110000  |
|500       |00101101  |
|501       |00001111  |

## Perguntas
- Considere que `pc = 300` e que a CPU irá buscar uma instrução de `24 bits` armazenada a partir do endereço `300`. Depois, essa instrução acessará o dado armazenado no endereço `500`.

a) Qual registrador recebe inicialmente o endereço da instrução a ser buscada?
    - **Resposta:** O endereço da instrução a ser buscada será inicialmente armazenada no registrador MAR.

b) Como a instrução possui 24 bits e o barramento de dados possui 8 bits, quantos ciclos de leitura serão necessários para buscar a instrução completa?
    - **Resposta:** Será necessário 3 ciclos de leitura para buscar uma instrução.

c) Indique, ciclo a ciclo, quais endereços serão colocados no MAR e quais conteúdos serão carregados no MDR.
    - **Resposta:**

|Ciclo | MAR | MDR/MBR |
|------|-----|---------|
|1     |0    | 
|2     |0    |
|3     |0    |
|4     |1    |
|5     |1    |


d) Após a busca completa, qual será a instrução montada pela CPU em binário?
    - **Resposta:** 

e) Durante o acesso ao dado no endereço 500, qual valor deve ser colocado no MAR?
    - **Resposta:** 

f) Qual conteúdo será lido da memória e colocado no MDR?
    - **Resposta:** 

g) Por qual barramento trafega o endereço 500? E por qual barramento trafega o conteúdo lido?
    - **Resposta:** 

h) Explique por que o tamanho do barramento de dados influencia a quantidade de ciclos necessários para buscar a instrução.
    - **Resposta:** 
