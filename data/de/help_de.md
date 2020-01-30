<div class="divider" id="help-gen"></div>

## Wo man Hilfe bekommen kann

Schnelle Hilfe kann einem viele Tränen ersparen und bietet die Möglichkeit, das weiter zu machen, was wirklich wichtig ist im Leben. Dieses Thema ist nach Bereichen gegliedert, wo die Distribution siduction Hilfe anbietet:

+ [Foren und Wiki](help-de.htm#for-wiki) 

+ [IRC](help-de.htm#irc) 

+ [Nützliche Helfer im Textmodus (tty) und init 3](help-de.htm#init3-tools)  

+ [IRC im Textmodus bzw. in init 3](help-de.htm#irc-init3)  

+ [Internetaufruf im Textmodus bzw. in init 3](help-de.htm#init3-web)  

+ [inxi](help-de.htm#inxi) 

<div class="divider" id="for-wiki"></div>

## Das siduction-Forum

Das siduction-Forum bietet die Möglichkeit Fragen zu stellen und Antworten auf diese zu erhalten. Bevor ein neuer Beitrag erstellt wird, sollte die Forensuche benutzt werden, da die Wahrscheinlichkeit groß ist, dass diese oder eine ähnliche Frage schon einmal gestellt wurde. [Das Forum](http://siduction.org/module-PNphpBB2-main-newlang-deu.html)  ist auf Deutsch und Englisch verfügbar.

## Das siduction-Wiki

Das siduction-Wiki ist von allen siduction-Nutzern frei nutz- und veränderbar. Wir hoffen so, dass die siduction-Dokumentation im Laufe der Zeit mit dem Projekt wachsen wird.

Wir hoffen auf Beiträge von Linuxnutzern aller Erfahrungsebenen, da dieses Wiki beabsichtigt, Nutzern jeden Kenntnisstandes zu helfen. Die wenigen Minuten, die dem Wiki und Projekt "geopfert" werden, können anderen Nutzern (und vielleicht einem selbst) Stunden des Suchens nach Problemlösungen ersparen. [Link zum siduction-Wiki](http://wiki.siduction.de/index.php?title=Hauptseite) .

<div class="divider" id="irc"></div>

## IRC - interaktiver Livesupport 

#### Verhaltensregel im IRC

 **`Der IRC soll nie als "root" betreten werden, sondern nur als normaler Nutzer. Bei Unklarheiten bitte dies sofort im IRC-Channel bekannt geben, damit Hilfe gegeben werden kann.`**
### #siduction erreichen

<!--Es gibt 2 Methoden #siduction zu erreichen:  
-->  Indem man das `"IRC Chat #siduction"-Symbol`  auf dem Desktop anklickt oder einen anderen Chat-Client verwendet  
<!-- 2) Indem man auf `Meet the Team`  im Menü der [siduction-Homepage](http://siduction.org)  klickt

### Konversation

Am einfachsten ist es, das `siduction-IRC-Symbol`  auf dem Desktop anzuklicken oder den kmenu-Eintrag von koversation zu verwenden.

Wenn man einen anderen Chat-Client bevorzugt, muss man diese Serverdaten eingeben:

~~~
irc.oftc.net
port 6667
~~~

### IRC-Client auf der siduction-Homepage starten

Auf der [siduction-Homepage](http://siduction.org)  einfach `Meet the Team`  in der Menüliste klicken. Man erhält zwei Optionen für einen Web-basierten Chat: CGI oder Java.

Das gewünschte Pseudonym (Nickname) und #siduction wird in die entsprechenden Felder eingetragen, und im Anschluss klickt man auf "login".

<div class="divider" id="paste"></div>

### siduction-paste

siduction-paste ermöglicht das Einfügen von Dateien aus dem Terminal oder TTY. Die ist ideal, wenn man sich mit Problemen in Runlevel 3 (ohne Grafikserver) befindet. siduction-paste nutzt http://paste.siduction.org als Link, und die Ausgabe ist 24 Stunden lang verfügbar.

Man kann sowohl als user wie auch als root siduction-paste verwenden, einige Anfragen jedoch benötigen root-Zugang.

~~~
siduction-paste command|file
oder
command | siduction-paste
~~~

#### Beispiel für siduction-paste &lt;file&gt;

~~~
siduction-paste /etc/fstab
Your paste can be seen here: http://paste.siduction.org/xyz.html
~~~

Der Link `http://paste.siduction.org/xyz.html`  muss danach im IRC-Channel #siduction eingegeben werden.

#### Beispiel für command | siduction-paste 

~~~
fdisk -l | siduction-paste
Your paste can be seen here:http://siduction.paste.org/yzx.html
~~~

Man kann per siduction-paste auch screenshots machen und gleichzeitig hochladen

~~~
siduction-paste -s
~~~

Jetzt bleiben einige Sekunden Zeit, um zum abzulichtenden Objekt zu navigieren. Bitte denkt daran, dass diese Funktion die Installation von  *scrot*  voraussetzt

Der Link `http://siduction.paste.org/yzx.html`  muss danach im IRC-Channel #siduction eingegeben werden.

<div class="divider" id="init3-tools"></div>

## Nützliche Helfer im Textmodus (tty) und in init 3 

Normalerweise verwendet man den Textmodus (Runlevel 3, init 3), wenn man ein dist-upgrade durchführen möchte, oder gezwungenermaßen, wenn das System einen schwerwiegenden Fehler aufweist.

### gpm

Ein hilfreiches Programm im Textmodus ist `gpm` . Dieses ermöglicht, die Maus zum Kopieren und Einfügen im Terminal zu benutzen.

`gpm`  ist in siduction vorkonfiguriert. Falls dem nicht so ist:

~~~
gpm -t imps2 -m /dev/input/mice
~~~

Danach sollte man prüfen, dass /etc/gpm.conf angelegt wurde

~~~
/etc/init.d/gpm restart
~~~

Nun sollte man seine Maus im Textmodus (tty) nutzen können.

### Dateimanager und Textbearbeitung

Midnight Commander ist ein einfach zu bedienender Dateimanager im Text-Modus (tty) und Texteditor. Er wird mit siduction ausgeliefert.

Abgesehen von den normalen Tastatureingaben kann aufgrund von gpm auch die Maus benutzt werden.

`mc`  zeigt das Dateisystem und mit `mcedit`  kann eine vorhandene Datei bearbeitet bzw. eine neue Datei erstellt werden.

So öffnet man eine vorhandene Datei:

~~~
mcedit /etc/apt/sources.list.d/debian.list
~~~

Nun kann die Datei bearbeitet und gespeichert werden. Die Änderungen werden sofort wirksam.

Weitere Informationen:

~~~
man mc
~~~

<div class="divider" id="irc-init3"></div>

### Wie man den IRC-Support #siduction im Textmodus (init 3) erreicht

#### Verhaltensregel im IRC

 **`Der IRC soll nie als "root" betreten werden, sondern nur als normaler Nutzer. Bei Unklarheiten bitte dies sofort im IRC-Channel bekannt geben, damit Hilfe gegeben werden kann.`**
### IRC im Textmodus bzw. Runlevel 3

In siduction ist irssi aktiviert.

Im Runlevel 3 kann so in einen anderen Terminal/TTY gewechselt werden:

~~~
# CTRL-ALT-F2
$ siductionbox login: <username2 <password2 (nicht als root)
danach gibt man ein:
$ siduction-irc (dies startet irssi)
~~~

Anleitung, falls ein anderer Client (im Beispiel weechat) installiert ist:

Zuerst stellt man sicher, dass WeeChat installiert ist, indem man unter Kmenu > Debian > Net den Eintrag von weechat sucht. Falls dieser nicht vorhanden sein sollte:

~~~
#apt-get install weechat-curses
~~~

Im Runlevel 3 kann man das Terminal mit folgendem Befehl wechseln:

~~~
# CTRL-ALT-F2
$ siductionbox login: <username2 <password2 (nicht root!)
danach eingeben
$ weechat-curses
~~~

Jetzt kann man sich mit irc.oftc.net auf Port 6667 verbinden. Nach erfolgter Verbindung wird das Pseudonym (der "Nickname") geändert:

~~~
/nick username_of_choice
~~~

Den siduction-Channel betritt man mit folgender Eingabe:

~~~
/join #siduction
~~~

Falls man wünscht, den Server zu wechseln, gibt man einen Befehl mit folgender Syntax ein:

~~~
/server server.name
~~~

In der unteren Menüzeile sieht man Zahlen, falls die Channel aktiv sind, und um sich mit einem Channel zu verbinden, verwendet man ALT-1, ALT-2, ALT-3, ALT-4 usw.

Einen Channel verlässt man mit

~~~
/exit
~~~

Falls gleichzeitig ein dist-upgrade durchgeführt wird, kann man folgendermaßen das Terminal wechseln, um den Fortschritt des Upgrades zu verfolgen:

~~~
CTRL-ALT-F1
## und zum IRC kommt man zurück mit
CTRL-ALT-F2
~~~

[Dokumentationsseite von irssi (Englisch)](http://irssi.org/documentation)  
[Dokumentationsseite von WeeChat (Deutsch)](http://www.weechat.org/) 

<div class="divider" id="init3-web"></div>

### Surfen im Internet im Textmodus (Runlevel 3)

Der Kommandozeilenbrowser w3m ermöglicht das Surfen im Internet in einem Terminal bzw. einer Konsole oder im Textmodus

Falls w3m oder elinks nicht installiert sind, geht man so vor:

~~~
apt-get update
apt-get install w3m
~~~

Um zum Beispiel auf w3m zuzugreifen, öffnet man ein(e) Terminal/Konsole:

~~~
$w3m URL
oder
w3m ?
oder
w3m siduction.org
~~~

Beispiel: http://siduction.org ruft man so auf (http:// wird weggelassen):

~~~
$ w3m siduction.org
~~~

Im Textmodus (Runlevel 3) geht man so vor:

~~~
# CTRL-ALT-F2
$ siductionbox login: <username2 <password2 (nicht root!)
danach gibt man ein:
$ w3m siduction.org
~~~

Eine neue URL wird mit Hilfe der Tastenkombination Shift+U aufgerufen:

~~~
SHIFT+U
~~~

Danach sieht man eine Zeile wie "Goto URL: http://siduction.org". Mit der Rücktaste löscht man die zuletzt gewählte URL und gibt die gewünschte ein.

Mehr Informationen gibt es auf der [Dokumentationsseite von w3m (Englisch)](http://w3m.sourceforge.net/) 

####  `Es ist ratsam, sich vor einem Notfall mit elinks/w3m, irssi/weechat und midnight commander vertraut zu machen. Drucke diese Datei aus, um im Notfall diese Informationen griffbereit zu haben.` 

<div class="divider" id="inxi"></div>

## inxi

Inxi ist ein System-Informations-Skript, welches unabhängig von einzelnen IRC-Clients funktioniert. Dieses Skript gibt verschiedene Informationen über die benutzte Hard- und Software aus, sodass andere Nutzer in #siduction bei der Fehlerdiagnose besser helfen können. Oder in einer Konsole ausgeführt, kann man selbst Informationen über das eigene System erhalten.

Um inxi in Konversation zu nutzen, gibt man in die Chatbox dies ein:

~~~
/cmd inxi -v2
~~~

Um inxi in weechat zu nutzen, gibt man in die Chatbox dies ein:

~~~
/shell -o inxi -v2
~~~

Vorausgesetzt, dass man die Erweiterung "shell" installiert hat.

Siehe dazu: [http://www.weechat.org/scripts/](http://www.weechat.org/scripts/) 

Um inxi in anderen Klienten zu nutzen, gibt man in die Chatbox dies ein:

~~~
/exec -o inxi -v2
oder
/inxi -v2
~~~

In einer Konsole wird folgender Befehl eingegeben:

~~~
inxi -v2
~~~

Hilfe zu inxi

~~~
inxi --help
~~~

<div class="divider" id="links"></div>

## Nützliche Links

#### Allgemeine Dokumentationen zu Linux

[LibreOffice](http://de.libreoffice.org/)  (Dokumentation ist teilweise auf Deutsch verfügbar  
[OpenOffice-Dokumentation auf Deutsch](http://de.openoffice.org/doc/)  (Vieles gilt auch für LibreOffice)  
[Debian Referenzkarte - zum Ausdruck auf ein Einzelblatt](http://www.debian.org/doc/user-manuals#refcard)  
[HOWTOs von der Debian-Seite](http://www.debian.org/doc/#howtos)  (ist automatisch auf Deutsch, wenn Browser lokalisiert ist)  
[Debian-Referenz: Grundlagen und Systemadministration](http://qref.sourceforge.net/index.de.php)  (Dokumente verfügbar als HTML, Text, PDF und PS  
[Linux Basics (EN)](http://linuxbasics.org/)  
[Common Unix Printing System CUPS (EN)](http://www.cups.org/) . Weiters bietet das KDE-Hilfezentrum Hilfe zu CUPS.

<div id="rev">Content last revised 11/17/2014 1838 UTC </div>
