<div class="divider" id="part-lvm"></div>

## LVM-Partitionierung - Logical Volume Manager

**`Es folgt nun eine Basiseinführung. Es liegt am geschätzten Leser, sich tiefer in die Materie einzuarbeiten. Weitere Informationsquellen finden sich am Ende dieses Textes gelistet - die Liste erhebt keinen Anspruch auf Vollständigkeit.`** 

Diese Anleitung gilt ab siduction-onestepbeyond.iso.

Logische Volumen können mehrere Festplatten umspannen und sind skalierbar. Dies unterscheidet sie von anderen Methoden der Festplattenpartitionierung.

Weder die traditionelle Partitionierungsmethode noch die Partitionierung mit LVM sind Aktionen, die sehr oft durchgeführt werden. Somit sollte die Vorgehensweise durchdacht sein, um das gewünschte Ergebnis zu erzielen.

Mit drei Grundbegriffen sollte man vertraut sein:

+ `Physical Volumes (Physische Volumen):`  Diese sind die physischen Festplatten oder Partitionen wie zum Beispiel /dev/sda oder /dev/sdb1 und werden zum Einbinden/Ausbinden verwendet. Mit LVM können mehrere physische Volumen in Volumengruppen zusammengefasst werden.

+ `Volume Groups (Volumengruppen):`  Eine Volumengruppe besteht aus realen physischen Volumen und ist der Speicherort zur Erstellung von logischen Volumen, welche erstellt, entfernt und verwendet werden können, bzw. deren Größe verändert werden kann. Eine Volumengruppe kann als "virtuelles Laufwerk" gesehen werden, das aus physischen Volumen zusammengesetzt ist. Sie kann in "virtuelle" Partitionen aufgeteilt werden, welche wiederum logische Volumen sind.

+ `Logical Volumes (Logische Volumen):`  Logische Volumen schließlich sind die Volumen, die im System eingebunden werden. Sie können dynamisch verändert werden, da ein logisches Volumen größer sein kann als ein physisches Volumen (zum Beispiel kann ein logisches Volumen aus vier 250GB großen Festplatten bestehen und 1TB umfassen).

### Sechs Schritte, die benötigt werden

`Wir gehen in unserem Beispiel von nicht partitionierten Festplatten aus. Zu beachten ist: falls alte Partitionen gelöscht werden, gehen alle Daten unwiederbringlich verloren.` 

Als Partitionierungsprogramm werden cfdisk oder fdisk benötigt, da zur Zeit GParted bzw. der KDE-Partitionsmanager (partitionmanager) LVM nicht unterstützen.

`Schritt 1:`  Erstellung einer Partitionstabelle:

~~~
cfdisk /dev/sda
`n` erstellt eine neue Partition auf dem Laufwerk
`p` diese Partition wird eine primäre Partition
`1` die Partition erhält die Nummer 1 als Identifikation
`### size allocation`  ### setzt den ersten und letzten Zylinder auf Default-Werte. Drücke ENTER, um das gesamte Laufwerk zu umspannen
`t` wählt den zu erstellenden Partitionstyp
`8e` dies ist der Hex-Code für eine Linux-LVM
`W` schreibt Veränderungen auf das Laufwerk. ##Dieser Befehl schreibt die Partitionierungstabelle. Falls bis zu diesem Punkt ein Fehler gemacht wurde, kann das vorhandene Partitionierungs-Layout wieder hergestellt werden und die Daten sind witerhin vorhanden.##
~~~

Falls das Volumen mehr als ein Laufwerk umspannen soll, muss obiger Vorgang auf jedem Laufwerk durchgeführt werden.

`Schritt 2:`  Erstellen eines physischen Volumens (dieser Schritt löscht alle Daten):

~~~
pvcreate /dev/sda1
~~~

Dieser Vorgang wird nach Bedarf auf jeder Partition wiederholt.

`Schritt 3:`  Erstellen einer Volumengruppe:

~~~
vgcreate vulcan /dev/sda1
~~~

Hier werden alle Laufwerke, welche in der Volumengruppe sein sollen, im Befehl vgcreate gelistet (in unserem Beispiel drei Laufwerke):

~~~
vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1
~~~

Falls dieser Schritt korrekt durchgeführt wurde, kann das Ergebnis in der Ausgabe folgenden Befehls gesehen werden:

~~~
vgscan
~~~

vgdisplay zeigt die `Größe` :

~~~
vgdisplay vulcan
~~~

`Schritt 4:`  Erstellung eines logischen Volumens. An dieser Stelle muss entschieden werden, wie groß das logische Volumen zu Beginn sein soll. Ein Vorteil von LVM ist die Möglichkeit, die Größe ohne Reboot anpassen zu können.

In unserem Beispiel wünschen wir uns ein 300GB großes Volumen mit dem Namen spock innerhalb des LVM namens vulcan:

~~~
lvcreate -n spock --size 300g vulcan
~~~

`Schritt 5:`  Formatieren des Volumens (bitte habe etwas Geduld, dieser Vorgang kann längere Zeit in Anspruch nehmen):


~~~
mkfs.ext4 /dev/vulcan/spock
~~~

`Schritt 6:` 

~~~
mkdir /media/spock/
~~~

Um das Volumen während des Bootvorgangs einzubinden, muss fstab mit einem Texteditor angepasst werden. 

~~~
mcedit /etc/fstab
~~~

Die Verwendung von `/dev/vulcan/spock`  ist bei einem LVM der Verwendung von UUID-Nummern vorzuziehen, da es damit einfacher ist das Dateisystem zu klonen (keine UUID-Kollisionen). Besonders mit einem LVM können Dateisysteme mit gleicher UUID-Nummer erstellt werden (Musterbeispiel: Snapshots).

~~~
/dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2
~~~

`Optional:`  Der Besitzer des Volumens kann geändert werden, sodass andere Nutzer Lese- bzw. Schreibzugang zum LVM haben:

~~~
chown root:users /media/spock
~~~

~~~
chmod 775 /media/spock
~~~

Ein einfacher LVM sollte nun erstellt sein.

### Größenänderung eines Volumens

`Wir empfehlen die Verwendung einer Live-ISO, um Partitionsgrößen zu ändern. Obwohl die Vergrößerung einer Partition des laufenden Systems ohne Fehler durchgeführt werden kann, ist dies bei der Verkleinerung einer Partition nicht der Fall. Anomalien können zu einem Datenverlust führen, vor allem wenn die Verzeichnisse`  **`/ (root)`**  `oder`  **`/home`**  `betroffen sind.`

#### Beispiel einer Vergrößerung einer Partition von 300GB auf 500GB:

~~~
umount /media/spock/
~~~

~~~
lvextend -L+200g /dev/vulcan/spock
~~~

Befehl, der die Größe des Dateisystems ändert:

~~~
e2fsck -f /dev/vulcan/spock
~~~

~~~
resize2fs /dev/vulcan/spock
~~~

~~~
mount /media/spock
~~~

#### Beispiel einer Verkleinerung einer Partition von 500GB auf 280GB:

~~~
umount /media/spock/
~~~

Befehl, der die Größe des Dateisystems festlegt:

~~~
e2fsck -f /dev/vulcan/spock
~~~

~~~
resize2fs /dev/vulcan/spock 280g
~~~

Danach wird die Partitionsgröße geändert.

~~~
lvreduce -L-220g /dev/vulcan/spock
~~~

~~~
resize2fs /dev/vulcan/spock
~~~

~~~
mount /media/spock
~~~

#### LVM mit einem GUI-Programm verwalten

`system-config-lvm`  bietet eine graphische Oberfläche zur Verwaltung von LVMs. Das Programm wird als root ausgeführt:

~~~
apt-get install system-config-lvm
man system-config-lvm `# Pflichtlektüre` 
~~~

#### Weitere Informationen:

+ [Debian Administration - Eine einfache Einführung in die Arbeit mit LVM](http://www.debian-administration.org/articles/410)  (Englisch)

+ [Verwaltung von logischen Volumen (IBM)](http://www.ibm.com/developerworks/linux/library/l-lvm2/)  (Englisch)

+ [Größenänderung von Linuxpartitionen - Teil 2 (IBM)](http://www.ibm.com/developerworks/linux/library/l-resizing-partitions-2/index.html)  (Englisch)

+  [Handbuch zur LVM-Verwaltung (Red Hat)](http://docs.google.com/viewer?a=v&amp;q=cache:1RMpacheCBcJ:www.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/5.4/pdf/Logical_Volume_Manager_Administration.pdf+%22Logical+Volume+Manager+Administration+%22&amp;hl=en&amp;pid=bl&amp;srcid=ADGEEShRiptIjzsnPNsCs4RgyUFNWkYcrDc3SkBSD6cTq39D6wye5JM3tP_ehcn37I5VWs84I_HI45rvG-n6YG4R2fE8hqDByq-KPhNEkha4zwphrR7QIUVnUz6omwY85e-ZEXX723Js&amp;sig=AHIEtbSJyxEst6Wue7_1_TeDYwB480azEw)  (Englisch)

+  [Logical Volume Manager (Linux) - Wikipedia](http://de.wikipedia.org/wiki/Logical_Volume_Manager)  (Deutsch)

+  [Aufsetzen eines LVM zur Datenspeicherung](http://thelinuxexperiment.com/guinea-pigs/jon-f/setting-up-an-lvm-for-storage/)  (Englisch)

+  [Erstellen eines LVM unter Linux](http://linuxhelp.blogspot.com/2005/04/creating-lvm-in-linux.html)  (Englisch)

+  [Aufsetzen eines Linux-LVM](http://www.linuxconfig.org/Linux_lvm_-_Logical_Volume_Manager)  (Englisch)

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
