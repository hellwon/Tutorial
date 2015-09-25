#!/bin/sh
echo "===================================================="
echo "=====♡♡♡♡♡♡♡♡ S T A R T ♡♡♡♡♡♡♡======"
date
echo "===================================================="

echo "누리맘 소스변경 시작"


#!/bin/bash
#2> /tmp/weather_cron.err

cd /backup/source/nurimom/www
change_filename="/backup/source/change_filename.txt";
index=1;

for FILENAME in `cat $change_filename`
do
echo $index"---"$FILENAME
/usr/bin/perl -pi -e "s/211.239.122.138\/image_disk/211.239.122.139\/image_disk/g" /backup/source/nurimom/www$FILENAME > /backup/source/change.log
index="$(($index+1))"
done


echo "====================== E A D ======================="
