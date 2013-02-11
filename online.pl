#!/usr/bin/perl -w
use strict;
use warnings;
use diagnostics;

use Getopt::Long;
my $path;
GetOptions ("path=s" => \$path);

while($path =~ m/^(.*)(\/\.\/)(.*)/){
    $path = $1 . "\/" . $3;
}
      while($path[0] =~ m/\.\./)
                {
                $path[0] =~ s/\/[^\/]*\/\.\.//;
                }
printf $path . "\n";
