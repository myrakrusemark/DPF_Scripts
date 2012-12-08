#!/usr/bin/perl

# use module
use strict;
use warnings;

use LWP::Simple;
use XML::Simple;


my $url=<http://rss.cnn.com/rss/cnn_topstories.rss>;
my $itemnumber=1;
my $posx=30;
my $posy=120;
my $font=</usr/share/fonts/truetype/freefont/>;
my $cnnitem="";
my $pub="";
my $base="/home/picture/syncscripts/cnn/base.jpg";
my $target="/home/picture/syncscripts/cnn/cnn.png";

#Retrieve the Feed
my $feed_to_parse = get ($url) or die "I can't get the feed you want";

#Parse the XML
my $parser = XML::Simple->new();
my $rss = $parser->XMLin("$feed_to_parse");

#XML Output
#print "************************************************************************\n";
#Print Channel Title
#print $rss->{'channel'}->{'title'},"- Top Stories\n";

#Open file for output
open(CNN, ">/home/picture/syncscripts/cnn/update.sh");

#Print Channel Items
#print "************************************************************************\n";
print CNN "#!/bin/bash \n\n";
print CNN "gm convert ";
print CNN "-font $font/FreeSansBold.ttf -pointsize 40 -fill white -draw \"text 30,50 \\\"$rss->{'channel'}->{'title'} - Top Stories\\\" \" ";
foreach my $item(@{$rss->{channel}->{item}}) {
next unless defined($item->{'title'});
$cnnitem=$item->{'title'};
$pub=$rss->{'channel'}->{'pubDate'};
print CNN "-font $font/FreeSansBold.ttf -pointsize 45 -fill white -draw \"text $posx,$posy \\\"$cnnitem\\\" \" ";
$itemnumber=$itemnumber+1;
$posy=$posy+51;
}
print CNN "-font $font/FreeSansBold.ttf -pointsize 15 -fill white -draw \"text $posx,740 \\\"$pub\\\" \" ";
print CNN "$base ";
print CNN "$target";

#Close Files
close(CNN);
