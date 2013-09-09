#! /usr/bin/perl
use strict;

my $name = shift;
my $name2 = shift;

Rename($name, $name2, "de");
Rename($name, $name2, "en");
Rename($name, $name2, "ro");
Rename($name, $name2, "it");
Rename($name, $name2, "pl");
Rename($name, $name2, "pt-br");
sub Rename{
	my $name = shift;
	my $name2 = shift;
	my $lang = shift;
	chdir($lang);
	
	my $src = "$name" . "_$lang.htm";
	if (! -f $src){
		print "+++ $src: not found\n";
	} else {
		my $cmd = "mv $src  ${name2}_$lang.htm";
		print $cmd, "\n";
		system("$cmd");
	}
	chdir ("..");
}
