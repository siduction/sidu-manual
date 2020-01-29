<div class="divider" id="live-cd-upgrade"></div>

## Aktualisierung mittels Live-CD

Die Möglichkeit der Aktualisierung einer siduction-Installation mittels Live-CD existiert nicht. Vor einer Installation von siduction **`ist ein BACKUP aller wichtigen Daten inklusive Bookmarks und E-Mails sehr ans Herz gelegt.`** 

 `Weiters ist das Anlegen einer eigenen Datenpartition empfohlen. Die Vorteile im Falle einer Datenrettung und auch bezüglich Datenstabilität sind unermesslich.`
Das Verzeichnis $HOME wird zu dem Ort, an dem Programmkonfigurationen abgelegt werden.

 **`Bitte IMMER EIN DATENBACKUP ANLEGEN, inklusive Bookmarks und E-Mails!`**

<div class="divider" id="hd-upgrade"></div>

## Systemaktualisierung nach einer Installation

Nach der siduction-Installation auf eine Festplatte stellt sich die Frage, wie neue Programmpakete und Sicherheitsupdates eingespielt werden können.

Bei siduction heißt das 'dist-upgrade' und geht nur mit bestehender Internetanbindung

**`Bitte NIEMALS "apt-get dist-upgrade" oder "apt-get upgrade" in der graphischen Umgebung X durchführen. Besuche vor einer Aktualisierung die [siduction-Homepage](http://siduction.org) , um eventuelle Upgradewarnungen in Erfahrung zu bringen. Diese Warnungen sind wegen der Struktur von Debian sid/unstable notwendig, welches täglich neue Programmpakete in seine Repositorien aufnimmt.`**

#### Die empfohlene Methode eines dist-upgrade ist folgende:

1. Aus der KDE-Desktopumgebung abmelden
2. In den Textmodus gehen mit Ctrl+Alt+F1
3. Einloggen als root:

~~~
init 3
apt-get update
apt-get dist-upgrade
apt-get clean
init 5 && exit
~~~

**`Und nochmal unsere Warnung: Bitte NIEMALS eine Systemaktualisierung mit einem graphischen Programm wie synaptic, adept oder kpackage bzw. dem Programm aptitude durchführen!`**  
[Mehr im Kapitel "Aktualisierung eines installierten Systems - dist-upgrade](sys-admin-apt-de.htm#apt-upgrade)

---

### Gründe, warum man nur apt-get für eine Systemaktualisierung verwenden soll

Paketmanager wie adept, aptitude, synaptic und kpackage können nicht immer die umfassenden Änderungen in Sid (Änderungen von Abhängigkeiten, Benennungskonventionen, Skripten u.a.) korrekt auflösen. Dies sind keine Fehler in diesen Programmen oder Fehler der Entwickler. Dies sind exzellente Programme für eine Installation von Debian stable, aber nicht angepasst an die besonderen Aufgaben der dynamischen Distribution Debian Sid.

Diese Programme können sich sehr gut dazu eignen, Programme zu suchen, aber zum Installieren, Löschen und zum Durchführen eines Dist-Upgrades soll apt-get verwendet werden.

Paketmanager wie adept, aptitude, synaptic und kpackage sind - technisch gesprochen - nicht deterministisch. Bei Verwendung einer dynamischen Distribution wie Debian Sid unter Hinzunahme von Drittrepositorien, deren Qualität nicht vom Debian-Team getestet sein kann, kann eine Systemaktualisierung zur Katastrophe führen, da diese Paketmanager durch automatische Lösungsversuche falsche Entscheidungen treffen können. Weiterhin ist zu beachten, dass ALLE GUI-Paketmanager in init 5 und/oder in X ausgeführt werden müssen, und eine Systemaktualisierung in init 5 und/oder X (oder selbst ein ohnehin nicht empfohlenes 'apt-get upgrade') wird früher oder später dazu führen, dass man sein System irreversibel beschädigt.

Im Gegensatz dazu führt apt-get ausschließlich das durch, was angefragt ist. Bei unvollständigen Abhängigkeiten in Sid, sprich: wenn das System "bricht" (dies kann in Sid bei Strukturänderungen vorkommen), können die Ursachen genau festgestellt und dadurch repariert oder umgangen werden. Das eigene System "bricht" nicht. Falls also ein Dist-Upgrade dem Gefühl nach das halbe System löschen möchte, überlässt apt-get dem Administrator die Entscheidung, was zu tun ist, und handelt nicht eigenmächtig.

Dies ist der Grund, warum Debian-Builds apt-get nutzen und nicht andere Paketmanager.

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
