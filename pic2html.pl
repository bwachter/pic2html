#!/usr/bin/perl
# (c) Bernd 'Aard' Wachter, bwachter@lart.info, http://bwachter.lart.info
# you may use and redistribute this under the terms and conditions of the 
# GNU General Public License

use GD;

print "Content-type: text/html\n\n";
open(IM,"hostkbd.jpg");
$im=newFromJpeg GD::Image(IM);

print "<html><head></head><body></body><table><style type=\"text/css\">
<!--
table { border-spacing:0px; }
td { width:1px; }
-->
</style>";
($x,$y)=$im->getBounds();
for ($i=$x;$i>0;$i--){
  print "<tr>\n";
  for ($j=0;$j<$y;$j++){
    $index=$im->getPixel($i,$j);
    ($r,$g,$b)=$im->rgb($index);
    print "\t<td bgcolor=\"#";
    printf "%02x"x3,$r,$g,$b;
    print "\"></td>\n";
  }
  print "</tr>\n";
}
print "</table></body></html>";

