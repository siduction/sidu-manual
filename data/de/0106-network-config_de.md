% WLAN Konfiguration

## Konfiguration von Netzwerken

Der in allen graphischen Oberflächen von siduction integrierte `NetworkManager` bietet eine schnelle Konfiguration von Netzwerkkarten (WLAN und Ethernet). Im Terminal bietet das Skript `nmcli` Zugang zur Funktionalität des NetworkManager.  
Drahtlose Netzwerke werden gescant. Man kann sich mit den gefundenen Netzwerken verbinden und Einstellungen zur Verschlüsselungsmethode, zum Internet Protokoll IPv4 oder IPv6 und zu einem Proxy Server vornehmen. Als Backend kommt `iwd` zum Einsatz. Die Ethernet-Konfiguration erfolgt bei Verwendung eines DHCP-Servers am Router (dynamische Zuweisung einer IP-Adresse) automatisch, aber auch die Möglichkeit eines manuellen Setups (von Netmasks bis Nameserver) ist gegeben.  
Auf dem Live Medium und nach der Installation ist der NetworkManager mit seinem Backend iwd bereits konfiguriert und einsatzbereit.

### NetworkManager

In der graphischen Oberfläche befindet sich der NetworkManager in der Taskleiste. Er ist größtenteils selbsterklärend.

Mit **`nmcli`** oder **`nmtui`** steht ein leistungsfähiger Kommandozeilenclient für den täglichen Gebrauch des NetworkManagers zur Verfügung. *nmtui* bietet eine benutzerfreundliche ncurses Oberfläche innerhalb des Terminals. Auch hier ist die Funktion größtenteils selbsterklärend. Falls das Skript nicht vorhanden ist, installiert man es mit:

~~~
apt install network-manager
~~~

Der Startbefehl in der Konsole ist **`nmcli`**.  
Eine detaillierte Beschreibung zur Bedienung findet sich unter [Netzwerk - nmcli](0501-inet-nm-cli_de.md#network-manager-kommandline-tool).

Hat man alle notwendigen Informationen zur Hand, genügt auch eine einzige Kommandozeile.  
Beispiel:  
Device Name = wlan0  
Device Type = wifi  
SSID = HOME_WLAN  
Passwort = s3Hrg3he!m

Befehl zum Aufbau der WLAN Verbindung:

~~~
nmcli device wifi connect "HOME_WLAN" password "s3Hrg3he!m"
~~~

Die Verbindung trennt man mit:

~~~
nmcli device down wlan0
~~~

NetworkManager speichert die einmal eingegebenen Verbindungsdaten. Befindet man sie erneut in Reichweite dieses Routers, stellt NetworkManager die Verbindung automatisch wieder her. Um das Verhalten zu ändern bitte die Manpages  
**`man NetworkManager`**  
und  
**`man nm-settings`**  
konsultieren.

<div id="rev">Zuletzt bearbeitet: 2023-11-13</div>
