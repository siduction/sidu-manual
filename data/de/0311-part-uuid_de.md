% UUID - Benennung von Blockgeräten

## UUID - Benennung von Blockgeräten

**UUID (Universally Unique Identifier) und Partitions-Label**

Die dauerhafte Benennung (persistent naming) von Blockgeräten wurde mit Einführung von udev ermöglicht. Der Vorteil ist die Unabhängigkeit von den verwendeten Controllern, sowie der Art und der Anzahl der angeschlossenen Geräte. Die bei der Installation von siduction erstellte Datei `/etc/fstab` enthält entsprechende Einträge für alle zu diesem Zeitpunkt angeschlossenen Blockgeräte.

### Arten der Benennung von Blockgeräten

Zur Zeit werden in Linux fünf Arten von Bezeichnern für Blockgeräte verwendet. Alle Bezeichner sind unterhalb des Verzeichnisses `/dev/disk/` zu finden und werden vom System automatisch erstellt. Für `Label` gilt dies nur, sofern diese den Blockgeräten zuvor zugewiesen wurden.

1. **UUID**  
  Er ist eine eindeutige Kennung auf Dateisystem-Ebene und in den Metadaten des Dateisystems gespeichert. Zum Auslesen muss der Dateisystemtyp bekannt und lesbar sein. Er ist unique (einzigartig), denn bereits beim Formatieren einer Partition wird ein neuer UUID erstellt.  
  Ein UUID ist eine 128-Bit-Zahl. Jeder kann einen UUID erstellen und ihn verwenden. Die Wahrscheinlichkeit, dass ein UUID dupliziert wird, ist zwar nicht null, aber so gering, dass der Fall vernachlässigt werden kann. Alle Linux-Dateisysteme inklusive swap unterstützen UUID. Obwohl FAT- und NTFS-Dateisysteme UUID nicht unterstützen, werden sie in `/dev/disk/by-uuid` gelistet.

2. **PARTUUID**  
  Er ist eine Kennung auf Partitionstabellen-Ebene die mit GTP eingeführt wurde. Er bleibt erhalten wenn die Partition umformatiert wird und ist damit nicht unique. Zum Beispiel scheitert das Mounten mittels eines fstab Eintrages auf Basis von PARTUUID, wenn die Partition mit einem anderen Dateisystem versehen wurde ohne die fstab anzupassen.

3. **Geräte-ID (ID)**  
  Die ID wird aus den Metadaten des Gerätes (Hersteller, Anschlussart, Bauart, Speichervolumen usw.) erstellt und berücksichtigt weder die Partitionierung, noch die Dateisysteme in den Partitionen. Sie ist als dauerhafter Bezeichner in der fstab ungeeignet.

4. **PATH**  
  Er setzt sich aus der Bezeichnung des Controllers, der Geräteart und der Partitionsnummer zusammen. Wie bei der ID ist er als dauerhafter Bezeichner in der fstab ungeeignet.

5. **LABEL**  
  Label sind von uns selbst vergebene, leicht wiedererkennbare Bezeichner. Sie sind nicht unique, deshalb muss sehr genau darauf geachtet werden Namensüberschneidungen zu vermeiden. 

**In der Grundeinstellung benutzt siduction aus oben genannten Gründen UUID in der `/etc/fstab`.**

### Label verwenden

Das Label eines Blockgerätes hat für uns Menschen den Vorteil leicht verständlich und gut wiedererkennbar zu sein. 
Praktisch jeder Typ von Dateisystem kann ein Label haben. Partitionen mit einem Label findet man im Verzeichnis `/dev/disk/by-label`:

~~~
$ ls -l /dev/disk/by-label
total 0
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2
lrwxrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda6
lrwxrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1
lrwxrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5
lrwxrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1
~~~

Die Bezeichnung eines Labels kann je nach Dateisystem mit folgenden Befehlen erzeugt bzw. geändert werden:

+ **swap**  
  `swaplabel -L <label> /dev/sdXx`
  
+ **ext2/ext3/ext4**  
  `e2label /dev/sdXx <label>` oder  
  `tune2fs -L <label> /dev/sdXx`
  
+ **JFS**  
  `jfs_tune -L <label> /dev/sdXx`
  
+ **XFS**  
  `xfs_admin -L <label> /dev/sdXx`
  
+ **ReiserFS**  
  `reiserfstune -l <label> /dev/sdXx`
  
+ **FAT**  
  `fatlabel /dev/sdXx <label>`
  
+ **NTFS**  
  `ntfslabel /dev/sdXx <label>`
  
+ **exFAT**
  `exfatlabel /dev/sdXx <label>`

Der Name des Labels einer NTFS- und FAT-Partition sollte nur aus Großbuchstaben, Ziffern und den für Dateinamen erlaubten Sonderzeichen von Windows™ bestehen.

Die Syntax in der `fstab` für das `<file system>` ist `LABEL=<label>`.

> Unbedingt zu beachten ist:  
> Die Labels müssen eine singuläre Bezeichnung haben, um bei der Einbindung funktionieren zu können. Das gilt auch für externe Geräte (Festplatten, Sticks etc.), die via USB oder Firewire eingebunden werden.

## Die fstab

Die Datei `/etc/fstab` wird während des Systemstarts ausgelesen um die gewünschten Partitionen einzuhängen. Hier ein Beispiel einer fstab.

~~~
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256	swap           swap    defaults,noatime 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb	/              ext4    defaults,noatime 0 1
UUID=35336532-0cc8-4613-9b1a-f31b12ea58c3	/home          ext4    defaults,noatime 0 2
tmpfs				                		/tmp           tmpfs   defaults,noatime,mode=1777 0 0
UUID=e2164479-3f71-4216-a4d4-af3321750322	/mnt/TEST_root ext4    noauto,noatime 0 0
LABEL=TEST_HOME			                	/mnt/TEST_home ext4    noauto,users,noatime 0 0
UUID=B248-1CCA			            		/mnt/TEST_boot vfat    noauto,users,rw,noatime 0 0
UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5	/mnt/TEST_res  ext4    noauto,users,rw,noatime 0 0
~~~

Partitionen, die in der fstab aufgeführt sind, kann man mit ihrem "\<file system\>"-Bezeichner oder mit dem "\<mount point\>" einhängen.

~~~
$ mount UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5
    oder
$ mount /mnt/TEST_res
    oder
$ mount LABEL=TEST_HOME
~~~

### Anpassung der fstab

Um neu erstellte Partitionen nutzen zu können (nehmen wir `sda5` und `sdb7` als Beispiele), die nicht in der fstab erscheinen oder sich nicht mit den zuvor genannten Befehlen mounten lassen, tippt man als **user** folgenden Befehl in die Konsole:

~~~
ls -l /dev/disk/by-uuid
~~~

Er wird etwas Ähnliches wie dies hier ausgeben:

~~~
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
**`2ef32215-d545-4e12-bc00-d0099a218970`**  der fehlende Eintrag für `sda5` und  
**`a7aeabe9-f09d-43b5-bb12-878b4c3d98c5`**  der fehlende Eintrag für `sdb7`.

Der nächste Schritt ist, die UUID/Partitionen in die `/etc/fstab` einzutragen. Um sie zu dieser hinzuzufügen, benutzt man einen Texteditor (wie mcedit, kate, kwrite oder gedit) mit Rootrechten; in diesem Beispiel sähe der Eintrag so aus:

~~~
UUID=2ef32215-d545-4e12-bc00-d0099a218970  /media/disk1part5 ext4 auto,users,exec 0 2
UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5  /media/disk2part7 ext4 auto,users,exec 0 2
~~~

Anschließend informieren wir den Kernel über die Änderungen an der `/etc/fstab` mit dem Befehl **`systemctl daemon-reload`**.

### Erstellung neuer Einhängepunkte
  
**Anmerkung:**
Ein Einhängepunkt, der in fstab festgelegt wird, muss einem existierenden Verzeichnis zugeordnet sein. Diese Verzeichnisse werden während der Live-Session von siduction unterhalb von `/media`  angelegt und besitzen das Benennungsschema `diskXpartX` .

Wenn nun die Partitionierungstabelle nach der Installation verändert und fstab angepasst wurde (zum Beispiel wurden zwei neue Partitionen angelegt), existiert noch kein Einhängepunkt. Er muss manuell angelegt werden.

**Beispiel**  
Als erstes werden wir zu **root** und ermitteln die bestehenden Einhängepunkte.
Die Ausgabe zeigt zum Beispiel:

~~~
cd /media
ls
disk1part1 disk1part3 disk2part1
~~~

Im Verzeichnis `/media` werden nun die Einhängepunkte der neuen Partitionen angelegt:

~~~
mkdir disk1part5
mkdir disk2part7
~~~

So können die neuen Partitionen sofort genutzt oder getestet werden:

~~~
mount /media/disk1part5
mount /media/disk2part7
~~~

Nach einem Neustart des Computers werden die neuen Dateisysteme automatisch eingebunden wenn in der fstab unter "\<options\>" `auto` oder `defaults` eingetragen ist. Siehe auch:

~~~
man mount
~~~

Natürlich muss man sich nicht an das Namensschema *"diskXpartX"* halten. Einhängepunkte (mountpoints) und die dazugehörigen Bezeichner in der fstab können sinnvoll mit z.B. *"data"* oder *"music"* benannt werden.

<div id="rev">Zuletzt bearbeitet: 2023-11-07</div>
