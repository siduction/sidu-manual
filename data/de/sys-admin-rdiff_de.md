
<div class="divider" id="rdiff"></div>

## Systemsicherung mit rdiff-backup

rdiff-backup ist eine Applikation zur Dateisicherung, welche unter verschiedenen *nix-Systemen eingesetzt werden kann.

 **`Wenn nicht anders angegeben, werden die Befehle als Root in einer Konsole gestartet.`**
#### rdiff-backup

* besonders geeignet zur Wiederherstellung des Systems nach einer missglückten Systemaktualisierung, bei Problemen nach einer Aktualisierung des Kernels oder einfach zur Wiederherstellung älterer Versionen einzelner Dateien.

* wie bei rsync wird nur gesichert, was verändert wurde (sehr schneller Sicherungsvorgang!)

* eine Sicherungsgeschichte (verschiedene Sicherungsebenen) wird angelegt - das bedeutet, es kann auch eine Datei wiederhergestellt werden, welche drei Wochen zuvor am Arbeitssystem bereits gelöscht wurde!

* ein Backup kann im Netzwerk über eine sichere Verbindung durchgeführt werden (Verwendung von ssh).

* ein Backup von eingehängten Partitionen kann angelegt werden (dies ermöglicht ein einfaches, automatisches und tägliches Backup, ohne manuell eine Partition aushängen zu müssen).

* nach einem Festplattentod können sämtliche Daten auf einer neuen Festplatte wiederhergestellt werden

* skaliertes Backup großer Netzwerke (problemlos in Linux-Netzwerken, Windows-Netzwerke sind komplexer zu handhaben), benutzt auch in kommerziellen Umgebungen

* es ist eine Befehlszeilenanwendung, womit es besonders geeignet ist, um automatisierte Backups einzurichten (z. B. mittels eines Bash-Scripts, welches über cron aufgerufen wird)

* kann mit Angaben zu Dateibesitzer und Dateiberechtigungen umgehen wie auch mit symbolischen Verknüpfungen (und noch viel mehr), sodass nach einer Rückspielung von Daten ein exaktes Abbild des ursprünglichen Zustands wiederhergestellt wird.

#### Was benötigt wird

rdiff-backup legt eine unkomprimierte Kopie der Dateien, welche gesichert werden, an, und es wird eine Backup-"Geschichte", ein inkrementelles Backup angelegt. Somit muss der Speicherplatz für das Backup größer sein als die Größe der Dateien, welche gesichert werden. Wenn z. B. 100 GB gesichert werden sollen, sollte ein Speicherplatz von etwa 120 GB vorhanden sein, am besten auf einer eigenen Festplatte. Der benötigte Speicherplatz kann natürlich variieren.

#### Einrichtung

Gehen wir von folgenden Spezifikationen des PCs aus:

* eine Festplatte mit 100 GB (sda), sda1 ist die Rootpartition, sda5 ist die Partition für Musik und andere Dateien, sda6 ist die Swap-Partition.

* eine extra Festplatte (sdb) mit 200 GB, welche nicht im Produktivsystem aktiv ist und die nach sdb1 eingebunden wird. Diese Festplatte wird für Sicherheitsbackups verwendet.

* Die IP-Adresse ist 192.168.0.1

Als erstes wird rdiff-backup installiert:

~~~
# apt-get install rdiff-backup
~~~

Obwohl nun bereits Backups von jedem Verzeichnis angelegt werden können, wollen wir zeigen, wie ganze Partitionen gesichert werden können: gesichert werden sollen sda1 und sda5 (nicht sda6). Als erstes legen wir Verzeichnisse an, wohin das Backup gespielt werden soll:

~~~
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/root
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/sda5
~~~

Die IP-Adresse wird angegeben für den Fall, dass von einem anderen Computer ebenfalls Backups auf dieser Festplatte gespeichert werden sollen (siehe unten).

#### Das Backup

rdiff-backup verwendet folgende Syntax: `rdiff-backup Quellverzeichnis Zielverzeichnis` . Zu beachten: es werden immer Verzeichnisnamen, nicht Dateinamen angegeben!

Um ein Backup von sda5 anzulegen, wird folgender Befehl eingegeben:

~~~
# rdiff-backup /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5
~~~

Um ein Backup der Root-Partition anzulegen, wird folgender Befehl eingegeben::

~~~
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root
~~~

Fehlermeldungen mit "AF_UNIX path too long" können ignoriert werden. Der Backupvorgang kann beim ersten Mal längere Zeit beanspruchen, da die gesamte Partition gesichert wird. Zu beachten ist auch, dass /tmp nicht gesichert wird, da dieses Verzeichnis ständigen Veränderungen unterworfen ist. Ebensowenig werden /proc und /sys gesichert, da diese Verzeichnisse keine reellen Dateien beinhalten. Auch werden eingebundene Datenträger nicht gesichert, da in diesem Falle sdb1 ebenfalls gesichert würde, was in einer unendlichen Schleife enden könnte! Um dies zu verhindern, können andere eingebundene Datenträger separat gesichert werden.

Der Grund, warum '/proc/*' und nicht einfach '/proc' gesetzt wurde, liegt darin, dass damit ein Backupverzeichnis /proc angelegt, der Inhalt jedoch ignoriert wird. Gleiches trifft auf /tmp, /sys und alle anderen Mountpunkte zu.

Das bedeutet, nach einer Zerstörung der Root-Partition kann ein vollständiges Backup wieder eingespielt werden, die Mountpunkte /tmp, /proc, /sys und alle weiteren originalen Mountpunkte werden wieder angelegt (genau, wie es sein soll). Wenn z. B. /tmp beim Start von X nicht existieren würde, könnte ein Problem gegeben sein (siehe "man rdiff-backup" für mehr Optionen bezüglich --exclude und --include).

#### Wiederherstellung von Verzeichnissen aus dem Backup

rdiff-backup verwendet folgende Syntax:

~~~
rdiff-backup -r from-when source-dir dest-dir
~~~

from-when: von wann  
source-dir: Quellverzeichnis  
dest-dir: Zielverzeichnis

Angenommen, das Verzeichnis /media/sda7/photos wurde irrtümlich gelöscht, so kann es mit folgendem Befehl wiederhergestellt werden:

~~~
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5/photos /media/sda5/photos
~~~

Die Option "-r now" bedeutet eine Wiederherstellung des letzten Backups. Wenn nun periodisch (via crontab etwa) ein Backup erstellt und erst einige Tage nach der Löschung bemerkt wurde, dass das Verzeichnis photos fehlt, muss ein älteres Backup zur Wiederherstellung herangezogen werden (nicht mit der Option "now"). Ein anderes Anwendungsgebiet wäre die Wiederherstellung einer älteren Version einer gegebenen Datei.

Zur Wiederherstellung eines drei Tage alten Backups wird verwendet:"-r 3D" ... aber, wie in der manpage steht, soll beachtet werden:

 `"3D" refers to the instant 72 hours before the present, and if there was no backup made at that time, rdiff-backup restores the state recorded for the previous backup. For instance, in the above case, if "3D" is used, and there are only backups from 2 days and 4 days ago, the directory would be restored as it was 4 days ago (so you have to think about it before you restore).`
Sinngemäße Übersetzung:

 *"3D" bezieht sich auf genau 72 Stunden vor der Jetztzeit, und wenn zu diesem Zeitpunkt kein Backup angelegt wurde, wird das letzte Backup davor zur Wiederherstellung herangezogen. Wenn zum Beispiel im obigen Fall "3D" verwendet wird und nur Backups vorhanden sind, welche 2 Tage und 4 Tage alt sind, würde das 4 Tage alte Verzeichnis wiederhergestellt werden (eine Wiederherstellung benötigt also eine genaue Planung vor der Durchführung).* 

Folgender Befehl listet Datum und Zeitpunkt der letzten Backups von sda5:

~~~
# rdiff-backup -l /media/sdb1/rdiff-backups/192.168.0.1/sda5
~~~

#### Wiederherstellung von Partitionen

Es können auch ganze Partitionen und Mountpunkte wiederhergestellt werden, denn schließlich ist ein Mountpunkt auch nur ein Verzeichnis.

 **`WARNUNG: Das Root-Verzeichnis darf nicht wiederhergestellt werden, wenn in dieses gebootet wurde! Mit einem einzigen Befehl gehen alle Dateien auf allen Partitionen inklusive aller Backups auf weiteren Festplatten verloren!! rdiff-backup führt exakt das durch, welche Anweisung es bekommen hat ... Wenn das Backup der Root-Partition leere Mountpunkte hat und Anweisung lautet, diese Mountpunkte ebenfalls wiederherzustellen, wird alles in den gegebenen Mountpunkten gelöscht, um genau nach Anweisung leere Mountpunkte zu erstellen.`**
 
Um sda5 vom letzten Backup wiederherzustellen, genügt folgender Befehl:

~~~
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5 /media/sda5
~~~

#### Wiederherstellung der Root-Partition

Die Wiederherstellung der Root-Partition ist keine einfache, triviale Aufgabe. Die Root-Partition darf nicht wiederhergestellt werden, während sie eingebunden ist (siehe Warnung oben). Aber es ist durchaus sinnvoll, in der Lage zu sein, die Root-Partition wiederherstellen zu können. Denn eine System- oder Kernelaktualisierung kann auch mal misslingen, und es ist beruhigend zu wissen, dass das System so neu eingespielt werden kann, wie es vor den Problemen war. Der Zeitaufwand beträgt nur etwa 20 Minuten.

Eine Möglichkeit, die Root-Partition wiederherzustellen, ist, in eine weitere Linux-Partition zu booten, so eine auf der Festplatte vorhanden ist. Danach kann die gewünschte Partition wiederhergestellt werden, da sie nicht als Root-Partition eingebunden ist. Nach Wiederherstellung der Partition kann in sie gebootet werden, und sie wird exakt so aussehen wie zu dem Zeitpunkt, zu dem das Backup angelegt wurde. Dies ist die bei weitem einfachste Methode der Systemwiederherstellung.

Eine weitere Möglichkeit, die Root-Partition wiederherzustellen, ist, mit der siduction Live-CD zu booten und die Wiederherstellung mit diesem System durchzuführen. rdiff-backup ist auf der siduction Live-CD enthalten. Falls die siduction Live-CD kein rdiff-backup enthalten würde, kann in die Grub-Befehlszeile die Option "unionfs" eingegeben werden, wonach weitere Pakete auch im Live-CD-Modus installiert werden können. Im gegebenen Fall sind die Befehle:

~~~
$ sudo su
# wget -O /etc/apt/sources.list http://siduction.org/files/misc/sources.list
# apt-get update
# apt-get install rdiff-backup
~~~

#### Und jetzt die Wiederherstellung:

~~~
# mount /dev/sda1 /media/sda1
# mount /dev/sdb1 /media/sdb1
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1
~~~

Anmerkung: Bei Nutzung einer anderen Live-CD als siduction und im Falle, dass diese klik unterstützt, kann rdiff-backup unter Verwendung von klik mit folgendem Befehl installiert werden:

~~~
$ sudo ~/.zAppRun ~/Desktop/rdiff-backup_0.13.4-5.cmg rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1
~~~

Es ist empfohlen, dass die Wiederherstellung einer Root-Partition mit rdiff-backup getestet wird, um im Ernstfall nicht auf unerwartete Probleme zu stoßen.

Falls die Festplatte gewechselt oder neu formatiert wurde, müssen UUIDs oder Labels in der Datei `/boot/grub/menu.lst (grub-legacy) bzw. in Dateien des Verzeichnisses /etc/grub.d (grub2)`  sowie in der Datei `/etc/fstab`  entsprechend angepasst werden. Am einfachsten erhält man die Information, auf welche Weise menu.lst und fstab angepasst werden müssen, mit diesem Root-Befehl:

~~~
blkid
~~~

#### Sicherung weiterer PCs

Es können Daten weiterer Computer auf dem lokalen PC gesichert werden, wenn der lokale PC sich mittels ssh zu den anderen Computern verbinden kann (und natürlich Speicherplatz vorhanden ist). Der ssh-Server (sshd) muss am entfernten Computer laufen. Der andere Computer muss sich nicht im lokalen Netzwerk (LAN) befinden, er kann sich irgendwo in der Welt befinden.

Angenommen, der entfernte Computer hat folgende Spezifikationen:


1) Eine Festplatte (sda) mit 100 GB, die mit folgenden Mountpunkten in Verwendung ist:  
2) sda1 ist die Root-Partition  
3) sda5 speichert temporäre Dateien, welche nicht gesichert werden sollen  
4) sda6 ist die Swap-Partition  
5) die IP-Adresse ist 192.168.0.2

Anmerkung: zwei Festplatten mit je 100 GB können normalerweise nicht auf eine Festplatte mit 200 GB gesichert werden, wenn rdiff-backup verwendet wird, da der Platz für inkrementelle Backups fehlen würde. Da jedoch sda5 des entfernten Computers nicht gesichert werden soll und - auch wenn man sich nicht darauf verlassen soll - Partitionen in der Regel nicht zu 100 Prozent voll sind, kann man damit spekulieren, dass genug Speicherplatz für das Backup vorhanden ist. Es soll aber berücksichtigt werden, dass jedes Backup mehr Speicherplatz in Anspruch nimmt, da inkrementelle Dateien zugefügt werden.

rdiff-backup kann beauftragt werden, nur Backups zu behalten, die nicht älter als einen Monat sind (siehe unten). Dies nimmt selbstverständlich weniger Speicherplatz in Anspruch, als wenn Daten über Jahre hinweg gesichert werden. Im letzteren Fall muss selbstverständlich der Speicherplatz vorhanden sein, um Jahre von Daten inkrementell sichern zu können.

Als erstes muss rdiff-backup am entfernten Computer installiert werden (jeder Computer, dessen Daten gesichert werden sollen, muss - wie auch der Backup-Server - rdiff-backup installiert haben).

Um den entfernten Computer am lokalen PC zu sichern, wird am lokalen PC (192.168.0.1) gestartet `(beachte den doppelten Doppelpunkt ::)` :

~~~
# mkdir /media/sdb1/rdiff-backups/192.168.0.2/root
rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' 192.168.0.2::/ /media/sdb1/rdiff-backups/192.168.0.2/root
~~~

Um nun ein Verzeichnis auf dem entfernten Computer wiederherzustellen, wird der Wiederherstellungsprozess entweder am lokalen oder am entfernten Computer in Gang gesetzt.

Auf diese Weise wird das Verzeichnis /usr/local/games auf dem entfernten Computer wiederhergestellt, indem der Prozess am entfernten Computer initiiert wird:

~~~
# rdiff-backup -r now 192.168.0.1::/media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games /usr/local/games
~~~

Auf diese Weise wird das Verzeichnis /usr/local/games auf dem entfernten Computer wiederhergestellt, indem der Prozess am lokalen PC initiiert wird:

~~~
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games 192.168.0.2::/usr/local/games
~~~

Die gleiche Syntax wird verwendet, wenn die Root-Partition von einer Live-CD wiederhergestellt wird. (Falls der entfernte Computer durch eine Live-CD gebootet wurde: siehe oben.)

#### Automatisierung von Backups:

Wenn Backups von anderen PCs auf dem eigenen, lokalen gespeichert werden, sollte zunächst ein passwortfreier ssh-Login unter Verwendung von ssh-Schlüsseln (ssh-keys) eingerichtet werden.

**`Zur Beachtung: dies bedeutet passwortfreie ssh-Logins als root. Dies kann beschränkt werden, dass nur Befehle von rdiff-backup ausgeführt werden, aber diese Vorgehensweise ist außerhalb des Rahmens dieser Anleitung, siehe daher das Handbuchkapitel`**  
[SSH: Sicherheit](ssh-de.htm#ssh-s) .

Wir setzten absolute Vertrauenswürdigkeit voraus und zeigen die einfachste Möglichkeit, wie ein passwortfreier ssh-Login angelegt werden kann.

Vom lokalen PC ist der Befehl:

~~~
# [ -f /root/.ssh/id_rsa ] || ssh-keygen -t rsa -f /root/.ssh/id_rsa
~~~

Für leere Passwörter wird zweimal die Entertaste gedrückt. Danach:

~~~
# cat /root/.ssh/id_rsa.pub | ssh 192.168.0.2 'mkdir -p /root/.ssh;\ <!--dunno if this wrong-->
> cat - >>/root/.ssh/authorized_keys2'
~~~

Das Root-Passwort wird angefragt.

Jetzt kann eine ssh-Verbindung als root zum entfernten Computer aufgebaut werden, ohne ein Passwort eintippen zu müssen, womit rdiff-backup nun automatisiert werden kann.

Als nächstes wird ein Bash-Script geschrieben, welches alle rdiff-backup-Befehle enthält. Dieses Bash-Script kann folgendermaßen aussehen:

~~~
 #!/bin/bash
RDIFF=/usr/bin/rdiff-backup
echo
echo "=======Backing up 192.168.0.1 root======="
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root
echo "(and purge increments older than 1 month)"
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/root
echo
echo "=======Backing up 192.168.0.1 mount sda5======="
${RDIFF} --ssh-no-compression --exclude /media/sda5/myjunk /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5
echo "(and purge increments older than 1 months)"
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/sda5
echo
echo "=======Backing up 192.168.0.2 root======="
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' --exclude '/mnt/*/*' 192.168.0.2::/media/sdb1/rdiff-backups/192.168.0.2/root
echo "(and purge increments older than 1 months)"
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.2/root 
~~~

Wir nennen das Bash-Script "myrdiff-backups.bash" und speichern es unter /usr/local/bin auf unserem lokalen PC, der als Backup-Server dient, und machen es ausführbar. Das Skript wird nun in einem Testlauf ausgeführt, um sicherzugehen, dass es funktioniert.

Zu guter Letzt lassen wir cron unser Bash-Script jeden Abend um 20 Uhr ausführen. Um dies der crontab von root zu übertragen, muss folgendes gemacht werden:

~~~
# crontab -e
~~~

Es wird folgende Zeile eingefügt:

~~~
0 20 * * * /usr/local/bin/myrdiff-backups.bash
~~~

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
