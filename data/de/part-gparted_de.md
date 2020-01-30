<div class="divider" id="partition"></dev>
## Partitionieren der Festplatte mit Gparted/KDE Partition Manager

##### Bitte BEACHTEN: bezüglich der Benennung von Speichergeräten [bitte das Kapitel zu UUID, Partitionsbezeichnung und fstab zu Rate ziehen, da siduction in der Grundeinstellung Benennung nach UUID verwendet.](part-uuid-de.htm#uuid)

##### Partitionierungsprogramme benötigen Rootrechte. Man startet sie in einer Konsole nach Eingabe von suxterm und dem Rootpasswort. Auf einem Live-System ist kein Rootpasswort gesetzt, nach suxterm drückt man die Eingabetaste "Enter". Siehe auch: [Live-CD-Modus](live-mode-de.htm#rootpw)

:::warning
Größenänderungen bei NTFS-Partitionen erfordern nach der Ausführung einen **sofortigen** Reboot, vorher dürfen **keine weiteren Änderungen** an Partitionen durchgeführt werden. Dies führte unweigerlich zu Fehlern.[ Bitte lese hier weiter.](part-gparted-de.htm#ntfs)
:::

Bitte immer ein Daten-Backup anlegen!

### Grundlagen

Eine Partition benötigt ein Dateisystem. Linux kann auf und mit verschiedenen Dateisystemen arbeiten. ext4 ist das empfohlene Dateisystem für siduction. ext2 ist ein geeignetes Dateisystem zur Datenspeicherung und zum Datentausch, da ein Treiber für MS Windows™ verfügbar ist: [Ext2-Dateisystem für MS-Windows (Treiber und englischsprachige Doku)](http://www.fs-driver.org/).

Für normalen Gebrauch empfehlen wir das Dateisystem ext4.

## Verwendung des KDE Partition Manager &amp; Gparted

Partitionen zu erstellen oder zu bearbeiten ist keine alltägliche Aufgabe. Daher ist es eine gute Idee, folgende Anleitungen einmal gelesen zu haben, um mit dem Konzept eines Partitionsmanagers vertraut zu werden.

### KDE Partition Manager - in einem Terminal:

	suxterm
	partitionmanager

### Gparted - in einem Terminal:

	suxterm
	gparted

* Wenn GParted oder KDE Partition Manager gestartet wird, öffnet sich ein Fenster und die vorhandenen Laufwerke werden ausgelesen.
    Im KDE Partition Manager werden die Laufwerke auf der linken Seite aufgelistet.
    
![KDE Partition Manager partition information](../images-common/images-kpart/kpart-02.png "KDE Partition Manager partition information")

    Wenn in Gparted auf einen Menüpunkt geklickt wird, öffnet sich ein Pop-Down-Menü. Ein erneutes Einlesen der Laufwerke kann gewählt werden (refresh).
    
![gparted](../images-de/gparted-de/gparted02-de.png "Gparted: Geräteübersicht")

###### Die folgenden Bildschirmfotos wurden mit GParted erstellt. Der KDE Partition Manager verhält sich bezüglich Benutzerführung sehr ähnlich.
* ### Edit  

    Edit ist der 3. Menüpunkt von links. Er zeigt drei ausgegraute Optionen, die sehr wichtig sind:  
    + letzte Aktionen rückgängig machen ("Undo last operations"),  
    + alle Aktionen löschen ("clear all operations") und  
    + alle Aktionen anwenden ("apply all operations").
    
* ### Ansicht

    ##### Festplatteninfo ("Device Information")

    Die Festplatteninformationsanzeige zeigt in einem linken Fensterrahmen Details der Festplatte wie Modell, Größe usw., die wichtig sind, wenn mehrere Festplatten oder Datenträger im System vorhanden sind. Damit kann man kontrollieren, ob der richtige Datenträger zur Formatierung gewählt wurde.
    
![operation view](../images-de/gparted-de/gparted03-de.png "Gparted: Festplatteninformation")

    ##### Anstehende Aktionen ("Pending Operations"):
    
    In einem unten sich öffnenden Fensterrahmen werden die anstehenden Aktionen angezeigt. Diese Information ist sehr nützlich, um einen Überblick darüber zu haben, welche Aktionen durchgeführt werden sollen.
    
* ### Gerät

    "Gerät" erlaubt, ein Disklabel zu setzen. Ein vorhandenes Label kann geändert werden.
    
* ### Partition

    Der Menüpunkt "Partition" ist von größter Wichtigkeit. Beachten sollte man, dass einige der Unterpunkte auch kritische bzw. gefährliche Aktionen durchführen können.
    Löschen wird zum Entfernen bestehender Partitionen gewählt. Zum Löschen muss eine Partition ausgewählt werden.
    Resize/Move ist eine nützliche Funktion, mit der Partitonsgrößen verändert bzw. Partitionen verschoben werden.
    
* ##### Eine neue Partition erstellen

    In der Toolbar erlaubt der Knopf Neu das Erstellen einer neuen Partition, wenn zuvor ein unzugeordneter Bereich gewählt wurde. Ein neues Fenster erlaubt die Festlegung der Größe für eine primäre, erweiterte oder logische Partition und die Festlegung des Dateisystems.
    
![file system](../images-de/gparted-de/gparted07-de.png "Gparted: Neue Partition")

* ##### Falls ein Fehler gemacht wurde

    Falls ein Fehler gemacht wurde, kann die Partition mit der Delete-Taste (ENTF/DEL) wieder gelöscht werden. Falls noch nicht "Anwenden" ("Apply all operations") angeklickt wurde, kann mit der Aktion "Rückgängig" ("Undo last operation") die Aktion aufgehoben werden.
    
![delete](../images-de/gparted-de/gparted04-de.png "Gparted: Löschen")

* ### Resize/Move (Größe verändern und Partition verschieben)

    Um die Größe einer gewählten Partition zu ändern, klickt man auf Resize/Move, worauf ein neues Fenster erscheint. Die Partition kann mit der Maus verkleinert bzw. vergrößert werden - oder man nutzt die Pfeiltasten.
    
![resize / move](../images-de/gparted-de/gparted05-de.png "Gparted: Größenänderung")

* Im Anschluss daran klickt man auf "Anwenden" ("Apply all operations"), da die vorher durchgeführten Aktionen erst dann endgültig umgesetzt werden.

![operation view](../images-de/gparted-de/gparted09-de.png "Gparted: Ausführen und speichern")

    Die Dauer der Operation hängt von der Größe der gewählten Partition ab.
    Nachdem durch die Änderungen die Partitionstabelle automatisch neu erstellt wurde, muss man in jedem Fall sich abmelden und den Computer neu starten, damit die neue Partitionstabelle von siduction eingelesen wird.

<div class="divider" id="ntfs"></div>

## NTFS-Partitionsgrößen mit GParted ändern

Größenänderungen bei NTFS-Partitionen erfordern nach der Ausführung einen **sofortigen** Reboot, vorher dürfen **keine weiteren Änderungen** an Partitionen durchgeführt werden. Dies führte unweigerlich zu Fehlern.

* Nach dem Neustart von Windows und dem Windows-Logo erscheint ein Fenster von **checkdisk**, das besagt, dass C:\\ auf Fehler überprüft wird.
* Diesen AUTOCHECK bitte zu Ende laufen lassen: ein Windows-NT-System muss das Filesystem nach einer Größenänderung überprüfen.
* Nach der Überprüfung wird der Rechner automatisch das zweite Mal neu gestartet. Dies gewährleistet, dass das System problemlos laufen kann.
* Nach dem Neustart wird ein Windows der NT-Generation (z.B. XP) ordnungsgemäß funktionieren. Man muss jedoch das System fertig starten lassen und auf das Anmeldefenster warten!

**Die gesamte GParted-Dokumentation findet sich auf der [Gparted-Homepage](http://gparted.sourceforge.net) in den Sprachen Englisch, Französisch und Spanisch.**

<div class="divider" id="hd-ntfs3g"></div>

## NTFS Partitionen mit ntfs-3g beschreibbar machen

**Achtung**: Obwohl der Treiber ntfs-3g nun für stabil erklärt ist, empfehlen wir keine Benutzung ohne vorher die Daten zu sichern, vor allem nicht auf Arbeitsplattformen! Die Benutzung erfolgt auf eigene Gefahr, da ein Datenverlust nicht gänzlich ausgeschlossen werden kann!

In eine Konsole Folgendes eingegeben (_siehe das Kapitel [Partitionieren der Festplatte](part-cfdisk-de.htm#disknames), wie die UUIDs der verschiedenen Partitionen ermittelt werden!)_:

	suxterm
	apt-get update &amp;&amp; apt-get install ntfs-3g
	umount /media/xdxx
	mount -t ntfs-3g /dev/disk/by-uuid/xxyyzz[etc] /media/xdxx
	exit  ## mit diesem Befehl wird die Konsole verlassen

Die NTFS Partition sollte jetzt **mit Schreibzugriff** eingehängt sein und man sollte Daten darauf speichern können.

 Aber noch einmal unsere Warnung: _Dieses Vorgehen ist für Situationen gedacht, für die es keine anderen Lösungsmöglichkeiten gibt. Für die tägliche Routinenutzung es nicht empfohlen!_

<div id="rev">Page last revised 14/01/2012 1445 UTC</div>
