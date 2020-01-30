<div class="divider" id="mon-res"></div>

## Ändern der Bildschirmauflösung

### xrandr

#### Unterstützte Grafikkartentreiber

+  xserver-xorg-video-intel (ab 2.0)

+ xserver-xorg-video-nouveau ( [Refer to the nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))

+ xserver-xorg-video-ati (ab 6.7.192)

Als erstes muss man als User nur xrandr eingeben, um festzustellen, ob das Programm unterstützt ist. Falls keine Unterstützung gegeben ist, überprüfe bitte die Version von xorg und den benutzten Grafiktreiber.

Die Auflösung des primären Bildschirms kann man bei Unterstützung durch xrandr folgendermaßen ändern:

~~~
xrandr --output VGA --mode 1440x900
~~~

<div class="divider" id="xrandr"></div>

## Zwei Monitore und xrandr

 **`xorg.conf wird für freie Treiber nicht mehr benötigt.`**  Falls sich Konfigurationsdateien für Xorg im Verzeichnis `/etc/X11/xorg.conf.d`  befinden, da proprietäre Treiber verwendet werden, sollten diese nun gesichert werden, bevor die nächsten Schritte durchgeführt werden.

xorg.conf, so sie überhaupt existiert, ist nun modular aufgebaut. Jedes Modul beinhaltet alle Einstellungen für z.B. ein Gerät, die Anzeige oder die Maus.

Mit xrandr kann der primäre und sekundäre Monitor konfiguriert werden, ohne dass X neu gestartet werden muss. xrandr ersetzt xinerama und mergedFB. Mit xrandr 1.2 ist es möglich, dass die klassischen Konfigurationen in xorg.conf (xinerama and mergedFB) nicht mehr funktionieren.

#### Unterstützte Grafikkartentreiber

+ xserver-xorg-video-intel (ab 2.0)

+ xserver-xorg-video-nouveau ([Refer to the nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))

+ xserver-xorg-video-ati (ab 6.7.192)

### Vorbereitung einer xrandr-Konfiguration für einen PC mit zwei Monitoren (Dualhead)

**`Anmerkung:`**  Falls ein PC immer mit zwei Monitoren betrieben wird, ist es am besten, `xorg.conf`  dauerhaft anzupassen.

Ein Laptop/Notebook muss dynamisch konfiguriert werden (anders als ein PC mit zwei Monitoren). Nach einem Neustart muss die Auflösung neu konfiguriert werden. Zur dauerhaften Anpassung können die Einstellungen von xrandr in einem Startskript in`~/.kde/Autostart/`  abgelegt werden.

### Vertraut werden mit xrandr

Als erstes gibt man als User  *xrandr*  in eine Konsole ein, um mit der Ausgabe vertraut zu werden:

~~~
xrandr
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm
1024x768 60.0*+ 75.1 70.1 60.0* 59.9
832x624 74.6
800x600 72.2 75.0 60.3 56.2
640x480 75.0 72.8 66.7 60.0
720x400 70.1
~~~

Hier sieht man nur VGA für den PC (siehe [Anhang A](hw-dev-mon-de.htm#aa)  für die Begriffserklärung). Man sieht auch die unterstützten Bildschirmauflösungen und die maximale Bildschirmgröße (hier 2048x768).

Jetzt wird der externe Bildschirm angeschlossen und xrandr noch einmal ausgeführt:

~~~
$ xrandr
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm
1024x768 60.0*+ 75.1 70.1 60.0* 59.9
832x624 74.6
800x600 72.2 75.0 60.3 56.2
640x480 75.0 72.8 66.7 60.0
720x400 70.1
DVI-0 connected 1024x768+1024+0 (normal left inverted right x axis y axis) 310mm x 230mm
1024x768_85.00 85.0*+
1024x768 85.0 + 84.9 74.9 75.1 70.1 60.0 43.5
832x624 74.6
800x600 84.9 72.2 75.0 60.3 56.2
640x480 84.6 75.0 72.8 66.7 60.0
720x400 87.8 70.1
S-video disconnected (normal left inverted right x axis y axis)
~~~

Hier sieht man, dass auch ein DVI-Monitor angeschlossen ist und Auflösungen von 720x400 bis 1024x768 mit den jeweiligen Wiederholfrequenzen unterstützt werden.

#### Konfigurationsmöglichkeiten

Grundlegende Befehlssyntax

~~~
xrandr --output <output2 --rate <rate2 --mode <mode2 --left-of|--right-of|--above|--below|--same-as <output2
~~~

Dabei ist:

+ &lt;output&gt;: der Name des Ausgabegeräts (siehe [Anhang A](hw-dev-mon-de.htm#aa))

+ &lt;rate&gt;: die Wiederholungsrate nach xrandr (optional)

+ &lt;mode&gt;: die Bildschirmauflösung nach xrandr output (optional)

#### Änderung der Auflösung des primären Monitors

~~~
xrandr --output VGA --mode 1024x768
~~~

#### Klonen

Wenn der externe Bildschirm nur eine Auflösung von 1024x768 besitzt, lautet der Befehl folgendermaßen:

~~~
xrandr --output VGA --mode 1024x768 --output LVDS --mode 1024x768
~~~

Um den externen Bildschirm auszuschalten und die Auflösung des primären Monitors zurückzusetzen, nutzt man folgenden Befehl:

~~~
xrandr --output VGA --off --output LVDS --mode 1280x800
~~~

#### Desktops mit mehreren Bildschirmen

Da Intel GMA &lt;=945GM/GMS die 3D-Unterstützung mit einem virtuellen Bildschirm &gt;2048x2048 verliert, können zwei Bildschirme nicht mit hohen Auflösungen parallel angesteuert werden. 1024x768 für beide Bildschirme geht gut.

~~~
xrandr --output LVDS --mode 1024x768 --output VGA --mode 1024x768 --left-of LVDS
~~~

Um die Anzeige auf mehreren Bildschirmen zu deaktivieren, muss man nur den zweiten Monitor nicht mehr ansteuern und die Auflösung des primären Monitors zurücksetzen (so benötigt):

~~~
xrandr --output VGA --off (--output LVDS --mode 1280x800)
~~~

Eine andere Option ist, den zweiten Monitor unterhalb/oberhalb des primären zu setzen:

~~~
xrandr --output LVDS --mode 1280x800 --output VGA --mode 1280x1024 --above LVDS
~~~

Dies resultiert in einer virtuellen Bildschirmauflösung von 1280x1824, was unterhalb von 2048x2048 liegt. Eine andere Lösung könnte sein, den Bildschirm zu rotieren:

~~~
xrandr --verbose --output LVDS --mode 1280x800 --output VGA --mode 1024x768 --rotate left --left-of LVDS
~~~

ANMERKUNG: Dies funktioniert nur, wenn man den Monitor auch physisch rotieren kann.

#### Beispiel einer dauerhaften Konfiguration eines PCs mit zwei Monitoren unter Benutzung von xrandr mithilfe von Konfigurations-Code in der Datei `/etc/X11/xorg.conf.d/30-screen.conf` :

~~~
#30-screen.conf
Section "Monitor"
Identifier "DVI-0"
Option "Primary" "true"
EndSection

Section "Monitor"
Identifier "DVI-1"
Option "RightOf" "DVI-0"
EndSection

Section "Device"
Identifier "ATI Radeon HD 2600"
Option "Monitor-DVI-0" "DVI-0"
Option "Monitor-DVI-1" "DVI-1"
EndSection
~~~

Anmerkungen

+ Die Begrenzung der Auflösung von virtuellen Bildschirmen auf 2048x2048 gilt für Intel-Grafikchips. Man kann höhere Auflösungen einstellen, verliert jedoch die DRI-Fähigkeit. Für Grafikkarten von nVidia und ATI scheint es keinerlei Beschränkungen zu geben.

+ TV-Out funktioniert nicht mit ATI

+  falls die Erkennung von DDC mit ATI-Karten nicht korrekt funktioniert (Xorg.0.log: (WW) RADEON(0): DDC2/I2C is not properly initialised), ist es möglich, dass diese Werte durch veränderte Modelines nicht überschrieben werden.

+ Falls xrandr bei der Konfiguration eines großen Bildschirms (Dualhead) ausgibt, dass die gewünschte Auflösung größer ist, als von xrandr unterstützt wird, kann man "virtual" benutzen und die gewünschte Auflösung angeben (siehe Monitor-Sektion in Anhang A)

+ Für jede Grafikkarte außer Intel soll die virtuelle Auflösung groß genug sein, damit die physischen Auflösungsfähigkeiten der Monitore genutzt werden können. Zum Beispiel: monitor1=1024x768 und monitor2=1280x1024, dann sollte der virtuelle Bildschirm folgende Auflösungen haben: (1024+1280)x(1024>768) -> 2304x1024

<div class="divider" id="aa"></div>

#### Anhang A

#### Intel

~~~
Bezeichnungen der Ausgabeschnittstellen:
* LVDS: interner Laptopmonitor
* TMDS-1: externer DVI-Anschluss
* VGA: externer VGA-Anschluss
* TV: externer TV-Anschluss
~~~

#### ATI

~~~
Bezeichnungen der Ausgabeschnittstellen:
* LVDS: interner Laptopmonitor
* DVI-0: erster externer DVI-Anschluss
* DVI-1: zweiter externer DVI-Anschluss (falls vorhanden)
* VGA-0: erster externer VGA-Anschluss
* VGA-1: zweiter externer VGA-Anschluss (falls vorhanden)
* S-video
~~~

#### Nvidia

~~~
Der nv-Treiber unterstützt RandR1.2 auf G80-Karten
Bezeichnungen der Ausgabeschnittstellen:
* LVDS: interner Laptopmonitor
* DVI0: erster externer DVI-Anschluss
* DVI1: zweiter externer DVI-Anschluss (falls vorhanden)
~~~

#### Links

[http://wiki.debian.org/XStrikeForce/HowToRandR12](http://wiki.debian.org/XStrikeForce/HowToRandR12)  
[http://bgoglin.livejournal.com/9846.html](http://bgoglin.livejournal.com/9846.html)  
[http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419)  
[http://www.thinkwiki.org/wiki/Xorg_RandR_1.2](http://www.thinkwiki.org/wiki/Xorg_RandR_1.2)  

<div class="divider" id="mon-binary"></div>

## Zwei Monitore mit binären Grafiktreibern

 `Für proprietäre Treiber ziehe bitte die Dokumenatation des Grafikkartenherstellers zu Rate.` 

#### nvidia

Für den nicht-freien nvidia-Treiber kann das Konfigurationsprogramm für xorg von nvidia verwendet werden ([http://www.sorgonet.com/linux/nv-online/](http://www.sorgonet.com/linux/nv-online/)) und die Einstellungen können in diesem vorgenommen werden. Auch hier ist zu beachten: die maximale Auflösung des schwächeren Monitors soll gewählt werden bzw. beide Monitore müssen auf die gleiche Auflösung eingestellt sein.

#### Nativer ATI-Treiber - radeon

<!--Im Forums-Thread [http://siduction.org/index.php?name=PNphpBB2&amp;file=viewtopic&amp;p=19794#19794](http://siduction.org/index.php?name=PNphpBB2&amp;file=viewtopic&amp;p=19794#19794)  gibt es einige funktionierende Beispiele für die xorg.conf mit dem freien Radeon-Treiber.

ZU BEACHTEN: Um die Konfigurationsinformationen des zweiten Monitors zu erhalten, muss der erste abgehängt werden und mit der Live-CD gebootet werden, um eine xorg.conf generieren zu lassen. Von dieser xorg.conf muss eine Kopie angelegt werden. Um die Konfigurationsinformationen des ersten Monitors zu erhalten, wird das gleiche Verfahren angewendet.

Umfassende Informationen zur Konfigurationseinstellung gibt es hier: [http://ftp.x.org/pub/X11R6.9.0/doc/html/radeon.4.html](http://ftp.x.org/pub/X11R6.9.0/doc/html/radeon.4.html) 

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
