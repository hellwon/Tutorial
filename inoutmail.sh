#!/bin/bash

if [ "$1" == "" ]
then
	echo "used : ./inoutmail date shotdomain"
	exit
fi

if [ "$2" == "" ]
then
        echo "used : ./inoutmail date shotdomain"
        exit
fi

DATE=`date +%Y%m%d`
OUTFILE="/home/onnet/$2-$DATE.txt"

FILES=`find /var/log/smtpd/ -type f -mtime -$1 | sort`
echo "==============================================================" > $OUTFILE
for FILE in $FILES
do
	SFILE=${FILE##/*/}
        OUT=`cat $FILE | egrep -i from:+[._0-9a-zA-Z]+@$2 | egrep -i Success | wc -l`
        IN=`cat $FILE | egrep -i to:+[._0-9a-zA-Z]+@$2 | egrep -i Success | wc -l`

	echo "FileName : $SFILE   OutMail: $OUT  IncomingMail: $IN"  >> $OUTFILE
done
echo "==============================================================" >> $OUTFILE
