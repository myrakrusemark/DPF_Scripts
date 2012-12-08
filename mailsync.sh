echo "MAILSYNC: Moving images to 'olmail' on GMail"
mv -f /home/picture/mail/INBOX/new/* /home/picture/mail/INBOX/cur/
mv -f /home/picture/Pictures/mail/* /home/picture/Pictures/oldmail/
rm -f /home/picture/Pictures/mail/*

offlineimap

echo "MAILSYNC: Unpacking images"
munpack -C /home/picture/Pictures/mail/ /home/picture/mail/INBOX/new/*

echo "MAILSYNC: Checking for new images"

if [ -f /home/picture/Pictures/mail/*.jpg ] || [ -f /home/picture/Pictures/mail/*.JPG ] || [ -f /home/picture/Pictures/mail/*.jpg.* ] || [ -f /home/picture/Pictures/mail/*.JPG.* ] || [ -f /home/picture/Pictures/mail/*.png ] || [ -f /home/picture/Pictures/mail/*.PNG ]
then

echo "MAILSYNC: New images! Imprinting text--restarting Feh" 

echo "MAILSYNC: Imprinting text"
/home/picture/syncscripts/email/emailtext.sh

echo "MAILSYNC: BING!!!"
aplay /home/picture/syncscripts/alert.wav

echo "MAILSYNC: Restarting Feh"
/home/picture/syncscripts/restartfeh.sh

else

echo "MAILSYNC: There are no new images"

fi

echo "***DONE***"

