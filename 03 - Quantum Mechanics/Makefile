LATEXMK := latexmk
FLAGS := -interaction=nonstopmode -halt-on-error -file-line-error
LATEXMK_OPTS ?=
TEXINPUTS := .:./manuscript//:./drivers//:
TEXMFVAR := $(CURDIR)/build/texmf-var
AUDIT_MANUSCRIPT ?= manuscript/chapters
export TEXINPUTS
export TEXMFVAR

CHAPTERS := 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18
CHAPTER_TARGETS := $(addprefix chapter-,$(CHAPTERS))
SOURCE_TARGETS := $(addprefix source-,$(CHAPTERS))

.PHONY: all prepare book audit chapters sources supplements source-supplements subject-index source-subject-index fragment-source fragment-translation watch check check-vector clean distclean $(CHAPTER_TARGETS) $(SOURCE_TARGETS)

all: book

prepare:
	mkdir -p build/texmf-var

book: prepare check-vector
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) quantum-mechanics.tex

# REF must point to the owner-local OCR outside the repository.  Optional
# CHAPTER="--chapter ch01 --chapter ch02" supports concurrent batch audits.
audit:
	@test -n "$(REF)" || { echo 'Usage: make audit REF=/absolute/path/ref-ocr.txt [CHAPTER="--chapter chNN"]'; exit 2; }
	python3 ../tools/similarity-audit.py "$(REF)" --manuscript "$(AUDIT_MANUSCRIPT)" $(CHAPTER)

chapters: $(CHAPTER_TARGETS)

sources: $(SOURCE_TARGETS)

supplements: prepare check-vector
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -jobname=supplements drivers/supplements.tex

source-supplements: prepare check-vector
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -jobname=source-supplements drivers/source-supplements.tex

subject-index: prepare check-vector
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -jobname=subject-index drivers/subject-index.tex

source-subject-index: prepare check-vector
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -jobname=source-subject-index drivers/source-subject-index.tex

$(CHAPTER_TARGETS): chapter-%: prepare check-vector
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -jobname=chapter-$* drivers/chapter-$*.tex

$(SOURCE_TARGETS): source-%: prepare check-vector
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -jobname=source-$* drivers/source-$*.tex

fragment-source: prepare check-vector
	@test -n "$(FILE)" || { echo 'Usage: make fragment-source FILE=manuscript/...source.ru.tex'; exit 2; }
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -jobname=$(basename $(notdir $(FILE))) -usepretex='\def\FragmentFile{$(FILE)}' drivers/fragment-source.tex

fragment-translation: prepare check-vector
	@test -n "$(FILE)" || { echo 'Usage: make fragment-translation FILE=manuscript/...translation.en.tex'; exit 2; }
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -jobname=$(basename $(notdir $(FILE))) -usepretex='\def\FragmentFile{$(FILE)}' drivers/fragment-translation.tex

watch: prepare check-vector
	$(LATEXMK) $(FLAGS) $(LATEXMK_OPTS) -pvc quantum-mechanics.tex

check: check-vector chapters sources supplements source-supplements subject-index source-subject-index

check-vector:
	@if rg -n '\\(includegraphics|includesvg|includepdf|tikzexternalize|pgfimage|epsfig|psfig|includeinkscape)\b|addplot[[:space:]]+graphics' manuscript drivers quantum-mechanics.tex openlandau-qm.cls; then \
		echo 'External image inclusion is forbidden.'; exit 1; \
	fi

clean:
	$(LATEXMK) $(FLAGS) -C quantum-mechanics.tex $(addprefix drivers/chapter-,$(addsuffix .tex,$(CHAPTERS))) $(addprefix drivers/source-,$(addsuffix .tex,$(CHAPTERS))) drivers/supplements.tex drivers/source-supplements.tex drivers/subject-index.tex drivers/source-subject-index.tex drivers/fragment-source.tex drivers/fragment-translation.tex

distclean: clean
	rm -rf build
