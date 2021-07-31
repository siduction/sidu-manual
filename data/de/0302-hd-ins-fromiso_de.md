% fromiso

## Aus ISO-Datei booten

### Überblick

Dieser Cheatcode startet aus einer ISO-Datei auf der Festplatte mit dem Dateisystem ext4. **Für normalen Gebrauch empfehlen wir das Standarddateisystem von siduction, ext4, welches von den Maintainern gut betreut ist.**
 
Der Start von einer "fromiso" Festplatten-Installationen dauert nur einen Bruchteil der Zeit, die ein Start von einer CD benötigt. 
Außerdem steht gleichzeitig das CD/DVD-Laufwerk zur Verfügung. Alternativ kann man auch VBox, KVM oder QEMU verwenden.

**Voraussetzungen**

* eine funktionierende Grub-Installation (auf Floppy, einer Festplatteninstallation oder der Live-CD)  
* eine siduction-Imagedatei, z. B. siduction.iso (Name gekürzt) und ein Linux-Dateisystem wie ext4  

### fromiso mit Grub2

siduction liefert eine grub2-Datei mit der Bezeichnung 60_fll-fromiso, um einen fromiso-Eintrag im grub2-Menü zu generieren. Die Konfigurationsdatei für fromiso ist im Paket `grub2-fll-fromiso` , mit dem Pfad `/etc/default/grub2-fll-fromiso` .

 Als erstes öffnet man einen Terminal und wird root mit:

~~~sh
su
apt-get update
apt-get install grub2-fll-fromiso
~~~

Im Anschluss öffnet man einen Editor der Wahl (kwrite, mcedit, vim ...):

~~~sh
mcedit /etc/default/grub2-fll-fromiso
~~~

In den Zeilen, die aktiv sein sollen, wird das Kommentarzeichen (**#**)  entfernt, und man ersetzt die voreingestellten Anweisungen innerhalb der doppelten Anführungszeichen (**"**) mit den eigenen Parametern. 

Beispiel: vergleiche diese geänderte grub2-fll-fromiso mit den Grundeinstellungen:

~~~sh
# Defaults for grub2-fll-fromiso update-grub helper
# sourced by grub2's update-grub
# installed at /etc/default/grub2-fll-fromiso by the maintainer scripts

#
# This is a POSIX shell fragment
#

# specify where to look for the ISO
# default: /srv/ISO
## Achtung: Dies ist der Pfad zum Verzeichnis, in dem das oder die ISO(s) liegen,  
## der Pfad soll das eigentliche siduction.iso nicht inkludieren.
FLL_GRUB2_ISO_LOCATION="/media/disk1part4"

# array for defining ISO prefices --> siduction-*.iso
# default: "siduction- fullstory-"
FLL_GRUB2_ISO_PREFIX="siduction-"

# set default language
# default: en_US
FLL_GRUB2_LANG="de_DE"

# override the default timezone.
# default: UTC
FLL_GRUB2_TZ="Europe/Berlin" 

# kernel framebuffer resolution, see
# http://manual.siduction.org/de/cheatcodes-vga-de.htm#vga
# default: 791
#FLL_GRUB2_VGA="791"

# additional cheatcodes
# default: noeject
FLL_GRUB2_CHEATCODE="noeject nointro" 
~~~

Speichere die Änderungen, schließe den Editor und führe als root folgenden Befehl in einem Terminal aus:

~~~sh
update-grub
~~~

Die Grub2-Konfigurationsdatei grub.cfg wird damit aktualisiert und erkennt die im angegebenen Verzeichnis platzierten ISOs. Diese stehen beim nächsten Neustart zur Wahl.

### toram

Eine weitere Nützliche Option beim Booten von einem Live Medium ist `toram`. Selbige ist empfehlenswert, wenn der rechner über ausreichend  
Arbeitsspeicher verfügt (4GiB oder mehr). Damit wird der komplette Inhalt des Live Mediums in den Ram kopiert. Das hat den Vorteil, dass das   
System dann sehr schnell reagiert und man kann das Medium dann auch entfernen. Das ist nützlich, wenn der Start von einem USB-Stick erfolgte,  
und man diesen USB Port anderweitig benutzen will.

<div id="rev">Zuletzt bearbeitet: 2021-07-23</div>
