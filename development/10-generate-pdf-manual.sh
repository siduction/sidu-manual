#!/bin/sh
#
# Name: 10-generate-pdfmanual.sh within siduction manual /development folder.
#
# Wrapper script around pandoc
# Provides templates to apply with pdf processing
# Copyright Claes Holmerson 2010, GPL licensed (see COPYING for details)
# Copyright Hendrik Lehmbruch 2021, GPL licensed (see COPYING for details)
# Copyright Axel Konrad 2022, GPL licensed (see COPYING for details)
# Added code to generate siduction manual.
#
# COPYING: https://www.gnu.org/licenses/gpl-3.0.html
#
# Usage:
#  Normaly it is called by 000-generate-manual.pl
#  If you want to use this file directly, then change as user
#  in a terminal into the folder /development.
#  Enter the program name and, separated by space, the two-letter shortcode
#  for the language in which the manual should be created. The language shortcode
#  must correspond to the names of the subfolder in /data.
#  Example: ./10-generate-pdfmanual.sh en

# General test and
# country specific page options
if [ "$1" = "de" ]
then
    paper=a4
    language=de-DE
    titel="Siduction Handbuch"
    team="siduction Team"
    datum=$(date +%d.%m.%Y)
elif [ "$1" = "en" ]
then
    paper=letter
    language=en-US
    titel="siduction manual"
    team="siduction team"
    datum=$(LC_ALL=en_US.utf8 date '+%B %d, %Y')
#elif [ "$1" = "it" ]           # New translations dummy
#then
#    paper=a4paper
#    language=it-IT
#    titel="Manuale di siduction"
#    team="siduction team"
#    datum=$(date +%F)
else
    echo "Language shortcode is missing or not supported."
    exit 1
fi

langcode=$1

#hmargin=2cm
#vmargin=3.0cm
#margin=20mm
#fontsize=10pt
#fontsize=11pt
fontsize=12pt
#mainfont=Cambria
#sansfont=Corbel
#monofont=Consolas
mainfont="Liberation Sans"
sansfont="Liberation Sans"
monofont="Liberation Mono"
#language=swedish
nohyphenation=false
linkcolor=blue

columns=onecolumn
#columns=twocolumn

geometry=portrait
#geometry=landscape

#alignment=flushleft
#alignment=flushright
#alignment=center

# directories, based on the fact we use it in folder contain .md-files.
header=./11-helpfile-pdf-manual-header.tex
searchpath=./:../data/$langcode/:../data/$langcode/images/:../sys-images/

# Verarbeiten der Dateien zur Erzeugung des PDF:
#  - Ordner /arbeit anlegen und Dateien kopieren.
#  - Aus dem Ordner /arbeit die Dateiliste erstellen
#  - pandoc (LaTex) Mettatag aus allen Dateien entfernen.
#  - pandoc (LaTex) Mettatag nur in der ersten Datei einfügen.
#  - Dateinamen auf Link anderer Handbuchseiten entfernen.
#  - Ordner für das PDF erstellen.
#  - pandoc ausführen
#  - Den Ordner /arbeit löschen.

mkdir ../arbeit/ || exit 1

cp -pP ../data/$langcode/* ../arbeit/ 2>/dev/null

LISTE=$(ls ../arbeit/[[:digit:]]*)

for i in $LISTE ; do sed -i -E '/^% \w/d' "$i"; done 

sed -i -e "1 i% $titel" -e "1 i% $team" -e "1 i% $datum" ../arbeit/0000-*

for i in $LISTE ; do sed -i -e 's/([-_./[:alnum:]]*de.md#/(#/g' "$i"; done

if [ ! -d ../data/$langcode/pdf ]; then mkdir ../data/$langcode/pdf; fi

pandoc -N --toc --toc-depth=4 -p --pdf-engine=xelatex --listings -H $header --resource-path=$searchpath --highlight-style tango -V language=$language -V papersize=$paper -V hmargin=$hmargin -V vmargin=$vmargin -V linkcolor=$linkcolor -V geometry:margin="$margin" -V mainfont="$mainfont" -V sansfont="$sansfont" -V monofont="$monofont" -V geometry=$geometry -V alignment=$alignment -V columns=$columns -V fontsize=$fontsize -V nohyphenation=$nohyphenation $LISTE -o ../data/$langcode/pdf/siduction-manual_$langcode.pdf

rm -r ../arbeit

