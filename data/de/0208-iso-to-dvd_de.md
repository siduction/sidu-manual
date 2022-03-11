ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Arbeiten 2022-03
+ Neu, aus "0206-iso-dl" ausgelagert
+ Link prüfen/aktualisieren
+ Rechtschreibprüfung
+ Formatierungen bereinigt

Noch zu erledigen
+ Inhalt durch weitere fachkundige Person prüfen
+ Nochmalige Rechtschreibprüfung
+ Link nach Abschluss aller anderen Arbeiten an 0206, 0207, 0208 und 0209 prüfen.

ENDE   INFOBEREICH FÜR DIE AUTOREN  
% siduction ISO brennen

## ISO brennen

Bevor die ISO-Abbilddatei auf eine DVD gebrannt wird, sollte man sie stets mit Hilfe der von siduction immer angebotenen md5sum und sha256sum prüfen. Das erspart unter Umständen viel Zeit für die Fehlersuche bei einer veränderten oder beschädigten Datei.  
Eine ausführliche Anleitung steht im Handbuchkapitel [md5sum und Integritätsprüfung](0206-iso-dl_de.md#md5sum-und-integritätsprüfung).

> **WICHTIGE INFORMATION:**  
> siduction, als Linux-LIVE-DVD/CD, ist sehr stark komprimiert. Aus diesem Grund muss besonders auf die Brennmethode des Abbildes geachtet werden. Bitte verwende hochwertige Medien, das Brennen im DAO-Modus (disk-at-once) und nicht schneller als achtfach (8x).

Wir empfehlen allerdings, sofern die Hardware das Booten von USB unterstützt, das Abbild auf einen USB-Stick oder eine SD-Speicherkarte zu legen. Eine Anleitung dazu bietet die Handbuchseite [ISO auf USB-Stick / Speicherkarte](0207-iso-to-usb-sd_de.md#iso-auf-usb-stick---speicherkarte).

### DVD mit Linux brennen

Wer bereits Linux auf dem Rechner hat, kann die DVD mit jedem installierten Brennprogramm erstellen. Je nach Desktopumgebung sind das die Programme  
+ **K3b** für KDE  
+ **Brasero** für Gnome  
+ **Xfburn** für XFCE, LXQt und Gnome

Die Brennprogramme sind in ihrer Bedienung weitgehend selbsterklärend.  
Bei K3b wählt man *Weitere Aktionen...* -\> *Abbild schreiben...* aus.  
In Xfburn und Brasero sollte man "Abbild brennen" anklicken.  
Anschließend ist das zu brennende ISO-File (z.B. siduction-21.3.0-wintersky-kde-amd64-202112231751.iso) auszuwählen und der Brennmodus *DAO* (Disk At Once) oder *Automatisch* einzustellen und der Brennvorgang zu starten.

Gelegentliche Probleme beim Brennen der Live-DVD haben ihre Ursache zumeist in den graphischen Frontend-Applikationen. Dies kann man umgehen, indem auf der Konsole das sehr einfach anzuwendende Skript *burniso* benutzt wird. Die Handbuchseite [DVD ohne GUI brennen](0209-no-gui-burn_de.md#dvd-ohne-gui-brennen) erklärt die Verwendung von *burniso* kurz und exakt, sowie weitere Befehle um verfügbare Hardware zu erkennen, Daten zusammenzustellen und CD/DVDs zu brennen.

### DVD mit Windows brennen

Selbstverständlich kann man die DVD auch in Windows brennen. Die heruntergeladene Datei muss als ISO-Abbild auf eine DVD gebrannt werden und nicht aus dem Windows Explorer heraus als Datei.  
Es gibt verschiedene gute Programme, die die mit Windows Vista eingeführte, integrierte Brennfunktion für CD und DVD erweitern um ISO-Dateien zu brennen. Hier nur zwei Beispiele.

+ Die Open-Source-Software [cdrtfe](https://cdrtfe.sourceforge.io/cdrtfe/index_de.html) ist in der aktuellen Version kompatibel mit Windows Vista, 7, 8, 10 und 11. Mit dem Programm lassen sich ISO-Abbilder brennen, Daten-Disks (CD, DVD, BD) sowie Audio und Video CD/DVDs erstellen. Man kann es in Windows installieren oder das zip-Archiv herunterladen und nach dem Entpacken cdrtfe ohne weitere Installation starten.  
+ Die Closed-Source-Software CDBurnerXP ist ein kostenloses Programm, dass neben dem Brennen von ISO-Abbildern auch Daten und Audio CD/DVDs erstellen kann und wieder beschreibbare Medien bei Bedarf löscht. Erhältlich unter [CDBurnerXP](https://cdburnerxp.de.uptodown.com/windows).

<div id="rev">Zuletzt bearbeitet: 2022-03-06</div>
