#!/usr/local/pkg/bin/bash

FORMATS="md org odt html ascii latex rtf docx dvi pdf"
RESUMES="hist-first sysadmin techwriting dev qa data"

### Procedures
usage() {
    echo "Usage: $0 resume format"
    echo "     --where resume is one of:"
    echo $RESUMES
    echo "       and format is one of:"
    echo $FORMATS
}

notmember() {
  for word in $1; do
    [[ $word = $2 ]] && return 1
  done
  return 0
}

org() {
    m4 $1.m4 > $1.org
}

md() {
    org $1
    emacs --script build.el $1.org md
}

odt() {
    org $1
    pandoc --from=org --to=odt --output=$1.odt $1.org
}

html() {
    org $1
    emacs --script build.el $1.org html
}

ascii() {
    org $1
    emacs --script build.el $1.org ascii
}

make-latex() {
    org $1
    emacs --script build.el $1.org latex
}

rtf() {
    md $1
    pandoc --standalone --from=markdown --to=rtf --output=$1.rtf $1.md
}

docx() {
    md $1
    pandoc --from=markdown --to=docx --output=$1.docx $1.md
}

pdf() {
    make-latex $1
    pdflatex $1.tex
}

dvi() {
    make-latex $1
    latex $1.tex
}

### Input validation
if [ "$#" -ne 2 ] ; then
    usage;
    exit 1
fi

if notmember "$RESUMES" $1; then 
    usage;
    exit 1
fi

if notmember "$FORMATS" $2; then 
    usage;
    exit 1
fi

### Script
$2 $1
