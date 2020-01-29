<div class="divider" id="term-kon"></div>

## Definition von Terminal bzw. Konsole

Ein Terminal, auch Konsole genannt, ist ein Programm, das es einem ermöglicht, durch direkt ausgeführte Befehle unmittelbar mit dem GNU/Linux Betriebssystem zu interagieren. Das Terminal, auch häufig die `Shell`  oder `Kommandozeile`  genannt, ist ein äußerst mächtiges Werkzeug und den Aufwand, die Grundlagen seiner Handhabung zu lernen wert.

In siduction kann man das Terminal/die Konsole aufrufen, indem man das PC-Monitorsymbol rechts des K-Menüs anklickt oder in K-Menü > System > Terminal aufruft, oder, noch einfacher, in die Suchleiste des K-Menü  *kons*  eintippt. 

Nach dem Aufrufen des Terminals sieht man die Eingabeaufforderung "prompt":

~~~
username@hostname:~$
~~~

"username" in obigem Beispiel entspricht dem Nutzernamen des angemeldeten Benutzers. Die `Tilde ~`  zeigt, man befindet sich in seinem Heimverzeichnis `/home/username` , und das Dollarzeichen `$`  bedeutet, dass man im Terminal mit eingeschränkten Benutzerrechten angemeldet ist. Am Ende blinkt der Cursor. Dies alles ist die Kommandozeile. Hier werden Befehle eingegeben, die das Terminal ausführen soll.

Viele Befehle kann man nur mit Root-Rechten, also Administratorrechten, ausführen. Root-Rechte erhält man, indem man `suxterm`  eingibt und Enter drückt, Hiernach muss man das Rootpasswort eingeben. Das Passwort wird während der Eingabe auf dem Bildschirm nicht angezeigt.

Ist die Eingabe korrekt, zeigt die Kommandozeile nun:

~~~
root@hostname:/home/username#
~~~

:::warning
**Achtung:**  
Während man mit Root-Rechten eingeloggt ist, darf man alles, z. B. Dateien löschen, ohne die das Betriebssystem nicht mehr funktioniert, uvm. Wenn man mit Root-Rechten arbeitet, muss man sich darüber im Klaren sein, **was** man gerade macht, denn es ist leicht möglich, dem Betriebssystem irreparable Schäden zuzufügen.
:::

Zu beachten ist, dass das Dollarzeichen `$` durch eine Raute `#`  ersetzt wurde. In einem Terminal/einer Konsole bedeutet die Raute `#`  immer, dass man mit Root-Rechten angemeldet ist.  
`Wenn im Handbuch Kommandozeilenbefehle angegeben werden, werden die Angaben vor dem Prompt ($ oder #) ausgelassen. Ein Befehl wie:` 

~~~
# apt-get install [Paketname]
~~~

bedeutet also: man öffnet ein Terminal, meldet sich als root an (suxterm) und führt dann den Befehl an einem Rootprompt # aus. `Die Raute # wird nicht mit eingegeben`.

Manchmal kann eine Konsole bzw. ein Terminal nicht mehr so reagieren wie gewünscht, dann muss eingegeben werden:

~~~
reset
~~~

und die Eingabetaste (Enter) gedrückt werden.

Wenn die Ausgabe einer Konsole bzw. eines Terminals verzerrt erscheint, kann dies meist durch das Drücken von `ctrl+l`  behoben werden, was das Terminal-Fenster neu aufbaut. Solche Verzerrungen treten meist auf, wenn man mit Programmen arbeitet, welche eine ncurses-Schnittstelle benutzen, zum Beispiel irssi.

Eine Konsole bzw. ein Terminal können eingefroren erscheinen, was aber in der Regel nicht der Fall ist, sondern die Eingaben werden weiterhin verarbeitet, auch wenn es nicht so scheint. Dies kann durch versehentliches Drücken von `ctrl+s`  verursacht sein. In diesem Fall kann `ctrl+q`  versucht werden, um die Konsole wieder frei zu geben.

<div class="divider" id="colours"></div>

### Farbiges Terminal

#### Prompts für `user:~ $`  und **`root:` `#`**

Farbige Prompts am Terminal können einen vor unangenehmen oder katastrophalen Fehlern bewahren, falls man als **`root #`**  eine Aufgabe durchführt, die man als `user~$` machen wollte. Sie können auch eingesetzt werden, um als Lesezeichen für alle 100 Zeilen zu fungieren.

In den Grundeinstellungen besitzen die Prompts für user~$ und root# den gleichen Farbton, aber es ist einfach die Farben zu ändern.

Die Grundfarben sind:

~~~
(die Syntax ist 00;XX)
[00;30] Schwarz
[00;31] Rot
[00;32] Grün
[00;33] Gelb
[00;34] Blau
[00;35] Magenta
[00;36] Cyan
[00;37] Weiß
[Man ersetzt [00;XX] mit [01;XX] um eine Farbvariation zu erhalten].
~~~

#### Änderung der Farbe für den Prompt des User ~$:

Als $user mit einem Texteditor:

~~~
$ <editor2 ~/.bashrc
~~~

In der Zeile 39 wird das Kommentarzeichen entfernt und sie sieht so aus:

~~~
force_color_prompt=yes
~~~

In der Zeile 53 wird dort, wo zum Beispiel 01;32m steht auf den gewünschten Farbwert gesetzt.

Im Beispiel wird der farbige Prompt für user~:$ auf `Cyan` [01;36m\] gesetzt. Dies muss an drei Stellen mit dieser Syntax erfolgen:

~~~
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[01;36m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
~~~

Die neue Farbe existiert nach Öffnen eines neuen Terminals.

#### Änderung der Farbe für den Prompt von root#:

~~~
suxterm
<editor2 /root/.bashrc
~~~

In der Zeile 39 wird das Kommentarzeichen entfernt und sie sieht so aus:

~~~
force_color_prompt=yes
~~~

In der Zeile 53 wird dort, wo zum Beispiel 01;32m steht auf den gewünschten Farbwert gesetzt.

Im Beispiel wird der farbige Prompt für root:# auf **`Rot`**  [01;31m\] gesetzt. Dies muss an drei Stellen mit dieser Syntax erfolgen:

~~~
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[01;31m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '
~~~

Die neue Farbe existiert nach Öffnen eines neuen Terminals.

#### Hintergrundfarben des Terminals


Um die Hintergrundfarbe und die Fonts in einem Terminal zu ändern, finden sich die Optionen im Menü des Terminal.

![Terminal colours](../images-common/images-terminal/terminal-colour-0.1.png "Terminal colours") 

Es gibt eine Unmenge an Einstellungsmöglichkeiten für Hintergrundfarben. Wir empfehlen eine eher schlichte Einstellung.

<div class="divider" id="suxterm"></div>

## Über suxterm

Eine Anzahl von Befehlen muss mit Root-Rechten gestartet werden. Diese erhält man durch Eingabe von:

~~~
suxterm
~~~

Im Gegensatz zum allgemeinen Befehl 'su' erlaubt `suxterm`  das Ausführen von Programmen mit graphischer Oberfläche mit Root-Rechten. `suxterm`  transferiert unter Benutzung von 'su' die X-Eigenschaften an den Zielnutzer. (Siehe auch [sudo](#sudo)).

Beispiele für die Verwendung graphischer Anwendungen mittels suxterm sind: die Bearbeitung einer Konfigurationsdatei mit kwrite oder kate, der Einsatz des Partitionierungsmanagers gparted oder die Verwendung von Dateimanagern wie dolphin oder thunar. 

#### KDE: Tastatur-Optionen

Start von krunner in KDE:

~~~
Alt+F2
~~~

oder Rechts-Klick auf dem Desktop und Auswahl von:

~~~
Befehl ausführen
~~~

danach:

~~~
kdesu <Application2
~~~

#### Xfce: Tastatur-Optionen

Start des Run-Befehls in Xfce:

~~~
Alt+F2
~~~

oder Rechts-Klick auf dem Desktop und Auswahl von:

~~~
Befehl ausführen
~~~

danach:

~~~
gksu <Application2
~~~

#### Optionen für weitere Desktopumgebungen


Eine andere Tastatur-Option für alle Desktopumgebungen ist:

~~~
Alt+F2
~~~

danach:

~~~
su-to-root -X -c <Anwendung2
~~~

`Alle Tastatur-Optionen können in einem Terminal eingegeben werden.` 

<div class="divider" id="sudo"></div>

## sudo ist nicht standardmäßig konfiguriert

sudo ist nicht aktiviert nach einer Installation, sondern steht nur im Live-Modus zur Verfügung, da kein Root-Passwort gesetzt ist. Der Grund ist: falls ein Angreifer das Nutzer-Passwort abgreift, hat er nicht Super-User-Rechte und kann keine schädlichen Veränderungen am System durchführen.

Ein anderes Problem mit sudo ist, dass eine Root-Anwendung, die mit der Nutzerkonfiguration läuft, Berechtigungen ändern und somit für den Nutzer unbrauchbar machen kann. Die Verwendung von `[suxterm](#suxterm) , kdesu, gksu oder su-to-root -X -c`  wird empfohlen!

## Arbeit als root

::: warning
**Achtung:**  
Während man mit Root-Rechten im Terminal eingeloggt ist, darf man alles, z. B. Dateien löschen, ohne die das Betriebssystem nicht mehr funktioniert, uvm. Wenn man mit Root-Rechten arbeitet, muss man sich darüber im Klaren sein,  **was**  man gerade macht, denn es ist leicht möglich, dem Betriebssystem irreparable Schäden zuzufügen.
:::

**`Unter keinen Umständen sollten Produktivprogramme, die normalerweise mit Benutzerrechten gestartet werden, mit dieser Option als root hochgefahren werden: Internet-Browser, E-Mail-Programme, Büroprogramme u.a.`**

<div class="divider" id="cli-help"></div>

## Hilfe in der Kommandozeile

Die meisten Befehle/Programme haben eine Kommandozeilenhilfe und auch Anleitungen. Die Anleitungen werden "man page" oder "manual page" genannt. Die Syntax zum Aufrufen der "man page" ist:

~~~
$ man Befehl
~~~

oder

~~~
$ man -k <keyword2
~~~

Dies ruft die "man page" eines Befehls auf. Die Navigation in den "man pages" erfolgt durch die Pfeiltasten, beendet werden sie mit "q" für quit. Beispiel:

~~~
$ man apt-get
~~~

Um eine manpage zu verlassen, tippt man `q` 

Ein anderes nützliches Werkzeug ist der "apropos"-Befehl. "Apropos" ermöglicht es, die man pages nach einem Befehl zu durchsuchen, wenn man z. B. die Syntax vergessen hat. Beispiel:

~~~
$ apropos apt-
~~~

Dies listet alle Befehle für den Paketmanager apt auf. "apropos" ist ein mächtiges Werkzeug, für eingehendere Informationen über "apropos" siehe

~~~
$ man apropos
~~~

<div class="divider" id="term-cmds"></div>

## Linux Konsolenbefehle

Eine sehr gute Einführung in die Konsole BASH findet sich auf [linuxcommand.org](http://linuxcommand.org/) .

 `Eine umfangreiche Liste von 687 Befehlen in alphabetischer Reihenfolge aus  *Linux in a Nutshell, 5th Edition, O'Reilly Publications*  gibt es [hier](http://www.linuxdevcenter.com/linux/cmd/#a) . Sie sollte in keiner Bookmarksammlung fehlen!`
Eine weitere der vielen guten Anleitungen ist [ *A Beginners' Bash* ](http://linux.org.mt/article/terminal)  (auf Englisch).

Natürlich kann auch die favorisierte Suchmaschine verwendet werden, um mehr zu finden.

<div class="divider" id="shell-scripts"></div>

## Skripte und wie man sie nutzt

Ein Konsolen-Skript ist ein bequemer Weg, um mehrere Befehle in einer Datei zu bündeln. Die Eingabe des Dateinamen des Skripts führt die Befehle, die im Skript sind, aus. siduction wird mit einigen sehr nützlichen Skripten ausgeliefert, welche Vereinfachungen der Systemadministration bieten.

Ein Skript wird in der Konsole folgendermaßen gestartet, wenn man sich im gleichen Verzeichnis befindet:

~~~
./name_des_skripts
~~~

 `Einige Skripte benötigen root-Zugang (suxterm), abhängig vom Aufgabenbereich des Skripts.`
#### Installation und Ausführung von Skripten

Mit wget kann ein Skript auf den Rechner geladen werden, und man platziert es am besten in das empfohlene Verzeichnis, `zum Beispiel nach /usr/local/bin` . Zum Kopieren und Einfügen in der Konsole kann auch die Maus benutzt werden, nachdem man mit `suxterm`  Root-Rechte erlangt hat.

#### Hier ein Beispiel, wie man wget mit `root-Rechten (suxterm)`  ausführt:

~~~
suxterm
cd /usr/local/bin
wget script-name
~~~

Danach muss die Datei ausführbar gemacht werden:

~~~
chmod +x script-name
~~~

Die Datei kann auch mit einem Browser auf den Computer geladen und an den geeigneten Ort platziert werden, aber sie muss auch dann ausführbar gemacht werden.

<!-- #### Beispiel, wie man wget als Nutzer verwendet

So speichert man als Nutzer eine Datei `im $HOME (der Promt ist '$')` :

~~~
$ wget http://manual.siduction.org/shell-script-test/test-script.sh
~~~

~~~
$ chmod +x test-script.sh
~~~

Um das Skript auszuführen, wird eine Konsole geöffnet und das Skript so gestartet:

~~~
$ ./test-script.sh
~~~

Folgende Antwort sollte bei diesem Test-Skript zu sehen sein:

~~~
Congratulations user
You successfully downloaded and executed a bash script!
Welcome to siduction-manuals http://manual.siduction.org
~~~

<div id="rev">Page last revised 26/11/2014 2000 UTC</div>
