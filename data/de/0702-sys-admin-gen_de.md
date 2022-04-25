% siduction Systemadministration

## Systemadministration allgemein

### Bootoptionen Cheatcodes

Zu Beginn des Bootvorgangs lässt sich die Kernel-Befehlszeile editieren, indem man, sobald das Grub-Menue erscheint, die Taste **`e`** drückt. Im Editiermodus navigiert man mit den Pfeiltasten zur Kernelzeile und fügt am Ende den oder die gewünschten Cheatcode ein. Als Trennzeichen dient das Leerzeichen. Der Bootvorgang wird mit der Tastenkombination **`Strg`**+**`X`** fortgesetzt.

Die nachstehenden Link führen zu der Handbuchseite mit den Tabellen für die Bootoptionen.

1. [siduction spezifische Parameter (nur Live-CD)](cheatcodes_de.md#siduction-spezifische-parameter)
2. [Bootoptionen für den Grafikserver X](cheatcodes_de.md#bootoptionen-für-den-grafikserver-x)
3. [Allgemeine Parameter des Linux-Kernels](cheatcodes_de.md#allgemeine-parameter-des-linux-kernels)
4. [Werte für den allgemeinen Parameter **vga**](cheatcodes_de.md#vga-codes)

[Ausführliche Referenzliste für Kernel-Bootcodes von kernel.org (Englisch, PDF)](http://files.kroah.com/lkn/lkn_pdf/ch09.pdf) 

### systemd - Dienste verwalten

systemd kennt insgesamt 11 Unit-Typen. Die Units, mit denen wir im Alltag am häufigsten zu tun haben sind:

+ systemd.service
+ systemd.target
+ systemd.device
+ systemd.timer
+ systemd.mount
+ systemd.path

Einige der Unit-Typen stellen wir hier kurz vor. Ihre Namen geben bereits einen Hinweis auf die vorgesehene Funktionalität. Etwas ausführlichere Erläuterungen zu den Units beinhaltet unsere Handbuchseite [Systemadministration.Systemd](systemd-start_de.md#systemd-der-system--und-dienste-manager). Die vollständige Dokumentation ist in den man-Pages `man systemd.unit`, `man systemd.special` und jeweils `man systemd.<Unit-Typ>` zu finden.

Mit dem Befehl

~~~
systemctl [OPTIONEN...] Befehl [UNIT...]
~~~

je nach den Units und den notwendigen Rechten als **user** oder **root** aufgerufen, wird das systemd-System gesteuert. *"systemctl"* kennt die Autovervollständigung mittels `TAB` und die Anzeige aller Variationen mittels `TAB` `TAB`. Bitte die man-Page `man systemctl` lesen.

Eine nach Typen sortierte Liste mit allen aktiven Units bzw. Unit-Dateien, geben die folgenden Befehle aus:

~~~
$ systemctl list-units          # für Units
$ systemctl list-unit-files     # für Unit-Dateien
~~~

mit der Option `-a` werden auch alle inaktiven Units bzw. Unit-Dateien ausgegeben.

### systemd.service 

Zum Starten oder Stoppen einer .service-Unit dienen die Befehle:

~~~
$ systemctl start <UNIT>.service
$ systemctl stop <UNIT>.service
$ systemctl restart <UNIT>.service
~~~

*"Restart"* ist z. B. nützlich, um dem Service eine geänderte Konfiguration bekannt zu geben. Sofern für die Aktion root-Rechte nötig sind, wird das root-Passwort abgefragt.  
Zum Beenden eines Dienstes dient auch der Befehl:

~~~
$ systemctl kill -s SIGSTOP --kill-who=control <UNIT>.service
~~~

Mit *"kill"* stehen im Gegensatz zu *"stop"* die Optionen `-s, --signal=` und `--kill-who=` bereit.

+ *"-s"* sendet eines der Signale `SIGTERM`, `SIGINT` oder `SIGSTOP`. Vorgabe ist *"SIGTERM"*.
+ *"--kill-who="* erlaubt die Auswahl der Prozesse innerhalb der Hirarchie, an die ein Signal gesendet werden soll. Die Optionen sind `main`, `control` oder `all`. Damit wird dem Hauptprozess, den Kind-Prozesse oder beiden das Signal gesendet. Vorgabe ist *"all"*.

Dieses Verhalten ähnelt dem altbekannten und weiterhin verwendbaren Befehl pkill, der weiter unten im Abschnitt [Beenden eines Prozesses](0702-sys-admin-gen_de.md#beenden-eines-prozesses) erläutert wird.


### systemd - UNIT eingliedern

Damit eine (selbst erstellte) Unit beim Hochfahren des Rechners automatisch geladen wird, als **root**:

~~~
# systemctl enable <UNIT-Datei>
~~~

Dies erzeugt eine Gruppe von Symlinks entsprechend den Anforderungen in der Konfiguration der Unit. Im Anschluss wird automatisch die Systemverwalterkonfiguration neu geladen.

Der Befehl

~~~
# systemctl disable <UNIT-Datei>
~~~

entfernt die Symlinks wieder.

**Beispiel**  
Wenn ein PC oder Laptop ohne Bluetooth Hardware im Einsatz ist, oder man kein Bluetooth verwenden möchte, entfernt der Befehl:

~~~
# systemctl disable bluetooth.service
~~~

die Symlinks aus allen Anforderungen und Abhängigkeiten innerhalb systemd und der Service ist nicht mehr verfügbar und wird auch nicht automatisch gestartet.


### systemd-target ehemals Runlevel

Seit der Veröffentlichung von 2013.2 "December" benutzt siduction bereits systemd als Standard-Init-System.  
Die alten sysvinit-Befehle werden weiterhin unterstützt. (hierzu ein Zitat aus `man systemd`: "... wird aus Kompatibilitätsgründen und da es leichter zu tippen ist, bereitgestellt.")  
Ausführlichere Informationen zum systemd enthält die Handbuchseite [Systemadministration.systemd](systemd-start_de.md#systemd-der-system--und-dienste-manager).  
Die verschiedenen Runlevel, in die gebootet oder gewechselt wird, beschreibt systemd als **Ziel-Unit**. Sie besitzen die Erweiterung **.target**.

| Ziel-Unit | Beschreibung | 
| ---- | ---- |
| emergency.target | Startet in eine Notfall-Shell auf der Hauptkonsole. Es ist die minimalste Version eines Systemstarts, um eine interaktive Shell zu erlangen. Mit dieser Unit kann der Bootvorgang Schritt für Schritt begleitet werden. | 
| rescue.target | Startet das Basissystem (einschließlich Systemeinhängungen) und eine Notfall-Shell. Im Vergleich zu multi-user.target könnte dieses Ziel als single-user.target betrachtet werden. |
| multi-user.target | Mehrbenutzersystem mit funktionierendem Netzwerk, ohne Grafikserver X. Diese Unit wird verwendet, wenn man X stoppen bzw. nicht in X booten möchte. [Auf dieser Unit wird eine Systemaktualisierung (dist-upgrade) durchgeführt](sys-admin-apt_de.md#aktualisierung-des-systems) . |
| graphical.target | Die Unit für den Mehrbenutzermodus mit Netzwerkfähigkeit und einem laufenden X-Window-System. |
| default.target | Die Vorgabe-Unit, die systemd beim Systemstart startet. In siduction ist dies ein Symlink auf graphical.target (außer noX). |

Ein Blick in die Dokumentation **`man SYSTEMD.SPECIAL(7)`** ist obligatorisch um die Zusammenhänge der verschiedenen *"xxx.target - Unit"* zu verstehen.

Um in den Runlevel zur Systemaktualisierung zu wechseln, ist im Terminal folgender Befehl als **root** zu verwenden:

~~~
# systemctl isolate multi-user.target
~~~

Wichtig ist hierbei der Befehl *"isolate"*, der dafür sorgt, dass alle Dienste und Services, welche die gewählte Unit nicht anfordert, beendet werden.

Um das System herunter zu fahren bzw. neu zu starten, sollte der Befehl 

~~~
# systemctl poweroff
   bzw.
# systemctl reboot
~~~

verwendet werden. *"poweroff"* bzw. *"reboot"* (jeweils ohne .target) ist ein Befehl, der mehrere Unit in der richtigen Reihenfolge hereinholt, um das System geordnet zu beenden und ggf. einen Neustart auszuführen.

### Beenden eines Prozesses

**pgrep und pkill**

Unabhängig von systemd ist `pgrep` und `pkill` ein sehr nützliches Duo um unliebsame Prozesse zu beenden. Mit Benutzer- oder root-Rechten in einer Konsole oder TTY ausgeführt:

~~~
$ pgreg <tab> <tab>
~~~

listet alle Prozesse mit ihrem Namen, aber ohne die Prozess-ID (PID) auf. Wir benutzen im Anschluss Firefox als Beispiel.  
Die Option `-l` gibt die PID und den vollständigen Namen aus:

~~~
$ pgrep -l firefox
4279 firefox-esr
~~~

Um, sofern vorhanden, Unterprozesse anzuzeigen benutzen wir zusätzlich die Option `-P` und nur die PID:

~~~
$ pgrep -l -P 4279
4387 WebExtensions
4455 file:// Content
231999 Web Content
~~~

anschließend

~~~
$ pkill firefox-esr
~~~

beendet Firefox mit dem Standardsignal SIGTERM.  
Mit der Option `--signal`, gefolgt von der Signalnummer oder dem Signalnamen, sendet pkill das gewünschte Signal an den Prozess. Eine übersichtliche Liste der Signale erhält man mit **`kill -L`**.

**htop**

Im Terminal eingegeben, ist htop eine gute Alternative, da sehr viele nützliche Informationen zu den Prozessen und zur Systemauslastung präsentiert werden. Dazu zählen eine Baumdarstellung, Filter- und Suchfunktion, Kill-Signal und einiges mehr. Die Bedienung ist selbsterklärend.

**Notausgang**

Als letzten Rettungsanker bevor der Netzstecker gezogen wird, kann man den Befehl **`killall -9`** im Terminal absetzen.

### Vergessenes Rootpasswort

Ein vergessenes Rootpasswort kann nicht wiederhergestellt werden, aber ein neues kann gesetzt werden.

Dazu muss zuerst die Live-CD gebootet werden.

Als **root** muss die Rootpartition eingebunden werden (z. B. als /dev/sdb2)

~~~
mount /dev/sdb2 /media/sdb2
~~~

Nun folgen ein chroot in die Rootpartition (chroot=changed root ... "veränderter Root") und die Eingabe eines neuen Passwortes:

~~~
chroot /media/sdb2 passwd
~~~

### Setzen neuer Passwörter

Um ein User-Passwort zu ändern, als **user** :

~~~
$ passwd
~~~

Um das Root-Passwort zu ändern, als **root** :

~~~
# passwd
~~~

Um ein User-Passwort als Administrator zu ändern, als **root** :

~~~
# passwd <user>
~~~

### Schriftarten in siduction

Um, sofern nötig, die Darstellung der Schriften zu verbessern, ist es wichtig vorab die richtigen Einstellungen und Konfigurationen der Hardware zu prüfen.

**Einstellungen prüfen**

- Korrekte Grafiktreiber  
    Einige neuere Grafikkarten von ATI und Nvidia harmonieren nicht besonders mit den freien Xorg-Treibern. Einzig vernünftige Lösung ist in diesen Fällen die Installation von proprietären, nicht quelloffenen Treibern. Aus rechtlichen Gründen kann siduction diese nicht vorinstallieren. Eine Anleitung zur Installation dieser Treiber findest Du auf der Seite [Grafiktreiber](gpu_de.md#grafiktreiber) des Handbuchs.

- Korrekte Bildschirmauflösungen und Bildwiederholungsraten  
    Zuerst ist ein Blick in die technischen Unterlagen des Herstellers sinnvoll, entweder print oder online. Jeder Monitor hat seine eigene perfekte Einstellungskombination. Diese DCC-Werte werden in aller Regel richtig an das Betriebssystem übergeben. Nur manchmal muss manuell eingegriffen werden, um die Grundeinstellungen zu überschreiben.

    Um zu prüfen welche Einstellungen der X-Server zur Zeit verwendet, benutzen wir xrandr im Terminal:

   ~~~
    $ xrandr
    Screen 0: minimum 320 x 200, current 1680 x 1050,
    maximum 16384 x 16384
    HDMI-1 disconnected
      (normal left inverted right x axis y axis)
    HDMI-2 connected 1680x1050+0+0 (normal left
      inverted right x axis y axis)  474mm x 296mm
      
      1680x1050     59.95*+
      1280x1024     75.02    60.02
      1440x900      59.90
      1024x768      75.03    60.00
      800x600       75.00    60.32
      640x480       75.00    59.94
      720x400       70.08
    DP-1 disconnected
      (normal left inverted right x axis y axis)
   ~~~

    Der mit **\*** markierte Wert kennzeichnet die verwendete Einstellung,  
    1680 x 1050 Pixel bei einer physikalischen Größe von 474 x 296 mm.
    Zusätzlich berechnen wir die tatsächliche Auflösung in Px/inch (dpi) um einen Anhaltspunkt für die Einstellungen der Schriften zu erhalten. Mit den oben ausgegebenen Werten erhalten wir 90 dpi.  
    1680 Px `x` 25,4 mm/inch `:` 474 mm `=` 90 Px/inch (dpi)

- Überprüfung  
    Mit einem Zollstock oder Maßband ermitteln wir die tatsächliche Größe des Monitors. Das Ergebnis sollte um weniger als drei Millimeter von den durch xrandr ausgegebenen Werten abweichen.  

**Basiskonfiguration der Schriftarten**

siduction nutzt freie Fonts, die sich in Debian als ausgewogen bewährt haben. In der graphischen Oberfläche kommen TTF- bzw. Outline-Schriften zur Anwendung. Wenn eigene Schriftarten gewählt werden, müssen eventuell neue Konfigurationsanpassungen vorgenommen werden, um das gewünschte Schriftbild zu erhalten. 

Die systemweite Grundkonfiguration erfolgt im Terminal als **root** mittels:

~~~
# dpkg-reconfigure fontconfig-config
~~~

Bei den aufgerufenen Dialogen haben sich diese Einstellungen bewährt:

1. Bitte wählen Sie zur Bildschirmdarstellung die bevorzugte Methode zum Schriftabgleich (font tuning) aus.  
   **`autohinter`**
2. Bitte wählen Sie, inwieweit Font-Hinting standardmäßig angewendet wird.  
   **`mittel`**
3. Die Einbeziehung der Subpixel-Ebene verbessert die Textdarstellung auf Flachbildschirmen (LCD)  
   **`automatisch`**
4. Standardmäßig nutzen Anwendungen, die fontconfig unterstützen, nur Outline-Schriften. Standardmäßig Bitmap-Schriften verwenden?  
   **`nein`**

Anschließend ist 

~~~
# dpkg-reconfigure fontconfig
~~~

notwendig um die Konfiguration neu zu schreiben.

Manchmal bedeutet der Neuaufbau des Font-Caches eine Lösung (der erste Befehl gilt der Datensicherung mit einem Datumsanhang, der zweite Befehl ist ohne Zeilenumbruch, d. h. in einer Zeile einzugeben):

~~~
# mv /etc/fonts/ /etc/fonts_$(date +%F)/

# apt-get install --reinstall --yes -o DPkg::Options::=
--force-confmiss -o DPkg::Options::=--force-confnew
 fontconfig fontconfig-config
~~~

### Userkonfiguration

**Darstellungsart, Größe, 4K-Display**

Beachtet werden muss, dass jede Schriftart ein ideales Größenspektrum besitzt, sodass identische Größeneinstellungen nicht bei jeder Schriftart zu einem gleich guten Ergebnis führen muss.  
Die Einstellungen kann man bequem in der graphischen Oberfläche vornehmen. Sie werden auf dem Desktop sofort wirksam, Anwendungen müssen zum Teil neu gestartet werden.  
Die Liste zeigt, wo im Menü die Einstellungen zu finden sind.

+ KDE Plasma  
  + *Systemeinstellungen* > *Schriftarten* > *Schriftarten*
  + *Systemeinstellungen* > *Anzeige-Einrichtung* > *Anzeige-Einrichtung* > *Globale Skalierung*

+ Gnome (Tweak Tool)  
  *Anwendungen* > *Optimierungen* > *Schriften*

+ XFCE  
  *Einstellungen* > *Erscheinungsbild* > Reiter: *Schriften*

**Begriffserklärung**  
*"Kantenglättung / Antialising"* :  
Das ist die Helligkeitsabstufung der Nachbarpixel an den Kanten um bei Rundungen den Treppeneffekt zu vermindern. Es bewirkt aber eine gewisse Unschärfe der Schriftzeichen.

*"Subpixel-Rendering / Farbreihenfolge / RGB"* :  
Das ist eine Erweiterung des Antialising für LCD-Bildschirme, indem zusätzlich die Farbkomponenten eines Pixels angesteuert werden.

*"Hinting"* :  
Ist die Anpassung (Veränderung) der Schriftzeichen an das Pixelrasters des Bildschirms. Dadurch verringert sich der Bedarf an Antialising, aber die Schriftform entspricht nicht mehr genau den Vorgaben, es sei denn, die Entwickler der Schrift haben bereits Hintingvarianten integriert. Bei **4K**-Bildschirmen ist Hinting meist nicht notwendig.

*"DPI-Wert / Skalierungsfaktor"* :  
Die Einstellmöglichkeit eines anderen DPI-Wertes bzw. einer anderen Größe nur für die Schriften. Hier lässt sich die Darstellung auf einem **4K**-Bildschirm schnell verbessern. Die folgende Tabelle verdeutlicht den Zusammenhang zwischen der Bildschirmdiagonalen und dem DPI-Wert bei **4k**-Bildschirmen.

4k Auflösung: 3840 x 2160 (16:9)

| Diagonale | X-Achse |	Y-Achse | DPI |
| :-------: | :------: | :------: | :---: |
| 24 Zoll | 531 mm | 299 mm | 184 |
| 27 Zoll | 598 mm | 336 mm | 163 |
| 28 Zoll | 620 mm | 349 mm | 157 |
| 32 Zoll | 708 mm | 398 mm | 138 |
| 37 Zoll | 819 mm | 461 mm | 119 |
| 42 Zoll | 930 mm | 523 mm | 105 |

Demnach ist bei 4k-Bildschirmen mit 24 Zoll Diagonale ein Skalierungsfaktor von 2,0 und mit 37 Zoll Diagonale ein Skalierungsfaktor von 1,2 erforderlich um etwa gleiche Darstellungen entsprechend SXGA oder WSXGA Bildschirmen mit 90 DPI zu erhalten.

### CUPS - das Drucksystem

KDE hat einen großen Abschnitt zu CUPS in der KDE-Hilfe. Trotzdem folgt nun eine Anleitung, was man bei Problemen mit CUPS nach einem full-upgrade tun kann. Eine der bekannten Lösungen ist:

~~~
# modprobe lp
# echo lp >> /etc/modules
# apt purge cups
# apt install cups
        ODER
# apt install cups printer-driver-gutenprint hplip
~~~

CUPS wird nun neu gestartet:

~~~
# systemctl restart cups.service
~~~

Im Anschluss daran wird ein Web-Browser geöffnet und in die Adresszeile eingegeben: 

http://localhost:631

Ein kleines Problem tritt auf, wenn CUPS zur Legitimation die entsprechende Dialog-Box öffnet. Dort ist gelegentlich der eigene Benutzername bereits eingetragen und das Passwort wird erwartet. Die Eingabe des Benutzerpassworts ist jedoch nicht zielführend. Es geht nichts. Die Lösung ist, den Benutzernamen in **root** zu ändern und das root-Passwort einzugeben.

[Die OpenPrinting-Datenbank](https://wiki.linuxfoundation.org/openprinting/database/databaseintro)  beinhaltet umfangreiche Informationen über verschiedenste Drucker und deren Treiber. Es stehen Treiber, Spezifikationen und Konfigurations-Tools zur Verfügung. Die Firma Samsung lieferte früher eigene Linux-Treiber für ihre Drucker. Nach dem Verkauf der Druckersparte an HP war die Downloadseite nicht mehr erreichbar und HP nahm die Samsung-Treiber leider nicht in die *"hplib"* auf. Derzeit funktioniert für Samsung-Drucker und Samsung-Multifunktionsgeräte am ehesten das Paket `printer-driver-splix`. CUPS ist gerade im Umbruch und geht in Richtung Drucken ohne Treiber per [IPP-Everywhere](https://linuxnews.de/2020/11/pappl-erstellt-cups-printer-applications/).

### Sound in siduction

*In älteren siduction Installationen ist der Ton in der Grundeinstellung deaktiviert.*

Die meisten Tonprobleme lassen sich lösen, indem man auf das Sound-Ikon in der Kontrollleiste klickt, den Mischer öffnet und das Häkchen von "stumm" oder "mute" entfernt bzw. den entsprechenden Schieber betätigt. Ist das Lautsprecher-Symbol nicht vorhanden, genügt ein Rechtsklick auf die Kontrollleiste, dann die Auswahl

in KDE:   *Kontrollleiste Optionen* > *Miniprogramme hinzufügen...*  
in XFCE:  *Leiste* > *Neue Elemente hinzufügen...*

und das gewünschte Modul auswählen.

**KDE Plasma**

Ein Rechtsklick auf das Lautsprechersymbol in der Kontrollleiste öffnet das Einstellungsfenster für die Soundausgabe. Die Benutzerführung ist selbsterklärend.

**GNOME**

Ein Rechtsklick auf das Lautsprechersymbol in der Kontrollleiste öffnet ein Drop-down-Menü, dass einen Schieber für die Lautstärke enthält.  
Weitere Einstellungen sind wie folgt möglich:

Rechtsklick auf die Arbeitsfläche > *Einstellungen* > *Audio*

**XFCE Pulse-Audio**

Die Einstellungen erfolgen über das Lautsprechersymbol (Puls-Audio-Modul) in der Kontrollleiste. Auch hier ist die Benutzerführung selbsterklärend. Fehlt das Symbol, kann man sich auf die Schnelle mit einem Terminal und dem Befehl

~~~
$ pavucontrol
~~~

behelfen und nimmt im neu geöffneten Fenster die Einstellungen vor.

**Alsamixer**

Wer alsamixer bevorzugt, findet diesen im Paket alsa-utils:

~~~
# apt update
# apt install alsa-utils
# exit
~~~

Die gewünschten Sound-Einstellungen werden als **\<user\>** von einem Terminal aus vorgenommen:

~~~
$ alsamixer
~~~

<div id="rev">Zuletzt bearbeitet: 2021-11-29</div>
