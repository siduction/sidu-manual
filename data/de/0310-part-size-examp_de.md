% Partitionierung von Installationsmedien

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

Änderungen 2020-06

+ Inhalt vollständig überarbeitet.  
+ Link geprüft und aktualisiert.  
+ Entfernen des Hinweises auf ext2 Treiber für WIN, da offensichtlich buggy.  

Änderungen 2020-12:

+ Für die Verwendung mit pandoc optimiert.
+ Inhalt teilweise überarbeitet.

Änderungen 202-03:

+ Gnome entfernt, LXde hinzugefügt.
+ /home-Partition entfernt Erklärung unter Hinweise eingefügt.
+ KDE Partition Manager hinzugefügt.

ENDE INFOBEREICH FÜR DIE AUTOREN

## Partitionierung von Installationsmedien

Linux-Einsteigern empfehlen wir, nur zwei Partitionen anzulegen (root/home und swap), da dies eine Erstinstallation wesentlich vereinfacht. Nach der Installation können weitere Datenpartitionen angelegt werden.

Wir raten generell davon ab eine /home-Partition anzulegen.  
Das Verzeichnis **/home** sollte der Ort sein, an dem die individuellen Konfigurationen abgelegt werden, und nur diese. Für alle weiteren privaten Daten sollte eine eigene Datenpartition angelegt werden. Die Vorteile für die Datenstabilität, Datensicherung und auch im Falle einer Datenrettung sind nahezu unermesslich.

Eine swap-Partition entspricht in der Funktionalität etwa der Auslagerungsdatei bei Windows, ist aber weit effektiver als diese. Als Faustregel sollte die Swap-Partition zweimal so groß sein wie das verwendete RAM. Dies gilt hauptsächlich für Notebooks, die per *suspend* in den Energiesparmodus versetzt werden sollen, oder Desktops mit sehr wenig RAM (1 GByte oder weniger). Geräte mit ausreichend RAM brauchen heute keine Swap-Partition mehr.

Für den Datenaustausch mit einer Windows-Installation sollte die dafür vorgesehene Partition mit **ntfs** formatiert werden. Siduction kann mit dem automatisch installierten *ntfs-3g* lesend und schreibend auf die Daten zugreifen.

Es gibt sehr viele gute Möglichkeiten seine Platten aufzuteilen. Diese Beispiele sollten einen ersten Einblick in die Möglichkeiten bieten. 

Die Anschaffung einer externen USB-Festplatte zur regelmäßigen Datensicherung ist ebenso eine Überlegung wert.

### Mindestanforderungen

Die Mindestanforderungen für den sinnvollen Gebrauch einer siduction Installation betragen:

| Installationssystem | Festplattenplatz |
| :--- | :--: |
| siduction NOX | 5GB |
| siduction Xorg | 10GB |
| siduction LXQt | 15GB |
| siduction LXde | 15GB |
| siduction XFCE | 15GB |
| siduction Cinnamon | 15GB |
| siduction KDE Plasma | 15GB |

### Beispiele mit verschiedenen Plattengrößen

Falls ein Dual-Boot mit MS Windows&#8482; angelegt wird, muss MS Windows immer als erstes System auf die Festplatte installiert werden.

Als Partitionstabelle sollte der Typ "*GPT*" gewählt werden. So kann man die Vorteile gegenüber "*MBR*" nutzen. Nur bei alter Hardware ist "*MBR*" noch sinnvoll. Die Erklärungen hierzu enthält unsere Handbuchseite [Partitionieren mit gdisk, warum GPT](part-gdisk_de.md#warum-gdisk-gpt-fdisk-verwenden).

Die Beispiele beziehen sich auf Partitionstabellen vom Typ "*GPT*", für deren Funktion die ersten beiden, sehr kleinen Partitionen erforderlich sind.

**Dual-Boot mit MS Windows und Linux**

**1 TB Festplatte:**

| Partition | Size | Filesystem | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 50 GB | NTFS | MS Windows System |
| 4 | 300 GB | NTFS | Daten für MS Windows |
| 5 | 200 GB | NTFS | Daten für MS Windows und Linux |
| 6 | 30 GB | ext4 | / (Linux root) |
| 7 | 416 GB | ext4 | Daten für Linux |
| 8 | 4 GB | Linux Swap | Linux Swap |

**120 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 40 GB | NTFS | MS Windows System |
| 4 | 48 GB | NTFS | Daten für MS Windows und Linux |
| 5 | 30 GB | ext4 | / (Linux root) |
| 6 | 2 GB | Linux Swap | Linux Swap |

**80 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 40 GB | NTFS | MS Windows System |
| 4 | 10 GB | NTFS | Daten für MS Windows und Linux |
| 5 | 28 GB | ext4 | / (Linux root) |
| 6 | 2 GB | Linux Swap | Linux Swap |


**Linux allein**

**500 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 30 GB | ext4 | / |
| 4 | 250 GB | ext4 | Daten_1 |
| 5 | 216 GB | ext4 | Daten_2 |
| 6 | 4 GB | Linux Swap | Linux Swap |

**160 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 1 | 26 GB | ext4 | / |
| 3 | 130 GB | ext4 | Daten |
| 4 | 4 GB | Linux Swap | Linux Swap |

**60 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 25 GB | ext4 | / |
| 4 | 33 GB | ext4 | Daten |
| 5 | 2 GB | Linux Swap | Linux Swap |

### Partitionierungsprogramme

+ **GParted** Ein einfach zu bedienendes Partitionierungsprogramm mit graphischer Oberfläche.  
  *Gparted* ist auf allen mit einer graphischen Oberfläche ausgestatteten siduction Installationen und Installationsmedien verfügbar. *Gparted* unterstützt eine Reihe verschiedener Typen von Partitionstabellen. Die Handbuchseite [Partitionieren der Festplatte mit GParted](part-gparted_de.md#partitionieren-mit-gparted) liefert weitere Informationen zum Programm.

+ **KDE Partition Manager** Ein Qt basiertes, einfach zu bedienendes Partitionierungsprogramm mit graphischer Oberfläche.  
  Der *KDE Partition Manager* ist das Standard-Partitionierungsprogramm für den KDE Destktop, einfach zu bedienen und genauso umfangreich wie *Gparted*.

+ **gdisk / cgdisk** Ein Konsolenprogramm für Partitionstabellen vom Typ *GPT - UEFI*.  
  *gdisk* ist das klassische Textmodus-Programm. *cgdisk* hat eine benutzerfreundlichere ncurses-Oberfläche. Die Handbuchseite [Partitionieren mit gdisk](part-gdisk_de.md#partitionieren-mit-gdisk) liefert weitere Informationen zum Programm.

+ **fdisk / cfdisk** Ein Konsolenprogramm für Partitionstabellen vom Typ *msdos - MBR*.  
  Hinweis: *fdisk* sollte nur noch für alte Hardware, die *GPT - UEFI* nicht unterstützt verwendet werden.  
  *fdisk* ist das klassische Textmodus-Programm. *cfdisk* hat eine benutzerfreundlichere ncurses-Oberfläche. Die Handbuchseite [Partitionieren mit Cfdisk](part-cfdisk_de.md#partitionieren-mit-fdisk) liefert weitere Informationen zum Programm.

> **Achtung**
> Bei Verwendung jedweder Partitionierungssoftware droht Datenverlust. Daten, die erhalten bleiben sollen, immer zuvor auf einem anderen Datenträger sichern.

**Eingebundene Partitionen** (auch swap) müssen vor Bearbeitung gelöst werden.  
Im Terminal (als root) mit dem Befehl:

~~~
# umount /dev/sda1
~~~

Die Einbindung einer swap-Partition wird mit diesem Befehl gelöst: 

~~~
# swapoff -a
~~~

### Weiterführende Infos

[Hier die umfassende englischsprachige Dokumentation von GParted](https://gparted.org/index.php)

Für weitere Partitionierungsoptionen siehe:

+ Logical Volume Manager [LVM-Partitionierung](part-lvm_de.md#lvm-partitionierung---logical-volume-manager)

+ Partitionierung mit GPT zur Unterstützung von UEFI [Partitionieren mit gdisk (GPT fdisk)](part-gdisk_de.md#partitionieren-mit-gdisk)

+ [Installation auf eine verschlüsselte root-Partition](hd-install-crypt_de.md#installation-auf-verschlüsselte-root-partition)

<div id="rev">Zuletzt bearbeitet: 2021-05-04</div>
