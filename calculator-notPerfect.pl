#!/usr/bin/perl 

use strict;
use warnings;

# Input:
# 1430_5 - 110_2 * 2A_12 + 10_10

   # Output:
# 46

my $expression = "1430_5 - 110_2 * 2A_12 + 10_10 ";
my $substitute;

if ( $expression =~ m/(.*)(\+|\-|\*)(.*)(\*)(.*)(\+|\-|\*)(.*)/) {

	printf "$1 | $2 | $3 | $4 | $5 | $6 | $7\n";
	
	$substitute = &translation($3) * &translation($5);

	$expression = $1 . $2 . $substitute."_10" . $6 . $7;

	printf $expression . "\n";

}

my @nums;
my @operators;
while ( $expression =~ m/(.*)(\-|\+|\*)(.*)/ ) {
	printf "$1\n";
	printf "$2\n";
	printf "$3\n";
	printf "new expression\n";
	$expression = $1;
	push (@nums, $3);
	push (@operators, $2);	
}
my $result = &translation($expression);
printf "length of ops:" . scalar(@nums)." ". $result ."\n";
for (my $var = scalar(@operators) - 1; $var >= 0; $var--) {
	printf $nums[$var] . " nums\n";
	if ($operators[$var] eq "+") {
		$result += &translation($nums[$var]);
	}
	elsif ($operators[$var] eq "-"){
		my $operand = &translation($nums[$var]);
		printf "subtract $operand\n";
		$result = $result - $operand;
	}
	printf "loop: $var ---> $result \n"
}

sub translation {
	
	if ( $_[0] =~ m/(.*)(\_)(.*)/ ) {
		
		my $base = $3 + 0;
		my $index = $1;
		my $result = 0;
		my $char;
		#printf "$index - $base\n";
		for (my $var = 0; $var < length($index); $var++) {
			$char = substr($index,length($index) - $var -1,1);
			$char = &replaceConsts($char);
			#printf $char."\n";
			#"$index[length($index) - $var -1]";
			$result += ($char * ( $base ** $var) );
		}

	return $result;
		
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
}