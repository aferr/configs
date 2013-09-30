PAPER = paper
TEX = $(wildcard *.tex)

.PHONY: all clean

$(PAPER).pdf: $(TEX) jpaper.cls
	echo $(FIGS)
	pdflatex $(PAPER)
	pdflatex $(PAPER)
	pdflatex $(PAPER)

clean:
	rm -f *.aux *.bbl *.blg *.log *.out $(PAPER).pdf

