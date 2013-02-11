#!/usr/bin/perl -w
use strict;
use warnings;
use diagnostics;

use Getopt::Long;
my $path;
GetOptions ("path=s" => \$path);

#takes care of '/./'
while ($path =~ m/^(.*)(\/\.\/)(.*)/){ 
	$path = $1 . "\/" . $3;
}
	
#takes care of '/../' and its combinations
while(($path =~ m/(.*?)(\/\w*\/\.\.\/)(.*)/) || 
		($path =~ m/(.*?)(\/\.\.\/)(.*)/)	 || 	
		($path =~ m/(.*?)(\/\w*\/\.\.)(.*)/)) 	
{ 
	$path = $1 . "\/" . $3;
}

#takes care of the '/.' and './' combinations
while(($path =~ m/^(.*)(\.\/)(.*)/) ||
		($path =~ m/^(.*)(\/\.)(.*)/))
{ 
	$path = $1 . "\/" . $3;
}
	
# resulting path is printed
printf $path . "\n";
