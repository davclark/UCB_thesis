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

deps += assessments-of-ccc/assessments-of-ccc.tex
cleans += assessments-of-ccc/assessments-of-ccc.aux

deps += two-routes-estimation/two-routes-estimation.tex
cleans += two-routes-estimation/two-routes-estimation.aux


# These should get re-factored into proper chapters
deps += experimental-description/experimental-aims.tex experimental-description/experimental-plan.tex
cleans += experimental-description/experimental-aims.aux experimental-description/experimental-plan.aux

## Appendices

deps += graphical-models/graphical-models.tex
cleans += graphical-models/graphical-models.aux

# The thesis itself. We move the PDF to a new filename so that viewers
# don't keep on trying to reload the file as it's being written and
# rewritten by pdfLaTeX.

deps += myucthesis.cls uct12.clo aasmacros.sty mydeluxetable.sty \
  setup.tex fixed.bib proposal.bib yahapj.bst
cleans += thesis.pdf setup.aux .latexwork/*
toplevels += thesis.pdf

thesis.pdf: thesis.tex $(deps)
	./latexdriver -x -l -b $< $@


# Approval page

cleans += approvalpage.aux approvalpage.log approvalpage.pdf
toplevels += approvalpage.pdf

approvalpage.pdf: approvalpage.tex $(deps)
	./latexdriver -x -l $< $@


# Helpers

all: $(toplevels)

clean:
	-rm -f $(cleans)
