SRC    := $(wildcard */fiches/fiche*.tex)
PDFS   := $(foreach f,$(SRC),$(subst /fiches/,/pdf/,$(basename $(f)))-enonce.pdf \
                             $(subst /fiches/,/pdf/,$(basename $(f)))-corrige.pdf)
TEXOPT := -interaction=nonstopmode -halt-on-error

all: $(PDFS)

seconde: $(filter seconde/%,$(PDFS))
troisieme: $(filter troisieme/%,$(PDFS))

# $* vaut par exemple « seconde/pdf/fiche01 » ; on en tire le niveau et le nom.
niveau = $(firstword $(subst /, ,$*))
nom    = $(notdir $*)

.SECONDEXPANSION:

%-enonce.pdf: $$(subst /pdf/,/fiches/,$$*).tex fiche.cls
	@mkdir -p build/$(niveau) $(@D)
	pdflatex $(TEXOPT) -output-directory=build/$(niveau) -jobname=$(nom)-enonce "\input{$<}"
	pdflatex $(TEXOPT) -output-directory=build/$(niveau) -jobname=$(nom)-enonce "\input{$<}"
	@cp build/$(niveau)/$(nom)-enonce.pdf $@

%-corrige.pdf: $$(subst /pdf/,/fiches/,$$*).tex fiche.cls
	@mkdir -p build/$(niveau) $(@D)
	pdflatex $(TEXOPT) -output-directory=build/$(niveau) -jobname=$(nom)-corrige "\PassOptionsToClass{corrige}{fiche}\input{$<}"
	pdflatex $(TEXOPT) -output-directory=build/$(niveau) -jobname=$(nom)-corrige "\PassOptionsToClass{corrige}{fiche}\input{$<}"
	@cp build/$(niveau)/$(nom)-corrige.pdf $@

clean:
	rm -rf build

.PHONY: all seconde troisieme clean
