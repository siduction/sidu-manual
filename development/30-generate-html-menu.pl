#!/usr/bin/perl -w
#
# Name: 30-generate-html-menu.pl within siduction manual /development folder.
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2022, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Usage for siduktion manual:
# Extract the headings from the .md files to form a menu for the HTML pages.
# Only numbered files are evaluated.
#
# Cal:
#  Normaly it is called by 00-generate-manual.pl
#  If you want to use this file directly, then change as user
#  in a terminal into the folder /development.
#  Enter the program name and add, separated by space, the two-letter shortcode
#  for the language in which the menu-file should be created. The language
#  shortcode must correspond to the names of the subfolder in /data.
#  Example: ./30-generate-html-menu.pl en
#
# --------
# Verwendung für das siduktion Handbuch.
# Extrahieren der Überschriften aus den .md-Dateien, um daraus ein Menue für die
# HTML-Seiten zu formen. Es werden ausschließlich nummerierte Dateien ausgewertet.
# 
# Aufruf:
#  Normalerweise wird sie von 00-generate-manual.pl aufgerufen.
#  Wenn Sie diese Datei direkt verwenden wollen, dann wechseln Sie als Benutzer
#  in einem Terminal in den Ordner /development. Geben Sie den Programmnamen
#  und, durch ein Leerzeichen getrennt, das zweistellige Kürzel für die Sprache ein,
#  in der die Menue-Datei erstellt werden soll. Das Sprachkürzel muss mit den Namen
#  der Unterordner in /data übereinstimmen.
#  Beispiel: ./30-generate-html-menu.pl en
#

use strict;
use File::Basename;

my ($FILE, $NR, $EBENE1, $EBENE2, $TAB, $CLASS, $TEXT, $ANKER, $LINK, $LINK1, $langcode);
my (@DATEIEN, @QUELLE, @LAGER, @MENU_FILE);


# General test

if (scalar @ARGV != 1) {
    die "Error: We need exactly one argument\n";
} else {
    if ($ARGV[0] eq "de" || $ARGV[0] eq "en") {
        $langcode = "$ARGV[0]";
    } else {
        die "Error: Langcode not supported\n";
    }
}


# Create html header

open HEADER, "./31-header-html-menu.html"
    or die "Can't open html header.";

while (<HEADER>) {
    push @MENU_FILE, "$_";
}
close HEADER;

if ($langcode eq "de") {
    push @MENU_FILE, "	<li><h3>Siduction Handbuch</h3>";
} elsif ($langcode eq "en") {
    push @MENU_FILE, "	<li><h3>siduction manual</h3>";
#} elsif ($langcode eq "it") {                    # New translations dummy
#    push @MENU_FILE, "	<li><h3>Manuale di siduction</h3>";
} else {
    die "The given language shortcode is not supported.\n";
}


# Read in files and process them one by one.

@DATEIEN = <../data/$langcode/0*>;

while (@DATEIEN) {
    $_ = shift @DATEIEN;
    chomp($_);
    next unless (/\d{4}-.*/);
    $FILE = $_;
    $FILE =~ s!^.*\d{4}-(.*)\.md!$1\.html!;
        
    open(DATEI, "$_") || die "$_ not found\n";
    @QUELLE=<DATEI>;
    close(DATEI);
    $NR ++;


# Start searching headings.

    while (@QUELLE) {
        $_ = shift @QUELLE;
    
                 # Remove code
       if (/^~{3,}/) {
            $_ = shift @QUELLE;
            until (/^~{3,}/) {
                $_ = shift @QUELLE;
            }
            $_ = shift @QUELLE;
        }
                # Skip all, except headings class #-###
        next unless /^#{1,3} /;
        push @LAGER , "$_";
    }

# Start evaluate headings.
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
                push @MENU_FILE, "$TAB</ul>\n\t\t\t</li>\n";
            }
        }
    }
}

push @MENU_FILE, "\t\t</ul>\n\t</li>\n</ul>\n<ul>\n\t<li style=\"line-height: 25px\"><a href=\"https://manual.siduction.org/manual.pdf\" target=\"_blank\" style=\"text-decoration: none;\"><img src=\"tree-menue-frames_data/pdf-icon.svg\" style=\"vertical-align: bottom;margin-right: 5px;\" height=\"25\">PDF herunterladen</a>\n\t</li>\n</ul>\n</body>\n</html>\n";

sub LINK_LINE {

        # Eliminate format errors (spaces at the end of lines).
        $_ =~ s!^(#{1,3}.*)\s+$!$1!;
        
        # Disassemble and reassemble lines.
        $CLASS = $_;
        $CLASS =~ s/^(#{1,3}) .*/$1/;

        $TEXT = $_;
        $TEXT =~ s/^#{1,3} +(.*)/$1/;
        $TEXT =~ s!Ä!&Auml;!g;
        $TEXT =~ s!Ö!&Ouml;!g;
        $TEXT =~ s!Ü!&Uuml;!g;
        $TEXT =~ s!ä!&auml;!g;
        $TEXT =~ s!ö!&ouml;!g;
        $TEXT =~ s!ü!&uuml;!g;
        $TEXT =~ s!ß!&szlig;!g;
        
        $ANKER = $TEXT;
        $ANKER =~ s!(.*)!\L$1!;
        $ANKER =~ s!( )!-!g;
        $LINK = "<a target=\"main\" href=\"https://manual.siduction.org/$FILE\#$ANKER\">$TEXT</a>";
        $LINK1 = "<a target=\"main\" href=\"https://manual.siduction.org/$FILE\">$TEXT</a>";
}


# Write into outputfile.

system "if [ ! -d ../data/$langcode/html ]; then mkdir ../data/$langcode/html; fi";

open (DATEI, ">", "../data/$langcode/html/tree-menue_$langcode.html") || die "Kann nicht schreiben.\n";
    print DATEI @MENU_FILE;
close(DATEI);

