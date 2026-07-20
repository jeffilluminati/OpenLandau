LATEXMK := latexmk
FLAGS := -interaction=nonstopmode -halt-on-error -file-line-error
TEXINPUTS := .:./manuscript//:./drivers//:
TEXMFVAR := $(CURDIR)/build/texmf-var
AUDIT_MANUSCRIPT ?= manuscript/chapters
export TEXINPUTS
export TEXMFVAR

CHAPTERS := 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
CHAPTER_TARGETS := $(addprefix chapter-,$(CHAPTERS))
SOURCE_TARGETS := $(addprefix source-,$(CHAPTERS))

.PHONY: all prepare book audit chapters sources fragment-source fragment-translation watch check check-vector clean distclean $(CHAPTER_TARGETS) $(SOURCE_TARGETS)

all: book

prepare:
	mkdir -p build/texmf-var

book: prepare check-vector
	$(LATEXMK) $(FLAGS) quantum-electrodynamics.tex

# REF must point to the owner-local OCR outside the repository. Optional
# AUDIT_MANUSCRIPT=... selects a single canonical fragment for the corrected
# single-file audit mode.
audit:
	@test -n "$(REF)" || { echo 'Usage: make audit REF=/absolute/path/ref-ocr.txt [AUDIT_MANUSCRIPT=manuscript/...translation.en.tex]'; exit 2; }
	@test -r "$(REF)" || { echo 'Reference OCR is missing or unreadable; owner must provide it as an opaque external audit input.'; exit 2; }
	python3 ../tools/similarity-audit.py --manuscript "$(AUDIT_MANUSCRIPT)" "$(REF)"

chapters: $(CHAPTER_TARGETS)

sources: $(SOURCE_TARGETS)

$(CHAPTER_TARGETS): chapter-%: prepare check-vector
	$(LATEXMK) $(FLAGS) -jobname=chapter-$* drivers/chapter-$*.tex

$(SOURCE_TARGETS): source-%: prepare check-vector
	$(LATEXMK) $(FLAGS) -jobname=source-$* drivers/source-$*.tex

fragment-source: prepare check-vector
	@test -n "$(FILE)" || { echo 'Usage: make fragment-source FILE=manuscript/...source.ru.tex'; exit 2; }
	$(LATEXMK) $(FLAGS) -jobname=$(basename $(notdir $(FILE))) -usepretex='\def\FragmentFile{$(FILE)}' drivers/fragment-source.tex

fragment-translation: prepare check-vector
	@test -n "$(FILE)" || { echo 'Usage: make fragment-translation FILE=manuscript/...translation.en.tex'; exit 2; }
	$(LATEXMK) $(FLAGS) -jobname=$(basename $(notdir $(FILE))) -usepretex='\def\FragmentFile{$(FILE)}' drivers/fragment-translation.tex

watch: prepare check-vector
	$(LATEXMK) $(FLAGS) -pvc quantum-electrodynamics.tex

check: check-vector chapters sources

check-vector:
	@if rg -n '\\(includegraphics|includesvg|includepdf|tikzexternalize|pgfimage|epsfig|psfig|includeinkscape)\b|addplot[[:space:]]+graphics' manuscript drivers quantum-electrodynamics.tex openlandau-qed.cls; then \
		echo 'External image inclusion is forbidden.'; exit 1; \
	fi

clean:
	$(LATEXMK) $(FLAGS) -C quantum-electrodynamics.tex $(addprefix drivers/chapter-,$(addsuffix .tex,$(CHAPTERS))) $(addprefix drivers/source-,$(addsuffix .tex,$(CHAPTERS))) drivers/fragment-source.tex drivers/fragment-translation.tex

distclean: clean
	rm -rf build
