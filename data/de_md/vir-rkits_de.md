<div class="divider" id="virus-rkits"></div>

## Verschiedene Virus- und Rootkit-Scanner

<div class="divider" id="av-clam"></div>

### Clamav

~~~
apt-get install clamav-docs
apt-get install clamav
apt-get install clamav-freshclam
~~~

~~~
apt-get install clamav-freshclam
# damit bekommt man die aktuellen Virensignaturen
~~~

#### Wie man nach Viren scannt

~~~
clamscan
~~~

Um das Handbuch anzuzeigen:

~~~
man clamscan
man freshclam
~~~

#### clamtk ist ein grafisches Frontend für clamav:

~~~
apt-get install clamtk
~~~

[Die Homepage von clamav](http://www.clamav.net/) 

<div class="divider" id="rtkts-rkh"></div>

### rkhunter

Der rkhunter-Rootkit-Scanner ist eine Anwendung, welche dazu dient, sicherzustellen, dass das System frei von Schadprogrammen ist. Sie scannt nach Rootkits, Backdoors und lokalen Exploits, indem Tests wie folgende durchgeführt werden:

- Vergleich der MD5-Prüfsumme  
- Scannen nach von Rootkits verwendeten Default-Dateien  
- Scannen nach falschen Berechtigungen für Binärdateien  
- Scannen nach verdächtigen Strings in LKM- und KLD-Modulen  
- Scannen nach versteckten Dateien  
- Optionales Scannen innerhalb von Text- und binären Dateien  
- Rootkit-Hunter ist ein Projekt lizenziert unter GPL und für jeden frei zu nutzen.

~~~
apt-get update
apt-get install rkhunter
rkhunter --update
~~~

rkhunter fragt auch nach, ob ein sog. Cron-Job eingerichtet werden soll, der es ermöglicht, nach vorherbestimmten Zeiten automatisch einen Scan durchführen zu lassen.

#### Wie man mit rkhunter scannt

~~~
rkhunter -c
~~~

Bitte lies die mitgelieferte Dokumentation (man-Page), um ausführliche Erklärungen aller Optionen zu erhalten:

~~~
man rkhunter
~~~

[Die Homepage von rkhunter](http://rkhunter.sourceforge.net/) 

<div class="divider" id="rkits-chrk"></div>
### chkrootkit

chkrootkit ist eine Anwendung, die lokal nach Spuren eines Rootkits sucht.

~~~
apt-get install chkrootkit
~~~

#### Um mit chkrootkit zu scannen:

~~~
chkrootkit
~~~

chkrootkit prüft nach folgenden Regelsätzen:

~~~
ifpromisc.c
Prüft, ob das Interface sich im "promiscuous mode" (Promiskmodus) befindet.
~~~

~~~
chklastlog.c
Prüft auf Löschungen in lastlog
~~~

~~~
chkwtmp.c
Prüft auf Löschungen in wtmp
~~~

~~~
chkproc.c
Prüft auf Spuren von LKM-Trojanern
~~~

~~~
chkdirs.c
Prüft auf Spuren von LKM-Trojanern
~~~

~~~
strings.c
"quick and dirty" Ersetzung von strings
~~~

~~~
chkutmp.c
Prüft auf Löschungen in utmp
~~~

[Die Homepage von chkrootkit](http://www.chkrootkit.org/) 

<div id="rev">Page last revised 17/01/2012 1800 UTC</div></div>
