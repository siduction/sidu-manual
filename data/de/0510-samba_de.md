% SAMBA

## SAMBA

### Client-Konfiguration

**um mit siduction über das Netzwerk auf Windows-Freigaben zugreifen zu können**

+ Alle Befehle werden in einem Terminal oder einer Konsole als  **root**  ausgeführt.

+ Die URL wird in Dolphin als normaler **user** aufgerufen .  
    server = Servername oder IP der Windows-Maschine  
    share = Name der Freigabe
    
    Im KDE-Dateimanager Dolphin wird die URL folgendermaßen eingeben: `smb://server`  oder mit dem gesamten Pfad: `smb://server/share` 

In einer Konsole können die Freigaben auf einem Server damit gesehen werden:

~~~
smbclient -L server
~~~

Um eine Freigabe in einem Verzeichnis sehen zu können (mit Zugriff für ALLE User), muss ein Einhängeort (Mountpoint) existieren. Ist das nicht der Fall, muss ein Verzeichnis als Einhängepunkt erstellt werden (der Name ist beliebig):

~~~
mkdir -p /mnt/server_share
~~~

Eine Freigabe wird mit diesem Befehl eingehängt:

~~~
mount -t cifs -o username=Administrator,uid=$UID,gid=$GID //server/share /mnt/server_share
~~~

sollte es hier zu einer Fehlermeldung kommen, dann kann das an der verwendeten SMB Protokoll-Version liegen.
In Debian wird SMB 1.0 aus Sicherheitsgründen nicht mehr benutzt. Leider gibt es auch heute noch Systeme, welche 
SMB nur per Version 1.0 bereit stellen. Um auf solch eine Freigabe zugreifen zu können, wird als Mountoption
dann noch `vers=1.0` benötigt. Der komplette Befehl lautet dann

~~~
mount -t cifs -o username=Administrator,vers=1.0,uid=$UID,gid=$GID //server/share /mnt/server_share
~~~

Eine Verbindung wird mit diesem Befehl beendet:

~~~
umount /mnt/server_share
~~~

Um einen Samba-Share automatisch einzubinden, kann die Datei `/etc/fstab` nach folgendem Muster ergänzt werden (alles in einer Zeile):

~~~
//server/share /mnt/server_share cifs noauto,x-systemd.
automount,x-systemd.idle-timeout=300,user=username,
password=**********,uid=$UID,gid=$GID   0 0
~~~

Es ist aber nicht empfehlenswert, das Passwort im Klartext in die fstab zu schreiben. Als bessere Variante erzeugt man `~.smbcredentials` mit folgendem Inhalt an:

~~~
username=<benutzer>
password=<passwort>
~~~

Der resultierende Eintrag für /etc/fstab ist dann (alles in einer Zeile):

~~~
//server/share /mnt/server_share cifs noauto,x-systemd.
automount,x-systemd.idle-timeout=300,credentials=</pfad/
zu/.smbcredentials>,uid=$UID,gid=$GID 0 0
~~~

Die Variablen *"UID"* und *"GID"* entsprechen denen des users, dem das Share gegeben werden soll. Man kann aber auch `uid=<username>` und `gid=<groupname>` schreiben.

### siduction als Samba-Server

Natürlich kann man in siduction auch einen SMB-Server stellen. Die Einrichtung als Samba-Server hier im Handbuch zu beschreiben würde den Rahmen allerdings sprengen. Das Internet hält viele HowTo zu diesem Thema bereit.

Unsere Empfehlungen:

[Thomas Krenn, Einfache Samba Freigabe unter Debian](https://www.thomas-krenn.com/de/wiki/Einfache_Samba_Freigabe_unter_Debian)  
[Debian, Windows Freigaben mit Samba](https://debian-handbook.info/browse/de-DE/stable/sect.windows-file-server-with-samba.html)  

Es finden sich noch viele weitere Seiten zu diesem Thema im Netz.

<div id="rev">Zuletzt bearbeitet: 2022-04-20</div>
