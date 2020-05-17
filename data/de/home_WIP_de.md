ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: in Arbeit**

Änderungen 2020-05:
+ Inhalt
+ Korrektur und Prüfung aller Links noch nicht erledigt.

ENDE   INFOBEREICH FÜR DIE AUTOREN

<div class="divider" id="home-bu"></div>

## Sicherung des alten /home

Bevor `/home`  verschoben wird, sollte alles unterhalb von /home als Root gesichert werden: 

~~~
tar cvzpf somewhere/home.tar.gz /home
~~~

Zum Entpacken:

~~~
tar xvpf somewhere/home.tar.gz
~~~

[Eine alternative Methode für ein Backup ist rdiff.](sys-admin-rdiff-de.htm#rdiff) 

<div class="divider" id="home-move"></div>

## Verschieben von /home

**`Ein existierendes $home einer anderen Distribution soll nicht verwendet oder geteilt werden, da es bei Verwendung eines gleichen Nutzernamens bei Konfigurationsdateien zu Konflikten kommen kann/wird.`** 

Das Verschieben oder Einbinden eines existierenden /home einer siduction-Installation kann auf zwei Arten durchgeführt werden: mit der Live-CD oder in der Konsole. Beides ist nicht kompliziert.

Das System benötigt die [UUID-Information](part-uuid-de.htm#uuid)  der neuen Partition 

Man fügt die UUID-Information am besten vor dem Verschieben von /home mit einem Kommentarzeichen # am Anfang der Zeile in `/etc/fstab`  ein.

Der PC wird neu gestartet und in die grub-Befehlszeile wird eine 1 eingegeben und die Eingabetaste Enter gedrückt. Der PC startet in den Runlevel 1, das ist Single-User-Modus ohne Einbindung des /home, was ein sicheres Arbeiten gewährleistet.

In der TTY-Konsole meldet man sich als Root an und bindet die neue /home-Partition ein, zum Beispiel:

~~~
mount /dev/sdxX /media/new-home
cp -pr /home /media/new-home
~~~

Als nächstes bearbeitet man `/etc/fstab` , um das neue /home zu aktivieren: 

~~~
mcedit /etc/fstab
~~~

`Entfernung des Kommentarzeichens #`  in der Zeile für das neue /home und `Setzung eines Kommentarzeichens #`  am Beginn der Zeile des alten /home. Man sichert mit F2 und beendet den Editor mit F10, danach wird der PC neu gestartet.

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
