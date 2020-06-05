ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2020-05:
+ Inhalt vollständig überarbeitet.
+ Neue Aufteilung der Kapitel.
+ Veraltete Inhalte entfernt.

ENDE   INFOBEREICH FÜR DIE AUTOREN

<div class="divider" id="uuid"></div>

## UUID (Universally Unique Identifier) und Partitions-Label

### Dauerhafte Benennung von Blockgeräten

Die dauerhafte Benennung (persistent naming) von Blockgeräten wurde mit Einführung von udev ermöglicht. Der Vorteil ist die Unabhängigkeit von den verwendeten Controllern, sowie der Art und der Anzahl der angeschlossenen Geräte.

Zur Zeit (05-2020) werden in Linux vier Arten von Bezeichnern für Blockgeräte verwendet.

1. **UUID**  
  Er ist eine eindeutige Kennung auf Dateisystem-Ebene und in den Metadaten des Dateisystems gespeichert. Zum Auslesen muss der Dateisystemtyp bekannt und lesbar sein. Er ist unique (einzigartig), denn bereits beim neu Formatieren einer Partition wird ein neuer UUID erstellt.

2. **PARTUUID**  
  Er ist eine Kennung auf Partitionstabellen-Ebene die mit GTP eingeführt wurde. Er bleibt erhalten wenn die Partition umformatiert wird und ist damit nicht unique. Zum Beispiel scheitert das Mounten mittels eines fstab Eintrages auf Basis von PARTUUID, wenn die Partition mit einem anderen Dateisystem versehen wurde ohne die fstab anzupassen.

3. **Geräte-ID (ID)**  
  Die ID wird aus den Metadaten des Gerätes (Hersteller, Anschlussart, Bauart, Speichervolumen usw.) erstellt und berücksichtigt weder die Partitionierung, noch die Dateisysteme in den Partitionen. Sie ist als dauerhafter Bezeichner in der fstab ungeeignet.

4. **PATH**  
  Er setzt sich aus der Bezeichnung des Controllers, der Geräteart und der Partitionsnummer zusammen. Wie bei der ID ist er als dauerhafter Bezeichner in der fstab ungeeignet.

Ein UUID ist eine 128-Bit-Zahl. Jeder kann einen UUID erstellen und ihn verwenden. Die Wahrscheinlichkeit, dass ein UUID dupliziert wird, ist zwar nicht null, aber so gering, dass der Fall vernachlässigt werden kann. Alle Linux-Dateisysteme inklusive swap unterstützen UUID. Obwohl FAT- und NTFS-Dateisysteme UUID nicht unterstützen, werden sie in /dev/disk/by-uuid gelistet.

**In der Grundeinstellung benutzt siduction aus oben genannten Gründen UUID in der /etc/fstab.**

### Dauerhafte Benennung mittels LABEL

Label sind von uns selbst vergebene, leicht wiedererkennbare Bezeichner. Sie sind nicht unique, deshalb muss sehr genau darauf geachtet werden Namensüberschneidungen zu vermeiden. Die Syntax in der fstab ist `LABEL=<label>`.  
Praktisch jeder Typ von Dateisystem kann ein Label haben. Partitionen mit einem Label findet man im Verzeichnis /dev/disk/by-label:

~~~ sh
$ ls -l /dev/disk/by-label
total 0
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2
lrwxrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda6
lrwxrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1
lrwxrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5
lrwxrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1
~~~

Die Bezeichnung eines Labels kann mit folgenden Befehlen erzeugt bzw. geändert werden:

| Dateisystem | Befehl |
| :--- | :--- |
| swap | swaplabel -L <LABEL> /dev/sdXx |
| ext2/ext3/ext4 | e2label /dev/sdXx <LABEL> oder tune2fs -L <LABEL> /dev/sdXx |
| jfs | jfs_tune -L <LABEL> /dev/sdXx |
| xfs | xfs_admin -L <LABEL> /dev/sdXx |
| ReiserFS | reiserfstune -l <LABEL> /dev/sdXx |
| fat | fatlabel /dev/sdXx <LABEL> |
| ntfs | ntfslabel /dev/sdXx <LABEL> |

Der Name des Labels einer NTFS- und FAT-Partitionen sollte nur aus Großbuchstaben, Ziffern und den für Dateinamen erlaubten Sonderzeichen von Windows™ bestehen.

<warning>Unbedingt zu beachten ist:</warning>
<warning>Die Labels müssen eine singuläre Bezeichnung haben, um bei der Einbindung funktionieren zu können. Das gilt auch für externe Geräte (Festplatten, Sticks etc.), die via USB oder Firewire eingebunden werden.</warning>

---

<div class="divider" id="uuid-fstab"></div>

## Die fstab

Die Datei /etc/fstab wird während des Systemstarts ausgelesen um die gewünschten Partitionen einzuhängen. Hier ein Beispiel einer fstab.

~~~ sh
# <file system>					 <mount point>  <type>  <options>	<dump><pass>
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256	swap           swap    defaults,noatime 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb	/              ext4    defaults,noatime 0 1
UUID=35336532-0cc8-4613-9b1a-f31b12ea58c3	/home          ext4    defaults,noatime 0 2
tmpfs						/tmp           tmpfs   defaults,noatime,mode=1777 0 0
UUID=e2164479-3f71-4216-a4d4-af3321750322	/mnt/GNOME_root ext4   noauto,noatime 0 0
LABEL=GNOME_HOME				/mnt/GNOME_home ext4   noauto,users,noatime 0 0
UUID=B248-1CCA					/mnt/TEST_boot vfat    noauto,users,rw,noatime 0 0
UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5	/mnt/TEST_res  ext4    noauto,users,rw,noatime 0 0
~~~

Partitionen, die in der fstab aufgeführt sind, kann man mit ihrem \<file system\>-Bezeichner oder mit dem \<mount point\> eingehängen.

~~~ sh
$ mount UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5
    oder
$ mount /mnt/TEST_res
    oder
$ mount LABEL=GNOME_HOME
~~~

---

## Anpassung der fstab und Erstellung neuer Einhängepunkte

Um neu erstellte Partitionen nutzen zu können (nehmen wir sda5 und sdb7 als Beispiele), die nicht in der fstab erscheinen oder sich nicht mit den zuvor genannten Befehlen mounten lassen, tippt man als user ($) folgenden Befehl in die Konsole:

~~~ sh
ls -l /dev/disk/by-uuid
~~~

Er wird etwas Ähnliches wie dies hier ausgeben:

~~~ sh
lrwxrwxrwx 1 root root 10 Mai 29 17:51 1c257cff-1c96-4c4f-811f-46a87bcf6abb -> ../../sda2
lrwxrwxrwx 1 root root 10 Mai 29 17:51 2e3a21ef-b98b-4d53-af62-cbf9666c1256 -> ../../sda1
lrwxrwxrwx 1 root root 10 Mai 29 17:51 2ef32215-d545-4e12-bc00-d0099a218970 -> ../../sda5
lrwxrwxrwx 1 root root 10 Mai 29 17:51 35336532-0cc8-4613-9b1a-f31b12ea58c3 -> ../../sda4
lrwxrwxrwx 1 root root 10 Mai 29 17:51 4c4b9246-2904-40d1-addc-724fc90a2b6a -> ../../sdb3
lrwxrwxrwx 1 root root 10 Mai 29 17:51 a7aeabe9-f09d-43b5-bb12-878b4c3d98c5 -> ../../sdb7
lrwxrwxrwx 1 root root 10 Mai 29 17:51 B248-1CCA -> ../../sdb1
lrwxrwxrwx 1 root root 10 Mai 29 17:51 d5b01bbc-700c-43ce-a382-1ba95a59de78 -> ../../sdb6
lrwxrwxrwx 1 root root 10 Mai 29 17:51 e2164479-3f71-4216-a4d4-af3321750322 -> ../../sdb5
lrwxrwxrwx 1 root root 10 Mai 29 17:51 f5ed412d-7b7b-41c1-80ce-53337c82405b -> ../../sdb2
~~~

In diesem Beispiel ist  
**`2ef32215-d545-4e12-bc00-d0099a218970`**  der fehlende Eintrag für sda5 und  
**`a7aeabe9-f09d-43b5-bb12-878b4c3d98c5`**  der fehlende Eintrag für sdb7.

Der nächste Schritt ist, die UUID/Partitionen in die /etc/fstab einzutragen. Um sie zu dieser hinzuzufügen, benutzt man einen Texteditor (wie mcedit, kate, kwrite oder gedit) mit Rootrechten; in diesem Beispiel sähe der Eintrag so aus:

~~~ sh
# <file system>                            <mount point>     <type>  <options> <dump><pass>    
UUID=2ef32215-d545-4e12-bc00-d0099a218970  /media/disk1part5 ext4 auto,users,exec 0 2
UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5  /media/disk2part7 ext4 auto,users,exec 0 2
~~~
    
### Erstellung neuer Einhängepunkte
  
**Anmerkung:**
Ein Einhängepunkt, der in fstab festgelegt wird, muss einem existierenden Verzeichnis zugeordnet sein. Diese Verzeichnisse werden während des Installationsprozesses von siduction unterhalb von `/media`  angelegt und besitzen das Benennungsschema `diskXpartX` .

Wenn nun die Partitionierungstabelle nach der Installation verändert und fstab angepasst wurde (zum Beispiel wurden zwei neue Partitionen angelegt), existiert noch kein Einhängepunkt. Er muss manuell angelegt werden.

#### Beispiel:

Als erstes ermittelt man als **Root** die bestehenden Einhängepunkte:

~~~ Less
cd /media
ls
~~~

Die Ausgabe zeigt zum Beispiel:

~~~ sh
disk1part1 disk1part3 disk2part1
~~~

Im Verzeichnis /media werden nun die Einhängepunkte der neuen Partitionen angelegt:

~~~ sh
mkdir disk1part5
mkdir disk2part7
~~~

So können die neuen Partitionen sofort genutzt oder getestet werden:

~~~ sh
mount /media/disk1part5
mount /media/disk2part7
~~~

Nach einem Neustart des Computers werden die neuen Dateisysteme automatisch eingebunden wenn in der fstab unter \<options\> *auto* oder *defaults* eingetragen ist. Siehe auch:

~~~ sh
man mount
~~~

Natürlich muss man sich nicht an das Namensschema *'diskXpartX'* halten. Einhängepunkte (mountpoints) und die dazugehörigen Bezeichner in der fstab können sinnvoll mit z.B. *'data'* oder *'music'* benannt werden.

<div id="rev">Page last revised by akli 2020-05-29</div>
