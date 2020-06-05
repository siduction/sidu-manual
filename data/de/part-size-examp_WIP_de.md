ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2020-06
+ Inhalt vollständig überarbeitet.
+ Link geprüft und aktualisiert.
+ 

ENDE   INFOBEREICH FÜR DIE AUTOREN

<div class="divider" id="part-example"></div>

## Partitionierung von Installationsmedien

## Beispiele und Größen

### Partitionierungsprogramme

+ **GParted** Ein einfach zu bedienendes Partitionierungsprogramm mit graphischer Oberfläche.  
  *Gparted* ist auf allen mit einer graphischen Oberfläche ausgestatteten siduction Installationen und Installationsmedien verfügbar. *Gparted* unterstützt eine Reihe verschiedener Typen von Partitionstabellen. Die Handbuchseite [Partitionieren der Festplatte mit GParted](part-gpartrd_de.md) liefert weitere Informationen zum Programm.

+ **fdisk / cfdisk** Ein Konsolenprogramm für Partitionstabellen vom Typ *msdos - MBR*.
  *fdisk* ist das klassische Textmodus-Programm. *cfdisk* hat eine benutzerfreundlichere curses-Oberfläche. Die Handbuchseite [Partitionieren mit Cfdisk](part-cfdisk_de.md) liefert weitere Informationen zum Programm.

+ **gdisk / cgdisk** Ein Konsolenprogramm für Partitionstabellen vom Typ *GPT - UEFI*.
  *gdisk* ist das klassische Textmodus-Programm. *cgdisk* hat eine benutzerfreundlichere curses-Oberfläche. Die Handbuchseite [Partitionieren mit gdisk](part-gdisk_de.md) liefert weitere Informationen zum Programm.

<warning>**Achtung**</warning>
<warning>Bei Verwendung jedweder Partitionierungssoftware droht Datenverlust. Daten, die erhalten bleiben sollen immer zuvor auf einem anderen Datenträger sichern.</warning>

### Hinweise

**Eingebundene Partitionen** (auch swap) müssen vor Bearbeitung gelöst werden.  
Im Terminal (ggf. als root) mit dem Befehl:

~~~ sh
umount /dev/sda1
~~~

Die Einbindung einer swap-Partition wird mit diesem Befehl gelöst: 

~~~ sh
swapoff -a
~~~

Die **Mindestanforderungen** für den sinnvollen Gebrauch einer siduction Installation betragen:

| Installationssystem | \| Festplattenplatz |
| :---:| :--: |
| Siduction NOX | 5GB |
| Siduction Xorg | 10GB |
| Siduction LXQt | 10GB |
| Siduction XFCE | 10GB |
| Siduction Cinnamon | 10GB |
| Siduction GNOME | 10GB |
| Siduction  | 10GB |

Linux-Einsteiger empfehlen wir, nur zwei Partitionen anzulegen (root/home und swap), da dies eine Erstinstallation wesentlich vereinfacht. Nach der Installation können weitere Partitionen für ein separates /home und weitere Datenpartitionen angelegt werden.

Eine swap-Partition entspricht in der Funktionalität etwa der Auslagerungsdatei bei Windows, ist aber weit effektiver als diese. Als Faustregel `sollte die Swap-Partition zweimal so groß sein wie das verwendete RAM` . Dies gilt hauptsächlich für Notebooks, die per  *suspend*  in den Energiesparmodus versetzt werden sollen, oder Desktops mit sehr wenig RAM (1 GByte oder weniger). Geräte mit ausreichend RAM brauchen heute keine Swap-Partition mehr.

Für den Datenaustausch mit einer Windows-Installation soll vfat (fat32) oder ext2 verwendet werden. damit ein Treiber für MS Windows™ zum gegenseitigen Zugriff auf Daten vorhanden ist. Siehe auch: [Ext2 Installable File System For MS Windows (Info auf Englisch)](http://www.fs-driver.org/)  und [NTFS Partitionen mit ntfs-3g beschreibbar machen](part-gparted-de.htm#hd-ntfs3g).

Wir empfehlen sich die Namen der Partitionen zu notieren.

#### Hier einige einfache Beispiele mit verschiedenen Plattengrößen:

#### 1 TB für den Dual-Boot von MS Windows und Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpunkt/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 50 GB | NTFS | MS Windows System | 
| sdb1 | 100 GB | ext4 | / (inklusive home) | 
| sda3 | 300 GB | FAT32/ext2 | Daten für MS Windows System und Linux | 
| sda2 | 550 GB | ext4 | Daten für Linux |
| sda4 | 2 GB | Linux Swap | Linux Swap | 

---

#### 120 GB Festplatte mit MS Windows, Dual-Boot mit Linux:

|  **Disk**  |  **Größe**  |  **Formatierung**  |  **Mountpunkt/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 30 GB | NTFS | MS Windows System | 
| sda2 | 20 GB | ext3 | / | 
| sda3 | 20 GB | ext3 | /home | 
| sdb1 | 48 GB | FAT32/ext2 | Daten für MS Windows und Linux | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 

---

#### 60 GB für Dualboot von MS Windows Und Linux:

|  **Disk**  |  **Größe**  |  **Formatierung**  |  **Mountpunkt/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 14 GB | NTFS | MS Windows System | 
| sda2 | 10 GB | FAT32/ext2 | Daten für MS Windows und Linux | 
| sda3 | 10 GB | FAT32/ext2 | Daten für MS Windows und Linux | 
| sdb1 | 14GB | ext4 | / (inklusive home) | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 

---

#### 200GB Festplatte:

|  **Disk**  |  **Größe**  |  **Formatierung**  |  **Mountpunkt/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20 GB | ext4 | / | 
| sda2 | 20 GB | ext4 | /home | 
| sda3 | 158 GB | ext2/3/4 | Daten | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 

---

#### 160GB Festplatte:

|  **Disk**  |  **Größe**  |  **Formatierung**  |  **Mountpunkt/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20GB | ext4 | / | 
| sda2 | 20GB | ext4 | /home | 
| sda3 | 59GB | ext4 | Daten | 
| sdb1 | 59GB | ext4 | Daten | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 
#### Allgemein

[Hier die umfassende englischsprachige Dokumentation von GParted](https://gparted.org/index.php)

Es gibt sehr viele gute Möglichkeiten seine Platten aufzuteilen. Diese Beispiele sollten einen ersten Einblick in die Möglichkeiten bieten. 

Die Anschaffung einer externen USB-Festplatte zur regelmäßigen Datensicherung ist ebenso eine Überlegung wert.

`Falls ein Dual-Boot mit MS Windows&#8482; angelegt wird, muss MS Windows immer als erstes System auf die Festplatte/Partition installiert werden` .

Für weitere Partitionierungsoptionen siehe [LVM-Partitionierung - Logical Volume Manager](part-lvm-de.htm#part-lvm)  und [Installation auf eine verschlüsselte root-Partition](hd-install-crypt-de.htm#install-crypt) .

<div id="rev">Page last revised 15/01/2012 1045 UTC</div>
