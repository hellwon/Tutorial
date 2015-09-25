#!/bin/sh

echo "====================== START ======================="
echo "신규가입자 최종 로그인 일자를 구합니다."

cd /var/log/webmail/debug
#read USERS

UDATE=`date +%s`
#SDATE=`date -d $1 +%s`
#LDATE=`date -d $2 +%s`
OUTFILE="/var/log/webmail/debug/out.txt"

USERS=`cat user2.txt`
#declare -i WDATE
for USER in $USERS
do
WDATE=20100530
echo $USER "검색중 - - -"
#REALDATE=``
#for ( DATE = 20100530; DATE <= 20100501; DATE++ )
	while 	[ $WDATE != 20100501 ];
	do
	LOGINDATE=`grep $USER $WDATE|grep get_maildb`
	#echo "grep" $USER $DATE"|grep get_maildb |awk '{print $1}' |awk -F '[' '{print $2}'|uniq"

		if [ "$LOGINDATE" != "" ]; then
			REALDATE=`grep $USER $WDATE|grep get_maildb |grep get_maildb |awk '{print $1}' |awk -F '[' '{print $2}'|uniq` 
			echo $USER "|" $REALDATE
			echo $USER "|" $REALDATE >> $OUTFILE
			break
		else
			echo $WDATE
		fi

		WDATE=$(($WDATE-1))
	done
done
