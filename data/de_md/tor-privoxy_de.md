<div class="divider" id="privoxy"></div>

## Privoxy

 Privoxy ist ein Web-Proxy mit umfangreichen Filtermöglichkeiten zum Schutz der Privatsphäre, zur Modifizierung von Daten einer Website, für das Cookie-Management, zur Zugangskontrolle und zur Entfernung von Werbung, Werbebannern, Pop-Ups und weiterem lästigen Internet-Müll. Privoxy kann sehr flexibel konfiguriert und an die persönlichen Ansprüche angepasst werden. Privoxy umfasst Anwendungen sowohl für Einzelplatzsysteme als auch für Netzwerke mit Mehrbenutzersystemen. Privoxy basiert auf Internet Junkbuster™.

Installation von Privoxy:

~~~
apt-get update
apt-get install privoxy
~~~

Eine Installation mit den Grundeinstellungen sollte einen vernünftigen Ausgangspunkt für die meisten Nutzer bieten. Zweifellos wird es Situationen geben, in denen eine Anpassung der Konfiguration erwünscht ist, diese muss aber erst dann durchgeführt werden, wenn sie benötigt wird. In den meisten Fällen ist nach der Installation keine Anpassung der Konfiguration notwendig.

Abhängig von den persönlichen Präferenzen kann es nötig sein, in der Privoxy-Konfigurationsdatei Zeilen zu aktivieren (Raute am Beginn rausnehmen). Welche, muss der Nutzer selbst entscheiden.

Weiterführende Informationen bietet das englischsprachige  
[Benutzerhandbuch von Privoxy](http://www.privoxy.org/user-manual/index.html)  
mit Erläuterungen zu erweiterten Konfigurationsmöglichkeiten.

<div class="divider" id="tor"></div>

## Tor

Tor ist ein Netzwerk virtueller Tunnel, welches den Schutz der Privatsphäre und die Sicherheit im Internet erhöht. Auch ermöglicht es Programmierern neue Kommunikationssoftware mit integrierten Features zum Schutz der Privatsphäre zu entwickeln. Tor stellt die Grundlagen für eine Reihe von Anwendungen zur Verfügung, welche Organisationen und Privatpersonen ermöglichen, ihre Informationen über öffentliche Netzwerke zu tauschen, ohne den Schutz der Privatsphäre aufgeben zu müssen.

Man sollte sich jedoch dessen bewusst sein, dass die Durchsatzgeschwindigkeiten negativ beeinflusst werden.

Installation von Tor:

~~~
apt-get update
apt-get install tor
~~~

Die ausgelieferte Konfigurationsdatei torrc sollte für die meisten Nutzer ohne weitere Änderungen ausreichend sein. Um Tor im Internet zu nutzen, muss Privoxy konfiguriert werden: [Tor und Internet](https://www.torproject.org/docs/tor-doc-unix#privoxy)  (English).

<!-- Für den Iceweasel Internetbrowser gibt es [Torbutton](https://addons.mozilla.org/en-US/firefox/addon/2275)  als Add-On.

[Die Tor-Dokumentation](https://www.torproject.org/documentation.html.en)  bietet umfassende Informationen über jeden Aspekt von Tor (Englisch).

Vidalia ist ein graphisches Kontroll-Programm für die Tor-Software und ermöglicht den Start und das Beenden von Tor, gibt einen Überblick über den Status von Tor und beobachtet die benutzte Bandbreite:

~~~
apt-get update
apt-get install vidalia
~~~

[Homepage von Vidalia](https://www.torproject.org/projects/vidalia.html.en)  

<div id="rev">Page last revised 17/01/2012 1545 UTC</div>
