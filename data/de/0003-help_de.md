% Die siduction Hilfe

## siduction Hilfe

Schnelle Hilfe kann einem viele Tränen ersparen und bietet die Möglichkeit, das weiter zu machen, was wirklich wichtig ist im Leben. Dieses Thema ist nach Bereichen gegliedert, wo die Distribution siduction Hilfe anbietet:

### Das siduction-Forum

Das siduction-Forum bietet die Möglichkeit Fragen zu stellen und Antworten auf diese zu erhalten. Bevor ein neuer Beitrag erstellt wird, sollte die Forensuche benutzt werden, da die Wahrscheinlichkeit groß ist, dass diese oder eine ähnliche Frage schon einmal gestellt wurde. [Das Forum](https://forum.siduction.org/index.php?name=PNphpBB2)  ist auf Deutsch und Englisch verfügbar.

### Das siduction-Wiki

Das siduction-Wiki ist von allen siduction-Nutzern frei nutz- und veränderbar. Wir hoffen so, dass die siduction-Dokumentation im Laufe der Zeit mit dem Projekt wachsen wird.

Wir hoffen auf Beiträge von Linuxnutzern aller Erfahrungsebenen, da dieses Wiki beabsichtigt, Nutzern jeden Kenntnisstandes zu helfen. Die wenigen Minuten, die dem Wiki und Projekt "geopfert" werden, können anderen Nutzern (und vielleicht einem selbst) Stunden des Suchens nach Problemlösungen ersparen. [Link zum siduction-Wiki](https://forum.siduction.org/index.php?board=66.0) .

### IRC - interaktiver Livesupport 

**Der IRC soll nie als "root" betreten werden, sondern nur als normaler Nutzer.**  
Bei Unklarheiten bitte dies sofort im IRC-Channel bekannt geben, damit Hilfe gegeben werden kann.

**Verhaltensregeln im IRC**

* Ein freundlicher Umgangston ist obligatorisch, denn wir leisten den Support alle ehrenamtlich.
* Hilfreich ist es, eine nach bestem Wissen genaue Anfrage zu stellen und nach Möglichkeit zuvor im siduction-Wiki nach Lösungen zu suchen.
* Bitte niemals gleichzeitig im IRC und Forum eine Anfrage stellen. Bestenfalls reiben wir uns verwundert die Augen.

**siduction erreichen**

+ Klicke einfach auf das **"IRC Chat #siduction"-Symbol**  auf dem Desktop oder verwende den kmenu-Eintrag von koversation.  
Wenn du einen anderen Chat-Client bevorzugst, musst du diese Serverdaten eingeben:

  ~~~
  irc.oftc.net
  port 6667
  ~~~

+ [Mit diesem Link kannst Du den IRC sofort in Deinem Browser aufrufen](https://webchat.oftc.net/?nick=siducer007&channels=siduction-de) : gib dazu einen frei gewählten Nicknamen ein und betritt den Channel #siduction-de.

### Nützliche Helfer im Textmodus

Normalerweise verwendet man den Textmodus Runlevel 3 (init 3 bzw. journalctl isolate multi-user.target), wenn man ein dist-upgrade durchführen möchte, oder gezwungenermaßen, wenn das System einen schwerwiegenden Fehler aufweist.

**gpm**

 ist ein hilfreiches Programm im Textmodus. Dieses ermöglicht, die Maus zum Kopieren und Einfügen im Terminal zu benutzen.

*gpm* ist in siduction vorkonfiguriert. Falls dem nicht so ist:

~~~
$ gpm -t imps2 -m /dev/input/mice
~~~

Danach sollte man prüfen ob der Service aktiv ist:

~~~
$ systemctl status gpm.service
~~~

Bei Erfolg findet sich in der Ausgabe auch eine Zeile ähnlich der folgenden.

~~~
  Active: active (running) since Thu 2020-04-09 12:17:14 CEST; 5min ago
~~~

Nun sollte man seine Maus im Textmodus (tty) nutzen können.

**Dateimanager und Textbearbeitung**

Midnight Commander ist ein einfach zu bedienender Dateimanager im Text-Modus (tty) und Texteditor. Er wird mit siduction ausgeliefert.

Abgesehen von den normalen Tastatureingaben kann aufgrund von gpm auch die Maus benutzt werden.

**mc** zeigt das Dateisystem und mit **mcedit** kann eine vorhandene Datei bearbeitet bzw. eine neue Datei erstellt werden.

So öffnet man eine vorhandene Datei (zuerst wird eine Sicherungskopie angelegt):

~~~
$ cp /etc/apt/sources.list.d/debian.list /etc/apt/sources.list.d/debian.list_$(date +%F)

  anschließend

$ mcedit /etc/apt/sources.list.d/debian.list
~~~

Nun kann die Datei bearbeitet und gespeichert werden. Die Änderungen werden sofort wirksam.

Weitere Informationen auf der Manpage:

~~~
$ man mc
~~~

### siduction IRC-Support im Textmodus

**Verhaltensregel im IRC**

 **Der IRC soll nie als "root" betreten werden, sondern nur als normaler Nutzer.**  
 Bei Unklarheiten bitte dies sofort im IRC-Channel bekannt geben, damit Hilfe gegeben werden kann.

**IRC im Textmodus**

Das Programm *irssi* stellt einen IRC-Client im Textmodus oder der Konsole bereit und ist in siduction aktiviert.  
Mit der Tastenkombination `ALT`+`F2` oder `F3` usw. kann man von einem Terminal/TTY in ein anderes wechseln und sich dort mit seinem Useraccount anmelden:

~~~
$ siductionbox login: <username> <password> (nicht als root)
~~~

danach gibt man

~~~
$ siduction-irc
~~~

ein, um *irssi* zu starten.

Anleitung, falls ein anderer Client (im Beispiel weechat) gewünscht ist:  
Zuerst stellt man sicher, dass WeeChat installiert ist, indem man im Menü den Eintrag von weechat sucht. Falls dieser nicht vorhanden sein sollte:

~~~
# apt update
# apt install weechat-curses

  und anschließend das Programm starten

$ weechat-curses
~~~

Jetzt kann man sich mit irc.oftc.net auf Port 6667 verbinden. Nach erfolgter Verbindung wird das Pseudonym (der "Nickname") geändert:

**/nick 'Dein_neuer_nick'**

Den siduction-Channel betritt man mit folgender Eingabe:

**/join #siduction-de**

Falls man wünscht, den Server zu wechseln, gibt man einen Befehl mit folgender Syntax ein:

**/server server.name**

In der unteren Menüzeile sieht man Zahlen, falls die Channel aktiv sind, und um sich mit einem Channel zu verbinden, verwendet man ALT-1, ALT-2, ALT-3, ALT-4 usw.

Einen Channel verlässt man mit

**/exit**

Falls gleichzeitig ein dist-upgrade durchgeführt wird, kann man folgendermaßen das Terminal wechseln, um den Fortschritt des Upgrades zu verfolgen:

Tastenkombination `ALT`+`F3`  
und zum IRC kommt man zurück mit der  
Tastenkombination `ALT`+`F2`

Die folgenden Link bieten weitere Informationen.  
[Dokumentationsseite von irssi (Englisch)](https://irssi.org/documentation)  
[Dokumentationsseite von WeeChat (Deutsch)](https://www.weechat.org/) 

### Surfen im Internet im Textmodus

Der Kommandozeilenbrowser w3m ermöglicht das Surfen im Internet in einem Terminal bzw. einer Konsole oder im Textmodus

Falls w3m oder elinks nicht installiert sind, geht man so vor:

~~~
# apt update
# apt install w3m
# apt install elinks
~~~

Nun kann man den Kommandozeilenbrowser w3m benutzen. Dazu ist es sinnvoll in ein anderes Terminal zu wechseln und sich mit seinem Useraccount anzumelden:

Tastenkombination `ALT`+`F2`

~~~
$ siductionbox login: <username> <password> (nicht root!)
~~~

Der Programmaufruf lautet "w3m URL" oder "w3m ?".  
Beispiel: https://siduction.org ruft man so auf (https:// wird weggelassen):

~~~
$ w3m siduction.org
~~~

Eine neue URL wird mit Hilfe der Tastenkombination Shift+U aufgerufen:

`SHIFT`+`U`

Danach sieht man eine Zeile wie "Goto URL: https://siduction.org". Mit der Rücktaste löscht man die zuletzt gewählte URL und gibt die gewünschte ein.  
Beendet wird w3m mit:

`SHIFT`+`Q`

Mehr Informationen gibt es auf der [Dokumentationsseite von w3m (Englisch)](http://w3m.sourceforge.net/) 

Es ist ratsam, sich vor einem Notfall mit **elinks/w3m, irssi/weechat, midnight commander** vertraut zu machen. Drucke diese Datei aus, um im Notfall die Informationen griffbereit zu haben.

### inxi

Inxi ist ein System-Informations-Skript, welches unabhängig von einzelnen IRC-Clients funktioniert. Dieses Skript gibt verschiedene Informationen über die benutzte Hard- und Software aus, sodass andere Nutzer in #siduction bei der Fehlerdiagnose besser helfen können. Oder in einer Konsole ausgeführt, kann man selbst Informationen über das eigene System erhalten.

Um inxi in Konversation zu nutzen, gibt man in die Chatbox dies ein:

**/cmd inxi -v2**

Um inxi in weechat zu nutzen, gibt man in die Chatbox dies ein:

**/shell -o inxi -v2**

Vorausgesetzt, dass man die Erweiterung "shell" installiert hat.

Siehe dazu: [https://www.weechat.org/scripts/](https://www.weechat.org/scripts/) 

Um inxi in anderen Klienten zu nutzen, gibt man in die Chatbox dies ein:

**/exec -o inxi -v2**  
oder  
**/inxi -v2**

In einer Konsole wird folgender Befehl eingegeben:

~~~
$ inxi -v2
~~~

Hilfe zu inxi

~~~
$ inxi --help
~~~

### Nützliche Links

[Debian Referenzkarte - zum Ausdruck auf ein Einzelblatt](https://www.debian.org/doc/user-manuals#refcard)  
[HOWTOs von der Debian-Seite](https://www.debian.org/doc/#howtos)  (ist automatisch auf Deutsch, wenn Browser lokalisiert ist)  
[Debian-Referenz: Grundlagen und Systemadministration](http://qref.sourceforge.net/index.de.php) Dokumente verfügbar als HTML, Text, PDF und PS  
[Common Unix Printing System CUPS (EN)](https://www.cups.org/) . In KDE bietet das KDE-Hilfezentrum Informationen zu CUPS.  
[LibreOffice](https://de.libreoffice.org/) Im Menü "Hilfe" finden sich viele Angebote.

<div id="rev">Zuletzt bearbeitet: 2022-01-13</div>
