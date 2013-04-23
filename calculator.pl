#!/usr/bin/perl 

use strict;
use warnings;

# Input:
# 1430_5 - 110_2 * 2A_12 + 10_10

   # Output:
# 46

# $expression = $ARGV[0];
my $expression = "1_10 * 2_10 * 3_10 * 4_10 * 5_10 * 6_10";
# my $expression = "2_10 * 2_10 * 2_10 * 2_10 * 2_10 * 2_10";
# my $expression = "1430_5 - 110_2 * 2A_12 + 10_10 *1_10 * 1_10";
# my $expression = "240_10 - 6_10 * 34_10 + 10_10 *1_10 * 1_10";
my @nums;
my @operators;
while ( $expression =~ m/(.*)(\-|\+|\*)(.*)/ ) {
	printf "$1\n";
	#printf "$2\n";
	#printf "$3\n";
	#printf "new expression\n";
	$expression = $1;
	push (@nums, $3);
	push (@operators, $2);	
}

push (@nums, $expression);

printf "operators: " . scalar(@operators) . " nums: " .scalar(@nums) ."\n";


foreach ( @operators ) {
	printf $_ . "|";
}

printf "\n";
foreach ( @nums ) {
	printf $_ . "|";
}

printf "\n";

for (my $var = scalar(@operators) - 1; $var >= 0; $var--) {
	if ($operators[$var] eq "*") {
		$nums[$var] = &translation($nums[$var]) * &translation($nums[$var+1]) . "_10";
		$nums[$var+1] = "0_10";
		if ( $var + 1 <= scalar(@operators)){
			if ($operators[$var + 1] eq "*") {
				$operators[$var] = "+";
			}
			elsif ($operators[$var + 1] eq "-") {
				$operators[$var] = "-";
			}
			else {
				$operators[$var] = "+";
			}
		}
	}
}

foreach ( @operators ) {
	printf $_ . "|";
}

printf "\n";
foreach ( @nums ) {
	printf $_ . "|";
}

printf "\n";

my $result = &translation($nums[scalar(@nums)-1]);
#= &translation($expression);
# printf "length of ops:" . scalar(@nums)."\n";
for (my $var = scalar(@operators) - 1; $var >= 0; $var--) {
	if ($operators[$var] eq "+") {
		$result += &translation($nums[$var]);
	}
	elsif ($operators[$var] eq "-"){
		$result -= &translation($nums[$var]);
	}

	printf "loop: $var ---> $result \n"
}
#printf "\n $expression \n $result";


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

