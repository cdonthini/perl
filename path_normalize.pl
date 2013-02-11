#!/usr/bin/perl -w
use Getopt::Long;
my $path;
GetOptions ("path=s" => \$path);
while($path =~ m/^(.*)(\/\.\/)(.*)/){
    $path = $1 . "\/" . $3;
}
while($path =~ m/^(.*)(\/\w*\/\.\.\/)(.*)/){
    $path = $1 . "\/" . $3;
}
printf $path . "\n";
