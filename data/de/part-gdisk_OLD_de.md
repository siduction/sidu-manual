<div class="divider" id="gdisk-1"></div>

## Übersicht über das Partitionieren mit GPT gdisk

GPT gdisk, Globally Unique Identifier (GUID) Partition Table (GPT), ist eine Anwendung, um Datenträger von jeder Größe zu partitionieren `und wird unbedingt für Datenträger benötigt, die größer als 2TB sind` . gdisk sorgt dafür, dass Partitionen für SSDs eingerichtet sind (bzw. für Speicher, die keine 512 Byte großen Sektoren besitzen).

Der entscheidende Vorteil von GPT ist, dass man nicht mehr auf die dem MBR inhärenten primären, erweiterten oder logischen Partitionen angewiesen ist. GBT kann eine beinahe unbegrenzte Anzahl von Partitionen unterstützen und ist nur durch den für Partitionseinträge reservierten Speicherplatz des GPT-Datenträgers eingeschränkt. Zu beachten ist, dass die Anwendung `gdisk`  für 128 Partitionen eingestellt ist.

Falls GPT auf kleinen USB/SSD-Datenträgern eingesetzt wird (zum Beispiel auf einem USB-Stick mit 8GB), könnte sich dies kontraproduktiv auswirken, falls Daten zwischen verschiedenen Computern oder Betriebssystemen ausgetauscht werden sollen.

<!--**`NOTE : USB booting is not supported with GPT.`** 

### Wichtige Anmerkungen

`Die Begriffe UEFI und EFI sind austauschbar und bezeichnen das gleiche Konzept` 

#### GPT-Datenträger

`Einige Betriebssysteme unterstützen keine GPT-Datenträger. Ziehe bitte die Dokumentation Deines jeweiligen Systems zu Rate.` 

GPT-Datenträger können unter Linux auf Computern mit 32 bit und 64 bit eingesetzt werden.

#### Booten von GPT-Datenträgern

Dual- und Triple-Boot von GPT-Datenträgern mit Linux, BSD und Apple ist mit dem `EFI` -Modus mit 64 bit unterstützt.

Dual-Boot von GPT-Datenträgern mit Linux und MS Windows ist möglich. Voraussetzung ist, dass die Version von MS Windows GPT-Datenträger im `UEFI` -Modus mit 64 bit booten kann.

#### Graphische Partitionierungsprogramme für GPT

Neben dem Befehlszeilenprogramm gdisk unterstützen graphische Anwendungen wie 'gparted' und 'partitionmanager' GPT-Datenträger. Trotzdem empfehlen wir gdisk, um unerwünschten Anomalien vorzubeugen. 'Gparted - gparted' sowie 'KDE Partition Manager - partitionmanager' (unter anderen) sind dennoch großartige Hilfsmittel, um die in gdisk durchgeführten Aktionen sich vor Augen führen zu können.

 `Grundlegende Lektüre:`

+
        man gdisk

+ [GPT fdisk Tutorial by Roderick W. Smith (Englisch)](http://www.rodsbooks.com/gdisk/) 

+ [Wikipedia (Englisch)](http://en.wikipedia.org/wiki/GUID_Partition_Table)  - [Wikipedia (Deutsch)](http://de.wikipedia.org/wiki/GUID_Partition_Table>Wikipedia) 

<div class="divider" id="gdisk-2"></div>

## Partitionierung einer HD mit gdisk zur Nutzung eines Linux-Systems

#### Das Verständnis von Schlüsselbefehlen wie **`m`**  (zurück zum Hauptmenü), **`d`** , **`n`**  **``**  und **`t`**  ist Voraussetzung für eine Partitionierung mit gdisk und wir empfehlen, gdisk auf einem Testdatenträger auszuprobieren, um sich mit dem Programm vertraut zu machen.

#### **`WICHTIGE ANMERKUNG über den Befehl n:`**  

<!--####  After creating the first partition you need to press `< Enter 2 2 times`  each time you use **`n`**  to bring up the last sector to set the size of the subsequent partitions.

Bei Verwendung des Befehls **`n`**  wird beim ersten Drücken der <Eingabetaste2 der Partition die nächste freie Nummer übergeben und im Anschluss muss die <Eingabetaste2 ein zweites Mal gedrückt werden, um den Startsektor der nächsten Partition zu akzeptieren, bevor die Größe gesetzt werden kann, um den letzten Sektor zu ermitteln. Zum Beispiel:

~~~
Command (? for help): n 
Partition number (2-128, default 2): 2 
First sector (34-15728606, default = `411648` ) or {+-}size{KMGTP}: 
Last sector (`411648` -15728606, default = 15728606) or {+-}size{KMGTP}: +6144M
~~~

### Beispiel einer Partitionierung eines GPT-Datenträgers

 *Bitte das Beispiel nach eigenen Anforderungen anpassen* .

1. Erstellung einer Partition für den Bootloader `(vorausgesetzt der Datenträger ist nicht ausschließlich für Daten gedacht und muss bootbar sein)` 

2. Erstellung einer Swap-Partition `(vorausgesetzt der Datenträger ist nicht ausschließlich für Daten gedacht und muss bootbar sein)` 

3. Erstellung von Linux-Partitionen 

4. Erstellung weiterer Daten-Partitionen  

**`ANMERKUNG: Das folgende Beispiel nutzt einen USB-Stick, um die Schritte zu demonstrieren, und erhebt daher keinen Anspruch auf Vollständigkeit.`** 

### Die Schritte

Zur Erhebung der Benennung des Datenträgers wird fdisk benutzt (Root-Rechte sind für alle Partitionierungs- und Formatierungsbefehle nötig):

~~~
fdisk -l
~~~

Die Ausgabe von fdisk zeigt den benötigten Pfad und möglicherweise werden weitere Partitionsbezeichnungen innerhalb des Datenträgers gelistet. Im Folgenden ist der Datenträgerpfad nötig, unabhängig von möglicherweise existierenden Partitionen. Im Beispiel gehen wir vom Pfad `sdb`  aus und starten gdisk mit diesem Datenträgerpfad:

~~~
gdisk /dev/sdb
~~~

`Falls der Datenträger nicht neu ist oder bereits GPT nutzt, ist die erste Ausgabe eine Warnung:` 

~~~
GPT fdisk (gdisk) version 0.7.2
Partition table scan:
MBR: MBR only
BSD: not present
APM: not present
GPT: not present
***************************************************************
Found invalid GPT and valid MBR; converting MBR to GPT format.
THIS OPERATION IS POTENTIALLY DESTRUCTIVE! Exit by typing 'q' if
you don't want to convert your MBR partitions to GPT format!
***************************************************************
Command (? for help):
~~~

Falls `gdisk`  auf einem Datenträger mit vorhandenen MBR-Partitionen (ohne GPT) gestartet wird, zeigt das Programm eine von Sternchen umrahmte Warnung über das Konvertieren bestehender Partitionen nach GPT. `Dies ist beabsichtigt, um den Prozess abzubrechen, falls ein falscher Datenträger gewählt wurde bzw. um den Nutzer zum Abbruch zu bewegen, falls er nicht mehr weiter weiß. Auf diese Warnung muss explizit geantwortet werden, bevor der nächste Schritt gesetzt werden kann. Der Hintergrund: eine nicht gewollte Beschädigung des Boot-Datenträgers soll dadurch verhindert werden.` 

Der Befehl **`?`**  listet die möglichen Befehle (`farbige`  Befehle dienen zur Hilfe und Dokumentation):

~~~
Command (? for help): ?
b back up GPT data to a file
c change a partition's name
d delete a partition
i show detailed information on a partition
l list known partition types
n add a new partition
o create a new empty GUID partition table (GPT)
p print the partition table
q quit without saving changes
r recovery and transformation options (experts only)
s sort partitions
t change a partition's type code
v verify disk
w write table to disk and exit
x extra functionality (experts only)
? print this menu
~~~

Zur Bestätigung, dass auf dem gewünschten Datenträger gearbeitet wird, wird **`p`**  eingegeben.  
*(Dieses Beispiel nutzt einen 8GB USB-Stick)*
~~~
Command (? for help): p
Disk /dev/sdb: 16547840 sectors, 7.9 GiB 
Logical sector size: 512 bytes
Disk identifier (GUID): 0267952D-9B06-4B10-A648-B83684786910
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 16547806
Partitions will be aligned on 2048-sector boundaries
Total free space is 16547773 sectors (7.9 GiB)
Number Start (sector) End (sector) Size Code Name
~~~

Die Ausgabespalte `Code`  zeigt den Code des Partitionstyps und die Ausgabespalte `Name`  gibt einen frei bearbeitbaren Text aus.

### Löschen der Partitionierungstabelle

Um eine GPT-Partitionierung aufsetzen zu können, muss nun die gesamte Partitionierungstabelle gelöscht werden:

~~~
command (? for help): d
~~~

<!--If there are multiple partitions gdisk will ask you to type a number representing the partitions you wish to delete.

<div class="divider" id="gdisk-3"></div>

## Booten mit GPT-EFI oder GPT-BIOS

Falls ein bootbarer Datenträger mit GPT erstellt werden soll, gibt es zwei Möglichkeiten den Bootsektor eines GPT-Datenträgers zu formatieren.

Diese Möglichkeiten sind:

+ `Das BIOS des Computers erkennt (U)EFI. Diese Option ist aktiviert und als bootfähig ausgewählt.` 

+ EFI soll zum Booten des GPT-Datenträgers verwendet werden

**oder** 

+ Das BIOS des Computers erkennt (U)EFI **`nicht`** 

+ Das BIOS soll zum Booten des GPT-Datenträgers verwendet werden

### Booten mit EFI

**`Das BIOS muss EFI-fähig sein. EFI muss aktiviert und als bootfähig ausgewählt sein.`**  

Wenn EFI zum Booten verwendet werden soll, muss eine mit FAT formatierte EFI-Systempartition (Typ `EF00` ) als erste Partition erstellt werden. Diese Partition enthält den/die Bootloader. Während der Installation von siduction wird jegliche Auswahlmöglichkeit, wohin der Bootloader installiert werden soll, in der install-gui ignoriert werden. Der Bootloader von siduction wird in der EFI-Systempartition unter `/efi/siduction`  gespeichert. Die EFI-Systempartition wird auch als `/boot/efi`  eingebunden, solange die Option der Einbindung weiterer Partitionen ("mount other partitions") gewählt ist. Die Einbindung der EFI-Systempartition muss im Installer nicht extra angegeben werden.

<!--**`NOTE: USB booting is not supported with GPT.`** 

### Erstellen der EFI-Systempartition

Mit **`n`**  wird eine neue Partition erstellt und `+200M`  übergibt die Größe der Partition.

~~~
Command (? for help): **`n`** 
Partition number (1-128, default 1): **`1`** 
~~~

~~~
First sector (34-16547806, default = 34) or {+-}size{KMGTP}: 
Information: Moved requested sector from 34 to 2048 in
order to align on 2048-sector boundaries.
Use 'l' on the experts' menu to adjust alignment
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M`** 
Current type is 'Linux filesystem'
~~~

**`L`**  präsentiert eine Liste der Partitionierungscodes:

~~~
Hex code or GUID (L to show codes, Enter = 8300): **`L`** 
0700 Microsoft basic data 0c01 Microsoft reserved 2700 Windows RE 
4200 Windows LDM data 4201 Windows LDM metadata 7501 IBM GPFS 
7f00 ChromeOS kernel 7f01 ChromeOS root 7f02 ChromeOS reserved 
8200 Linux swap 8300 Linux filesystem 8301 Linux reserved 
8e00 Linux LVM a500 FreeBSD disklabel a501 FreeBSD boot 
a502 FreeBSD swap a503 FreeBSD UFS a504 FreeBSD ZFS 
a505 FreeBSD Vinum/RAID a800 Apple UFS a901 NetBSD swap 
a902 NetBSD FFS a903 NetBSD LFS a904 NetBSD concatenated 
a905 NetBSD encrypted a906 NetBSD RAID ab00 Apple boot 
af00 Apple HFS/HFS+ af01 Apple RAID af02 Apple RAID offline 
af03 Apple label af04 AppleTV recovery be00 Solaris boot 
bf00 Solaris root bf01 Solaris /usr & Mac Z bf02 Solaris swap 
bf03 Solaris backup bf04 Solaris /var bf05 Solaris /home 
bf06 Solaris alternate se bf07 Solaris Reserved 1 bf08 Solaris Reserved 2 
bf09 Solaris Reserved 3 bf0a Solaris Reserved 4 bf0b Solaris Reserved 5 
c001 HP-UX data c002 HP-UX service **`ef00 EFI System`**  
ef01 MBR partition scheme ef02 BIOS boot partition fd00 Linux RAID
~~~

Mit der Eingabe von `ef00`  wird eine EFI-Systempartition erstellt:

~~~
Hex code or GUID (L to show codes, Enter = 8300): **`ef00`** 
Changed system type of partition to 'EFI System'
~~~

### BIOS-Bootpartition

### Erstellen einer BIOS-BootpartitionCreating a BOIS boot partition

Falls das System UEFI nicht unterstützt, kann eine BIOS-Bootpartition erstellt werden. Diese ersetzt den Sektor eines DOS-partitionierten Datenträgers, der sich zwischen der Partitionierungstabelle und der ersten Partition befindet, und in diesen wird Grub direkt geschrieben.

Mit **`n`**  wird eine neue Partition erstellt und `+200M`  übergibt die Größe der Partition. (Der Grund der Größe +200M anstelle der konventionellen +32M liegt darin, um für den Fall eines Wechsels zu EFI eine ausreichend große Partition zur Verfügung zu haben.)

~~~
Command (? for help): **`n`** 
Partition number (1-128, default 1): **`1`** 
~~~

~~~
First sector (34-16547806, default = 34) or {+-}size{KMGTP}: 
Information: Moved requested sector from 34 to 2048 in
order to align on 2048-sector boundaries.
Use 'l' on the experts' menu to adjust alignment
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M`** 
Current type is 'Linux filesystem'
~~~

Mit der Eingabe von `ef02`  wird eine BIOS-Bootpartition erstellt:

~~~
Hex code or GUID (L to show codes, Enter = 8300): **`ef02`** 
Changed system type of partition to 'BIOS boot'
~~~

**`Wichtige Anmerkung: Die BIOS-Bootpartition darf nicht formatiert werden.`** 

<div class="divider" id="gdisk-4"> </div>

### Erstellen einer Swap-Partition

Die Zuteilung einer Swap-Partition sollte nie unterschätzt werden. Besonders Laptops und Notebooks sollten die Fähigkeit für ein Suspend-to-Disk besitzen. Die Größe der Swap-Partition sollte zumindest der des RAM entsprechen.

Mit der Eingabe von **`n`**  wird eine neue Partition erstellt und mit `+2G`  (oder `+2048M` ) wird der Swap-Partition eine Größe zugeteilt. Die Eingabe von **`8200`**  definiert diese Partition als Linux Swap-Partition:

~~~
Command (? for help): **`n`**  
Partition number (2-128, default 2): **`2`** 
First sector (34-15728606, default = 411648) or {+-}size{KMGTP}: 
Last sector (411648-15728606, default = 15728606) or {+-}size{KMGTP}: **`+2048M`** 
Current type is 'Linux filesystem'
Hex code or GUID (L to show codes, Enter = 8300): **`8200`** 
Changed type of partition to 'Linux swap
~~~

<div class="divider" id="gdisk-5"> </div>

### Erstellen von Daten-Partitionen

Mit der Eingabe von **`n`**  wird eine neue Partition angelegt und `XXXG`  definiert die Größe, in unserem Beispiel `+4G` :

~~~
Partition number (3-128, default 3): **`3`** 
First sector (34-15728606, default = 4605952) or {+-}size{KMGTP}: 
Last sector (4605952-15728606, default = 15728606) or {+-}size{KMGTP}: **`+4G`** 
Current type is 'Linux filesystem'
Hex code or GUID (L to show codes, Enter = 8300): **`8300`** 
Changed type of partition to 'Linux filesystem
~~~

`Dieser Vorgang wird nach den eigenen Anforderungen wiederholt.` 

Da in unserem Beispiel ein USB-Stick verwendet wird, ist es zielführend eine Partition mit `Any OS Data (Typ 0700)`  zu erstellen. Ansonsten wird der Code für ein Linux-Dateisystem (Typ 8300) gegeben:

~~~
Command (? for help): **`n`** 
Partition number (4-128, default 4): **`4`** 
First sector (34-15728606, default = 12994560) or {+-}size{KMGTP}: 
Last sector (12994560-15728606, default = 15728606) or {+-}size{KMGTP}:**`+1300M`** 
Current type is 'Linux filesystem'
Hex code or GUID (L to show codes, Enter = 8300): **`0700`** 
Changed type of partition to 'Microsoft basic data'
~~~

Am Ende lässt man sich am besten einen Überblick über die erstellten Partitionen ausgeben:

~~~
Command (? for help): **`p`** 
Disk /dev/sdx: 15728640 sectors, 7.5 GiB
Logical sector size: 512 bytes
Disk identifier (GUID): F409CFD3-6DDC-4551-BBC5-85DC218C1352
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 15728606
Partitions will be aligned on 2048-sector boundaries
Total free space is 73661 sectors (36.0 MiB)

Number Start (sector) End (sector) Size Code Name
1 2048 411647 200.0 MiB EF00 Boot
2 411648 4605951 2.0 GiB 8200 Swap
3 4605952 12994559 4.0 GiB 8300 Linux File System
4 12994560 15656959 1.3 GiB 0700 Any OS Data
~~~

Zur Beifügung einer Beschreibung zu jeder Partition wird der Befehl **`c`**  verwendet. Beispiel:

~~~
Command (? for help): **`c`** 
Partition number (1-4): **`4`** 
Enter name: `Aussagekräftige Bezeichnung nach Belieben` 
~~~

Mit **`w`**  werden die Veränderungen auf den Datenträger geschrieben, mit **`q`**  das Programm ohne Speicherung verlassen:

~~~
Command (? for help): **`w`** 

Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING
PARTITIONS!!

Do you want to proceed? (Y/N): **`y`** 
OK; writing new GUID partition table (GPT).
The operation has completed successfully.
~~~

<div class="divider" id="gdisk-6"></div>

## Formatieren der Partitionen

Da gdisk nur Partitionen, aber keine Dateisysteme erstellt, muss jede der neuen Partitionen formatiert werden. Die genaue Bezeichnung der Partitionen muss bekannt sein, daher:

~~~
fdisk -l
~~~

fdisk zeigt den benötigten Pfad. In unserem Beispiel `sdb` :

~~~
gdisk /dev/sdb
Command (? for help): **`p`** 
~~~

Mit **`q`**  wird gdisk beendet. Am Root-Prompt **`#`**  kann nun der Pfad mit der Nummer für jede Partition angegeben werden:

Für die EFI-Systempartition **`(Eine BIOS-Bootpartition darf nicht formatiert werden!)`** :

~~~
mkfs -t vfat /dev/sdb1
~~~

Für die Linuxpartition `(Für weitere Linuxpartitionen würden sie die Partitionsnummern selbstverständlich ändern: sdb4, sdb5, ...)` :

~~~
mkfs -t ext4 /dev/sdb3
~~~

Für die Datenpartition 'Any OS' `(wird wohl insbesonders für Kompatibilität über Plattformen hinweg benötigt)` :

~~~
mkfs -t vfat /dev/sdb4
~~~

Formatieren der Swap-Partition:

~~~
mkswap /dev/sdb2
~~~

Danach:

~~~
swapon /dev/sdb2
~~~

Kontrolle, ob Swap erkannt wird:

~~~
swapon -s
~~~

Falls Swap korrekt erkannt wurde:

~~~
swapoff -a
~~~

Diese Befehle funktionieren wie auf MBR-Partitionen.

#### **`Als nächstes ist es unbedingt notwendig, das System neu zu starten, damit das neue Partitionierungs- und Dateisystemschema vom Kernel eingelesen wird.`** 

Nach dem Neustart kann der neue GPT-Datenträger seiner Bestimmung gemäß verwendet werden.

<div class="divider" id="gdisk-7"></div>

## Erweiterte Befehle von gdisk

Vor dem Speichern der Änderungen kann es erwünscht sein zu überprüfen, ob die GPT-Datenstrukturen Fehler aufweisen. Dies ermöglicht der Befehl **`v`** :

~~~
Command (? for help): v
No problems found. 0 free sectors (0 bytes) available in 0
segments, the largest of which is 0 sectors (0 bytes) in size
~~~

In diesem Fall ist jedes Byte des Datenträgers zugeordnet und es wurden keine Probleme gefunden. Falls noch freier Platz zur Erstellung von Partitionen vorhanden wäre, könnte dies nun gesehen werden. Auch würden Probleme mit überlappenden Partitionen oder nicht entsprechenden Haupt- und Sicherungspartitionstabellen jetzt erkannt werden. Selbstverständlich besitzt gdisk Sicherheitsmechanismen, damit solche Fehler nicht auftreten, aber die Option v bietet Hilfe zur Entdeckung von Datenkorruption.

Falls Probleme entdeckt wurden, besteht die Möglichkeit, dass diese mit verschiedenen Optionen im Menü `recovery & transformation`  behoben werden. Dies ist ein Untermenü, zu dem man mit dem Befehl **`r`**  gelangt:

~~~
Command (? for help): r

recovery/transformation command (? for help): ?
b use backup GPT header (rebuilding main)
c load backup partition table from disk (rebuilding main)
d use main GPT header (rebuilding backup)
e load main partition table from disk (rebuilding backup)
f load MBR and build fresh GPT from it
g convert GPT into MBR and exit
h make hybrid MBR
i show detailed information on a partition
l load partition data from a backup file
m return to main menu
o print protective MBR data
p print the partition table
q quit without saving changes
t transform BSD disklabel partition
v verify disk
w write table to disk and exit
x extra functionality (experts only)
? print this menu
~~~

Ein drittes Menü, `experts` , erreicht man mit **`x`**  entweder vom `main menu`  oder dem `recovery & transformation menu` .

~~~
recovery/transformation command (? for help): x

Expert command (? for help): ?
a set attributes
c change partition GUID
d display the sector alignment value
e relocate backup data structures to the end of the disk
g change disk GUID
i show detailed information on a partition
l set the sector alignment value
m return to main menu
n create a new protective MBR
o print protective MBR data
p print the partition table
q quit without saving changes
r recovery and transformation options (experts only)
s resize partition table
v verify disk
w write table to disk and exit
z zap (destroy) GPT data structures and exit
? print this menu
~~~

Dieses Menü ermöglicht Low-Level-Bearbeitung wie Änderung der Partition oder der GUIDs des Datenträgers (**`c`**  bzw. **`g`** ). Die Option **`z`**  zerstört augenblicklich die GPT-Datenstrukturen. Dies kann sinnvoll sein, wenn der GPT-Datenträger mit einem anderen Partitionierungsschema verwendet werden soll. Falls diese Strukturen nicht ausgelöscht werden, können einige Partitionierungsprogramme wegen des Vorhandenseins von zwei Partitionierungssystemen Probleme haben.

Trotz alledem: die Optionen der Menüs `recovery & transformation`  und `experts`  sollten nur benutzt werden, wenn man sich sehr gut mit GPT auskennt. Als "Nicht-Experte" sollte man diese Menüs nur verwenden, wenn ein Datenträger beschädigt ist. Vor jeder drastischen Aktion sollte die Option **`b`**  im Hauptmenü verwendet werden, um eine Sicherungskopie in einer Datei anzulegen und diese auf einem separaten Datenträger speichern. Dadurch kann die originale Konfiguration wieder hergestellt werden, falls die Aktion nicht nach Wunsch läuft.

#### Quellen: 

 [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/) 

 [Windows Hardware Developer Center](http://msdn.microsoft.com/en-us/windows/hardware/gg463525) 

<div class="divider" id="gdisk-8"></div>

## Dual booting with Linux and another OS - TBA

+       
    ~~~
    man gdisk
    ~~~

+ [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/) 

+ [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table) 

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
