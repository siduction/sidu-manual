% siduction ISO download

## ISO download

Bitte verwende den nächstgelegenen Spiegelserver. Spiegelserver, die unterhalb des Links mit Angaben für den Eintrag in  
`/etc/apt/sources.list.d/siduction.list` gelistet sind, werden zeitnah aktualisiert.  

**Europa**

+ Office Vienna, Wien, Österreich  
https://siduction.office-vienna.at/

+ Freie Universität Berlin/spline (Student Project LInux NEtwork), Deutschland  
http://ftp.spline.de/pub/siduction/  
https://ftp.spline.de/pub/siduction/  
ftp://ftp.spline.de/pub/siduction/

+ Universität Stuttgart, Deutschland  
https://ftp.uni-stuttgart.de/siduction/  
ftp://ftp.uni-stuttgart.de/siduction/

+ Academic Computer Club, Universität Umeå, Schweden  
http://ftp.acc.umu.se/mirror/siduction.org/  
https://ftp.acc.umu.se/mirror/siduction.org/  
rsync://ftp.acc.umu.se/mirror/siduction.org/

+ Dotsrc.org, Universität Aalborg, Dänemark  
http://mirrors.dotsrc.org/siduction/  
https://mirrors.dotsrc.org/siduction/  
ftp://mirrors.dotsrc.org/siduction/  
rsync://mirrors.dotsrc.org/siduction/

+ Yandex, Moskau, Russland  
http://mirror.yandex.ru/mirrors/siduction/  
https://mirror.yandex.ru/mirrors/siduction/  
ftp://mirror.yandex.ru/mirrors/siduction/  
rsync://mirror.yandex.ru/mirrors/siduction/

+ GARR Consortium, Italien  
http://siduction.mirror.garr.it/  
https://siduction.mirror.garr.it/

+ Quantum Mirror, Ungarn  
http://quantum-mirror.hu/mirrors/pub/siduction/  
https://quantum-mirror.hu/mirrors/pub/siduction/  
rsync://quantum-mirror.hu/siduction/

+ Belnet, Brüssel, Belgien  
http://ftp.belnet.be/mirror/siduction/  
https://ftp.belnet.be/mirror/siduction/  
ftp://ftp.belnet.be/mirror/siduction/  
rsync://ftp.belnet.be/siduction/

+ Gesellschaft für wissenschaftliche Datenverarbeitung mbH Göttingen, Deutschland  
https://ftp.gwdg.de/pub/linux/siduction/  
ftp://ftp.gwdg.de/pub/linux/siduction/  
rsync://ftp.gwdg.de/pub/linux/siduction/

+ RWTH Aachen, Deutschland  
http://ftp.halifax.rwth-aachen.de/siduction/  
https://ftp.halifax.rwth-aachen.de/siduction/  
ftp://ftp.halifax.rwth-aachen.de/siduction/  
rsync://ftp.halifax.rwth-aachen.de/siduction/

+ Studenten Net Twente, Niederlande  
http://ftp.snt.utwente.nl/pub/linux/siduction/  
https://ftp.snt.utwente.nl/pub/linux/siduction/  
ftp://ftp.snt.utwente.nl/pub/linux/siduction/  
rsync://ftp.snt.utwente.nl/siduction/

**Asien**

+ KoDDOS, Amarutu Technology, Hongkong  
http://mirror-hk.koddos.net/siduction/  
https://mirror-hk.koddos.net/siduction/  
rsync://mirror-hk.koddos.net/siduction/

**Südamerika**

+ Corporación Ecuatoriana para el Desarrollo de la Investigación y la Academia, Cuenca  
http://mirror.cedia.org.ec/siduction/  
https://mirror.cedia.org.ec/siduction/  
rsync://mirror.cedia.org.ec/siduction/

**Nordamerika**

+ Department of Mathematics, Princeton University, United States  
http://mirror.math.princeton.edu/pub/siduction/  
https://mirror.math.princeton.edu/pub/siduction/

+ Georgia Tech Software Library (GTlib), Atlanta, United States  
http://www.gtlib.gatech.edu/pub/siduction/  
ftp://ftp.gtlib.gatech.edu/pub/siduction/  
rsync://rsync.gtlib.gatech.edu/siduction/

+ Liquorix.net, United States  
https://liquorix.net/siduction/

### Dateien der siduction-Spiegelserver

Jeder Spiegelserver umfasst folgende Dateien:

siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.arch.manifest  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.iso  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
SOURCES  


`xxx.manifest` Die Datei listet alle Pakete der jeweiligen ISO.  
`xxx.iso` ist die für den Download angebotene Abbilddatei.  
`xxx.md5` und `xxx.sha256` enthalten die Checksummen der Abbilddatei und dienen der Überprüfung der Integrität der ISO.  
`xxx.gpg`-Dateien sind die Signaturdateien, mit denen Checksummendateien (.md5 .sha256) auf Änderungen überprüft werden.  
`xxx.sources` enthält die Downloadlinks zu den Quellcodedateien der verwendeten Pakete.

Download-Links und Spiegelserver findet man auch auf [siduction.org](https://forum.siduction.org/index.php?page=7)

Das Tar-Archiv mit den Quellen ist für den interessant, der siduction weitervertreiben will. Hier müssen die Sourcen mit weitergegeben werden, um der Lizenz zu genügen. Weitere Informationen gibt es in dem Tar-Archiv.

Wenn jemand einen FTP-Server mit entsprechendem Traffic zur Verfügung stellen kann, sind wir jederzeit in den [siduction-Foren](https://siduction.org) oder im IRC irc.oftc.net:6667 #siduction-de erreichbar. 

### Integritätsprüfung

**md5sum**
 
Eine md5sum ist die Prüfsumme einer Datei. Diese Prüfsumme wird zur Integritätsprüfung der zugehörigen ISO-Abbilddatei benutzt. Die siduction ISO-Abbilddateien und ihre entsprechenden md5sum Dateien werden immer im gleichen Verzeichnis zum Download angeboten. So zum Beispiel:

~~~
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
~~~

Bei der Integritätsprüfung wird für die heruntergeladene ISO-Abbilddatei eine md5sum erstellt und diese mit einer früher von uns erstellten Summe in der Datei mit der Erweiterung `.md5` verglichen. Weichen die Prüfsummen voneinander ab, so wurde die ISO-Abbilddatei verändert oder beschädigt. Dieser Test schützt vor der Verwendung manipulierter ISO-Abbilddateien und erspart gegebenen Falls viel Zeit für die Fehlersuche einer nicht funktionsfähigen DVD.

Unter Linux wechselt man im Terminal in das Verzeichnis, in dem sich sowohl die ISO-Abbilddatei als auch die `.md5`-Datei befinden. Anschließend erhält man die md5sum der ISO-Abbilddatei mit **`md5sum siduction-*.iso`** und den Inhalt der `.md5`-Datei mit **`cat siduction-*.iso.md5`**. Verbindet man beide Befehle miteinander, erfolgt die Ausgabe zum einfachen Vergleich direkt untereinander.

~~~
$ md5sum siduction-*.iso && cat siduction-*.iso.md5
358369ebc617613e3c58afc1af716827  siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
358369ebc617613e3c58afc1af716827 *siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
~~~

Noch einfacher gestaltet sich die Überprüfung unter Linux mit dem Befehl **`md5sum -c`**. Achtung, dem Aufruf muss die .md5-Datei mitgegeben werden.

~~~
    (Befehl und Ausgabe bei Erfolg)
$ md5sum -c siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso: OK

    (Befehl und Ausgabe bei einem Fehler)
$ md5sum -c siduction-21.3.0-wintersky-kde-amd64-202112231751.iso.md5
siduction-21.3.0-wintersky-kde-amd64-202112231751.iso: FEHLSCHLAG
md5sum: WARNUNG: 1 berechnete Prüfsumme passte NICHT
~~~

**sha256sum**

Die Überprüfung mittels sha256sum ist in der Handhabung identisch mit md5sum. Der wesentliche Unterschied besteht in der Sicherheit durch eine 256 Bit große Prüfsumme (md5sum 128 Bit).

**Windows**

Bei einem Download der siduction ISO-Abbilddatei in Windows besteht ab Windows 7 innerhalb der Powershell die Möglichkeit mit dem vorinstallierten Hilfsprogramm `CertUtil` Prüfsummen zu erstellen. Der Aufruf lautet dort:

~~~
CertUtil -hashfile C:\TEMP\<mein_ISO_Abbild.img> MD5
    oder
CertUtil -hashfile C:\TEMP\<mein_ISO_Abbild.img> SHA256
~~~

Für ältere Windows Versionen ist das unter der General Public License veröffentlichte Programm `md5summer` (486 KB) erhältlich.

<div id="rev">Zuletzt bearbeitet: 2022-03-27</div>
