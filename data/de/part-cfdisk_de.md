ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2020-05:
+ Inhalt vollständig überarbeitet.
+ Neue Aufteilung der Kapitel.
+ Veraltete Inhalte entfernt.

ENDE   INFOBEREICH FÜR DIE AUTOREN

<div class="divider" id="disknames"></div>

## Partitionieren mit Cfdisk

### Benennungspraxis für Festplatten und Partitionen

**Bitte BEACHTEN: bezüglich der Benennung von Speichergeräten**  
siduction verwendet in der fstab UUID für die Benennung von Speichergeräten. Bitte das Kapitel [Benennung nach UUID](part-uuid_de.md#uuid) zu Rate ziehen.

#### Für Festplatten

Seit udev den Universal Unique Identifier (UUID) übernommen hat nutzen alle Festplatten und Laufwerke eine Benennung, die aus einer Kombination von drei Buchstaben und Nummern besteht, welche zum Beispiel `sda`  lautet, und für Partitionen das Schema `sdaX`  aufweist, wobei X eine Zahl ist.

Welche Hardware auch immer eingesetzt wird (IDE, SATA , SCSI, SSD oder M2-HD, einzig der dritte Buchstabe unterscheidet nun die verschiedenen Festplatten oder Laufwerke:`/dev/sda`, `/dev/sdb`, `/dev/sdc`  usw.

Informationen über die Geräte erhält man leicht von einem Informationsfenster (Pop-Up), wenn man mit der Maus auf das Icon eines Geräts auf dem Desktop geht. Dies funktioniert sowohl von der Live-CD als auch bei einem installierten siduction.

Wir empfehlen die Erstellung einer Tabelle (manuell oder generiert), welche die Details aller Geräte enthält. Dies kann sehr hilfreich sein, falls Probleme auftreten. In einem Terminal werden wir mit **`su`** zu root ud geben **`fdisk -l`** ein. Bei zwei Festplatten bekommen wir z. B. eine Ausgabe ähnlich der unten gezeigten. Mit dem Befehl  
**`fdisk -l > /home/<MEIN USER NAME>/Dokumente/fdisk-l_Ausgabe`**  
erhalten wir eine Text-Datei mit dem gleichen Inhalt.

~~~ sh
user1@pc1:~$ su
Passwort: <MEIN ROOT PASSWORT>
fdisk -l

Disk /dev/sda: 149,5 GiB, 160041885696 bytes, 312581808 sectors
Disk model: FUJITSU MHY2160B
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x6513a8ff

Device     Boot     Start       End   Sectors  Size Id Type
/dev/sda1            2048  41945087  41943040   20G 83 Linux
/dev/sda2        41945088  83888127  41943040   20G 83 Linux
/dev/sda3        83888128  88291327   4403200  2,1G 82 Linux swap / Solaris
/dev/sda4        88291328 312581807 224290480  107G  5 Extended
/dev/sda5        88293376 249774079 161480704   77G 83 Linux
/dev/sda6       249776128 281233407  31457280   15G 83 Linux
/dev/sda7       281235456 312581807  31346352   15G 83 Linux


Disk /dev/sdb: 119,25 GiB, 128035676160 bytes, 250069680 sectors
Disk model: Samsung SSD 850 
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x000403b7

Device     Boot     Start       End   Sectors  Size Id Type
/dev/sdb1            2048  17831935  17829888  8,5G 82 Linux swap / Solaris
/dev/sdb2        17831936 122687487 104855552   50G 83 Linux
/dev/sdb3       122687488 250068991 127381504 60,8G 83 Linux
~~~

#### Für Partitionen

Es gibt folgende Partitionstypen: primäre, erweiterte und logische. Die logischen Partitionen befinden sich innerhalb der erweiterten Partition. Es sind maximal vier primäre bzw. drei primäre und eine erweiterte Partition anlegbar. Die erweiterte Partition kann bis zu elf logische Partitionen enthalten.  
Primäre oder erweiterte Partitionen erhalten eine Bezeichnung zwischen 1 und 4 (zum Beispiel sda1 bis sda4). Logische Partitionen sind immer gebündelt und Teil einer erweiterten Partition. Mit libata können maximal elf logische Partitionen definiert werden, und ihre Bezeichnungen beginnen mit Nummer 5 (sda5) und enden höchstens mit Nummer 15 (sda15).

Der neuere Standard **G**lobally Unique Identifier **P**artition **T**able (GPT), der Teil des UEFI-Standards ist, wird den MBR ersetzen und erlaubt Platten/Partitionen größer als 2 TByte und eine theoretisch unbegrenzte Anzahl primärer Partitionen. Weitere Informationen dazu gibt es in [Wikipedia GUID-Partitionstabelle](https://de.wikipedia.org/wiki/GUID_Partition_Table)  
Zum Partitionieren mit GPT bitte die Handbuchseite [Partitionieren mit gdisk](part-gdisk_de.md) zu Rate ziehen.

#### Beispiele

`/dev/sda5`  kann nur eine logische Partition sein (in diesem Fall die erste logische auf diesem Gerät). Sie befindet sich auf der ersten Festplatte des Computers (abhängig von der BIOS-Konfiguration).

`/dev/sdb3`  kann nur eine primäre oder erweiterte Partition sein. Der Buchstabe "b" indiziert, dass diese Partition sich auf einem anderen Gerät befindet als die Partition des ersten Beispiels, welche den Buchstaben "a" enthält.

---

<div class="divider" id="partition"></div>

## Cfdisk verwenden

<warning>**Daten zuvor sichern!**</warning>
<warning>Bei Verwendung jedweder Partitionierungssoftware droht Datenverlust. Daten, die erhalten bleiben sollen immer zuvor auf einem anderen Datenträger sichern.</warning>

In einer Konsole wird cfdisk als root gestartet (nach "su" ist die Eingabe des root-Passworts gefordert):

~~~ sh
user1@pc1:/$ su
Passwort: <MEIN-ROOT-PASSWORT>
root@pc1:/#
cfdisk /dev/sda
~~~

### Die Bedienoberfläche

Im ersten Bildschirm zeigt cfdisk die aktuelle Partitionstabelle mit den Namen und einigen Informationen zu jeder Partition. Am unteren Ende des Fensters befinden sich einige Befehlsschalter. Um zwischen den Partitionen zu wechseln, benutzt man die Pfeiltasten auf, ab. Um Befehle auszuwählen, benutzt man die Pfeiltasten rechts, links. Um Befehle auszuführen betätigt man die 'Enter' Taste.

![cfdisk - Start](../../static/images-de/cfdisk-de/cfdisk_01.png)

Wir haben auf der Beispielfestplatte drei Partitionen.

| Device | Part. Größe | Part. Typ | Mountpoint |
| --- | ---: | :---: | ---: |
| /dev/sda1 | 8,5G | 82 Swap | - |
| /dev/sda2 | 50,0G | 83 Linux | / |
| /dev/sda3 | 60,8G | 83 Linux | /home |

Aus der Home-Partition möchten wir die Verzeichnisse 'Bilder' und 'Download' in eigene Partitionen auslagern und dafür mehr Platz schaffen. Die Root-Partition ist mit 50 GB überdimensioniert. Die Partition für die Bilder soll auch für ein auf einer weiteren Festplatte residierendes Windows zugänglich sein.

### Löschen einer Partition

Um Platz zu schaffen, löschen wir die Home-Partition und verkleinern anschließend die Root-Partition.

Um die Partition /dev/sda3 zu löschen, wird sie mit den auf-ab-Tasten markiert und der Befehl **`Delete`** mit den Pfeiltasten links-rechts gewählt und durch **`Enter`** bestätigt.

![Delete a partition](../../static/images-de/cfdisk-de/cfdisk_02.png) 

### Größe einer Partition ändern

Die Partition /dev/sda2 wird markiert und der Befehl **`Resize`** ausgewählt und bestätigt.

![Resize a partition](../../static/images-de/cfdisk-de/cfdisk_03.png)

Anschließend erfolgt die Eingabe der neuen Größe von '20G'

![New Size of a partition](../../static/images-de/cfdisk-de/cfdisk_04.png)

### Erstellen einer neuen Partition

Der nun freie Platz der Festplatte wird markiert. Die Befehlsauswahl springt automatisch auf **`New`**, die zu bestätigen ist.

![Create a new partition](../../static/images-de/cfdisk-de/cfdisk_05.png)

Anschließend ist die neue Größe von '15G' für die Home-Partition einzugeben.

![Create a new partition - Size](../../static/images-de/cfdisk-de/cfdisk_06.png)

Jetzt muss zwischen einer **primären** oder einer **erweiterten** (extended) Partition entschieden werden. Wir entscheiden uns für eine primäre Partition.

![Create a new partition - prim](../../static/images-de/cfdisk-de/cfdisk_07.png)

Danach wird wieder der freie Plattenplatz markiert, bestätigt und die voreingestellte gesamte Größe ebenso bestätigt. In der folgenden Auswahl ist **`extended`** zu wählen. Dies erstellt die Erweiterte Partition (hier 'Container' genannt) in der die beiden Partitionen für unsere Daten anzulegen sind.

![extended partition](../../static/images-de/cfdisk-de/cfdisk_08.png)

Zum Schluss sind die zwei Partitionen für 'Download' und 'Bilder' entsprechend dem oben gezeigten Vorgehen in der gewünschten Größe anzulegen. Da nur noch logische Partitionen möglich sind, entfällt die Auswahl zwischen einer primären und einer erweiterten Partition.

![partition finished](../../static/images-de/cfdisk-de/cfdisk_09.png) So sieht das Ergebnis aus.

### Partitionstyp

Um den Typ einer Partition zu ändern, markiert man die gewünschte Partition und wählt den Befehl **`Type`** aus.

![partition type](../../static/images-de/cfdisk-de/cfdisk_10.png)

Es erscheint eine Auswahlliste in der mit den Pfeiltasten auf und ab der Partitionstyp gewählt wird. In unserem Beispiel wählen wir für die Partition /dev/sda6, die die Bilder aufnehmen soll, **`7 HPFS/NTFS/exFAT`** aus. So kann das oben erwähnte Windows auf die Partition zugreifen.

![partition type](../../static/images-de/cfdisk-de/cfdisk_11.png)

### Eine Partition bootfähig machen

Für Linux besteht kein Grund, eine Partition bootfähig zu machen, aber einige andere Betriebssysteme brauchen das. Dabei wird die entsprechende Partition markiert und der Befehl **`Bootable`** gewählt (Anmerkung: Bei Installation auf eine externe Festplatte muss eine Partition bootfähig gemacht werden).

### Das Ergebnis auf die Platte schreiben

Wenn alles fertig partitioniert ist, kann das Resultat mit dem Befehl **`Write`** gesichert werden. Die Partitionstabelle wird jetzt auf die Platte geschrieben.

![partition select type](../../static/images-de/cfdisk-de/cfdisk_12.png)

**Da damit alle Daten auf der entsprechenden Festplatte/Partition gelöscht werden** , sollte man sich seiner Sache wirklich sicher sein, bevor man **`yes`** eintippt und noch einmal mit der Entertaste bestätigt.

### Beenden

Um das Programm nun zu verlassen, wird der Befehl **`Quit`** benutzt. Nach Beendigung von **cfdisk** und vor der Installation sollte man auf jeden Fall rebooten, um die Partitionstabelle neu einlesen zu lassen.

---

<div class="divider" id="formating"></div>

## Formatieren von Partitionen

### Grundlagen

Es gibt für Linux verschiedene Filesysteme, die man benutzen kann. Da wären **Ext2**, **Ext4**, **ReiserFs** und für erfahrenere Anwender **XFS**, **JFS** und **ZFS**.  
Ext2 kann von Interesse sein, wenn man von Windows aus zugreifen möchte, da es Windows-Treiber für dieses Dateisystem gibt. [Ext2-Dateisystem für MS Windows (Treiber und englischsprachige Doku)](http://www.fs-driver.org/).

Für normalen Gebrauch empfehlen wir das Dateisystem ext4. Ext4 ist das Standard-Dateisystem von siduction. 

### Formatieren

Nach Beendigung von cfdisk wird die Root-Konsole weiter verwendet. Eine Formatierung erfordert Root-Rechte.  
Der Befehl lautet **`mkfs.ext4 /dev/sdaX`**. Für "X" trägt man die Nummer der ausgewählten Partition ein.

~~~ sh
mkfs.ext4 /dev/sda2
mke2fs 1.45.6 (20-Mar-2020)
/dev/sdb2 contains a ext4 file system
	last mounted on Tue May 26 14:26:34 2020
Proceed anyway? (y,N)
~~~

Die Abfrage wird mit "**y**" beantwortet, wenn man darin sicher ist, dass die richtige Partition formatiert werden soll. Bitte mehrfach überprüfen!

Nach Abschluss der Formatierung muss die Meldung erfolgen, dass ext4 erfolgreich geschrieben wurde. Ist das nicht der Fall, ist bei der Partitionierung etwas schiefgelaufen oder **sdaX** ist keine Linux-Partition. Wir überprüfen mit:

~~~ sh
fdisk -l /dev/sda
~~~

Wenn etwas falsch ist, muss gegebenenfalls noch einmal partitioniert werden.

War die Formatierung erfolgreich, so wird dieser Ablauf für die anderen Partitionen wiederholt, wobei der Befehl entsprechend des Partitions-Typ und des gewünschten Dateisystem anzupassen ist. (z. B.: 'mkfs.ext2' oder 'mkfs.vfat' oder 'mkfs.ntfs' usw.)
Bitte die Manpage **`man mkfs`** lesen.

Zuletzt wird die Swap-Partition formatiert, in diesem Fall sda1:

~~~ sh
mkswap /dev/sda1
~~~

Im Anschluss wird die Swap-Partition aktiviert:

~~~ sh
swapon /dev/sda1
~~~

Danach kann in der Konsole überprüft werden, ob die Swap-Partition erkannt wird:

~~~ sh
swapon -s
~~~

Bei eingebundener Swap-Partition sollte die Ausgabe auf den vorherigen Befehl etwa so aussehen:

~~~ sh
Filename        Type        Size      Used   Priority
/dev/sda1       partition   8914940   0      -2
~~~

Wird die Swap-Partition korrekt erkannt, starten wir den Computer neu.

Jetzt kann die Installation beginnen.

<div id="rev">Content last revised by akli 2020-06-03</div>
