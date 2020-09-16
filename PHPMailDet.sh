#!/bin/bash
#This script Requires PHP Mail() logging to be enabled in the PHP.ini and PHP Version 5.3+
#Mail Function logging can be enabled by adding the following to your site's PHP.ini: mail.log = /var/log/php-mail.log

#temp file
tmp=/root/phpmaildet.tmp
mailto=you@example.com
#Add hostname, date, and path to log to file
echo "$(hostname)" > $tmp; echo >> $tmp; date >> $tmp; echo >> $tmp

echo "Log file = /var/log/phpmail.log" >> $tmp; echo >> $tmp

#Query the mail log, sort, and remove unneccessary info incl. brackets and trailing ':'
grep 'home' /var/log/phpmail.log| grep -v "_exclude_me_"| awk '{print $6}'| sort -n|tr -d '[',']'| cut -f 1 -d':' | uniq -c | sort -n

#Email execution and cleanup
if [ -s $tmp ]
then
mail -s "PHP Mail Script Detector $(hostname)" $mailto < $tmp
fi
rm -f $tmp
