<div class="divider" id="wpa-basic"></div>

## Basisanleitung zum Aufsetzen einer WLAN-Verbindung: WiFi

    Aufgrund der komplexen rechtlichen Situation stellt siduction nur freie Software  
    im Sinne des Debian Free Software Guide (dfsg)  zur Verfügung.
    
[Hier finden sich zusätzliche Informationen zu nicht freier Firmware.](nf-firm_de.md)`
 
Um WiFi aufzusetzen, braucht man für ein paar Minuten eine kabelgebundene Netzwerkverbindung um die entsprechende Firmware aus dem Internet laden zu können.

Falls eine kabelgebundene Netzwerkverbindung nicht hergestellt werden kann, besteht die Möglichkeit, die benötigte Firmware auch von einem Wechselmedium (CD-R, USB-Stick u.a.) zu installieren.

Die Firmware wird dann folgendermaßen installiert (der Befehl wird im Verzeichnis der gespeicherten Firmware ausgeführt):

~~~
#dpkg -i <firmware.deb>
~~~

Um die richtige Firmware zu finden, wenn man nicht weiß, welcher WiFi-Chip im Computer eingebaut ist, wird dieser Befehl ausgeführt:

~~~
#fw-detect
~~~

Damit erhält man folgende Information:

~~~
#apt-get update
#apt-get install <Name der Firmware>
#modprobe -r <Modulname>
#modprobe <Modulname>
~~~

Nun wird der Installationsbefehl ausgeführt, den fw-detect in der Zeile mit "apt get install" ausgegeben hat. Bevor die WiFi-Schnittstelle konfiguriert werden kann, muss das Modul noch geladen werden (der Modulname wird von fw-detect ausgegeben).

Dies geschieht als root mit diesen Konsolenbefehlen:

~~~
modprobe -r <Modulname>

modprobe <Modulname>
~~~

&lt;Modulname&gt; wird durch den von fw-detect ausgegebenen realen Namen des Moduls ersetzt. Am einfachsten geschieht dies unter Verwendung der automatischen Textergänzung von Bash mittels Tabulator-Taste:  
  
Nach den ersten Buchstaben des richtigen &lt;Modulnamen&gt; wird die vollständige Bezeichnung durch Drücken der Tabulatortaste (TAB) automatisch ergänzt. Zum Beispiel: "modprobe ipw [TAB-Taste]". Mit dieser Methode können unangenehme Tippfehler vermieden werden.

Beide modprobe-Befehle geben keine Rückmeldung aus, falls die Module erfolgreich installiert wurden. Es erscheint nur ein neuer Prompt (#).

Mit folgendem Befehl kann geprüft werden, ob das Modul korrekt geladen wurde:

~~~
#lsmod | grep <Modulname>
~~~

Nun kann Ceni gestartet werden: in K-Menü>Internet oder als root in einer Konsole. Siehe auch [Internet &amp; Netzwerk - Ceni](inet-ceni-de.htm#netcardconfig) . Die konfigurierbare WiFi-Schnittstelle sollte angezeigt werden.

Eine Anleitung zur Kontaktaufnahme mit verschiedenen (freien) WiFi-Netzwerken via wpagui findet sich in diesem Kapitel: [WiFi-roaming, WPA-GUI](inet-wpagui-de.htm) .

<div class="divider" id="wpa"></div>

## Arbeitweisen des wpasupplicant in Debian

 `Auf Grund der Komplexizität der Gesetzgebung liefert siduction nur freie Software im Sinne des Debian Free Software Guide (dfsg) auf der LiveCD mit, nähere Informationen, wie man unfreie Soft- bzw. Firmware installiert gibt es [hier](nf-firm-de.htm#non-free-firmware) .`  
Das Debian wpasupplicant-Paket unterstützt zwei Arbeitsweisen, die beide sehr nahe am Kern der Netzwerk-Infrastruktur (ifupdown) agieren.

### Inhaltsangabe

1. #### Modus #1: Managed Mode
    * Beispiele
    * Tabelle der allgemeinen Optionen
    * Wichtige Anmerkungen zum Managed Mode
    * Wie man's macht

2. #### Mode #2: Roaming Mode
    * wpa_supplicant.conf
    * /etc/network/interfaces
    * Kontrolle des Roaming-Daemons mit wpa_action 
    * Feineinstellung der Roaming-Konfiguration
    * Das Logfile
    * Nutzung von externen Mapping-Skripten (z.B. guessnet)
    * /etc/network/interfaces mit externem Mapping

3. #### Problemlösungen
    * Versteckte Essids

4. #### Sicherheitserwägungen
    * Konfiguration der Dateirechte

---

### Allgemeine Treiberempfehlung

Die Intel Pro Wireless Adapter (ipw2100, ipw2200 and ipw3945) benutzen alle das 'wext'-Backend, es sei denn, der Kernel ist älter als 2.6.14.

Ndiswrapper unterstützt seit Version 1.16 das 'ndiswrapper' Treiber-Backend  **nicht mehr** . Wenn man keine antiquierte ndiswrapper-Version verwendet,  **muss der 'wext' Treiber für ndiswrapper verwendet werden** .

Die 'wpa_driver'-Option wird in der `/etc/network/interfaces`  im für das Gerät verwendeten Abschnitt definiert, zum Beispiel:

~~~
iface eth0 inet dhcp
wpa-driver wext
 *. . . . . andere Optionen* 
~~~

## 1. Modus #1: Managed Mode

Dieser Modus bietet die Möglichkeit, über das 'wpa_supplicant' Verbindung zu einem bekannten Netzwerk herzustellen. Dies funktioniert ähnlich wie mit dem Paket 'wireless tools'. Jedes Element, das benötigt wird, um eine Verbindung herzustellen, wird mit dem Präfix 'wpa-' in der `/etc/network/interfaces` angeführt.

#### Beispiel einer 'wpa.conf' für 'Managed Mode' - Beispiel 1

~~~
# Beispiel einer Mode #1 wpa.conf Datei - Beispiel 1.
# ACHTUNG: der Wert 'wpa-psk' ist nur gültig, wenn:

# 1. er Klartext (ascii) und zwischen 8 und 63 Buchstaben oder
# 2. er Hexadezimal und 64 Buchstaben lang ist.

# Verbindung mit dem Zugangsknoten (access point, 'ap') der ssid 'NETBEER' und der
# WPA-PSK/WPA2-PSK Verschlüsselung. Das 'wext' Treiber-Backend von 'wpa_supplicant' wird
# verwendet, da kein 'wpa-driver' definiert wurde.
# Das Passwort (passphrase) wird als ASCII (Klartext, plaintext) eingegeben. DHCP wird verwendet
# um eine Netzwerkadresse zu erhalten.
#
iface wlan0 inet dhcp

wpa-ssid NETBEER
# plaintext passphrase
wpa-psk PlainTextSecret

# Verbindung mit dem access point der ssid 'homezone' . Verschlüsselung
# WPA-PSK/WPA2-PSK, wpa_supplicant verwendet das 'wext' Treiber-Backend
# Der psk (personal key) wird als verschlüsselte hexadezimale Zeichenfolge eingegeben.
# DHCP wird verwendet, um eine Netzwerkadresse zu erhalten.
#
iface wlan0 inet dhcp
wpa-driver wext
wpa-ssid homezone
# hexadecimal psk is encoded from a plaintext passphrase
wpa-psk 000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f

# Verbindung zu einem Accesspoint mit der ssid 'HotSpot1' und der bssid '00:1a:2b:3c:4d:5e'
# mit dem Verschlüsselungstyp WPA-PSK/WPA2-PSK unter Verwendung des 'madwifi'-Treiberbackends
# von wpa_supplicant. Die Passphrase ist als Zeichentextkette gegeben.
# Eine statische Netzwerkadresse wird zugewiesen.
#
iface ath0 inet static

wpa-driver madwifi
wpa-ssid HotSpot1
wpa-bssid 00:1a:2b:3c:4d:5e
# plaintext passphrase
wpa-psk madhotspot
wpa-key-mgmt WPA-PSK
wpa-pairwise TKIP CCMP
wpa-group TKIP CCMP
wpa-proto WPA RSN
# static ip settings
address 192.168.0.100
netmask 255.255.255.0
network 192.168.0.0
broadcast 192.168.0.255
gateway 192.168.0.1

# Eine statische wpa_supplicant.conf wird für eth1 verwendet. Alle Netzwerkinformationen
# befinden sich in der vom Nutzer definierten wpa_supplicant.conf. Kein wpa-Treibertyp
# ist spezifiziert, somit wird wext verwendet. DHCP wird verwendet, um eine Netzwerkadresse
# zu erhalten.

iface eth1 inet dhcp

wpa-conf /path/to/wpa_supplicant.conf
~~~

<div class="divider" id="wpa1"></div>

## Tabelle der allgemeinen Optionen

Es folgt nun eine kurze Übersicht der am häufigsten benutzten 'wpa-'Optionen, welche in der `/etc/network/interfaces`  gültig sind. Sie müssen im Abschnitt des WLAN-Gerätes stehen. Siehe auch 'Wichtige Anmerkungen zum Managed Mode', um Informationen über gültige und ungültige Werte des 'wpa-'Präfixes zu erhalten.

 **`ACHTUNG: bei allen Werten die gRoß- bzw. klEiNschreiBung beachten!`**

~~~
Element Beispiel-Wert Beschreibung
======= ============= ===========
wpa-ssid ssidintext setzt das ssid des Netzwerks
wpa-bssid 00:1a:2b:3c:4d:5e bssid des Access-Points
wpa-psk 0123456789 der preshared WPA-Schlüssel. Mit
wpa_passphrase(8) kann der psk-Schlüssel
aus einer Passphrase generiert werden
wpa-key-mgmt NONE, WPA-PSK, WPA-EAP, Liste der akzeptierten Authentifizierung
IEEE8021X der Management-Protokolle
wpa-group CCMP, TKIP, WEP104, Liste der akzeptierten group
WEP40 ciphers für WPA
wpa-pairwise CCMP, TKIP, NONE Liste der paarweise akzeptierten
ciphers für WPA
wpa-auth-alg OPEN, SHARED, LEAP Liste der erlaubten IEEE 802.11
Authentifizierungsalgorhithmen
wpa-proto WPA, RSN Liste akzeptierter Protokolle
wpa-identity meinnameintext durch den Administrator bestimmter Benutzername
(EAP authentication)
wpa-password meinpasswortintext Benutzerpasswort
(EAP authentication)
wpa-scan-ssid 0 oder 1 Umschalten des ssid-Scannens mit
spezifischen "probe request frames"
wpa-ap-scan 0 oder 1 oder 2 Einstellen der wpa_supplicant-Scannerlogik

~~~

Die gesamten Funktionen des wpa_cli(8) sollten integriert sein. Eine fehlende Funktion wird als Programmfehler (bug) angesehen und sollte als solcher berichtet werden. Patches sind immer willkommen.

## Wichtige Anmerkungen zum Managed Mode

Fast alle 'wpa-'Optionen benötigen zumindest eine definierte ssid. Nur zwei der Optionen haben einen globalen Effekt. Dies sind 'wpa-ap-scan' und 'wpa-preauthenticate'.

Einer Schnittstelle in der interfaces(5) gegebene 'wpa-'Option genügt, den wpa_supplicant-Daemon aufzurufen.

Das ifupdown-Skript von wpasupplicant macht Annahmen bezüglich des 'Typs' der Eingabe, die für jede Option gültig ist. Es vermutet zum Beispiel, dass manche Eingaben Klartext sind und setzt sie in Anführungszeichen, bevor sie an wpa_cli weitergegeben werden. Dieser fügt die Eingabe dann dem Netzwerkblock durch den wpa_supplicant-ctrl_interface-socket hinzu.

'ifup' mit der '--verbose' Option von Hand ausgeführt zeigt alle Befehle, die von wpa_cli verwendet werden, um den Netzwerkblock zu bilden. Ist der Wert einer in der `/etc/network/interfaces` definierten 'wpa-'Option in Anführungszeichen gesetzt, wird angenommen, dass es sich um "plaintext"- oder "ascii"-Eingaben handelt.

Mancher Wertetyp einer Option, wie z.B. 'wpa-wep-key', wird als hexadezimale Folge angenommen. Der Wertetyp der 'wpa-psk'-Option wird jedoch durch eine simple Suche nach nichthexadezimalen Zeichen bestimmt.

## Wie wpa_supplicant funktioniert

Wie bereits erwähnt, wird jedes 'wpa_supplicant'-spezifische Element mit dem Präfix 'wpa-' aufgerufen. Jedes Element entspricht einer in den wpa_supplicant.conf(5), wpa_supplicant(8) und wpa_cli(8) man-pages beschriebenen Eigenschaft des 'wpa_supplicant'.

Der supplicant wird ohne jede Vorkonfiguration aufgerufen und wpa_cli bildet die Netzwerkkonfiguration aus den bereitgestellten Eingaben der 'wpa-cli'-Zeilen. wpa_supplicant/wpa_cli legen nicht sofort Eigenschaften des Geräts fest (wie zum Beispiel iwconfig), sondern zeigen an, welcher Access-Point für eine Verbindung geeignet ist. Nachdem das Gerät die Gegend gescannt hat und der Access-Point gefunden wurde, werden, wenn der Access-Point bereit ist, diese Eigenschaften gesetzt.

Die Skripte, welche dies bewerkstelligen, befinden sich hier:

~~~
/etc/wpa_supplicant/ifupdown.sh
/etc/wpa_supplicant/functions.sh
~~~

Sie werden von run-parts ausgeführt, welches selbst von ifupdown während der Phasen 'pre-up', 'pre-down' und 'post-down' aufgerufen wird.

In der 'pre-up'-Phase wird ein wpa_supplicant-daemon gestartet, gefolgt von einer Serie von wpi_cli-Befehlen, die eine Netzwerkkonfiguration entsprechend der in `/etc/network/interfaces`  genutzten 'wpa-'Optionen für das Gerät aufsetzen.

Wenn wpa-roam benutzt wird, wird ein wpa_cli-daemon in der 'post-up'-Phase gestartet.

In der 'pre-down'-Phase wird der wpa_cli-daemon gestoppt (killed), so er vorhanden ist.

In der 'post-down'-Phase wird der wpa_supplicant-daemon gestoppt (killed).

## 2. Modus #2: Roaming Mode

Das Paket (wpa_supplicant) enthält einen in sich geschlossenen, simplen Roaming-Mechanismus in Form eines wpa_cli-action-Skripts, `/sbin/wpa_action` . Bei Aktivierung vermutet wpa_action Kontrolle über ifupdown. Die wpa_action(8)-manpage beschreibt die technischen Details eingehend.

Um ein Roaming-Interface zu aktivieren, muss folgendes Beispiel für die Datei interfaces(5) angepasst werden:

~~~
iface eth1 inet manual
wpa-driver wext
wpa-roam /path/to/wpa_supplicant.conf
~~~

Zwei Daemons werden durch obiges Beispiel gestartet: wpa_supplicant und wpa_cli. Eine `/etc/wpa_supplicant.conf`  ist notwendig. Einen guten Anfang bietet das Konfigurationsbeispiel, welches so nach `/etc`  kopiert werden kann:

~~~
# copy the template to /etc/wpa_supplicant/
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf \
/etc/wpa_supplicant/wpa_supplicant.conf
# allow only root to read and write to file
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf

NOTE: it is critical that the used wpa_supplicant.conf defines the location of
the 'ctrl_interface' so that a communication socket is created for the
wpa_cli (wpa-roam daemon) to attach. The mentioned example configuration,
/usr/share/doc/wpasupplicant/examples/wpa-roam.conf, has been set to a
sane default.

~~~

Es ist notwendig, diese Konfigurationsdatei zu editieren und für alle bekannten Netzwerke Netzwerkblöcke hinzuzufügen. Wer sich unsicher ist, was das bedeutet, sollte jetzt die manpage wpa_supplicant.conf(5) lesen.

Für jedes Netzwerk kann eine eigene 'id_str' verwendet werden. Diese sollte eine simple Zeichenfolge sein. Diese Folge bildet die Basis der Netzwerkprofile; es entspricht einer logischen Schnittstelle, die in der Datei interfaces(5) definiert wurde. Wenn keine 'id_str' für ein Netzwerk gegeben ist, wird von wpa_action das Interface 'default' benutzt. Das Interface 'default' kann durch die Option 'wpa-default-iface' definiert werden.

Was all das bedeutet, wird mit folgendem (übersetzten) Beispiel aus der wpa_action(8) manpage illustriert:

#### `/etc/wpa_supplicant.conf` Beispiel

~~~
wpa_supplicant.conf example:
network={
ssid="foo"
key_mgmt=NONE
# this id_str will notify /sbin/wpa_action to 'ifup uni'
id_str="uni"
}

network={
ssid="bar"
psk=123456789...
# this id_str will notify /sbin/wpa_action to 'ifup home_static'
id_str="home_static"
}

network={
ssid=""
key_mgmt=NONE
# no 'id_str' parameter is given, /sbin/wpa_action will 'ifup default'
}
~~~

<div class="divider" id="wpa2"></div>

#### `/etc/network/interfaces`  Beispiel

~~~
/etc/network/interfaces (Beispiel):
# das roaming-interface muss die manuelle inet-Methode nutzen
# 'allow-hotplug' oder 'auto' stellt sicher, dass der Daemon automatisch startet
allow-hotplug eth1
iface eth1 inet manual

wpa-driver wext
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf

# kein id_str, 'default' wird zur Absicherung als Mapping Target verwendet
iface default inet dhcp

# id_str="uni"
iface uni inet dhcp

# id_str="home_static"
iface home_static inet static

address 192.168.0.20
netmask 255.255.255.0
network 192.168.0.0

broadcast 192.168.0.255
gateway 192.168.0.1
~~~

Eine logische Schnittstelle wird durch ifup gestartet (und durch ifdown gestoppt), wenn wpa_supplicant sich mit dem durch 'id_str' in der `/etc/wpa_supplicant.conf`  zugeordneten Netzwerk verbindet (oder die Verbindung trennt).

Ein Log der von /sbin/wpa_action durchgeführten Aktionen wird als /var/log/wpa_action.log gespeichert. Bitte an Problemberichte das Log anhängen.

## Zusammenspiel von wpa_supplicant mit wpa_cli und wpa_gui

Der Prozess wpa_supplicant kann mit den Gruppenmitgliedern von "netdev" zusammenspielen, wenn die Beispielkonfiguration von "Roaming" verwendet wird (Gruppe und GID kann mit dem Parameter "GROUP= crtl_interface" angepasst werden). Die Beispieldatei wurde übersetzt

~~~
# die ctrl_interface Option in der Grundeinstellung wird in der Beispieldatei so definiert:
# /usr/share/doc/wpasupplicant/examples/wpa-roam.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev

Um supplicant zu steuern, werden wpa_cli (Befehlseingabe) und wpa_gui (QT-Gui) ausgeliefert. Damit kann man Verbindungen aufbauen und stoppen sowie Netzwerkblöcke hinzufügen und löschen, weiters werden interaktiv Sicherheitsoptionen zur Verfügung gestellt und vieles mehr.
~~~

## Kontrolle des Roaming-Daemon durch wpa_action

Ist der roaming daemon gestartet, geht er von der Kontrolle von ifupdown aus. Das heißt, wpa_cli ruft ifup auf, wenn wpa_supplicant sich erfolgreich mit einem Access-Point verbunden hat, und ruft ifdown auf, wenn die Verbindung getrennt wurde oder verloren ging. Solange der roaming-daemon aktiv ist, sollte ifupdown nicht direkt über manuelle Befehle angesprochen werden, sondern /sbin/wpa_action sollte verwendet werden, um den roaming-daemon zu stoppen oder neu zu laden. Um den roaming-daemon auf der Netzwerkkarte eth1 zu stoppen, wird folgender Befehl verwendet:

~~~
wpa_action eth1 stop
~~~

Wenn der roaming-daemon mit neuen Netzwerkinformationen versorgt wird, muss er nicht angehalten werden. Dazu wird die Datei wpa_supplicant.conf editiert, welche der roaming-daemon nutzt, und die neuen Netzwerkdaten werden in diese Datei eingegeben. Optionale Netzwerkeinstellungen, welche für das hinzugefügte Netzwerk spezifisch sind (gelinkt durch 'id_str'), werden in /etc/network/interfaces eingetragen. Im Anschluss kann der roaming-daemon wie folgt neu geladen werden:

~~~
wpa_action eth1 reload
~~~

Umfassende technische Einzelheiten, also wozu wpa_action fähig ist, findet man auf der manpage wpa_action(8).

<div class="divider" id="wpa3"></div>

## Fine-Tuning der Roaming-Einstellungen

Es ist durchaus möglich, dass in näherer Umgebung mehrere Access-Points aktiv sind. Der Access-Point kann manuell mittels wpa_cli oder wpa_gui ausgewählt werden, oder jedem Access-Point bzw. Netzwerk kann seine eigene Prioritätsstufe gegeben werden. Letzteres geschieht durch die Option 'priority' in der wpa_supplicant.conf.

<div class="divider" id="wpa4"></div>

## Die Protokolldatei (der Logfile)

Jede Aktivität des 'roaming-daemons' wird in /var/log/wpa_action.log protokolliert. Folgende Informationen sind darin enthalten:

*time and date  
*interface name and action event  
*values of enviromental variables (WPA_ID, WPA_ID_STR, WPA_CTRL_DIR)  
*ifupdown command executed  
*wpa_cli status (based on WPA-PSK, network may display different info)  
*bssid  
*ssid  
*id  
*id_str  
*pairwise_cipher  
*group_cipher  
*key_mgmt  
*wpa_state  
*ip_address

<div class="divider" id="wpa5"></div>

## Verwendung externer Mapping-Scripts (z. B. guessnet)

Zusätzlich zum internen Mapping von logischen Schnittstellen mittels 'id_str', kann wpa_action externe Mapping-Scripts aufrufen. Ein externes Mapping-Script sollte den Namen der logischen Schnittstelle übermitteln, welche aufgerufen werden soll. Jedes Mapping-Script sollte durch einen Aufruf von wpa_action funktionieren, wenn es mit dem ifupdown Mapping-Mechanismus arbeitet (siehe man interfaces).

Um ein Mapping-Script aufzurufen, wird zu den Schnittstellen-Stanzen (interfaces stanza) des physischen Roaming-Geräts (roaming device) eine Zeile mit der Syntax 'wpa-mapping-script name-of-the-script' angefügt. (Der absolute Pfad zu dem Mapping-Script kann erforderlich sein).

Der Inhalt der Zeilen, welche mit wpa-map beginnen, wird zum stdin des Mapping-Scripts weiter geleitet. Da ifupdown nur eine 'wpa-map'-Zeile zulässt, können beliebig viele Zeilen mit 'wpa-map' angehängt werden. Zum Beispiel:

~~~
iface wlan0 inet manual
wpa-driver wext
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
wpa-mapping-script guessnet-ifupdown
wpa-map0 home
wpa-map1 work
wpa-map2 school
# ... zusätzliche Zeilen mit wpa-mapX, wie benötigt
~~~

In der Grundeinstellung wird ein Mapping-Script nur verwendet, wenn kein 'id_str' für das aktuelle Netzwerk angegeben ist. Wenn 'id_str' vollständig ignoriert und nur ein externes Mapping-Script verwendet werden soll, wird die Option 'wpa-mapping-script-priority 1' gesetzt, um das Verhalten der Grundeinstellung zu überschreiben.

Falls das Mapping-Script eine leere Zeichenfolge übermittelt, nutzt wpa_action die Schnittstelle der Grundeinstellung (das Default-Device), solange keine Alternative durch die Option 'wpa-roam-default-iface' definiert ist.

Es folgt ein ausführliches Beispiel, welches guessnet-ifupdown als externes Mapping-Script verwendet.

#### /etc/network/interfaces mit externem Mapping-Beispiel

~~~
/etc/network/interfaces mit externem Mapping-Beispiel:
allow-hotplug wlan0
iface wlan0 inet manual

wpa-driver wext
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
wpa-roam-default-iface default-wparoam
wpa-mapping-script guessnet-ifupdown
wpa-map default: default-guessnet
wpa-map0 home_static
wpa-map1 work_static

# school kann nur mittels 'id_str' gewählt werden
iface school inet dhcp

# resolvconf
dns-nameservers 11.22.33.44 55.66.77.88

iface home_static inet static

address 192.168.0.20
netmask 255.255.255.0

network 192.168.0.0
broadcast 192.168.0.255
gateway 192.168.0.1
test peer address 192.168.0.1 mac 00:01:02:03:04:05

iface work_static inet static

address 192.168.3.200
netmask 255.255.255.0
network 192.168.3.0
broadcast 192.168.3.255

gateway 192.168.3.1
test peer address 192.168.3.1 mac 00:01:02:03:04:05

iface default-guessnet inet dhcp

iface default-wparoam inet dhcp
~~~

In diesem Beispiel nutzt wpa_action das Script guessnet nur zur Wahl einer geeigneten logischen Schnittstelle, wenn keine Option 'id_str' für das aktuelle Netzwerk in wpa_supplicant.conf gesetzt wurde.

Die Zeilen mit 'wpa-map' statten guessnet mit den logischen Schnittstellen aus, welche geprüft werden sollen. Die Default-Schnittstelle wird verwendet, wenn mit keiner Schnittstelle aus 'wpa-map' eine Verbindung hergestellt werden konnte. Die "Test-Zeilen" einer jeden logischen Schnittstelle werden von guessnet genutzt, um zu ermitteln, ob eine Verbindung zu dem gegebenen Netzwerk hergestellt ist. guessnet wählt zum Beispiel die logische Schnittstelle 'home_static', wenn ein Netzwerkgerät mit einer IP-Adresse 192.168.0.1 und einer MAC mit 00:01:02:03:04:05 im aktuellen Netzwerk vorhanden ist. Wenn alle Tests erfolglos sind, wird die Schnittstelle 'default-guessnet' konfiguriert.

Zur weiteren Information siehe die manpage guessnet(8).

## 3. Problemlösungen

Um Fehler bei Verbindung oder Authentifizierung ausfindig zu machen, schlagen wir vor, den Befehl `wpa_cli -i &lt;interface&gt;` in einer neu geöffneten Konsole auszuführen, bevor die Schnittstelle angesprochen wird. Zunächst wird der Befehl 'level 0' verwendet, um alle Fehlermeldungen zu erhalten. Im Anschluss daran erhält man mit `ifup --verbose &lt;interface&gt;` ausführliche Fehlermeldungen von dem Script, welches wpasupplicant startet.

<div class="divider" id="wpa6"></div>

### Versteckte ssids

Zur Referenz beachte man Debian Bug.#358137. Um sich mit versteckten ssids verbinden zu können, soll die Option 'ap_scan=1' in der globalen Sektion (global section) und die Option 'scan_ssid=1' in der Sektion Netzwerkblock (network block section) der wpa_supplicant.conf eingetragen sein. Bei einem Netzwerk im Managed Mode (verwalteten Modus), geschieht dies durch folgende Stanzen (stanzas):

~~~
iface eth1 inet dhcp
wpa-conf managed
wpa-ap-scan 1
wpa-scan-ssid 1
# ... zusätzliche Einstellungsoptionen
~~~

Laut Debian Bug #368770 kann die Verbindungsherstellung bei Netzwerken eine lange Zeit in Anspruch nehmen, welche mit WEP gesichert sind. In manchen Fällen kann der Parameter 'ap_scan=2' in der Konfigurationsdatei (oder eine Stanze 'wpa-ap-scan 2', welche die gleiche Funktion hat) eine große Hilfe für eine schnellere Verbindungsherstellung bedeuten.

<div class="divider" id="wpa7"></div>

## 4. Sicherheitsüberlegungen

#### Konfiguration der Dateiberechtigungen

Es ist wichtig, die PSK und andere sensible Daten, welche das Netzwerk betreffen, nicht öffentlich zugänglich zu machen. Daher muss sicher gestellt sein, dass Konfigurationsdateien, welche diese Informationen enthalten, nur vom Besitzer dieser Dateien lesbar sind. Zum Beispiel:

~~~
chmod 0600 /etc/network/interfaces
# der Pfad zur Datei wpa_supplicant.conf kann individuell variieren
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf
~~~

In der Grundeinstellung ist /etc/network/interfaces für alle lesbar. Dies ist nicht geeignet, um geheime Schlüssel und Passwörter in dieser Datei gespeichert zu haben.

<div id="rev">Page last revised 10/01/2012 1345 UTC</div>
