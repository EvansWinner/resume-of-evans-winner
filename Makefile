SOURCE=resume.org

all:	latex pdf ascii html odt docx rtf md

md:	
	pandoc --from=org --to=markdown --output=resume.md $(SOURCE)

odt:	
	pandoc --from=org --to=odt --output=resume.odt $(SOURCE)

html:	
	emacs --script build.el $(SOURCE) html

ascii:	
	emacs --script build.el $(SOURCE) ascii

rtf:	
	pandoc --standalone --from=org --to=rtf --output=resume.rtf $(SOURCE)

docx:	
	pandoc --from=org --to=docx --output=resume.docx $(SOURCE)

latex:	
	emacs --script build.el $(SOURCE) latex

pdf:	latex
	lualatex resume.tex

very-clean:	clean
	rm -rf *.tex *.pdf *.html *.txt *.odt resume.md *.docx *.rtf

clean:	
	rm -rf *.aux *.log *.out *.*~
