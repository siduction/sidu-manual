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

my ($FILE, $NR, $EBENE1, $EBENE2, $TAB, $TAB2, $CLASS, $TEXT, $ANKER, $LINK, $LINK1);
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

        if (/^# /) {
            if ($NR > 1) {
                push @MENU_FILE, "\t\t</ul>\n\t</li>\n";
            }    
            $EBENE1 ++;
            $EBENE2 = 0;
            $TAB = "\t\t";
            chomp($_);
            &LINK_LINE;
            push @MENU_FILE, "\t<li class=\"versteckt\">\n$TAB<input type=\"checkbox\" id=\"M$EBENE1\"/>\n$TAB<label for=\"M$EBENE1\">$TEXT</label>\n$TAB<ul>\n\t$TAB<li>$LINK1</li>\n";
            next;
        } elsif (/^## /) {
            $EBENE2 ++;
            $TAB = "\t\t\t\t";
            chomp($_);
            &LINK_LINE;
                push @MENU_FILE, "\t\t\t<li class=\"versteckt\">\n$TAB<input type=\"checkbox\" id=\"M$EBENE1" . "_" . "$EBENE2\"/>\n$TAB<label for=\"M$EBENE1" . "_" . "$EBENE2\">$TEXT</label>\n$TAB<ul>\n$TAB\t<li>$LINK1</li>\n";
                next;
        } else {
            unshift @LAGER, $_;
            while (@LAGER) {
                $_ = shift @LAGER;
                if (/^## /) {
                    push @MENU_FILE, "\t$TAB</ul>\n$TAB</li>\n";
                    unshift @LAGER, $_;
                    next START;
                } else {
                    chomp($_);
                    &LINK_LINE;
                    push @MENU_FILE, "$TAB\t<li>$LINK</li>\n";
                }
            }
            if ( $TAB eq "\t\t\t\t") {
                $TAB2 = "\t\t\t";
                push @MENU_FILE, "$TAB</ul>\n$TAB2</li>\n";
            }
        }
    }
}

push @MENU_FILE, "\t\t</ul>\n\t</li>\n</ul>\n</body>\n</html>\n";

sub LINK_LINE {

        # Formatfehler (Leerzeichen am Zeilenende) beseitigen.
        $_ =~ s!^(#{1,3}.*)\s+$!$1!;
        
        # Zeilen zerlegen und neu zusammensetzen.
        $CLASS = $_;
        $CLASS =~ s/^(#{1,3}) .*/$1/;

        $TEXT = $_;
        $TEXT =~ s/^#{1,3} +(.*)/$1/;
        
        $ANKER = $TEXT;
        $ANKER =~ s!(.*)!\L$1!;
        $ANKER =~ s!( )!-!g;
        
        $LINK = "<a target= \"main\" href=\"$FILE\#$ANKER\">$TEXT</a>";
        $LINK1 = "<a target= \"main\" href=\"$FILE\">$TEXT</a>";
}

######## In Ausgabedateien schreiben.
# (Für Testzwecke auf der Konsole auskommentieren.)

open (DATEI, ">", "./html/tree-menue.html") || die "Kann nicht schreiben.\n";
    print DATEI @MENU_FILE;
close(DATEI);

__END__
