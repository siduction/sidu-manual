% GRUB

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2021-05
+ Überarbeitet
+ GRUB legacy entfernt

Rückstufung 2021-07
+ Viele Formatfehler
+ suxterm
+ kaputte Links
+ Überlange Überschriften
+ Überschriften mit verbotenen Zeichen
+ HTML-Tag "span class="highlight-2"

ENDE   INFOBEREICH FÜR DIE AUTOREN

## Bootmanager GRUB 2

**Zusammenfassung der wesentlichen Unterschiede zwischen GRUB 1 (jetzt GRUB-legacy) und GRUB 2:**

+ Die Syntax der Konfiguration von GRUB 1 und GRUB 2 ist nicht kompatibel. 

+ Die Datei menu.lst existiert in GRUB 2 nicht mehr.

+ GRUB 2 erstellt aus den Konfigurations-Skripten in */etc/grub.d* und Einstellungen in */etc/default/grub* die Datei */boot/grub/grub.cfg*.

+ Die Datei */boot/grub/grub.cfg*  steuert auch den GRUB-Bildschirm.

+ Die Bezeichnung der Partitionen ändert sich ebenfalls. Die Nummerierung der Partitionen beginnt mit 1, nicht mit 0 (Laufwerksnummerierungen beginnen weiterhin mit 0):

  | Partition | GRUB 1 | GRUB 2 |
  | --- | -- | -- |
  | /dev/sda1 | (hd0,0) | (hd0,1) |
  | /dev/sda2 | (hd0,1) | (hd0,2) |
  | /dev/sda3 | (hd0,2) | (hd0,3) |
  | /dev/sdb1 | (hd1,0) | (hd1,1) |
  | /dev/sdb2 | (hd1,1) | (hd1,2) |
  | /dev/sdb3 | (hd1,2) | (hd1,3) |

### Konfiguration von GRUB 2

Die Datei **/boot/grub/grub.cfg** wird bei der Systeminstallation und bei Kernelaktualisierungen automatisch erstellt.  
Man kann die Datei auch manuell mit root-Rechten in einem Terminal erzeugen. Der Befehl lautet:

~~~
grub-mkconfig -o /boot/grub/grub.cfg
~~~

Ohne Option erfolgt die Ausgabe in das Terminal, sodass wir die Datei prüfen können.  
Die kurze Variante des obigen Befehls lautet:

~~~
update-grub
~~~

Die Datei **/etc/default/grub** enthält variable Einstellungen für GRUB 2, zum Beispiel Timeout, Basiseinstellungen des Menüs, Kernel-Parameter, graphische Oberfläche u.a. Die Skripte in **/etc/grub.d** testen die Systemumgebung und erstellen die Zieldatei *grub.cfg*. An diesen beiden Stellen sind bei Bedarf die Änderungen in der Konfiguration vorzunehmen.  
Das Debianpaket von GRUB 2 ist so gestaltet, dass eine manuelle Änderung selten erforderlich ist.  
Der os-prober sollte 90% der Fälle korrekt lösen:

~~~
00_header:
05_debian_theme: Setzt Hintergrund, Textfarben, Grafikthema
10_hurd: Sucht einen Hurd-Kernel
10_linux: Sucht einen Linux-Kernel auf Grundlage des Befehls lsb_release
20_memtest86+: Falls die Datei /boot/memtest86+.bin existiert, wird sie ins Boot-Menü integriert
30_os-prober: Sucht in allen Partitionen nach Betriebssystemen (Linux und andere) und integriert sie in das Boot-Menü
40_custom: Eine Vorlage, um benutzerdefinierte Menü-Einträge für weitere Betriebssysteme anzulegen
60_fll-fromiso: Eine Vorlage, um benutzerdefinierte Menü-Einträge für fromiso auf eine/n USB-Stick/SSD-Karte anzulegen
~~~

60_fll-fromiso darf nicht manuell geändert werden. Für Anpassungen steht /etc/default/GRUB 2-fll-fromiso zur Verfügung
Weitere Informationen unter [fromiso' mit GRUB 2](0302-hd-ins-fromiso_de.md#fromiso-mit-grub2).

> Niemals die Datei grub.cfg manuell ändern!

Beim nächsten Update überschreibt GRUB die Datei mit Werten aus den zuvor genannten Quellen. Daher sind alle Änderungen in den Skriptdateien im Ordner */etc/grub.d* und in der Datei */etc/default/grub* durchzuführen. Nach Änderungen der Konfiguration ist die Datei *grub.cfg*, wie oben beschrieben, manuell zu erzeugen.

### Eingabe von GRUB 2 Bootoptionen

Falls temporäre Änderungen bei den Boot-Optionen eines in GRUB 2 gelisteten Kernels nötig sind, kann man die Kerneloptionen bearbeiten, indem die Taste **`e`**  gedrückt wird. Mit den Pfeiltasten geht man zu dem Kernel, der bearbeitet werden soll. Noch im Bearbeitungsmodus wird mit `Ctrl+x`  der Computer mit den neuen Optionen gestartet.

Ein Beispiel:  
Um direkt in den Runlevel 3 (Multiuser ohne graphische Oberfläche) zu starten, wird eine *3* an das Ende der Zeile *linux /boot/vmlinuz...* gesetzt.

### Dualboot und Multiboot mit GRUB 2

GRUB 2 besitzt eine modulare Konfiguration und erlaubt daher einen einfachen Befehl, um neu installierte Betriebssysteme zu finden und automatisch in die Datei *grub.cfg* zu integrieren. Der einfache Befehl lautet:

~~~
update-grub
~~~

Sollte ein benutzerdefinierter Eintrag in *grub.cfg* erwünscht sein, oder falls 30\_os-prober nicht die benötigten Chainload-Einträge durchführt, können Ergänzungen mit Hilfe eines Texteditors in der Datei */etc/grub.d/40_custom* durchgeführt werden.

Beispiele für eine Adaptierung der Datei 40_custom:

~~~
menuentry "second mbr"{
set root=(hd1)
chainloader +1
}
~~~

~~~
menuentry "second partition"{
set root=(hd0,2)
chainloader +1
}
~~~

Nach Abspeicherung der Änderungen müssen diese GRUB übergeben werden:

~~~
update-grub
~~~

Sollte die Fehlermeldung auftreten, dass GRUB auf einem Laufwerk nicht erkannt wird, muss die devicemap neu erstellt werden.

Stelle bei der Installation eines weiteren Betriebssystems sicher, dass GRUB nicht in den MBR, sondern in die Partition des neuen Betriebssystems geschrieben wird:

~~~
grub-mkdevicemap --no-floppy
update-grub
~~~

Warnhinweise können ignoriert werden.

Bei einem Fehler überschreibt die Aktualisierung vermutlich den MBR. Wie dies repariert wird, findest Du in [Wiederherstellung des MBR](sys-admin-grub2_de.md#Wiederherstellung-des-MBR) .

### GRUB 2 neu in den MBR schreiben

~~~
/usr/sbin/grub-install --recheck --no-floppy /dev/sda
~~~

Es kann sein, dass dieser Befehl mehrfach ausgeführt werden muss, bis er "überzeugt" ist, dass dies wirklich durchgeführt werden soll.

### MBR fehlerhaft

So kann GRUB 2 bei einem von Windows überschriebenen oder korrumpierten MBR wiederherstellt werden.

**ANMERKUNG:**  
Zur Wiederherstellung von GRUB 2 benötigt man ein siduction.iso.

[Alternativ kann ein chroot mit jeder live.iso verwendet werden](sys-admin-grub2_de.htm#chroot) .

Um GRUB 2 neu zu schreiben oder wiederherzustellen, muss in eine *siduction.iso* gestartet werden:

1. Um die Partitionen ([h,s]d[a..]X) zu identifizieren und bestätigen, muss man root (#) werden:

   ~~~
   $ su
   ~~~

2. Als root wird Folgendes eingegeben:  
   ~~~
   fdisk -l
   cat /etc/fstab
   ~~~

   Auf diese Weise erhält man die korrekten Benennungen. 

3. Wenn die korrekte Partitionsbezeichnung gefunden ist, wird ein Einhängepunkt erstellt:  
   
   ~~~
   mkdir -p /media/[sdx,diskx]
   ~~~

4. Danach wird die Partition eingebunden:  

   ~~~
   mount /dev/xdxx /media/sdx
   ~~~

5. Jetzt kann GRUB in den MBR der ersten Festplatte geschrieben werden:  

   ~~~
   /usr/sbin/GRUB-install --recheck --no-floppy --root-directory=/media/sdx /dev/sda
   ~~~

### Wiederherstellung des MBR

Um GRUB wiederherzustellen, falls er im MBR überschrieben oder korrumpiert wurde, muss eine `chroot` -Umgebung aufgesetzt werden. 

**Anmerkung:**  
Es kann jede live.iso verwendet werden, da die Chroot-Umgebung die Festplatteninstallation anspricht, sodass GRUB  wiederhergestellt werden kann!

Man bootet in eine Deinem System entsprechende siduction.iso (32 oder 64 bit CD, DVD, USB-Stick oder SSD-Karte) und öffnet eine Konsole. Man tippt *su* und drückt die Eingabetaste, um root-Rechte zu erhalten.

Mit *fdisk -l oder blkid* stellt man sicher, welche Partition die Boot-Partition ist, und erhält die korrekten Bezeichnungen (falls eine graphische Oberfläche gewünscht ist, verwendet man *Gparted*):

~~~
blkid
~~~

Jetzt überprüft man, ob die Einträge in der Datei fstab mit der Ausgabe von blkid identisch sind:

~~~
cat /etc/fstab
~~~

Hier wird angenommen, dass das root-Dateisystem sich auf */dev/sda2*  befindet:

~~~
mkdir /mnt/siduction-chroot
mount /dev/sda2 /mnt/siduction-chroot
~~~

Als nächstes müssen /proc, /run, /dev und /sys wie folgt eingebunden werden:

~~~
mount --bind /proc /mnt/siduction-chroot/proc
mount --bind /run /mnt/siduction-chroot/run
mount --bind /sys /mnt/siduction-chroot/sys
mount --bind /dev /mnt/siduction-chroot/dev
mount --bind /dev/pts /mnt/siduction-chroot/dev/pts
~~~

Wenn in eine EFI-Systempartition gebootet wird, muss diese auch eingebunden werden. In diesem Beispiel ist sie /dev/sda1:

~~~
mount /dev/sda1 /mnt/siduction-chroot/boot/efi
~~~

Die chroot-Umgebung ist nun aufgesetzt und es kann auf diese Weise darauf zugegriffen werden:

~~~
chroot /mnt/siduction-chroot /bin/bash
~~~

Es kann nun auf den lokalen Cache von apt zugegriffen werden bzw. in Dateien, die geändert werden müssen, geschrieben werden. Das Verhalten entspricht demjenigen, als ob Du im zu reparierenden System selbst arbeiten würdest. In folgendem Beispiel wird GRUB neu in den MBR geschrieben.

**Wiederherstellung von GRUB**

~~~
apt-get install --reinstall grub-pc
~~~

Um sicherzustellen, dass GRUB auf dem richtigen Gerät bzw. der richtigen Partition installiert wurde, wird dieser Konfigurationsbefehl ausgeführt:

~~~
dpkg-reconfigure grub-pc
~~~

**Wiederherstellung von GRUB 2 EFI** 

~~~
apt-get install reinstall grub-efi-amd64
~~~

Folge den Anweisungen des Installationsprogramms.

Mit diesem Befehl wird die chroot-Umgebung wieder frei gegeben:

~~~
Ctrl+d
~~~

Starte Deinen PC neu.

<div id="rev">Seite zuletzt aktualisiert 2021-07-25</div>
