#!/usr/bin/perl 

use strict;
use warnings;
#1430_5 - 110_2 * 2A_12 + 10_10
my $decimal = "1430_5";
my $hex = " 2A_12";
my $binary = " 1111_2";
printf "$binary\n";

if ( $hex =~ m/(.*)(\_)(.*)/ ) {
	
	my $base = $3 + 0;
	my $index = $1;
	my $result = 0;
	my $char;
	#printf "$index - $base\n";
	for (my $var = 0; $var < length($index); $var++) {
		$char = substr($index,length($index) - $var -1,1);
		$char = &replaceConsts($char);
		printf $char."\n";
		#"$index[length($index) - $var -1]";
		$result += &replaceConsts($char) * ( $base ** $var) ;
	}

printf $result;
	
}

sub replaceConsts {

	if($_[0] eq "A") {
		return 10;
	} 
	elsif ($_[0] eq "B") {
		return 11;
	}
	elsif ($_[0] eq "C") {
		return 12;
	}
	elsif ($_[0] eq "D") {
		return 13;
	}
	elsif ($_[0] eq "E") {
		return 14;
	}
	elsif ($_[0] eq "F") {
		return 15;
	}
	else {
		return $_[0];
	}
}

