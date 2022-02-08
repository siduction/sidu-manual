#!/usr/bin/perl -w
#
# Name: headings-2-link.pl
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2022, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Verwendung für das siduktion Handbuch.
# Extrahieren und aufbereiten der Überschriften aus den .md-Dateien.
# Es werden ausschließlich nummerierte Dateien ausgewertet.
#
# Aufruf:
# Als User in einem Terminal in den Ordner /development wechseln.
# Hier den Programmnamen und, durch Leerzeichen voneinander getrennt, die aus zwei
# Buchstaben bestehenden Kürzel für die Sprachen, in denen das Handbuch erstellt
# werden soll, eingeben. Die Sprachkürzel müssen den Namen der Unterordner in /data
# entsprechen.
# Beispiel: ./headings-2-link.pl en
# Die erstellten Überschriftenlisten mit den eingebetteten Sprachkürzeln
# "heading-link-en-by-file"
#   und
# "heading-link-en-by-text"
# befinden sich dann im Ordner /development.
#
# -----------
# Use for the siduction manual.
# Extract and prepare the headings from the .md files.
# Only numbered files are evaluated.
#
# Call:
# As user in a terminal change into the folder /development.
# Enter the program name and, separated by spaces, the two-letter abbreviations
# for the languages in which the manual is to be created. The language abbreviations
# must correspond to the names of the subfolders in /data folder.
# Example: ./headings-2-link.pl en
# The created headings lists with the embedded language abbreviations
# "heading-link-en-by-file"
#   and
# "heading-link-en-by-text"
# are then located in the /development folder.
#
#

use strict;
use File::Basename;
#use Unicode::Normalize;

my ($FILE, $H_CLASS, $H_TEXT, $LINK, $langcode);
my (@QUELLE, @DATEIEN, @HLTEXT, @HLFILE);


# General tests

die "Language shortcode is missing.\nUsage:\nEnter the program name and, separated by spaces, the two-letter shortcode\nfor the languages in which the manual should be created. The language shortcode\nmust correspond to the names of the subfolders in /data.\n" if @ARGV < 1;

foreach (@ARGV) {
    if (!/de|en/) {          # add language shortcode if an additional language is available
        die "The given language shortcode \"$_\" is not supported.\n";
    } else {
        $langcode = $_;
    }

# Read in files and process them one by one.

    @DATEIEN =  <../data/$langcode/0*>;

    while (@DATEIEN) {
        $FILE = shift @DATEIEN;
        chomp($FILE);
    
        open(DATEI, "$FILE") || die "$FILE nicht gefunden\n";
        @QUELLE=<DATEI>;
        close(DATEI);
        
        $FILE =~ s!../data/$langcode/!!;

# Start searching headings.

        while (@QUELLE) {
            $_ = shift @QUELLE;
            chomp($_);
    
            if (/^~{3,}/) {
                    # Remove code blocks completely.
                $_ = shift @QUELLE;
                until (/^~{3,}/) {
                    $_ = shift @QUELLE;
                }
                $_ = shift @QUELLE;
            }
                    # Skip all, except headings.
            next unless /^#{1,4}/;
        
                    # Disassemble and reassemble lines.
            $H_CLASS = $_;
            $H_CLASS =~ s/^(#{1,4}) .*/$1/;

            $H_TEXT = $_;
            $H_TEXT =~ s/^#{1,4} (.*)/$1/; 
        
            $LINK = "\[\]\($FILE\#$H_TEXT\)";
            $LINK =~ s!(.*)!\L$1!;
            $LINK =~ s!Ä|ä!&auml;!g;
            $LINK =~ s!Ö|ö!&ouml;!g;
            $LINK =~ s!Ü|ü!&uuml;!g;
            $LINK =~ s!ß!&szlig;!g;
            $LINK =~ s!( )!-!g;
            $_ = "$FILE   $H_CLASS $H_TEXT   Link: $LINK\n";
            push @HLFILE,$_;
        
            $_ = sprintf "%s~%4s~%s~%s\n", $H_TEXT, $H_CLASS, $FILE, $LINK;
            push @HLTEXT,$_;
            @HLTEXT = sort { "\L$a" cmp "\L$b" } @HLTEXT;
        }
    }

# Write into outputfile.

    open (DATEI, ">", "./headinglinks-$langcode-by-file") || die "Kann nicht schreiben.\n";
    print DATEI @HLFILE;
    #    print @HLFILE;
    close(DATEI);


    open (DATEI, ">", "./headinglinks-$langcode-by-text") || die "Kann nicht schreiben.\n";
    foreach (@HLTEXT) {
        s!(.*?)~(.*?)~(.*?)~(.*?)!$2 $1   $3   Link: $4!;
        print DATEI "$_";
    #    print "$_";
    }
    close(DATEI);

}
