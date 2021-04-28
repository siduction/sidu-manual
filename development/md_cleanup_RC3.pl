#!/usr/bin/perl
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2021, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Status am 28.04.2021: Zu Testzwecken freigegeben.
# Aufruf:   Zuerst im grep-Befehl den richtigen Pfad zu den md-Dateien eintragen.
#           Im LINUX Terminal './<Pfad_zu>/md_cleanup_RC3.pl'
#           Für jede Datei, die das Suchmuster von grep enthält, legt das Script
#           eine Datei mit gleichem Namen im Unterordner /clean an.
#           Der Bereich "INFOBEREICH FÜR DIE AUTOREN" und die horizontalen
#           Linien wurden entfernt.
#
#

use strict;
use File::Basename;

my ($DATEI, $FILE, $DIR, $END, $SCHREIBEN);
my (@QUELLE, @NEU, @DATEIEN);

# In dieser Zeile den richtigen Pfad zu den md-Dateien eintragen.
system "grep -l -e RC3 ~/git/sidu-manual/data/de/* 2>/dev/null > ./clean_dateien";

open DATEI, "<./clean_dateien";
@DATEIEN = <DATEI>;
close DATEI;

system "rm ./clean_dateien";

foreach (@DATEIEN) {
    chomp $_;
    next if (! -f $_);
    $DIR = "";
    
# Dateinamen zerlegen und Unterverzeichnis einfügen.
    my($filename, $dirs, $suffix) = fileparse($_, qr/\.[^.]*/);
    $FILE  = $filename;
    $DIR = $dirs . "clean/";
    $END  = $suffix;


# Unterverzeichnis anlegen, wenn nicht vorhanden.
    if (! -d $DIR) {
        system "mkdir $DIR";
    }


# Dateinamen zusammensetzen.
    $SCHREIBEN = $DIR . $FILE . $END;


# Liste, der zu bearbeitenden Dateien holen.
    open DATEI, "<$_";
    @QUELLE = <DATEI>;
    close DATEI;


# Dateien bearbeiten und ausgeben.

    &CLEAN;
    &PRINT;

}



#####################################################
######### Beginn inhaltliche Bearbeitung der Dateien.

sub CLEAN {
    @NEU = "";
    while (@QUELLE) {
        $_ = shift @QUELLE;
        if (/^\s*ANFANG\s+INFOBEREICH FÜR DIE AUTOREN/) {
            $_ = shift @QUELLE;
            until (/^\s*ENDE\s+INFOBEREICH FÜR DIE AUTOREN/) {
                if ( ! defined($_) ){
                    print "Fehler mit Datei: " . $FILE . $END . "\n";
                    last;
                }
            $_ = shift @QUELLE;
            }
#            $_ = shift @QUELLE;
            next;
            
        } elsif (/^\s*$/) {
            $_ = shift @QUELLE;
            if (/^---\s*$/) {
                next;
            } else {
                push @NEU,"\n";
                unshift @QUELLE,"$_";
                next;
            }
        }
        push @NEU,"$_";    
    }
}

#########  In Ausgabedatei schreiben.
######### (Für Testzwecke auf der Konsole auskommentieren.)

sub PRINT {

    open (DATEI, ">", $SCHREIBEN) || die "Kann Datei nicht anlegen.\n";
    foreach (@NEU) {
        print DATEI "$_";
    }
    close(DATEI);
    
}
