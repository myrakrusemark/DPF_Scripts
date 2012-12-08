#!/bin/bash 

gm convert -font /usr/share/fonts/truetype/freefont//FreeSansBold.ttf -pointsize 10 -fill white -draw "text 10,10 \" Alan Helton <alnino2005@gmail.com>\" " -font /usr/share/fonts/truetype/freefont//FreeSansBold.ttf -pointsize 40 -fill white -gravity SouthWest -draw "text 55,45 \"Ian is lonely :(\" "  -font /usr/share/fonts/truetype/freefont//FreeSansBold.ttf -pointsize 15 -fill white -draw "text 55,75 \" Awww,\" " /home/picture/Pictures/mail/CIMG2367.JPG /home/picture/syncscripts/email/image/$RANDOM.jpg

echo "TEXT EMBEDDER: Update.sh - Finished making image"

