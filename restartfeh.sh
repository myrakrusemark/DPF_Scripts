rm /home/picture/syncscripts/playlist

echo "Making a playlist for mail directory..."
find /home/picture/Pictures/mail/ -type f \( -name "*.JPG" -o -name "*.jpg" -o -name "*.jpg.*" -o -name "*.JPG.*" -o -name "*.png.*" -o -name "*.png" \) -print > /home/picture/syncscripts/playlist

echo "Making a playlist for all other pictures..."
find /home/picture/Pictures/ -type f \( -name "*.JPG" -o -name "*.jpg" -o -name "*.jpg.*" -o -name "*.JPG.*" -o -name "*.png.*" -o -name "*.png" \) -print > /home/picture/syncscripts/playlist_preshuffle

shuf /home/picture/syncscripts/playlist_preshuffle >> /home/picture/syncscripts/playlist

#cat /home/picture/syncscripts/playlist

killall -q feh

DISPLAY=:0 /usr/bin/feh -f /home/picture/syncscripts/playlist --hide-pointer -dZFD 10
