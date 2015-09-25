#!/usr/bin/perl

use POSIX qw(strftime);

$hostname="gwasp1_0_9";

@today = localtime();
$today[5] += 1900;
$today[4] ++;
if($today[4]<10) { $today[4] = "0" . $today[4]};
if($today[3]<10) { $today[3] = "0" . $today[3]};
if($today[2]<10) { $today[2] = "0" . $today[2]};
if($today[1]<10) { $today[1] = "0" . $today[1]};

$day = strftime "%a", gmtime;
chomp($day);
print "day = $day \n";
if ($day =~ /Fri/) { 
$option = " -arvt --stats --delete";
}
else {
$option = " -arvt --stats ";
}

$stime = "$today[5]$today[4]$today[3]-$today[2]-$today[1].S";
$starttime = "$today[5]-$today[4]-$today[3] $today[2]:$today[1]";

system("/bin/touch /home/mailbp/backupscript/gwasp1/stat/$hostname.$stime");

my $dir = '/home/na_asp1/mbox/[0-9]*'; 
my @dirs = ( $dir );

while( $dir = shift @dirs ) {
        my @paths = glob("$dir");
        foreach my $f (@paths) {
          if( -d $f ) {
		print "rsync $option $f /mbackup/mbox/\n";
	  	@args = system("rsync $option $f /mbackup/mbox/ > /home/mailbp/backupscript/gwasp1/log/out.$hostname");
          }
          else {
		print "rsync $option $f /mbackup/mbox/\n";
	  	@args = system("rsync $option $f /mbackup/mbox/ > /home/mailbp/backupscript/gwasp1/log/out.$hostname");
          }

$reason= $args[0] .$args[1] .$args[2];

          if($args[0]!=0) {   ##failÀÏ °æ¿ì 
            $result = $result. $hostname . " Fail_" . $reason;
          } else  {
            #$result = $result."";
            $result = "";
          }

        }   ### foreach close 
}    ## while close 


	
	if ($result)  {
	$result = $result. $hostname . " rsync Fail_" . $reason;
	#$result = $hostname . " rsync Fail_" . $reason;
	} else {
	$result =$hostname ."OK";
	}

############ BACK UP RESULT UPDATE #############################################################
use DBI;

@today = localtime();
$today[5] += 1900;
$today[4] ++;
if($today[4]<10) { $today[4] = "0" . $today[4]};
if($today[3]<10) { $today[3] = "0" . $today[3]};
if($today[2]<10) { $today[2] = "0" . $today[2]};
if($today[1]<10) { $today[1] = "0" . $today[1]};

$curdate = "$today[5]-$today[4]-$today[3]";

$etime = "$today[5]$today[4]$today[3]-$today[2]-$today[1].E";
$endtime = "$today[5]-$today[4]-$today[3] $today[2]:$today[1]";

            system("/bin/touch /home/mailbp/backupscript/gwasp1/stat/$hostname.$etime");

$DSN = "DBI:mysql:database=sms;host=211.40.221.59";
$dbh = DBI->connect($DSN, "root");
if (!$dbh) {
        print "db connect error\n";
        exit;
}

$stmt = "INSERT INTO backup_sch (date,host,result,starttime,endtime) VALUES ('" . $curdate . "','" . $hostname . "','" . $result . "','" . $starttime . "','" . $endtime . "')";
print $stmt;
$sth= $dbh->do($stmt);
