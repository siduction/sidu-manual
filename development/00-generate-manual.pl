#!/usr/bin/perl -w
#
# Name 00-generate-manual.pl
#
# Autor: Axel Konrad (akli)
# Copyright Axel Konrad 2022, wtfpl 2.0
# see http://www.wtfpl.net/txt/copying/
# ------
#
# Verwendung für das siduktion Handbuch.
# Erzeugung des PDF-Handbuches, der HTML-Handbuch Dateien und der HTML-Menü-Datei
# aus den .md-Dateien aller zur Verfügung stehenden Sprachen.
#
# Aufruf:
# Als User in einem Terminal in den Ordner /development wechseln.
# Hier den Programmnamen und, durch Leerzeichen voneinander getrennt, die aus zwei
# Buchstaben bestehenden Kürzel für die Sprachen, in denen das Handbuch erstellt
# werden soll, eingeben. Die Sprachkürzel müssen den Namen der Unterordner in /data
# entsprechen.
# Beispiel: ./00-generate-manual.pl en de
# ------
# 
# Usage for the siduction manual.
# Generation of the PDF manual, the HTML manual files and the HTML menu file
# from the .md files of all available languages.
#
# Call:
# As user in a terminal change into the folder /development.
# Enter the program name and, separated by spaces, the two-letter shortcode
# for the languages in which the manual should be created. The language shortcode
# must correspond to the names of the subfolders in /data.
# Example: ./00-generate-manual.pl en de
# ------

use strict;
use File::Basename;

# General tests

die "Language shortcode is missing.\nUsage:\nEnter the program name and, separated by spaces, the two-letter shortcode\nfor the languages in which the manual should be created. The language shortcode\nmust correspond to the names of the subfolders in /data.\n" if @ARGV < 1;

foreach (@ARGV) {
    next if (/de|en/);          # add language shortcode if an additional language is available
    die "The given language shortcode \"$_\" is not supported.\n";
}

# Start generation of manual

my $langcode;
foreach $langcode (@ARGV) {

    ## Part 1 of 3: Generate PDF manual
    # 
    system "./10-generate-pdf-manual.sh $langcode || exit 1";


    ## Part 2 of 3: Generate HTML manual files
    #
    system "./20-generate-html-manual.sh $langcode || exit 1";


    ## Part 3 of 3: Generate HTML menu file
    #
    system "./30-generate-html-menu.pl $langcode || exit 1";
}
