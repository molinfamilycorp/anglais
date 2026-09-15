SRC    := $(wildcard fiches/fiche*.tex)
NOMS   := $(notdir $(basename $(SRC)))
PDFS   := $(addprefix pdf/,$(addsuffix -enonce.pdf,$(NOMS)) $(addsuffix -corrige.pdf,$(NOMS)))
TEXOPT := -interaction=nonstopmode -halt-on-error -output-directory=build

all: $(PDFS)

pdf/%-enonce.pdf: fiches/%.tex fiche.cls
	@mkdir -p build pdf
	pdflatex $(TEXOPT) -jobname=$*-enonce "\input{$<}"
	pdflatex $(TEXOPT) -jobname=$*-enonce "\input{$<}"
	@cp build/$*-enonce.pdf $@

pdf/%-corrige.pdf: fiches/%.tex fiche.cls
	@mkdir -p build pdf
	pdflatex $(TEXOPT) -jobname=$*-corrige "\PassOptionsToClass{corrige}{fiche}\input{$<}"
	pdflatex $(TEXOPT) -jobname=$*-corrige "\PassOptionsToClass{corrige}{fiche}\input{$<}"
	@cp build/$*-corrige.pdf $@

clean:
	rm -rf build

.PHONY: all clean
