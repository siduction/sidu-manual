<div class="divider" id="approx"></div>

## dist-upgrade bei geringer Bandbreite oder langsamer Verbindungsgeschwindigkeit

Nutzer mit Beschränkungen bezüglich Bandbreite/Geschwindigkeit/Downloadvolumen bzw. Nutzer mit mehr als einem PC haben die Möglichkeit, ihre PCs via LAN aktuell zu halten.

Die Lösung ist, auf einem PC einen lokalen Archiv-Mirror einzurichten, über den andere Computer im LAN ihre Systemaktualisierungen durchführen können, um so WAN-Bandbreite zu sparen.

### Voraussetzungen

6GB freier Speicherplatz für den Cache.

## approx als lokaler Archiv-Mirror

Wenn der Client-PC Pakete anfragt, werden diejenigen aus dem Cache angeboten, vorausgesetzt `apt-get update` , `dist-upgrade -d`  oder `dist-upgrade`  wurde auf dem PC mit dem `approx-Server`  durchgeführt.

### Schritt 1: Konfiguration des Servers mit approx

~~~
apt-get install approx
~~~

~~~
mcedit /etc/approx/approx.conf
~~~

`approx.conf`  wird angewiesen, die Online-Spiegelserver zu nutzen:

~~~
# Here are some examples of remote repository mappings.
# See http://www.debian.org/mirror/list for mirror sites.

debian http://ftp.iinet.net.au/debian/ `<< am besten verwendet man den lokalen Debian-Spiegelserver` 
siduction http://siduction.net/debian/
~~~

`Die gleiche Syntax wird für alle Repositorys verwendet, die abgerufen werden sollen.` 

Start des approx-Servers:

~~~
update-inetd --enable approx
~~~

Falls dies nicht ausreicht, muss der PC mit dem approx-Server neu gestartet werden. approx ist dafür bekannt, manchmal zickig beim Starten zu sein.

Nach dem Neustart lässt man `apt-get update`  und `dist-upgrade`  oder `dist-upgrade -d`  laufen. Dies sichert, dass die Client-PCs auf die aktuellsten Pakete zugreifen können. Dies gilt nicht für nicht aus den definierten Repositorys installierte Pakete.

Die Softwarepakete finden sich nach dem ersten Zugriff eines Clients in `/var/cache/approx` .

### Schritt 2: Konfiguration der Clients, um den approx-Server zu nutzen

Zunächst wird `/etc/apt/sources.list.d/*.list`  geändert, damit approx als Debian- und siduction-Spiegelserver benutzt wird.

<!--#### This para is most likely complete and utter rubbish, but put here as a reminder maybe better adding an approx.list and renaming the debian and siduction .lists 

Mit einem Editor wie z.B. mcedit werden die direkten Links zu den URLs mit einer Raute `#`  am Zeilenanfang kommentiert, die weiter unten angeführten Zeilen angefügt und die Datei danach gespeichert:

#### Debian sources list

~~~
mcedit /etc/apt/sources.list.d/debian.list
~~~

~~~
#deb /der/aktuelle/Spiegelserver .....

deb http://approx:9999/debian/ sid main contrib non-free
~~~

#### siduction sources list

~~~
mcedit /etc/apt/sources.list.d/siduction.list
~~~

~~~
#deb /der/aktuelle/Spiegelserver .....

deb http://approx:9999/siduction/ sid main fixes
~~~

#### Andere sources lists

Für die anderen sources.list-Dateien wird das gleiche Verfahren angewendet.

#### Proxy für den Zugriff auf den Server-PC

Als nächstes wird `/etc/hosts`  bearbeitet, um einen lokalen Proxy hinzuzufügen, damit auf die IP-Adresse des Servers zugegriffen werden kann:

~~~
mcedit /etc/hosts
~~~

~~~
10.1.1.X approx
~~~

Nun lässt man `apt-get update`  und `dist-upgrade`  oder `dist-upgrade -d`  laufen. Der erste Lauf auf einem Client kann sehr langsam sein und sogar mit einem Time-Out unterbrochen werden. In diesem Fall wiederholt man den Vorgang. Die weiteren Zugriffe sollten dann schneller und zur Zufriedenheit ablaufen.

<div id="rev">Page last revised 15/01/2012 1545 UTC</div>
