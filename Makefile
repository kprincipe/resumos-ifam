MDC=pandoc
FLAGS=--metadata-file=../metadata.yaml --template=../template.tex -s --from markdown --to pdf --toc -o

all: segundo-periodo/
	make MDC=$(MDC) FLAGS="$(FLAGS)" -C segundo-periodo/

clean:
	make clean -C segundo-periodo/
