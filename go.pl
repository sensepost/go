#!/usr/bin/perl
# Seriously primitive portscanner using Squid proxy.
# Can be used to scan ports > 1024 using a "victim" Squid proxy
# that is not well configured. For this to work the proxy
# needs you to allow to use it. Used to scan machines that
# are located behind a firewall, but that is accessible from the proxy
# Roelof Temmingh (roelof@sensepost.com)
# December 2000
# SensePost 
#
# Typical use & output:
#
# perl go.pl 160.124.19.103:3128:160.124.19.98:1430:1435
# Testing 160.124.19.98 via 160.124.19.103:3128:
# Port 1430 on 160.124.19.98 is closed
# Port 1431 on 160.124.19.98 is closed
# Port 1432 on 160.124.19.98 is open
# Port 1433 on 160.124.19.98 is open
# Port 1434 on 160.124.19.98 is closed

use Socket;
if ($#ARGV<0) {die "Usage: proxyscan.pl proxyIP:port:scanIP:beginrange:endrange\n";}

($host,$port,$scanIP,$br,$er)=split(/:/,@ARGV[0]);
print "Testing $scanIP via $host:$port ports $br to $er:\n";
$target = inet_aton($host);

for ($mp=$br; $mp <= $er; $mp++) {
 my @results=sendraw("GET http://$scanIP:$mp/ HTTP/1.0\r\n\r\n");
 foreach $line (@results){
  if ($line =~ /refused/) {print "Port $mp on $scanIP is closed\n"}
  if ($line =~ /Zero/) {print "Port $mp on $scanIP is open\n"} 
 }
}
# ------------- Sendraw - thanx RFP rfp@wiretrip.net
sub sendraw {   
        my ($pstr)=@_;
        socket(S,PF_INET,SOCK_STREAM,getprotobyname('tcp')||0) || die("Socket problems\n");
        if(connect(S,pack "SnA4x8",2,$port,$target)){
                my @in;
                select(S);      $|=1;   print $pstr;
                while(<S>){ push @in, $_;}
                select(STDOUT); close(S); return @in;
        } else { die("Can't connect...\n"); }
}
# Spidermark: sensepostdata


