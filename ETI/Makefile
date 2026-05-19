MDC=?
FLAGS=?

.PHONY: clean

all: 01_aula_06_02.pdf 02_aula_12_02.pdf

01_aula_06_02.pdf: 01_aula_06_02.md
	$(MDC) 01_aula_06_02.md $(FLAGS) 01_aula_06_02.pdf

02_aula_12_02.md.pdf: 02_aula_12_02.md
	$(MDC) 02_aula_12_02.md $(FLAGS) 02_aula_12_02.pdf

clean:
	@rm *.pdf
