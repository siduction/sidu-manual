ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2020-05:
+ Inhalt nur redaktionell aktualisiert
+ Korrektur und Prüfung aller Links, Ubuntu-man entfernt, da mit 'man nmcli' identisch
Änderungen 2020-06:
+ Dateinamen und Titelanker geändert um das Dokument sinnvoll in die Dateihirarchie zu integrieren.

ENDE   INFOBEREICH FÜR DIE AUTOREN

<div class="divider" id="inet-nm-cli"></div>

## Network Manager in der Shell

### Allgemeine Hinweise

Der Networkmanager ist mittlerweile ein sehr brauchbarer Ersatz für das Netzwerkkommando  *ifup, ifdown*  bzw.  *ifconfig*  in der Debianwelt geworden. Das Vorurteil das sich der Networkmanager nicht für die Kommandozeile eignet oder gar instabil läuft gehört ins Reich der Märchenwelt. Es existiert ein leistungsfähiger Kommandozeilenclient  *nmcli*  für den täglichen Gebrauch des Networkmanagers.

In den nachfolgenden Beispielen gehen wir von zwei konfigurierten Verbindungen aus. Eine WLAN-Verbindung (Name: BluelupoWLAN, Interface wlp4s0 (früher; wlan)) und einer kabelgebundenen Verbindung (Name: BluelupoLAN, Interface enp2s0 (früher: eth0)). Bitte die Verbindungsnamen an eure Gegebenheiten anpassen.

### Installation

Falls der Networkmanager auf dem System noch nicht installiert ist, kann man dies nachholen. Im nachfolgenden Kommando sind alle Pakete die man braucht um alle möglichen Verbindungsarten zu konfigurieren (mobiles Breitband, WLAN und LAN Verbindungen), sowie das grafische KDE-Plasma-Widget für den NM. Bitte alles in eine Zeile eingeben.

~~~
apt install network-manager modemmanager mobile-broadband-provider-info plasma-widget-networkmanagement network-manager-vpnc network-manager-openvpn network-manager-pptp
~~~

### Informationen zu WIFI Netzen anzeigen

Welche WLAN-Netze sind überhaupt am Standort verfügbar, das kann man sich in kompakter Form mit  *nmcli dev wifi list*  anzeigen lassen.

~~~
nmcli dev wifi list
SSID BSSID MODUS FREQUENZ RATE SIGNAL SICHERHEIT AKTIV 
'WLAN01' 00:24:FE:A7:82:99 Infrastuktur 2412 MHz 54 MB/s 45 WPAWPA nein 
'WLAN02' 34:08:04:DB:05:A0 Infrastuktur 2437 MHz 54 MB/s 37 WPA nein 
'WLAN03' 00:1A:4F:DA:D5:1D Infrastuktur 2462 MHz 54 MB/s 29 WPAWPA nein 
'WLAN04' C0:25:06:BB:10:3C Infrastuktur 2462 MHz 54 MB/s 19 WPAWPA nein 
'WLAN05' 00:26:4D:4B:24:FF Infrastuktur 2437 MHz 54 MB/s 15 WPAWPA nein 

(SSID aus Datenschutzgründen abgeändert)
~~~

### Konfigurierte Verbindungen anzeigen

Mit dem Kommando  *nmcli c*  können die konfigurierten Verbindungen, die man am System angelegt hat, angezeigt werden.

~~~
nmcli c
NAME UUID TYP ZEITSTEMPEL-ECHT 
BluelupoWLAN a9fc7143-11cb-e64a-b6b5-63c94600490c 802-11-wireless Fr 29 Jun 2012 11:06:48 CEST 
BluelupoLAN b92aa237-1b70-4a2b-9bbb-da15a3f0e599 802-3-ethernet Fr 29 Jun 2012 06:17:58 CEST 
BluelupoUMTS fe09a895-f5fa-4b94-8622-d03c4195721e gsm Fr 29 Jun 2012 10:37:30 CEST 
~~~

Im obigen Beispiel sind drei Verbindungen vorhanden WLAN, LAN und eine Mobile Breitbandverbindung.

### Konfigurierte Geräte anzeigen

Will man wissen welche Geräte (Interfaces) überhaupt dem Networkmanager bekannt sind ist  *nmcli d*  hilfreich.

~~~
nmcli d
GERÄT TYP STATUS 
ttyACM0 gsm nicht verbunden
usb0 802-3-ethernet nicht verfügbar
wlan0 802-11-wireless verbunden 
eth0 802-3-ethernet nicht verfügbar
~~~

Sehr detaillierte Informationen (Eigenschaften) gibt es mit  *nmcli dev show*  zum eigenen und dem am Ort verfügbaren WIFI-Netzen (hier im Beispiel aus Datenschutzgründen nicht aufgelistet).

~~~
nmcli dev show
[...]
GENERAL.GERÄT: wlan0
GENERAL.TYP: 802-11-wireless
GENERAL.HERSTELLER: Intel Corporation
GENERAL.PRODUKT: PRO/Wireless 3945ABG [Golan] Network Connection
GENERAL.TREIBER: iwl3945
GENERAL.HWADDR: 00:18:DE:55:11:0D
GENERAL.STATUS: 100 (verbunden)
GENERAL.GRUND: 0 (Kein Grund angegeben)
GENERAL.UDI: /sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/net/wlan0
GENERAL.IP-IFACE: wlan0
GENERAL.NM-VERWALTET: ja
GENERAL.FIRMWARE-FEHLT: nein
GENERAL.VERBINDUNG: /org/freedesktop/NetworkManager/ActiveConnection/3
CAPABILITIES.TRÄGERFREQUENZERKENNUNG: nein
CAPABILITIES.GESCHWINDIGKEIT: 54 Mb/s
WIFI-PROPERTIES.WEP: ja
WIFI-PROPERTIES.WPA: ja
WIFI-PROPERTIES.WPA2: ja
WIFI-PROPERTIES.TKIP: ja
WIFI-PROPERTIES.CCMP: ja
[...]
~~~

### Verbindungen wechseln

Um eine Verbindungsart zu wechseln, z.B. von LAN auf eine WLAN Verbindung, muss man die bestehende aktive Verbindung abbauen und die neue aktivieren. Hier muss man definitiv das Interface angeben, da ein  *nmcli con down id <Name>*  zwar funktioniert, die Verbindung wenn es eine Systemverbindung ist sofort wieder aufgebaut wird.

~~~
Hier hilft folgendes Kommando.

# nmcli dev disconnect iface eth0
# nmcli dev status
GERÄT TYP STATUS 
ttyACM0 gsm nicht verbunden
usb0 802-3-ethernet nicht verfügbar
wlan0 802-11-wireless nicht verbunden
eth0 802-3-ethernet nicht verbunden 
~~~

~~~
Jetzt die WLAN Verbindung aktivieren
# nmcli con up id BluelupoWLAN
# nmcli dev status
GERÄT TYP STATUS 
ttyACM0 gsm nicht verbunden
usb0 802-3-ethernet nicht verfügbar
wlan0 802-11-wireless verbunden
eth0 802-3-ethernet nicht verbunden 
~~~

Man kann das Ganze noch in eine Kommandozeile packen, dann wird der Wechsel sofort durchgeführt.

### Wechsel von einer LAN- zu einer WLAN-Verbindung

~~~
nmcli dev disconnect iface eth0 && sleep 2 && nmcli con up id BluelupoWLAN && nmcli dev status

Umgekehrt von WLAN auf LAN.

nmcli dev disconnect iface wlan0 && sleep 2 && nmcli con up id BluelupoLAN && nmcli dev status
~~~

### Weiterführende Informationen

+       
    ~~~
    man nmcli
    ~~~

+ [Ubuntuusers Wiki](https://wiki.ubuntuusers.de/NetworkManager?redirect=no)

<div id="rev">Page last revised by akli 2020-05-12</div>

nach einem Wiki-Eintrag von Bluelupo
