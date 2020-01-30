<div class="divider" id="raw-usb"></div>

## Installation einer siduction-ISO auf einen USB-Stick, eine SSD-Karte, einem SHDC-Gerät unter Verwendung einer anderen Linuxdistribution, MS Windows&#8482; oder Mac OS X&#8482;

Unabhängig vom verwendeten Betriebssytem ermöglichen die nachfolgend beschriebenen Methoden die Installation einer siduction-ISO auf einen USB-Stick, eine SSD-Karte, einem SHDC-Gerät (Secure Digital High Capacity card).

Dabei wird das siduction-ISO auf das Gerät geschrieben. Auch wenn die Option persist nicht möglich ist, kann man "siduction auf einem Stick" haben.

Falls persist benötigt wird, ist install-usb-gui bei einem vorhandenen siduction-System die empfohlene Methode, da man dadurch keinerlei Einschränkungen ausgesetzt ist. Siehe auch: [USB/SSD fromiso Installation - siduction-on-a-stick](hd-install-opts-de.htm#usb-from1) .

### Voraussetzungen

+ `Stelle sicher, dass das BIOS des PC, auf dem Du siduction-on-a-stick/card starten möchten, das Booten mittels eines USB-Sticks bzw. einer SSD-Karte erlaubt. Normalerweise ist dies der Fall, wenn der PC das USB 2.0 oder 3.0-Protokoll verwendet und das Booten von USB/SSD unterstützt.` 
+ USB/SSD sollte automatisch erkannt werden und die Menü-Option `F4`  sollte `Hard Disk`  ausgeben, andernfalls sollte `F4 2Hard Drive`  aufgerufen oder `fromhd`  der Bootmenü-Zeile beigefügt werden.
+ **`Es ist wichtig anzumerken, dass die folgenden Methoden vorhandene Partitionstabellen auf dem Zielmedium überschreiben und zerstören werden. Der Datenverlust hängt von der Größe der siduction-*.iso ab. Was Linux betrifft, wird der gegebene Speicherplatz nicht beschränkt und es kann sein, dass Daten wiedergewonnen werden können, welche nicht durch die ISO zerstört wurden. MS Windows hingegen scheint nur eine Partition zu erlauben. Gehe also keine Risiken eines Datenverlustes ein und wende diese Methode nicht auf einer Deiner 100+ GB Festplatten an. Sichere Deine Daten!`** 

 [Linux](#raw-lin)  &nbsp; &nbsp;[MS Windows](#raw-ms)  &nbsp; &nbsp;[Mac OS X](#raw-mac)  

<div class="divider" id="raw-lin"></div>

### Linux-Betriebssysteme

Stecke Deinen USB-Stick oder Kartenleser mit der Karte, auf die geschrieben werden soll, an und führe folgenden Befehl aus:

~~~
cat /path/to/siduction-*.iso > /dev/USB_raw_device_node
~~~

oder

~~~
dd if=/path/to/siduction-*.iso of=/dev/sdX
~~~

Um herauszufinden, was das X in sdX ist, bitte als root  *fdisk -l*  aufrufen.

#### Beispiel:

Schließe Dein Gerät an, führe den Befehl `dmesg`  aus und beachte die Ausgabe:

~~~
sd 13:0:0:0: [sdf] Assuming drive cache: write through
sd 13:0:0:0: [sdf] Assuming drive cache: write through
sdf: sdf1 sdf2
sd 13:0:0:0: [sdf] Assuming drive cache: write through
sd 13:0:0:0: [sdf] Attached SCSI removable disk
~~~

Angenommen die gespeicherte ISO `siduction-11.1-OneStepBeyond--i386-2011xxxxx`  wurde zu `siduction-11.1-onestepbeyond.iso`  umbenannt, so ist der auszuführende Befehl:

~~~
cat /home/username/siduction-11.1-onestepbeyond.iso > /dev/sdf
~~~

oder

~~~
dd if=/home/username/siduction-11.1-onestepbeyond.iso of=/dev/sdf
~~~

USB/SSD sollte automatisch erkannt werden und die Menü-Option `F4`  sollte `Hard Disk`  ausgeben, andernfalls sollte `F4 2Hard Drive`  aufgerufen oder `fromhd`  der Bootmenü-Zeile beigefügt werden.

<div class="divider" id="raw-ms"></div>

### MS Windows&#8482;

Das Vorgehen ist einfach. Lade das kleine Tool [USBWriter](http://sourceforge.net/p/usbwriter/wiki/Documentation/)  herunter. Es muss nicht installiert werden. Nach dem Start des Werkzeugs beispielsweise vom Desktop aus muss lediglich das gewünschte ISO-Image sowie der USB-Stick ausgewählt werden. Hierbei ist große Aufmerksamkeit erforderlich, denn der Vorgang löscht alle Daten auf dem Device. Wird also das falsche Device gewählt, sind die Daten darauf verloren, sobald der  *WRITE* -Button gedrückt wurde. In wenigen Minuten schreibt das Werkzeug das Image bootfähig auf das Gerät.

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

Angenommen die ISO `siduction-11.1-OneStepBeyond--i386-2011xxxxx`  wurde zu `siduction-11.1-onestepbeyond.iso`  umbenannt und in `/Users/username/Downloads/`  gespeichert, und das USB-Gerät hat die Bezeichnung `disk1` , so führt man folgenden Befehl aus:

~~~
dd if=/Users/username/Downloads/siduction-11.1-onestepbeyond.iso of=/dev/disk1
~~~

USB/SSD sollte automatisch erkannt werden und die Menü-Option `F4`  sollte `Hard Disk`  ausgeben, andernfalls sollte `F4 2Hard Drive`  aufgerufen oder `fromhd`  der Bootmenü-Zeile beigefügt werden.

<div id="rev">Page last revised 17/02/2014 2045 UTC</div>
