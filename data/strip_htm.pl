#! /usr/bin/perl

use strict;

my $fn = shift;

die "usage: strip_htm.pl source" unless $fn;
oneFile($fn);
foreach(@ARGV){
	oneFile($_);
}

sub oneFile{
	my $fn = shift;
	my $fnOut = "$fn.out";
	open(INP, $fn) || die "$fn: $!";
	open(OUT, ">$fnOut") || die "$fnOut: $!";

	my $state = "init";
	while(<INP>){
		if ($state eq "init"){
			print OUT;
			if (/<body/){
				$state = "menu";
				print OUT "<div>\n";
			}
		} elsif ($state eq "menu"){
			if (/id="main-page/){
				$state = "main";
				print OUT;
				$state = "rest";
			}
		} else {
			print OUT;
		}
	}
	close INP;
	close OUT;
	if ($state ne "rest"){
		print '+++ id="main" not found: ', $fn, "\n";
	} else {
		system("ls -ld $fn $fnOut");
		system("mv $fn /tmp");
		rename $fnOut, $fn;
	}
}



