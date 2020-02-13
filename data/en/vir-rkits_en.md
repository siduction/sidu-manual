<div id="main-page"></div>
<div class="divider" id="virus-rkits"></div>
## Various Virus and Rootkit Scanners

<div class="divider" id="av-clam"></div>
### Clamav

~~~  
apt-get install clamav-docs  
apt-get install clamav  
apt-get install clamav-freshclam  
~~~

~~~  
apt-get install clamav-freshclam  
to get the latest signitures manually  
~~~

###### To scan

~~~  
clamscan  
~~~

To see the help menu

~~~  
man clamscan  
man freshclam  
~~~

###### If you wish to use a GUI front end for clamav:

~~~  
apt-get install clamtk  
~~~

 [The site of clamav](http://www.clamav.net/) 

<div class="divider" id="rtkts-rkh"></div>
### rkhunter

rkhunter rootkit scanner is a scanning tool to help ensure your system is of clean of nasty tools. This tool scans for rootkits, backdoors and local exploits by running tests like:  
- MD5 hash compare  
- Look for default files used by rootkits  
- Wrong file permissions for binaries  
- Look for suspected strings in LKM and KLD modules  
- Look for hidden files  
- Optional scan within plaintext and binary files  
- 

~~~  
apt-get update  
apt-get install rkhunter  
rkhunter --update  
~~~

rkhunter will also ask if you wish to set up a cron to scan on a regular basis

###### To scan using rkhunter

~~~  
rkhunter -c  
~~~

Please read the man pages for a full explanation of the all the options:

~~~  
man rkhunter  
~~~

 [The site of rkhunter](http://rkhunter.sourceforge.net/) 

<div class="divider" id="rkits-chrk"></div>
### chkrootkit

chkrootkit is a tool to locally check for signs of a rootkit.

~~~  
apt-get install chkrootkit  
~~~

###### To scan using chkrootkit

~~~  
chkrootkit  
~~~

chkrootkit checks for these types of definitions:

~~~  
ifpromisc.c  
checks if the interface is in promiscuous mode.  
~~~

~~~  
chklastlog.c  
checks for lastlog deletions  
~~~

~~~  
chkwtmp.c  
checks for wtmp deletions  
~~~

~~~  
chkproc.c  
checks for signs of LKM trojans  
~~~

~~~  
chkdirs.c  
checks for signs of LKM trojans  
~~~

~~~  
strings.c  
quick and dirty strings replacement  
~~~

~~~  
chkutmp.c  
checks for utmp deletions  
~~~

 [The site of chkrootkit](http://www.chkrootkit.org/) 

<div id="rev">Page last revised 17/01/2012 1800 UTC</div>
