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
# "../../development/menue-extract.pl" eingeben.
# Das erstellte Menue mit dem Namen
# "tree-menue.html"
# befinden sich dann im Ordner data/de/html/.
#
use strict;
use File::Basename;

my ($FILE, $NR, $EBENE1, $EBENE2, $CLASS, $TEXT, $LINK, $LINK2, $LINK1);
my (@DATEIEN, @QUELLE, @LAGER, @MENU_FILE);

######## HTML Anfang erzeugen

open HEADER, "../../development/tree-menue-header.html"
    or die "Kann HTML-Header nicht öffnen. ($1)";

while (<HEADER>) {
    push @MENU_FILE, "$_";
}

close HEADER;

######## Dateien des Ordners einlesen und einzeln verarbeiten.

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

######## Beginn Überschriften auswerten.
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
            $LINK1 = "\t\t\t<li>$LINK1</li>\n";
            push @MENU_FILE, "\t<li class=\"versteckt\">\n\t\t<input type=\"checkbox\" id=\"M$EBENE1\"/>\n\t\t<label for=\"M$EBENE1\">$TEXT</label>\n\t\t<ul>\n$LINK1";
            next;
         }   
         
        if (/^# / && $#LAGER > 0) {
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

            } elsif (/^## /) {            # Hier Überschrift Klasse ##
                $EBENE2 ++;
                &LINK_LINE;
                $LINK2 = "\t\t\t\t\t<li>$LINK2</li>\n";
                push @MENU_FILE, "\t\t\t<li class=\"versteckt\">\n\t\t\t\t<input type=\"checkbox\" id=\"M$EBENE1" . "_" . "$EBENE2\"/>\n\t\t\t\t<label for=\"M$EBENE1" . "_" . "$EBENE2\">$TEXT</label>\n\t\t\t\t<ul>\n$LINK2";
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
                $LINK2 = "\t\t\t\t\t<li>$LINK2</li>\n";
                push @MENU_FILE, "\t\t\t<li class=\"versteckt\">\n\t\t\t\t<input type=\"checkbox\" id=\"M$EBENE1" . "_" . "$EBENE2\"/>\n\t\t\t\t<label for=\"M$EBENE1" . "_" . "$EBENE2\">$TEXT</label>\n\t\t\t\t<ul>\n$LINK2";
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

push @MENU_FILE, "\t\t</ul>\n\t</li>\n</ul>\n</body>\n</html>\n";

sub LINK_LINE {
                # Zeilen zerlegen und neu zusammensetzen.
        $CLASS = $_;
        $CLASS =~ s/^(#{1,3}) .*/$1/;

        $TEXT = $_;
        $TEXT =~ s/^#{1,3} (.*)/$1/;
        
        $LINK = "$FILE\#$TEXT";
        $LINK =~ s!(.*)!\L$1!;
        $LINK =~ s!( )!-!g;
        $LINK = "<a target= \"main\" href=\"$LINK\">$TEXT</a>";
        $LINK1 = "<a target= \"main\" href=\"$FILE\">$TEXT</a>";
        
        $LINK2 = "$FILE";
        $LINK2 =~ s!(.*)!\L$1!;
        $LINK2 =~ s!( )!-!g;
        $LINK2 = "<a target= \"main\" href=\"$LINK2\">$TEXT</a>";
}

######## In Ausgabedateien schreiben.
# (Für Testzwecke auf der Konsole auskommentieren.)

open (DATEI, ">", "./html/tree-menue.html") || die "Kann nicht schreiben.\n";
    print DATEI @MENU_FILE;
close(DATEI);

__END__
