#!/usr/bin/perl -w
#
# Name: check-md-file-before-commit.pl
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2022, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Verwendung für das siduktion Handbuch.
# Testet md-Datei auf die richtige Schreibweise des Titels, der
# Überschriften und der internen Link.
# 
# Aufruf:
# Als User in einem Terminal in den Ordner /development wechseln.
# Hier den Programmnamen und als Option die Namen der zu prüfenden
# Datein angeben.
# 
# --------------------------------------------------------------
# 
# Use for siduction manual.
# Tests md file for correct spelling of the title, the
# Headings and the internal link.
# 
# Call:
# As user in a terminal change into the folder /development.
# Enter the program name and as option the names of the files to be tested.
# files to be checked.
#


my ($DATEI, $ZEILE, $NR);
my (@INHALT, @FEHLER);



foreach $DATEI (@ARGV) {

    # Zähler und Fehlerspeicher zurücksetzten.
    $NR = "";
    @FEHLER = ();

    # Datei einlesen.
    open(INPUT, "$DATEI") || die "$_ nicht gefunden\n";
    @INHALT=<INPUT>;
    close(INPUT);
    push @FEHLER, "$DATEI\n";


    # Zeile 1 und 2 auf Titel prüfen.
    $_ = shift (@INHALT);
    chomp($_);  
    $NR++;
    if (!/^%/) {
       push @FEHLER, "\tZeile 1 ist kein Titel >\"$_\"\n";
    }
    $_ = shift (@INHALT);
    chomp($_);
    $NR++;
    unless ($_ eq "") {
        push @FEHLER, "\tZeile 2 ist nicht leer >\"$_\"\n";
    }


    # Alle anderen Zeilen der Reihe nach einlesen. Leerzeilen verwerfen.
    while (@INHALT) {
        $_ = shift @INHALT;
        chomp($_);
        $NR++;
        next if (/\A\s*\Z/);


        # Code Blöcke vollständig entfernen, da der Promt die '#' enthalten kann
        # und die Blöcke nicht verändert werden sollen.
        if (/\A *~{3,}/) {
            $_ = shift @INHALT;
            $NR++;
            until (/\A *~{3,}/) {
                $_ = shift @INHALT;
                $NR++;
            }
            next;
        }


        # Suche nach Überschriften und darin enthaltenen verbotenen Zeichen.
        if (/\A#{1,4}/) {
            if (/[^a-zA-Z_äöüßÄÖÜ0-9 \.\-#]/) {
                push @FEHLER, "\tZeile $NR, Verbotenes Zeichen '$&' in der Überschrift:$_\n";
            }
            next;
        }


        # Suchen nach internen Link in der Zeile.
        if (/\.md/) {
            $ZEILE = $_;
            $ZEILE =~ s!\A.*?(\[.*?\].*?\))(.*)!$2!;
            
            # Prüfen auf Syntaxfehler in der Zeile. (Führt zu leerer Variablen $1.)
            if ( defined ($1) ) {
              $_ = $1;
            } else {
                push @FEHLER, "\tZeile $NR, Syntaxfehler\n";
                next;
            }

            # Externe Link zu .md Dokumenten aussortieren.
            if (/https?/i) {

            # Klammern korrekt gesetzt?
            } elsif ( ! /\[.*?\]\(.*?\)/) {
                push @FEHLER, "\tZeile $NR, Klammerfehler:$_\n";

            # Linktext vorhanden?
            } elsif ( ! /\[.+?\]/) {
                push @FEHLER, "\tZeile $NR, Linktext fehlt:$_\n";

            # Vier Ziffern am Anfang des Dateinamens?
            } elsif ( ! /\(\d{4}.+?\)/) {
                push @FEHLER, "\tZeile $NR, Führende Ziffern im Dateinamen fehlen:$_\n";

            # Ist der Ankerteil im Link vorhanden?
            } elsif ( ! /\.md#.+?\)/) {
                push @FEHLER, "\tZeile $NR, Der Ankerteil im Link fehlt:$_\n";
            }
    
            # Hurra, bis hier kommt ein fehlerfreier interner Link.
            # Der Teststring wird entfernt und der Rest der Zeile weiter verarbeitet.
            if ( defined ($ZEILE) ) {
              $_ = $ZEILE;
                if (/\.md/) {
                    unshift @INHALT, $_;
                    $NR--;
                    redo;
                }
            }
        }
    }
    if ($#FEHLER > 0) {
        print @FEHLER;
    }
}
