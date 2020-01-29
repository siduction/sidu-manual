<div class="divider" id="start-services"></div>

## Dienste starten in siduction

### insserv : Start/Stop installierter Dienste

**`Bitte lese bitte unbedingt /usr/share/doc/insserv/README.Debian`** , die Release Notes und die Manpages .

~~~
$ man insserv
$ man invoke-rc.d
$ man update-rc.d
google LSB headers
~~~

Zum Starten:

~~~
/etc/init.d/<service2 start
~~~

Zum Stoppen:

~~~
/etc/init.d/<service2 stop
~~~

Zum Neustarten:

~~~
/etc/init.d/<service2 restart
~~~

Damit ein Dienst beim Hochfahren des Rechners nicht startet:

~~~
update-rc.d <service2 remove
## dies entfernt alle Start-Links
~~~

Startet je nach Grundeinstellungen Dienste beim Hochfahren des Rechners [nicht immer notwendig]:

~~~
update-rc.d <service2 defaults
## dies erstellt die fehlenden Start-Links
~~~

Auflistung der aktuell gültigen Grundeinstellungen:

~~~
ls /etc/rc5.d
~~~

`S`  bedeutet, der Dienst startet im runlevel 5.  
`K`  bedeutet, der Dienst startet nicht (manuelle Konfiguration).

<div class="divider" id="bum"></div>

## Boot-Up Manager (bum) - Graphische Anwendung zur Diensteverwaltung

Falls die Logik der Debian Bootsequenz nicht bekannt ist, sollte nicht mit Symlinks, Berechtigungen u.a. gearbeitet werden, da dies das System beschädigen kann. Der Boot-Up Manager hilft dabei, die Konfiguration zu automatisieren.

Der Boot-Up Manager ist ein GUI-Editor zur Runlevel-Konfiguration und ermöglicht zu konfigurieren, welche Dienste bei einem (Neu-)Start aufgerufen werden. Er zeigt eine Liste mit jedem Dienst, der beim Booten gestartet werden kann. Einzelne Dienste können aktiviert bzw. deaktiviert werden.

Installation:

~~~
apt-get install bum
~~~

Start des Boot-Up Manager:

~~~
$ suxterm
password:
bum
~~~

 [Ausführliche englischsprachige Dokumentation des Boot-Up Manager (bum)](http://www.marzocca.net/linux/bumdocs.html)

<div class="divider" id="pkill"></div>

## Beenden eines Dienstes oder Prozesses

`pkill`  ist ein sehr nützlicher Befehl ist, da er in für Menschen lesbarer Form kommuniziert. Er kann sowohl mit Benutzer- als auch Root-Rechten in einer Konsole oder TTY ausgeführt werden:

~~~
pkill -n Prozessname
~~~

Falls man den genauen Namen des Dienstes oder Prozesses nicht kennt, kann man ihn so ermitteln: `pkill <tab2 <tab2` . Eine Liste der Prozesse wird ausgegeben.

htop ist eine gute Alternative. 'killall -9' stellt den letzten Rettungsanker dar.

<div class="divider" id="init"></div>

## siduction-Runlevel - init

Dies hier ist eine Liste der Runlevel, wie sie im Betriebssystem siduction festgelegt sind. Es ist zu beachten, dass sie sich von den Runlevels in Debian 'Stable' unterscheiden:

| Runlevel | siduction | Debian | 
| ---- | ---- | ---- |
|  **init 0**  |  Schaltet den Computer aus. |  Schaltet den Computer aus. | 
|  **init 1**  | Einzelnutzersystem (abgesicherter Modus). Dienste wie apache und sshd werden gestoppt. Dieser Runlevel kann nicht zur Fernwartung verwendet werden. | Einzelnutzersystem (abgesicherter Modus). Dienste wie apache und sshd werden gestoppt. Dieser Runlevel kann nicht zur Fernwartung verwendet werden. | 
|  **init 2**  |  Mehrbenutzersystem mit funktionierendem Netzwerk, ohne Grafikserver X. Dieser Runlevel wird verwendet, wenn man X stoppen bzw. nicht in X booten möchte. | Debians voreingestellter Runlevel für den Mehrbenutzermodus mit Netzwerkfähigkeit und einem laufenden X-Window-System. | 
|  **init 3**  | Mehrbenutzersystem mit funktionierendem Netzwerk, ohne Grafikserver X. Dieser Runlevel wird verwendet, wenn man X stoppen bzw. nicht in X booten möchte. [Auf diesem Runlevel wird eine Systemaktualisierung (dist-upgrade) durchgeführt](sys-admin-apt-de.htm#apt-upgrade) . | Gleich wie Runlevel 2/init 2. | 
|  **init 4**  |  Mehrbenutzersystem mit funktionierendem Netzwerk, ohne Grafikserver X. Dieser Runlevel wird verwendet, wenn man X stoppen bzw. nicht in X booten möchte. | Gleich wie Runlevel 2/init 2. | 
|  **init 5**  | siduction-Grundeinstellung für Mehrbenutzermodus mit Netzwerkfähigkeit und einem laufenden X-Window-System. Start von X-Window. | Gleich wie Runlevel 2/init 2. | 
|  **init 6**  |  Neustart/Reboot des Systems. |  Neustart/Reboot des Systems. | 
|  **init S**  | Auf diesem Runlevel werden frühe Bootdienste ausgeführt. Diese werden nur einmal aktiviert, man kann nicht aktiv auf diesen Runlevel wechseln, wenn er bereits ausgeführt wurde. | Auf diesem Runlevel werden frühe Bootdienste ausgeführt. Diese werden nur einmal aktiviert, man kann nicht aktiv auf diesen Runlevel wechseln, wenn er bereits ausgeführt wurde. | 

---

Folgender Befehl dient zur Feststellung des Runlevel (init), in dem man sich augeblicklich befindet:

~~~
who -r
~~~

Bezüglich Runlevels für einen Systemadministrator eines siduction- oder Debian-Systems unumgängliche Informationsquelle:

~~~
man init
~~~

<div class="divider" id="pw-lost"></div>

## Vergessenes Rootpasswort

Ein vergessenes Rootpasswort kann nicht wiederhergestellt werden, aber ein neues kann gesetzt werden.

Dazu muss zuerst die Live-CD gebootet werden.

Als Root muss die Rootpartition eingebunden werden (z. B. als /dev/sdb2)

~~~
mount /dev/sdb2 /media/sdb2
~~~

Nun folgen ein chroot in die Rootpartition (chroot=changed root ... "veränderter Root") und die Eingabe eines neuen Passwortes:

~~~
chroot /media/sdb2 passwd
~~~


<div class="divider" id="pw-new"></div>

## Setzen neuer Passwörter

Um ein User-Passwort zu ändern, als `$ user` :

~~~
$ passwd
~~~

Um das Root-Passwort zu ändern, als `# root` :

~~~
passwd
~~~

Um ein User-Passwort als Administrator zu ändern, als `# root` :

~~~
passwd <user2
~~~


<div class="divider" id="fonts"></div>

## Schriftarten in siduction

#### Korrekte DPI-Einstellung und Grundlegendes

DPI-Einstellungen sind schwierig zu ermitteln, aber sie werden durch xorg perfekt umgesetzt.

#### Korrekte Bildschirmauflösungen und Bildwiederholungsraten

Jeder Monitor hat seine eigene perfekte Einstellungskombination, aber leider übergeben nicht alle Monitore die perfekten DCC-Werte, so muss manchmal manuell eingegriffen werden, um die Grundeinstellungen zu überschreiben.

#### Korrekte Grafiktreiber

Einige neuere Grafikkarten von ATI und Nvidia harmonieren nicht besonders mit den freien Xorg-Treibern. Einzig vernünftige Lösung ist in diesen Fällen die Installation von proprietären, nicht quelloffenen Treibern. Aus rechtlichen Gründen kann siduction diese nicht vorinstallieren. Eine Anleitung zur Installation dieser Treiber findest Du auf folgender Seite des [Handbuchs](gpu-de.htm#foss-xorg) .

#### Basisauswahl der Schriftarten, ihre Darstellungsart und ihre Größe

siduction nutzt freie Fonts, die sich in Debian als ausgewogen bewährt haben. Wenn eigene Schriftarten gewählt werden, müssen eventuell neue Konfigurationsanpassungen als Root vorgenommen werden, um das gewünschte Schriftbild zu erhalten. Neben den Einstellungsmöglichkeiten im apart from KDE>systemsettings, gibt es bei Debian einige mächtige Einstellungsoptionen, um eine saubere Schriftendarstellung zu erzielen. Beachtet werden muss jedoch, dass jede Schriftart ein ideales Größenspektrum besitzt, sodass identische Größeneinstellungen nicht bei jeder Schriftart zu einem gleich guten Ergebnis führen müssen.

Eine Änderung der DPI-Größe kann auch zu einer besseren Schriftendarstellung beitragen. Dazu wird dieser Befehl verwendet:

~~~
fix-dpi-kdm
~~~

Dies sollte die passende DPI-Größe für den verwendeten Monitor anzeigen, aber sie kann geändert werden. Um die Änderungen wirksam werden zu lassen, muss der Grafikserver X neu gestartet (init 3 - init 5) oder ein Reboot durchgeführt werden.

Nach Änderung einer Schriftart oder der DPI-Größe (in X oder Firefox/Iceweasel) müssen eventuell noch einige Anpassungen vorgenommen werden, besonders wenn von einem Bitmap-Font zu einem True-Type-Font gewechselt wurde (oder umgekehrt):

~~~
dpkg-reconfigure fontconfig-config
~~~

Die ersten beiden Einstellungen - (1) "native" und (2) "autohinter" - werden am besten auf "automatic" gesetzt. Andere Einstellungsmöglichkeiten können ausprobiert werden. Die dritte Einstellungsoption optimiert für Bitmap-Schriften ("yes") oder True-Type-Schriften ("no").

Falls dieser Befehl Änderungen nicht gestattet, kann der Neuaufbau des Font-Caches eine Lösung bedeuten (der zweite Befehl ist ohne Zeilenumbruch, d. h. in einer Zeile einzugeben):

~~~
rm -rf /etc/fonts
apt-get install --reinstall --yes -o DPkg::Options::=--force-confmiss -o DPkg::Options::=--force-confnew fontconfig fontconfig-config
~~~

Zu beachten ist auch, dass nicht jede Schriftart in allen Größen die gleiche Schriftqualität liefert.

#### Voreinstellungen in Firefox/Iceweasel

Programme, die auf GTK2 basieren, sind bezüglich Schriftbild in KDE-Umgebungen problematisch. Eine der Lösungsmöglichkeiten ist die Installation von:

~~~
apt-get install gtk2-engines system-config-gtk-kde gtk-qt-engine gtk2-engines-qtcurve
~~~

Unter `Systemeinstellungen > Erscheinungsbild`  gibt es einen Menüpunkt `GTK-Stile und Schriftarten` . Man setzt z.B. 'GTK-Stile' auf 'Clearlooks' und 'GTK-Schriftarten' auf 'KDE-Fonts' `oder`  experimentiert mit verschiedenen Optionen, um eine gewünschte Einstellung zu finden.

Dieses Vorgehen kann helfen, Probleme der Schriftendarstellung in GTK-Programmen zu lösen.

<div class="divider" id="cups"></div>

## CUPS

KDE hat einen großen Abschnitt zu CUPS in der KDE-Hilfe. Trotzdem folgt nun eine Anleitung, was man bei Problemen mit CUPS nach einem dist-upgrade tun kann. Eine der bekannten Lösungen ist:

~~~
modprobe lp
echo lp >> /etc/modules
apt-get purge cupsys cups
apt-get install cups
        ODER
apt-get install cups printer-driver-gutenprint hplip
~~~

CUPS wird nun neu gestartet:

~~~
/etc/init.d/cups restart
~~~

Im Anschluss daran wird ein Web-Browser geöffnet und in die Adresszeile eingegeben: 

~~~
http://localhost:631
~~~

Ein kleines Problem ist, wenn CUPS mit einer grafischen Oberfläche eingerichtet wird, dass die Dialog-Box den Benutzernamen bereits eingesetzt hat und ein Passwort erwartet. Die Eingabe des Benutzerpassworts ist jedoch nicht zielführend. Es geht nichts. Die Lösung ist, den Benutzernamen in **`root`**  zu ändern und das **`Root-Passwort`**  einzugeben.

[Die OpenPrinting-Datenbank](http://www.linuxfoundation.org/collaborate/workgroups/openprinting/database/databaseintro)  beinhaltet umfangreiche Informationen über verschiedenste Drucker und deren Treiber. Es stehen Treiber, Spezifikationen und Konfigurations-Tools zur Verfügung.

<div class="divider" id="sound"></div>

## Sound in siduction

`In der Grundeinstellung ist der Ton bei siduction deaktiviert.` 

Als Mischersoftware verwendet die KDE-Version Kmix und die XFCE-Version Mixer.

Die meisten Tonprobleme lassen sich lösen, indem man auf das Sound-Ikon in der Symbolleiste klickt, den Mischer öffnet und das Häkchen von "stumm" oder "mute" entfernt.

#### Kmix

In Kmix müssen die Kanaloptonen aktiviert werden: `Kmix>Einstellungen>Kanäle einrichten` . Oder in einem Terminal:

~~~
$ kmix
~~~

#### XFCE

In XFCE wird das Mischpult "Mixer" gestartet. Die Kontrollfunktionen werden mittels `Multimedia>Mixer`  Klick auf `Select Controls box`  eingestellt Oder in einem Terminal:


~~~
$ xfce4-mixer
~~~

### Alsamixer

Wer alsamixer bevorzugt, findet diesen im Paket alsa-utils:

~~~
apt-get update
apt-get install alsa-utils
exit
~~~

Die gewünschten Sound-Einstellungen werden als **`$user`**  von einem Terminal vorgenommen:

~~~
$ alsamixer
~~~

<div id="rev">Page last revised 24/07/2012 1830 UTC</div>
