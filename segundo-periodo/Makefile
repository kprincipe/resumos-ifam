MDC=?
FLAGS=?

.PHONY: clean

all: pdf/organizacao-de-computadores.pdf pdf/programacao-orientada-objetos.pdf pdf/estrutura-dados.pdf pdf/modelagem-banco-dados.pdf pdf/empreendedorismo.pdf pdf/modelagem-processos-negocios.pdf

pdf/organizacao-de-computadores.pdf: organizacao-de-computadores.md
	$(MDC) organizacao-de-computadores.md $(FLAGS) pdf/organizacao-de-computadores.pdf

pdf/programacao-orientada-objetos.pdf: programacao-orientada-objetos.md
	$(MDC) programacao-orientada-objetos.md $(FLAGS) pdf/programacao-orientada-objetos.pdf

pdf/estrutura-dados.pdf: estrutura-dados.md
	$(MDC) estrutura-dados.md $(FLAGS) pdf/estrutura-dados.pdf

pdf/modelagem-banco-dados.pdf: modelagem-banco-dados.md
	$(MDC) modelagem-banco-dados.md $(FLAGS) pdf/modelagem-banco-dados.pdf

pdf/empreendedorismo.pdf: empreendedorismo.md
	$(MDC) empreendedorismo.md $(FLAGS) pdf/empreendedorismo.pdf

pdf/modelagem-processos-negocios.pdf: modelagem-processos-negocios.md
	$(MDC) modelagem-processos-negocios.md $(FLAGS) pdf/modelagem-processos-negocios.pdf

clean:
	rm pdf/*.pdf
