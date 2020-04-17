<div class="divider" id="disknames"></div>

## Namen der Festplatten

#### **`Bitte BEACHTEN: bezüglich der Benennung von Speichergeräten`**  [bitte das Kapitel zu UUID, Partitionsbezeichnung und fstab zu Rate ziehen, da siduction in der Grundeinstellung Benennung nach UUID verwendet](part-uuid-de.htm#uuid) .

### Aktuelle Benennungspraxis

#### Für Festplatten

Seit udev den Universal Unique Identifier (UUID) übernommen hat und seit den letzten Linux-Kerneln nutzen alle Festplatten und Laufwerke eine Benennung, die aus einer Kombination von drei Buchstaben und Nummern besteht, welche zum Beispiel `sda`  lautet, und für Partitionen das Schema `sdaX`  aufweist, wobei X eine Zahl ist.

Welcher Standard auch immer eingesetzt wird (PATA (IDE), SATA (Serial ATA), SCSI oder SSD, einzig der dritte Buchstabe unterscheidet nun die verschiedenen Festplatten oder Laufwerke:`/dev/sda1, /dev/sdb1, /dev/sdc1, /dev/sdd1`  usw.

Informationen über die Geräte erhält man leicht von einem Informationsfenster (Pop-Up), wenn man mit der Maus auf das Icon eines Geräts auf dem Desktop geht. Dies funktioniert sowohl von der Live-CD als auch bei einem installierten siduction.

Wir empfehlen die Erstellung einer Tabelle (manuell oder generiert), welche die Details aller Geräte enthält. Dies kann sehr hilfreich sein, falls Probleme auftreten.

Die Datei `/etc/fstab`  der Live-CD und einer installierten Version enthält die Information `/dev/ sdaX`  in einer kommentierten Informationszeile (innerhalb einer eckigen Klammer) oberhalb der eigentlichen Gerätezeile, was so aussieht:

~~~
# added by siduction [ /dev/sdd1 , no label]
UUID=2ae950df-7d72-4d9b-a71a-bad1eb2d4f6a / ext4 defaults,errors=remount-ro,relatime 0 1
~~~

#### Für Partitionen

Wie oben angesprochen, wird für Partitionen der Bezeichner für `/dev/disk`  mit einer Nummer abgeschlossen. 

Es gibt folgende Partitionstypen: primäre, erweiterte und logische. Die logischen Partitionen befinden sich innerhalb der erweiterten Partition. Es sind maximal vier primäre bzw. drei primäre und eine erweiterte Partition anlegbar. Die erweiterte Partition kann bis zu elf logische Partitionen enthalten.

Der aufkommende Standard GUID Partition Table (GPT), der Teil des UEFI-Standards ist, wird den MBR ersetzen und erlaubt Platten/Partitionen größer als 2 TByte und eine theoretisch unbegrenzte Anzahl primärer Partitionen. Weitere Informationen dazu gibt es in der [Wikipedia](http://en.wikipedia.org/wiki/GUID_Partition_Table) 

Primäre oder erweiterte Partitionen erhalten eine Bezeichnung zwischen 1 und 4 (zum Beispiel sda1 bis sda4). Logische Partitionen sind immer gebündelt und Teil einer erweiterten Partition. Mit libata können maximal elf logische Partitionen definiert werden, und ihre Bezeichnungen beginnen mit Nummer 5 (sda5) und enden höchstens mit Nummer 15 (sda15).

#### Einige Beispiele

`/dev/sda5`  kann nur eine logische Partition sein (in diesem Fall die erste logische auf diesem Gerät). Sie befindet sich auf der ersten SATA- oder IDE-Festplatte des Computers (abhängig von der BIOS-Konfiguration).

`/dev/sdb3`  kann nur eine primäre oder erweiterte Partition sein. Der Buchstabe "b" indiziert, dass diese Partition sich auf einem anderen Gerät befindet als die Partition des ersten Beispiels, welche den Buchstaben "a" enthält.

### Frühere und jetzt veraltete Bezeichnung von IDE-Laufwerken

Auf älteren Linux-Systemen wurden IDE-Laufwerke (PATA) von jenen, welche den aktuellen Standard nutzten, durch `hdaX`  anstelle von sdaX unterschieden.

<div class="divider" id="partition"></div>

## Partitionieren mit Cfdisk

 **`Für normalen Gebrauch empfehlen wir, das Dateisystem ext4 zu benutzen. Ext4 ist das Standard-Dateisystem von siduction und gut betreut.`**
In einer Konsole wird cfdisk als root gestartet (nach "su" ist die Eingabe des root-Passworts gefordert):

~~~
su
cfdisk /dev/sda
~~~

#### Die Bedienoberfläche

Im ersten Bildschirm zeigt cfdisk die aktuelle Partitionstabelle mit den Namen und einigen Informationen zu jeder Partition. Am unteren Ende des Fensters befinden sich einige Befehlsschalter. Um zwischen den Partitionen zu wechseln, benutzt man die Pfeiltasten auf, ab. Um Befehle auszuwählen, benutzt man die Pfeiltasten rechts, links.

#### Löschen einer Partition

![Delete a partition](../images-de/cfdisk-de/cfdisk0-de.png "Löschen einer Partition") 

Um eine Partition zu löschen, wird sie mit den auf-ab-Tasten markiert und folgender Befehl gewählt (auszuwählen mit den Pfeiltasten links-rechts):

~~~
Löschen
~~~

und bestätigt mit

~~~
Enter
~~~

#### Erstellen einer neuen Partition

![Create a new partition](../images-de/cfdisk-de/cfdisk1-de.png "Erstellen einer neuen Partition") 

Zum Erstellen einer neuen Partition wird folgender Befehl gewählt (auszuwählen mit den Pfeiltasten links-rechts):

~~~
Neue
~~~

und mit der Entertaste bestätigt. Es muss dabei zwischen einer  **primären**  oder einer  **logischen**  Partition entschieden werden. Wenn eine logische Partition erstellt werden soll, erstellt cfdisk automatisch eine erweiterte Partition, die dann die logische Partition enthält. Danach muss die Größe der Partition festgelegt werden (in MB). Wenn keine MB-Angaben gemacht werden können, kehrt man mit der ESC-Taste zum Hauptmenü zurück und wählt MB mit dem Befehl:

~~~
Einheiten
~~~

#### Partitionstyp

![Type of a partition 1](../images-de/cfdisk-de/cfdisk2-de.png "Partitionstypen 1") 

Um den Partitionstyp festzulegen, für  **Linux swap**  oder  **Linux** , wird die entsprechende Partition gewählt und folgender Befehl gewählt:

~~~
Typ
~~~

Nun wird eine Liste mit Partitionstypen ausgegeben. Durch Drücken der Leertaste erhält man weitere Partitionstypen auf einer zweiten Seite. Man wählt nun den Hexadezimal-Code des benötigten Partitionstyps ( **Linux swap**  ist Typ  **82** ,  **Linux**  ist Typ  **83** ).

![Type of a partition 2](../images-de/cfdisk-de/cfdisk3-de.png "Partitionstypen 2") 

#### Eine Partition bootfähig machen

Für Linux besteht kein Grund, eine Partition bootfähig zu machen, aber einige andere Betriebssysteme brauchen das. Dabei wird die entsprechende Partition markiert und folgender Befehl gewählt (Anmerkung: bei Installation auf eine externe Festplatte muss eine Partition bootfähig gemacht werden):

~~~
Bootbar
~~~

#### Das Ergebnis auf die Platte schreiben

Wenn alles fertig partitioniert ist, kann das Resultat mit dem Befehl  **"Schreiben"**  gesichert werden. Die Partitionstabelle wird jetzt auf die Platte geschrieben. Ein Fehler bezüglich  **Dos**  kann dabei ignoriert werden.

 **Da damit alle Daten auf der entsprechenden Partition gelöscht werden** , sollte man sich seiner Sache wirklich sicher sein, bevor man mit der Entertaste bestätigt:

~~~
Enter
~~~

![Write the result to disk](../images-de/cfdisk-de/cfdisk4-de.png "Speichern des Resultats auf der Festplatte") 

#### Beenden

Um das Programm nun zu verlassen, wird der Befehl  **Ende**  benutzt. Nach Beendigung von  **cfdisk**  und vor der Installation sollte man auf jeden Fall rebooten, um die Partitionstabelle neu einlesen zu lassen.


<div class="divider" id="formating"></div>

## Formatieren von Partitionen mit Cfdisk

#### Grundlagen

Es gibt für Linux verschiedene Filesysteme, die man benutzen kann. Da wären  **ReiserFs** ,  **Ext2** ,  **Ext4** , und für erfahrenere Anwender  **XFS**  und  **JFS** . ext2 kann von Interesse sein, wenn man von Windows aus zugreifen möchte, da es Windows-Treiber für dieses Dateisystem gibt. [Ext2-Dateisystem für MS Windows (Treiber und englischsprachige Doku)](http://www.fs-driver.org/) .

Für normalen Gebrauch empfehlen wir das Dateisystem ext4. Ext4 ist das Standard-Dateisystem von siduction und gut betreut. 

#### Formatieren

Nach Beendigung von cfdisk wird die Konsole weiter vewendet. Eine Formatierung erfordert  **Rootrechte** . Auf der LiveCD wird man mit  **sudo su**  root. Auf einer Festplatteninstallation reicht  **su**  aus (in diesem Fall wird nach dem Rootpasswort gefragt).

~~~
su
mkfs -t ext4 /dev/sdb1
~~~

Es folgt eine Abfrage, die mit  **ja**  beantwortet wird, wenn man darin sicher ist, dass die richtige Partition formatiert werden soll. Bitte mehrfach überprüfen!

Nach Abschluss der Formatierung muss die Meldung erfolgen, dass ext4 erfolgreich geschrieben wurde. Ist das nicht der Fall, ist bei der Partitionierung etwas schiefgelaufen oder  **sdb1**  ist keine Linux-Partition. Wir überprüfen mit:

~~~
fdisk -l /dev/sdb
~~~

Wenn etwas falsch ist, muss gegebenenfalls noch einmal partitioniert werden.

War die Formatierung erfolgreich, wird - so gewünscht - dieser Ablauf für eine separate  **Home-Partition**  wiederholt.

Zuletzt wird die Swap-Partition formatiert, in diesem Fall sdb3:

~~~
mkswap /dev/sdb3
~~~

Im Anschluss wird die Swap-Partition aktiviert:

~~~
swapon /dev/sdb3
~~~

Danach kann in der Konsole überprüft werden, ob die Swap-Partition erkannt wird:

~~~
swapon -s
~~~

Die nun eingebundene Swap-Partition sollte erkannt werden:

| Filename | Type | Size | Used | Priority | 
| ---- | ---- | ---- | ---- | ---- |
| /dev/sdb3 | partition | 995988 | 248632 | -1 | 

---

Wird die Swap-Partition korrekt erkannt, wird folgender Befehl eingegeben 

~~~
swapoff -a
~~~

und der Computer neu gestartet.

Jetzt kann die Installation beginnen.

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
