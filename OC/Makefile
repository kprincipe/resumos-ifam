MDC=?
FLAGS=?

.PHONY: clean

all: introducao.pdf portas_logicas.pdf sistemas_numericos.pdf ciclo_instrucao_interrupcao.pdf organizacao_memoria.pdf


introducao.pdf: introducao.md
	$(MDC) introducao.md $(FLAGS) introducao.pdf

sistemas_numericos.pdf: sistemas_numericos.md
	$(MDC) sistemas_numericos.md $(FLAGS)  sistemas_numericos.pdf

portas_logicas.pdf: portas_logicas.md
	$(MDC) portas_logicas.md $(FLAGS)  portas_logicas.pdf

ciclo_instrucao_interrupcao.pdf: ciclo_instrucao_interrupcao.md
	$(MDC) ciclo_instrucao_interrupcao.md $(FLAGS)  ciclo_instrucao_interrupcao.pdf

organizacao_memoria.pdf: organizacao_memoria.md
	$(MDC) organizacao_memoria.md $(FLAGS)  organizacao_memoria.pdf

clean:
	rm *.pdf
