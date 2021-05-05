% DVD ohne GUI brennen

## DVD ohne GUI brennen

<warning>**WICHTIGE INFORMATION:**</warning>
<warning>
siduction, als Linux-LIVE-DVD/CD, ist sehr stark komprimiert. Aus diesem Grund muss besonders auf die Brennmethode des ISO-Abbilds geachtet werden. Wir empfehlen hochwertige CD-Medien (oder DVD+R), das Brennen im DAO-Modus (disk-at-once) und nicht schneller als achtfach (8x).
</warning>

### burniso

Man benötigt zum Brennen einer CD/DVD nicht notwendigerweise eine grafische Benutzeroberfläche (GUI).

Probleme, die beim Brennen auftreten, haben ihre Ursache normalerweise in den Frontends wie K3b, nicht so häufig in den Backends wie growisofs, wodim oder cdrdao.

siduction stellt ein Skript namens "burniso" zur Verfügung, um die siduction-ISO zu brennen.

burniso brennt unter Nutzung von wodim ISO-Abbilddateien im Disk-At-Once-Modus mit einer fest eingestellten Brenngeschwindigkeit von 8x.

~~~sh
# apt-get install siduction-scripts
~~~

Als $Nutzer:

~~~sh
$ cd /Pfad/zur/ISO
$ burniso
~~~

Alle ISO-Abbilddateien im aktuellen Verzeichnis werden zur Auswahl angeboten, und der Brennvorgang startet sofort nach der Auswahl einer ISO-Datei. Daher soll man darauf achten, dass vor Start des Skripts bereits das Medium, auf das gebrannt wird, eingelegt ist.  

### Verfügbare Geräte

Für ATAPI Geräte:

wodim:

~~~sh
$ wodim --devices
wodim: Overview of accessible drives (2 found) :
---------------------------------------------------------
0  dev='/dev/scd0'      rwrw-- : 'AOPEN' 'CD-RW CRW2440'
1  dev='/dev/scd1'      rwrw-- : '_NEC' 'DVD_RW ND-3540A'
---------------------------------------------------------
~~~

Weitere Alternativen sind:

~~~sh
$ wodim dev=/dev/scd0 driveropts=help -checkdrive
~~~

und

~~~sh
$ wodim -prcap
~~~

cdrdao Geräte-Check:

~~~sh
$ cdrdao scanbus
Cdrdao version 1.2.1 - (C)  Andreas Mueller
ATA:1,0,0 AOPEN , CD-RW CRW2440 , 2.02
ATA:1,1,0 _NEC , DVD_RW ND-3540A , 1.01
~~~

### Nützliche Beispiele

**Informationen über leere CDs/DVDs:**

~~~sh
$ wodim dev=/dev/scd0 -atip
~~~

oder

~~~sh
$ cdrdao disk-info --device ATA:1,0,0
~~~

**Einen wiederbeschreibbaren Rohling löschen:**

~~~sh
$ wodim -blank=fast -v dev=/dev/scd0
~~~

oder

~~~sh
$ cdrdao blank --device ATA:1,0,0 --blank-mode minimal
~~~

**Eine CD kopieren:**

~~~sh
$ cdrdao copy --fast-toc --device ATA:1,0,0 --buffers 256 -v2
~~~

**Eine CD "on the fly" kopieren:**

~~~sh
$ cdrdao copy --fast-toc --source-device ATA:1,1,0 --device ATA:1,0,0 --on-the-fly --buffers 256 --eject -v2
~~~

**Eine Audio-CD mit wav-Dateien mit 12facher Geschwindigkeit brennen:**

~~~sh
$ wodim -v -eject -pad -dao speed=12 dev=/dev/scd0 defpregap=0 -audio *.wav
~~~

**Eine CD mittels eines bin/cue-Abbilds brennen:**

~~~sh
$ cdrdao write --speed 24 --device ATA:1,0,0 --eject filenam.cue
~~~


**CD von einem ISO-Abbild brennen:**

~~~sh
$ wodim dev=/dev/scd0 driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso
~~~

Falls man eine Fehlermeldung zu driveropts erhält, liegt dies daran, dass burnfree auf einigen Brennern nicht möglich ist. Dies wird so gelöst:

~~~sh
$ wodim dev=/dev/scd0 driveropts=noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso
~~~

oder so:

~~~sh
$ wodim dev=/dev/scd0 fs=14M speed=8 -dao -eject -overburn -v siduction.iso
~~~

**Eine ISO-Abbildatei aus einem Ordner und allen Unterordnern erstellen:**

~~~sh
$ genisoimage -o siduction.iso -r -J -l directory
~~~

**Man kann growisofs verwenden, um eine DVD zu brennen, im Beispiel eine ISO-Datei:**

~~~sh
$ growisofs -dvd-compat -Z /dev/dvd=siduction.iso
~~~

**Mehrere Dateien auf DVD brennen:**

~~~sh
$ growisofs -Z /dev/dvd -R -J datei1 datei2 datei3 ...
~~~

**Wenn auf der DVD noch Platz ist, kann man Dateien hinzufügen:**

~~~sh
$ growisofs -M /dev/dvd -R -J noch_eine_datei und_noch_eine_datei
~~~

**Um eine Sitzung zu schließen:**

~~~sh
$ growisofs -M /dev/dvd=/dev/zero $
~~~~

<div id="rev">Zuletzt bearbeitet: 2021-05-05</div>
