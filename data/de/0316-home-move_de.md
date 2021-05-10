% home verschieben

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC§**

Änderungen 2020-05:

+ Inhalt vollständig überarbeitet
+ Korrektur und Prüfung aller Links.

Änderungen 2020-12:

+ Rechtschreib- und Layoutfehler korrigiert
+ Inhalt teilweise überarbeitet.
+ Für die Verwendung mit pandoc optimiert.

Änderungen 2021-03:

+ /home-Partition entfernt Erklärung unter Hinweise eingefügt.
+ Den weiteren Inhalt entsprechend angepasst.

Änderungen 2021-05:
Leichte umformulierung, warnug eingefügt, Status RC 3

ENDE   INFOBEREICH FÜR DIE AUTOREN

## Das Verzeichnis /home verschieben

> Wichtige Information  
> Ein existierendes **/home** soll nicht mit einer anderen Distribution verwendet oder geteilt werden, da es bei den Konfigurationsdateien zu Konflikten kommen kann/wird.

Deshalb raten wir generell davon ab eine /home-Partition anzulegen.  
Das Verzeichnis **/home** sollte der Ort sein, an dem die individuellen Konfigurationen abgelegt werden, und nur diese. Für alle weiteren privaten Daten sollte eine eigene Datenpartition angelegt, und diese z. B. unter **/Daten** eingehängt werden. Die Vorteile für die Datenstabilität, Datensicherung und auch im Falle einer Datenrettung sind nahezu unermesslich.  
Sofern Daten gemeinsam für parallele Installationen bereit stehen sollen, ist diese Vorgehensweise besonders ratsam.

### Vorbereitungen

An Hand eines realistischen Beispiels zeigen wir die notwendigen Schritte auf.  
Die Ausgangslage:

* Die alte, mittlerweile zu kleine, Festplatte hat drei Partitionen ("/boot/efi", "/", "swap").
* Es existiert bisher noch keine separate Daten-Partition.
* Eine zusätzliche eingebaute Festplatte hat vier Partitionen mit ext4-Dateisystem.  
  Davon benutzen wir die Partitionen "sdb4" für die neue Daten-Partition, die wir unter "/Daten" einhängen.

Unsere bisherige **/etc/fstab** hat den Inhalt:

~~~
$ cat /etc/fstab
...
# <file system>				            <mount point>  <type>  <options>    <dump><pass>
UUID=B248-1CCA                             /boot/efi   vfat    umask=0077 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb  /           ext4    defaults,noatime 0 1
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256  swap        swap    defaults,noatime 0 2
tmpfs                                      /tmp        tmpfs   defaults,noatime,mode=1777 0 0
~~~

Von der zusätzlichen Festplatte benötigen wir die UUID-Informationen. Siehe auch die Handbuchseite [Anpassung der fstab](#fstab-anpassen).  
Der Befehl *blkid* gibt uns Auskunft.

~~~
$ /sbin/blkid
...
/dev/sdb4: UUID="e2164479-3f71-4216-a4d4-af3321750322" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="000403b7-04"
~~~

**Sicherung des alten /home**

Bevor irgendeine Änderung am bestehenden Dateisysten vorgenommen wird, sichern wir als *Root* alles unterhalb von "/home" in einem tar-Archiv. 

~~~
# cd /home
# tar cvzpf somewhere/home.tar.gz ./
~~~

**Mountpoint der Daten-Partition**

Wir erstellen das Verzeichnis "*Daten*" underhalb "**/**" und binden die Partition "sdb4" dort ein. Als Eigentümer und Gruppe legen wir die eigenen Namen fest. Etwas später kopieren wir die privaten Daten, nicht aber die Konfigurationen, aus dem bestehenden /home dort hinein.

Mountpoint erstellen und Partition einhängen (als root):

~~~
# mkdir /Daten
# chown <user>.<group> /Daten
# mount -t ext4 /dev/sdb4 /Daten
~~~

### Private Daten verschieben

**Analyse von /home**

Wir schauen uns erst einmal unser Home-Verzeichnis genau an.  
(Die Ausgabe wurde zur besseren Übersicht sortiert.)

~~~
~$ ls -la
insgesamt 169
drwxr-xr-x 19 <user> <group> 4096  4. Okt 2020  .
drwxr-xr-x 62 <user> <group> 4096  4. Okt 22:17 ..
-rw-------  1 <user> <group>  330 15. Okt 2020  .bash_history
-rw-r--r--  1 <user> <group>  220  4. Okt 2020  .bash_logout
-rw-r--r--  1 <user> <group> 3528  4. Okt 2020  .bashrc
drwx------ 19 <user> <group> 4096 15. Okt 2020  .cache
drwxr-xr-x 22 <user> <group> 4096 15. Okt 2020  .config
-rw-r--r--  1 <user> <group>   24  4. Okt 2020  .dmrc
drwx------  3 <user> <group> 4096 15. Okt 2020  .gconf
-rw-r--r--  1 <user> <group>  152  4. Okt 2020  .gitignore
drwx------  3 <user> <group> 4096 15. Okt 2020  .gnupg
-rw-------  1 <user> <group> 3112 15. Okt 2020  .ICEauthority
-rw-r--r--  1 <user> <group>  140  4. Okt 2020  .inputrc
drwx------  3 <user> <group> 4096  4. Okt 2020  .local
drwx------  5 <user> <group> 4096 15. Okt 2020  .mozilla
-rw-r--r--  1 <user> <group>  807  4. Okt 2020  .profile
drwx------  2 <user> <group> 4096  4. Okt 2020  .ssh
drwx------  5 <user> <group> 4096 15. Okt 2020  .thunderbird
-rw-------  1 <user> <group>   48 15. Okt 2020  .Xauthority
-rw-------  1 <user> <group> 1084 15. Okt 2020  .xsession-errors
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Bilder
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Desktop
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Dokumente
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Downloads
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Musik
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Öffentlich
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Videos
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Vorlagen
~~~

Die Ausgabe zeigt das Home-Verzeichnis kurz nach der Installation mit nur geringfügigen Änderungen.  
In den, per default erstellten, Verzeichnissen "*Bilder*" bis "*Vorlagen*" am Ende der Liste, legen wir unsere privaten Dokumente ab. Diese und eventuell zusätzliche, selbst erstellte Verzeichnisse mit privaten Daten, verschieben wir später in die neue Daten-Partition.  
Mit einem Punkt (.) beginnende, "versteckte" Dateien und Verzeichnisse enthalten die Konfiguration und programmspezifische Daten, die wir, von drei Ausnahmen abgesehen, nicht verschieben. Die Ausnahmen sind:  
Der Zwischenspeicher "*.cache*",  
der Internetbrowser "*.mozilla*" und  
das Mailprogramm "*.thunderbird*".  
Alle drei erreichen mit der Zeit ein erhebliches Volumen und sie enthalten auch viele private Daten. Deshalb wandern sie zusätzlich auf die neue Daten-Partition.

**Kopieren der privaten Daten**

Zum Kopieren benutzen wir den Befehl "*cp*" mit der Archiv-Option "*-a*", so bleiben die Rechte, Eigentümer und der Zeitstempel erhalten und es wird rekursiv kopiert.

~~~
~$ cp -a * /Daten/
~$ cp -a .cache /Daten/
~$ cp -a .mozilla /Daten/
~$ cp -a .thunderbird /Daten/
~~~

Der erste Befehl kopiert alle Dateien und Verzeichnisse, außer die versteckten.  
Die folgende Ausgabe zeigt das Ergebnis.

~~~
~$ ls -la /Daten/
insgesamt 45
drwxr-xr-x 13 <user> <group> 4096  4. Mai 2020  .
drwxr-xr-x 20 root     root  4096  4. Okt 2020  ..
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Bilder
drwx------ 19 <user> <group> 4096 15. Okt 2020  .cache
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Desktop
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Dokumente
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Downloads
drwx------  5 <user> <group> 4096 15. Okt 2020  .mozilla
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Musik
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Öffentlich
drwx------  5 <user> <group> 4096 15. Okt 2020  .thunderbird
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Videos
drwxr-xr-x  2 <user> <group> 4096  4. Okt 2020  Vorlagen
~~~

Die Prüfung der Kopieraktion auf Fehler erfolgt mit dem Befehl **`dirdiff /home/<user>/ /Daten/`**. Es dürfen nur die Dateien und Verzeichnisse gelistet sein, die wir nicht kopiert haben.

Nun befinden sich alle privaten Daten aus dem alten *home* zusätzlich auf der neuen Partition.

**Löschen in /home**

Für diese Aktion sollten alle Programmfenster, mit Ausnahme des von uns benutzten Terminals, geschlossen werden.  
Je nach Desktopumgebung benutzen diverse Anwendungen die per default bei der Installation angelegten Verzeichnisse (z. B. "*Musik*") um dort Dateien abzulegen. Um den Zugriff der Anwendungen auf die Verzeichnisse zu ermöglichen müssen diese zurück verlinkt werden, somit auf entsprechende Verzeichnisse der /daten Partition verweisen.

> Die Befehle vor dem Ausführen bitte genau prüfen, damit nicht aus Versehen etwas falsches gelöscht wird.

~~~
~$ rm -r Bilder/ && ln -s /Daten/Bilder/ ./Bilder
~$ rm -r Desktop/ && ln -s /Daten/Desktop/ ./Desktop
~$ rm -r Dokumente/ && ln -s /Daten/Dokumente/ ./Dokumente
~$ rm -r Downloads/ && ln -s /Daten/Downloads/ ./Downloads
~$ rm -r Musik/ && ln -s /Daten/Musik/ ./Musik
~$ rm -r Öffentlich/ && ln -s /Daten/Öffentlich/ ./Öffentlich
~$ rm -r Videos/ && ln -s /Daten/Videos/ ./Videos
~$ rm -r Vorlagen/ && ln -s /Daten/Vorlagen/ ./Vorlagen
~$ rm -r .cache/ && ln -s /Daten/.cache/ ./.cache
~$ rm -r .mozilla/ && ln -s /Daten/.mozilla/ ./.mozilla
~$ rm -r .thunderbird/ && ln -s /Daten/.thunderbird/ ./.thunderbird
~~~

Die im /home-Verzeichnis verbliebenen Daten belegen nur noch einen Speicherplatz von weniger als 10 MB.

### fstab anpassen

Damit beim Systemstart die neue Daten-Partition eingehangen wird und dem User zur Verfügung steht, muss die Datei *fstab* geändert werden. Zusätzliche Informationen zur *fstab* bietet unser Handbuch [Anpassung der fstab](0311-part-uuid_de.md#anpassung-der-fstab).  
Wir benötigen die oben bereits ausgelesene UUID-Information der Daten-Partition. Zuvor erstellen wir eine Sicherungskopie der *fstab* mit Datumsanhang:

~~~
# cp /etc/fstab /etc/fstab_$(date +%F) 
# mcedit /etc/fstab
~~~

Entsprechend unseres Beispiels fügen wir die folgende Zeile in die fstab ein.

**`UUID=e2164479-3f71-4216-a4d4-af3321750322  /Daten  ext4  defaults,noatime 0 2`**

Die fstab sollte nun so aussehen:

~~~
# <file system>				            <mount point>  <type>  <options>    <dump><pass>
UUID=B248-1CCA                             /boot/efi   vfat    umask=0077 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb  /           ext4    defaults,noatime 0 1
UUID=e2164479-3f71-4216-a4d4-af3321750322  /Daten      ext4    defaults,noatime 0 2
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256  swap        swap    defaults,noatime 0 2
tmpfs                                      /tmp        tmpfs   defaults,noatime,mode=1777 0 0
~~~

Man speichert die Datei mit F2 und beendet den Editor mit F10.

Sollte dennoch irgend etwas schief gehen, so haben wir unsere Daten immer noch im gesicherten tar-Archiv.

<div id="rev">Zuletzt bearbeitet: 2021-05-10</div>
