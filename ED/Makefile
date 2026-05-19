MDC=?
FLAGS=?

.PHONY: clean

all: ponteiros.pdf listas_lineares.pdf

ponteiros.pdf: ponteiros.md
	$(MDC) ponteiros.md $(FLAGS) ponteiros.pdf

listas_lineares.pdf: listas_lineares.md
	$(MDC) listas_lineares.md $(FLAGS) listas_lineares.pdf

clean:
	@rm *.pdf
