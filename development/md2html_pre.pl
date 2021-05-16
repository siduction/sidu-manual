#!/usr/bin/perl -w
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2021, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Verwendung für das siduktion Handbuch.
# Vorbereitung für die Erzeugung einzelner .html-Dokumente aus
# den .md-Dateien des Ordners "sidu-manual/data/de/"
#
# Die Pfade bei Bedarf an die individuellen Gegebenheiten angepassen.
#
use strict;
use File::Basename;

my ($SCHREIBEN, $LAGER);
my (@QUELLE, @NEU);

open(DATEI, "<$ARGV[0]") || die "$ARGV[0] nicht gefunden\n";
@QUELLE=<DATEI>;
close(DATEI);

$SCHREIBEN = "$ARGV[0]";

######## Beginn inhaltliche Bearbeitung der Dateien.

while (@QUELLE) {                                
    $_ = shift @QUELLE;
    chomp($_);
    
        # Eine Zeile mit ">" in "<warning> ... </warning>" Tag ändern.
    if (/^> */) {
            # ">" enfernen, schließenden Tag anhängen und in $LAGER geben.
        s#^> *(.*)$#$1</warning>#;
        $LAGER = $_;
            # Vorherige Zeile wieder holen.
        $_ = pop @NEU;
        chomp($_);
       
        if (/^<warning>.*<\/warning>$/) {
                # Wenn Zeile mit vollständigen Tag, schließ-Tag entfernen
                #  und zurück nach @NEU geben.
            s#^(.*)</warning>#$1#;
            push @NEU,$_;
                # HTML-Zeilenumbruch vor die neue Zeile setzen und weiter verarbeiten.
            $_ = "<br \/>$LAGER";
            
        } elsif (/<\/warning>$/) {
                # Wenn Zeile bereits eine zweite Zeile war, dann Schließ-Tag
                #  entfernen, neue Zeile anhängen und weiter verarbeiten.
            s#<\/warning>##;
            $_ = "$_ $LAGER";
             
        } else {
                # Wenn die vorherige Zeile keinen Tag hatte, Zeilenumbruch wieder
                #  einfügen und die Zeile zurück nach @NEU geben.
        $_ = "$_\n";
        push @NEU,$_;
                # Neue Zeile mit Start-Tag vervollständigen und weiter verarbeiten.
        $_ = "<warning>$LAGER";
        }
    }
            
    # Handbuch interne Link auf .html ändern
    s/(\(.*?\.)md/$1html/g;
    $_ = "$_\n";
    push @NEU,$_;
}

@QUELLE = @NEU;
@NEU = ();

######## In Ausgabedatei schreiben.
# (Für Testzwecke auf der Konsole auskommentieren.)
                                                
open (DATEI, ">", $SCHREIBEN) || die "Kann nicht schreiben.\n";
    print DATEI @QUELLE;
#    print @QUELLE;
close(DATEI);

__END__
