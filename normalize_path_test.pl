#!/usr/bin/perl -w
use strict;
use warnings;
use diagnostics;

sub normalize($) {

	my $path = shift;
	
	#takes care of enclsoed '/./'
	while ($path =~ m/^(.*)(\/\.\/)(.*)/){ 
		$path = $1 . "\/" . $3;
	}
	
	#takes care of '/../' and its combinations
	while(($path =~ m/(.*?)(\/\w*\/\.\.\/)(.*)/) || #blah /../ blah
				($path =~ m/(.*?)(\/\.\.\/)(.*)/)|| # /../
				($path =~ m/(.*?)(\/\w*\/\.\.)(.*)/)){ #blah /..
		$path = $1 . "\/" . $3;
	}

	#takes care of the '/.' and './' combinations
	while(($path =~ m/^(.*)(\.\/)(.*)/) ||
			($path =~ m/^(.*)(\/\.)(.*)/)){ #blah/./blah
		$path = $1 . "\/" . $3;
	}
	
	# resulting path is printed
	printf $path . "\n";
	return $path
}

sub test(){
	my $test  = "/foo/..//baz";
	print($test . " ---> "); normalize($test);

	$test = "/other/../bar/../baz";
	print($test . " ---> "); normalize($test);

	$test = "/foo/../../";
	print($test . " ---> "); normalize($test);

	$test = "/../../../hello";
	print($test . " ---> "); normalize($test);

	$test = "hello/./help";
	print($test . " ---> "); normalize($test);

	$test = "/foo/./././hello/./help//other";
	print($test . " ---> "); normalize($test);

	$test = "/.//foo//hello/./help//other/.";
	print($test . " ---> "); normalize($test);

	$test = "/../../../hello/./help//other/../../bar/../baz";
	print($test . " ---> "); normalize($test);
	
	$test = "../../../hello/./help//other/../../bar/../baz";
	print($test . " ---> "); normalize($test);

	$test = "/foo/../../../hello/./help//other/../../bar/..";
	print($test . " ---> "); normalize($test);

	$test = "/foo/../../../hello/./../help//other/../../bar/../baz";
	print($test . " ---> "); normalize($test);
	
	$test = "/foo/hello/help/other/bar/baz";
	print($test . " ---> "); normalize($test);
	
	$test = "/foo/../hello/../bat/../hello/../help/../other/../baz";
	print($test . " ---> "); normalize($test);
	
	$test = "/foo/./../hello/./bat/../hello/./../help/.././other/../baz";
	print($test . " ---> "); normalize($test);
}

test(); 

