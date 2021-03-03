Änderung: 03-2021

OBSOLET?

## Aufsetzen von WiFi-Roaming

`Es ist möglich, dass nicht freie Firmware von einem USB-Stick installiert werden muss. Weitere Informationen dazu im Kapitel [Hardware mit nicht freier Firmware](nf-firm-de.htm#non-free-firmware) .` 

### Übersicht

wpa-roaming ist eine Methode, mit der man drahtlose Netzwerke durchsehen und sich mit ihnen verbinden kann `- auch ohne graphische Desktopumgebung` .

Die folgende Konfiguration führt bei nicht angeschlossenem Ethernetkabel dazu, dass wlan0 Verbindung zu einem vorher definierten bevorzugten drahtlosen Netzwerk oder zu einem offenen drahtlosen Netzwerk verbindet. Wenn ein Ethernetkabel angeschlossen wird, stoppt der drahtlose Zugang und eth0 verbindet zu dem verkabelten LAN. Nach Ausstecken des Ethernetkabels steht die drahtlose Verbindung sofort wieder zur Verfügung.

### Aufsetzen der Netzwerkkonfiguration

Als `root`  wird die Datei `/etc/network/interfaces`  wie folgt angepasst (der Schnittstellenname kann abweichen):

~~~
# The loopback network interface
auto lo
iface lo inet loopback

#Added by user
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa-roam.conf

#this line must always be here
iface default inet dhcp
~~~

Danach benötigt wpa_supplicant eine Konfigurationsdatei: wpa-roam.conf

~~~
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf /etc/wpa_supplicant/wpa-roam.conf
~~~

Die Datei wird mit einem Texteditor geöffnet:

~~~
<editor2 /etc/wpa_supplicant/wpa-roam.conf
~~~

Das Kommentarzeichen **`#`**  in Zeile 30 wird entfernt. Ohne dies würden Konfigurationsänderungen nicht gespeichert werden können:

~~~
update_config=1
~~~

Um einen Computer für eine sichere Verbindung aufzusetzen, entfernt man das Kommentarzeichen **`#`** für WPA-WPA2PSK: 

WEP kann nicht mehr empfohlen werden, es ist unsicher und in Minuten zu entschlüsseln

Beispiel für WPA:

~~~
network={
ssid="siduction_Worldwide" #Example WPA Network
psk="mysecretpassphrase"
}
~~~

Der nächste Schritt sichert wpa-roam.conf vor Lesezugriff Dritter. Dies ist aus Sicherheitsgründen notwendig, da sich in dieser Datei geheim zu haltende Schlüssel für den Netzwerkzugang befinden:

~~~
chmod 600 /etc/wpa_supplicant/wpa-roam.conf
~~~

Start der drahtlosen Verbindung:

~~~
ifup wlan0
~~~

Überprüfung der Verbindung:

~~~
wpa_cli status
~~~

Die Ausgabe sieht in etwa so aus:

~~~
Selected interface 'wlan0'
bssid=94:0c:6d:aa:f4:42
ssid=siduction_Melbourne
id=3
pairwise_cipher=CCMP
group_cipher=CCMP
key_mgmt=WPA2-PSK
wpa_state=COMPLETED
ip_address=192.168.1.102
~~~

Falls ip_address= keine Ziffern zeigt, ist keine Verbindung vorhanden. Nach Stoppen der Verbindung von wlan0 muss die Konfiguration überprüft werden:

~~~
wpa_action wlan0 stop
~~~

Komplexere Konfigurationseinstellungen finden sich [hier](#net-set3) 

<div class="divider" id="net-set2"></div>

## Umschalten zwischen drahtloser und Kabelverbindung

Zunächst siehe [Fliegender Wechsel zwischen LAN und WLAN](inet-ifplug-de.htm) . Ohne korrektes Implementieren von ifplugd kann nicht fliegend zwischen LAN und WLAN gewechselt werden.

Nach Einrichten von ifplugd sollte die Konfigurationsdatei /etc/network/interfaces so aussehen: 

~~~
auto lo
iface lo inet loopback

# governed by ifplugd ... do not use allow-hotplug or auto options
iface eth0 inet dhcp

#Added by user
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa-roam.conf

#this line must always be here
iface default inet dhcp
~~~

<div class="divider" id="net-set3"></div>

## wpa-roam.conf für benutzerdefinierte Netzwerkverbindungen

Mittels `IDString`  und `Priority`  kann bestimmt werden, mit welchem Netzwerk sich während des Bootens verbunden werden soll. Höchste Priorität ist `1000` , niedrigste Priorität ist `0` . Der `id_str`  muss auch in die Datei `/etc/network/interfaces`  eingefügt werden.

#### Die Syntax für /etc/network/interfaces

Das erste Beispiel ist für die Verbindung zu einem DHCP-Server, das zweite zum Aufsetzen einer Verbindung mit fixer IP-Adresse:

~~~
# id_str="home_dhcp"
iface home_dhcp inet dhcp

#this line must always be here
iface default inet dhcp

# id_str="home_static"
iface home_static inet static

address 192.168.0.20
netmask 255.255.255.0
network 192.168.0.0

broadcast 192.168.0.255
gateway 192.168.0.1
~~~

#### Praxisbeispiele

Man will automatisch mit meinem Heimnetzwerk verbunden werden, wenn man zu Hause ist. So gibt man diesem Netzwerk den IDString "home" und Priorität "15". Unterwegs will man, dass das Notebook sich automatisch mit jedem verfügbaren freien, nicht mit einem Passwort geschützten Netzwerk verbindet. Diese Aktion erhält den IDString "stalk" und Priorität "1" (sehr niedrig). Zu beachten ist, dass bei letzterer Methode nach Verbindung immer geprüft werden muss, ob diese legal ist und bei offensichtlicher Illegalität muss man die Verbindung sofort trennen.

So sehen die Stanzas für dieses Beispiel in /etc/network/interfaces aus:

~~~
# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)

# The loopback interface
# automatically added when upgrading
auto lo
iface lo inet loopback

allow-hotplug eth0
iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa-roam.conf

#this line must always be here
iface default inet dhcp

iface home inet dhcp
iface stalk inet dhcp
~~~

Beispiel einer /etc/wpa_supplicant/wpa-roam.conf (SSID und Passwörter sind verändert oder nur erklärt):

~~~
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
ssid="my_ssid"
scan_ssid=1
psk=123ABC ##here comes the passphrase in hexadecimal code!!
# psk="password_in_ascii" ##you dont need to
key_mgmt=WPA-PSK
pairwise=TKIP
group=TKIP
auth_alg=OPEN
priority=15
id_str="home"
}

network={
ssid=""
scan_ssid=1
key_mgmt=NONE
auth_alg=OPEN
priority=1
disabled=1 ## no automatic connection, one needs wpa_cli or wpa_gui
id_str="stalk"
}
~~~

Anmerkung: die Option "disabled=1" verhindert, dass man ohne Zutun mit dem erstbesten offenen WLAN verbunden wird. Man muss mit wpa_cli oder wpa_gui entscheiden, dass man sich verbinden möchte. Wer automatisch mit irgendeinem WLAN verbunden werden möchte, nimmt entweder diese Option gar nicht in wpa_supplicant.conf auf oder setzt eine Raute # vor die Zeile mit der Option "disabled=1".

#### Anmerkungen

#### 1. Einfache Wiederverwertbarkeit

Einmal aufgesetzt, können die Konfigurationsdateien ohne Probleme auf einem anderen Laptop oder PC mit WLAN-Karte weiter benutzt werden. Man kopiert /etc/network/interfaces (die Bezeichnung der Schnittstelle muss eventuell angepasst werden) und /etc/wpa_supplicant/wpa-roam.conf auf den anderen Rechner. Man muss danach nichts mehr installieren, nur mehr das Netzwerk und wpasupplicant (neu) starten oder rebooten.

#### 2. Backup

Es ist hilfreich, ein Backup von /etc/network/interfaces und /etc/wpa_supplicant/wpa-roam.conf anzulegen, aber `man sollte das Backup verschlüsseln, da es vertrauliche Informationen enthalten kann` .

Eine geeignete Methode eines sicheren Backups der Konfigurationsdateien mit Verschlüsselung ist eine Kombination von tar und gpg. Als root:

~~~
tar -cf- /etc/network/interfaces /etc/wpa_supplicant/wpa-roam.conf | gpg -c > backup_name.tar.gpg
~~~

Eine Datei wurde nun in $ HOME erstellt:  
backup_name.tar.gpg

Dies listet den Inhalt der Archivdatei backup_name.tar.gpg:

~~~
gpg -d -o - backup_name.tar.gpg | tar vtf -
~~~

Das Archiv backup_name.tar.gpg wird entpackt und entschlüsselt:

~~~
gpg -d -o - backup_name.tar.gpg | tar vxf -
~~~

#### 3. Versteckte SSIDs

Versteckte SSIDs werden erkannt, wenn `scan_ssid=1`  im Netzwerkblock gesetzt ist.

<div class="divider" id="rousec-wifi"></div>

## Grundlegende Sicherheitsmaßnahmen für drahtlose Modems und Router

Einige grundlegende Sicherheitsmaßnahmen können dazu beitragen, das Netzwerk vor Eindringlingen zu schützen.

#### Auswahl des Sicherheitsprotokolls

+ WPA2-PSK ist die bessere Option

+ Als Verschlüsselungsprotokoll wird AES gewählt

+ Es sollte eine starke Passphrase gewählt werden

#### Passphrase - Passwort

Zur Generierung einer starken Passphrase bzw. eines starken Passworts, welche nicht leicht memorisiert werden können, kann der Befehl pwgen in einem Terminal verwendet werden (siehe: man pwgen):

~~~
$ pwgen -s 63 1
VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi
~~~

+ -s = sicher (keine Mnemonics)

+ 63 = Anzahl der Zeichen

+ 1 = ein einzelnes zufälliges Passwort wird generiert

Ohne die Option -s wird ein aussprechbares Passwort generiert. Dies ist nicht empfehlenswert:

~~~
$ pwgen 8 3
Sooxae2s Niew9ugh Hi7eeloo
~~~

Generierte Passwörter/Passphrasen werden in einer Textdatei auf einem USB-Stick gespeichert und auf den Computern, die mit dem drahtlosen Netzwerk verbunden werden sollen angewendet. Passwörter/Passphrasen sollen nicht auf den jeweiligen Computern gespeichert werden.

#### Beispiel eines Router-Setups:

~~~
Version: WPA2-PSK
Encryption: AES
PSK Password: VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi
~~~

<!-- Alle Hinweise auf WEP wurden entfernt, es ist unsicher und sollte nicht mehr empfohlen werden -->

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
