<div class="divider" id="nbd1"></div>

## siduction über ein Netzwerk booten (network block device - nbd)

:::warning
#### **Warnung:**
**dnsmasq inkludiert einen dhcp-Server, der mit einem bereits auf dem System existierenden dhcp-Server (Ihr Router kann einen zur Verfügung stellen) in Konflikt stehen kann.**
 
Die sicherste Lösung ist immer, in einem Netzwerk nur einen dhcp-Server zu nutzen. Dies bedeutet, dass jeder weitere dhcp-Server im gleichen Netzwerk stillgelegt werden soll. Die weiter unten beschriebenen dnsmasq-Proxy-Optionen sollten es ermöglichen, mit jedem weiteren dhcp-Server im Netzwerk zu koexistieren. Du solltest dies nicht durchführen, falls Dunicht selbst der Administrator des Netzwerks bist, und bereit bist, mit unvorhergesehenen Folgen konfrontiert zu sein.
:::

### Grundlagen

Das Booten über ein Netzwerk benötigt zunächst einen Computer, der fähig ist, über ein Netzwerk gestartet zu werden und der über ein bestehendes Netzwerk mit einem Computer verbunden werden kann, welcher die Netzwerk-Boot-Dienste anbietet.

Dies sollte nicht in einem Netzwerk durchgeführt werden, das Du nicht kontrollierst (z.B. an Deinem Arbeitsplatz), sondern nur in einem Netzwerk, das Du selbst administrierst oder für das Du vom Netzwerkadministrator die benötigten Rechte erhalten hast. Falls Du Ko-Administrator in einem größeren Netzwerk bist, studiere alle Optionen von dnsmasq (Beschränkung der Schnittstellen, die abgehört werden, oder der Clients, die antworten sollen), um die Auswirkungen Deiner Einstellungen auf das Netzwerk so gering wie möglich zu halten.

### Voraussetzungen

Eine siduction.iso 2011.1 (oder neuer), gebootet, um als Netzwerk-Boot-Server zu fungieren. Die Anweisungen sollten für jeden aktuellen siduction- oder Debian-Sid-Computer gültig sein und alle Informationen enthalten, die benötigt werden, um sie auf anderen Systemen anzuwenden. (Linux ist vorausgesetzt, um nbd-Geräte ansprechen zu können).

dnsmasq wird benötigt, um den Bootvorgang initiieren zu können.

#### Installation

~~~
apt-get install nbd-server dnsmasq
~~~

### Aufsetzen eines nbd-Servers

 Vorausgesetzt die iso ist unter `/dev/scd0`  zu finden (bei einem Boot von einer CD, ansonsten wird der Pfad zur gegebenen Datei oder zum Gerät gesetzt), kann eine Konfigurationsdatei für einen nbd-Server mit dem Namen `nbd-siduction.conf`  erstellt werden. Diese beinhaltet eine Sektion namens siduction-iso, um die CD zu exportieren. Dies erfolgt mit diesem Befehl:

~~~
echo '[generic]' 2 nbd-siduction.conf
nbd-server 0.0.0.0:10809 /dev/scd0 -o siduction-iso 22 nbd-siduction.conf
~~~

Der Header "generic" wird immer benötigt. Falls Du jedoch einen automatisch funktionierenden nbd-Server auf einem realen System aufsetzen willst, sollte stattdessen eine Datei /etc/nbd-server.conf erstellt werden. Um alle Optionen für nbd-Server kennenzulernen, lese bitte `man nbd-server.` 

Um den Server als normaler Nutzer und ohne Aufsetzen von `/etc/nbd-server.conf`  zu starten, kann dieser Befehl ausgeführt werden:

~~~
nbd-server -C nbd-siduction.conf
~~~

Das Ziel des nbd-Servers muss keine ISO oder CD/DVD/USB-Stick sein, es muss nur eine geeignete Dateisystem-Abbilddatei haben.

### dnsmasq

Das folgende Beispiel einer funktionierenden Konfiguration geht davon aus, dass ein einfaches Netzwerk installiert ist, in dem Ihr Computer eine Ethernet-Verbindung besitzt, die via DHCP von einem anderen Computer angesprochen wird und welche die Netzwerk-Boot-Clients nutzen können, um deren Schnittstellen via DHCP angesprochen zu haben.

Die wichtigsten Optionen für dnsmasq, um siduction über ein Netzwerk zu booten, sind die Bestimmung des Pfads für den tftp-Server und die Konfigurationsdatei, um von diesem Ort aus booten zu können. 

Zunächst wird ein für das Booten notwendiges `tftp` -Verzeichnis in `/home/`  erstellt (der Ort ist beliebig, Du kannst dieses Verzeichnis erstellen, wo Du willst). Der Pfad ist nun `/home/tftp` .

Als nächstes wir die Datei `pxe-siduction.conf`  in $HOME erstellt:

~~~
dhcp-range=0.0.0.0,proxy
pxe-service=x86PC, &quot;boot linux&quot;, pxelinux
enable-tftp
tftp-root=/home/tftp
tftp-secure
~~~

Wenn ein DHCP-Proxy verwendet wird, muss ein pxe-Menü mit pxelinux als einzigen Eintrag zur Verfügung gestellt werden, damit das System automatisch gestartet wird. Dafür sorgt die Zeile mit dem Eintrag "pxe-service" in obigem Beispiel.

Als root wird die neu erstellte Datei `pxe-siduction.conf`  nach `/etc/dnsmasq.d/`  verschoben:

~~~
suxterm
mv pxe-siduction.conf /etc/dnsmasq.d/
~~~

Anmerkung: Für ein Netzwerk (z.B. 192.168.0.*) ohne DHCP-Server können die ersten beiden Zeilen so aussehen:

~~~
dhcp-range=192.168.0.100,192.168.0.199,1h
dhcp-boot=pxelinux.0
~~~

Dies vergibt IP-Adressen von 192.168.0.100 bis 192.168.0.199 mit einer Lease-Time von einer Stunde und den Dateinamen, um nur pxelinux.0 als Teil der DHCP-Anfrage laufen zu lassen (falls der Proxy benutzt wird, wird nur ein pxe-Menüpunkt mit dem Eintrag pxlinux gesetzt, der dann automatisch startet). Diese Vorgehensweise setzt wahrscheinlich das Netzwerk nicht wie gewünscht auf, wenn der dnsmasq-Server nicht gleichzeitig DNS-Server und Gateway für die Boot-Clients ist.

Um die neue Datei zu aktivieren, muss die Zeile `conf-dir=/etc/dnsmasq.d`  am Ende der Datei `/etc/dnsmasq.conf`  freigeschaltet (keine Raute # am Zeilenbeginn) und dnsmasq neu gestartet werden.

dnsmasq besitzt sehr viele Optionen und kann sowohl als DNS-Server wie auch als DHCP-, PXE- und TFTP-Server dienen. Obige Erläuterungen sind nur Minimalangaben, um pxelinux mit gfxboot zu nutzen, um siduction zu booten.

### tftp

tftp ist das Netzwerkäquivalent des Bootverzeichnisses. Um das Beispielverzeichnis `/home/tftp`  zu nutzen, muss es "bevölkert" werden. Vorausgesetzt, die CD-ROM ist unter `/fll/scd0`  eingebunden:

~~~
cp /fll/scd0/boot/isolinux/* /home/tftp
mkdir /home/tftp/pxelinux.cfg
mv /home/tftp/isolinux.cfg /home/tftp/pxelinux.cfg/default
mkdir /home/tftp/boot
cp /fll/scd0/boot/vmlin* /fll/scd0/boot/initr* /fll/scd0/boot/memtest* /home/tftp/boot/
cp /usr/lib/syslinux/pxelinux.0 /home/tftp/
# required for the tftp-secure option to dnsmasq
chown -R dnsmasq.dnsmasq /home/tftp/*
~~~

Nun können die Boot-Optionen unter `/home/tftp`  in den Dateien `pxelinux.cfg/default`  und `gfxboot.cfg`  nach Belieben bearbeitet werden.

Im besonderen wird vorgeschlagen, dass in der Sektion `[install]`  folgende Parameter auf die angegebenen Werte gesetzt wird: `install=` auf `install=nbd` , `install.nbd.server`  auf die IP des Netzwerk-Servers und `install.nbd.port`  auf den Namen der NBD-Export-Sektion, zum Beispiel siduction-iso (NBD-Exporte besitzen eher Namen als nur Port-Nummern).

Auch kann das F3-Menü gänzlich deaktiviert und die Kernel-Befehlszeile mit einem Befehl ähnlich diesem ausgestattet werden:

~~~
fromhd=/dev/nbd0 root=/dev/nbd0 nbdroot=192.168.1.23,siduction-iso nonetwork
~~~

#### toram Boot-Code

Falls toram den Bootoptionen hinzugefügt wird, geben Computer mit genügend RAM den Server frei, sobald sobald die Datei ins RAM kopiert ist. Computer ohne ausreichenden RAM booten normal. Mindestvoraussetzung für toram sind 1GB RAM, empfohlen sind 2GB oder mehr.

### Booten über das Netzwerk

Stelle sicher, dass der Client-PC die BIOS-Option `Boot from Network`  aktiviert hat. 

Wenn das BIOS ein Booten via Netzwerk unterstützt und der Computer mit dem Netzwerkserver (siduction-Kernel mit Unterstützung von initrd.img) verbunden ist, sollte die Netzwerkkarte siduction über das Netzerk booten können. 

Einige Netzwerkkarten können nicht freie Firmeware benötigen. In diesem Falle muss das initrd-Abbild neu gebaut werden, um die Firmware einzugliedern.

<div id="rev">Page last revised 13/01/2012 1345 UTC</div>
