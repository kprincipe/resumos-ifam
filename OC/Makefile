MDC=pandoc
FLAGS=--from markdown --to pdf

.PHONY: clean

all: 01_aula_04_02.pdf 02_aula_11_02.pdf 03_aula_25_02.pdf 04_aula_18_03.pdf 05_aula_22_04.pdf 06_aula_13_05.pdf


01_aula_04_02.pdf: 01_aula_04_02.md
	$(MDC) $(FLAGS) 01_aula_04_02.md -o 01_aula_04_02.pdf

02_aula_11_02.pdf: 02_aula_11_02.md
	$(MDC) $(FLAGS) 02_aula_11_02.md -o 02_aula_11_02.pdf

03_aula_25_02.pdf: 03_aula_25_02.md
	$(MDC) $(FLAGS) 03_aula_25_02.md -o 03_aula_25_02.pdf

04_aula_18_03.pdf: 04_aula_18_03.md
	$(MDC) $(FLAGS) 04_aula_18_03.md -o 04_aula_18_03.pdf

05_aula_22_04.pdf: 05_aula_22_04.md
	$(MDC) $(FLAGS) 05_aula_22_04.md -o 05_aula_22_04.pdf

06_aula_13_05.pdf: 06_aula_13_05.md
	$(MDC) $(FLAGS) 06_aula_13_05.md -o 06_aula_13_05.pdf

clean:
	rm *.pdf
