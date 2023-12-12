% Partitionierung von "Logical Volume"

## LVM-Partitionierung - Logical Volume Manager

**Es folgt nun eine Basiseinführung.** Es liegt am geschätzten Leser, sich tiefer in die Materie einzuarbeiten. Bitte beachten sie die jeweilige man-Page. Weitere Informationsquellen finden sich am Ende dieses Textes - die Liste erhebt keinen Anspruch auf Vollständigkeit.

Das Arbeiten mit *Logical Volumes* ist viel einfacher als die meisten User glauben. Die beste Eigenschaft von LVM ist, dass Änderungen wirksam werden ohne dafür das System neu starten zu müssen. *Logical Volumes* können mehrere Festplatten umspannen und sind skalierbar. Dies unterscheidet sie von anderen Methoden der Festplattenpartitionierung.

Mit drei Grundbegriffen sollte man vertraut sein:

+ **Physisches Volumen (Physical Volume) [PV]:**  Diese sind die physischen, real vorhandenen, Festplatten oder Partitionen wie zum Beispiel `/dev/sda` oder `/dev/sdb1` und werden zum Einbinden/Aushängen verwendet. Mit LVM können mehrere physische Volumen in Volumengruppen zusammengefasst werden.

+ **Volumengruppe (Volume Group) [VG]:**  Eine Volumengruppe besteht aus *Physischen Volumen* und ist der Speicherort von *Logischen Volumen*. Eine Volumengruppe kann als "virtuelles Laufwerk" gesehen werden, das aus *Physischen Volumen* zusammengesetzt ist. Zum Verständnis einige Beispiele:

  + Mehrere Speichergeräte (z. B. Festplatten, SSDs, M2-Disks, externe USB-Festplatten usw.) können zu einer Volumengruppe (einem virtuellen Laufwerk) zusammengefasst werden.

  + Mehrere Partitionen eines Speichergerätes können zu einer Volumengruppe (einem virtuellen Laufwerk) zusammengefasst werden.

  + Eine Kombination aus den beiden vorgenannten Möglichkeiten. Z. B. drei SSDs, wovon von der ersten nur zwei Partitionen und die beiden anderen vollständig in der Volumengruppe zusammengefasst werden.

+ **Logisches Volumen (Logical Volume) [LV]:**  Logische Volumen werden inerhalb einer *Volumengruppe* erstellt und in das System eingebunden. Man kann sie auch als "virtuelle" Partitionen verstehen. Sie sind dynamisch veränderbar, können in der Größe verändert, neu erstellt, entfernt und verwendet werden. Ein logisches Volumen kann sich innerhalb der Volumengruppe über mehrere physische Volumen erstrecken.

### Sechs Schritte zu Logical Volumes

> **Achtung**  
> Wir gehen in unserem Beispiel von nicht partitionierten Festplatten aus. Zu beachten ist: Falls alte Partitionen gelöscht werden, gehen alle Daten unwiederbringlich verloren.

Als Partitionierungsprogramm werden cfdisk oder gdisk benötigt, da zur Zeit GParted bzw. der KDE-Partitionsmanager (partitionmanager) das Anlegen von *Logical Volumes* nicht unterstützen. Siehe auch die Handbuchseiten:  
[Partitionieren mit cfdisk (msdos-MBR)](0314-part-cfdisk_de.md#partitionieren-mit-fdisk)  
[Partitionieren mit gdisk (GPT-UEFI)](0313-part-gdisk_de.md#partitionieren-mit-gdisk)

Alle folgenden Befehle und Aktionen erfordern root-Rechte.

1. Erstellung einer Partitionstabelle

   ~~~
   cfdisk /dev/sda
   n  -> erstellt eine neue Partition auf dem Laufwerk
   p  -> diese Partition wird eine primäre Partition
   1  -> die Partition erhält die Nummer 1
         "size allocation" setzt den ersten und letzten
         Zylinder auf Default-Werte. Drücke ENTER, um
         das gesamte Laufwerk zu umspannen
   t  -> wählt den zu erstellenden Partitionstyp
   8e -> der Hex-Code für eine Linux-LVM
   W  -> schreibt Veränderungen auf das Laufwerk.
   ~~~

   Der Befehl `W` schreibt die Partitionierungstabelle. Falls bis zu diesem Punkt ein Fehler gemacht wurde, kann das vorhandene Partitionierungs-Layout wieder hergestellt werden. Zu diesen Zweck gibt man den Befehl `q` ein, cfdisk beendet sich ohne Schreibvorgang, und alles bleibt wie es zuvor war.

   Falls die Volumengruppe mehr als ein Physische Volumen (Laufwerk) umspannen soll, muss obiger Vorgang auf jedem physischen Volumen durchgeführt werden.

2. Erstellen eines physischen Volumens [PV]

   ~~~
   pvcreate /dev/sda1
   ~~~

   Der Befehl erstellt auf der ersten Partition der ersten Festplatte das PV.  
   Dieser Vorgang wird nach Bedarf auf jeder Partition wiederholt.

3. Erstellen einer Volumengruppe [VG]

   Nun erzeugen wir die VG mit dem Namen **vulcan** und ordnen ihr drei PV zu (in unserem Beispiel die Laufwerke /dev/sda1 /dev/sdb1 /dev/sdc1):

   ~~~
   vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1
   ~~~

   Falls dieser Schritt korrekt durchgeführt wurde, kann das Ergebnis in der Ausgabe folgenden Befehls gesehen werden:

   ~~~
   vgscan
   ~~~

   vgdisplay zeigt die Größe mit:

   ~~~
   vgdisplay vulcan
   ~~~

4. Erstellung eines logischen Volumens [LV]

   An dieser Stelle muss entschieden werden, wie groß das LV zu Beginn sein soll. Ein Vorteil von LVM ist die Möglichkeit, die Größe ohne Reboot anpassen zu können.

   In unserem Beispiel wünschen wir uns ein 300GB großes LV mit dem Namen **spock** innerhalb der VG Namens **vulcan**:

   ~~~
   lvcreate -n spock --size 300g vulcan
   ~~~

5. Formatieren des LV

   Bitte habe etwas Geduld, dieser Vorgang kann längere Zeit in Anspruch nehmen.

   ~~~
   mkfs.ext4 /dev/vulcan/spock
   ~~~

6. Einbindung des LV

   Erstellen des Mountpoints mit

   ~~~
   mkdir /media/spock/
   ~~~

   Um das LV während des Bootvorgangs einzubinden, muss die Datei `/etc/fstab` mit einem Texteditor angepasst werden.  
   Die Verwendung von *"/dev/vulcan/spock"*  ist bei einem LVM der Verwendung von UUID-Nummern vorzuziehen, da es damit einfacher ist das Dateisystem zu klonen (keine UUID-Kollisionen). Besonders mit einem LVM können Dateisysteme mit gleicher UUID-Nummer erstellt werden (Musterbeispiel: Snapshots).

   ~~~
   mcedit /etc/fstab
   ~~~

   und dann die folgende Zeile entsprechend unseres Beispiels einfügen.

   ~~~
   /dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2
   ~~~

   Optional:  
   Der Besitzer des LV kann geändert werden, sodass andere Nutzer Lese- bzw. Schreibzugang erhalten:

   ~~~
   chown root:users /media/spock
   chmod 775 /media/spock
   ~~~

Die Schritte 4 bis 6 wiederholen wir nun für das weitere LV **kirk**.

Ein einfacher LVM sollte nun erstellt sein.

### Größenänderung eines Volumens

> Achtung  
> Immer zuerst eine Datensicherung vornehmen.

Wir empfehlen die Verwendung einer Live-ISO, für die Größenänderung. Obwohl die Vergrößerung eines Volumens im laufenden System ohne Fehler durchgeführt werden kann, ist dies bei der Verkleinerung nicht der Fall. Anomalien können zu einem Datenverlust führen, vor allem wenn die Verzeichnisse `/` (root) oder `/home` betroffen sind.

**Beispiel einer Vergrößerung**

Das LV *spock* soll von 300GB auf 500GB vergrößert werden.  
Wir prüfen zuerst, ob genug freier Speicherplatz vorhanden ist.  
`vgdisplay` gibt Auskunft.

~~~
vgdisplay vulcan
[...]
Free PE / Size      170890 / 667,50 GiB
[...]
~~~

Es ist genug freier Speicherplatz für unser Vorhaben vorhanden.  
Wir können mit der Arbeit beginnen.  
Aushängen des LV:

~~~
umount /media/spock/
~~~

> Achtung  
> Hängen Sie nie Ihr root-Dateisystem im laufenden Betrieb aus.

Erweitern des LV und seines Dateisystems:

~~~
lvextend -L+200g --resizefs /dev/vulcan/spock
~~~

Dem Befehl *"lvextend"* ist als Option der Wert für die Größen**änderung** anzugeben und nicht die gewünscht Gesamtgröße.  
Anschließend wird mit der Option *"--resizefs"* zuerst das Dateisystem überprüft und dann an die neue Größe des LV angepasst.

Zuletzt hängen wir das LV wieder ein.

~~~
mount /media/spock
~~~

Die Vergrößerung eines LV, sogar für das **"/"** (root) Dateisystem, ist auch im laufenden Betrieb möglich. Lediglich die beiden Befehle `unmount` und `mount` entfallen. Allerdings wird dann kein Dateisystemcheck durchgeführt.

Wenn Sie das root-Dateisystem überprüfen wollen, nutzen Sie den Kernel-Kommandozeilen-Parameter `fsck.mode=force` beim Boot-Vorgang.

**Beispiel einer Verkleinerung**

Das LV *spock* wird von 500GB auf 280GB verkleinert:

~~~
umount /media/spock/
~~~

Die Größe des Dateisystems verringern:

~~~
e2fsck -f /dev/vulcan/spock
resize2fs /dev/vulcan/spock 280g
~~~

Danach wird das LV geändert.

~~~
lvreduce -L-220g /dev/vulcan/spock
resize2fs /dev/vulcan/spock
mount /media/spock
~~~

Auch hier ist dem Befehl *"lvreduce"* als Option der Wert für die Größen**änderung** anzugeben.  
Der erneute *"resize2sf"*-Befehl passt das Dateisystem exakt an die Größe des LV an.

### LVM mit einem GUI-Programm verwalten

Gparted bietet die Möglichkeit zur Verwaltung von bereits angelegten Logical Volumes. Das Programm wird als root ausgeführt.

### Weitere Infos

[Logical Volume Manager - Wikipedia](https://de.wikipedia.org/wiki/Logical_Volume_Manager)  (Deutsch)  
[Working with logical volumes #1](https://thelinuxexperiment.com/working-with-logical-volumes-part-1/)  (Englisch)  
[Working with logical volumes #2](https://thelinuxexperiment.com/working-with-logical-volumes-part-2/)  (Englisch)  
[Working with logical volumes #3](https://thelinuxexperiment.com/working-with-logical-volumes-part-3/)  (Englisch)

<div id="rev">Zuletzt bearbeitet: 2023-12-12</div>
