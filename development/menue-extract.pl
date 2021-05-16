#!/usr/bin/perl -w
#
# Name: menue-extract.pl
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2021, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Verwendung für das siduktion Handbuch.
# Extrahieren der Überschriften aus den .md-Dateien des Ordners
# "sidu-manual/data/de/", um daraus ein Menue für die HTML-Seiten
# zu formen. Es werden ausschließlich nummerierte Dateien ausgewertet.
# 
# Aufruf: In den Ordner data/de/ wechseln und
# "../../development/menue-extract.pl." eingeben.
# Das erstellte Menue mit dem Namen
# "tree-menue.html"
# befinden sich dann im Ordner data/de/html/.
#
use strict;
use File::Basename;

my ($FILE, $NR, $EBENE1, $EBENE2, $CLASS, $TEXT, $LINK, $LINK2);
my (@DATEIEN, @QUELLE, @LAGER, @MENU_FILE);


######## Dateien des Ordners einlesen und einzeln verarbeiten.

push @MENU_FILE, "<ul id=\"treeMenu\">\n";

@DATEIEN = glob "*";

while (@DATEIEN) {
    $_ = shift @DATEIEN;
    chomp($_);
    next unless (/^\d{4}-.*/);
    $FILE = $_;
    $FILE =~ s!^\d{4}-(.*)\.md!$1\.html!;
        
    open(DATEI, "$_") || die "$_ nicht gefunden\n";
    @QUELLE=<DATEI>;
    close(DATEI);
    $NR ++;

######## Beginn Überschriften suchen.
    while (@QUELLE) {
        $_ = shift @QUELLE;
    
        if (/^~{3,}/) {
                # Code-Blöcke vollständig entfernen.
            $_ = shift @QUELLE;
            until (/^~{3,}/) {
                $_ = shift @QUELLE;
            }
            $_ = shift @QUELLE;
        }
                # Alles außer Überschriften Klasse #-### verwerfen.
        next unless /^#{1,3} /;
        push @LAGER , "$_";
    }

    START: while (@LAGER) {
        $_ = shift @LAGER;
        chomp($_);
        
        if (/^# /) {
            if ($NR > 1) {
                push @MENU_FILE, "\t\t</ul>\n\t</li>\n";
            }    
            $EBENE1 ++;
            $EBENE2 = 0;
            &LINK_LINE;
            push @MENU_FILE, "\t<li><label for=\"M$EBENE1 class=\"open\">$TEXT</label>\n\t\t  <input name=\"tree\"  id=\"M$EBENE1\" type=\"checkbox\" />\n\t\t<ul>\n";
            $_ = shift @LAGER;
            chomp($_);
            
            if (/^### /) {
                &LINK_LINE;
                $LINK = "\t\t\t<li>$LINK</li>\n";
                while (@LAGER) {
                    $_ = shift @LAGER;
                    if (/^### /) {
                    chomp($_);
                        &LINK_LINE;
                        $LINK = "\t\t\t<li>$LINK</li>\n";
                        push @MENU_FILE, "$LINK";
                    } else {
                        unshift @LAGER, $_;
                        push @MENU_FILE, "\t\t</ul>\n\t</li>\n";
                        next START;
                    }
                }
                push @MENU_FILE, "\t\t</ul>\n\t</li>\n";
            } else {            # Hier Überschrift Klasse ##
                $EBENE2 ++;
                &LINK_LINE;
                push @MENU_FILE, "\t\t\t<li><label for=\"M$EBENE1" . "_" . "$EBENE2 class=\"open\">$LINK2</label>\n\t\t\t\t  <input name=\"tree\"  id=\"M$EBENE1" . "_" . "$EBENE2\" type=\"checkbox\" />\n\t\t\t\t<ul>\n";
                while (@LAGER) {
                    $_ = shift @LAGER;
                    if (/^### /) {
                        chomp($_);
                        &LINK_LINE;
                        $LINK = "\t\t\t\t\t<li>$LINK</li>\n";
                        push @MENU_FILE, "$LINK";
                    } else {
                        push @MENU_FILE, "\t\t\t\t</ul>\n\t\t\t</li>\n";
                        unshift @LAGER, $_;
                        $EBENE2 = 0;
                        next START;
                    }
                }
                push @MENU_FILE, "\t\t\t\t</ul>\n\t\t\t</li>\n";
            }
        } else {
            $EBENE2 ++;
            &LINK_LINE;
            push @MENU_FILE, "\t\t\t<li><label for=\"M$EBENE1" . "_" . "$EBENE2 class=\"open\">$LINK2</label>\n\t\t\t\t  <input name=\"tree\"  id=\"M$EBENE1" . "_" . "$EBENE2\" type=\"checkbox\" />\n\t\t\t\t<ul>\n";
            while (@LAGER) {
                $_ = shift @LAGER;
                if (/^### /) {
                    chomp($_);
                    &LINK_LINE;
                    $LINK = "\t\t\t\t\t<li>$LINK</li>\n";
                    push @MENU_FILE, "$LINK";
                } else {
                    push @MENU_FILE, "\t\t\t\t</ul>\n\t\t\t</li>\n";
                    unshift @LAGER, $_;
                    next START;
                }
            }
            push @MENU_FILE, "\t\t\t\t</ul>\n\t\t\t</li>\n";
        }
    }
}

push @MENU_FILE, "\t\t</ul>\n\t</li>\n</ul>\n";

sub LINK_LINE {
                # Zeilen zerlegen und neu zusammensetzen.
        $CLASS = $_;
        $CLASS =~ s/^(#{1,3}) .*/$1/;

        $TEXT = $_;
        $TEXT =~ s/^#{1,3} (.*)/$1/;
        
        $LINK = "$FILE\#$TEXT";
        $LINK =~ s!(.*)!\L$1!;
        $LINK =~ s!( )!-!g;
        $LINK = "<a href=\"$LINK\">$TEXT</a>";
        $LINK2 = "<a href=\"$FILE\">$TEXT</a>";
}

######## In Ausgabedateien schreiben.
# (Für Testzwecke auf der Konsole auskommentieren.)

open (DATEI, ">", "./html/tree-menue.html") || die "Kann nicht schreiben.\n";
    print DATEI @MENU_FILE;
close(DATEI);

__END__
