% Netzwerk - IWD

 ANFANG   INFOBEREICH FÜR DIE AUTOREN
 
 Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!
 
 **Status: RC2**
 
 Änderungen: 2021-03-04
 + initial commit
 + WIP
 
 TODO:
 + Dokument aufräumen [done] (es geht um iwd, nicht modem noch firewall)
    + ~~braucht es noch das modem?~~
    + ~~firewall software?~~
 + Installation und nutzung von IWD erklären
    + Komandozeile: nmcli/nmtui/iwctl
       + ~~iwctl [RC3]~~
       + ~~nmcli [RC3]~~
       + ~~nmtui [RC3]~~
    + grafische Programme:
       + NetworkManager
       + iwgtk? (gibt es nicht in debian, ist aber gut zu nutzen)
       + conman
 + Deaktivierung von IWD  zurück zu wpa_supplicant

 Änderung 2021-03-09
 
 + Nutzung von iwctl, done
 + Status von WIP nach RC2 gestuft 
 
 Änderung 2021-03-10
 
 + nmcli & nmtui, done
 
ENDE   INFOBEREICH FÜR DIE AUTOREN
 
## IWD installieren

Wer möchte, kann iwd als Ersatz für wpa-supplicant nutzen, entweder eigenständig, oder in Verbindung mit dem NetworkManager. 

Einfach die folgenden Befehle als root im Terminal ausführen, um iwd zu nutzen:

    Anmerkung:
    Unter debian ist es leider nicht möglich den NetworkManager (standalone) ohne wpa_supplicant zu installieren.
    Möchte man dieses so gibt es zwei Möglichkeiten (eigentlich nur eine):

        1. NetworkManager aus den Sourcen installieren
        2. den wpa_supplicant.service nicht starten bzw. maskieren, da dieser ja mit installiert wird so man apt nutzt.

    Wobei die zweite Möglichkeit die einfachere ist.
    Möchte man iwd ohne NetworkManager nutzen, muss man sich darüber keine Gedanken machen

Vorrausgesetzt der NetworkManager ist installiert, 
+ als erstes wird **iwd** installiert, 
+ dann wird der **wpa_supplicant.service** gestopt und maskiert,
+ dann der **NetworkManager.service** angehalten,
+ nun die Datei `/etc/NetworkManager/conf.d/nm.conf` angelegt und **iwd** dort eingetragen, 
+ dann legen wir die Datei `/etc/iwd/main.conf` an und befüllen diese mit entsprechendem Inhalt, 
+ aktivieren und starten den **iwd.service**, 
+ und starten den **NetworkManager.service**.

~~~
apt update
apt install iwd
systemctl stop wpa_supplicant.service
systemctl mask wpa_supplicant.service
systemctl stop NetworkManager.service
touch /etc/NetworkManager/conf.d/nm.conf
echo -e "[device]\nwifi.backend=iwd" > /etc/NetworkManager/conf.d/nm.conf
touch /etc/iwd/main.conf
echo -e "[General]\nEnableNetworkConfiguration=true\n\n[Network]\nNameResolvingService=systemd" > /etc/iwd/main.conf
systemctl enable -now iwd.service
systemctl start NetworkManager.service
~~~

Schauen ob es geklappt hat
+ /etc/NetworkManager/conf.d/nm.conf
~~~
~$ cat /etc/NetworkManager/conf.d/nm.conf
[device]
wifi.backend=iwd
~~~~
+ /etc/iwd/main.conf
~~~
~$ cat /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
~~~

Jetzt ist man in der Lage im Terminal mit dem Befehl *`iwctl`* eine interaktive Shell zu starten. Die Eingabe von "help" gibt alle Optionen aus um WiFi Hardware anzuzeigen, zu konfigurieren und sich mit einem Netzwerk zu verbinden. Auch kann man *`nmtui`* oder *`nmcli`* im Terminal bzw. den NetworkManager in der graphischen Oberfläche benutzen.

    Anmerkung:
    Es ist möglich, dass nicht freie Firmware von einem USB-Stick installiert werden muss, bzw via LAN!
    Weitere Informationen dazu im Kapitel [Hardware mit nicht freier Firmware](nf-firm-de.htm#non-free-firmware). 

## Konfiguration einer Netzwerkverbindung mit IWD

Der schnellste und einfachste Weg iwd zu nutzen ist, eine Konsole zu öffnen und diesen Befehl einzugeben *(Vorrausgesetzt man nutzt den NetworkManager.service)*:

~~~
nmtui
~~~

Dies sollte selbsterklärend sein!

## Eine wifi Verbindung mit *nmcli* aufbauen

Ich beschreibe hier nur kurz den schnellsten Weg ein Netzwerk mit Hilfe des Network-Managers in der Kommandozeile einzurichten.

Um eine Verbindung aufzubauen, vorausgesetzt man hat alle Informationen, reicht jener Einzeiler. Alle anderen Informationen zu *nmcli* finden sie auf folgender Seite, [inet-nm-cli_de](inet-nm-cli_de.md)

```
nmcli dev wifi con "ssid" password suppergeheim name "name"

```

Zum Beispiel:
```
nmcli dev wifi con "HomeOffice" password 8chG3hD0chH31m name "HomeOffice"

```
## Eine wifi Verbindung mit *iwctl* einrichten, ohne den Network-Manager

Als erstes sollte die Hilfe zu *iwd* aufgerufen werden, um zu sehen was alles möglich ist.

Dafür geben wir im Terminal den Befehl *`iwctl`* ein, dann am Eingabe-Prompt *help*.
```
:~$ iwctl
[iwd]# help

                               iwctl version 1.12                              
--------------------------------------------------------------------------------
  Usage
--------------------------------------------------------------------------------
  iwctl [--options] [commands]
                               Available options
--------------------------------------------------------------------------------
  Options                                           Description                 
--------------------------------------------------------------------------------

[...] hier steht jetzt eine ganze Menge, welches ich hier nicht auflisten kann!
```
Um heraus zu finden welche wifi Schnittstelle wir nutzen geben wir folgenden Befehl ein.

```
[iwd]# device list
                                    Devices                                   *
--------------------------------------------------------------------------------
  Name                Address             Powered   Adapter   Mode
--------------------------------------------------------------------------------
  wlan0               00:01:02:03:04:05   on        phy0      station
```
In diesem Falle ist es *wlan0* und es läuft (*Powered on*) im *station* mode.

Nun scannen wir nach einem aktiven Netzwerk
```
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
```
Jetzt können wir uns zu unserem Netzwerk verbinden.
```
[iwd]# station wlan0 connect SSID
```
(*SSID* bezeichnet den Name des Netzwerkes)

Es wird noch das Passwort abgefragt und wir sollten mit unserem Netzwerk verbunden sein, dies können wir mit *"station list"* oder *"station wlan0 get-networks"* Nachprüfen.

```
[iwd]# station list
                            Devices in Station Mode
--------------------------------------------------------------------------------
  Name                State          Scanning
--------------------------------------------------------------------------------
  wlan0               connected
```
Das ganze kann mit folgendem Befehl abgekürzt werden, so man alle nötigen Informationen hat!

```
iwctl --passphrase passphrase station device connect SSID
```
Zum Beispiel:
```
iwctl --passphrase 8chG3hD0chH31m station wlan0 connect HomeOffice
```
<div id="rev">Page last revised 10-03-2021</div>
