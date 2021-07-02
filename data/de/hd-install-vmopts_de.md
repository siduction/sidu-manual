<div class="divider" id="vmopts"></div>

## Optionen für virtuelle Maschinen

+ [KVM für Intel VT oder AMD-V](hd-install-vmopts-de.htm#kvm) 

+ [Virtualbox](hd-install-vmopts-de.htm#vbox) 

+ [QEMU](hd-install-vmopts-de.htm#qemu) 

+ [Installation anderer Distributionen auf ein Image](hd-install-vmopts-de.htm#oos) 

`Die folgenden Beispiele verwenden siduction. Ersetze siduction gegebenenfalls mit der Distribution Deiner Wahl.` 

<div class="divider" id="oos"></div>

## Installation anderer Distributionen auf ein VM-Image

Anmerkung: Falls Du auf ein Image einer virtuellen Maschine installieren willst, benötigen die meisten Linuxdistributionen eine Zuordnung von nur 12GB. Für MS Windows in einer virtuellen Maschine werden ungefähr 30GB oder mehr benötigt. Letztlich hängt die Zuordnung der Größe jedoch von Deinen Anforderungen ab.

Die einem Image zugeordnete Größe verbraucht keinen Speicherplatz auf der Festplatte, solange keine Daten im Image gespeichert sind. Auch dann wird der Speicherplatz dynamisch verwaltet und nur soviel verwendet, wie Daten im Image gespeichert sind. Dies wird durch [https://en.wikipedia.org/wiki/Qcow](qcow2) ermöglicht.

<div class="divider" id="kvm"></div>

## Aktivierung einer virtuellen Maschine mit KVM

KVM ist eine vollständige Virtualisierungslösung für Linux auf einer x86-Hardware mit Virtualisierungserweiterungen (Intel VT oder AMD-V).

### Voraussetzungen

Um zu ermitteln, ob die Hardware KVM unterstützt, muss festgestellt werden, ob diese im BIOS aktiviert ist (in manchen Fällen kann es auf einem Intel-VT- oder AMD-V-System nicht ersichtlich sein, wo die Option zur Aktivierung ist, in diesem Falle geht man davon aus, dass KVM aktiv ist). In der Konsole prüft man mit diesem Befehl:

~~~
cat /proc/cpuinfo | egrep --color=always 'vmx|svm'
~~~

Falls `svm`  oder `vmx`  im Feld der CPU-Flags erscheint, unterstützt das System KVM. (Falls nicht, sollten die Einstellungen im BIOS nochmal überprüft werden, oder man sucht im Internet nach den Einstellungsoptionen des jeweiligen BIOS).

Falls das BIOS KVM nicht unterstützt, empfehlen sich [Virtualbox](hd-install-vmopts-de.htm#vbox) oder [QEMU](hd-install-vmopts-de.htm#qemu) 

Um KVM zu installieren und starten, muss sichergestellt sein, dass keine Virtualbox-Module geladen sind (--purge ist die beste Option). Abhängig vom Chipset werden folgende Befehle durchgeführt:

Für `vmx` :

~~~
apt install qemu-kvm qemu-utils
modprobe kvm-intel
~~~

Für `svm` :

~~~
apt install qemu-kvm qemu-utils
modprobe kvm-amd
~~~

Beim Systemstart sorgen die qemu-kvm initscripts dafür, dass die nötigen Module geladen werden.

### KVM zum Booten einer siduction-*.iso

**`Als User:`** 

~~~
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom <siduction.iso>


#### Installieren einer siduction-*.iso auf ein KVM-Image

Zuerst muss ein Festplatten-Image erstellt werden (dieses Image ist sehr klein und wächst nach Bedarf nach qcow2-Kompressionsverhältnissen):

~~~
$ qemu-img create -f qcow2 siduction-2010-*-.img 12G
~~~

Das siduction-*.iso wird mit folgenden Parametern gebootet, um KVM die Möglichkeit zur Erkennung eines QEMU-Festplattenimages zu geben:

~~~
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom </path/to/siduction-*.iso> -boot d </path/to/siduction-VM.img>
~~~

Wenn die CR-ROM hochgefahren ist, klickt man auf den siduction-Installer, um das Installationsprogramm zu aktivieren (oder man verwendet das Menü), klickt auf den Reiter "Partitioning" und startet die bevorzugte Partitionierungsanwendung. Anleitungen finden sich im Kapitel [Partitionierung der Festplatte - traditionell, GPT und LVM](part-gparted-de.htm) . Eine Swap-Partition wird benötigt, wenn nicht genug RAM zur Verfügung steht. Die Formatierung benötigt einige Zeit.

![gparted kvm hard disk naming](../images-common/images-vm/kvm-gparted02.png "gparted kvm hard disk naming") 

---

Nun steht eine VM zur Verfügung:

~~~
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -drive if=virtio,boot=on,file=<path/to/siduction-VM.img>
~~~

Einige Gastsysteme unterstützen virtio nicht. In diesem Fall müssen beim Start von KVM andere Optionen gesetzt werden. Zum Beispiel:

~~~
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img> -cdrom your_other.iso -boot d
~~~

oder

~~~
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img>
~~~

Weitere Informationen: [KVM-Dokumentation](http://www.linux-kvm.org/page/Main_Page)  (Englisch).

#### Verwaltung einer KVM-Installation

~~~
apt install aqemu
~~~

Beim Benutzen des (englischsprachigen) AQEMU wird im Reiter "General" bei "Emulator Type" im Drop-Down-Menü "KVM mode" gewählt. Für AQEMU gibt es praktisch keine Dokumentation, daher muss man sich selbst in der selbsterklärenden Benutzerführung zurechtfinden. Ein guter Startpunkt dabei sind der Menüpunkt "VM" und der Reiter "General".

<div class="divider" id="vbox"></div>

## Booten und Installierung in eine virtuelle Maschine mit VirtualBox

Die Schritte:

+ 1. Erstellung eines Festplattenabbilds für VirtualBox
+ 2. Booten der ISO mit VirtualBox
+ 3. Installation auf dem Abbild

### Voraussetzungen

`1 GB RAM ist empfohlen` , idealerweise 512 MB für das Gastsystem und 512 MB für das Hostsystem. Bei weniger RAM ist mit Verlust an Performanz zu rechnen.

`Freier Festplattenplatz:`  VirtualBox selbst ist sehr schlank (eine typische Installation benötigt etwa 30 MB Speicherplatz), benötigt aber sehr große Dateien auf der Festplatte, auf der das Gastsystem gespeichert ist. Für eine Installation von MS Windows XP (TM) wird eine Datei benötigt, die leicht auf etliche Gigabyte anwachsen kann. Um siduction in VirtualBox verwenden zu können, sollte man ein fünf Gigabyte großes Image plus Platz für eine swap-Partition bereitstellen.

### Installation:

~~~
apt update && apt install virtualbox virtualbox-dkms
~~~

oder 

~~~
apt update && apt install virtualbox-qt virtualbox-dkms
~~~

für Installationen mit KDE Plasma oder LXQt

Der Computer muss nun neu gestartet werden.

### Installation von siduction auf der virtuellen Maschine:

Am besten werden die Assistenten von VirtualBox benutzt, um eine virtuelle Maschine für siduction zu erzeugen. Danach wird den Anweisungen für eine reguläre Installation von siduction gefolgt.

VirtualBox hat auf seiner Homepage eine umfassende englischsprachige [Bedienungsanleitung](http://www.virtualbox.org/), die man als PDF herunterladen kann.  

<div class="divider" id="qemu"></div>

## Eine QEMU Virtual Machine booten und installieren

+ 1. Erstellen eines Festplattenabbilds (iso) für QEMU
+ 2. Booten der iso mit QEMU
+ 3. Installation auf dem Image

Ein grafisches Hilfsprogramm auf QT-Basis ist zur Unterstützung einer QEMU-Konfiguration installierbar:

~~~
apt install qtemu
~~~

### Erstellen eines Festplattenimages (iso)

Um qemu laufen lassen zu können, braucht man ein Festplattenabbild. Das ist eine Datei, welche den Inhalt einer Partition oder Festplatte trägt.

Man verwendet den Befehl:

~~~
qemu-img create -f qcow siduction.qcow 5G
~~~

Damit erstellt man eine Abbilddatei mit dem Namen "siduction.qcow". Der Parameter "3G" spezifiziert die Größe der Platte, in diesem Fall 3 GB. Das Suffix M wird für Megabyte verwendet (zum Beispiel "256M"). Man muss sich über die Größe jedoch keine zu großen Gedanken machen - das Format qcow komprimiert das Abbild, sodass der unbenutzte Platz sich nicht auf die Größe der Datei aufaddiert.

### Installation des Betriebssystems

Jetzt wird zum ersten Mal der Emulator gestartet. Eines muss dabei beachtet werden: wenn man innerhalb des qemu-Fensters mit der Maus klickt, wird der Mauszeiger "gefangen". Um ihn wieder frei zu geben, drückt man Ctrl+Alt.

Falls man eine bootfähige Diskette benötigt, wird Qemu so gestartet:

~~~
qemu -floppy siduction.iso -net nic -net user -m 512 -boot d siduction.qcow
~~~

Wenn die CD-ROM bootfähig ist, wird Qemu so gestartet:

~~~
qemu -cdrom siduction.iso -net nic -net user -m 512 -boot d siduction.qcow
~~~

Nun kann siduction wie auf eine reale Festplatte installiert werden.

### Verwendung des Systems

Um das System zu starten, gibt man ein:

~~~
qemu [hd_image]
~~~

Eine gute Idee ist die Verwendung von sog. "überlagerten Abbildern" (overlay images). Auf diese Weise muss ein Abbild nur einmal angelegt werden und Qemu speichert Änderungen außerhalb dieses Abbilds. Das System ist so stabiler, da es sehr einfach ist, auf einen früheren Installationsstand zurückzugreifen.

Um ein "überlagertes Abbild" (overlay image) zu erstellen, gibt man ein:

~~~
qemu-img create -b [base_image] -f qcow [overlay_image]
~~~

Das Festplattenabbild ersetzt nun das Basis-Abbild (base_image), in unserem Fall siduction.qcow. Danach kann qemu gestartet werden:

~~~
qemu [overlay_image]
~~~

Das originale Abbild bleibt unberührt. Es muss aber beachtet werden, dass das Basis-Abbild weder umbenannt noch verschoben werden darf, da das Overlay den genauen, absoluten Pfad des Basis-Abbilds benötigt.

### Wie man jede echte Partition als primäre Partition eines Festplattenabbilds benutzen kann

Manchmal möchte man eine Systempartition aus qemu heraus benutzen (man möchte zum Beispiel sowohl die echte Installation wie auch die virtuelle qemu-Installation mit einer gegebenen Partition als root starten). Dies erfolgt durch ein Software-RAID im Linearmodus (dazu braucht man den linear.ko Kernel-Treiber) und ein Loopback-Gerät: der Trick dabei ist, dynamisch einen Master Boot Record (MBR) an den Beginn der realen Partition zu stellen, welche in das Raw-Disk-Image von qemu eingebettet werden soll.

Angenommen, man hat eine einfache, nicht eingebundene Partition /dev/sdaN mit einem Dateisystem, welche Teil eines qemu-Festplattenabbilds werden soll. Als erstes erstellt man eine kleine Datei, welche den MBR beinhalten soll:

~~~
dd if=/dev/zero of=/path/to/mbr count=32
~~~

Hiermit wird eine 16 KB (32 * 512 bytes) große Datei erstellt. Es ist wichtig, diese Datei nicht zu klein zu veranschlagen (auch wenn der MBR nur einen einzelnen 512 Bytes großen Block benötigt), da die Chunk-Größe des Software-RAID-Geräts umso kleiner sein muss, je kleiner jene Datei ist, was wiederum einen Einfluss auf die Leistung haben wird. Danach kann ein Loopback-Gerät zum MBR-File aufgesetzt werden:

~~~
losetup -f /path/to/mbr
~~~

Gehen wir davon aus, dass das Gerät /dev/loop0 heißt, da noch kein weiteres Loopback existiert. Nächster Schritt ist das Erstellen eines zusammengeführten Abbilds von MBR + /dev/sdaN unter Benutzung eines Software-RAIDS:

~~~
modprobe linear
mdadm --build --verbose /dev/md0 --chunk=16 --level=linear --raid-devices=2 /dev/loop0 /dev/sdaN
~~~

Das daraus resultierende /dev/md0 wird als qemu-Raw-Diskimage benutzt (das Setzen der Berechtigungen nicht vergessen, damit der Emulator darauf zugreifen kann). Der letzte (und etwas heikle) Schritt ist die Erstellung der Festplattenkonfiguration (Plattengeometrie und Partitionstabellen), sodass der Startpunkt der primären Partition im MBR mit jenem von /dev/sdaN innerhalb von /dev/md0 übereinstimmt (ein Offset von genau 16 * 512 = 16384 Bytes in diesem Beispiel). Dazu wird fdisk auf der Host-Maschine benutzt, nicht auf dem Emulator: in den Grundeinstellungen resultiert die Raw-Disk-Erkennung von qemu oft in Offsets, die nicht auf Kilobyte gerundet werden können (wie 31.5 KB im vorangegangenen Abschnitt), was wiederum vom Code des Software-RAIDs nicht verstanden werden kann. Daher gibt man auf der Host-Maschine ein:

~~~
fdisk /dev/md0
~~~

Dort erstellt man eine primäre Partition entsprechend /dev/sdaN und spielt mit dem Befehl 's' (Sector) im Menü 'x' (Expert), bis der erste Zylinder (wo die erste Partition beginnt) genau zur Größe des MBR passt. Schließlich wird mit 'w' (write) das Ergebnis in den File geschrieben: damit ist die Arbeit abgeschlossen. Jetzt ist eine Partition vorhanden, welche sowohl direkt von der Host-Maschine eingebunden werden kann als auch vom qemu-Festplattenimage:

~~~
qemu -hdc /dev/md0 [...]
~~~

Natürlich kann gefahrlos jeder Bootloader auf das Festplattenabbild mit qemu geschrieben werden, vorausgesetzt, die originale Partition /boot/sdaN enthält die dafür notwendigen Anwendungen.

###<!-- Das QEMU Beschleunigungs-Modul (Accelerator Module)

Die Entwickler von qemu haben ein optionales Kernelmodul erstellt, um qemu beinahe auf natives Niveau beschleunigen zu können. Dieses Modul sollte mit dieser Option geladen werden:

~~~
major=0
~~~

Damit wird die Einrichtung des benötigten Geräts /dev/kqemu automatisiert. Weitere Befehle sind:

~~~
echo "options kqemu major=0" >> /etc/modules
~~~

Dieser erweitert die Datei /etc/modules, um sicherzustellen, dass die Moduloption bei jedem Laden des Moduls aktiviert wird.

~~~
qemu [...] -kernel-kqemu
~~~

Damit wird die volle Virtualisierung ermöglicht und die Geschwindigkeit beträchtlich erhöht.

### Aktivierung von QEMU:

~~~
qemu -cdrom /tmp/pkg/siduction-debug.iso -net nic -net user -m 512
~~~

[Die offizielle englischsprachige Dokumentation des QEMU-Projekts](http://www.nongnu.org/qemu/user-doc.html)  
[Einige Abschnitte für QEMU wurden für das siduction-Handbuch unter der GNU Free Documentation License 1.2 verwendet und für das siduction-Handbuch angepasst. Die Übersetzung ins Deutsche erfolgte durch das siduction-Team.](http://wiki.archlinux.org/index.php/Qemu)  

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
