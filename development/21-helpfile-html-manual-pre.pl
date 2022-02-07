#!/usr/bin/perl -w
#
# Name: 21-helpfile-html-manual-pre.pl within siduction manual /development folder.
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2022, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Usage for siduktion manual.
# Preparation of .md files to use them with 20-generate-html-manual.sh
#  and 00-generate_manual.pl
#
#  Do not call this script direcly!
#
#
use strict;
use File::Basename;

my ($SCHREIBEN, $LAGER, $NR);
my (@QUELLE, @NEU);
my %ZEILEN = ();

open(DATEI, "<$ARGV[0]") || die "$ARGV[0] nicht gefunden\n";
@QUELLE=<DATEI>;
close(DATEI);

$SCHREIBEN = "$ARGV[0]";

######## Beginn inhaltliche Bearbeitung der Dateien.
# Klasse 1 Überschriften aus den "XX00-"Dateien entfernen.

#$_ = ;
$NR = 0 ;
if ($SCHREIBEN =~ /\d{2}00/) {
    while (@QUELLE) {
        $NR ++;
        $_ = shift @QUELLE;
        if (/^\# /){
            $NR --;
            shift @QUELLE;
            while ($NR > 0) {
                unshift @QUELLE, $ZEILEN{"$NR"};
                $NR --;
            } 
            last;
        } else {
            $ZEILEN{"$NR"} = $_;
        }
    }
#        # Zifferncode entfernen.
#        # Anker-Teil aus den Link der "XX00-"Dateien entfernen,
#        #  damit in der Zielseite auch der Titel angezeigt wird.
#    foreach (@QUELLE) {
#        s/\(\d{4}-(.*?\.)md\#.*?\)/\($1html\)/g;
#    }
}   

while (@QUELLE) {                                
    $_ = shift @QUELLE;
    chomp($_);
    
        # Umlaute zu HTML Notation
    $_ =~ s!ä!&auml;!g;
    $_ =~ s!Ä!&Auml;!g;
    $_ =~ s!ö!&ouml;!g;
    $_ =~ s!Ö!&Ouml;!g;
    $_ =~ s!ü!&uuml;!g;
    $_ =~ s!Ü!&Uuml;!g;
    $_ =~ s!ß!&szlig;!g;
    
        # Umformatierung der Warnungen
        #
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

    # Handbuch interne Link auf .html ändern und Zifferncode entfernen.
    s!\d{4}-(.*?\.)md\#!https://manual.siduction.org/$1html\#!g;
    
    # Nur notwendig, weil fehlerhafte Link vorhanden sind.
    if (/\(.*?\.md\#/) {
    s!\]\(\.?/?(.*?\.)md\#!\]\(https://manual.siduction.org/$1html\#!g;
    }
    
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
