% Netzwerk - ceni

ANFANG INFOBEREICH FÜR DIE AUTOREN
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!
Status: Old - Obsolet

2021-02-03

Frage: 

Ceni ist auf keinem unser iso's  installiert, der Network-Manger (nmtui, nmcli) hat die aufgabe das netzwerk zu konfigurieren übernommen.
Ergo, diese Seite hat höchstens einen historischen Wert aber ist ansonsten Sinnfrei.

Braucht es diese Seite dann noch?

## Konfiguration einer Netzwerkverbindung mit Ceni

`Es ist möglich, dass nicht freie Firmware von einem USB-Stick installiert werden muss. Weitere Informationen dazu im Kapitel [Hardware mit nicht freier Firmware](nf-firm-de.htm#non-free-firmware) .` 

Die Verbindung zu einem DHCP-Server im LAN wird automatisch während des Bootvorgangs hergestellt. Für weitere Optionen ist das Netzwerkkonfigurations-Tool `Ceni`  hilfreich, welches sich hier im Menü findet: `KDE-Start-Menü > Internet > Ceni - Netzwerkkarte konfigurieren` . Damit wird eine Konsole geöffnet, in welcher das Root-Passwort angefragt wird. Im Live-CD-Modus entfällt die Eingabe des Root-Passworts.

Der schnellste Weg, Ceni zu starten, ist, eine Konsole zu öffnen und diesen Befehl einzugeben:

~~~
ceni
~~~

Auf installierten Systemen wird nach dem Root-Passwort gefragt.

![Ceni Network Interfaces](../images-common/images-netcard/Ceni-interface-selection-01.png "Ceni Netzwerkgeräte") 

![Ceni Network Settings](../images-common/images-netcard/Ceni-static-network-configuration-02.png "Ceni Netzwerkeinstellunen") 

---

 `Eine der Stärken von Ceni ist die Konfiguration von drahtlosen Netzwerkverbindungen (WiFi), siehe das Kapitel [WiFi - Aufsetzen einer WLAN-Verbindung](inet-wpa-de.htm#wpa-basic) :`
![Ceni Wifi-Einstellungen](../images-common/images-netcard/Ceni-wireless-network-selection-02.png "Ceni Wireless Settings") 

![Scan or Roam](../images-common/images-netcard/Ceni-wireless-network-configuration-01.png "Ceni Scannen oder Roamen") 

<div class="divider" id="dial-mod"></div>

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

<div id="rev">Page last revised 02/08/2012 1545 UTC</div>
