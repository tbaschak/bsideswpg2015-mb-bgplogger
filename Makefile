SRCS		= bsideswpg2015-mb-bgplogger.md
PDFOBJS		= $(SRCS:.md=.pdf)
SLIDEOBJS	= $(SRCS:.md=.html)
PANDOC		= pandoc
PFLAGS		= -t beamer
ORIGIN		= github

.PHONY: all clean slides pdf 

all: clean slides $(PDFOBJS)
	@echo Slides and PDF generated

%.pdf:	%.md
	$(PANDOC) $(PFLAGS) $< -o $@

pdf: cleanpdf $(PDFOBJS)

%.html: %.md
	pandoc -V theme=night -s -S -t revealjs --mathjax -V revealjs-url:https://ciscodude.net/vendor/reveal.js $< -o $@

slides: $(SLIDEOBJS)

clean: cleanpdf cleanslides

cleanpdf:
	@rm -f $(PDFOBJS)

cleanslides:
	@rm -f $(SLIDEOBJS) 

gh-pages: slides pdf
	@git add $(PDFOBJS) $(SLIDEOBJS)
	@git commit -m 'generate latest slides via Makefile'
	@git push -u $(ORIGIN) master
	@git checkout gh-pages
	@git checkout master -- $(SLIDEOBJS)
	@git checkout master -- $(PDFOBJS)
	@git add $(PDFOBJS) $(SLIDEOBJS)
	@git commit -m 'pull in latest generated slides from master branch'
	@git push -u $(ORIGIN) gh-pages
	@git checkout master
	@echo Slides generated and pushed to gh-pages branch
