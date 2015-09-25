#!/bin/bash

if [ "$1" = "" ];
then
        echo "used : ./inoutmail2.sh firstdate lastdate shotdomain"
        echo "ex ) ./inoutmail2.sh 20081201 20081204 onnet21 [option:search add Email address string]"
        exit
fi


if [ "$2" = "" ];
then
        echo "used : ./inoutmail2.sh firstdate lastdate shotdomain"
        echo "ex ) ./inoutmail2.sh 20081201 20081204 onnet21 [option:search add Email address string]"
        exit
fi


if [ "$3" = "" ];
then
        echo "used : ./inoutmail2.sh firstdate lastdate shotdomain"
        echo "ex ) ./inoutmail2.sh 20081201 20081204 onnet21 [option:search add Email address string]"
        exit
fi

DATE=`date +%Y%m%d`
UDATE=`date +%s`
SDATE=`date -d $1 +%s`
LDATE=`date -d $2 +%s`
US=$(( (UDATE+32400)/86400 - (SDATE+32400)/86400 ))
LS=$(( (UDATE+32400)/86400 - (LDATE+32400)/86400 ))
OUTMAILFILE="/home/onnet/$3-$1-outmail.txt"
INMAILFILE="/home/onnet/$3-$1-inmail.txt"

FILES=`find /var/log/smtpd/ -type f -mtime -$US | sort`
for FILE in $FILES
do
        
	SFILE=${FILE##/*/}
	OUTMAILFILE="/home/onnet/$3-$SFILE-outmail.txt"
	INMAILFILE="/home/onnet/$3-$SFILE-inmail.txt"

	if [ "$4" != "" ];
	then
	OUTMAILDATA=`egrep -E "from:+[._0-9a-zA-Z]+@$3|from:$4" $FILE | egrep -E Success | sed 's/|\/home.*//g' | sed 's/) (size:.*//g' | sed 's/\[L.*) (//g' | sed 's/\[R.*) (//g' |  sed 's/)(/ /g'  |cut -c-162 `
	else
	OUTMAILDATA=`egrep -E from:+[._0-9a-zA-Z]+@$3 $FILE | egrep -E Success | sed 's/|\/home.*//g' | sed 's/) (size:.*//g' | sed 's/\[L.*) (//g' | sed 's/\[R.*) (//g' |  sed 's/)(/ /g' | cut -c-162 `
	fi
	
	echo "========== Starting $SFILE Out Mail data to : $OUTMAILFILE"	
	echo "==================== $SFILE ===================" > $OUTMAILFILE
	echo "$OUTMAILDATA"	      			       >>$OUTMAILFILE
	echo "=========  end"

        if [ "$4" != "" ];
        then
        INMAILDATA=`egrep -E "to:+[._0-9a-zA-Z]+@$3|to:$4" $FILE | egrep -E Success | sed 's/|\/home.*//g' | sed 's/) (size:.*//g' | sed 's/\[L.*) (//g' | sed 's/\[R.*) (//g' |  sed 's/)(/ /g' | sed '/Boun/d' |cut -c-162 `
        else
        INMAILDATA=`egrep -E to:+[._0-9a-zA-Z]+@$3 $FILE | egrep -E Success | sed 's/|\/home.*//g' | sed 's/) (size:.*//g' | sed 's/\[L.*) (//g' | sed 's/\[R.*) (//g' |  sed 's/)(/ /g' | cut -c-162 `
        fi
 
	echo "========== Starting $SFILE Incoming Mail data to : $INMAILFILE"	
       	echo "==================== $SFILE ===================" 	> $INMAILFILE
      	echo "$INMAILDATA"                                    	>>$INMAILFILE
	echo "=========  end "

        if [ "$2" = "$SFILE" ]
        then
		echo "=========  End all Data Extract ==========="
                break;
        fi
done
