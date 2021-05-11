#!/usr/bin/perl -w
#
# Name: headline-extract.pl
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2021, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Verwendung für das siduktion Handbuch.
# Extrahieren und aufbereiten der Überschriften aus den .md-Dateien
# des Ordners "sidu-manual/data/de/"
#
# Aufruf: In den Ordner /development/ wechseln und "./headline-extract.pl"
# eingeben. Die erstellten Überschriftenlisten mit den Namen
# "headline-by-file"
#   und
# "headline-by-text"
# befinden sich dann im gleichen Ordner.
#
use strict;
use File::Basename;

my ($FILE, $H_CLASS, $H_TEXT);
my (@QUELLE, @DATEIEN, @HLTEXT, @HLFILE);


######## Dateien des Ordners einlesen und einzeln verarbeiten.

@DATEIEN = glob "*";

while (@DATEIEN) {
    chomp($FILE = shift @DATEIEN);

    
    open(DATEI, "$FILE") || die "$FILE nicht gefunden\n";
    @QUELLE=<DATEI>;
    close(DATEI);


######## Beginn Überschriften suchen.

    while (@QUELLE) {
        $_ = shift @QUELLE;
        chomp($_);
    
        if (/^~{3,}/) {
                # Code-Blöcke vollständig entfernen.
            $_ = shift @QUELLE;
            until (/^~{3,}/) {
                $_ = shift @QUELLE;
            }
            $_ = shift @QUELLE;
        }
                # Alles, außer Überschriften verwerfen.
        next unless /^#{1,4}/;
        
                # Zeilen zerlegen und neu zusammensetzen.
        $H_CLASS = $_;
        $H_CLASS =~ s/^(#{1,4}) .*/$1/;

        $H_TEXT = $_;
        $H_TEXT =~ s/^#{1,4} (.*)/$1/; 
    
        $_ = sprintf "  %-34s %-4s %-s\n", $FILE, $H_CLASS, $H_TEXT;
        push @HLFILE,$_;
    
        $_ = sprintf "  %-46s %-4s %-s\n", $H_TEXT, $H_CLASS, $FILE;
        push @HLTEXT,$_;
    }
}

######## In Ausgabedateien schreiben.
# (Für Testzwecke auf der Konsole auskommentieren.)

open (DATEI, ">", "../../development/headline-by-file") || die "Kann nicht schreiben.\n";
foreach (@HLFILE) {
    print DATEI "$_";
#    print "$_";
}
close(DATEI);


@HLTEXT = sort @HLTEXT;

open (DATEI, ">", "../../development/headline-by-text") || die "Kann nicht schreiben.\n";
foreach (@HLTEXT) {
    print DATEI "$_";
#    print "$_";
}
close(DATEI);

__END__
