PACKAGE_NAME = emojione

INS = emojione.ins
DTX = emojione.dtx
STY = emojione.sty
PDF = emojione.pdf
IMG = $(wildcard pdf/*.pdf)
MD = README.md

CTAN_CONTENT = $(INS) $(DTX) $(PDF) $(MD) $(IMG)

TEXMFHOME = $(shell kpsewhich -var-value=TEXMFHOME)
INSTALL_DIR = $(TEXMFHOME)/tex/latex/emojione
DOC_DIR = $(TEXMFHOME)/doc/latex/emojione
CACHE_DIR = .latex-cache

TEXC := latexmk -xelatex -output-directory=$(CACHE_DIR)

.PHONY: sty doc

all: sty doc

$(STY): $(DTX) $(INS)
	@latex $(INS)

$(PDF): $(STY) $(DTX)
	@$(TEXC) $(DTX)
	@cp $(CACHE_DIR)/$(PDF) .

sty: $(STY)

doc: $(PDF)

clean:
	@git clean -xfd

clean-cache:
	@rm -rf $(CACHE_DIR)

clean-sty:
	@rm -f $(STY)

install: $(STY) $(PDF)
	@mkdir -p $(INSTALL_DIR)
	@cp $(STY) $(INSTALL_DIR)
	@mkdir -p $(INSTALL_DIR)/pdf
	@cp $(IMG) $(INSTALL_DIR)/pdf
	@mkdir -p $(DOC_DIR)
	@cp $(PDF) $(DOC_DIR)

uninstall:
	@rm -f $(addprefix $(INSTALL_DIR)/, $(STY))
	@rm -f $(addprefix $(INSTALL_DIR)/, $(IMG))
	@rm -f $(DOC_DIR)/$(PDF)
	@rmdir $(INSTALL_DIR)/pdf
	@rmdir $(INSTALL_DIR)
	@rmdir $(DOC_DIR)

ctan: $(CTAN_CONTENT) ctan-version
	@tar --transform "s@\(.*\)@emojione/\1@" -cf emojione-$(shell date "+%Y-%m-%d").tar.gz $(CTAN_CONTENT)

ctan-version:
	@sed -i 's@\(ProvidesPackage.*\[\)[0-9/]*@\1$(shell date "+%Y/%m/%d")@' $(STY)
