% Netzwerk - IWD

## IWD

Intels [iNet wireless daemon](https://iwd.wiki.kernel.org/) (iwd) schickt den wpa-supplicant in den wohlverdienten Ruhestand. Nur ein Zehntel so groß und viel schneller, ist iwd der Nachfolger. iwd funktioniert alleine oder zusammen mit NetworkManager, systemd-networkd und Connman.  
Zwei Dinge, die iwd noch nicht kann, sind die Verbindung per WPA/WPA2 Enterprise und der korrekte Umgang mit versteckten Netzwerken. Bei solchen Arbeitsumgebungen sollte man bei wpa-supplicant bleiben oder ab siduction 2021.3.0 wieder zum [wpa-supplicant wechseln](0502-inet-iwd_de.md#zurück-zum-wpa_supplicant).

Weiterführende Informationen bietet das [Arch Linux wiki](https://wiki.archlinux.org/index.php/Iwd) bzw. das [debian wiki](https://wiki.debian.org/NetworkManager/iwd). 

**Seit siduction 2021.3.0** kommt iwd als Standard für den Verbindungsaufbau im WLAN zum Einsatz. Unsere Implementation läuft mit NetworkManager.

**Seit siduction 2021.1.0** wurde iwd bereits in den Flavours Xorg und noX ausgeliefert. Wer möchte, kann iwd in den anderen Flavours installieren. Siehe weiter unten: [IWD statt wpa_supplicant](0502-inet-iwd_de.md#iwd-statt-wpa_supplicant).

**Vor siduction 2021.1.0**: Auch bei einem etwas älteren Snapshot kann iwd installiert werden (getestet mit siduction 2018.3.0 und linux-image-5.15.12-1-siduction-amd64). Bitte ebenfalls der Anleitung unter [IWD statt wpa_supplicant](0502-inet-iwd_de.md#iwd-statt-wpa_supplicant) folgen.

### Grafische Konfigurationsprogramme

+ **NetworkManager** Für den NetworkManager gibt es verschiedene grafische Oberflächen z.B. für den plasma-desktop/kde `plasma-nm` oder für gnome `network-manager-gnome` und andere. Ihr Benutzung sollte selbsterklärend sein!
+ **conman** ist ein von Intel entwickelter Netzwerkmanager, klein und Ressourcen schonend ist, mehr dazu im [Arch-Wiki](https://wiki.archlinux.org/index.php/ConnMan)
+ **iwgtk** ist nicht in debian-Quellen, es muss aus dem Sourcecode gebaut werden und ist auf [github](https://github.com/J-Lentz/iwgtk) zu finden.

### Konfiguration im Terminal

**iwd und NetworkManager**

1. Der schnellste und einfachste Weg iwd mit dem NetworkManager zu nutzen ist eine Konsole zu öffnen und diesen Befehl einzugeben:

   ~~~txt
   ~$ nmtui
   ~~~

   Es startet im Terminal eine textbasierte, graphische Oberfläche des NetworkManagers. Die Bedienung sollte selbsterklärend sein!

2. Das Kommandline-tool `nmcli` des NetworkManagers benutzen. Ausführliche Informationen hierzu finden sie auf unserer Handbuchseite [Network Manager im Terminal](0501-inet-nm-cli_de.md#network-manager-kommandline-tool)

   Ich beschreibe hier nur kurz den schnellsten Weg ein Netzwerk mit Hilfe des NetworkManagers in der Kommandozeile einzurichten. Vorausgesetzt man hat alle Informationen, reicht jener Einzeiler:

   ~~~txt
   ~$ nmcli dev wifi con "<ssid>" password password name "<name>"
   ~~~

   *"ssid"* bezeichnet den Namen des Netzwerkes

   Zum Beispiel:

   ~~~txt
   nmcli dev wifi con "HomeOffice" password W1rkl1chS3hrG3h31m name "HomeOffice"
   ~~~

**iwd standalone (ohne NetworkManager)**

Intels iwd bringt ein eigenes Kommandline-tool Namens `iwctl` mit. Bitte iwctl nur benutzen, wenn der NetworkManager und wpa_supplicant deinstalliert oder beide im systemd maskiert wurden. 

Als erstes sollte die Hilfe zu iwctl aufgerufen werden, um zu sehen was alles möglich ist. Dafür geben wir im Terminal den Befehl `iwctl` ein, dann am Eingabe-Prompt `help`.

![iwctl Hilfe](./images/iwd/iwctl-help.png)

Um heraus zu finden welche WiFi Schnittstelle wir nutzen geben wir folgenden Befehl ein.

~~~txt
[iwd]# device list
              Devices                             *
---------------------------------------------------
Name   Address            Powered  Adapter  Mode
---------------------------------------------------
wlan0  00:01:02:03:04:05  on       phy0     station
~~~

In diesem Falle ist es *"wlan0"* und es läuft (*"Powered on"*) im *"station"* mode.

Nun scannen wir nach einem aktiven Netzwerk

~~~txt
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
~~~

Jetzt können wir uns zu unserem Netzwerk verbinden.

~~~txt
[iwd]# station wlan0 connect SSID
~~~

*"SSID"* bezeichnet den Namen des Netzwerkes.

Es wird noch das Passwort abgefragt und wir sollten mit unserem Netzwerk verbunden sein, dies können wir mit *"station list"* oder *"station wlan0 get-networks"* Nachprüfen.

~~~txt
[iwd]# station list
     Devices in Station Mode
-------------------------------
Name       State       Scanning
-------------------------------
wlan0      connected
~~~

Das ganze kann mit folgendem Befehl abgekürzt werden, so man alle nötigen Informationen hat!

~~~txt
iwctl --passphrase <passphrase> station device connect SSID
~~~

Zum Beispiel:

~~~txt
~$ iwctl --passphrase W1rkl1chS3hrG3h31m station wlan0 connect HomeOffice
~~~

## IWD statt wpa_supplicant

Allen, die iwd als Ersatz für wpa_supplicant mit einem etwas älteren Snapshot als siduction 2021.3.0 nutzen möchten, richten sich bitte nach den folgenden Anweisungen.

### IWD installieren

> Anmerkung:  
> Es ist möglich, dass nicht freie Firmware von einem USB-Stick oder via LAN installiert werden muss!  
> Debian installiert bei Verwendung von apt den NetworkManager immer zusammen mit wpa_supplicant.
 
Um den wpa_supplicant los zu werden, gibt es zwei Möglichkeiten, wobei die zweite Möglichkeit die sinnvollere und einfachere ist.

1. NetworkManager ohne apt aus den Sourcen installieren.
2. Den wpa_supplicant.service im systemd nicht starten bzw. maskieren.  
   Da siduction systemd nutzt, werden wir nicht darauf eingehen, wie iwd ohne systemd konfiguriert wird!

Möchte man iwd ohne NetworkManager nutzen, so muss man sich darüber keine Gedanken machen, sondern den NetworkManager und wpa_supplicant mit 

~~~txt
~# apt purge network-manager wpasupplicant
~~~

mitsamt seiner Konfiguration von der Platte putzen.
    
**Vorgehensweise bei installiertem NetworkManager**  
**und iwd < 1.21-2**

1. *"iwd"* installieren. 
2. *"NetworkManager.service"* stoppen.
3. *"wpa_supplicant.service"* stoppen und maskieren.
4. Die Datei `/etc/NetworkManager/conf.d/nm.conf` angelegen und iwd dort eingetragen.
5. Die Datei `/etc/iwd/main.conf` anlegen und mit entsprechendem Inhalt befüllen.
6. *"iwd.service"* aktivieren und starten.
7. *"NetworkManager.service"* wieder starten.

Jetzt einfach die folgenden Befehle als root im Terminal ausführen, um iwd zu nutzen:

~~~txt
~# apt update
~# apt install iwd
~# systemctl stop NetworkManager.service
~# systemctl disable --now wpa_supplicant.service
~# echo -e '[device]\nwifi.backend=iwd' > /etc/NetworkManager/conf.d/nm.conf
~# touch /etc/iwd/main.conf
~# echo -e '[General]\nEnableNetworkConfiguration=true\n\n[Network]\nNameResolvingService=systemd' > /etc/iwd/main.conf
~# systemctl enable --now iwd.service
~# systemctl start NetworkManager.service
~~~

**Schauen ob es geklappt hat**  
Wir lassen uns die beiden Konfigurationsdateien anzeigen.

+ /etc/NetworkManager/conf.d/nm.conf

~~~txt
~$ cat /etc/NetworkManager/conf.d/nm.conf
[device]
wiFi.backend=iwd
~~~~

+ /etc/iwd/main.conf

~~~txt
~$ cat /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
~~~

**Vorgehensweise bei installiertem NetworkManager**  
**und iwd >= 1.21-2**

Ab Version 1.21-2 bringt iwd eine eigene Konfigurationsdatei `/etc/iwd/main.conf` mit. Die Vorgehensweise gleicht der eben genannten mit der Ausnahme, dass wir die Konfigurationsdatei nicht mehr anlegen, sondern in ihr das Kommentarzeichen vor "EnableNetworkConfiguration=true" entfernen.

Bitte die folgenden Befehle als root im Terminal ausführen:

~~~txt
~# apt update
~# apt install iwd
~# systemctl stop NetworkManager.service
~# systemctl disable --now wpa_supplicant.service
~# echo -e '[device]\nwifi.backend=iwd' > /etc/NetworkManager/conf.d/nm.conf
~# sed -i -E 's/#(EnableNetworkConfiguration=true)/\1/' /etc/iwd/main.conf
~# systemctl enable --now iwd.service
~# systemctl start NetworkManager.service
~~~

**Schauen ob es geklappt hat**  
Wir lassen uns die beiden Konfigurationsdateien anzeigen.

+ /etc/NetworkManager/conf.d/nm.conf

~~~txt
~$ cat /etc/NetworkManager/conf.d/nm.conf
[device]
wiFi.backend=iwd
~~~~

+ /etc/iwd/main.conf

~~~txt
~$ cat /etc/iwd/main.conf

[...]
[General]
# iwd is capable of performing network configuration on its
# own, including DHCPv4 based address configuration.
# By default this behavior is disabled, and an external
# service such as NetworkManager, systemd-network or
# dhcpclient is required.  Uncomment the following line if
# you want iwd to manage network interface configuration.
#
EnableNetworkConfiguration=true
#
[...]
~~~

Jetzt ist man in der Lage, sich im Terminal mit den oben beschriebenen Befehlen [**nmtui**, **nmcli** oder **iwctl**](0502-inet-iwd_de.md#konfiguration-im-terminal) WiFi Hardware anzeigen zu lassen, sie zu konfigurieren und sich mit einem Netzwerk zu verbinden.  
Oder man benutzt den NetworkManager in der graphischen Oberfläche. Siehe: [Grafische Konfigurationsprogramme](0502-inet-iwd_de.md#grafische-konfigurationsprogramme)

### Zurück zum wpa_supplicant

Vorausgesetzt der NetworkManager und wpa_supplicant sind installiert, benötigen wir folgende Arbeitsschritte:

1. *"NetworkManager.service"* stoppen.
2. *"iwd.service"* stoppen und maskieren.
3. Die Datei `/etc/NetworkManger/conf.d/nm.conf` umbenennen.
4. *"wpa_supplicant.service"* demaskieren und starten.
5. *"NetworkManager.service"* wieder starten.

~~~txt
~# systemctl stop NetworkManager.service
~# systemctl disable --now iwd.service
~# mv /etc/NetworkManager/conf.d/nm.conf /etc/NetworkManager/conf.d/nm.conf~
~# systemctl unmask wpa_supplicant.service
~# systemctl enable --now wpa_supplicant.service
~# systemctl start NetworkManager.service
~~~

Jetzt wird wieder der wpa_supplicant für die Verbindung mit der WiFi-Hardware benutzt.

<div id="rev">Zuletzt bearbeitet: 2022-01-13</div>
