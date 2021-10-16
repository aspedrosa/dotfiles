#!/bin/bash

tex_filename=$(ls | grep \\.tex)
count_tex_files=$(ls | grep -c \\.tex)

if [[ $tex_filename == "" ]] ; then
    echo "No .tex file on current folder"
    exit 1
elif [[ $count_tex_files -gt 1 ]] ; then
    echo "Multiple .tex files on current folder"
    exit 2
fi

# comple three times
for i in $(seq 1 3) ; do
    pdflatex $tex_filename
    if [[ $? -ne 0 ]] ; then
        echo "Compiling errors"
        exit 3
    fi
done
