#!/bin/sh

# Name "en-md2html5.sh"
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2021, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Use for the siduction manual.
# Creation of individual .html documents from the .md files
# of the folder "sidu-manual/data/en/"
#
# call:
# change to the folder /data/en/ and enter "../../development/md2html5.sh".
# Adjust the paths to the individual circumstances in case of deviations.
#

if [ ! -d ./html/ ]
then
   mkdir ./html/
fi

mkdir ../../arbeit/ || exit 1

cp ./0* ../../arbeit/ 2>/dev/null

cd ../../arbeit/ 

for i in *;
do
    ../development/md2html_pre.pl "$i" && pandoc -s --template=../development/pandoc_template.html5 --toc --toc-depth=4 "$i" -o ../data/en/html/$(basename $i .md | sed 's#[[:digit:]]\{4\}-\(.*\)#\1.html#');
done

cd ../data/en/

rm -r ../../arbeit/ 2>/dev/null

