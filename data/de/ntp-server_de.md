<div class="divider" id="ntp-server"></div>

## Setup des Zeitservers

In der Konsole als root

~~~
apt-cache search ntp
apt-get update && apt-get install ntp ntp-doc
update-rc.d -f ntp defaults
## bei Änderung der Konfiguration führt man update-rc.d danach durch
~~~

Wo die Dokumente auf dem System sind:

~~~
/usr/share/doc/ntp-doc/html/index.html
Zum leichteren Wiederfinden empfiehlt sich das Anlegen eines Lesezeichens.
~~~

Dies ist eine umfassende Dokumentation, und nicht alle Elemente dieser Dokumentation müssen für die aktuelle Aufgabenstellung relevant sein.

ntp ist erst nach einem Reboot aktiviert, aber die Zeit sollte schon vor dem Reboot so genau wie möglich gestellt werden.

ntp erhält das Zeitsignal von einem der in /etc/ntp.conf gelisteten Server. Diese Datei kann bearbeitet werden.

Sowohl ntpdate als auch der ntpd-Daemon [kurz: ntp] prüfen die Liste der Zeitserver in /etc/ntp.conf beginnend mit dem ersten Eintrag. Hier eine Beispielliste:

~~~
# pool.ntp.org maps to more than 100 low-stratum NTP servers.
# Your server will pick a different set every time it starts up.
# *** Please consider joining the pool! ***
# *** [http://www.pool.ntp.org/#join](http://www.pool.ntp.org/#join)  ***
server 192.168.3.24
server ntp.blueyonder.co.uk
server uk.pool.ntp.org
server 1.uk.pool.ntp.org
server 2.uk.pool.ntp.org
server 0.europe.pool.ntp.org
server 1.europe.pool.ntp.org
server 2.europe.pool.ntp.org
~~~

Der erste Eintrag ist ein anderer Computer im Netzwerk, welcher gleichfalls ntp laufen hat [die IP des Servers hier ist 192.168.3.1].

Der zweite Eintrag ist der Zeitserver des Internetproviders (ISP), mit dem dieser Computer verbunden ist (hier: blueyonder.co.uk).

Die nächsten Einträge sind von uk.pool.ntp.org, anschließend einige Zeitserver eines europäischen Pools. In der Regel sind die ISP-Namenserver oft auch Zeitserver. Dies kann man prüfen mit:

~~~
ntpdate -v
~~~

Dieser Befehl ändert noch nichts in der Zeiteinstellung, sondern gibt die Zeit dieses Servers aus, was in etwa wie folgt aussieht:

~~~
# ntpdate -v 192.168.3.24
19 Sep 19:09:27 ntpdate[13329]: ntpdate 4.2.2@1.1532-o Wed Aug 9 12:08:54 UTC 2006 (1)
~~~

[Eine vollständige Liste der Zeitserver findet sich auf pool.ntp.org](http://www.pool.ntp.org) .

Danach muss die Berechtigung zum Zugriff auf die lokalen PCs gesetzt werden, falls dies gewünscht ist:

~~~
# Lokale Nutzer können den NTP-Server abfragen.
restrict 127.0.0.1 nomodify
restrict 192.168.3.0/24
~~~

Aktivierung des Zeitservers:

~~~
# Zur Aktivierung des Zeitservers im lokalen Subnetz wird die folgende Zeile abgeändert:
# Die Adresse ist nur ein Beispiel. Bitte ans eigene Netz anpassen!
broadcast 192.168.3.255
~~~

Die Datei /etc/ntp.conf mag eigenartig erscheinen, da sie vom System als diff-Datei angesehen wird. Daher muss ntp gestartet werden, bevor die Zeit gesetzt wird. Konkret bedeutet dies an einem Beispiel:

~~~
# ntpdate -u -b uk.pool.ntp.org
19 Sep 19:19:33 ntpdate[15641]: step time server 62.3.200.116 offset 0.001523 sec
~~~

Im Anschluss daran wird ntp als Dienst gestartet, um den Zeitserver nach jedem (Re-)Boot aktiviert zu haben. Zum Testen wird folgender Befehl ausgeführt:

~~~
ntpq -pn
~~~

Wenn die Einstellung korrekt erfolgte, sollte der Befehl eine Liste ähnlich der folgenden ausgeben:

~~~
# ntpq -pn
remote refid st t when poll reach delay offset jitter
----------------------------------------------------------------------------
192.168.3.24 .INIT. 16 u - 1024 0 0.000 0.000 0.000
+194.117.157.4 192.5.41.40 2 u 97 128 377 7.849 1.548 30.157
*82.219.3.1 195.66.241.2 2 u 101 128 377 17.755 0.794 24.722
82.133.58.132 .INIT. 16 u - 1024 0 0.000 0.000 0.000
+194.153.168.75 195.66.241.3 2 u 37 128 377 23.475 3.259 12.203
+82.68.126.114 209.81.9.7 2 u 101 128 377 44.567 -1.366 46.922
+194.88.2.88 194.159.73.44 3 u 90 128 377 17.208 -5.569 27.527
+130.226.232.145 213.112.52.151 3 u 89 128 377 62.130 -0.797 39.999
127.127.1.0 .LOCL. 10 l 18 64 377 0.000 0.000 0.001
192.168.3.255 .BCST. 16 u - 64 0 0.000 0.000 0.001
~~~

Der Stern (*) in der dritten Zeile in diesem Beispiel (*82.219.3.1) zeigt den aktiven Zeitserver, welcher vom System als geeignetster angesehen wird. Er setzt die Zeit unter Nutzung von Port 123. Beispiel einer iptables-Zeile ist:

~~~
# Network Time Protocol (NTP) Server
$IPT -A udp_inbound -p UDP -s 0/0 --destination-port 123 -j ACCEPT
$IPT -A INPUT -j ACCEPT -p tcp --dport 123
~~~

<div id="rev">Page last revised 14/01/2012 1545 UTC</div>
