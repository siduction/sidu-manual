#!/bin/sh

# Ausführen im Verzeichnis der .md Dateien.
# Run in the directory of the .md files.

ORDNER=$(pwd | sed 's#.*/##')

grep -oh -P '\(\d{4}-.*?\)' 0* | sort | uniq > ~/LINK

grep -oh -P '\(\d{4}-.*?\)' ../../development/headinglinks-$ORDNER |sort | uniq > ~/HEADING

diff ~/HEADING ~/LINK | grep '>'

rm ~/LINK ~/HEADING
