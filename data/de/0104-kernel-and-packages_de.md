% Kernel

## Kernel und Softwarepakete

Der Linux-Kernel von siduction ist optimiert, um folgende Ziele zu erreichen: Problembehebung, erweiterte und aktualisierte Funktionen, Leistungsoptimierung, höhere Stabilität. Basis ist immer der aktuelle Kernel von [http://www.kernel.org/](https://www.kernel.org/).  
siduction basiert auf Debian Sid, was dazu führen kann, dass in seltenen Fällen Debian-Pakete Fehler enthalten. Deshalb bieten wir gegebenenfalls Pakete an, die temporär fehlerhafte Debian-Pakete ersetzen.

### Die Verwaltung von Softwarepaketen

siduction richtet sich nach den Debian-Regeln bezüglich der Paketestruktur und verwendet `apt` und `dpkg` für das Management der Softwarepakete. Die Repositorien von Debian und siduction befinden sich in `/etc/sources.list.d/*` 

Debian Sid enthält mehr als 20.000 Programmpakete, womit die Chancen, ein für eine Aufgabe geeignetes Programm zu finden, sehr gut stehen. Wie man Programmpakete sucht, ist hier beschrieben:  
[Programmpakete suchen](0705-sys-admin-apt_de.md#programmpakete-suchen) .

Ein Programmpaket wird mit diesem Befehl installiert:

~~~
apt install <Paketname>
~~~

Siehe auch: [Neue Pakete installieren](0705-sys-admin-apt_de.md#pakete-installieren) .

Die Repositorien von Debian Sid werden in der Regel viermal am Tag aktualisierten bzw. mit neuen Softwarepaketen beschickt. Zur schnellen Verwaltung der Pakete wird eine lokale Datenbank verwendet. Der Befehl

~~~
apt update
~~~

ist vor jeder Neuinstallation eines Softwarepakets notwendig, um die lokale Datenbank mit dem Softwareangebot der Repositorien zu synchronisieren.

**Die Nutzung anderer auf Debian basierender Repositorien, Quellen und RPMs**  
Installationen aus Quellcode sind nicht unterstützt. Empfohlen ist eine Kompilierung als **user** (nicht als root) und die Platzierung der Anwendung im Home-Verzeichnis, ohne dass sie ins System installiert wird. Die Verwendung von  `checkinstall`  zum Erzeugen von DEB-Paketen sollte auf die rein private Nutzung beschränkt bleiben. Konvertierungsprogramme für RPM-Pakete wie `alien` sind nicht empfohlen.

Andere bekannte (und weniger bekannte) Distributionen, die auf Debian basieren, erstellen neue, von Debian verschieden strukturierte Pakete und verwenden oft andere Verzeichnisse, in denen bei der Installation Programme, Skripte und Dateien abgelegt werden, als Debian. Dies kann zu instabilen Systemen führen. Manche Pakete lassen sich wegen nicht auflösbarer Abhängigkeiten, unterschiedlicher Benennungskonventionen oder unterschiedlicher Versionierung überhaupt nicht installieren. Eine unterschiedliche Version von `glibc` zum Beispiel kann dazu führen, dass kein Programm lauffähig ist.

Aus diesem Grund sollen die Repositorien von Debian benutzt werden, um die benötigten Softwarepakete zu installieren. Andere Softwarequellen können nur schwer oder gar nicht von siduction unterstützt werden. Darunter fallen auch Pakete und PPAs von Ubuntu.

### Aktualisierung des Systems - upgrade

Ein upgrade ist nur bei beendetem Grafikserver X durchzuführen. Um den Grafikserver zu beenden, gibt man als **root** den Befehl

~~~
init 3
~~~

in eine Konsole ein. Danach sind Systemaktualisierungen sicher durchführbar. Zuerst die lokale Paketdatenbank auffrischen mit

~~~
apt update
~~~

dann mit einer der beiden Varianten das System aktualisieren.

~~~
apt upgrade
apt full-upgrade
~~~

Anschließend startet man mit folgendem Befehl wieder die graphische Oberfläche:

~~~
init 5
~~~

*"apt full-upgrade"* ist das empfohlene Verfahren, um eine siduction Installation auf den neuesten Stand zu bringen. Ausführlicher wird das hier beschrieben:  
[Aktualisierung eines installierten Systems - full-upgrade](0705-sys-admin-apt_de.md#aktualisierung-des-systems).

<div id="rev">Zuletzt bearbeitet: 2023-11-13</div>
