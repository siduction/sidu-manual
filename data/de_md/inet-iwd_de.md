% Netzwerk - IWD

 ANFANG   INFOBEREICH FÜR DIE AUTOREN
 
 Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!
 
 **Status: WIP**
 
 Änderungen: 2021-03-04
 + initial commit
 + WIP
 
 TODO:
 + Dokument aufräumen
    + braucht es noch das modem?
    + firewall software?
 + Installation und nutzung von IWD erklären
    + Komandozeile: nmcli/nmtui/iwctl
    + grafische Programme:
       + NetworkManager
       + iwgtk gibt es nicht in debian, ist aber gut zu nutzen
       + conman
 + Deaktivierung von IWD  zurück zu wpa_supplicant
 
ENDE   INFOBEREICH FÜR DIE AUTOREN
 
## IWD installieren

Wer möchte, kann iwd als Ersatz für wpa-supplicant nutzen, entweder eigenständig, oder in Verbindung mit dem NetworkManager. 

Einfach die folgenden Befehle als root im Terminal ausführen, um iwd zu nutzen:

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

Jetzt ist man in der Lage im Terminal mit dem Befehl **`iwctl`** eine interaktive Shell zu starten. Die Eingabe von "help" gibt alle Optionen aus um WiFi Hardware anzuzeigen, zu konfigurieren und sich mit einem Netzwerk zu verbinden. Auch kann man **`nmtui`** oder **`nmcli`** im Terminal bzw. den NetworkManager in der graphischen Oberfläche benutzen.
 

## Konfiguration einer Netzwerkverbindung mit IWD

`Es ist möglich, dass nicht freie Firmware von einem USB-Stick installiert werden muss. Weitere Informationen dazu im Kapitel [Hardware mit nicht freier Firmware](nf-firm-de.htm#non-free-firmware) .` 

Der schnellste und einfachste Weg iwd zu nutzen ist, eine Konsole zu öffnen und diesen Befehl einzugeben *(Vorrausgesetzt man nutzt den NetworkManager.service)*:

~~~
nmtui
~~~

## Internetverbindung mit einem 56k Einwahlmodem

KDE hat ein Frontend für Einwahlmodems: `KPPP (Einwahl ins Internet)` . Es befindet sich in KDE-Start-Menü > Internet > KPPP - Einwahl ins Internet.

Die Anwendung hat eine interne Hilfe und bietet eine gut verständliche Anleitung zum Aufsetzen der Verbindung.

<div class="divider" id="firewalls"></div>

## Firewalls

Firewalls werden normalerweise nicht benötigt, wenn man sich hinter einem ordentlich konfigurierten Router befindet. Dennoch spielen sie eine sehr wichtige Rolle bei der Sicherheit, wenn man sich direkt über ein DSL-(USB-)Modem oder ein Einwahlmodem ins Internet verbinden muss:

~~~
apt-get install shorewall
~~~

oder

~~~
apt-get install shorewall6 
~~~

für IPv6 Verbindungen
[Shorewall- Ein grafisches Konfigurationstool für Netfilter in Linux.](http://www.shorewall.net/)  [Hinweis: Shorewall nicht auf entfernten Rechnern installieren, ihr schliesst euch ziemlich sicher selbst vom Zugang zum Server aus!] 

<div id="rev">Page last revised 04-03-2021</div>
