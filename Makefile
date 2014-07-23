SOURCE=resume.org
EMACS=c:\Users\thorne\bin\Emacs\bin\emacs.exe


all:	latex pdf ascii html odt docx rtf md dvi

md:	
	$(EMACS) --script build.el $(SOURCE) md

odt:	
	pandoc --from=org --to=odt --output=resume.odt $(SOURCE)

html:	
	$(EMACS) --script build.el $(SOURCE) html

ascii:
	$(EMACS)--script build.el $(SOURCE) ascii

rtf:	md
	pandoc --standalone --from=markdown --to=rtf --output=resume.rtf resume.md

docx:	md
	pandoc --from=markdown --to=docx --output=resume.docx resume.md

latex:	
	$(EMACS) --script build.el $(SOURCE) latex

dvi:	latex
	latex resume.tex

pdf:	latex
	pdflatex resume.tex

# Doesn't work properly on Windows without the right rm in the path
very-clean:	clean
	rm -rf *.tex *.pdf *.html *.txt *.odt resume.md *.docx *.rtf *.dvi

clean:	
	rm -rf *.aux *.log *.out *.*~
