#!/usr/bin/perl

# use module
use strict;
use warnings;

my $posx=30;
my $posy=120;
my $font=</usr/share/fonts/truetype/freefont/>;
my $search="SAY";

my @array;
my $line;

my $base=</home/picture/syncscripts/email/basefile.txt>;
my $file=</home/picture/syncscripts/email/inboxfile.txt>;
my $filename;
my $basename;
my $message;
my $subject;
my $from;

my $target="/home/picture/syncscripts/email/image/\$RANDOM.jpg";
my $throwaway;

#Open link files
open(LS, $file);
$filename = <LS>;
open(LS2, $base);
$basename = <LS2>;

#Print out filenames
print "TEXT EMBEDDER: $filename\n $basename \n";
chomp($filename);
chomp($basename);

#Open email for reading
open(TEXT, "/home/picture/mail/INBOX/new/$filename") or die "TEXT EMBEDDER: Update.pl - There is no email to open! Killing myself and everyone around me. \n";
@array = <TEXT>;

#Search through email for 'SAY' then split at "$"
foreach $line (@array){
if ($line =~ /SAY\$/){
($throwaway,$message)=split(/\$/,$line);
chomp($message);
print "Your search returned: $message <br>\n";
}

#Search through email for 'Subject:' then split at ":"
if ($line =~ /Subject\:/){
($throwaway,$subject)=split(/:/,$line);
chomp($subject);
print "Your search returned: $subject <br>\n";
}


#Search through email for 'From:' then split at ":"
if ($line =~ /From\:/){
($throwaway,$from)=split(/:/,$line);
chomp($from);
print "Your search returned: $from <br>\n";
}
}

print "MailText: Writing update.sh\n";
#Open the update script
open(EMAIL, ">/home/picture/syncscripts/email/update.sh");
print EMAIL "#!/bin/bash \n\n";
print EMAIL "gm convert ";
print EMAIL "-font $font/FreeSansBold.ttf -pointsize 10 -fill white -draw \"text 10,10 \\\"$from\\\" \" -font $font/FreeSansBold.ttf -pointsize 40 -fill white -gravity SouthWest -draw \"text 55,45 \\\"$message\\\" \"  -font $font/FreeSansBold.ttf -pointsize 15 -fill white -draw \"text 55,75 \\\"$subject\\\" \"";
print EMAIL " /home/picture/Pictures/mail/$basename ";
print EMAIL "$target";
print EMAIL "\n\necho \"TEXT EMBEDDER: Update.sh - Finished making image\"\n\n";
close(EMAIL);



print "TEXT EMBEDDER: Update.pl - Closing files\n";
#Close Files

close(LS);
close(TEXT);
#close(TEXT);
