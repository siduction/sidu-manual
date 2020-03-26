<div class="divider" id="Inst-prep"></div>

## Installationsvorbereitungen

 **`Im Regelfall empfehlen wir das Dateisystem ext4, welches bei siduction als Default-Dateisystem verwendet wird und im Upstream sehr gut gewartet wird.`**
**`Vor der Installation bitte alle USB-Sticks, Kameras etc. entfernen.`**  [Die Installation auf einem USB-Device](hd-install-opts-de.htm#usb-hd)  benötigt ein anderes Verfahren und ist an anderer Stelle beschrieben. Es ist auch möglich, die Installationsdatei `~/.sidconf`  zu ändern, um dort ein anderes Dateisystem zu wählen oder die Installation auf mehrere Partitionen aufzuteilen.

 `Weiters ist das Anlegen einer eigenen Datenpartition empfohlen. Die Vorteile im Falle einer Datenrettung und auch für die Datenstabilität sind unermesslich.`
Das Verzeichnis $HOME wird zu dem Ort, an dem Programmkonfigurationen abgelegt werden.

#### Benutzerdefinierte Installation von Software bei Neuinstallation oder bei Duplizierung auf einem anderen Computer

Mit folgendem Konsolenbefehl wird eine Liste der installierten Softwarepakete erstellt, um mit Hilfe dieser eine identische Softwareauswahl auf einem anderen Computer oder bei einer allfälligen Neuinstallation installieren zu können:

~~~
dpkg -l|awk '/^ii/{ print $2 }'|grep -v -e ^lib -e -dev -e $(uname -r) >/home/username/installed.txt
~~~

Am besten wird diese Textdatei auf einen USB-Stick oder einen Datenträger nach Wahl kopiert.

Auf der Zielinstallation wird die Textdatei nach $HOME kopiert und als Referenz verwendet, um die benötigten Programmpakete zu installieren. Die gesamte Paketliste kann per

~~~
apt-get install $(<installed.txt)
~~~

installiert werden.

#### RAM und Swap

Auf PCs mit weniger als 512MB RAM muss eine swap-Partition angelegt werden. Deren Größe sollte aber nicht kleiner als 128MB sein. Mehr als 1GB wird normal nicht benötigt und ist nur bei Suspend-to-Disk und Serversystemen wirklich sinnvoll.

 `Siehe auch: [Festplatte Partitionieren](part-gparted-de.htm#gparted) `
**`WICHTIG: IMMER EINE DATENSICHERUNG ANLEGEN!`**  Siehe auch [Backup mit rdiff](sys-admin-rdiff-de.htm#rdiff)  und [Backup mit rsync](sys-admin-rsync-de.htm#rsync) . Eine weitere Option ist Lucky Backup (muss installiert werden).

Eine Installation auf der Festplatte ist ungleich komfortabler und schneller als ein System, das nur von CD-ROM läuft.

Zuerst stellt man im BIOS die Bootreihenfolge auf CD-ROM um. Bei den meisten Computern kommt man durch Drücken der 'Entf'-Taste während des Bootvorgangs in das BIOS-Setup (bei einigen BIOS-Versionen kann man auch während des Bootens das Startlaufwerk auswählen, beim AMI-BIOS z. B. mit F11 oder F8).

siduction startet jetzt in der Regel problemlos. Sollte das nicht der Fall sein, helfen Bootoptionen (Cheatcodes), die an den Bootmanager übergeben werden können. Einige Bootparameter (z. B. für die Bildschirmauflösung oder Wahl der Sprache) können sehr viel Konfigurationsarbeit sparen. Mit F4 lässt sich beispielsweise beim Booten der Live-CD die Sprache wählen. [Siehe auch Cheatcodes](cheatcodes-de.htm#cheatcodes-siduction)  und [VGA-Auflösungen](cheatcodes-vga-de.htm#vga) 

## Sprache bei der Installation wählen

#### `Bei der Installation wählbare Sprachen mit KDE-full` 

Die Hauptsprache wird im **`Grub-Menü (F4)`**  der `KDE-full-Version`  gewählt. Damit kann man lokalisierte Versionen des Desktops und vieler Programme bereits während des Bootens installieren.

Dies stellt sicher, dass die lokalisierten Versionen durch eine einfache Sprachenwahl sofort nach der Installation von siduction verfügbar sind. Wieviel Speicher benötigt wird, hängt von der gewählten Sprache ab, und siduction kann die Installation einer zusätzlichen Sprache automatisch zurückweisen, falls nicht ausreichend RAM zur Verfügung steht. Der Bootvorgang wird dann auf Englisch fortgesetzt, während die lokalisierten Einstellungen (Währung, Datum und Zeit-Format) übernommen werden. 1 GB RAM oder mehr sollten ausreichend sein, um alle Sprachen zu unterstützen. Verfügbare Sprachen sind:

  Default - Deutsch  
 Default - English (Amerikanisches Englisch)  
 *Čeština (Tschechisch)  
 *Dansk (Dänisch)  
 *Español (Spanisch)  
 *English (Britisches Englisch)  
 *Français (Französisch)  
 *Italiano (Italienisch)  
 *Nihongo (Japanisch)  
 *Nederlands (Holländisch)  
 *Polski (Polnisch)  
 *Português (Portugiesisch - BR und PT)  
 *Română (Rumänisch)  
 *Русский (Russisch)  
 

Die zur Verfügung stehenden Sprachen hängen davon ab, in welche Sprachen das siduction-Handbuch übersetzt ist. Neue Sprachen sind immer willkommen!

#### `Installation weiterer Sprachen mit KDE` 

1. Die Hauptsprache wird im **`gfxboot-Menü (F4)`**  gewählt. (Siehe auch [siduction spezifische Parameter (nur Live-CD)](cheatcodes-de.htm#cheatcodes)). Die Sprachdateien selbst befinden sich nicht auf der Live-CD, siduction wird mit der Standardsprache Englisch booten. Die Auswahl der Sprache stellt jedoch die korrekten Einstellungen sicher, die benötigt werden, und es muss daher nach der Installation der Sprachkpakete nichts mehr zusätzlich konfiguriert werden.
2.  Installation starten.
3. Installation auf die Festplatte und nach Abschluss Neustart des Rechners.
4. Nach der Festplatteninstallation werden die gewünschte Sprache und Anwendungen mit apt-get installiert.

#### Erster Start einer Festplatteninstallation

`Nach dem ersten Start von siduction wird man feststellen müssen, dass siduction die Netzwerkkonfigurationen vergessen hat` . Ein Netzwerk kann bequem mit [K-Menü > Internet > Ceni](inet-ceni-de.htm#netcardconfig)  eingerichtet werden. Für zusätzliches WIFI/WLAN-Roaming [bitte hier weiterlesen](inet-wpagui-de.htm) .

<div class="divider" id="Installation"></div>

## Das siduction-Installationsprogramm

 **1.**  Das Installationsprogramm startet man bequem über: `das Icon am Desktop, über KMenu > System > siduction-installer.` 

![siduction-Installer1](../images-de/installer-de/installer1-de.png "Begrüßung - siduction-Installer") 

 **2.**  Nach dem Lesen (und Verstehen) des Hinweistextes geht es weiter zur Partitionsauswahl.

![siduction-Installer2](../images-de/installer-de/installer2-de.png "Partitionierung - siduction-Installer") 

 `Bitte vergewissere Dich nochmal, ob für alle Daten ein Backup angelegt wurde.`
Wenn die Festplatte noch nicht partitioniert ist, kann man dies im Bereich `Start Part.-Manager`  durchführen, oder man liest im Handbuch die Kapitel [Partitionieren der Festplatte mit cfdisk](part-cfdisk-de.htm#disknames)  bzw. [Partitionieren mit Gparted](part-gparted-de.htm#partition) .

---

 **3.**  Nun wird ausgewählt, wohin installiert wird, und die Mountpunkte werden festgelegt. Die Mountpunkte von Partitionen, für die kein Mountpunkt gewählt wurde, werden vom Installationsprogramm zugewiesen (die Swap-Partition wird immer automatisch während des Systemstarts eingebunden).

![grub-to-mbr](../images-de/installer-de/installer3-de.png "Grub/Zeitzone - siduction-Installer") 

**`ANMERKUNG: Die Root-Partiton ("&#47;") wird automatisch mit dem gewählten Filesystem formatiert.`** 

Alle nicht gewählten Partitionen werden in `/media/`  eingebunden. `Auch kann jetzt eine Datenpartition erstellt werden.` `Mit einem "Linksklick" wird ein Auswahlmenü für die jeweilige Partition geöffnet.` 

 **4.**  Auf dieser Seite könne weitere Partitionen angelegt werden. Wir empfehlen einen zusätzliche Partition für Dein /home/. Du kannst hier auch ein Daten Partition erstellen. Einfach auf hinzufügen drücken. Alle weiteren Partition werden automatisch auf /media/ eingebunden. 

![choosing-pw](../images-de/installer-de/installer4-de.png "User/Passwort - siduction-Installer") 

---

 **5.**  Als Bootmanager verwenden wir  **Grub im MBR** ! Eine andere Wahl ist nur erfahrenen Nutzern empfohlen, die wissen, welche Folgen diese Entscheidung mit sich zieht. Grub erkennt automatisch, ob noch andere Betriebssysteme auf dem Computer installiert sind (z. B. Windows), und fügt diese seinem Bootmenü hinzu.

Die Zeitzone kann bei Bedarf noch angepasst werden.

Im Anschluss wird der Name der Installation gewählt. Der Name ist beliebig, aber der Computername (Hostname) darf ausschließlich aus Buchstaben und Zahlen bestehen (keine Sonderzeichen oder Umlaute) und darf nicht mit einer Ziffer beginnen.

Im Anschluss daran kann ausgewählt werden, ob ssh automatisch beim Booten gestartet werden soll oder nicht.

![hostname](../images-de/installer-de/installer5-de.png "Netzwerk - siduction-Installer") 

---

 **6.**  Als nächstes werden Benutzername, Benutzerpasswort und Rootpasswort festgelegt (bitte gut merken!). Die Passwörter sollen aus Sicherheitsgründen nicht zu einfach gewählt werden. Weitere Benutzer können nach der Installation in einem Terminal mit [adduser](hd-install-de.htm#adduser)  zugefügt werden.

Diese Abfrage ist die letzte Möglichkeit, die gewählten Einstellungen zu überprüfen. Du solltest noch einmal sorgfältig durchgelesen werden, danach bestätigt man durch `das anklicken des "Weiter" Knopfes` .

![installation-config](../images-de/installer-de/installer6-de.png "Installation - siduction-Installer") 

 **7.**  Als nächstes wird der Computer Name festgelegt. Zusätzliche kann ssh eingechaltet werden.

![installation-config](../images-de/installer-de/installer7-de.png "Installation - siduction-Installer") 

An diesem Punkt ist es möglich, die Konfigurationsdatei zu editieren und den Installationsprozess mit der angepassten Konfigurationsdatei zu starten. Die Installationsroutine führt keine Überprüfungen durch und `der "Zurück"-Knopf soll nicht gedrückt werden, da ansonsten alle manuellen Änderungen rückgängig gemacht werden.`  

![Begin Installtion](../images-de/installer-de/installer8-de.png "Start der Installation - siduction Installer") 

Um die Installation zu starten, klickt man auf `Installation starten` . Der ganze Installationsprozess dauert - abhängig von der benutzten Hardware - zwischen fünf und fünfzehn Minuten. Auf sehr alten Systemen kann man mit bis zu einer Stunde rechnen.

Falls der Fortschrittsbalken sich scheinbar nicht weiter bewegt, bitte die Installation nicht abbrechen, sondern dem Prozess Zeit geben.

Nach Beendigung der Installation bitte die CD aus dem Laufwerk nehmen und in das neue System rebooten!

<div class="divider" id="first-hd-boot"></div>

## Der erste Start

 `Nach dem ersten Start von der Festplatte hat siduction zunächst die Netzwerkeinstellungen vergessen. Also muss das Netzwerk (Wlan, Modem, ISDN, ...) noch einmal eingerichtet werden.`
Wer vorher z. B. durch seinen DSL-Router eine Netzwerkadresse vollkommen ohne sein Zutun erhalten hat (DHCP), muss jetzt auch nur einmal folgenden Befehl aufrufen:

~~~
ceni
~~~

Die entsprechenden Tools findet man wieder unter  *Kmenu>Internet>ceni - Netzwerkkarte konfigurieren* . Siehe auch: [Internet und Netzwerk](inet-ceni-de.htm#netcardconfig) 

Um eine existierende $home-Partition von siduction in eine neue Installation einbinden zu können, muss fstab geändert werden. Siehe: [/home verschieben](home-de.htm#home-move) .

 **`Ein existierendes $home einer anderen Distribution soll nicht verwendet oder geteilt werden, da es bei Verwendung eines gleichen Nutzernamens bei Konfigurationsdateien zu Konflikten kommen kann/wird.`** 


<div class="divider" id="adduser"></div>

## Weitere Benutzer hinzufügen

Um `neue Benutzer`  mit automatischer Übernahme der Gruppenberechtigungen hinzuzufügen, führt man folgenden Befehl als root aus:

~~~
adduser <nutzername>
~~~

Das Drücken der Eingabetaste Enter führt zu weiteren Optionen, die Feinstellungen ermöglichen. Es folgt eine Aufforderung zum zweimaligen Eingeben des Passworts.

siduction spezifische Desktopsymbole (für das Handbuch und den IRC) müssen selbst hinzugefügt werden. 

So entfernt man einen Benutzer

~~~
deluser <nutzername>
~~~

Mehr Informationen:

~~~
man adduser
man deluser
~~~

Mit `kuser`  können gleichfalls neue Benutzer erstellt werden, wobei die Gruppenberechtigungen in diesem Fall nicht automatisch übernommen werden, sondern manuell gewährt werden müssen.

<div class="divider" id="su"></div>

## Über suxterm

Eine Anzahl von Befehlen muss mit Root-Rechten gestartet werden. Diese erhält man durch Eingabe von:

~~~
su oder suxterm
~~~

Im Gegensatz zum allgemeinen Befehl 'su', erlaubt `suxterm`  das Ausführen von Programmen mit graphischer Oberfläche mit Root-Rechten. `suxterm`  transferiert unter Benutzung von 'su' die X-Eigenschaften an den Zielnutzer.

Einige KDE-Anwendungen benötigen `dbus-launch`  vor dem Anwendungsbefehl:

~~~
dbus-launch <Anwendung>
~~~

Anders als 'sudo', wie es an manchen Linux-Systemen Standard ist, bedeutet dies, dass ein Nutzer ohne Rootrechte keine - potentiell gefährlichen - Änderungen am System vornehmen kann.

 **`Achtung:`** `Während man mit Rootrechten eingeloggt ist, darf man alles, z. B. Dateien löschen, ohne die das Betriebssystem nicht mehr funktioniert usw. Wenn man mit Rootrechten arbeitet, muss man sich darüber im Klaren sein,` **`was`** `man gerade macht, denn es ist leicht möglich, dem Betriebssystem irreparable Schäden zuzufügen.`
 **`Unter keinen Umständen sollten Produktivprogramme, die normalerweise mit Benutzerrechten gestartet werden, mit dieser Option als root hochgefahren werden: Internet-Browser, E-Mail-Programme, Büroprogramme u.v.m.`**

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
