% Installation auf USB-Stick / Speicherkarte

## Installation auf USB-Stick - Speicherkarte

**Nachfolgend beschrieben wir Methoden der Installation einer siduction-ISO auf einen USB-Stick, eine SSD-Karte, einem SHDC-Gerät (Secure Digital High Capacity card) jeweils unter Verwendung einer anderen Linuxdistribution, MS Windows&#8482; oder Mac OS X&#8482;.**

Dabei wird das siduction-ISO auf das Gerät geschrieben. Auch wenn die Option persist nicht möglich ist, kann man "siduction auf einem Stick" haben.

Falls persist benötigt wird, ist install-usb-gui bei einem vorhandenen siduction-System die empfohlene Methode, da man dadurch keinerlei Einschränkungen ausgesetzt ist. Siehe auch: [USB/SSD fromiso Installation - siduction-on-a-stick](hd-install-opts-de.md#fromiso) .

**Voraussetzungen**

+ Das BIOS des PC, auf dem Du siduction-on-a-stick/card starten möchtest, muss das Booten mittels eines USB-Sticks bzw. einer SSD-Karte erlauben. Normalerweise ist dies der Fall, wenn im BIOS des PC diese Bootoption angeboten wird.
+ USB/SSD sollte automatisch erkannt werden und die Menü-Option **F4**  sollte **Hard Disk**  ausgeben, andernfalls sollte **F4 > Hard Drive**  aufgerufen oder **fromhd** der Bootmenü-Zeile beigefügt werden.
+ Sichere das Betriebssystem und alle deine Daten auf den Geräten die du für die Herstellung des siduction-USB-Mediums verwenden möchtest. Ein kleiner Tippfehler kann alle deine Daten zerstören!

> Wichtige Information  
> Die folgenden Methoden werden vorhandene Partitionstabellen auf dem Zielmedium überschreiben und zerstören. Der Datenverlust hängt von der Größe der siduction-*.iso ab.  
> Was Linux betrifft, wird der gegebene Speicherplatz nicht beschränkt und es kann sein, dass Daten wiedergewonnen werden können, welche nicht durch die ISO zerstört wurden.  
> MS Windows hingegen scheint nur eine Partition zu erlauben. Gehe also keine Risiken eines Datenverlustes ein und wende diese Methode nicht auf einer Deiner 100+ GB Festplatten an. Sichere Deine Daten!

### Mit Linux-Betriebssystemen

Stecke Deinen USB-Stick oder Kartenleser mit der Karte, auf die geschrieben werden soll, an und führe folgenden Befehl aus:

~~~sh
cat /home/username/siduction-18.3.0-patience-kde.iso > /dev/sdX
~~~

oder

~~~sh
dd if=/path/to/siduction-*.iso of=/dev/sdX
~~~

Um herauszufinden, was das X in sdX ist, bitte als root  *fdisk -l*  oder *dmesg* aufrufen.

**Beispiel:**  
Führe den Befehl **dmesg -w** aus, schließe Dein Gerät an, und beachte die Ausgabe:

~~~sh
sd 13:0:0:0: [sdc] Write Protect is off
sd 13:0:0:0: [sdc] Mode Sense: 23 00 00 00
sd 13:0:0:0: [sdc] Write cache: disabled, read cache: enabled
sd 13:0:0:0: [sdc] Attached SCSI removable disk
~~~

Das Speichergerät wir hier mit dem Laufwerksbezeichner **sdc** erkannt.  
Anschließend wird *dmesg* mit der Tastenkombination `Strg`+`c` beendet.  
Angenommen die gespeicherte ISO "siduction-18.3.0-patience-kde-amd64-201805132121.iso"  wurde zu "siduction-18.3.0-patience-kde.iso"  umbenannt, so ist der auszuführende Befehl:

~~~sh
cat /home/username/siduction-18.3.0-patience-kde.iso > /dev/sdc
~~~

oder

~~~sh
dd if=/home/username/siduction-18.3.0-patience-kde.iso of=/dev/sdc
~~~

### Mit MS Windows

Das Vorgehen ist einfach. Lade das kleine Tool [USBWriter](https://sourceforge.net/p/usbwriter/wiki/Documentation/)  herunter. Es muss nicht installiert werden. Nach dem Start des Werkzeugs, beispielsweise vom Desktop aus, muss lediglich das gewünschte ISO-Image sowie der USB-Stick ausgewählt werden. Hierbei ist große Aufmerksamkeit erforderlich, denn der Vorgang löscht alle Daten auf dem Device. Wird also das falsche Device gewählt, sind die Daten darauf verloren, sobald der *WRITE*-Button gedrückt wurde. In wenigen Minuten schreibt das Werkzeug das Image bootfähig auf das Gerät.

### Mit Mac OS X

Schließe Dein USB-Gerät an, Mac OS X sollte es automatisch einbinden. Im Terminal (unter Applications &gt; Utilities), wird dieser Befehl ausgeführt:

~~~sh
diskutil list
~~~

Stelle die Bezeichnung des USB-Geräts fest und binde die Partitionen des Geräts aus (unmount). In unserem Beispiel ist die Bezeichnung /dev/disk1:

~~~sh
diskutil unmountDisk /dev/disk1
~~~

Angenommen die gespeicherte ISO "siduction-18.3.0-patience-kde-amd64-201805132121.iso"  wurde zu "siduction-18.3.0-patience-kde.iso"  umbenannt und in "/Users/username/Downloads/"  gespeichert, und das USB-Gerät hat die Bezeichnung "disk1" , so führt man folgenden Befehl aus:

~~~sh
dd if=/Users/username/Downloads/siduction-18.3.0-patience-kde.iso of=/dev/disk1
~~~

<div id="rev">Zuletzt bearbeitet: 2021-05-03</div>
