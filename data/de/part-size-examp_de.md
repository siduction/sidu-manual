<div class="divider" id="part-example"></div>

## Partitionsgrößen: Beispiele

 **`Für normalen Gebrauch empfehlen wir das Dateisystem ext4.`**
Mit dem Partitionsmanager GParted werden Festplatten partitioniert und/oder formatiert. Das Programm hat eine grafische Benutzeroberfläche und ist selbsterklärend aufgebaut.

Gparted ist auch in der Lage, Partitionen zu verkleinern oder zu verschieben und es können auch NTFS-Partitionen bearbeitet werden (jedoch mit der Einschränkung, dass nach Bearbeitung einer NTFS-Partition das System sofort neu gestartet werden muss, bevor weitere Bearbeitungsvorgänge durchgeführt werden). [Hier die umfassende englischsprachige Dokumentation von GParted](http://gparted.sourceforge.net/) . Änderungen an NTFS-Partitionen kann man auch mit proprietären Applikationen durchführen (z. B. Partition Magic™, Acronis™.

 **`IMMER EIN BACKUP DER WICHTIGEN DATEN MACHEN!`**
Eine eingebundene Partition (auch swap) muss vor Bearbeitung gelöst werden (entweder mittels Rechtsklick in gparted oder im Terminal). Hier die Syntax für den Konsolenbefehl:

~~~
umount /dev/sda1
~~~

Die Einbindung einer swap-Partition wird mit diesem Befehl gelöst: 

~~~
swapoff -a
~~~

Anschließend kann der Partitionsmanager wieder gestartet werden. Prinzipiell reichen für eine Installation weniger als 5GB, aber damit wird man nicht viel Spass haben. Sinnvolles Mindestmaß sind etwa 12GB. Für Linux-Einsteiger empfehlen wir, nur zwei Partitionen anzulegen (root/home und swap), da dies eine Erstinstallation wesentlich vereinfacht. Nach der Installation können weitere Partitionen für ein separates /home und weitere Datenpartitionen angelegt werden.

Eine swap-Partition entspricht in der Funktionalität etwa der Auslagerungsdatei bei Windows, ist aber weit effektiver als diese. Als Faustregel `sollte die Swap-Partition zweimal so groß sein wie das verwendete RAM` . Dies gilt hauptsächlich für Notebooks, die per  *suspend*  in den Energiesparmodus versetzt werden sollen, oder Desktops mit sehr wenig RAM (1 GByte oder weniger). Geräte mit ausreichend RAM brauchen heute keine Swap-Partition mehr.

Für den Datenaustausch mit einer Windows-Installation soll vfat (fat32) oder ext2 verwendet werden, damit ein Treiber für MS Windows™ zum gegenseitigen Zugriff auf Daten vorhanden ist. [XFS ist nicht unterstützt]. Siehe auch: [Ext2 Installable File System For MS Windows (Info auf Englisch)](http://www.fs-driver.org/)  und [NTFS Partitionen mit ntfs-3g beschreibbar machen](part-gparted-de.htm#hd-ntfs3g) .

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

Es gibt sehr viele gute Möglichkeiten seine Platten aufzuteilen. Diese Beispiele sollten einen ersten Einblick in die Möglichkeiten bieten. 

Die Anschaffung einer externen USB-Festplatte zur regelmäßigen Datensicherung ist ebenso eine Überlegung wert.

`Falls ein Dual-Boot mit MS Windows&#8482; angelegt wird, muss MS Windows immer als erstes System auf die Festplatte/Partition installiert werden` .

Für weitere Partitionierungsoptionen siehe [LVM-Partitionierung - Logical Volume Manager](part-lvm-de.htm#part-lvm)  und [Installation auf eine verschlüsselte root-Partition](hd-install-crypt-de.htm#install-crypt) .

<div id="rev">Page last revised 15/01/2012 1045 UTC</div>
