#!/usr/bin/perl -w
#
# Name: en-headline-extract.pl
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2021, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
#
# Use for the siduction manual.
# Extract and prepare the headings from the .md files
# of the folder "sidu-manual/data/en/". Only numbered files are evaluated.
# numbered files are evaluated.
#
# Call: Change into the folder data/en/ and
# "../../development/en-headline-extract.pl.".
# The created headline lists with the names
# "en-headline-by-file"
# and
# "en-headline-by-text"
# are then located in the /development folder.
#
use strict;
use File::Basename;
#use Unicode::Normalize;

my ($FILE, $H_CLASS, $H_TEXT, $LINK);
my (@QUELLE, @DATEIEN, @HLTEXT, @HLFILE);


######### Read in files of the folder and process them individually.

@DATEIEN = glob "*";

while (@DATEIEN) {
    $_ = shift @DATEIEN;
    chomp($_);
    next unless (/^\d{4}-.*/);
    $FILE = $_;
    
    open(DATEI, "$_") || die "$_ not found\n";
    @QUELLE=<DATEI>;
    close(DATEI);


######### Start searching headings.

    while (@QUELLE) {
        $_ = shift @QUELLE;
        chomp($_);
    
        if (/^ *~{3,}/) {           # Remove code blocks.
            $_ = shift @QUELLE;
            until (/^ *~{3,}/) {
                $_ = shift @QUELLE;
            }
            $_ = shift @QUELLE;
        }
          
        next unless /^#{1,4}/;      # Discard everything except headings.
    
                                    # Disassemble and reassemble lines.
        $H_CLASS = $_;
        $H_CLASS =~ s/^(#{1,4}) .*/$1/;

        $H_TEXT = $_;
        $H_TEXT =~ s/^#{1,4} (.*)/$1/; 
        
        $LINK = "\[\]\($FILE\#$H_TEXT\)";
        $LINK =~ s!(.*)!\L$1!;
        $LINK =~ s!( )!-!g;
        $_ = "$FILE   $H_CLASS $H_TEXT   link: $LINK\n";
        push @HLFILE,$_;
        
        $_ = sprintf "%s~%4s~%s~%s\n", $H_TEXT, $H_CLASS, $FILE, $LINK;
        push @HLTEXT,$_;
        @HLTEXT = sort { "\L$a" cmp "\L$b" } @HLTEXT;
    }
}

######## Write to output files.
# (Comment out on the console for testing purposes)

open (DATEI, ">", "../../development/en-headline-by-file") || die "cannot write.\n";
print DATEI @HLFILE;
#    print @HLFILE;
close(DATEI);


open (DATEI, ">", "../../development/en-headline-by-text") || die "cannot write.\n";
foreach (@HLTEXT) {
    s!(.*?)~(.*?)~(.*?)~(.*?)!$2 $1   $3   link: $4!;
    print DATEI "$_";
#    print "$_";
}
close(DATEI);

__END__
