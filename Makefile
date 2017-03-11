UML_SRC_FILES:=$(wildcard *.iuml)
UML_PDF_FILES:=$(patsubst %.iuml,%.pdf,${UML_SRC_FILES})

DOT_SRC_FILES = $(wildcard *.dot)
DOT_PDF_FILES = $(patsubst %.dot,%.pdf,${DOT_SRC_FILES})

default : ${DOT_PDF_FILES} ${UML_PDF_FILES}


${DOT_PDF_FILES} : %.pdf : %.dot
	dot -Tpdf -Gdpi=300 $< > $@

${UML_PDF_FILES} : %.pdf : %.iuml
	cat $< | plantuml -p -teps -nbthread auto | epstopdf --filter > $@

.PHONY : default clean

default : ${TEX_PDF_FILES} ${UML_PDF_FILES}

clean : 
	rm *.png *.dvi *.pdf
