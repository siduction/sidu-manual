#!/usr/bin/perl -w
#
# Name: en-menu-extract.pl
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2021, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Usage for the siduction manual.
# Extract the headings from the .md files of the folder
# "sidu-manual/data/en/" to form a menu for the HTML pages.
# Only numbered files are evaluated.
# 
# Call: Change into the folder data/en/ and
# "../../development/en-menu-extract.pl".
# The created menu with the name
# "tree-menu.html"
# will be in the folder data/en/html/.

#
use strict;
use File::Basename;

my ($FILE, $NR, $EBENE1, $EBENE2, $TAB, $TAB2, $CLASS, $TEXT, $ANKER, $LINK, $LINK1);
my (@DATEIEN, @QUELLE, @LAGER, @MENU_FILE);

######## setup HTML HEADER

open HEADER, "../../development/en-tree-menu-header.html"
    or die "Cannot open HTML header. ($1)";

while (<HEADER>) {
    push @MENU_FILE, "$_";
}

close HEADER;

######## Read in files of the folder and process them individually.

@DATEIEN = glob "*";

while (@DATEIEN) {
    $_ = shift @DATEIEN;
    chomp($_);
    next unless (/^\d{4}-.*/);
    $FILE = $_;
    $FILE =~ s!^\d{4}-(.*)\.md!$1\.html!;
        
    open(DATEI, "$_") || die "$_ not found\n";
    @QUELLE=<DATEI>;
    close(DATEI);
    $NR ++;

######## Start searching headings.
    while (@QUELLE) {
        $_ = shift @QUELLE;
    
        if (/^~{3,}/) {
                # Remove code blocks.
            $_ = shift @QUELLE;
            until (/^~{3,}/) {
                $_ = shift @QUELLE;
            }
            $_ = shift @QUELLE;
        }
                # Discard everything except headings class #-###.
        next unless /^#{1,3} /;
        push @LAGER , "$_";
    }

######## Start evaluating headings.
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

        # Remove format errors (spaces at the end of lines).
        $_ =~ s!^(.*)\s+$!$1!;
        
        # Disassemble and reassemble lines.
        $CLASS = $_;
        $CLASS =~ s/^(#{1,3}) .*/$1/;

        $TEXT = $_;
        $TEXT =~ s/^#{1,3} +(.*)/$1/;
        
        $ANKER = $TEXT;
        $ANKER =~ s!(.*)!\L$1!;
        $ANKER =~ s!Ä!ä!g;
        $ANKER =~ s!Ö!ö!g;
        $ANKER =~ s!Ü!ü!g;
        $ANKER =~ s!( )!-!g;
        
        $LINK = "<a target= \"main\" href=\"$FILE\#$ANKER\">$TEXT</a>";
        $LINK1 = "<a target= \"main\" href=\"$FILE\">$TEXT</a>";
}

######## Write to output files.
# (For testing purposes on the console)

open (DATEI, ">", "./html/tree-menue.html") || die "Cannot write.\n";
    print DATEI @MENU_FILE;
close(DATEI);

__END__
