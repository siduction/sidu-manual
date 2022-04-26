#!/bin/sh

# Name: 20-generate-html-manual.sh within siduction manual /development folder.
#
# Copyright Axel Konrad (akli) 2022, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Usage for siduktion manual.
# Generation of individual .html documents from the .md files
#
# Usage:
#  Normaly it is called by 000-generate-manual.pl
#  If you want to use this file directly, then change as user
#  in a terminal into the folder /development.
#  Enter the program name and, separated by space, the two-letter shortcode
#  for the language in which the manual should be created. The language shortcode
#  must correspond to the names of the subfolder in /data.
#  Example: ./20-generate-html-manual.sh en
#
#

# General test
#
if [ $# -ne 1 ]
then
    echo "Error: We need exactly one argument."
    exit 1
fi

 
if [ "$1" = "de" ] || [ "$1" = "en" ]   # add new test if an additional language is available
then
    langcode=$1
else
    echo "Language shortcode is not supported."
    exit 1
fi



if [ ! -d ../data/$langcode/html/ ]
then
   mkdir ../data/$langcode/html/
fi

mkdir ../arbeit/ || exit 1

cp ../data/$langcode/0* ../arbeit/ 2>/dev/null

cd ../arbeit/ 

for i in *;
do
    ../development/21-helpfile-html-manual-pre.pl "$i" && pandoc -s --template=../development/22-helpfile-html-manual-template.html --toc --toc-depth=4 "$i" -o ../data/$langcode/html/$(basename $i .md | sed 's#[[:digit:]]\{4\}-\(.*\)#\1.html#');
done

cd ../development/

for i in ../data/de/html/*;
do 
    sed -i 's/ä/\&auml;/g' "$i";
    sed -i 's/Ä/\&Auml;/g' "$i";
    sed -i 's/ö/\&ouml;/g' "$i";
    sed -i 's/Ö/\&Ouml;/g' "$i";
    sed -i 's/ü/\&uuml;/g' "$i";
    sed -i 's/Ü/\&Uuml;/g' "$i";
    sed -i 's/ß/\&szlig;/g' "$i";
done

rm -r ../arbeit/ 2>/dev/null

