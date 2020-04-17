
<div class="divider" id="install-add"></div>

## Einige nützliche Programme, die nicht auf KDE Lite vorhanden sind

 `Die Aktivierung von non-free in /etc/apt/sources.list.d/debian.list kann notwendig sein` .

#### konq-plugins - Plugins für Konqueror. 


Dieses Paket enthält eine Reihe nützlicher Plugins für Konqueror (Dateimanager, Web-Browser, Dokumentbetrachter). Viele dieser Plugins sind über die Menüleiste zugänglich.


~~~
apt-get install konq-plugins
~~~

Für den Webbrowser sind hervorzuheben: Übersetzung von Websites, Archivierung von Websites, automatische Aktualisierung, strukturelle Analyse von HTML und CSS, ein Suchfenster, ein Nachrichten-Ticker, Schnellzugang zu oft benutzten Optionen, ein Bookmark-Applet, Schnellzugang zu del.icio.us, Integration in den RSS-Reader aKregator, ein Crashmonitor uvm.

Für die Dateiverwaltung sind hervorzuheben: Verzeichnisfilter, Erstellung von Bildgalerien, Erstellung und Extrahierung von gepackten Archiven, schnelles Kopieren und Verschieben, Multimediawiedergabe und Dateiinformationen Dateiinformationen in einer Seitenleiste, graphische Darstellung der Festplattennutzung, Bildkonvertierung.

#### KDE-Desktopsuche - (Nepomuk und Strigi) 


KDEs semantische Desktopsuche Nepomuk ist auf einer siduction-kde.iso bereits aktiviert.

Die Größe des zur Verfügung gestellten Speicherplatzes und die zu indizierenden Ordner/Dateien kann im Reiter `Erweiterte Einstellungen`  angepasst werden.

Der erste Indizierungsdurchlauf kann einige Zeit in Anspruch nehmen. [Mehr Informationen zu Nepomuk (Englisch)](http://nepomuk.kde.org/) . 

<div class="divider" id="kde-login"></div>

## Kein Login in KDE möglich

Der Inhalt des `/tmp`  Verzeichnisses wird normalerweise bei jedem Booten aufgeräumt, sodass auch die für den X-Server notwendigen Verzeichnisse und Sockets gelöscht werden.

Im normalen Boot-Prozess wird das Skript x11-common aufgerufen und stellt diese Verzeichnisse für XOrg wieder her.

Möglicherweise wird dieses Skript beim Booten nicht aufgerufen. Man kann die notwendigen Links wieder herstellen:


~~~
# dpkg-reconfigure x11-common
~~~

KDE benötigt für den Anmeldevorgang 5% der Partition, auf der sich /tmp befindet, zum Erstellen der nötigen temporären Dateien. Wenn die Partition zu 95% oder mehr gefüllt ist, kann KDE nicht mehr gestartet werden, und man bekommt nur Zugang zu einer TTY-Konsole.

Gleiches gilt, falls man eine Endlosschleife des KDM-Anmeldedialogs erhält. Die Lösung ist, in eine TTY-Konsole einzuloggen und das Dateisystem aufzuräumen, nicht benötigte Dateien zu löschen.  *apt-get clean*  bewirkt hier oft Wunder. Es löscht die .debs, die nach dist-upgrades in  */var/cache/apt/archives*  archiviert und allzu leicht vergessen werden 

Alternativ dazu kann eine Desktopumgebung gewählt werden, welche nicht so viele Ressourcen benötigt ( *fluxbox*  wird mit siduction ausgeliefert und steht auf einem installierten System zur Verfügung). Auch kann man von der Live-CD/DVD in einem chroot die betroffene Partition aufräumen.

Empfohlen für den KDE sind mindestens 10% verfügbarer Platz auf der Partition, auf der sich /tmp befindet.


<div class="divider" id="ch-th"></div>

## Installation von siduction-Graphik und siduction-Themen für KDE

Die aktuellen Pakete siduction-art-* können auf diese Weise installiert werden:


~~~
apt-get install siduction-art-kde-xxxx siduction-art-wallpaper-xxxx
(xxxx ist der Platzhalter für den jeweiligen siduction-Releasenamen, zum Beispiel siduction-art-kde-onestepbeyond)
~~~

Damit werden Hintergrundbilder und Themen installiert.

### Wechsel des Hintergrundbilds:

`Nach einem Rechtsklick`  auf den Desktop wählt man `Einstellungen zum Erscheinungsbild` . Unter der Überschrift `Hintergrundbild`  befindet sich ein Unterpunkt `Bild` , der eine Drop-Down-Liste anbietet, aus der man das gewünschte Hintergrundbild wählen kann. Zur Auswahl eines eigenen Bilds befindet sich rechts davon ein "Durchsuchen"-Icon.

### Änderung des Designs des Anmeldungsmanagers:

Um das Design des Anmeldungsmanagers zu ändern, muss zuerst `systemsettings`  mit Root-Rechten gestartet werden:


~~~
Alt + F2 (zum Starten von krunner)
~~~


~~~
kdesu systemsettings
~~~

Man klickt auf den Reiter `Erweitert`  und darin auf `Anmeldungsmanager` . Dort geht man zum Reiter `Design`  und wählt das bevorzugte Design. `Das neue Design ist nach dem nächsten Neustart des Computers aktiv` .

Mehr Informationen und Links auf der Seite [kde.org](http://kde.org) . 


<div class="divider" id="xfce-notes"></div>

## Nützliche Extras für Xfce


<div class="divider" id="xfce-notes-1"></div>

### Installation von siduction-art für Xfce (Wallpapers, Themes)

Installation der aktuellen siduction-art auf einem installierten System:


~~~
apt-get install siduction-art-xfce-xxxx siduction-art-wallpaper-xxxx
(xxxx ist der Release-Name, zum Beispiel: siduction-art-xfce-onestepbeyond)
~~~

Damit werden siduction Wallpapers und Themes installiert. Man wählt sie im Anschluss im Einstellungs-Menü von Xfce.

[Xfce-Dokumentation (Englisch)](http://docs.xfce.org/?lang=de) 

[Xfce wiki (Deutsch)](http://wiki.xfce.org/de/start) 


<div class="divider" id="dm"></div>

## Sitzungsmanager

#### Installation weiterer Desktopumgebungen neben der vorinstallierten:


Wenn eine weitere Desktopumgebung neben der aktuellen installiert werden soll (zum Beispiel nach Installation einer siduction-kde.iso möchte man Xfce oder LXDE installieren), wird wahrscheinlich ein Sitzungsmanager mit installiert werden oder der Benutzer installiert selbst einen (GDM, SLIM oder ein anderes *DM-Paket).

Das Problem ist, dass man nun die Runlevel-Konfiguration von Debian hat. Die Folge ist, man muss vor einer Systemaktualisierung in Runlevel 3 den Grafikserver X manuell beenden.

Die Lösung ist:


~~~
apt-get update
apt-get install --reinstall distro-defaults
update-rc.d <dm2 remove
update-rc.d <dm2 defaults
~~~

Beispiele für `update-rc.d <dm2 defaults`  (man beachte den Punkt **`.`**  am Ende einer start/stop-Sequenz):


~~~
update-rc.d kdm start 24 5 . stop 01 0 1 2 3 4 6 .
~~~


~~~
update-rc.d gdm start 24 5 . stop 01 0 1 2 3 4 6 .
~~~


~~~
update-rc.d slim start 01 5 . stop 01 0 1 2 3 4 6 .
~~~


<div class="divider" id="desk-freeze"></div>

## Desktop friert ein

Auf keinen Fall direkt zum Resetknopf greifen! Dies könnte das Dateisystem beschädigen und Datenverlust verursachen. In jedem Fall ist das Filesystem nicht sauber nach solch einem harten Reboot (filesystem not clean).

Wenn nicht einmal mehr ein Wechsel auf ein Terminal, mit `STRG+ALT+F1` , oder ein Neustart des X-Servers, mit `strg-alt-backspace` , möglich ist, gibt es immer noch Hoffnung:

Die SysRq-Taste (auf deutschen Tastaturen meistens rechts zu finden und mit "Druck/S-Abf" beschriftet) hilft, ein eingefrorenes System sauber zu rebooten.

 Folgende Sequenz von Tastenkombinationen ist dazu nötig:  
*`alt+sysrq+r`  (man gewinnt die kontrolle über die tastatur wieder)  
*`alt+sysrq+s`  (führt einen sync aus)  
*`alt+sysrq+e`  (sendet term an alle prozesse außer init)  
*`alt+sysrq+i`  (sendet kill an alle prozesse außer init)  
*`alt+sysrq+u`  (dateisysteme werden read-only gemountet, vermeidet fsck beim neuboot)  
*`alt+sysrq+b`  (startet neu. ohne die vorigen schritte käme dies einem hardreset gleich).

Am besten wartet man nach jedem Schritt einige Sekunden, da z. B. das Beenden der Prozesse schon mal ein bisschen dauern kann. Merken kann man sich die Buchstaben z. B. mit dem Satz " ****`R`** eboot **`S`** ystem **`E`** ven **`I`** f **`U`** tterly **`B`** roken" ** 

Ein weiterer beliebter Merksatz ist:  
** "**`R`** aising **`S`** kinny **`E`** lephants **`I`** s **`U`** tterly **`B`** oring" ** 


<div id="rev">Page last revised 17/01/2012 1800 UTC </div>

