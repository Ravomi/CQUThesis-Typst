MAIN = main

.PHONY: all watch blind clean

all: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).typ cquthesis.typ contents/*.typ ref/refs.bib
	typst compile $(MAIN).typ $(MAIN).pdf

watch:
	typst watch $(MAIN).typ $(MAIN).pdf

blind:
	sed 's/blind-trial: false/blind-trial: true/' $(MAIN).typ > _blind.typ
	typst compile _blind.typ $(MAIN)-blind.pdf
	rm -f _blind.typ

clean:
	rm -f $(MAIN).pdf $(MAIN)-blind.pdf _blind.typ
