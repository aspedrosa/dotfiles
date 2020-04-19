#!/bin/bash

function compile() {
    for i in $(seq 1 $1) ; do
        pdflatex $2
    done
}

tex_filename=$(ls | grep \\.tex)
count_tex_files=$(ls | grep -c \\.tex)

if [[ $tex_filename == "" ]] ; then
    echo "No .tex file on current folder"
    exit 1
elif [[ $count_tex_files -gt 1 ]] ; then
    echo "Multiple .tex files on current folder"
    exit 2
fi

# remove .tex from file name
tex_filename=${tex_filename:0:-4} # specific to zsh. bash -> ${var::-4}

compile 1 $tex_filename

bibtex $tex_filename
if [[ $? -ne 0 ]] ; then
    echo "Bibtex errors"
    exit 4
fi

compile 2 $tex_filename
