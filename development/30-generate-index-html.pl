#!/usr/bin/perl -w
#
# Name: 30-generate-index-html.pl within siduction manual /development folder.
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2022, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Usage for siduktion manual:
# Assembling the 'index.html' for the siduction manual.
# Extracting the headings from the .md files, forming a menu from them and
# inserting it into the HTML page.
# Only numbered files are evaluated.
#
# Cal:
#  Normaly it is called by 00-generate-manual.pl
#  If you want to use this file directly, then change as user
#  in a terminal into the folder /development.
#  Enter the program name and add, separated by space, the two-letter shortcode
#  for the language in which the index-file should be created. The language
#  shortcode must correspond to the names of the subfolder in /data.
#  Example: ./30-generate-index-html.pl en
#
# --------
# Verwendung für das siduktion Handbuch.
# Zusammenbau der 'index.html' für das siduction Handbuch.
# Extrahieren der Überschriften aus den .md-Dateien, daraus ein Menue formen
# und es in die HTML-Seite einsetzen.
# Es werden ausschließlich nummerierte Dateien ausgewertet.
# 
# Aufruf:
#  Normalerweise wird sie von 00-generate-manual.pl aufgerufen.
#  Wenn Sie diese Datei direkt verwenden wollen, dann wechseln Sie als Benutzer
#  in einem Terminal in den Ordner /development. Geben Sie den Programmnamen
#  und, durch ein Leerzeichen getrennt, das zweistellige Kürzel für die Sprache ein,
#  in der die index-Datei erstellt werden soll. Das Sprachkürzel muss mit den Namen
#  der Unterordner in /data übereinstimmen.
#  Beispiel: ./30-generate-index-html.pl de
#

use strict;
use File::Basename;

my ($FILE, $NR, $EBENE1, $EBENE2, $TAB, $CLASS, $TEXT, $ANKER, $LINK, $LINK1, $langcode);
my (@DATEIEN, @QUELLE, @LAGER, @MENU_FILE);
my $MORE_LESS = "\t<span class=\"more\">&nbsp;&nbsp;&nbsp;\+</span><span class=\"less\">&nbsp;&nbsp;&nbsp;\-</span>";

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

open HEADER, "./31-header-index.html"
    or die "Can't open header.";

while (<HEADER>) {
    if ($langcode eq "en") {
        $_ =~ s/lang="de"/lang="en"/g;
        $_ =~ s/Zur\&uuml\;ck zu/Back to/;
        $_ =~ s/siduction Handbuch/siduction manual/;
        $_ =~ s/manual_de.pdf/manual_en.pdf/;
        $_ =~ s/PDF herunterladen/Download PDF/;
        $_ =~ s/Impressum/Inprint/;
        $_ =~ s/Datenschutz/Privacy/;
        $_ =~ s/datenschutzerklarung/data-privacy-statement/;
    }
    push @MENU_FILE, "$_";
}
close HEADER;


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
    
                 # Remove code first, because it may contain '#'
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
            $TAB = ("\t"x7);
            if ($NR > 1) {
                push @MENU_FILE, "$TAB\t</ul>\n$TAB</li>\n";
            }    
            $EBENE1 ++;
            $EBENE2 = 0;
            $TAB = ("\t"x8);
            chomp($_);
            &LINK_LINE;
            push @MENU_FILE, "\t\t\t\t\t\t\t<li class=\"item-1\">\n$TAB<input type=\"checkbox\" id=\"M$EBENE1\"/>\n$TAB<div class=\"label\">\n$TAB\t<span class=\"link\">$LINK1</span>\n$TAB\t<label for=\"M$EBENE1\">\n$TAB\t$MORE_LESS\n$TAB\t</label>\n$TAB</div>\n$TAB<ul class=\"menu-list\">\n";
            
#            $TAB\t<li class=\"item-2\">$LINK1</li>\n";
            
            next;
        } elsif (/^## /) {
            $EBENE2 ++;
            $TAB = ("\t"x10);
            chomp($_);
            &LINK_LINE;
            push @MENU_FILE, "\t\t\t\t\t\t\t\t\t<li class=\"item-2\">\n$TAB<input type=\"checkbox\" id=\"M$EBENE1" . "_" . "$EBENE2\"/>\n$TAB<div class=\"label\">\n$TAB\t<span class=\"link\">$LINK1</span>\n$TAB\t<label for=\"M$EBENE1" . "_" . "$EBENE2\">\n$TAB\t$MORE_LESS\n$TAB\t</label>\n$TAB</div>\n$TAB<ul class=\"menu-list\">\n";
            
            #            \n$TAB\t$MORE\n$TAB\t$LESS\n$TAB\t<span>$TEXT</span>\n$TAB</label>\n$TAB\t<li class=\"item-1\">$LINK1</li>\n";

            next;
        } else {
           unshift @LAGER, $_;
            while (@LAGER) {
                $_ = shift @LAGER;
                if (/^## /) {
                    push @MENU_FILE, "\t\t$TAB</ul>\n\t$TAB</li>\n";
                    unshift @LAGER, $_;
                    next START;
                } else {
                    chomp($_);
                    &LINK_LINE;
                    push @MENU_FILE, "$TAB\t<li class=\"item-1\">$LINK</li>\n";
                }
            }
            if ( $TAB eq "\t\t\t\t\t\t\t\t\t\t") {
                push @MENU_FILE, "$TAB</ul>\n\t\t\t\t\t\t\t\t\t</li>\n";
            }
        }
    }
}

open LASTPART, "./32-lastpart-index.html"
    or die "Can't open lastpart-index.html.";
        
while (<LASTPART>) {
    if ($langcode eq "en") {
        $_ =~ s/welcome_de.html/welcome_en.html/;
    }
    push @MENU_FILE, "$_";
}
close LASTPART;


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
        $LINK = "<a target=\"content\" href=\"https://manual.siduction.org/$FILE\#$ANKER\">$TEXT</a>";
        $LINK1 = "<a target=\"content\" href=\"https://manual.siduction.org/$FILE\">$TEXT</a>";
}


# Write into outputfile.

system "if [ ! -d ../data/$langcode/html ]; then mkdir ../data/$langcode/html; fi";

open (DATEI, ">", "../data/$langcode/html/index_$langcode.html") || die "Can't write outputfile.\n";
    print DATEI @MENU_FILE;
close(DATEI);

