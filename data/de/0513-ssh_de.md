% Secure Shell

## SSH

> **SSH aktivieren**  
> Bei siduction ist ssh sowohl auf dem Live-ISO als auch nach der Installation nicht aktiviert!  
> Um *ssh* zu aktivieren und deaktivieren nutzen Sie bitte die Scripte `sshactivate` und `sshdeactivate`. Sie befinden sich in `/usr/sbin`.  
> Alternativ nutzen sie die Starter im Anwendungsmenü > Internet/Netzwerk.

**Definition von SSH aus [Wikipedia](http://de.wikipedia.org/wiki/Secure_Shell)** :

Secure Shell oder SSH bezeichnet sowohl ein Netzwerkprotokoll als auch entsprechende Programme, mit deren Hilfe man auf eine sichere Art und Weise eine verschlüsselte Netzwerkverbindung mit einem entfernten Gerät herstellen kann. Häufig wird diese Methode verwendet, um sich eine entfernte Kommandozeile quasi auf den lokalen Rechner zu holen, das heißt, auf der lokalen Konsole werden die Ausgaben der entfernten Konsole ausgegeben und die lokalen Tastatureingaben werden an den entfernten Rechner gesendet. Hierdurch wird der Effekt erreicht, als säße man vor der entfernten Konsole, was beispielsweise sehr gut zur Fernwartung eines in einem entfernten Rechenzentrum stehenden Root-Servers genutzt werden kann. Die neuere Protokoll-Version SSH-2 bietet weitere Funktionen wie Datenübertragung per SFTP.

Generell sollte SSH zur Remote Steuerung nur konfiguriert und eingesetzt werden, wenn man sich sicher ist, welche Auswirkungen die Einstellungen in der Datei `/etc/ssh/sshd_config` und ggf. den Dateien im Verzeichnis `/etc/ssh/sshd_config.d/` haben.  
Im Zweifel ist die Dokumentation in den Manpages **`man sshd_config`**, **`man ssh_config`** oder in Internet zu studieren, oder der Rat fachkundiger Personen einzuholen.

### SSH absichern 

Es ist nicht sicher, Root-Anmeldungen via SSH zum Standard zu machen. Debian sollte sicher sein, nicht unsicher. Ebenso sollen Angreifer nicht die Möglichkeit haben, über einen längeren Zeitraum einen wortlistenbasierten Passwort Angriff (brute force attack) auf den SSH-Login durchzuführen. Deshalb nehmen wir einige Änderungen in der Datei `/etc/ssh/sshd_config` vor.

**Folgende Einstellungen können zur Erhöhung der Sicherheit angepasst werden:**  
(Um die Funktion der Einträge zu aktivieren muss das Kommentarzeichen '#' entfernt werden.)

+ **Port <gewünschter Port>**:  
  Dieser Eintrag muss auf den Port verweisen, der auf dem Router zur Weiterleitung freigeschaltet ist. Die IANA hat dem Protokoll den TCP-Port 22 zugeordnet und Debian setzt ihn als Standard. Es ist jedoch ratsam einen Port außerhalb des Standardscanbereichs zu verwenden. Wir benutzen deswegen z.B. Port 5874 um Angriffe zu erschweren, da der SSH-Port dem Angreifer nicht bekannt ist.

  ~~~
  Port 5874
  ~~~

+ **ListenAddress <IP des Rechners oder der Netzwerkschnittstelle>**:  
  Da der Port vom Router weitergeleitet wird, muss der Rechner eine statische IP-Adresse benutzen, sofern kein lokaler DNS-Server verwendet wird. Aber wenn etwas so Kompliziertes wie SSH unter Benutzung eines lokalen DNS-Servers aufgesetzt werden soll und diese Anweisungen benötigt werden, kann sich leicht ein gravierender Fehler einschleichen. Wir verwenden eine statische IP für das Beispiel:

  ~~~
  ListenAddress 192.168.2.134
  ~~~

  Das SSH Protokoll 2 mit seinen verbesserten und erweiterten Funktionen ist bereits Grundeinstellung bei Debian.

+ **LoginGraceTime <Zeitrahmen des Anmeldevorgangs>**:  
  Die erlaubte Zeitspanne beträgt als Standard 2 Minuten. Da man für gewöhnlich keine zwei Minuten benötigt, um Benutzernamen und Passwort einzugeben, stellen wir eine etwas kürzere Zeitspanne ein:

  ~~~
  LoginGraceTime 30
  ~~~

  Nun hat man 30 Sekunden Zeit zum Anmelden, und Hacker haben keine zwei Minuten bei jedem Versuch, das Passwort zu knacken.

+ **PermitRootLogin <prohibit‐password>**:  
  Warum Debian hier Erlaubnis zur Anmeldung als Root erteilt, ist nicht nachvollziehbar. Wir korrigieren zu `no`:

  ~~~
  PermitRootLogin no
  StrictModes yes
  ~~~
  
  Alternativ kann man diese Option auf *forced‐commands‐only* setzen. Damit wird die Anmeldung von root über asymmetrische Authentifizierung erlaubt, aber nur falls die Option *command* festgelegt wurde (was nützlich für die Durchführung ferner Sicherungskopien ist, selbst wenn die Anmeldung von root normalerweise nicht erlaubt ist). Alle anderen Authentifizierungsmethoden für root bleiben deaktiviert.  

+ **MaxAuthTries <Anzahl der erlaubten Anmeldungsversuche>**:  
  Mehr als 3 oder 4 Versuche sollten nicht ermöglicht werden:

  ~~~
  MaxAuthTries 3
  ~~~

**Folgende Einstellungen müssen hinzugefügt werden, so sie nicht vorhanden sind:**

+ **AllowUsers <xxx>**:  
  Benutzernamen, welchen der Zugriff via SSH erlaubt ist, getrennt durch Leerzeichen. Nur eingetragene Benutzer können den Zugang verwenden, und dies nur mit Benutzerrechten. Mit `adduser`  sollte man einen User hinzufügen, der speziell zur Nutzung von SSH verwendet wird:

  ~~~
  AllowUsers werauchimmer1 werauchimmer2
  ~~~

+ **PermitEmptyPasswords <xxx>**:  
  dem Benutzer soll ein schönes langes Passwort gegeben werden, das man in einer Million Jahren nicht erraten kann. Dieser Benutzer sollte der einzige mit SSH Zugriff sein. Ist er einmal angemeldet, kann er mit `su`  Root werden:

  ~~~
  PermitEmptyPasswords no
  ~~~

+ **PasswordAuthentication <xxx>**:  
  natürlich muss hier 'yes' gesetzt werden. Es sei denn, man verwendet einen KeyLogin.

  ~~~
  PasswordAuthentication yes
  ~~~

Schlussendlich:

~~~
systemctl restart ssh
~~~

Nun hat man eine etwas sicherere SSH-Konfiguration. Nicht vollkommen sicher, nur besser, vor allem wenn man einen Benutzer hinzugefügt hat, der speziell zur Verwendung mit SSH dient.

### SSH für X-Window Programme

ssh -X ermöglicht die Verbindung zu einem entfernten Computer und die Anzeige von dessen Grafikserver X auf dem eigenen lokalen Computer. Den Befehl gibt man als Benutzer (nicht als Root) ein (und man beachte, dass X ein Großbuchstabe ist):

~~~
$ ssh -X username@xxx.xxx.xxx.xxx (or IP)
~~~

Man gibt das Passwort für den Benutzernamen des entfernten Computers ein und startet eine graphische Anwendung in der Shell. Beispiele:

~~~
$ iceweasel ODER libreoffice ODER kspread
~~~

Bei sehr langsamen Verbindungen kann es von Vorteil sein, die Komprimierungsoption zu nutzen, um die Übertragungsrate zu erhöhen. Bei schnellen Verbindungen kann es jedoch zum entgegengesetzten Effekt kommen:

~~~
$ ssh -C -X username@xxx.xxx.xxx.xxx (or IP)
~~~

Weitere Informationen erhält man mit **`man ssh`**

**Anmerkung:**  
Falls ssh eine Verbindung verweigert und man eine Fehlermeldung erhält, sucht man in $HOME nach dem versteckten Verzeichnis `.ssh` , löscht die Datei `known_hosts`  und versucht einen neuen Verbindungsaufbau. Dieses Problem tritt hauptsächlich auf, wenn man die IP-Adresse dynamisch zugewiesen hat (DCHP).

### Kopieren scp via ssh

**scp** ist ein Befehlszeilenprogramm (Terminal/CLI), um Dateien zwischen Netzwerkcomputern zu kopieren. Es verwendet ssh zur Authentifizierung und zum sicheren Datentransfer, daher verlangt scp zur Anmeldung ein Passwort bzw. eine Passphrase.

So man ssh-Rechte an einem Netzwerk-PC oder Netzwerk-Server besitzt, ermöglicht scp das Kopieren von Partitionen, Verzeichnissen oder Dateien zu oder von einem Netzwerkcomputer (bzw. zu einem Bereich auf selbigem), für den man Zugangsrechte besitzt. Dies kann zum Beispiel ein PC oder Server im lokalen Netzwerk sein oder aber auch ein Computer in einem fremden Netzwerk oder ein lokales USB-Laufwerk. Der Kopiervorgang kann zwischen entfernten Computern/Speichergeräten stattfinden.

Es können rekursiv auch ganze Partitionen bzw. Verzeichnisse mit dem Befehl `scp -r`  kopiert werden. Zu beachten ist, dass scp -r auch symbolischen Links im Verzeichnisbaum folgt.

**Beispiele:**

1. Kopieren einer Partition:

   ~~~
   scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/ /media/diskXpartX/
   ~~~

2. Kopieren eines Verzeichnisses auf einer Partition, in diesem Fall eines Verzeichnisses mit der Bezeichnung "photos" im $HOME:

   ~~~
   scp -r <user>@xxx.xxx.x.xxx:~/photos/ /media/diskXpartX/xx
   ~~~

3. Kopieren einer Datei in einem Verzeichnis einer Partition, in diesem Fall eine Datei im $HOME:

   ~~~
   scp <user>@xxx.xxx.x.xxx:~/filename.txt /media/diskXpartX/xx
   ~~~

4. Kopieren einer Datei auf einer Partition:

   ~~~
   scp <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt /media/diskXpartX/xx
   ~~~

5. Falls man sich im Laufwerk bzw. Verzeichnis befindet, in das ein Verzeichnis bzw. eine Datei kopiert werden soll, verwendet man nur einen **.** (Punkt):

   ~~~
   scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt . 
   ~~~

Weitere Informationen bietet die Manpage:

~~~
man scp
~~~

### SSH mit Dolphin oder Thunar

Dolphin und Thunar sind fähig, auf Daten eines entfernten Rechners zuzugreifen, indem sie das *"sftp"* Protokoll benutzen, welches in ssh vorhanden ist.

So wird es gemacht:

1. **Für einen entfernten Server**  
  Man öffnet ein neues Dateimanager-Fenster oder einen neuen Reiter.  
  Eingabe in die Adress-Leiste nach dem Muster:  
    - `sftp://username@ssh-server.com`  
    Dann öffnet sich ein Dialog-Fenster und fragt nach dem SSH-Passwort. Man gibt das Passwort ein und klickt auf OK,  
    - oder die Eingabe enthält bereits das Passwort:  
    `sftp://username:password@remote_hostname_or_ip`  
    Es wird nicht nach einem Passwort gefragt, man wird direkt verbunden.

2. **Für eine LAN-Umgebung**  
  Nach dem gleichen Muster wie zuvor:  
    - `sftp://username@192.168.x.x`  
    mit Dialog-Fenster für das SSH-Passwort,  
    - oder gleich mit Passwort:  
    `sftp://username:passwort@192.168.x.x`

Bitte richtige IP eingeben!  
Eine SSH-Verbindung ist nun hergestellt. In diesem Fenster kann man mit den Dateien auf dem SSH-Server arbeiten, als wären es lokale Dateien.

**ANMERKUNG:**  
Wenn ein anderer Port als 22 (Grundeinstellung) benutzt wird, muss dieser bei Verwendung von sftp angegeben werden. Die Eingabe folgt dann der Syntax:  
`sftp://user@ip:port`,  
dies ist auch die Standardsyntax für viele Protokolle/Programme wie sftp und smb.

### SSHFS - auf einem entfernten Computer mounten

SSHFS ist eine einfache, schnelle und sichere Methode unter Verwendung von FUSE, um ein entferntes Dateisystem einzubinden. Auf Serverseite benötigt man ausschließlich einen laufenden ssh-daemon.

Auf Seite des Clients muss vermutlich sshfs erst installiert werden:

~~~
apt update && apt install sshfs
~~~

*fuse3* und  *groups*  sind bereits auf dem ISO und müssen nicht extra installiert werden. 

Das Einbinden eines entfernten Dateisystems ist sehr einfach:

~~~
sshfs  -o idmap=user username@entfernter_hostname:verzeichnis lokaler_mountpunkt
~~~

Wenn kein bestimmtes Verzeichnis angegeben wird, wird das Home-Verzeichnis des entfernten Nutzers eingebunden. Bitte beachten: der Doppelpunkt "**`:`**" ist unbedingt erforderlich, auch wenn kein Verzeichnis angegeben wird!

Nach erfolgter Einbindung verhält sich das entfernte Verzeichnis wie jedes andere lokale Dateisystem. Man kann wie auf einem lokalen Dateisystem nach Dateien suchen, diese lesen und ändern sowie Skripte ausführen.

Die Einbindung des entfernten Hosts wird mit folgendem Befehl gelöst:

~~~
fusermount -u lokaler_mountpunkt
~~~

Bei regelmäßiger Nutzung von sshfs empfiehlt sich ein Eintrag in der Datei `/etc/fstab` (alles in einer Zeile):

~~~
sshfs#remote_hostname://remote_directory /local_mount_
 point fuse -o idmap=user ,allow_other,uid=1000,gid=1000,
 noauto,fsname=sshfs#remote_hostname://remote_directory 0 0 
~~~

Als nächstes muss das Kommentarzeichen vor *"user_allow_other"*  in der Datei `/etc/fuse.conf`  entfernt werden:

~~~
# Allow non-root users to specify the 'allow_other'
# or 'allow_root' mount options.
#
user_allow_other
~~~

Dies ermöglicht jedem Nutzer der Gruppe fuse, das Dateisystem einzubinden bzw. zu lösen:

~~~
mount /pfad/zum/mount/punkt # Einbindung
umount /pfad/zum/mount/punkt # Lösen
~~~

Mit diesem Befehl prüft man, ob man Mitglied der Gruppe fuse ist:

~~~
cat /etc/group | grep fuse
~~~

Die Antwort sollte in etwa so aussehen:

~~~
fuse:x:117: <nutzername>
~~~

Falls der Nutzername (username) nicht gelistet ist, verwendet man als root den Befehl adduser:

~~~
adduser <nutzername> fuse
~~~

**Zur Beachtung:**  
Der Benutzer wird erst nach einem neuerlichen Einloggen Mitglied der Gruppe "fuse" sein.  
Jetzt sollte der gewünschte Nutzername gelistet und folgender Befehl ausführbar sein:

~~~
mount lokaler_mountpunkt
    und
umount lokaler_mountpunkt
~~~

<div id="rev">Zuletzt bearbeitet: 2023-10-19</div>
