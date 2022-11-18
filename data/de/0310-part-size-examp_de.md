% Partitionierung von Installationsmedien

## Partitionierung von Installationsmedien

Linux-Einsteigern empfehlen wir, nur zwei Partitionen anzulegen  
`/root` (inkl. `/home` ) und `swap`, da dies eine Erstinstallation wesentlich vereinfacht. Nach der Installation können weitere Datenpartitionen angelegt werden, oder etwa ein separates `/home`, falls gewünscht.

Wir raten aber eher davon ab eine `/home`-Partition anzulegen.  
Das Verzeichnis `/home` sollte der Ort sein, an dem die individuellen Konfigurationen abgelegt werden, und nur diese. Für alle weiteren privaten Daten sollte eine eigene Datenpartition angelegt werden. Die Vorteile für die Datenstabilität, Datensicherung und auch im Falle einer Datenrettung sind nahezu unermesslich.  
Die Anschaffung einer externen USB-Festplatte zur regelmäßigen Datensicherung ist ebenso eine Überlegung wert.

Eine `swap`-Partition entspricht in der Funktionalität etwa der Auslagerungsdatei bei Windows, ist aber weit effektiver als diese. Ihre Größe richtet sich stark nach dem installierten System und den Anforderungen des Benutzers. Einige Beispiele:  
Für Notebooks, die per `hibernate` in den Ruhezustand versetzt werden sollen, empfehlen wir eine swap Partition die wenigstens ein GByte oder 25% größer ist als das RAM.  
Aktuelle Desktop PCs, die *nicht* in den Ruhezustand versetzt werden sollen und über ausreichend RAM verfügen (je nach Verwendung ab 16 GByte), benötigen keine swap Partition mehr.  
Für Desktop PCs mit sehr wenig RAM gilt nach wie vor die Faustregel, dass die swap Partition zweimal so groß sein sollte wie das verwendete RAM.

Bei Linux System- und Datenpartitionen kommt als Standard das **ext4** Dateisystem zur Anwendung. Ab siduction 2022.12.0 besteht auch die Möglchkeit **Btrfs** auszuwählen, dass in Zusammenarbeit mit dem Programm *snapper* bei Veränderungen am Dateisystem Snapschots erstellt, die anschließend im Bootmanager Grub auswählbar sind.  
Für den Datenaustausch mit einer Windows-Installation sollte die dafür vorgesehene Partition mit **ntfs** formatiert werden. Siduction kann lesend und schreibend auf die Daten zugreifen.

Es gibt sehr viele gute Möglichkeiten seine Platten aufzuteilen. Diese Beispiele sollten einen ersten Einblick in die Möglichkeiten bieten. 

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

Als Partitionstabelle sollte der Typ *"GPT"* gewählt werden. So kann man die Vorteile gegenüber *"MBR"* nutzen. Nur bei alter Hardware ist *"MBR"* noch sinnvoll. Die Erklärungen hierzu enthält unsere Handbuchseite [Partitionieren mit gdisk](0313-part-gdisk_de.md#partitionieren-mit-gdisk).

Die Beispiele beziehen sich auf Partitionstabellen vom Typ *"GPT"*, für deren Funktion die ersten beiden, sehr kleinen Partitionen erforderlich sind.

**Desktop PC, Dual-Boot (MS Windows und Linux)**  
**1 TB Festplatte:**

| Partition | Size | Filesystem | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 50 GB | NTFS | MS Windows System |
| 4 | 500 GB | NTFS | Daten für MS Windows und Linux |
| 5 | 30 GB | ext4 | / (Linux root) |
| 6 | 416 GB | ext4 | Daten für Linux |
| 7 | 4 GB | Linux Swap | Linux Swap |

**Desktop PC, Dual-Boot (MS Windows und Linux)**  
**120 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 40 GB | NTFS | MS Windows System |
| 4 | 48 GB | NTFS | Daten für MS Windows und Linux |
| 5 | 30 GB | ext4 | / (Linux root) |
| 6 | 2 GB | Linux Swap | Linux Swap |

**Desktop PC, Linux allein**  
**500 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 30 GB | ext4 | / |
| 4 | 466 GB | ext4 | Daten |
| 5 | 4 GB | Linux Swap | Linux Swap |

**Desktop PC, Linux allein**  
**500 GB Festplatte mit Snapshot (ab siduction 2022.12.0):**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 496 GB | btrfs | / |
| 4 | 4 GB | Linux Swap | Linux Swap |

**Desktop PC, Linux allein**  
**160 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 1 | 26 GB | ext4 | / |
| 3 | 130 GB | ext4 | Daten |
| 4 | 4 GB | Linux Swap | Linux Swap |

**Laptop mit 32 GB RAM, Dual-Boot mit MS Windows und Linux**  
**1 TB Festplatte:**

| Partition | Size | Filesystem | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 3 | 80 GB | NTFS | MS Windows System |
| 4 | 500 GB | NTFS | Daten für MS Windows und Linux |
| 5 | 30 GB | ext4 | / (Linux root) |
| 6 | 350 GB | ext4 | Daten für Linux |
| 7 | 40 GB | Linux Swap | Linux Swap |

**Laptop mit 8 GB RAM, Linux allein**  
**120 GB Festplatte:**

| Partition | Größe | Formatierung | Verwendung |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI-System |
| 2 | 1 MB | ohne | BIOS-boot |
| 1 | 25 GB | ext4 | / |
| 3 | 85 GB | ext4 | Daten |
| 4 | 10 GB | Linux Swap | Linux Swap |

### Partitionierungsprogramme

+ **GParted** Ein einfach zu bedienendes Partitionierungsprogramm mit graphischer Oberfläche.  
  Gparted ist auf allen mit einer graphischen Oberfläche ausgestatteten siduction Installationen und Installationsmedien verfügbar. Gparted unterstützt eine Reihe verschiedener Typen von Partitionstabellen. Die Handbuchseite [Partitionieren der Festplatte mit GParted](0312-part-gparted_de.md#partitionieren-mit-gparted) liefert weitere Informationen zum Programm.

+ **KDE Partition Manager** Ein Qt basiertes, einfach zu bedienendes Partitionierungsprogramm mit graphischer Oberfläche.  
  Der KDE Partition Manager ist das Standard-Partitionierungsprogramm für den KDE Destktop, einfach zu bedienen und genauso umfangreich wie Gparted.

+ **gdisk / cgdisk** Ein Konsolenprogramm für Partitionstabellen vom Typ *"GPT-UEFI"*.  
  gdisk ist das klassische Textmodus-Programm. cgdisk hat eine benutzerfreundlichere ncurses-Oberfläche. Die Handbuchseite [Partitionieren mit gdisk](0313-part-gdisk_de.md#partitionieren-mit-gdisk) liefert weitere Informationen zum Programm.

+ **fdisk / cfdisk** Ein Konsolenprogramm für Partitionstabellen vom Typ *"msdos-MBR"*.  
  Hinweis: fdisk sollte nur noch für alte Hardware, die *"GPT-UEFI"* nicht unterstützt verwendet werden.  
  fdisk ist das klassische Textmodus-Programm. cfdisk hat eine benutzerfreundlichere ncurses-Oberfläche. Die Handbuchseite [Partitionieren mit Cfdisk](0314-part-cfdisk_de.md#partitionieren-mit-fdisk) liefert weitere Informationen zum Programm.

> **Achtung**  
> Bei Verwendung jedweder Partitionierungssoftware droht Datenverlust. Daten, die noch gebraucht werden, immer zuvor auf einem anderen Datenträger sichern.

Eingebundene Partitionen (auch swap) müssen vor Bearbeitung gelöst werden.  
Im Terminal als **root** mit dem Befehl:

~~~
# umount /dev/sda1
~~~

Die Einbindung einer Swap-Partition wird mit diesem Befehl gelöst: 

~~~
# swapoff -a
~~~

### Weiterführende Infos

[Hier die umfassende englischsprachige Dokumentation von GParted](https://gparted.org/index.php)

Für weitere Partitionierungsoptionen siehe:

+ Logical Volume Manager [LVM-Partitionierung](0315-part-lvm_de.md#lvm-partitionierung---logical-volume-manager)

+ Partitionierung mit GPT zur Unterstützung von UEFI [Partitionieren mit gdisk (GPT fdisk)](0313-part-gdisk_de.md#partitionieren-mit-gdisk)

<div id="rev">Zuletzt bearbeitet: 2021-07-21</div>
