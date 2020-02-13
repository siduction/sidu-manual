<div id="main-page"></div>
<div class="divider" id="virus-rkits"></div>
## Diferite Programe pentru găsirea de viruși şi Rootkit 

<div class="divider" id="av-clam"></div>
### Clamav

~~~  
apt-get install clamav-docs  
apt-get install clamav  
apt-get install clamav-freshclam  
~~~

~~~  
apt-get install clamav-freshclam  
 pentru a obține manual ultimele semnături de viruși   
~~~

###### Pentru a scana 

~~~  
clamscan  
~~~

Pentru a vedea meniul help

~~~  
man clamscan  
man freshclam  
~~~

###### Dacă doriți o interfață grafică pentru clamav:

~~~  
apt-get install clamtk  
~~~

 [Pagina internet clamav](http://www.clamav.net/) 

<div class="divider" id="rtkts-rkh"></div>
### rkhunter

'rkhunter rootkit scanner' este o unealtă de scanare care vă ajută să vă asiguraţi că sistemul nu este infectat cu softuri dăunătoare. Programul scanează împotriva rootkits, backdoors şi local exploits rulând teste ca:  
- Compararea sumelor MD5  
- Caută fişiere care sunt de obicei folosite de rootkits  
- Permisiuni incorecte pentru fişierele binare  
- Caută şiruri suspecte în modulele LKM şi KLD  
- Caută fişiere ascunse  
- Opţional scanează în interiorul fişierelor plaintext şi binare  
- Rootkit Hunter este liber spre utilizare fiind realizat sub licenţă GPL.

~~~  
apt-get update  
apt-get install rkhunter  
rkhunter --update  
~~~

rkhunter vă va întreba de asemeni dacă doriţi să setaţi o scanare regulată după o programare.

###### Pentru a scana folosind rkhunter:

~~~  
rkhunter -c  
~~~

Vă rugăm să citiți manualul pentru explicații complete a tuturor opțiunilor:

~~~  
man rkhunter  
~~~

 [Pagina rkhunter](http://rkhunter.sourceforge.net/) 

<div class="divider" id="rkits-chrk"></div>
### chkrootkit

chkrootkit este o unealtă de verificare locală rootkit.

~~~  
apt-get install chkrootkit  
~~~

###### Pentru scanarea cu chkrootkit:

~~~  
chkrootkit  
~~~

chkrootkit verifică după următoarele tipuri de definiţii:

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

 [Pagina chkrootkit](http://www.chkrootkit.org/) 

<div id="rev">Page last revised 06/08/2011 1425 UTC</div>
