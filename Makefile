MDC=pandoc
FLAGS=--template=../template.tex -s --from markdown --to pdf --toc -o

all: EMP ED OC
	make MDC=$(MDC) FLAGS="$(FLAGS)" -C EMP/
	make MDC=$(MDC) FLAGS="$(FLAGS)" -C ED/
	make MDC=$(MDC) FLAGS="$(FLAGS)" -C OC/

clean:
	make clean -C EMP/
	make clean -C ED/
	make clean -C OC/
