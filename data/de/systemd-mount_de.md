% Systemd - mount

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

Änderungen 2021-02 bis 03:

+ Neu "systemd-mount Unit"  
+ Für die Verwendung mit pandoc optimiert.

Änderungen 2021-04

+ Durch "systemd-unit-datei" erforderliche Anpassungen

ENDE   INFOBEREICH FÜR DIE AUTOREN

## systemd-mount

Die grundlegenden und einführenden Informationen zu Systemd enthält die Handbuchseite [Systemd-Start](./systemd-start_de.md) Die alle Unit-Dateien betreffenden Sektionen *[Unit]* und *[Install]* behandelt unsere Handbuchseite [Systemd Unit-Datei](./systemd-unit-datei_de.md)  
In der vorliegenden Handbuchseite erklären wir die Funktion der systemd-Unit **mount** und **automount**. Mit ihnen verwaltet systemd Einhängepunkte für Laufwerke und deren Partitionen, die sowohl lokal als auch über das Netzwerk erreichbar sein können.

Die **mount**-Unit ist eine Konfigurationsdatei, die für systemd Informationen über einen Einhängepunkt bereitstellt.  
Die **automount**-Unit überwacht das Dateisystem und aktiviert die gleichnamige *.mount-Unit*, wenn das darin bezeichnete Dateisystem verfügbar ist.

Für unmittelbar im PC verbaute Laufwerke und deren Partitionen verwenden wir nur die *mount*-Unit. Sie wird aktiviert (enabled) und gestartet um die Laufwerke bei jedem Boot einzuhängen.  
Bei Netzwerk-Dateisystemen bietet die *mount*-Unit den Vorteil, Abhängigkeiten deklarieren zu können, damit die Unit erst aktiv wird, wenn das Netzwerk bereit steht. Auch hier benutzen wir nur die *mount*-Unit und aktivieren und starten sie, um das Netzwerk-Dateisystemen bei jedem Boot einzuhängen. Die *mount*-Unit unterstützt alle Arten von Netzwerk-Dateisystemen (NFS, SMB, FTP, WEBDAV, SFTP, SSH).

Entfernbare Geräte, wie USB-Sticks, und Netzwerk-Dateisysteme, die nicht permanent erreichbar sind, müssen immer an eine *.automount*-Unit gekoppelt werden. In diesem Fall darf die *mount*-Unit nicht aktiviert werden und sollte auch keine [Install]-Sektion enthalten.

*mount*- und *automount*-Units müssen nach dem Einhängepunkt, den sie steuern, benannt sein. Beispiel: Der Einhängepunkt "/home/musteruser" muss in einer Unit-Datei "home-musteruser.mount", bzw. "home-musteruser.automount", konfiguriert werden.

Die in der "*/etc/fstab*" deklarierten Geräte und ihre Einhängepunkte übersetzt systemd in der frühen Bootphase mit Hilfe des "*systemd-fstab-generators*" in native *mount*-Units.

### Inhalt der mount-Unit

Die *mount*-Unit verfügt über die folgenden Optionen in der zwingend erforderlichen [Mount]-Sektion:

+ **What=** (Pflicht)  
 	Enthält den absoluten Pfad des eingehängten Geräts, also z.B. Festplatten-Partitionen wie /dev/sda8 oder eine Netzwerkfreigabe wie NFSv4 oder Samba.

+ **Where=** (Pflicht)  
 	Hier wird der Einhängepunkt (mount point) festgelegt, d.h. der Ordner, in den die Partition, das Netzlaufwerk oder Gerät eingehängt werden soll. Falls dieser nicht existiert, wird er beim Einhängen erzeugt.

+ **Type=** (optional)  
    Hier wird der Typ des Dateisystems angegeben, gemäß dem mount-Parameter -t.

+ **Options=** (optional)  
 	Enthält alle verwendeten Optionen in einer Komma getrennten Liste, gemäß dem mount-Parameter -o.

+ **LazyUmount=** (Standard: off)  
 	Wenn der Wert auf true gesetzt wird, wird das Dateisystem wieder ausgehängt, sobald es nicht mehr benötigt wird. 

+ **SloppyOptions=** (Standard: off)  
    Falls true, erfolgt eine entspannte Auswertung der in *Options=* festgelegten Optionen und unbekannte Einhängeoptionen werden toleriert. Dies entspricht dem mount-Parameter -s.

+ **ReadWriteOnly=** (Standard: off)  
    Falls false, wird bei dem Dateisystem oder Gerät, das read-write eingehängt werden soll, das Einhängen aber scheitert, versucht es read-only einzuhängen. Falls true, endet der Prozess sofort mit einem Fehler, wenn die Einhängung read-write scheitert. Dies entspricht dem mount-Parameter -w. 

+ **ForceUnmount=** (Standard: off)  
    Falls true, wird das Aushängen erzwungen wenn z. B. ein NFS-Dateisystem nicht erreichbar ist. Dies entspricht dem mount-Parameter -f. 

+ **DirectoryMode=** (Standard: 0755)  
    Die, falls notwendig, automatisch erzeugten Verzeichnisse von Einhängepunkten, erhalten den deklarierten Dateisystemzugriffsmodus. Akzeptiert einen Zugriffsmodus in oktaler Notation.

+ **TimeoutSec=** (Vorgabewert aus der Option *DefaultTimeoutStartSec=* in systemd-system.conf)  
    Konfiguriert die Zeit, die auf das Beenden des Einhängebefehls gewartet wird. Falls ein Befehl sich nicht innerhalb der konfigurierten Zeit beendet, wird die Einhängung als fehlgeschlagen betrachtet und wieder heruntergefahren. Akzeptiert einen einheitenfreien Wert in Sekunden oder einen Zeitdauerwert wie »5min 20s«. Durch Übergabe von »0« wird die Zeitüberschreitungslogik deaktiviert.

### Inhalt der automount-Unit

Die *automount*-Unit verfügt über die folgenden Optionen in der zwingend erforderlichen [Automount]-Sektion:

+ **Where=** (Pflicht)  
 	Hier wird der Einhängepunkt (mount point) festgelegt, d.h. der Ordner, in den die Partition, das Netzlaufwerk oder Gerät eingehängt werden soll. Falls dieser nicht existiert, wird er beim Einhängen erzeugt.

+ **DirectoryMode=** (Standard: 0755)  
    Die, falls notwendig, automatisch erzeugten Verzeichnisse von Einhängepunkten erhalten den deklarierten Dateisystemzugriffsmodus. Akzeptiert einen Zugriffsmodus in oktaler Notation.

+ **TimeoutIdleSec=** (Standard: 0)  
    Bestimmt die Zeit der Inaktivität, nach der systemd versucht das Dateisystem auszuhängen. Akzeptiert einen einheitenfreien Wert in Sekunden oder einen Zeitdauerwert wie »5min 20s«. Der Wert "0" deaktiviert die Option.

### Beispiele

Systemd liest den Einhängepunkt aus dem Namen der *mount*- und *automount*-Units. Deshalb müssen sie nach dem Einhängepunkt, den sie steuern, benannt sein.  
Dabei ist zu beachten, keine Bindestriche "-" in den Dateinamen zu verwenden, denn sie deklarieren ein neues Unterverzeichnis im Verzeichnisbaum. Einige Beispiele:

+ unzulässig: /data/home-backup
+ zulässig: /data/home_backup
+ zulässig: /data/home\\x2dbackup

Um einen fehlerfreien Dateinamen für die *mount*- und *automount*-Unit zu erhalten, verwenden wir im Terminal den Befehl "systemd-escape".

~~~
$ systemd-escape -p --suffix=mount "/data/home-backup"
  data/home\x2dbackup.mount
~~~

**Festplatten-Partition**  
Eine Partition soll nach jedem Systemstart unter "/disks/TEST" erreichbar sein.  
Wir erstellen mit einem Texteditor die Datei "disks-TEST.mount" im Verzeichnis "/usr/local/lib/systemd/system/". (Ggf. ist das Verzeichnis zuvor mit dem Befehl **`mkdir -p /usr/local/lib/systemd/system/`** anzulegen.)

~~~
[Unit]
Description=Mount /dev/sdb7 at /disks/TEST
After=blockdev@dev-disk-by\x2duuid-a7af4b19\x2df29d\x2d43bc\x2d3b12\x2d87924fc3d8c7.target
Requires=local-fs.target
Wants=multi-user.target

[Mount]
Where=/disks/TEST
What=/dev/disk/by-uuid/a7af4b19-f29d-43bc-3b12-87924fc3d8c7
Type=ext4
Options=defaults,noatime

[Install]
WantedBy=multi-user.target
~~~

Anschließend aktivieren und starten wir die neue *.mount*-Unit.

~~~
# systemctl enable --now disks-TEST.mount
~~~

**NFS**  
Das "document-root"-Verzeichnis eines Apache Webservers im heimischen Netzwerk soll in das Home-Verzeichnis des Arbeitsplatz-Rechners mittels NFS eingehängt werden.  
Wir erstellen mit einem Texteditor die Datei "home-\<user\>-www_data.mount" im Verzeichnis "/usr/local/lib/systemd/system/".  
"\<user\>" bitte mit dem eigenen Namen ersetzen.

~~~
[Unit]
Description=Mount server1/var/www/ using NFS
After=network-online.target
Wants=network-online.target

[Mount]
What=192.168.3.1:/
Where=/home/<user>/www_data
Type=nfs
Options=nfsvers=4,rw,users,soft
ForceUnmount=true
~~~

Diese Datei enthält keine [Install]-Sektion und wird auch nicht aktiviert. Die Steuerung übernimmt die nun folgende Datei "home-\<user\>-www_data.automount" im gleichen Verzeichnis.

~~~
[Unit]
Description=Automount server1/var/www/ using NFS
ConditionPathExists=/home/<user>/www_data
Requires=NetworkManager.service
After=network-online.target
Wants=network-online.target

[Automount]
Where=/home/<user>/www_data
TimeoutIdleSec=60

[Install]
WantedBy=remote-fs.target
WantedBy=multi-user.target
~~~

Anschließend:

~~~
# systemctl enable --now home-<user>-www_data.automount
~~~

Jetzt wird das "document-root"-Verzeichnis des Apache Webservers eingehangen, sobald wir in das Verzeichnis "/home/\<user\>/www_data" wechseln.  
Die Statusabfrage bestätigt die Aktion.

~~~
# systemctl status home-<user>-www_data.mount --no-pager
● home-<user>-www_data.mount - Mount server1/var/www/ using NFS
     Loaded: loaded (/usr/local/lib/systemd/system/home-<user>-www_data.mount; disabled; vendor preset: enabled)
     Active: active (mounted) since Wed 2021-03-10 16:27:58 CET; 8min ago
TriggeredBy: ● home-<user>-www_data.automount
      Where: /home/<user>/www_data
       What: 192.168.3.1:/
      Tasks: 0 (limit: 4279)
     Memory: 120.0K
        CPU: 5ms
     CGroup: /system.slice/home-<user>-www_data.mount
[...]

# systemctl status home-<user>-www_data.automount --no-pager
● home-<user>-www_data.automount - Automount server1/var/www/ usuing NFS
     Loaded: loaded (/usr/local/lib/systemd/system/home-<user>-www_data.automount; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-03-10 16:27:58 CET; 8min ago
   Triggers: ● home-<user>-www_data.mount
      Where: /home/<user>/www_data
[...]
~~~

Der Journalauszug protokolliert anschaulich die Funktion von "TimeoutIdleSec=60" zum Aushängen des Dateisystems und das wieder Einhängen durch den Start des Dateimanagers Thunar sowie einen Aufruf von "/home/\<user\>/www_data" im Terminal.

~~~
# journalctl -f -u home-<user>-www_data.*
[...]
Mär 10 17:56:14 pc1 systemd[1]: Mounted Mount server1/var/www/ using NFS.
Mär 10 17:57:34 pc1 systemd[1]: Unmounting Mount server1/var/www/ using NFS...
Mär 10 17:57:35 pc1 systemd[1]: home-<user>-www_data.mount: Succeeded.
Mär 10 17:57:35 pc1 systemd[1]: Unmounted Mount server1/var/www/ using NFS.
Mär 10 17:58:14 pc1 systemd[1]: home-<user>-www_data.automount: Got automount request for /home/<user>/www_data, triggered by 2500 (Thunar)
Mär 10 17:58:14 pc1 systemd[1]: Mounting Mount server1/var/www/ using NFS...
Mär 10 17:58:14 pc1 systemd[1]: Mounted Mount server1/var/www/ using NFS.
Mär 10 18:00:15 pc1 systemd[1]: Unmounting Mount server1/var/www/ using NFS...
Mär 10 18:00:15 pc1 systemd[1]: home-<user>-www_data.mount: Succeeded.
Mär 10 18:00:15 pc1 systemd[1]: Unmounted Mount server1/var/www/ using NFS.
Mär 10 18:00:30 pc1 systemd[1]: home-<user>-www_data.automount: Got automount request for /home/<user>/www_data, triggered by 6582 (bash)
Mär 10 18:00:30 pc1 systemd[1]: Mounting Mount server1/var/www/ using NFS...
Mär 10 18:00:30 pc1 systemd[1]: Mounted Mount server1/var/www/ using NFS.
Mär 10 18:01:51 pc1 systemd[1]: Unmounting Mount server1/var/www/ using NFS...
Mär 10 18:01:51 pc1 systemd[1]: home-<user>-www_data.mount: Succeeded.
Mär 10 18:01:51 pc1 systemd[1]: Unmounted Mount server1/var/www/ using NFS.
[...]
~~~

**Weitere Beispiele**  
Im Internet finden sich mit Hilfe der favorisierten Suchmaschine vielerlei Beispiele für die Anwendung der *mount*- und *automount*-Unit. Das Kapitel "Quellen" enhält einige Webseiten mit eine ganze Reihe weiterer Beispiele. Dringend empfohlen sind auch die man-Pages.

### Quellen sytemd-mount

[Deutsche Manpage, systemd.mount](https://manpages.debian.org/testing/manpages-de/systemd-mount.1.de.html)  
[Deutsche Manpage, mount](https://manpages.debian.org/testing/manpages-de/mount.8.de.html)  
[Manjaro Forum, systemd.mount](https://forum.manjaro.org/t/root-tip-systemd-mount-unit-samples/1191)  
[Manjaro Forum, Use systemd to mount ANY device](https://forum.manjaro.org/t/root-tip-use-systemd-to-mount-any-device/1185)  
[Linuxnews, nfs per systemd](https://linuxnews.de/2019/12/nfs-freigaben-per-systemd-einbinden/)  
[Debianforum, Netzlaufwerke einbinden](https://wiki.debianforum.de/Netzlaufwerke_einbinden)  
[Ubuntuusers, Mount-Units](https://wiki.ubuntuusers.de/systemd/Mount_Units/)

<div id="rev">Seite zuletzt aktualisert 2021-04-06</div>
