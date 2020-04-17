<div class="divider" id="uuid"></div>

## Anpassung der fstab und Erstellung neuer Einhängepunkte

 `siduction nutzt bei der Installation uuid in fstab.`
Um eine neu erstellte Partition anzuzeigen (nehmen wir sda6 oder sdb7 als Beispiel), die nicht in der fstab erscheint oder sich nicht mounten lässt, tippt man als user ($) folgenden Befehl in die Konsole:

~~~
ls -l /dev/disk/by-uuid
~~~

Er wird etwas Ähnliches wie dies hier ausgeben (nur das fett Gedruckte ist im Folgenden wichtig):

~~~
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 348ea9e6-7879-4332-8d7a-915507574a80 -> ../../sda4
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 610aaaeb-a65e-4269-9714-b26a1388a106 -> ../../sda2
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 857c5e63-c9be-4080-b4c2-72d606435051 -> ../../sda5
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 a83b8ede-a9df-4df6-bfc7-02b8b7a5f1f2 -> ../../sda1
lrwxrwxrwx 1 root root 10 2007-05-27 23:42  **ad662d33-6934-459c-a128-bdf0393e0f44**  -> ../../sda6
~~~

In diesem Beispiel ist  **ad662d33-6934-459c-a128-bdf0393e0f44**  der fehlende Eintrag. Der nächste Schritt ist, die UUID/Partition in die /etc/fstab einzutragen. Um sie zu dieser hinzuzufügen, benutzt man einen Texteditor (wie kate oder kwrite) mit Rootrechten; in diesem Beispiel sähe der Eintrag so aus:

~~~
# <device file system> <mount point> <type> <options> <dump> <pass>
 UUID=ad662d33-6934-459c-a128-bdf0393e0f44   /media/disk1part6   ext4   auto,users,exec   0   2
~~~

Ein anderes Beispiel:

~~~
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 30ebb8eb-8f22-460c-b8dd-59140274829d -> ../../sdb8
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 387d6d4b-4508-4b8e-8ed2-76998f41dae4 -> ../../sdb1
rwxrwxrwx 1 root root 10 2007-05-28 13:18 7014f66f-6cdf-4fe1-83da-9cab7b6fab1a -> ../../sdb5
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 8f042ead-259f-4df0-98ec-3343080396c5 -> ../../sdb6
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 94B0AE63B0AE4B94 -> ../../sda2
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 A61820AA18207B85 -> ../../sda1
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f28725d6-b7b5-4207-8476-36efe1a903ce -> ../../sdb9
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f855c263-2521-48d3-8ec9-d2d2b69b6635 -> ../../sda3
rwxrwxrwx 1 root root 10 2007-05-28 13:18  **f9aa4027-ecdd-4a86-84e2-df2ef73fe14e**  -> ../../sdb7
~~~

In diesem Fall ist  **f9aa4027-ecdd-4a86-84e2-df2ef73fe14e**  der fehlende Eintrag und dieser wird zur  */etc/fstab*  hinzugefügt:

~~~
# <device file system2 <mount point2 <type2 <options2 <dump2 <pass2
 UUID=f9aa4027-ecdd-4a86-84e2-df2ef73fe14e   /media/disk2part7   ext4   auto,users,exec   0   2
~~~

### Erstellung neuer Einhängepunkte

 `Anmerkung:`  Ein Einhängepunkt, der in fstab festgelegt wird, muss einem existierenden Verzeichnis zugeordnet sein. Diese Verzeichnisse werden während des Installationsprozesses von siduction unterhalb von `/media`  angelegt und besitzen das Benennungsschema `diskXpartX` .

Wenn nun die Partitionierungstabelle nach der Installation verändert (zum Beispiel: es wurden zwei neue Partitionen angelegt) und fstab angepasst wurde, existiert jedoch kein Einhängepunkt, welcher manuell angelegt werden muss.

#### Beispiel:

Als erstes ermittelt man als Root die bestehenden Einhängepunkte:

~~~
cd /media
ls
~~~

Die Ausgabe zeigt zum Beispiel:

~~~
disk1part1 disk1part3 disk2part1
~~~

Im Verzeichnis /media werden nun die Einhängepunkte der neuen Partitionen angelegt:

~~~
mkdir disk1part6
mkdir disk2part7
~~~

So können die neuen Partitionen sofort genutzt oder getestet werden:

~~~
mount /dev/sda6 /media/disk1part6
mount /dev/sda6 /media/disk2part7
~~~

Nach einem Neustart des Computers werden die neuen Dateisysteme automatisch eingebunden. Siehe auch:

Natürlich muss man sich nicht an das Namensschema `diskXpartX halten. Einhängepunkte (mountpoints) und die dazugehörigen Bezeichner in der fstab können sinnvoll mit z.B. 'data' oder 'music' benannt werden.` 

~~~
man mount
~~~

<div class="divider" id="uuid-fstab"></div>

## Übersicht: UUID, Partitions-Label und fstab

Die dauerhafte Benennung (persistent naming) von Blockgeräten wurde mit Einführung von udev ermöglicht und hat einige Vorteile gegenüber der Benennung auf Bus-Basis. Im Folgenden nennen wir eine Kennzeichnung nach dieser Methode einen "dauerhaften Bezeichner".

Die Weiterentwicklung von udev und von Linux-Distributionen hat die Hardware-Erkennung verlässlicher gemacht, auch wenn Veränderungen und neue Herausforderungen damit verbunden sind oder sein können:  
  
1)  Bei mehr als einem SATA/SCSI- oder IDE-Festplattenkontroller ist die Reihenfolge der Einbindung der Speichergeräte nun beliebig bzw. zufällig. Dies hat zur Folge, dass Gerätenamen nach jedem Bootvorgang beliebig zwischen hdX und hdY wechseln können. Gleiches gilt für sdX und sdY. Ein dauerhafter Bezeichner ermöglicht es, dass man darüber keine Gedanken zu verlieren braucht.  
  
2)  Mit Einführung der neuen libata PATA-Unterstützung werden alle Speichergeräte in Hinkunft mit sdX benannt, auch Geräte, die bisher hdX benannt waren. Mittels persistent naming ist man als Anwender in der Regel damit nicht konfrontiert, man bemerkt es nicht.  
  
3)  Bei Computern mit SATA- und IDE-Kontrollern (übliche Ausstattung moderner PCs) werden alle Speichergeräte mit sdX benannt.

 `In der Grundeinstellung benutzt eine siduction-Installation aus oben genannten Gründen UUID in /etc/fstab.`
Aus diesen und weiteren Überlegungen empfiehlt siduction, die Grundeinstellungen zu einem Schema mit dauerhaftem Bezeichner umzustellen.

## Die vier Grundschemata zur Erstellung eines dauerhaften Bezeichners:

### 1. Dauerhafter Bezeichner mittels UUID

UUID (wörtlich "Universally Unique Identifier") ist eine eindeutige, singuläre Kennzeichnung eines Geräts. Technisch wird ermöglicht, jedem Dateisystem eine eindeutige, singuläre Identifikation zu geben. Die technische Umsetzung dieses Konzepts macht eine Kollision zweier gleicher Identifikationsnummern sehr unwahrscheinlich.  
Alle Linux-Dateisysteme inklusive swap unterstützen UUID. Obwohl FAT- und NTFS-Dateisysteme UUID nicht unterstützen, werden sie in by-uuid mit eindeutigen, singulären Identifikationsnummern gelistet:

~~~
$ /bin/ls -lF /dev/disk/by-uuid/
total 0
lrwxrwxrwx 1 root root 10 Oct 16 10:27 2d781b26-0285-421a-b9d0-d4a0d3b55680 -> ../../sda1
lrwxrwxrwx 1 root root 10 Oct 16 10:27 31f8eb0d-612b-4805-835e-0e6d8b8c5591 -> ../../sda7
lrwxrwxrwx 1 root root 10 Oct 16 10:27 3FC2-3DDB -> ../../sda6
lrwxrwxrwx 1 root root 10 Oct 16 10:27 5090093f-e023-4a93-b2b6-8a9568dd23dc -> ../../sda2
lrwxrwxrwx 1 root root 10 Oct 16 10:27 912c7844-5430-4eea-b55c-e23f8959a8ee -> ../../sda5
lrwxrwxrwx 1 root root 10 Oct 16 10:27 B0DC1977DC193954 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Oct 16 10:27 bae98338-ec29-4beb-aacf-107e44599b2e -> ../../sdb2
~~~

Wie man sehen kann, haben die FAT- und NTFS-Partitionen kürzere Bezeichnungen, sind aber dennoch gelistet (sda6 und sdb1).

### 2. Dauerhafter Bezeichner mittels LABEL

Praktisch jeder Typ von Dateisystem kann ein Label haben. Partitionen mit einem Label findet man im Verzeichnis /dev/disk/by-label:

~~~
$ ls -lF /dev/disk/by-label
total 0
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data2 -> ../../sda2
lrwxrwxrwx 1 root root 10 Oct 16 10:27 fat -> ../../sda6
lrwxrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda7
lrwxrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1
lrwxrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5
lrwxrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1
~~~

Während Labels leicht wiedererkennbare Bezeichnungen haben, muss jedoch sehr genau darauf geachtet werden, Namensüberschneidungen zu vermeiden.

Die Bezeichnung eines Labels kann mit folgenden Befehlen geändert werden:

~~~
* swap: Erzeugung eines neuen swapspace: mkswap -L <label2 /dev/XXX
* ext2/ext3/ext4: e2label /dev/XXX <label2
* jfs: jfs_tune -L <label2 /dev/XXX
* xfs: xfs_admin -L <label2 /dev/XXX
* fat/vfat: Es gibt zwar kein Tool, um das Label einer FAT-Partition unter Linux zu ändern,
aber bei der Erstellung des Filesystems kann dieser Befehl verwendet werden:
mkdosfs -n <label2 <weitere Optionen2.
Die Änderung eines Labels von FAT-Partitionen kann in Windows durchgeführt werden.
* ntfs: ntfslabel /dev/XXX <label2 Änderung des Labels in Windows.
~~~

 `Unbedingt zu beachten ist: die Labels müssen eine singuläre Bezeichnung haben, um bei der Einbindung funktionieren zu können. Das gilt auch für externe Geräte (Festplatten, Sticks etc.), die via USB oder Firewire eingebunden werden. Die Syntax LABEL= oder UUID= ist für UN*X-Partitionen gegenüber /dev/disk/by-*/ vorzuziehen.`
### 3. Dauerhafter Bezeichner mittels ID 

by-id kreiert eine singuläre Bezeichnung auf Basis der Seriennummer der Hardware.

### 4. Dauerhafter Bezeichner mittels Pfad

by-path kreiert eine singuläre Bezeichnung auf Basis des kürzesten physischen Pfads (laut sysfs).  
  
Beide letztgenannten Methoden beinhalten Zeichenketten, welche indizieren, zu welchem Subsystem sie gehören, und sind somit nicht geeignet, die zu Beginn genannten Probleme zu lösen und werden im Weiteren hier nicht diskutiert.

### Aktivierung des dauerhaften Bezeichners

Hier nun die Methode, wie ein dauerhafter Bezeichner aktiviert wird.

### In fstab

Die Aktivierung in /etc/fstab ist einfach. Der Gerätename in der ersten Spalte wird durch den dauerhaften Bezeichner ersetzt. In unserem Beispiel wird /dev/sda7 durch einen der beiden neuen Bezeichner ersetzt:

~~~
/dev/disk/by-label/home oder
/dev/disk/by-uuid/31f8eb0d-612b-4805-835e-0e6d8b8c5591
~~~

Dies wird für alle Partitionen in der fstab durchgeführt.

Anstelle der direkten Benennung durch einen dauerhaften Bezeichner kann das Laufwerk, das mittels UUID oder Label eingebunden werden soll, auch nur indiziert werden, indem geschrieben wird: LABEL=&lt;label&gt; oder UUID=&lt;uuid&gt;. Zum Beispiel:

~~~
LABEL=Boot
~~~

oder

~~~
UUID=3e6be9de-8139-11d1-9106-a43f08d823a6
~~~

Quelle: [wiki.archlinux.org](http://wiki.archlinux.org/index.php/Persistent_block_device_naming)  unter Bezugnahme auf [marc.theaimsgroup.com](http://marc.theaimsgroup.com/?l=linux-hotplug-devel&amp;m=114795097514527&amp;w=2) . Der Inhalt von wiki.archlinux.org ist als unter der GNU Free Documentation License 1.2 stehend ausgewiesen. Neu editiert bzw. übersetzt für die siduction-Handbücher.

Mehr über Labels findet man auf [Debian Ressources](http://debian-resources.org/node/9/)  

<div id="rev">Page last revised 15/01/2012 1045 UTC</div>
