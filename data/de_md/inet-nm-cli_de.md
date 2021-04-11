% Network Manager im Terminal

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC3**

Änderungen 2020-05:

+ Inhalt nur redaktionell aktualisiert
+ Korrektur und Prüfung aller Links, Ubuntu-man entfernt, da mit 'man nmcli' identisch
Änderungen 2020-06:
+ Dateinamen und Titelanker geändert um das Dokument sinnvoll in die Dateihirarchie zu integrieren.

Änderungen 2021-04:

+ Für die Verwendung mit pandoc optimiert.
+ Inhalt teilweise überarbeitet.

ENDE   INFOBEREICH FÜR DIE AUTOREN

## Allgemeine Hinweise

Der Networkmanager ist mittlerweile ein sehr brauchbarer Ersatz für das Netzwerkkommando  *ifup, ifdown*  bzw.  *ifconfig*  in der Debianwelt geworden. Das Vorurteil das sich der Networkmanager nicht für die Kommandozeile eignet oder gar instabil läuft gehört ins Reich der Märchenwelt. Es existiert ein leistungsfähiger Kommandozeilenclient  **nmcli**  für den täglichen Gebrauch des Networkmanagers.

In den nachfolgenden Beispielen gehen wir von zwei konfigurierten Verbindungen aus. Eine WLAN-Verbindung (Name: BluelupoWLAN, Interface wlp4s0 (früher; wlan)) und einer kabelgebundenen Verbindung (Name: BluelupoLAN, Interface enp2s0 (früher: eth0)). Bitte die Verbindungsnamen an eure Gegebenheiten anpassen.

### Installation

Falls der Networkmanager auf dem System noch nicht installiert ist, kann man dies nachholen. Im nachfolgenden Kommando sind alle Pakete die man braucht um alle möglichen Verbindungsarten zu konfigurieren (mobiles Breitband, WLAN und LAN Verbindungen), sowie das grafische KDE-Plasma-Widget für den NM. Bitte alles in eine Zeile eingeben.

~~~
apt install network-manager modemmanager mobile-broadband-provider-info network-manager-pptp
 plasma-widget-networkmanagement network-manager-vpnc network-manager-openvpn
~~~

---

## Network Manager 'nmcli' verwenden

Die Eingaben können sowohl in einem virtuellen Terminal (Tastenkombination `Str` + `Umschalt` + `F2`) als auch in der graphischen Oberfläche in einer Konsole getätigt werden. In den abgebildeten Beispielen wurden die Angaben aus Datenschutzgründen abgeändert.

### Konfigurierte Verbindungen anzeigen

Mit dem Kommando  **nmcli c**  können die konfigurierten Verbindungen, die man am System angelegt hat, angezeigt werden.

~~~
nmcli c
NAME                         UUID                                  TYPE      DEVICE
WirelessAdapter_2            4c247331-05bd-4ae6-812b-6c70b35dc348  wifi      wtx7ckd90b81bbd
Kabelgebundene Verbindung 1  847d4195-3355-33bc-bea8-7a016ab86824  ethernet  evp0s3f76
Kabelgebundene Verbindung 2  efc70b04-01f1-31fc-b948-5fd9ceca651d  ethernet  --
MobilesNetzUMTS              fe0933bc-f5fa-4b94-8622-d03c4195721e  gsm       xyz72905dg34
~~~

Im obigen Beispiel sind vier Verbindungen vorhanden WLAN, 2x LAN und eine Mobile Breitbandverbindung.

### Informationen zu WIFI Netzen anzeigen

Welche WLAN-Netze sind überhaupt am Standort verfügbar, das kann man sich in kompakter Form mit  **nmcli dev wifi list**  anzeigen lassen.

~~~
nmcli dev wifi list
IN-USE  BSSID              SSID           MODE   CHAN  RATE        SIGNAL  BARS  SECURITY
*       14:CF:20:C6:1A:8F  WLAN-01        Infra  6     270 Mbit/s  92      ▂▄▆█  WPA2
        54:67:64:3D:02:30  WLAN-02        Infra  1     405 Mbit/s  85      ▂▄▆█  WPA2
        D0:AA:2A:17:EE:9B  WLAN-03        Infra  11    270 Mbit/s  52      ▂▄__  WPA2
~~~

### Konfigurierte Geräte anzeigen

Will man wissen welche Geräte (Interfaces) überhaupt dem Networkmanager bekannt sind ist  **nmcli d**  hilfreich.

~~~
nmcli d
DEVICE           TYPE      STATE            CONNECTION
evp0s3f76        ethernet  verbunden        Kabelgebundene Verbindung 1 
wtx7ckd90b81bbd  wifi      verbunden        Einhorn_2
evp3u3           ethernet  nicht verfügbar  --
ttyACM0          gsm       nicht verbunden  --
~~~

Sehr detaillierte Informationen (Eigenschaften) gibt es mit  **nmcli dev show**  zu den eigenen verfügbaren Verbindungen. Hier nur der Auszug für das WLAN.

~~~
nmcli dev show
[...]
GENERAL.DEVICE:                         wtx7ckd90b81bbd
GENERAL.TYPE:                           wifi
GENERAL.HWADDR:                         7C:FA:83:C2:6B:BD
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (verbunden)
GENERAL.CONNECTION:                     WirelessAdapter_2
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/2
IP4.ADDRESS[1]:                         192.168.0.6/24
IP4.GATEWAY:                            192.168.0.1
IP4.ROUTE[1]:                           dst = 0.0.0.0/0, nh = 192.168.0.1, mt = 600
IP4.ROUTE[2]:                           dst = 192.168.0.0/24, nh = 0.0.0.0, mt = 600
IP4.DNS[1]:                             192.168.0.1
IP4.DOMAIN[1]:                          home
IP6.ADDRESS[1]:                         2a02:810d:cc0:c4c:7edd:90ff:feb2:1bbd/64
IP6.ADDRESS[2]:                         fe80::7edd:90ff:feb2:1bbd/64
IP6.GATEWAY:                            fe80::362c:c4ff:fe17:1bf1
IP6.ROUTE[1]:                           dst = 2a02:810d:cc0:c4c::/64, nh = ::, mt = 256
IP6.ROUTE[2]:                           dst = fe80::/64, nh = ::, mt = 256
IP6.ROUTE[3]:                           dst = ::/0, nh = fe80::dc53:e2ff:fe81:6d46, mt = 1024
IP6.ROUTE[4]:                           dst = ::/0, nh = fe80::362c:c4ff:fe17:1bf1, mt = 1024
IP6.ROUTE[5]:                           dst = ff00::/8, nh = ::, mt = 256, table=255
[...]
~~~

Die Zugangsdaten zum WLAN kann man sich mit **nmcli dev wifi show** anzeigen lassen.

~~~
nmcli dev wifi show
SSID: WirelessAdapter_2
Sicherheit: WPA
Passwort: <das steht jetzt nicht hier>

  █████████████████████████████████
  ██ ▄▄▄▄▄ █▀ █▀▀██▀▄ ▀▄██ ▄▄▄▄▄ ██
  ██ █   █ █▀  █▄█ ▀ ▄ █▀█ █   █ ██
  ██ █▄▄▄█ █▀█ █▄█▀▀▄█▀▄▀█ █▄▄▄█ ██
  ██▄▄▄▄▄▄▄█▄█▄█ █▄█ █ ▀ █▄▄▄▄▄▄▄██
  ██ ▀█▄▀▄▄▀█▀ █▄ ▀▀▀▀▀▀ ▀▀▄▀ █ ▄██
  ██ ▄  ▄█▄▄▄ ▄█▄▄ █▀ ▄▄ ▄▀▄▀▄▀ ███
  ██    ▄▀▄▀▀ ▀▀ ▀█▀██ ▄▄▀▄ ▄ ▀▀ ██
  ███ ▀█ ▄▄▀▀▀ █▀▄▀▄▄▄█▀███▄█▀▄████
  ██ ▄▀▄█ ▄██▄▀▄ ▀▀█  ▄ ▀███▀ █ ▄██
  ███ ▀█ ▄▄▀▀▀ █▀▄▀▄▄▄█▀███▄█▀▄████
  ██▄█▄█▄█▄▄ ▄▀▄▀▀█▄▄█▀▄ ▄▄▄ ▄ ████
  ██ ▄▄▄▄▄ █▄ ▀█▀ ▄▄▀█▄  █▄█ ▀▄████
  ██ █   █ █ ▄██▄█▄█▄▀▀  █▄█ ▀█  ██
  ██ █▄▄▄█ ██▄█ ▀  ▄█▀▀█ ▄ ▄  ▄ ███
  ██▄▄▄▄▄▄▄█▄▄▄▄█████▄▄▄█▄▄█▄▄█████
  █████████████████████████████████
  
~~~

Der zusätzlich generierte QR-Code vereinfacht den Login für Smartphone und Tablet.

### Verbindungen wechseln

Um eine Verbindungsart zu wechseln, z.B. von LAN auf eine WLAN Verbindung, muss man die bestehende aktive Verbindung abbauen und die neue aktivieren. Hier muss man definitiv das Interface angeben, da ein  *nmcli con down id <Name>*  zwar funktioniert, die Verbindung, wenn es eine Systemverbindung ist, aber sofort wieder aufgebaut wird.

Um die automatische Verbindung zu verhindern hilft der Befehl **nmcli dev disconnect <Schnittstellenname>**.  
Zuerst beenden wir die LAN-Verbindung und fragen danach den Status ab.

~~~
# nmcli dev disconnect evp0s3f76
Gerät »evp0s3f76« wurde erfolgreich getrennt.
# nmcli dev status
DEVICE           TYPE      STATE            CONNECTION 
evp0s3f76        ethernet  nicht verbunden  --
wtx7ckd90b81bbd  wifi      nicht verbunden  --
evp3u3           ethernet  nicht verfügbar  --
ttyACM0          gsm       nicht verbunden  --
~~~

Jetzt die WLAN Verbindung aktivieren mit **nmcli con up id <Verbindungsname>**:

~~~
# nmcli con up id WirelessAdapter_2
Verbindung wurde erfolgreich aktiviert 
# nmcli dev status
DEVICE           TYPE      STATE            CONNECTION 
wtx7ckd90b81bbd  wifi      verbunden        WirelessAdapter_2
evp0s3f76        ethernet  nicht verbunden  --
evp3u3           ethernet  nicht verfügbar  --
ttyACM0          gsm       nicht verbunden  --
~~~

Man kann das Ganze noch in eine Kommandozeile packen, dann wird der Wechsel sofort durchgeführt.

Von LAN zu WLAN:

~~~
nmcli dev disconnect evp0s3f76 && sleep 2 && nmcli con up id WirelessAdapter_2
~~~

Umgekehrt von WLAN zu LAN:

~~~
nmcli dev disconnect wtx7ckd90b81bbd && sleep 2 && nmcli con up id 'Kabelgebundene Verbindung 1'
~~~

---

## Weiterführende Informationen

+       
    ~~~
    man nmcli
    ~~~

+ [Ubuntuusers Wiki](https://wiki.ubuntuusers.de/NetworkManager?redirect=no)

---

<div id="rev">Zuletzt bearbeitet: 2020-04-11</div>
