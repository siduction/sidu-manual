% fromiso

**STATUS**
**RC1**

Änderungen 2021-04
+ für Pandoc vorbereitet



# fromiso

## Booten "fromiso" - Überblick

 **Für normalen Gebrauch empfehlen wir das Standarddateisystem von siduction, ext4, welches von den Maintainern gut betreut ist.**
 
Dieser Cheatcode startet aus einer ISO-Datei auf der Festplatte (ext4). Das ist viel schneller als von einer CD (Festplatten-Installationen "fromiso" dauern nur einen Bruchteil der Zeit).

Dies ist natürlich viel schneller als von einem CD/DVD-Laufwerk, und das Laufwerk steht gleichzeitig zur Verfügung. Alternativ kann man auch VBox, KVM oder QEMU verwenden.

## Voraussetzungen:

* eine funktionierende Grub-Installation (auf Floppy, einer Festplatteninstallation oder der Live-CD)  
* eine siduction-Imagedatei, z. B. siduction.iso (Name gekürzt) und ein Linux-Dateisystem wie ext4  

## fromiso mit Grub2

siduction liefert eine grub2-Datei mit der Bezeichnung 60_fll-fromiso, um einen fromiso-Eintrag im grub2-Menü zu generieren. Die Konfigurationsdatei für fromiso ist `grub2-fll-fromiso` , mit dem Pfad `/etc/default/grub2-fll-fromiso` .

 Als erstes öffnet man einen Terminal und wird root mit:

~~~sh
suxterm
apt-get update
apt-get install grub2-fll-fromiso
~~~

Im Anschluss öffnet man einen Editor der Wahl (kwrite, mcedit, vim ...):

~~~sh
mcedit /etc/default/grub2-fll-fromiso
~~~

In den Zeilen, die aktiv sein sollen, wird das Kommentarzeichen **`#`**  entfernt, und man ersetzt die voreingestellten Anweisungen innerhalb der *`Anführungszeichen`* mit den eigenen Parametern.

Beispiel: vergleiche diese geänderte grub2-fll-fromiso mit den Grundeinstellungen (die zur Demonstration `hervorgehobenen`  Zeilen wurden geändert):

~~~sh
# Defaults for grub2-fll-fromiso update-grub helper
# sourced by grub2's update-grub
# installed at /etc/default/grub2-fll-fromiso by the maintainer scripts

#
# This is a POSIX shell fragment
#

# specify where to look for the ISO
# default: /srv/ISO <span class="highlight-1">
## Achtung: Dies ist der Pfad zum Verzeichnis, in dem das oder die ISO(s) liegen,  
## der Pfad soll das eigentliche siduction.iso nicht inkludieren.###</span>
'FLL_GRUB2_ISO_LOCATION="/media/disk1part4"'

# array for defining ISO prefices --> siduction-*.iso
# default: "siduction- fullstory-"
'FLL_GRUB2_ISO_PREFIX="siduction-"'

# set default language
# default: en_US
'FLL_GRUB2_LANG="en_AU"'

# override the default timezone.
# default: UTC
'FLL_GRUB2_TZ="Australia/Melbourne"' 

# kernel framebuffer resolution, see
# http://manual.siduction.org/de/cheatcodes-vga-de.htm#vga
# default: 791
#FLL_GRUB2_VGA="791"

# additional cheatcodes
# default: noeject
'FLL_GRUB2_CHEATCODE="noeject nointro"' 
~~~

Speichere die Änderungen, schließe den Editor und führe als root folgenden Befehl in einem Terminal aus:

~~~sh
update-grub
~~~

Die Grub2-Konfigurationsdatei grub.cfg wird damit aktualisiert und erkennt die im angegebenen Verzeichnis platzierten ISOs. Diese stehen beim nächsten Neustart zur Wahl.

## Allgemeine Informationen zu fromiso und persist

### Firmware

Dies gilt für alle Anwendungen mit Persist, außer Installationen auf RAW-Geräte. Für RAW-Geräte siehe [Installation einer siduction-ISO auf einen USB-Stick, eine SSD-Karte, einem SHDC-Gerät unter Verwendung einer anderen Linuxdistribution, MS Windows oder Mac OS X](hd-ins-opts-oos-de.htm#raw-usb) 

Um Firmware auf einem Live-System in dessen `/lib/firmware`  zu speichern, muss sie in einem Verzeichnis `/siduction/firmware`  auf dem Stick abgelegt werden. Dies kann beim Booten aktiviert werden, indem `Yes`  vom grafischen `Driver menu`  gewählt wird oder indem in der Kernelbefehlszeile `firmware`  angefügt wird. `firmware=/lib/firmware`  lädt die auf dem Computer gefundene Firmware ab der ersten Installation. Um dieses Verhalten als Grundeinstellung zu wählen, können die Boot-Konfigurationsdateien angepasst werden, so z.B. die Datei `/boot/isolinux/syslinux.cfg` .

Sowohl persist als auch firmware kann Dateien an verschiedenen Orten verwenden. Wenn zum Beispiel die Datei für Persistenz sich im Rootverzeichnis des Sticks gespeichert ist und den Namen `persist.img`  trägt, wird der Kernel-Parameter `persist=/persist.img`  verwendet. Falls Firmware sich in einem Verzeichnis fw befindet, wird der Kernelparameter `firmware=/fw`  gesetzt.

### fromiso und persist auf einer Festplatte

Ein persistentes Livesystem kann auf einer beschreibbaren Festplatte verwendet werden, wenn ein fromiso-System mit einem persist-Bootparmeter verbunden wird.  
Um persist zu nutzen, muss eine spezielle Datei verwendet werden. Der Boot-Parameter sieht dann so aus:

~~~sh
persist=/siduction/siduction-rw
~~~

siduction verwendet dmsetup, um "copy on write" auf der ISO zu ermöglichen, womit neue Dateien bzw. Verzeichnisse geschrieben werden können. Wenn vorhandene Verzeichnisse oder Dateien aktualisiert werden, wird die neue Version temporär im RAM gespeichert. Der Boot-Parameter `persist`  speichert neue Dateien in der gleichen Partition, in der sich auch das ISO-Abbild befindet.

`fromiso`  ergibt ein Live-System, welches alle automatischen Routinen einer siduction-Live-ISO bietet. Dies hat den Vorteil, dass zum Beispiel die Hardware automatisch konfiguriert wird. Gleichzeitig bedeutet es, dass bei jedem Systemstart die gleichen Dateien erstellt werden, wenn nicht zusätzliche Parameter verwendet werden

`persist`  zusätzlich mit siduction spezifischen Bootparametern wie noxorgconf oder nonetwork bedeutet, dass die automatische Erstellung von Dateien während des Bootvorgangs unterbunden wird. Siehe auch [Bootoptionen](http://manual.siduction.org/de/cheatcodes-de.htm#cheatcodes)

Mit Ausnahme einer Kernelaktualisierung können unter Verwendung von persist auch Programmpakete mit apt installiert werden. Alle neuen Anwendungen und Dateien stehen mit dem nächsten Systemstart zur Verfügung. Einige Programmpakete benötigen die Freischaltung von contrib und non-free in der APT-Quellenliste, siehe [Nicht freie Quellen für APT freischalten](nf-firm-de.htm#non-free-firmware)  

### fromiso und persist auf einem bootfähigen USB-Stick/SSD-Cards

Die vielleicht ideale Verwendung von persist ist mit install-usb-gui, womit ein eigener bootfähiger USB-Stick mit eigenen Daten und selbst gewählter Software erstellt werden kann. Die persönlichen Dateien werden auf dem USB-Gerät in einem Unterverzeichnis gespeichert.

**persist**  auf einem FAT-Dateisystem (üblich für DOS/Windows9x und Standard auf Flash-Drives) bedarf der Erstellung einer großen Datei, welche als Loop-Gerät eingebunden wird. Diese Datei muss formatiert werden.

~~~note
Anmerkung: 
 Für USB-Sticks/SSD-Cards sind ext4 und vfat die empfohlenen Dateisysteme. Sie bieten vermutlich die beste plattformübergreifende Kompatibilität zur Datenrettung im Notfall.  Bei Verwendung von ext4 muss auf "MS Windows&#8482;"-Installationen für den Datenaustausch ein ext4 Treiber verfügbar sein. Ein Wiederbeschreiben von Flash-Speichergeräten hängt von den technischen Spezifikationen des USB-Sticks SSD-Cards ab.` 
~~~

### vfat +ext4 Dateiystem

Wenn vfat oder ext4 verwendet wird, wird der persist-Modus mittels einer Datei ermöglicht, die maximal 2GB groß sein kann, aber mindestens 100MB groß sein soll (weniger macht keinen Sinn). Diese Datei sollte `siduction-rw`  benannt werden. 

### Beispiel, wie man persist nach erfolgter Installation setzt

Wenn man nicht sicher ist, wie der Mount-Punkt heißt, wird der USB-Stick eingebunden und der Befehl `ls -lh /media`  ausgeführt, um eine Liste mit allen Mount-Punkten des Systems zu erhalten. Man schaut nach einem Eintrag wie `drwxr-xr-x 6 username root 4.0K Jan 1 1970 disk` . Falls die Ausgabe anders lautet als *`/media/disk`*  in unserem Beispiel, muss die Zeile unseres Beispiels durch den wirklichen Mount-Punkt ersetzt werden (z.B. "/media/disk-1"):

Um das Beispiel fortzusetzen: der Befehl `df -h`  schafft Klarheit:

~~~sh
/dev/sdc2 3.4G 4.0K 3.4G 1% /media/disk
/dev/sdc1 4.1G 1.1G 2.8G 28% /media/disk-1
~~~

Daher:

~~~sh
disk="/media/disk-1"
~~~

Größe der persistenten Partition festlegen:

~~~sh
size=1024
~~~

Erstellen eines Verzeichnisses:

~~~sh
mkdir $disk-1/siduction
~~~

Erstellen der persistenten Partition:

~~~sh
dd if=/dev/zero of=$disk-1/siduction/siduction-rw bs=1M count=$size && echo 'y' | LANG=C /sbin/mkfs.ext4 $disk-1/siduction/siduction-rw && tune2fs -c 0 "$disk-1/siduction/siduction-rw"
~~~

 **`NTFS-Partitionen [das gebräuchliche Dateisystem von Windows-Installationen (NT/2000/XP) können NICHT für Persistenz verwendet werden.`**

## Installation von siduction auf USB-Stick/SSD-Karte

siduction auf USB-Stick/SSD-Karte zu installieren ist genauso einfach wie eine normale Festplatteninstallation. Hier eine einfache Anleitung.

### Voraussetzungen:

Jeder PC mit USB 2.0 / USB 3.0 und Bootfähigkeit von USB/SSD.

Eine Abbilddatei siduction.iso.

### 3 Arten der Installation nach USB/SSD

+ 1 [fromiso](hd-install-opts-de.htm#usb-from1) : diese Methode ist ausschießlich für siduction (siduction-on-a-stick)
+ 2 [Vollständig](hd-install-opts-de.htm#usb-hdd) : die vollständige Installation nach USB/SSD verhält sich wie eine Festplatteninstallation und wird mittels des normalen Installationsprogramms durchgeführt.
+ 3 [RAW device](hd-ins-opts-oos-de.htm#raw-usb) : ideal, wenn eine andere Linux-Distribution, MS Windows oder Mac OS X Ausgangssystem ist und man siduction auf einen USB-Stick installieren möchte (siduction-on-a-stick). Bitte beachte die Besonderheiten!

### USB/SSD fromiso-Installation, siduction-on-a-stick

~~~text
Anmerkung:
 Der USB-Speicher wird mit ext4 oder fat32 (mindestens 2GB) vorformatiert. Er soll nur eine als bootfähig markierte Partition haben (einige BIOS verlangen das Bootfähig-Flag).
~~~

Falls ein Formatierungs-Tool mit einer graphischen Oberfläche wie gparted verwendet wird, lösche bitte eine existierende Partition und erstelle eine neue, bevor Du diese formatierst.

### USB-fromiso von einer siduction-Festplatteninstallation:

`fromiso USB` wird mittels `Menü>System>install-siduction-to-usb` durchgeführt.

### USB-fromiso von einer siduction-*.iso:

Auf einer LIVE-CD kann man auch auf das `siduction-Installer-Icon`  klicken und `Install to USB`  wählen.

### Optionen:

Man hat die Möglichkeit Sprache, Zeitzone und weitere Optionen zu wählen, und mittels eines Häkchens kann man entscheiden, ob man persist aktivieren möchte oder nicht.

Schließlich hat man ein bootfähiges USB/SSD. Falls "persist" nicht gewählt wurde, kann es nachträglich aktiviert werden, indem man `persist`  der Befehlszeile des Grub-Startbildschirms anfügt. (Dies funktioniert vermutlich nicht, wenn vfat das Dateisystem ist. In diesem Falle muss die Installation wiederholt werden, wenn die persist-Option vergessen wurde.)

### Es geht auch in einem Terminal:

~~~sh
fll-iso2usb -D /dev/sdb -f none --iso /home/siduction/siduction.iso -p -- lang=no tz=Pacific/Auckland
~~~

Dieser Befehl installiert das ISO auf das USB-Speichergerät `sdb` mit persist, mit norwegischer Sprache und Lokalisation sowie der Zeitzone Pacific/Auckland (NZL) in der Grub-Befehlszeile.

Die Konfiguration von X (Grafikkarte, Tastatur, Maus) bzw. die Netzwerkkarten wurden nicht gespeichert, womit dieses Vorgehen ideal ist, falls diese Installation auf mehreren Computern verwendet werden soll.

Weitere Informationen auch zu individuellen Anpassungsmöglichkeiten siehe:

~~~sh
$ man fll-iso2usb
~~~

### Vollständige Installation nach USB/SSD (verhält sich wie eine Festplatteninstallation)

Empfohlene Mindestgröße:  
siduction LXDE: 2,5GB PLUS Platz für Daten  
siduction KDE, XFCE: 4GB PLUS Platz für Daten

~~~note
Der USB-Speicher wird mit ext4 vorformatiert und wie bei einer Standardinstallation partitioniert.
~~~

Die Installation wird von der Live-ISO gestartet, man wählt die Partition auf dem USB/SSD-Speicher, wohin siduction installiert werden soll (zum Beispiel `sdbX` ) und folgt den Anweisungen des Installers. Weitere Infos unter [Installation auf die Festplatte](hd-install-de.htm#Installation) .

~~~note
Um von einer USB/SSD booten zu können, muss 'Boot from USB' im BIOS aktiviert sein.` 
~~~
Weiters ist zu beachten: 

+ Eine USB/SSD-Installation ist üblicherweise an den PC gebunden, auf welchem die Installation durchgeführt wurde. Falls man wünscht, die Installation auch auf anderen PCs zu nutzen, sollten keine proprietären Grafiktreiber bzw. Bootoptionen vorkonfiguriert sein. Ausnahme ist die vesa-Bootoption in grub.cfg. Für dies alles muss man nach einer erfolgreichen Installation selbst Sorge tragen.
+ Nach dem Booten mit einem USB/SSD-Speicher auf einem anderen PC muss fstab angepasst werden, um die Festplatten des PCs ansprechen zu können.
+ "fromiso" mit "persist" ist eine bessere Option, falls mehrere PCs genutzt werden sollen.

### Vollständige Installation auf eine USB-Festplatte ist gleich einer Installation auf eine Partition

Eine USB-Festplatteninstallation ist besonders für Anwender, die von Windows kommen oder andere Linux-Distributionen nutzen, attraktiv: man kann siduction auf eine USB-Festplatte installieren und muss sich nach dem Anstecken der Festplatte nicht um eine Dual-Boot-Konfiguration kümmern (Neupartitionierung, Grub-Anpassung u.a. fallen weg).

Die Installation wird von der Live-ISO (oder von einem USB/SSD-Speicher) `wie eine Standard-Installation und nicht wie eine USB-Installation`  durchgeführt. Man wählt die Partition auf der USB-Festplatte, wohin siduction installiert werden soll, zum Beispiel `sdbX` , und folgt den Anweisungen des Installationsprogramms. Grub muss auf die Partition der USB-Festplatte geschrieben werden.

Weitere Informationen unter [Installation auf eine Festplatte](hd-install-de.htm#Installation) 

**Weiters ist zu beachten:**

+ Eine USB-Festplatteninstallation ist üblicherweise an den PC gebunden, auf welchem die Installation durchgeführt wurde. Falls man wünscht, die Installation auch auf anderen PCs zu nutzen, sollten keine proprietären Grafiktreiber bzw. Bootoptionen vorkonfiguriert sein. Ausnahme ist die vesa-Bootoption in grub.cfg. Für dies alles muss man nach einer erfolgreichen Installation selbst Sorge tragen.
+ Nach dem Booten mit einer USB-Festplatte auf einem anderen PC muss fstab angepasst werden, um die Festplatten des PCs ansprechen zu können. Auch kann xorg.conf eine Netzwerkkonfiguration benötigen.

## Vollständige Installation auf einen GPT-Wechsel-Datenträger (verhält sich wie eine normale Festplatteninstallation)

 Siehe [Partitionierung einer GPT mit gdisk](part-gdisk-de.htm#gdisk-1)  und die Instruktionen von [Installationsoptionen - HD, USB, VM und Cryptroot](hd-install-de.htm) .

## Bootbare (U)EFI-Wechseldatenträger

Falls mit EFI gebootet werden soll, ohne ein optisches Medium zu brennen, wird eine VFat-Partition mit einem portablen EFI-Bootloader `/efi/boot/bootx64.efi`  benötigt. Die ISOs siduction amd64 liefern eine solche Datei aus sowie eine Grub-Konfiguration, welche diese laden kann. Um einen USB-Stick dafür vorzubereiten, muss nur der Inhalt der siduction-ISO auf das Root-Dateisystem eines mit `vfat`  formatierten USB-Sticks kopiert werden. Diese Partition muss mit Hilfe eines Partitionierungsprogramms auch als bootbar markiert werden.

Selbstverständlich ermöglicht das ausschließliche Kopieren der Dateien auf eine VFat-Partition eines USB-Sticks kein Booten in ein traditionelles BIOS-System, aber es ist ziemlich einfach, dies mithilfe von syslinux und install-mbr aktivieren. Dazu müssen (ohne dass der USB-Stick eingebunden ist) diese beiden Befehle ausgeführt werden: 

~~~sh
syslinux -i -d /boot/isolinux /dev/sdXN
install-mbr /dev/sdX
~~~

Ein so vorbereiteter USB-Stick bootet mit EFI in ein einfaches Grub2-Menü bzw. mit einem traditionellen BIOS in ein grafisches gfxboot-Menü.

Einer der Vorteile, einen USB-Stick auf diese Weise vorzubereiten - im Gegensatz zur Erstellung eines Raw-Sticks unter Verwendung von isohybrid - ist die Möglichkeit, dass die Boot-Dateien am Stick bearbeitet werden können, um die automatische Verwendung benutzerdefinierter Optionen zu ermöglichen.

Für traditionelle BIOS-Systeme können diese Dateien bearbeitet werden: `/boot/isolinux/syslinux.cfg`  bzw. `/boot/isolinux/gfxboot.cfg` . Für EFI-Systeme kann die Datei `/boot/grub/x86_64-efi/grub.cfg`  bearbeitet werden.

## Persistenz und Firmware

Siehe [Allgemeine Informationen zu fromiso und persist](hd-install-opts-de.htm#fromiso-persist) 

<div id="rev">Page last revised 2021-04-12</div>
