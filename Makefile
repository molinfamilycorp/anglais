NIVEAUX := seconde troisieme
TEXOPT  := -interaction=nonstopmode -halt-on-error

all:

# Une paire de règles par niveau. Les motifs contiennent le répertoire : make
# n'applique pas alors sa règle de retrait des répertoires, qui casse les motifs
# génériques sous GNU make 3.81 (celui d'Apple).
define REGLES

$(1)/pdf/%-enonce.pdf: $(1)/fiches/%.tex fiche.cls
	@mkdir -p build/$(1) $(1)/pdf
	pdflatex $$(TEXOPT) -output-directory=build/$(1) -jobname=$$*-enonce "\input{$$<}"
	pdflatex $$(TEXOPT) -output-directory=build/$(1) -jobname=$$*-enonce "\input{$$<}"
	@cp build/$(1)/$$*-enonce.pdf $$@

$(1)/pdf/%-corrige.pdf: $(1)/fiches/%.tex fiche.cls
	@mkdir -p build/$(1) $(1)/pdf
	pdflatex $$(TEXOPT) -output-directory=build/$(1) -jobname=$$*-corrige "\PassOptionsToClass{corrige}{fiche}\input{$$<}"
	pdflatex $$(TEXOPT) -output-directory=build/$(1) -jobname=$$*-corrige "\PassOptionsToClass{corrige}{fiche}\input{$$<}"
	@cp build/$(1)/$$*-corrige.pdf $$@

$(1): $$(patsubst $(1)/fiches/%.tex,$(1)/pdf/%-enonce.pdf,$$(wildcard $(1)/fiches/fiche*.tex)) \
      $$(patsubst $(1)/fiches/%.tex,$(1)/pdf/%-corrige.pdf,$$(wildcard $(1)/fiches/fiche*.tex))

all: $(1)

endef

$(foreach n,$(NIVEAUX),$(eval $(call REGLES,$(n))))

clean:
	rm -rf build

.PHONY: all clean $(NIVEAUX)
