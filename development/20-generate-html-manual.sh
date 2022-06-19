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
#  Normaly it is called by 00-generate-manual.pl
#  If you want to use this file directly, then change as user
#  in a terminal into the folder /development.
#  Enter the program name and, separated by space, the two-letter shortcode
#  for the language in which the manual should be created. The language shortcode
#  must correspond to the names of the subfolder in /data.
#  Example: ./20-generate-html-manual.sh en
#
#

### General tests
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


### Create necessary folders.
if [ ! -d ../data/$langcode/html/ ]
then
   mkdir ../data/$langcode/html/
fi

if [ ! -d ../work/ ]
then
   mkdir ../work/ || exit 1
fi


### Copy files to ../work
cp ../data/$langcode/0* ../work/ 2>/dev/null


### Create the html-files
for i in ../work/*;
do
    ./21-preparation-html-manual.pl "$i" && pandoc -s --template=./22-template-html-manual.html --toc --toc-depth=4 "$i" -o ../data/$langcode/html/$(basename $i .md | sed 's#[[:digit:]]\{4\}-\(.*\)#\1.html#');
done


### Set language in html header, expand external link with 'target="_blank" ', and
for i in ../data/$langcode/html/*.html;
do
    sed -i -e "2 s/\"\"/\"$langcode\"/g" "$i" -e 's/<a\( href="http\)/<a target="_blank"\1/g';
    
### recode german special characters
    if [ "$langcode" = "de" ]
    then
        sed -i -e 's/ä/\&auml;/g' -e 's/Ä/\&Auml;/g' -e 's/ö/\&ouml;/g' -e 's/Ö/\&Ouml;/g' -e 's/ü/\&uuml;/g' -e 's/Ü/\&Uuml;/g' -e 's/ß/\&szlig;/g' "$i";
    fi
done


### Remove the folder ../work
rm -r ../work/ 2>/dev/null

