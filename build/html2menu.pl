#! /usr/bin/perl

use strict;

my $fn = shift;

open(INP, $fn) || die "$fn: $!";
my $level = -99999;
my ($id, $output);
while(<INP>){
	if (/id="menu"/){
		$level = 0;
	} elsif (/[<]ul/){
		$level++;
		if (/id="(.*?)"/){
			$id = $1;
		} else {
			$id = "-";
		}
		&Out;
	} elsif (/[<][\/]ul/){
		$level--;
		# <li><a href="welcome-de.htm#welcome-gen">siduction-Handbuch &#8658;</a>
	} elsif($level > 0 && /[<]li.*?href="(.*?)"\s*[>](.*?)[<]/){
		my ($link, $text) = ($1, $2);
		$link =~ s/-\w\w(-\w\w)?\.htm//;
		&Out;
		$output =  "*" x $level . "\t###\t$link\t$text\n";
	} elsif(/menu-header-5/){
		$level = -99999;
	}
}
&Out;
close INP;

sub Out{
	if ($output){
		$output =~ s/###/$id/;
		print $output;
		$id = '-';
		$output = '';
	}
}

