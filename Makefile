RM=rm -f
EMACS=emacs
NETBSD=true

nSOURCE=resume.org
TARGETS=hist-first sysadmin techwriting dev qa data


all: tex pdf ascii html odt docx rtf md dvi

org: $(addsuffix .m4,$(TARGETS))
	m4 $< > $@

md: org
	$(EMACS) --script build.el $< md

odt: org
	pandoc --from=org --to=odt --output=$@ $<

html: org
	$(EMACS) --script build.el $< html

ascii: org
	$(EMACS) --script build.el $< ascii

rtf: md
	pandoc --standalone --from=markdown --to=rtf --output=$@ $<

docx: md
	pandoc --from=markdown --to=docx --output=$@ $<

tex: org
	$(EMACS) --script build.el $< latex

dvi: texlatex
	latex $<

pdf: tex
	pdflatex $<

# Doesn't work properly on Windows without the right rm in the path
very-clean:	clean
	rm -rf *.tex *.pdf *.html *.txt *.odt resume.md *.docx *.rtf *.dvi *.md *.org

clean:	
	rm -rf *.aux *.log *.out *.*~ *~ *.pdf *.tex *.org
