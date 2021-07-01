**Status: RC1**

<div class="divider" id="configure"></div>

## SAMBA-Konfiguration, um mit siduction über das Netzwerk auf Windows-Freigaben zugreifen zu können

+ Alle Befehle werden in einem Terminal oder einer Konsole als  **root**  ausgeführt.

+ Die URL wird in Dolphin als  **normaler User aufgerufen** .  
    server = Servername oder IP der Windows-Maschine  
    share = Name der Freigabe
    
    Im KDE-Dateimanager Dolphin wird die URL folgendermaßen eingeben: `smb://server`  oder mit dem gesamten Pfad: `smb://server/share` 

In einer Konsole können die Freigaben auf einem Server damit gesehen werden:

~~~
smbclient -L server
~~~

Um eine Freigabe in einem Verzeichnis sehen zu können (mit Zugriff für ALLE User), muss ein Einhängeort (Mountpoint) existieren. Wenn nicht, muss ein Verzeichnis als Einhängepunkt erstellt werden (der Name ist beliebig):

~~~
mkdir -p /media/server_share
~~~

Eine Freigabe mit VFAT wird mit diesem Befehl eingehängt:

~~~
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777 //server/share /mnt/server_share
~~~

Eine Freigabe mit NTFS wird mit diesem Befehl eingehängt:

~~~
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777,lfs //server/share /mnt/server_share
~~~

Eine Verbindung wird mit diesem Befehl beendet:

~~~
umount /media/server_share
~~~

Um einen Samba-Share automatisch einzubinden, kann die Datei `/etc/fstab`  nach folgendem Muster ergänzt werden:

~~~
//server/share /mnt/server_share cifs defaults,username=your_username,password=**********,file_mode=0777,dir_mode=0777 0 0
~~~

<div class="divider" id="setup"></div>

## siduction als Samba-Server aufsetzen

Samba befindet sich nicht auf der Live-CD, daher sind folgende Schritte notwendig, um einen Samba-Netzwerkzugang zu erhalten:

~~~
apt-get update
apt-get install samba samba-tools smbclient smbfs samba-common-bin
~~~

### Festplatteninstallationen:

#### Example 1:

Auf einer Festplatteninstallation muss die Samba-Konfiguration angepasst werden. Im Folgenden geben wir ein einfaches Beispiel. Mehr zum Aufsetzen eines Linux-Samba-Servers findet man auf den [Dokumentationsseiten von Samba](http://de4.samba.org/samba/) .

Die Samba-Konfiguration wird wie folgt angepasst:

Als root wird die Datei `/etc/samba/smb.conf`  in einem Editor wie kedit oder kwrite geöffnet:

~~~
# Globale Konfiguration - sie soll so einfach wie möglich sein - keine Passwörter, Verhalten wie Windows 9x

[global]
security = share
workgroup = WORKGROUP

# Freigabe ohne Schreibrechte - wichtig, wenn NTFS-Partitionen freigegeben werden!

[WINDOWS]
comment = Windows-Partition
browseable = yes
writable = no
path = /media/XXXX # <-- "XXXX" muss der existierenden Partition entsprechen
public = yes

# Freigabe einer Partition mit Schreibrechten - die Partition muss eingebunden (gemountet) sein
# schreibbar macht Sinn, z. B. mit Fat32

[DATA]
comment = Datenpartition (erste erweiterte Partition)
browseable = yes
writable = yes
path = /media/sda5
public = yes
~~~

Neustart des Samba-Servers:

~~~
systemctl restart smbd.service
~~~

## Überprüfen von Samba-Freigaben

Freigaben ohne Sicherheitsbeschränkungen (zum Beispiel für ein LAN) werden folgendermaßen gesetzt.

Das Verzeichnis und sein Inhalt muss zumindest die Rechtevergabe -rwxr-xr-x haben, dies wird geprüft mit:

~~~
ls -la Pfad/zum/Sambaverzeichnis/*
~~~

Die Rechte können so gesetzt werden:

~~~
chmod -R 755 Pfad/zum/Sambaverzeichnis
~~~

Um ein Verzeichnis für alle Nutzer schreibbar zu setzen:

~~~
chmod -R 777 Pfad/zum/Sambaverzeichnis
~~~

Nach einem Neustart des Samba-Servers kann getestet werden, ob alles funktioniert:

~~~
smbclient -L localhost
~~~

Die Ausgabe sollte in etwa so aussehen:

~~~
smbclient -L localhost
Password:
Domain=[HOME] OS=[Unix] Server=[Samba 3.0.26a]

Sharename Type Comment
--------- ---- -------
IPC$ IPC IPC Service (3.0.26a)
MaShare Disk comment
print$ Disk Printer Drivers
Domain=[MSHOME] OS=[Unix] Server=[Samba 3.0.26a]
~~~

Falls kein Passwort gesetzt wurde, wird bei der Passwortanfrage die Taste ENTER gedrückt.

 Samba wird gestartet und gestoppt mit:

~~~
systemctl start smbd.service
~~~

beziehungsweise

~~~
systemctl stop smbd.service
~~~

Samba kann auch automatisch beim Booten gestartet werden:

~~~
systemctl enable --now smbd.service
~~~

Samba startet jetzt beim Booten.

[Weitere Informationen zu Samba (auf Englisch)](http://wiki.linuxquestions.org/wiki/Samba) 

<div id="rev">Page last revised 15/01/2012 1045 UTC</div>
