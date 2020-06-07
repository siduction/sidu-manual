ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2020-06
+ Inhalt vollständig überarbeitet.
+ Link geprüft und aktualisiert.
+ Entfernen des Hinweises auf ext2 Treiber für WIN, da offensichtlich buggy.

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
Im Terminal (als root) mit dem Befehl:

~~~ sh
umount /dev/sda1
~~~

Die Einbindung einer swap-Partition wird mit diesem Befehl gelöst: 

~~~ sh
swapoff -a
~~~

---

Die **Mindestanforderungen** für den sinnvollen Gebrauch einer siduction Installation betragen:

| Installationssystem | Festplattenplatz |
| :---:| :--: |
| siduction NOX | 5GB |
| siduction Xorg | 10GB |
| siduction LXQt | 15GB |
| siduction XFCE | 15GB |
| siduction Cinnamon | 15GB |
| siduction GNOME | 15GB |
| siduction KDE Plasma | 15GB |

---

**Allgemeine Hinweise**

Linux-Einsteigern empfehlen wir, nur zwei Partitionen anzulegen (root/home und swap), da dies eine Erstinstallation wesentlich vereinfacht. Nach der Installation können weitere Partitionen für ein separates /home und weitere Datenpartitionen angelegt werden.

Eine swap-Partition entspricht in der Funktionalität etwa der Auslagerungsdatei bei Windows, ist aber weit effektiver als diese. Als Faustregel sollte die Swap-Partition zweimal so groß sein wie das verwendete RAM. Dies gilt hauptsächlich für Notebooks, die per *suspend* in den Energiesparmodus versetzt werden sollen, oder Desktops mit sehr wenig RAM (1 GByte oder weniger). Geräte mit ausreichend RAM brauchen heute keine Swap-Partition mehr.

Für den Datenaustausch mit einer Windows-Installation sollte die dafür vorgesehene Partition mit **ntfs** formatiert werden. Siduction kann mit dem automatisch installierten *ntfs-3g* lesend und schreibend auf die Daten zugreifen.

Es gibt sehr viele gute Möglichkeiten seine Platten aufzuteilen. Diese Beispiele sollten einen ersten Einblick in die Möglichkeiten bieten. 

Die Anschaffung einer externen USB-Festplatte zur regelmäßigen Datensicherung ist ebenso eine Überlegung wert.

---

### Beispiele für Partitionierungen mit verschiedenen Plattengrößen:

Falls ein Dual-Boot mit MS Windows&#8482; angelegt wird, muss MS Windows immer als erstes System auf die Festplatte installiert werden.

## 1. Dual-Boot mit MS Windows und Linux

### 1 TB Festplatte:

| Partition | Size | Filesystem | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 50 GB | NTFS | MS Windows System |
| 2 | 300 GB | NTFS | Daten für MS Windows |
| 2 | 200 GB | NTFS | Daten für MS Windows und Linux |
| 3 | 30 GB | ext4 | / |
| 4 | 70 GB | ext4 | /home |
| 5 | 348 GB | ext4 | Daten für Linux |
| 6 | 2 GB | Linux Swap | Linux Swap |

### 120 GB Festplatte:

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 40 GB | NTFS | MS Windows System |
| 2 | 38 GB | NTFS | Daten für MS Windows und Linux |
| 3 | 20 GB | ext4 | / |
| 4 | 20 GB | ext4 | /home |
| 5 | 2 GB | Linux Swap | Linux Swap |

### 80 GB Festplatte:

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 40 GB | NTFS | MS Windows System |
| 2 | 10 GB | NTFS | Daten für MS Windows und Linux |
| 3 | 28 GB | ext4 | / (inkl. home) |
| 4 | 2 GB | Linux Swap | Linux Swap |

---

## 2. Linux allein

### 500 GB Festplatte:

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 30 GB | ext4 | / |
| 2 | 70 GB | ext4 | /home |
| 3 | 200 GB | ext4 | Daten |
| 4 | 198 GB | ext4 | Daten |
| 5 | 2 GB | Linux Swap | Linux Swap |

### 160 GB Festplatte:

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 20 GB | ext4 | / |
| 2 | 20 GB | ext4 | /home |
| 3 | 118 GB | ext4 | Daten |
| 4 | 2 GB | Linux Swap | Linux Swap |

### 60 GB Festplatte:

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 30 GB | ext4 | / (inkl. /home |
| 3 | 28 GB | ext4 | Daten |
| 4 | 2 GB | Linux Swap | Linux Swap |

---

### Weiterführende Infos

[Hier die umfassende englischsprachige Dokumentation von GParted](https://gparted.org/index.php)

Für weitere Partitionierungsoptionen siehe:

+ Logical Volume Manager [LVM-Partitionierung](part-lvm_de.md#part-lvm)

+ Partitionierung mit GPT zur Unterstützung von UEFI [Partitionieren mit gdisk (GPT fdisk)](part-gdisk_de.md)

+ [Installation auf eine verschlüsselte root-Partition](hd-install-crypt_de.md#install-crypt)

<div id="rev">Page last revised by akli 2020-06-06</div>
