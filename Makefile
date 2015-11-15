SRCS		= bsideswpg2015-mb-bgplogger.md
PDFOBJS		= $(SRCS:.md=.pdf)
SLIDEOBJS	= $(SRCS:.md=.html)
PANDOC		= pandoc
PFLAGS		= -t beamer
HTMLFLAGS   = -V theme=night -V transition=convex --section-divs -s -S -t revealjs --mathjax -V revealjs-url:https://ciscodude.net/vendor/reveal.js

.PHONY: all clean slides pdf 

all: clean slides $(PDFOBJS)
	@echo Slides and PDF generated

%.pdf:	%.md
	$(PANDOC) $(PFLAGS) $< -o $@

pdf: cleanpdf $(PDFOBJS)

%.html: %.md
	pandoc $(HTMLFLAGS) $< -o $@

slides: $(SLIDEOBJS)

clean: cleanpdf cleanslides

cleanpdf:
	@rm -f $(PDFOBJS)

cleanslides:
	@rm -f $(SLIDEOBJS) 
