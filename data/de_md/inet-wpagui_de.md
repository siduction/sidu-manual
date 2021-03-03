Änderung: 03-2021

OBSOLET?

## Verwendung von wpa_gui

wpa_gui ist ein auf Qt basierendes graphisches Frontend für wpa_supplicant. Es ermöglicht die Auswahl eines vordefinierten Netzwerks und stellt eine Methode zur Verfügung, Scan-Resultate von 802.11-SSID-Scans anzuzeigen. Auch können Netzwerkeinstellungen von wpa_supplicant geändert werden, und es werden Log-Nachrichten angezeigt.

wpa_gui befindet sich im Paket wpagui.

**`Bevor wpa_gui genutzt werden kann, müssen entweder mit [ceni](inet-ceni-de.htm)  oder mittels Konfigurationsdateien (siehe: [WiFi-Roaming with WPA](inet-setup-de.htm)) eine Basiskonfiguration erstellt werden.`** 

`Es ist möglich, dass nicht freie Firmware von einem USB-Stick installiert werden muss. Weitere Informationen dazu im Kapitel [Hardware mit nicht freier Firmware](nf-firm-de.htm#non-free-firmware) .` 

## Benutzung der graphischen Oberfläche von wpa_gui

wpa_gui kann vom Menü oder als User in einem Terminal mit /usr/sbin/wpa_gui gestartet werden.

Beim ersten Start sieht die Oberfläche so aus:

![First Screen](../images-common/images-wpa-roam/wpa-gui-0.01.png "First Screen") 

Um nach vorhandenen drahtlosen Netzwerken zu suchen klickt man `Scan` .

![Scanning](../images-common/images-wpa-roam/wpa-roam-04.png "Scanning") 

Ein Doppelklick auf das gewünschte Netzwerk öffnet diese Oberfläche:

![Enter passphrase and add](../images-common/images-wpa-roam/wpa-roam-05.png "Enter passphrase and add") 

Das benötigte Passwort wird eingegeben und man klickt auf `add` :

Falls die Verbindung zur Zufriedenheit hergestellt ist, können die Einstellungen mittels `File > Save Configuration`  in der Konfigurationsdatei `/etc/wpa_supplicant/wpa-roam.conf`  gespeichert werden.

Dadurch werden die gespeicherten Netzwerke im Drop-Down-Menü von "Netzwerk" angezeigt:

![The interface](../images-common/images-wpa-roam/wpa-roam-01.png "The interface") 

<!--Click on `Connect`  to access the network.

Im Roaming-Modus muss der Scan-Vorgang wiederholt werden.

<div id="rev">Page last revised 10/01/2012 1445 UTC</div>
