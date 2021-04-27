% Netzwerk - IWD

# IWD

Intels [iNet wireless daemon](https://iwd.wiki.kernel.org/) (iwd) schickt den WPA-Supplicant in den wohlverdienten Ruhestand. Nur ein Zehntel so groß und viel schneller; ist iwd der Nachfolger. 

Weiterführende Informationen bietet das [Arch Linux wiki](https://wiki.archlinux.org/index.php/Iwd) bzw. das [debian wiki](https://wiki.debian.org/NetworkManager/iwd). 

Wer möchte, kann iwd als Ersatz für wpa_supplicant nutzen, entweder eigenständig oder in Verbindung mit dem NetworkManager. 

## IWD installieren

Einfach die folgenden Befehle als root im Terminal ausführen, um iwd zu nutzen:

~~~note
Anmerkung:
 Unter debian ist es leider nicht möglich den NetworkManager (standalone) ohne wpa_supplicant zu installieren.
 Möchte man dieses so gibt es zwei Möglichkeiten (eigentlich nur eine):

    1. NetworkManager aus den Sourcen installieren
    2. den wpa_supplicant.service nicht starten bzw. maskieren, da dieser ja mit installiert wird, so man apt nutzt.

 Wobei die zweite Möglichkeit die einfachere ist.
    
 Möchte man iwd nutzen ohne NetworkManager zu installieren, so muss man sich darüber keine Gedanken machen
    
 Weiterhin machen wir darauf Aufmerksam, dass siduction systemd nutzt.
 Wir werden also nicht darauf eingehen wie iwd ohne systemd konfiguriert wird!
~~~

Vorrausgesetzt der NetworkManager ist installiert,```

+ als erstes wird **iwd** installiert, 
+ dann wird der **wpa_supplicant.service** gestopt und maskiert,
+ dann der **NetworkManager.service** angehalten,
+ nun die Datei `/etc/NetworkManager/conf.d/nm.conf` angelegt und **iwd** dort eingetragen, 
+ dann legen wir die Datei `/etc/iwd/main.conf` an und befüllen diese mit entsprechendem Inhalt, 
+ aktivieren und starten den **iwd.service**, 
+ und starten den **NetworkManager.service**.

~~~sh
~# apt update
~# apt install iwd
~# systemctl stop wpa_supplicant.service
~# systemctl mask wpa_supplicant.service
~# systemctl stop NetworkManager.service
~# touch /etc/NetworkManager/conf.d/nm.conf
~# echo -e '[device]\nWiFi.backend=iwd' > /etc/NetworkManager/conf.d/nm.conf
~# touch /etc/iwd/main.conf
~# echo -e '[General]\nEnableNetworkConfiguration=true \n\n[Network]\nNameResolvingService=systemd' > /etc/iwd/main.conf
~# systemctl enable -now iwd.service
~# systemctl start NetworkManager.service
~~~

Schauen ob es geklappt hat

+ /etc/NetworkManager/conf.d/nm.conf
~~~sh
~$ cat /etc/NetworkManager/conf.d/nm.conf
[device]
WiFi.backend=iwd
~~~~

+ /etc/iwd/main.conf

~~~sh
~$ cat /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
~~~

Jetzt ist man in der Lage im Terminal mit dem Befehl [**iwctl**](#iwctl) eine interaktive Shell zu starten. Die Eingabe von "help" gibt alle Optionen aus um WiFi Hardware anzuzeigen, zu konfigurieren und sich mit einem Netzwerk zu verbinden. Auch kann man **nmtui** oder [**nmcli**](#nmcli) im Terminal bzw. den NetworkManager in der graphischen Oberfläche benutzen.

~~~note
Hinweis:
 Es ist möglich, dass nicht freie Firmware von einem USB-Stick installiert werden muss, bzw via LAN!
~~~

**Weitere Informationen:**  
[Hardware mit nicht freier Firmware](nf-firm_de.md). 

## Konfiguration einer Netzwerkverbindung mit IWD

Der schnellste und einfachste Weg iwd zu nutzen ist eine Konsole zu öffnen und diesen Befehl einzugeben *(Vorrausgesetzt man nutzt den NetworkManager.service)*:

~~~sh
~$ nmtui
~~~

Dies sollte selbsterklärend sein!

### <a name="nmcli"></a>Eine WiFi Verbindung mit *nmcli* aufbauen

Ich beschreibe hier nur kurz den schnellsten Weg ein Netzwerk mit Hilfe des NetworkManagers in der Kommandozeile einzurichten.

Um eine Verbindung aufzubauen, vorausgesetzt man hat alle Informationen, reicht jener Einzeiler. Alle anderen Informationen zu *nmcli* finden sie auf folgender Seite, [inet-nm-cli_de](inet-nm-cli_de.md)

```sh
~$ nmcli dev WiFi con "ssid" password password name "name"

```
(*ssid* bezeichnet den Namen des Netzwerkes)

Zum Beispiel:
```
nmcli dev WiFi con "HomeOffice" password W1rkl1chS3hrG3h31m name "HomeOffice"

```
### <a name="iwctl"></a>Eine WiFi Verbindung mit *iwctl* einrichten, ohne den NetworkManager

Als erstes sollte die Hilfe zu *iwctl* aufgerufen werden, um zu sehen was alles möglich ist.

Dafür geben wir im Terminal den Befehl *`iwctl`* ein, dann am Eingabe-Prompt *help*.

 ![iwctl help](./images/iwd/iwctl-help.png)

Um heraus zu finden welche WiFi Schnittstelle wir nutzen geben wir folgenden Befehl ein.

```sh
[iwd]# device list
                                    Devices                                   *
--------------------------------------------------------------------------------
  Name                Address             Powered   Adapter   Mode
--------------------------------------------------------------------------------
  wlan0               00:01:02:03:04:05   on        phy0      station
```
In diesem Falle ist es *wlan0* und es läuft (*Powered on*) im *station* mode.

Nun scannen wir nach einem aktiven Netzwerk

```sh
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
```
Jetzt können wir uns zu unserem Netzwerk verbinden.

```sh
[iwd]# station wlan0 connect SSID
```
(*SSID* bezeichnet den Namen des Netzwerkes)

Es wird noch das Passwort abgefragt und wir sollten mit unserem Netzwerk verbunden sein, dies können wir mit *"station list"* oder *"station wlan0 get-networks"* Nachprüfen.

```sh
[iwd]# station list
                            Devices in Station Mode
--------------------------------------------------------------------------------
  Name                State          Scanning
--------------------------------------------------------------------------------
  wlan0               connected
```
Das ganze kann mit folgendem Befehl abgekürzt werden, so man alle nötigen Informationen hat!

```sh
iwctl --passphrase passphrase station device connect SSID
```
Zum Beispiel:

```sh
~$ iwctl --passphrase W1rkl1chS3hrG3h31m station wlan0 connect HomeOffice

```
### Grafische Programme zur Konfiguration eines WiFi Netzwerkes

+ NetworkManager, für den NetworkManager gibt es verschiedene grafische Oberflächen zB. für den plasma-desktop/kde plasma-nm oder für gnome network-manager-gnome und andere. Ihr Benutzung sollte selbsterklärend sein!
+ conman ist ein von Intel entwickelter Netzwerkmanager, klein und Ressourcen schonend ist, mehr dazu im [Arch-Wiki](https://wiki.archlinux.org/index.php/ConnMan)
+ iwgtk, ist nicht in debian-quellen, es muss aus dem Sourcecode gebaut werden und ist auf [github](https://github.com/J-Lentz/iwgtk) zu finden.

## Zurück zum wpa_supplicant

*(Vorausgstezt NetworkManager und wpa_supplicant sind installiert)*

+ Den **iwd.service** stoppen und maskieren.
+ Den **NetworkManager.service** stoppen.
+ Die Datei **/etc/NetworkManger/conf.d/nm.conf** umbenennen.
+ Demaskieren und starten des **wpa_supplicant.service**.
+ Den **NetworkManager.service** wieder starten.

```sh
~# systemctl stop iwd.service
~# systemctl mask iwd.servicenetwork-manager-gnome
~# systemctl stop NetworkManager.service
~# mv /etc/NetworkManager/conf.d/nm.conf /etc/NetworkManager/conf.d/nm.conf~
~# systemctl unmask wpa_supplicant.service
~# systemctl enable --now wpa_supplicant.service
~# systemctl start NetworkManager.service
```
Jetzt wird *wpa_supplicant* für die Verbindung mit der WiFi-Hardware benutzt.

<div id="rev">Page last revised 13-04-2021</div>
