Änderung: 03-2021

OBSOLET?

## Fliegender Wechsel zwischen LAN und WLAN

`Es ist möglich, dass nicht freie Firmware von einem USB-Stick installiert werden muss. Weitere Informationen dazu im Kapitel [Hardware mit nicht freier Firmware](nf-firm-de.htm#non-free-firmware)` .

Am einfachsten ist der fliegende Wechsel zwischen einer verkabelten LAN-Verbindung und einer drahtlosen WLAN-Verbindung mithilfe des Daemon ifplugd zu gestalten. Dieser ist auf siduction bereits installiert.

<div class="divider" id="interfaces"></div>

#### Anpassen von /etc/network/interfaces

Zunächst muss sichergestellt werden, dass eth0 nicht aktiv ist:

~~~
ifdown eth0
~~~

#### Beispiel für eine funktionierende Konfigurationsdatei interfaces:

Die Einstellung ist einfach: - der Kabelschnittstelle (hier: eth0) darf keine Konfiguration wie "allow-hotplug" oder ähnliches vorausgehen:

~~~
auto lo
iface lo inet loopback

# governed by ifplugd ... do not use allow-hotplug or auto options
iface eth0 inet dhcp

~~~

Im Anschluss wird ifplugd neu konfiguriert:

~~~
dpkg-reconfigure ifplugd
~~~

#### Debconf-Einstellungen von ifplugd

"Static interfaces" bleibt frei:

![Static interfaces](../images-de/ifplugd-de/ifplugd1-de.png "Static interfaces") 

Die Kabelschnittstelle (hier: "eth0") wird "hotplugged interfaces" zugefügt:

![Hotplugged interfaces](../images-de/ifplugd-de/ifplugd2-de.png "Hotplugged interfaces") 

Konfigurationshilfe:

![Configuration help](../images-de/ifplugd-de/ifplugd3-de.png "Configuration help") 

Die Grundeinstellungen können beibehalten werden, man klickt auf OK:

![Default configuration](../images-de/ifplugd-de/ifplugd4-de.png "Default configuraton") 

ifplugd soll vor Einleitung eines Ruhezustands gestoppt werden. Er wird automatisch nach Aufwachen neu gestartet:

![Suspend behaviour](../images-de/ifplugd-de/ifplugd5-de.png "Suspend behaviour") 

 Das Ergebnis ist eine Konfigurationsdatei /etc/default/ifplugd mit folgendem Inhalt:

~~~
INTERFACES=""
HOTPLUG_INTERFACES="eth0"
ARGS="-q -f -u0 -d10 -w -I"
SUSPEND_ACTION="stop"
~~~

Der Computer ist nun bereit, zwischen mehreren Netzwerkschnittstellen zu wechseln. Für eine Roaming-Einstellung des WLAN siehe [WiFi - Aufsetzen von WiFi-Roaming](inet-setup-de.htm) .

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
