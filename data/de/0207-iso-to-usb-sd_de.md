% ISO auf USB-Stick / Speicherkarte

## ISO auf USB-Stick - Speicherkarte

Nachfolgend beschrieben wir Methoden eine siduction ISO-Abbilddatei als Live-Medium auf einen USB-Stick, eine SD-Karte oder eine SHDC-Karte zu schreiben.

**Voraussetzungen**

+ Das BIOS des PC muss das Booten mittels eines USB-Sticks bzw. einer SD-Karte erlauben. Normalerweise ist dies der Fall, wenn im BIOS des PC diese Bootoption angeboten wird.
+ Ein USB-Stick oder eine SD-Karte mit einer empfohlenen Kapazität von mindestens 4 GB.
+ Sichere zuvor alle deine Daten auf den Geräten die du für die Herstellung des siduction Live-Medium verwenden möchtest. Auch das aktuell benutzte Betriebssystem und deine privaten Daten. Ein kleiner Tippfehler oder ein vorschneller Klick können alle deine Daten zerstören!

> Wichtige Information  
> Die folgenden Methoden werden vorhandene Partitionstabellen auf dem Zielmedium überschreiben, wodurch alle Daten verloren gehen. Achte auf äußerste Sorgfalt bei der Auswahl des Zielmediums und seiner Laufwerksbezeichnung.

### GUI Anwendung

**Für Linux&#8482;, RasPi&#8482;, MS Windows&#8482; oder Mac OS X&#8482;**

Das kleine Tool [USBImager](https://bztsrc.gitlab.io/usbimager/) ist für alle oben genannten Betriebssysteme verfügbar und dient der Datensicherung und dem Erstellen des Live-Mediums. Das Programm ist Open Source und lizenziert unter der MIT-Lizenz. Lade die für dein verwendetes Betriebssystem notwendige Datei herunter und installiere das Programm entsprechend den Angaben auf der Downloadseite.

Die Handhabung ist Dank der schnörkellosen Oberfläche denkbar einfach.

Image-Datei auf das Gerät schreiben:
1. Wähle ein Image aus, indem du auf `...` in der ersten Zeile klickst.
2. Wählen ein Gerät aus, indem du in die 3. Zeile klickst.
3. Klicke auf die Schaltfläche `Schreiben` in der 2. Zeile.

Ausführliche Informationen bietet das [Readme](https://gitlab.com/bztsrc/usbimager/-/blob/master/README.md) der Projektseite.

### Linux Kommandozeile

Wir empfehlen die Verwendung der Kommandozeile. Die Installation zusätzlicher Programme erübrigt sich, da bereits alle benötigten Werkzeuge vorhanden sind. Eine einzige, leicht verständliche Befehlszeile reicht aus um die siduction ISO-Abbilddatei auf das Speichermedium zu übertragen.

Bevor wir die siduction ISO-Abbilddatei auf das Speichermedium schreiben, müssen wir dessen Laufwerksbezeichnung ermitteln. Am einfachsten benutzen wir journald. Der Befehl **`journalctl -f`** in einem Terminal ausgeführt, zeigt fortlaufend die Meldungen des systemd. Nun stecken wir das Speichermedium an und beobachten die Meldungen im Terminal. Zeilen der folgenden Art enthalten die gesuchten Informationen.

~~~
kernel: usb 2-3.3: new high-speed USB device number 7 ...
[...]
kernel: scsi 1:0:0:0: Direct-Access   Intenso  Alu Line ...
kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
kernel: sd 1:0:0:0: [sdb] 7866368 512-byte logical blocks: (4.03 GB/3.75 GiB)
[...]
kernel: sd 1:0:0:0: [sdb] Write cache: disabled, read ...
~~~

Es handelt sich um einen Intenso USB-Stick mit 4 GB Speicherkapazität und einer Sektorengröße von 512 Bytes. Die Laufwerksbezeichnung lautet `sdb`. Daraus folgt, dass `/dev/sdb` der zu verwendende Pfad für das Zielmedium ist.  
Angenommen die siduction ISO-Abbilddatei wurde im `/home` Verzeichnis des Benutzers **tux** gespeichert, können wir mit den Kommandos `dd` oder `cat` das Zielmedium beschreiben. Die Kommandos erfordern Root-Rechte. Daher je nach System entweder **`sudo`** bzw. **`doas`** voranstellen oder ein Terminal verwenden und mit **`su`** zu **root** werden.

~~~
dd if=/home/tux/siduction-21.3.0-wintersky-kde-amd64-202112231751.iso of=/dev/sdb
    (oder)
cat /home/tux/siduction-21.3.0-wintersky-kde-amd64-202112231751.iso > /dev/sdb
~~~

Der Kopiervorgang kann bei einer etwa 3 GB großen ISO-Abbilddatei durchaus 15 Minuten oder länger benötigen. Bitte entspannt abwarten bis die Eingabeaufforderung zurückkehrt.

#### Zusätzliche Datenpartition

Meist ist das Speichermedium deutlich größer als die ISO-Abbilddatei. Die bisher gezeigten Methoden verwenden alle das gesamte Speichermedium, obwohl die ISO-Abbilddatei nur 2,9 GiB belegt. Das lässt sich im Nachhinein nicht ändern. Es bietet sich an, die Vorteile der Kommandozeile zu nutzen und vorausschauend zwei Partitionen einzurichten. Die erste Partition beinhaltet später das Live-System und die zweite den sonst ungenutzten Speicherplatz. Dadurch haben wir die Möglichkeit Daten auf dem Medium zur Life-Sitzung mitzunehmen und während der Life-Sitzung dort abzulegen.

Wir benutzen als root den Befehl `cgdisk /dev/sdb` um eine neue GUID-Partitionstabelle zu erstellen (siehe die Handbuchseite [Partitionieren mit gdisk](0313-part-gdisk_de.md#partitionieren-mit-gdisk)) und verwenden folgenden Daten:

1. Partition:  
   Startsektor: 64 (Voreinstellung)  
   Größe: 3G (3 GB, etwas größer als die ISO-Abbilddatei)  
   Typ Hex-Code: 0700 (Microsoft basic data)  
   Name: siduction  
2. Partition:  
   Startsektor: xxxxxxxx (Voreinstellung, 1. Sektor nach der vorherigen Partition)  
   Größe: xxxxxxxx (Voreinstellung, die maximal mögliche Größe)  
   Typ Hex-Code: 8300 (Linux)  
   Name: data

Wir schreiben die Partitionstabelle auf das Medium und beenden `cfdisk`, bleiben aber noch in der root-Konsole, denn die zweite Partition benötigt noch ein Dateisystem und ein aussagekräftiges Label um sie während der Life-Sitzung nach dem Mounten leichter im Dateimanager zu finden. Die Befehle lauten:

~~~
mkfs.ext4 -L LifeData /dev/sdb2
~~~

Mit dem so vorbereiteten Speichermedium schreiben wir die ISO-Abbilddatei in die **1. Partition**. 

~~~
dd if=/home/tux/siduction-21.3.0-wintersky-kde-amd64-202112231751.iso of=/dev/sdb1
~~~

Bitte unbedingt auf `/dev/sdb1` achten. Wenn nur `/dev/sdb` benutzt wird überschreibt der dd-Befehl gnadenlos unsere neu erstellte Partitionstabelle.

### Mac OS X Kommandozeile

Der Kopiervorgang ähnelt stark dem Vorgehen bei einem Linux Betriebssystem. Schließe dein USB-Gerät an, Mac OS X sollte es automatisch einbinden. Im Terminal (unter `Applications` \> `Utilities`), wird dieser Befehl ausgeführt:

~~~
diskutil list
~~~

Stelle die Bezeichnung des USB-Gerätes fest und hänge die Partitionen aus (unmount). In unserem Beispiel ist die Bezeichnung `/dev/disk1`:

~~~
diskutil unmountDisk /dev/disk1
~~~

Angenommen die siduction ISO-Abbilddatei wurde im `/home` Verzeichnis des Benutzers **steve** gespeichert, und das USB-Gerät hat die Bezeichnung `disk1`, so führt man folgenden Befehl aus:

~~~
dd if=/Users/steve/siduction-21.3.0-wintersky-kde-amd64-202112231751.iso of=/dev/disk1
~~~

<div id="rev">Zuletzt bearbeitet: 2022-03-10</div>
