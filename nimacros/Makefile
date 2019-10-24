D=
PDF_ARGS = -V geometry:margin=1in -V documentclass=report
SYNTAX= --syntax-definition nimrod.xml

ifeq ($(D),)
abort:
	@echo Usage: make D=document
endif

all:
	pandoc $(PDF_ARGS) chaps/*.md  $(D).md $(SYNTAX) -o $(D).pdf
clean:
	rm -rf $(D).pdf

