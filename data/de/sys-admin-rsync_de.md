
<div class="divider" id="rsync"></div>

## Backup mit rsync

rsync ist ein Hilfsprogramm, um Dateien zu synchronisieren und ein Backup anzulegen. Es ist Bestandteil vieler *nix-Systeme.

 **`Eine Beschränkung von rsync ist, dass Daten NICHT zwischen zwei entfernten Systemen kopiert werden können. Ein Workaround wäre, dass die Daten eines entfernten Systems auf den lokalen Rechner kopiert werden, um dann mit rsync die Daten des zweiten entfernten Rechners abzugleichen.`**
 
Mit siduction hat man verschiednen Möglichkeiten, den Prozess zu starten. Entweder startet man rsync in einem Terminal mit eigenen BEfehlen oder mittels dieses Programms aus Debian Sid:

#### Für das Debian-Programm:

~~~
apt-get install luckybackup
~~~

[Homepage of luckybackup.](http://luckybackup.sourceforge.net/) 

#### Anleitung für die Nutzung in einem Terminal


Im folgenden Abschnitt stellen wir rsync vor, was für Möglichkeiten mit diesem Programm gegeben sind und einige Beispiele, wie man rsync für ein eigenes Backup-Skript verwenden kann.

rsync ist ein einfach zu bedienendes Programm zum schnellen Erstellen von Backups von Verzeichnissen und Dateien. Es zeichnet sich durch ein intelligentes Verfahren aus, womit geänderte Dateien erkannt werden, sodass nur diese für den Kopiervorgang ausgewählt werden.

rsync kann weiters einen Komprimierungsalgorithmus verwenden, womit der Kopiervorgang beschleunigt wird. Dieser muss jedoch durch die Option -z explizit gesetzt werden, dessen Verwendung von unserer Seite jedoch sehr empfohlen ist. rsync ermittelt dabei geänderte Dateien und Verzeichnisse anhand von Attributen wie Größe oder Datum/Zeitpunkt, wodurch es sehr schnell selektieren kann.

Nach Auswahl der Verzeichnis- und Dateiliste ist wegen eines Komprimierungsverfahrens auch der Kopiervorgang schneller im Vergleich zu einem traditionellen Kopiervorgang. rsync komprimiert die Daten vor dem Kopiervorgang und entpackt sie am Zielort.

rsync kann folgendermaßen Daten kopieren:  
  
* von einem lokalen System zu einem lokalen System,  
* von einem lokalen System zu einem entfernten System,  
* von einem entfernten System zu einem lokalen System.

Dabei wird entweder der [ssh](ssh-de.htm#ssh) -Client (Grundeinstellung) oder ein rsync-daemon, der auf Quell- und Zielsystem läuft, benutzt. Die manpages für rsync besagen, wenn Systeme mit ssh verbunden werden können, kann rsync auch ssh nutzen.

 `Eine Beschränkung von rsync ist, dass Daten NICHT zwischen zwei entfernten Systemen kopiert werden können. Ein Workaround wäre, dass die Daten eines entfernten Systems auf den lokalen Rechner kopiert werden, um dann mit rsync die Daten des zweiten entfernten Rechners abzugleichen.`
 
Um dies zu verdeutlichen, gehen wir im folgenden Beispiel von drei Rechnern aus:

~~~
neo – das lokale System
morpheus – ein entferntes System
trinity – ein entferntes System
~~~

Jeder User hat einen anderen Nutzernamen, und rsync läuft ausschließlich auf neo, dem lokalen System:

~~~
Nutzername auf neo ist cuddles,
Nutzername auf morpheus ist tartie,
Nutzername auf trinity ist taylar.
~~~

Ziel ist der Abgleich der Verzeichnisse /home/$user/Daten:

~~~
neo: /home/cuddles/Daten nach morpheus und trinity,
morpheus: /home/tartie/Daten nach neo und trinity,
trinity: /home/taylar/Daten nach neo und morpheus.
~~~

Nun steht man vor dem Problem, dass rsync nicht zwischen zwei entfernten Rechnern eingesetzt werden kann:

~~~
neo --> morpheus – ok, von lokal nach entfernt
neo --> trinity – ok, von lokal nach entfernt
morpheus --> neo – ok, von entfernt nach lokal
trinity --> neo – ok, von entfernt nach lokal
morpheus --> trinity – geht nicht, von entfernt nach entfernt
trinity --> morpheus – geht nicht, von entfernt nach entfernt
~~~

Um diese Beschränkung aufzulösen, muss die Verfahrensweise wie folgt angepasst werden:

~~~
morpheus --> trinity – wird zu: morpheus --> neo & neo --> trinity
trinity --> morpheus – wird zu: trinity --> neo & neo --> morpheus
~~~

Dieser zusätzliche Schritt ändert nichts am Endresultat, welches erreicht werden soll. Dennoch sei darauf hingewiesen:

 `Diese Beschränkung von rsync muss bei der Planung eines Backup-Prozesses bedacht werden.`
#### Verwendung von Hostnamen mit Hostnamen in rsync.

Die Verwendung der IP-Adressen von neo, morpheus, und trinity kann den Kopiervorgang transparenter und daher einfacher gestalten.

Dazu müssen /etc/hosts editiert und die Hostnamen wie die dazu gehörigen IP-Adressen eingefügt werden. So hat /etc/hosts in unserem Beispiel auszusehen:

~~~
192.168.1.15 neo
192.168.1.16 morpheus
192.168.1.17 trinity
~~~

Die erste Zeile übersetzt die IP-Adresse 192.168.1.15 mit “neo”, die zweite 192.168.1.16 mit “morpheus” und die dritte 192.168.1.17 mit “trinity”. Nach Abspeicherung kann der Hostname anstelle der IP-Adresse verwendet werden. Ganz besonders praktisch ist dieses Verfahren, wenn die zugeordneten IP-Adressen geändert werden, zum Beispiel bei "neo" von 192.168.1.15 auf 192.168.1.25

Besonders erleichtert dies die Arbeit mit Skripten, da diese im Falle einer Änderung der IP-Adressen nicht angepasst werden müssen, sondern nur die Datei /etc/hosts. Auch sind Skripte auf Basis der "Hostnamen-Methode" transparenter gestaltet.

### Zwei Möglichkeiten, rsync zu nutzen.

Eine Möglichkeit ist, die Daten ins Ziel zu  **schieben (push)** , die andere, die Daten von der Quelle zu  **ziehen (pull)** . Jede Methode hat ihre Vor- und Nachteile, welche jetzt erklärt werden, wobei in unserem Beispiel ein lokales und ein entferntes System verwendet werden, um die Terminologie deutlicher erklären zu können.

 **“push”**  - das lokale System trägt die Quellverzeichnisse und Quelldateien, Ziel ist das entfernte System. Der Befehl rsync wird auf dem lokalen System gestartet und “schiebt” die Daten ins Zielsystem.

Vorteile:  
* Mehr als ein System kann auf dem Zielsystem sein Backup haben.  
* Der Backup-Prozess kann über das gesamte System verteilt werden.  
* Wenn ein System schneller den Backupvorgang beendet, kann es die Ressourcen für andere Aufgaben nutzen.

Nachteile:  
* Wenn ein Skript über eine Zeitsteuerung (cron) genutzt wird, müssen verschiedene crontabs auf jedem System erstellt werden. Bei Modifikation des Skriptes muss jedes Skript auf jedem System geändert werden, bei Änderungen des Zeitplans muss jede crontab auf jedem Rechner geändert werden. Dadurch wird eine administrative Wartung sehr komplex und unübersichtlich.  
* Der Backupprozess kann nicht prüfen, ob das Zielsystem die Zielpartition eingebunden hat. Wenn diese nicht eingebunden ist, wird kein Backup erstellt.

 **“pull”**  - das entfernte System trägt die Quellverzeichnisse und Quelldateien, Ziel ist das lokale System. Der Befehl rsync wird auf dem lokalen System gestartet und “zieht” die Daten aus dem Quellsystem.

Vorteile:  
* Ein System wird zum Server, welcher alle Backupprozesse aller anderen Systeme steuert. Die Backupprozesse werden zentralisiert.  
* Bei Verwendung eines Skripts muss sich dieses nur auf einem System befinden, was Modifikationen sehr einfach gestaltet. Bei Änderung des Zeitplans muss nur eine crontab geändert werden.  
* Das Skript kann prüfen, ob die Zielpartition eingebunden ist und gegebenenfalls diese einbinden.

#### Syntax von rsync (Auszug aus "man rsync"):

~~~
rsync [OPTION]... SRC [SRC]... DEST

rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST

rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST

rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST

rsync [OPTION]... SRC

rsync [OPTION]... [USER@]HOST:SRC [DEST]

rsync [OPTION]... [USER@]HOST::SRC [DEST]

rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]
~~~

#### Arbeitsbeispiele von Befehlen mit rsync:

~~~
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home
~~~

Erklärung der einzelnen Bestandteile dieses Befehls:

~~~
Die Quelle ist: morpheus:/home/tartie,
das Ziel ist: /media/sda7/SysBackups/morpheus/home
~~~

Das Verzeichnis /home/tartie (inklusive Unterverzeichnisse) wird in /media/sda7/SysBackups/morpheus/home gesichert, was nach dem rsync so aussieht:

~~~
/media/sda7/SysBackups/morpheus/home/tartie
~~~

Die übergeordnete Verzeichnisstruktur wird nicht übernommen, der ZIELORT bestimmt die Einbindung in das Zielsystem, nicht die Verzeichnisstruktur der Quelle. Darum kann /tartie sich in /home befinden. Die "Quelle" wählt nur, woher die Daten kommen, nicht wohin sie transferiert werden. Das “Ziel” befiehlt rsync, wohin die Daten aus der "Quelle" kopiert werden sollen. Hier ein Beispiel:

~~~
rsync [...] /home/user/data/files /media/sda7/SysBackups/neo
~~~

Hier werden nur das Quellverzeichnis /files und alle sich darin befindlichen Verzeichnisse und Dateien in den Zielordner /neo kopiert – und nicht die komplette Verzeichnisstruktur /media/sda7/SysBackups/neo/home/user/data/files

Dies sollte bei Erstellung von Backupbefehlen mit rsync beachtet werden.

#### Erklärung der Optionen (Rohübersetzung aus dem englischsprachigen "man rsync"):

~~~
-a Archiv-Modus. Die manpage dazu: “einfach gesagt, eine Methode, um ein rekursives Backup zu
erstellen und beinahe alle Attribute zu bewahren. Nicht bewahrt werden Hardlinks aufgrund der
Komplexität des Verfahrens. Die Option -a entspricht: -rlptgoD, was dies bedeutet:
-r = rekursiv – Unterverzeichnisse und darin befindliche Dateien aus dem "Quellort".
-l = Links – symlinks werden am Zielort wieder hergestellt.
-p = Berechtigungen – die Berechtigungen sind identisch mit jenen am Quellort.
-t = Zeitstempel – der Zeitstempel ist identisch mit jenem am Quellort.
-q = quiet – minimale Rückmeldung. Mehr Rückmeldungen erhält man mit der Option -v sofort nach der
Option -a. Abläufe ohne jegliche Rückmeldung werden ohne Setzung der Option -v erreicht.
-o = Besitzer – wenn rsync als Root durchgeführt wird, bleiben die Besitzer entsprechend der
Quelldateien erhalten.
-D = entspricht diesen beiden Befehlen: --devices --specials
--devices = Zeichen- und Blockgerätdateien werden ins entfernte System kopiert, um wiederhergestellt
zu werden. Zu beachten ist, dass ohne die Option --super die Option --devices nicht
arbeitet.
--specials = rsync kopiert spezielle Dateien wie sockets und fifos.
-g: die Gruppen bleiben entsprechend der Quelldateien erhalten.
-E: das Attribut “ausführbar” bleibt erhalten.
-v: für eine umfassende Rückmeldung. Wenn der Kopiervorgang bekannt ist, kann diese Option
entfernt werden. Wenn jedoch beobachtet werden soll, was durchgeführt werden soll, ist diese
Option sehr nützlich.
-z: zu kopierende Daten werden komprimiert, was den Kopiervorgang beschleunigt, da die
transferierte Datenmenge geringer ist.
--delete-after = Zielverzeichnisse oder Zieldateien, die in der Quelle nicht mehr vorhanden sind,
werden nach dem Transfer gelöscht, nicht vor dem Transfer. “after” wird im Falle
von Problemen oder eines Absturzes verwendet. "delete” verhindert, dass nicht
mehr benötigte Dateien und Verzeichnisse am Zielort Platz verschwenden.
--exclude = mit dieser Option werden Dateien oder Verzeichnisse vom Kopiervorgang ausgeschlossen.
Mit --exclude=“*~” würden ALLE Dateien mit der Endung “~” vom Backupvorgang ausgeschlossen. Mit
einer Option --exclude kann nur ein Muster übergeben werden, bei mehreren Ausschließungsmustern
müssen mehrere Optionen --exclude gesetzt werden.
~~~

#### Weitere nützliche Befehlsoptionen:

~~~
-c – führt weitere Vergleichsprüfungen durch, was jedoch mehr Zeit beansprucht. Da rsync bereits
Vergleichsprüfungen durchführt, wurde dieser Befehl nicht in -a integriert, um den
Zeitaufwand durch eine redundante Option nicht zu erhöhen. Diese Option wird im Regelfall
nicht benötigt.
--super – das Zielsystem versucht Root-Aktivitäten (Super-User-Aktivitäten) durchzuführen
(siehe manpage)
--dry-run – Testlauf: zeigt, was kopiert würde. Keine Dateien werden kopiert.
~~~

Die letzten beiden Elemente unseres Befehls sind das Quellverzeichnis und schließlich das Zielverzeichnis.

#### Beispielsbefehle:

~~~
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home
~~~

Dieser Befehl kopiert alle Verzeichnisse und Dateien unterhalb von /home/tartie auf das System “morpheus” und platziert diese in das Verzeichnis /media/sda7/SysBackups/morpheus/home. Die Verzeichnisstruktur von tartie bleibt erhalten.

~~~
rsync -agEvz --delete-after --exclude=”*~” /home/tartie neo:/media/sda7/SysBackups/morpheus/home
~~~

Dies ist der umgekehrte Befehl des ersten Beispiels. Er "schiebt" das Verzeichnis /home/tartie und seinen Inhalt in das angegebene Verzeichnis des Systems "neo" – beachtet muss werden, dass ein System als "entfernt" angesehen wird, wenn ein Doppelpunkt “:” vor dem Pfad gesetzt wird.

~~~
rsync -agEvz --delete-after --exclude=”*~” /home/cuddles /media/sda7/SysBackups/neo/home
~~~

Dies ist ein Backupvorgang auf dem lokalen Rechner. Zu beachten ist, dass hier kein Doppelpunkt gesetzt ist. Das lokale Verzeichnis /home/cuddles wird nach /media/sda7/SysBackups/neo/home auf dem selben lokalen Rechner kopiert.

#### rsync mit mehrfachen Optionen --exclude:

~~~
rsync -agEvz --delete-after --exclude=”*~” --exclude=”*.c” --exclude=”*.o” "/*" /media/sda7/SysBackups/neo
~~~

Dieser Befehl kopiert ALLES aus dem Root-Verzeichnis des lokalen Systems (alle Verzeichnisse und Dateien) nach /media/sda7/SysBackups/neo – ausgeschlossen davon sind alle Dateien und Verzeichnisse, die auf “~”, “.c” oder “.o” enden.

#### Ersetzung von Hostnamen mit der IP-Adresse:

Der erste Befehl ist mit der Hostnamen-Methode gesetzt, der zweite mit der IP-Adressen-Methode. Beide Befehle sind in ihrer Ausführung identisch:

~~~
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home
~~~

~~~
rsync -agEvz --delete-after --exclude=”*~” 192.168.1.16:/home/tartie /media/sda7/SysBackups/morpheus/home
~~~

Die Hostnamen-Methode muss nicht angewendet werden, aber unserer Meinung nach vereinfacht sie Backups mit rsync in Netzwerken.

#### Ein unmöglicher Befehl:

~~~
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie trinity:/home
~~~

 **`Wie gesagt, eine Einschränkung von rsync ist, dass der Befehl nicht zwischen zwei entfernten Rechnern kopieren kann. Darauf möchten wir am Ende dieses Abschnitts noch einmal explizit hingewiesen haben.`**
 
Wir hoffen, mit dieser kleinen Anleitung Anregungen zum eigenen, produktiven Gebrauch von rsync als hoch anpassungsfähigem Backupprogramm gegeben zu haben.

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
