#!/usr/bin/perl
#
# use module
use strict;
use warnings;

use LWP::Simple;
use XML::Simple;

#variables
my $zip=97206;
my $url="http://weather.yahooapis.com/forecastrss?p=$zip";
my $font=</usr/share/fonts/truetype/freefont/>;
my $base="/home/picture/syncscripts/rss/base.png";
my $target="/home/picture/syncscripts/rss/weather.png";
my $posy="100";
my $location="St. Louis";

#Retrieve the Feed
my $feed_to_parse = get ($url) or die "I can't get the feed you want";

#Parse the XML
my $parser = XML::Simple->new();
my $rss = $parser->XMLin("$feed_to_parse");

#Open weather script
open(WEAT,">/home/picture/syncscripts/rss/weather.sh");

#XML Output/script creation
print WEAT "#!/bin/bash\n\n";
print WEAT "gm convert ";

#Loop through Forecast
foreach my $item (@{$rss->{channel}->{item}->{'yweather:forecast'}}) {
    next unless defined($item->{'day'});
    my $day=$item->{'day'};
    my $high=$item->{'high'};
    my $low=$item->{'low'};
    my $text=$item->{'text'};
    print WEAT "-font $font/FreeSansBold.ttf -pointsize 40 -fill white -draw \"text 30,$posy \\\"$day\\\" \" ";
    print WEAT "-font $font/FreeSansBold.ttf -pointsize 30 -fill white -draw \"text 130,$posy \\\"$text\\\" \" ";
    $posy=$posy+35;
    print WEAT "-font $font/FreeSansBold.ttf -pointsize 30 -fill white -draw \"text 30,$posy \\\"High - $high\\\" \" ";
    $posy=$posy+35;
    print WEAT "-font $font/FreeSansBold.ttf -pointsize 30 -fill white -draw \"text 30,$posy \\\"Low - $low\\\" \" ";    
    $posy=$posy+130;    
    }

print WEAT "-font $font/FreeSansBold.ttf -pointsize 40 -fill white -draw \"text 30,50 \\\"$location Weather\\\" \" ";
print WEAT "-font $font/FreeSansBold.ttf -pointsize 40 -fill white -draw \"text 610,50 \\\"Current Conditions\\\" \" ";
print WEAT "-font $font/FreeSansBold.ttf -pointsize 60 -fill white -draw \"text 660,115 \\\"$rss->{'channel'}->{'item'}->{'yweather:condition'}->{'temp'}\\\" \" ";
print WEAT "-font $font/FreeSansBold.ttf -pointsize 40 -fill white -draw \"text 660,160 \\\"$rss->{'channel'}->{'item'}->{'yweather:condition'}->{'text'}\\\" \" ";
print WEAT "-font $font/FreeSansBold.ttf -pointsize 15 -fill white -draw \"text 30,740 \\\"Last Updated: $rss->{'channel'}->{'item'}->{'pubDate'}\\\" \" ";
print WEAT "-font $font/FreeSansBold.ttf -pointsize 15 -fill white -draw \"text 660,720 \\\"Sunrise: $rss->{'channel'}->{'yweather:astronomy'}->{'sunrise'}\\\" \" ";
print WEAT "-font $font/FreeSansBold.ttf -pointsize 15 -fill white -draw \"text 660,740 \\\"Sunset: $rss->{'channel'}->{'yweather:astronomy'}->{'sunset'}\\\" \" ";
print WEAT "$base ";
print WEAT "$target";

#Close Weather Script
close(WEAT);
