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
# des Ordners "sidu-manual/data/de/". Es werden ausschließlich
# nummerierte Dateien ausgewertet.
#
# Aufruf: In den Ordner data/de/ wechseln und
# "../../development/headline-extract.pl." eingeben.
# Die erstellten Überschriftenlisten mit den Namen
# "headline-by-file"
#   und
# "headline-by-text"
# befinden sich dann im Ordner /development.
#
use strict;
use File::Basename;

my ($FILE, $H_CLASS, $H_TEXT, $LINK);
my (@QUELLE, @DATEIEN, @HLTEXT, @HLFILE);


######## Dateien des Ordners einlesen und einzeln verarbeiten.

@DATEIEN = glob "*";

while (@DATEIEN) {
    $_ = shift @DATEIEN;
    chomp($_);
    next unless (/^\d{4}-.*/);
    $FILE = $_;
    
    open(DATEI, "$_") || die "$_ nicht gefunden\n";
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
        
        $LINK = "\[\]\($FILE\#$H_TEXT\)";
        $LINK =~ s!(.*)!\L$1!;
        $LINK =~ s!( )!-!g;
        $_ = sprintf "%s   %s %s   Link: %s\n", $FILE, $H_CLASS, $H_TEXT, $LINK;
#        $_ = sprintf "%-26s %-4s %-40s %-40s\n", $FILE, $H_CLASS, $H_TEXT, $LINK;
        push @HLFILE,$_;
        
        $_ = sprintf "%s~%4s~%s~%s\n", $H_TEXT, $H_CLASS, $FILE, $LINK;
        push @HLTEXT,$_;
        @HLTEXT = sort @HLTEXT;
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


open (DATEI, ">", "../../development/headline-by-text") || die "Kann nicht schreiben.\n";
foreach (@HLTEXT) {
    s!(.*?)~(.*?)~(.*?)~(.*?)!$2 $1   $3   Link: $4!;
    print DATEI "$_";
#    print "$_";
}
close(DATEI);

__END__
