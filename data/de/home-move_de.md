ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2020-05:
+ Inhalt vollständig überarbeitet
+ Korrektur und Prüfung aller Links.

ENDE   INFOBEREICH FÜR DIE AUTOREN

<div class="divider" id="home-bu"></div>

## Das Verzeichnis /home verschieben

<warning>Wichtige Information</warning>
<warning>
Ein existierendes `/home` soll nicht mit einer anderen Distribution verwendet oder geteilt werden, da es bei den Konfigurationsdateien zu Konflikten kommen kann/wird.
</warning>

Sofern Daten gemeinsam für parallele Installationen bereit stehen sollen, ist es ratsam eine eigene Partition zu erstellen und diese z. B. unter `/Daten` einzuhängen.

### Vorbereitungen

An Hand eines realistischen Beispiels zeigen wir die notwendigen Schritte auf.  
Die Ausgangslage:

* Die alte, mittlerweile zu kleine, Festplatte hat drei Partitionen (`/boot/efi`, `/`, `swap`).
* Eine zusätzliche eingebaute Festplatte hat vier Partitionen mit ext4-Dateisystem.  
  Davon benutzen wir die Partitionen `sdb4` für `/home`.

Unsere bisherige `/etc/fstab` hat den Inhalt:

~~~
# <file system>				            <mount point>  <type>  <options> <dump><pass>
UUID=B248-1CCA                             /boot/efi   vfat    umask=0077 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb  /           ext4    defaults,noatime 0 1
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256  swap        swap    defaults,noatime 0 2
tmpfs                                      /tmp        tmpfs   defaults,noatime,mode=1777 0 0
~~~

Von der zusätzlichen Festplatte benötigen wir die UUID-Informationen. Siehe auch die Handbuchseite [Anpassung der fstab](part-uuid-de.md#uuid).  
Der Befehl *blkid* gibt uns Auskunft.

~~~
# blkid
...
/dev/sdb4: UUID="e2164479-3f71-4216-a4d4-af3321750322" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="000403b7-04"
~~~

### Sicherung des alten /home

Bevor irgendeine Änderung am bestehenden Dateisysten vorgenommen wird, sichern wir als *Root* alles unterhalb von /home. 

~~~
# cd /home
# tar cvzpf somewhere/home.tar.gz ./
~~~

<div class="divider" id="home-move"></div>

### Kopieren der Daten von /home

Wir binden die neue Partition mit einem temporären Mountpoint ein und kopieren die Daten aus dem alten /home.

Mountpoint erstellen und Partition einhängen:

~~~
# mkdir /mnt/new-home
# mount -t ext4 /dev/sdb4 /mnt/new-home
~~~

Daten kopieren Variante 1:

~~~
# cd /home
# cp -a ./ /mnt/new-home
~~~

Daten kopieren Variante 2 mit dem tar-Archiv der Datensicherung:

~~~
# cd /mnt/new-home
# cp somewhere/home.tar.gz ./
# tar -xvpf home.tar.gz
~~~

Nun befinden sich alle Daten aus dem alten *home* auf der neuen Partition, bei Variante 2 zusätzlich das tar-Archiv.

Jetz hängen wir die neue Partition wieder aus und entfernen den temporären Mountpoint:

~~~
# umount /mnt/new-home
# rmdir /mnt/new-home
~~~

### fstab anpassen

Damit beim Systemstart die neue home-Partition eingehangen wird und dem User zur Verfügung steht, muss die Datei *fstab* geändert werden. Zusätzliche Informationen zur *fstab* bietet unser Handbuch [Anpassung der fstab](part-uuid_de.md).  
Wir benötigen die oben bereits ausgelesene UUID-Information der home-Partition. Zuvor erstellen wir eine Sicherungskopie der *fstab*:

~~~
# cp /etc/fstab /etc/fstab_$(date +%F) 
# mcedit /etc/fstab
~~~

Entsprechend unserem Beispiel fügen wir die folgende Zeile in die fstab ein.

`UUID=e2164479-3f71-4216-a4d4-af3321750322  /home  ext4  defaults,noatime 0 2`

Die fstab sollte nun so aussehen:

~~~
# <file system>				            <mount point>  <type>  <options> <dump><pass>
UUID=B248-1CCA                             /boot/efi   vfat    umask=0077 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb  /           ext4    defaults,noatime 0 1
UUID=e2164479-3f71-4216-a4d4-af3321750322  /home       ext4    defaults,noatime 0 2
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256  swap        swap    defaults,noatime 0 2
tmpfs                                      /tmp        tmpfs   defaults,noatime,mode=1777 0 0
~~~

Man speichert die Datei mit F2 und beendet den Editor mit F10.

### Altes /home entfernen

Zum jetzigen Zeitpunkt ist unser altes `/home` Verzeichnis innerhalb von **`/`** noch aktiv und mit Daten gefüllt. Um das zu ändern, wechseln wir in den emergency-Modus mit:

~~~
# systemctl isolate emergency.target
~~~

Nach Eingabe des Root Passwortes steht ein Terminal zur Verfügung. Der nächste Code-Block zeigt die Ein- und Ausgabe des Terminals der nun notwendigen Befehle.

+ In das **`/`** Verzeichnis wechseln.
+ Das **`/`** Verzeichnis listen.
+ Das `home` Verzeichnis nach `home_alt` verschieben.
+ Ein neues, leeres `home` Verzeichnis erstellen.
+ Wieder in die graphische Oberfläche hochfahren.

~~~
root@sidu:~# cd /
root@sidu:~# ls
  bin    etc         initrd.img.old  libx32      opt   sbin  usr
  boot   fll         lib             lost+found  proc  srv   var
  dev    home        lib32           media       root  sys   vmlinuz
  disks  initrd.img  lib64           mnt         run   tmp   vmlinuz.old
root@sidu:~# mv /home /home_alt
root@sidu:~# mkdir /home
root@sidu:~# systemctl default
~~~

Nachdem wieder in die graphische Oberfläche gewechstelt wurde, sieht der Desktop genauso aus wie zuvor und die neue `home` Partition ist eingebunden. Wir überprüfen das trotzdem mit

~~~
$ mount | grep /home
/dev/sdb4 on /home type ext4 (rw,noatime)
~~~

Unserem Beispiel entsprechend ist `sdb4` unter `/home` eingehängt.  
Nachdem der Datenbestand im `home` Verzeichnis überprüft wurde, können wir das alte home-Verzeichnis löschen.

~~~
# rm -r /home_alt
~~~

Sollte dennoch irgend etwas schief gehen, so haben wir unsere Daten immer noch im gesicherten tar-Archiv.

<div id="rev">Page last revised by akli 2020-05-24</div>
