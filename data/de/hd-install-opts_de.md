% fromiso

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC3**

Änderungen 2021-04
+ für Pandoc vorbereitet

ENDE INFOBEREICH FÜR DIE AUTOREN

# Installation

## fromiso

### Booten "fromiso" - Überblick

 **Für normalen Gebrauch empfehlen wir das Standarddateisystem von siduction, ext4, welches von den Maintainern gut betreut ist.**
 
Dieser Cheatcode startet aus einer ISO-Datei auf der Festplatte (ext4). Das ist viel schneller als von einer CD (Festplatten-Installationen "fromiso" dauern nur einen Bruchteil der Zeit).

Dies ist natürlich viel schneller als von einem CD/DVD-Laufwerk, und das Laufwerk steht gleichzeitig zur Verfügung. Alternativ kann man auch VBox, KVM oder QEMU verwenden.

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



<div id="rev">Zuletzt bearbeitet: 2021-07-21</div>
