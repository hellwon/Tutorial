#!/bin/sh
echo "===================================================="
echo "=====���������������� S T A R T ��������������======"
date
echo "===================================================="

echo "���� �ҽ� �������� ����"
# ftp ������ ���� ������ �����ð� ��ġ ���� ���� ������ ���� ��ġ ����
# ���� js ������ �߰��� ������ 
# ���� �÷��� �ؽ�Ʈ ���� �߰��� ������
# ��Ȱ ���� ���� ������
ftp -n -i  164.124.141.156 << EOF
user webadmin @anwlro79
bi
pass
cd /svc/addon/weather/wwwhome/forecast/land
lcd /svc/addon/sim/wwwhome/weather/forecast/land

mget LOC*

cd /svc/addon/weather/wwwhome/js
lcd /svc/addon/sim/wwwhome/weather/js

mget calendar.js common.js flashWrite.js highway.js jisu_data.js radar.js rolling.js sat.js sil_data.js world.js

cd /svc/addon/weather/wwwhome/data
lcd /svc/addon/sim/wwwhome/weather/data

mget *

cd /svc/addon/weather/wwwhome/life/jisu
lcd /svc/addon/sim/wwwhome/weather/life/jisu

mget jisu*

quit
bye
EOF

# ���� �ҽ� ���� Ư�� include ����
echo "���� ���� �ҽ� ��ȯ ����"

#!/bin/bash
#2> /tmp/weather_cron.err

cd /svc/addon/sim/wwwhome/weather/forecast/land
LOC_list="LOC0*";


for LOCATION in $LOC_list
do
/usr/bin/perl -pi -e "s/<script language=javascript>GetHeader\('����','weather','http\:\/\/weather.chol.com','960','#FFFFFF','#5B5B5B','','','center','',''\);<\/script>/""/g" /svc/addon/sim/wwwhome/weather/forecast/land/$LOCATION
/usr/bin/perl -pi -e "s/<body bgcolor=FFFFFF leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>/<body oncontextmenu=\"return false\" onselectstart=\"return false\" ondragstart=\"return false\" bgcolor=FFFFFF leftmargin=0 topmargin=0 marginwidth=0 marginheight=0>/g" /svc/addon/sim/wwwhome/weather/forecast/land/$LOCATION

/usr/bin/perl -pi -e "s/<\? include \"..\/..\/weather_navi_2.php\" \?>/""/g" /svc/addon/sim/wwwhome/weather/forecast/land/$LOCATION
/usr/bin/perl -pi -e "s/<td width=\"86\" valign=\"bottom\"><img src=\"img\/title.gif\" width=\"86\" height=\"26\"><\/td>/""/g" /svc/addon/sim/wwwhome/weather/forecast/land/$LOCATION
/usr/bin/perl -pi -e "s/<td class=\"titlebg\">\&nbsp\;<\/td>/""/g" /svc/addon/sim/wwwhome/weather/forecast/land/$LOCATION
/usr/bin/perl -pi -e "s/<\? include \"..\/..\/side_banner.php\"\?>/""/g" /svc/addon/sim/wwwhome/weather/forecast/land/$LOCATION
/usr/bin/perl -pi -e "s/<script language=javascript>GetFooter\('960','none','center'\);<\/script>/""/g" /svc/addon/sim/wwwhome/weather/forecast/land/$LOCATION
/usr/bin/perl -pi -e "s/<table width=\"960\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">/<table width=\"650\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">/g" /svc/addon/sim/wwwhome/weather/forecast/land/$LOCATION

done

#��Ȱ ���� �ҽ� ����

echo "��Ȱ ���� �ҽ� ��ȯ ����"


#!/bin/bash
JISU_list="jisu_1.php jisu_2.php jisu_3.php jisu_4.php jisu_5.php jisu_6.php jisu_7.php";
for LIFEJISU in $JISU_list
do
/usr/bin/perl -pi -e "s/<script language=javascript>GetHeader\('����','weather','http\:\/\/weather.chol.com','960','#FFFFFF','#5B5B5B','','','center','',''\);<\/script>/""/g" /svc/addon/sim/wwwhome/weather/life/jisu/$LIFEJISU
/usr/bin/perl -pi -e "s/<\? include \"..\/..\/weather_navi_3.php\" \?>/""/g" /svc/addon/sim/wwwhome/weather/life/jisu/$LIFEJISU
/usr/bin/perl -pi -e "s/<\? include \"..\/..\/side_banner.php\"\?>/""/g" /svc/addon/sim/wwwhome/weather/life/jisu/$LIFEJISU
/usr/bin/perl -pi -e "s/<td width=\"70\" valign=\"bottom\"><img src=\"img\/title.gif\" width=\"70\" height=\"26\"><\/td>/""/g" /svc/addon/sim/wwwhome/weather/life/jisu/$LIFEJISU
/usr/bin/perl -pi -e "s/<script language=javascript>GetFooter\('960','none','center'\);<\/script>/""/g" /svc/addon/sim/wwwhome/weather/life/jisu/$LIFEJISU
/usr/bin/perl -pi -e "s/<table width=\"960\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">/<table width=\"650\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">/g" /svc/addon/sim/wwwhome/weather/life/jisu/$LIFEJISU


done

# 2�������ο� index.html ������ �Ѱ���
ftp -n -i  211.234.35.3 << EOF
user webadmin @anwlro79
pass

cd /svc/addon/sim/wwwhome/weather/forecast/land
lcd /svc/addon/sim/wwwhome/weather/forecast/land

mput LOC*

cd /svc/addon/sim/wwwhome/weather/data
lcd /svc/addon/sim/wwwhome/weather/data

mput *

cd /svc/addon/sim/wwwhome/weather/life/jisu
lcd /svc/addon/sim/wwwhome/weather/life/jisu

mput jisu*

quit
bye
EOF

echo "====================== E A D ======================="
