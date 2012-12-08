echo "TEXT EMBEDDER: Making LS file"
rm /home/picture/Pictures/mail/*.desc
ls -1 /home/picture/mail/INBOX/new/ > /home/picture/syncscripts/email/inboxfile.txt
ls -1 /home/picture/Pictures/mail/ > /home/picture/syncscripts/email/basefile.txt

echo "TEXT EMBEDDER: Perl Script!"
perl /home/picture/syncscripts/email/update.pl
echo "TEXT EMBEDDER: Build image with GraphicsMajik"
/home/picture/syncscripts/email/update.sh
echo "TEXT EMBEDDER: Copying image file"
rm /home/picture/Pictures/mail/*
mv /home/picture/syncscripts/email/image/* /home/picture/Pictures/mail/
