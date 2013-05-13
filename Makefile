# This work is dedicated to the public domain.

default: thesis.pdf # default target if you just type "make"


# Resources and rules for the introductory chapter. Sample 'make' rule
# included to show how you can process data as you compile your thesis
# using standard GNU make constructs.

deps += intro/intro.tex # intro/processed.tex
cleans += intro/intro.aux # intro/processed.tex

# intro/processed.tex: intro/sample.tex
# 	sed -e s/terrible/wonderful/ $< >$@


## Chapters

deps += mechanism/mechanism.tex
cleans += mechanism/mechanism.aux

deps += two-routes-estimation/two-routes-estimation.tex
cleans += two-routes-estimation/two-routes-estimation.aux

deps += pro-ndi/pro-ndi.tex
cleans += pro-ndi/pro-ndi.aux

deps += evil-ndi/evil-ndi.tex
cleans += evil-ndi/evil-ndi.aux



# These should get re-factored into proper chapters
deps += experimental-description/experimental-aims.tex experimental-description/experimental-plan.tex
cleans += experimental-description/experimental-aims.aux experimental-description/experimental-plan.aux

## Appendices

deps += appendices/graphical-models/graphical-models.tex \
		appendices/kappa-extension/kappa-extension.tex \
		appendices/400words/400words.tex \
		appendices/survey-items/survey-items.tex \
		appendices/numbers/numbers.tex \
		appendices/NDI-intervention/NDI-intervention.tex \
		appendices/coding/codingpacket-blind-Oct26.pdf \
		appendices/coding/coding.tex

cleans += graphical-models/graphical-models.aux \
		appendices/kappa-extension/kappa-extension.aux \
		appendices/400words/400words.aux \
		appendices/survey-items/survey-items.aux \
		appendices/numbers/numbers.aux \
		appendices/NDI-intervention/NDI-intervention.aux \
		appendices/coding/coding.aux

# The thesis itself. We move the PDF to a new filename so that viewers
# don't keep on trying to reload the file as it's being written and
# rewritten by pdfLaTeX.

deps += myucthesis.cls uct12.clo
bibdeps = setup.tex fixed.bib thesis.bib
cleans += thesis.pdf setup.aux
toplevels += thesis.pdf

thesis.pdf: thesis.tex $(deps) $(bibdeps)
	lualatex -synctex=1 --file-line-error thesis

latexmk: thesis.tex $(deps)
	latexmk -pdf -pdflatex="lualatex -synctex=1 --file-line-error %O %S" -bibtex thesis


# Approval page

cleans += approvalpage.aux approvalpage.log approvalpage.pdf
toplevels += approvalpage.pdf

approvalpage.pdf: approvalpage.tex $(deps)
	latexmk -xelatex -bibtex approvalpage


# Helpers

# This is a copy from my proposal... not tested yet! You'll still need to copy
# over the python file, etc.
diff:
	./git_texdiff.py proposal_diff_base
	cd diff
	latexmk -pdf -bibtex thesis-proposal.tex
	# -bibtex required to delete *.bbl files
	latexmk -bibtex -c
	cd ..

all: $(toplevels)

clean:
	latexmk -bibtex -c
	-rm -f $(cleans)
