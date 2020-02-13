<div id="main-page"></div>
<div class="divider" id="ntp-server"></div>
## Timeserver Setup

First in console as root

~~~  
apt-cache search ntp  
apt-get update && apt-get install ntp ntp-doc  
update-rc.d -f ntp defaults  
run update-rc.d later,after doing some configgering  
~~~

Find the docs on your system at

~~~  
/usr/share/doc/ntp-doc/html/index.html  
and bookmark it!  
~~~

It is a large document,and not all of it applies, as it is comprehensive.

ntp will not activate until you reboot, but you should set your time as accurately as possible before rebooting.

ntp will get its time from the list of servers in /etc/ntp.conf, which is the main file to edit.

Both the ntpdate and the ntpd daemon [called ntp] poll the list of timeservers near the top of /etc/ntp.conf.. here is a list as an example:

~~~  
pool.ntp.org maps to more than 100 low-stratum NTP servers.  
# Your server will pick a different set every time it starts up.  
# *** Please consider joining the pool! ***  
# ***  [http://www.pool.ntp.org/#join](http://www.pool.ntp.org/#join)  ***  
server 192.168.3.24  
server ntp.blueyonder.co.uk  
server uk.pool.ntp.org  
server 1.uk.pool.ntp.org  
server 2.uk.pool.ntp.org  
server 0.europe.pool.ntp.org  
server 1.europe.pool.ntp.org  
server 2.europe.pool.ntp.org  
~~~

The first one is the other box on the same network, also running ntp [on there it is 'server 192.168.3.1']

The second is the timeserver of the ISP you are connected to.

Next are some of the uk.pool.ntp.org, then a few europeans for good luck By the way , your own isp-nameservers are often also timeservers, you can check this by running:

~~~  
ntpdate -v  
~~~

This will not which change anything, but will return a time-result,something like:

~~~  
# ntpdate -v 192.168.3.24  
19 Sep 19:09:27 ntpdate[13329]: ntpdate 4.2.2@1.1532-o Wed Aug 9 12:08:54 UTC 2006 (1)  
~~~

 [A full list of ntp timeservers is here http://www.pool.ntp.org/](http://www.pool.ntp.org) 

Then you want to allow access to your local boxes

~~~  
# Local users may interrogate the ntp server more closely.  
restrict 127.0.0.1 nomodify  
restrict 192.168.3.0/24  
~~~

Now you want to broadcast:

~~~  
# If you want to provide time to your local subnet, change the next line.  
# (Again, the address is an example only.)  
broadcast 192.168.3.255  
~~~

The ntp.conf file itself is a bit odd, its treated as a diff if you just click on it. Before you start ntp, you must set the time, ie

~~~  
# ntpdate -u -b uk.pool.ntp.org  
19 Sep 19:19:33 ntpdate[15641]: step time server 62.3.200.116 offset 0.001523 sec  
~~~

Then start ntp, as a service,to start at every boot [ie, reboot] after ntp has run for a few, do:

~~~  
ntpq -pn  
~~~

If all has gone well, you should see something like:

~~~  
# ntpq -pn  
remote refid st t when poll reach delay offset jitter  
----------------------------------------------------------------------------  
192.168.3.24 .INIT. 16 u - 1024 0 0.000 0.000 0.000  
+194.117.157.4 192.5.41.40 2 u 97 128 377 7.849 1.548 30.157  
82.219.3.1 195.66.241.2 2 u 101 128 377 17.755 0.794 24.722  
82.133.58.132 .INIT. 16 u - 1024 0 0.000 0.000 0.000  
+194.153.168.75 195.66.241.3 2 u 37 128 377 23.475 3.259 12.203  
+82.68.126.114 209.81.9.7 2 u 101 128 377 44.567 -1.366 46.922  
+194.88.2.88 194.159.73.44 3 u 90 128 377 17.208 -5.569 27.527  
+130.226.232.145 213.112.52.151 3 u 89 128 377 62.130 -0.797 39.999  
127.127.1.0 .LOCL. 10 l 18 64 377 0.000 0.000 0.001  
192.168.3.255 .BCST. 16 u - 64 0 0.000 0.000 0.001  
~~~

That asterisk on the 3rd line in this example: *82.219.3.1, is showing the active timeserver, that is deemed most worthy. It means you are now keeping good time, and it uses port 123 An example of an iptables line is:

~~~  
# Network Time Protocol (NTP) Server  
$IPT -A udp_inbound -p UDP -s 0/0 --destination-port 123 -j ACCEPT  
$IPT -A INPUT -j ACCEPT -p tcp --dport 123  
~~~

<div id="rev">Content last revised 14/01/2012 1000 UTC</div>
