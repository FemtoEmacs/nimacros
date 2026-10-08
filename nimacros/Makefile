D=
PDF_ARGS = -V geometry:margin=1in -V documentclass=book
SYNTAX= --syntax-definition nimrod.xml
ENG= --pdf-engine=pdflatex

ifeq ($(D),)
abort:
	@echo Usage: make D=document
endif

all:
	pandoc --standalone $(PDF_ARGS) chaps/*.md $(D).md $(SYNTAX) -o $(D).tex
	pandoc $(PDF_ARGS) chaps/*.md $(D).md $(SYNTAX) $(ENG) -o $(D).pdf
	cp $(D).pdf ../$(D).pdf

.PHONY: all clean
clean:
	rm -rf $(D).pdf

