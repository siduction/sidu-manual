#!/bin/sh

# Name "md2html5.sh"
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2021, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Verwendung für das siduktion Handbuch.
# Erzeugung einzelner .html-Dokumente aus den .md-Dateien
# des Ordners "sidu-manual/data/de/"
#
# Aufruf:
# in den Ordner /data/de/ wechselt und "../../development/md2html5.sh" eingeben.
# Die Pfade bei Abweichungen an die individuellen Gegebenheiten angepassen.
#

if [ ! -d ../de_html/ ]
then
   mkdir ../de_html/
fi

mkdir ../../arbeit/ && cp ./* ../../arbeit/ 2>/dev/null

cd ../../arbeit/ 

for i in *;
do
    ../development/md2html_pre.pl "$i" && pandoc -s --template=../development/pandoc_template.html5 --toc --toc-depth=4 "$i" -o ../data/de_html/$(basename $i .md).html;
done

cd ../data/de/

rm -r ../../arbeit/ 2>/dev/null

