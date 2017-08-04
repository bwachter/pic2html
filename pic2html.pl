#!/usr/bin/perl
# (c) Bernd 'Aard' Wachter, aard@aard.fi, http://aard.fi
# you may use and redistribute this under the terms and conditions of the
# GNU General Public License

use GD;
use Getopt::Long;
use strict;

my %opt;
Getopt::Long::Configure('bundling');
GetOptions(
           "i|input:s" => \$opt{i},
           "n|no-whitespace" => \$opt{n},
           "o|output:s" => \$opt{o},
          );

if (!$opt{i}){
  print "Usage: pic2html.pl -i|--input <input-file> [-o|--output <output-file>]\n\n";
  print "Output is to STDOUT if -o is omitted\n";
  exit -1;
}

my ($ifh, $ofh);
open($ifh, $opt{i}) || die "Unable to open input file: $!\n";
my $im=newFromJpeg GD::Image($ifh);
close($ifh);

if (!$opt{o}){
  $ofh = *STDOUT;
} else {
  open($ofh, '>', $opt{o}) || die "Unable to open output file: $!\n";
}

my $t='\t';
my $n='\n';

if ($opt{n}){
  $t='';
  $n='';
}

print $ofh "<html><head></head><body></body><table><style type=\"text/css\">
<!--
table { border-spacing:0px; }
td { width:1px; }
-->
</style>";
my ($x,$y)=$im->getBounds();

for (my $ty=0;$ty<$y;$ty++){
  print $ofh "<tr>".$n;
  for (my $tx=0;$tx<$x;$tx++){
    my ($r, $g, $b);
    my $index=$im->getPixel($tx,$ty);
    ($r,$g,$b)=$im->rgb($index);
    print $ofh $t."<td bgcolor=\"#";
    printf $ofh "%02x"x3,$r,$g,$b;
    print $ofh "\"></td>".$n;
  }
  print $ofh "</tr>".$n;
}
print $ofh "</table></body></html>";
