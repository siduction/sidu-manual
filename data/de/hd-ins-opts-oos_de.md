ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2020-05:  
+ Inhalt aktualisiert
+ Korrektur und Prüfung aller Links

ENDE   INFOBEREICH FÜR DIE AUTOREN

<div class="divider" id="raw-usb"></div>

## Installation einer siduction-ISO auf USB-Stick, SSD-Karte, SHDC-Gerät unter Verwendung einer anderen Linuxdistribution, MS Windows&#8482; oder Mac OS X&#8482;

Unabhängig vom verwendeten Betriebssytem ermöglichen die nachfolgend beschriebenen Methoden die Installation einer siduction-ISO auf einem USB-Stick, einer SSD-Karte, einem SHDC-Gerät (Secure Digital High Capacity card).

Dabei wird das siduction-ISO auf das Gerät geschrieben. Auch wenn die Option persist nicht möglich ist, kann man "siduction auf einem Stick" haben.

Falls persist benötigt wird, ist install-usb-gui bei einem vorhandenen siduction-System die empfohlene Methode, da man dadurch keinerlei Einschränkungen ausgesetzt ist. Siehe auch: [USB/SSD fromiso Installation - siduction-on-a-stick](hd-install-opts-de.md#usb-from1) .

### Voraussetzungen

+ Das BIOS des PC, auf dem Du siduction-on-a-stick/card starten möchtest, muss das Booten mittels eines USB-Sticks bzw. einer SSD-Karte erlauben. Normalerweise ist dies der Fall, wenn im BIOS des PC diese Bootoption angeboten wird.
+ USB/SSD sollte automatisch erkannt werden und die Menü-Option `F4`  sollte `Hard Disk`  ausgeben, andernfalls sollte `F4 > Hard Drive`  aufgerufen oder `fromhd`  der Bootmenü-Zeile beigefügt werden.
+ Sichere das Betriebssystem und alle deine Daten auf den Geräten die du für die Herstellung des siduction-USB-Mediums verwenden möchtest. Ein kleiner Tippfehler kann alle deine Daten zerstören!

**<warning>Wichtige Information</warning>**
<warning>
Die folgenden Methoden werden vorhandene Partitionstabellen auf dem Zielmedium überschreiben und zerstören. Der Datenverlust hängt von der Größe der siduction-*.iso ab. Was Linux betrifft, wird der gegebene Speicherplatz nicht beschränkt und es kann sein, dass Daten wiedergewonnen werden können, welche nicht durch die ISO zerstört wurden. MS Windows hingegen scheint nur eine Partition zu erlauben. Gehe also keine Risiken eines Datenverlustes ein und wende diese Methode nicht auf einer Deiner 100+ GB Festplatten an. Sichere Deine Daten!
</warning>

 Installation unter Verwendung von [Linux](#raw-lin)
 
 Installation unter Verwendung von [MS Windows&#8482;](#raw-ms)
 
 Installation unter Verwendung von [Mac OS X&#8482;](#raw-mac)

<div class="divider" id="raw-lin"></div>

### Linux-Betriebssysteme

Stecke Deinen USB-Stick oder Kartenleser mit der Karte, auf die geschrieben werden soll, an und führe folgenden Befehl aus:

~~~
cat /home/username/siduction-18.3.0-patience-kde.iso > /dev/sdX
~~~

oder

~~~
dd if=/path/to/siduction-*.iso of=/dev/sdX
~~~

Um herauszufinden, was das X in sdX ist, bitte als root  *fdisk -l*  oder *dmesg* aufrufen.

#### Beispiel:

Schließe Dein Gerät an, führe den Befehl `dmesg`  aus und beachte die Ausgabe:

~~~
sd 13:0:0:0: [sdf] Assuming drive cache: write through
sd 13:0:0:0: [sdf] Assuming drive cache: write through
sdf: sdf1 sdf2
sd 13:0:0:0: [sdf] Assuming drive cache: write through
sd 13:0:0:0: [sdf] Attached SCSI removable disk
~~~

Angenommen die gespeicherte ISO `siduction-18.3.0-patience-kde-amd64-201805132121.iso`  wurde zu `siduction-18.3.0-patience-kde.iso`  umbenannt, so ist der auszuführende Befehl:

~~~
cat /home/username/siduction-18.3.0-patience-kde.iso > /dev/sdf
~~~

oder

~~~
dd if=/home/username/siduction-18.3.0-patience-kde.iso of=/dev/sdf
~~~

USB/SSD sollte automatisch erkannt werden und die Menü-Option `F4`  sollte `Hard Disk`  ausgeben, andernfalls sollte `F4 > Hard Drive`  aufgerufen oder `fromhd`  der Bootmenü-Zeile beigefügt werden.

<div class="divider" id="raw-ms"></div>

### MS Windows&#8482;

Das Vorgehen ist einfach. Lade das kleine Tool [USBWriter](https://sourceforge.net/p/usbwriter/wiki/Documentation/)  herunter. Es muss nicht installiert werden. Nach dem Start des Werkzeugs beispielsweise vom Desktop aus muss lediglich das gewünschte ISO-Image sowie der USB-Stick ausgewählt werden. Hierbei ist große Aufmerksamkeit erforderlich, denn der Vorgang löscht alle Daten auf dem Device. Wird also das falsche Device gewählt, sind die Daten darauf verloren, sobald der  *WRITE* -Button gedrückt wurde. In wenigen Minuten schreibt das Werkzeug das Image bootfähig auf das Gerät.

<div class="divider" id="raw-mac"></div>

### Mac OS X&#8482;

Schließe Dein USB-Gerät an, Mac OS X sollte es automatisch einbinden. Im Terminal (unter Applications &gt; Utilities), wird dieser Befehl ausgeführt:

~~~
diskutil list
~~~

Stelle die Bezeichnung des USB-Geräts fest und binde die Partitionen des Geräts aus (unmount). In unserem Beispiel ist die Bezeichnung /dev/disk1:

~~~
diskutil unmountDisk /dev/disk1
~~~

Angenommen die gespeicherte ISO `siduction-18.3.0-patience-kde-amd64-201805132121.iso`  wurde zu `siduction-18.3.0-patience-kde.iso`  umbenannt und in `/Users/username/Downloads/`  gespeichert, und das USB-Gerät hat die Bezeichnung `disk1` , so führt man folgenden Befehl aus:

~~~
dd if=/Users/username/Downloads/siduction-18.3.0-patience-kde.iso of=/dev/disk1
~~~

USB/SSD sollte automatisch erkannt werden und die Menü-Option `F4`  sollte `Hard Disk`  ausgeben, andernfalls sollte `F4 > Hard Drive`  aufgerufen oder `fromhd`  der Bootmenü-Zeile beigefügt werden.

<div id="rev">Page last revised by akli 2020-05-12</div>
