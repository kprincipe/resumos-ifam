MDC=pandoc
FLAGS=--from markdown --to pdf --toc -o

.PHONY: clean

all: plano_de_negocio.pdf pitch_treino.pdf

plano_de_negocio.pdf: plano_de_negocio.md
	$(MDC) plano_de_negocio.md $(FLAGS) plano_de_negocio.pdf

pitch_treino.pdf: pitch_treino.md
	$(MDC) pitch_treino.md $(FLAGS) pitch_treino.pdf

clean:
	rm *.pdf
