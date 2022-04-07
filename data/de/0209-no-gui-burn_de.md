% Medien ohne GUI brennen

## Life-DVD ohne GUI brennen

> **WICHTIGE INFORMATION:**  
> siduction, als Linux-LIVE-DVD/CD, ist sehr stark komprimiert. Aus diesem Grund muss besonders auf die Brennmethode des ISO-Abbilds geachtet werden. Wir empfehlen hochwertige CD-Medien (oder DVD+R), das Brennen im DAO-Modus (disk-at-once) und nicht schneller als achtfach (8x).

Man benötigt zum Brennen einer CD/DVD nicht notwendigerweise eine grafische Benutzeroberfläche (GUI).  
Probleme, die beim Brennen auftreten, haben ihre Ursache normalerweise in den Frontends wie K3b, nicht so häufig in den Backends wie growisofs, wodim oder cdrdao.

Bevor die ISO-Abbilddatei auf eine DVD gebrannt wird, sollte man sie stets mit Hilfe der von siduction immer angebotenen md5sum und sha256sum prüfen. Das erspart unter Umständen viel Zeit für die Fehlersuche bei einer veränderten oder beschädigten Datei.  
Eine ausführliche Anleitung steht im Handbuchkapitel [ISO Download, Integritätsprüfung](0206-iso-dl_de.md#integritätsprüfung).

### burniso

Siduction stellt ein Skript namens `burniso` zur Verfügung.  
Burniso brennt unter Nutzung von wodim die ISO-Abbilddatei im Disk-At-Once-Modus mit einer fest eingestellten Brenngeschwindigkeit von 8x. Zuvor testet burniso ob die notwendige Hardware verfügbar ist und listet dann alle erkannten ISO-Abbilddateien auf. 

Als **user** wechselt man in das Verzeichnis mit den ISO-Abbilddateien und ruft `burniso` auf:

~~~
$ cd /Pfad/zur/ISO
$ burniso
Using device /dev/sr0.
Choose an ISO to burn: 
1) siduction-21.3.0-wintersky-kde-amd64-202112231751.iso
2) siduction-21.3.0-wintersky-lxqt-amd64-202112231805.iso
3) siduction-21.3.0-wintersky-xfce-amd64-202112231826.iso
#? _
~~~

Nach Eingabe der Ziffer für die gewünschte ISO-Abbilddatei prüft `burniso` die Integrität sofern im gleichen Verzeichnis eine zugehörige `.md5` Datei liegt. Bei Erfolg startet der Brennvorgang unmittelbar anschließend. Daher soll man darauf achten, dass vor dem Start des Skripts bereits das Medium, auf das gebrannt wird, eingelegt ist.

Burniso perfektioniert und vereinfacht für den Anwender eine einzige Funktion, nämlich das Brennen von ISO-Abbildern. Darüber hinaus bieten die Kommandozeilenprogramme alle Möglichkeiten um Medien mit Daten verschiedenster Art auf CD, DVD und BD zu erstellen. Im folgenden Kapitel zeigen wir einige Beispiele die häufig Anwendung finden.

### Brennen mit cdrdao wodim growisofs

Die Kommandozeilenprogramme bilden die Basis für die beliebten GUI-Programme wie `K3b`, `Brasero` oder `Xfburn`. Wer die vollständige Bandbreite an Optionen der Programme `cdrdao`, `wodim`, `growisofs` usw. bevorzugt, nutzt die Kommandozeile. Wir präsentieren hier nur einen minimalen Ausschnitt der Möglichkeiten. Das Studium der Manpages sollte selbstverständlich sein und ist mit den Beispielen etwas einfacher. Darüber hinaus finden sich im Internet mit der Suchmaschine der Wahl Tips für das eigene Projekt.

### Verfügbare Geräte

Ist die vorhandene Hardware zum Brennen nicht genau bekannt, analysieren die Programme wodim und cdrdao die Gerätedaten und geben die Informationen aus. Zuerst `wodim` für einen externen DVD-Brenner an USB:

~~~
$ wodim -checkdrive
Device was not specified. Trying to find an appropriate drive...
Detected CD-R drive: /dev/sr0
[...]
Vendor_info    : 'HL-DT-ST'
Identification : 'DVDRAM GP50NB40 '
Revision       : 'RB00'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc DVD-R(W) driver (mmc_mdvd).
Driver flags   : SWABAUDIO BURNFREE 
Supported modes: PACKET SAO
~~~

Die Ausgabe für das gleiche Gerät mit `cdrdao`:

~~~
$ cdrdao scanbus
Cdrdao version 1.2.4 - (C) Andreas Mueller
/dev/sr0 : HL-DT-ST, DVDRAM GP50NB40 , RB00
~~~

Ein weiteres Beispiel mit `wodim` auf einem anderen PC mit zwei IDE/ATAPI Geräten:

~~~
$ wodim --devices
wodim: Overview of accessible drives (2 found) :
---------------------------------------------------------
0  dev='/dev/scd0'      rwrw-- : 'AOPEN' 'CD-RW CRW2440'
1  dev='/dev/scd1'      rwrw-- : '_NEC' 'DVD_RW ND-3540A'
---------------------------------------------------------
~~~

Wir benötigen für die Kommandozeilenprogramme vor allen Dingen die genaue Bezeichnung der Gerätedatei (*"/dev/sr0"* oder *"/devscd1"*) um den richtigen Brenner zu benutzen.

### Beispiele für CD DVD BD

Bei den Beispielen verzichten wir auf umfangreiche Erläuterungen der verwendeten Optionen. Bitte die Manpages für ausführliche Informationen konsultieren.

**CD/DVD von einem ISO-Abbild brennen:**

Wodim erkennt an Hand der Dateinamenerweiterung `*.iso` und der Option `-dao`, dass ein Abbild zu brennen ist.

~~~
$ wodim dev=/dev/sr0 driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -v <ISO-Abbild.iso>
~~~

Falls man eine Fehlermeldung zu *"driveropts"* erhält, liegt dies daran, dass burnfree auf einigen Brennern nicht möglich ist. Dies wird gelöst, indem die driveropts aus dem Befehl entfernt werden.

~~~txt
$ wodim dev=/dev/sr0 fs=14M speed=8 -dao -eject -v <ISO-Abbild.iso>
~~~

Mit `genisoimage` und `growisofs` kann man eine ISO-Abbilddatei aus einem Ordner und allen Unterordnern erstellen und anschließend brennen.

~~~
    (ISO erstellen)
$ genisoimage -o <ISO-Abbild.iso> -r -J -l <directory>
    (ISO brennen)
$ growisofs -dvd-compat -Z /dev/dvd=<ISO-Abbild.iso>
~~~

Eine CD mittels eines bin/cue-Abbild brennen:

~~~
$ cdrdao write --speed 24 --device /dev/scd0 --eject filenam.cue
~~~

**CD-RW/DVD-RW löschen**

Um wieder beschreibbare Medien mit neuen Daten zu versehen, müssen sie zuvor gelöscht werden. Die Befehle für das Löschen der Inhaltsverzeichnisse lauten:

~~~
$ wodim -blank=fast -v dev=/dev/sr0
    (oder)
$ cdrdao blank --device /dev/sr0 --blank-mode minimal
~~~

Will man die gesamten Daten überbrennen, verwenden wir bei wodim `-blank=all` und bei cdrdao `-blank-mode full`.

**CD/DVD kopieren**

Kopieren wenn nur ein Laufwerk vorhanden ist. Nach dem Einlesen wird das Quellmedium ausgeworfen und man muss den leeren Rohling in das gleiche Laufwerk einlegen um fortzufahren.

~~~
$ cdrdao copy --fast-toc --device /dev/scd0 --buffers 256 -v2
~~~

Man kann eine CD "on the fly" kopieren, wenn zwei Laufwerke verfügbar sind.

~~~
$ cdrdao copy --fast-toc --source-device /dev/scd0 --device /dev/scd1 --on-the-fly --buffers 256 --eject -v2
~~~

**Audio-CD brennen**

Alle wav-Dateien in dem aktuellen Ordner mit 12 facher Geschwindigkeit brennen.

~~~
$ wodim -v -eject -pad -dao speed=12 dev=/dev/scd0 defpregap=0 -audio *.wav
~~~

**Dateien auf DVD brennen**

~~~
$ growisofs -Z /dev/dvd -R -J datei1 datei2 datei3 ...
~~~

Wenn auf der DVD noch Platz ist, kann man mit Hilfe der Option `-M` Dateien hinzufügen.

~~~
$ growisofs -M /dev/dvd -R -J noch_eine_datei und_noch_eine_datei
~~~

Mit diesem Befehl wird der verbliebene freie Platz auf der DVD mit Nullen gefüllt und das Medium geschlossen.

~~~
$ growisofs -M /dev/dvd=/dev/zero
~~~~

<div id="rev">Zuletzt bearbeitet: 2022-03-08</div>
