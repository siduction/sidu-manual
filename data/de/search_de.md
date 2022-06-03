<div class="divider" id="search-on"></div>

## Online-Suche

### Option 1

Nach Eingabe eines oder mehrerer Begriffe klickt man auf `Suche`  oder drückt die Eingabetaste "Enter".

---

<form method="get" action="/cgi-bin/perlfect/search-de/search.pl">
  <input type="hidden" name="p" value="1" /> <input type="hidden" name="lang" value="de" /> <input type="hidden" name="include" value="" /> <input type="hidden" name="exclude" value="" /> <input type="hidden" name="penalty" value="0" /> <select name="mode"> <option value="all">Nach ALLEN Wörtern suchen</option> <option value="any">Nach JEDEM Wort suchen</option> </select> <input type="text" name="q" /><input type="submit" value="Suche" /> 

</form>

---

#### Suchoptionen

`Nach ALLEN Wörtern suchen`  ist die Standardoption. Man erhält eine Liste von Handbuchdateien, welche alle gesuchten Begriffe enthalten. `Nach JEDEM Wort suchen`  gibt eine Liste von Handbuchdateien aus, die zumindest einen der Suchbegriffe enthalten.

Komplexe Suche:  
Ein `Pluszeichen (+)`  direkt vor einem oder mehreren Begriffen sucht nach Handbuchdateien, welche alle diese Wörter enthalten. Ein `Minuszeichen (-)`  direkt vor einem oder mehreren Begriffen sucht nach Handbuchdateien, welche alle diese Wörter nicht enthalten.

Eine Suche nach Phrasen ist nicht unterstützt, d.h. eine Suchphrase mit Anführungszeichen `"wie diese"`  führt zu keinem Ergebnis bezüglich der Phrase.

Die Resultate sind nach Relevanz sortiert (höchste Relevanz zuerst). Relevanzkriterien sind Anzahl und Positionierung der Suchbegriffe in der Handbuchdatei.

### Option 2

Für die Online-Suche im deutschen Handbuch gibt man in die Suchleiste des Browsers folgenden Suchbefehl ein (`xxxx`  ist Platzhalter für den Suchbegriff):

~~~
xxxxx site:manual.siduction.org/
~~~


## Offline-Suche

> Hinweis zur Bearbeitung der Datei:  
> Offlinesuche mit Recoll funktioniert gut wenn ein eigenes Verzeichnis benutzt wird.  
> Installationsoptionen für das siduction Handbuch prüfen.

In Zusammenarbeit mit dem Entwickler von Recoll hat Trevor Walkley (bluewater) eine spezielle Konfiguration als Teil des Standard-Pakets entwickelt worden. Diese basiert auf dem Xapian-Backend, um ein umfangreiches wie auch benutzerfreundliches Frontend mit einer auf QT aufgesetzten grafischen Benutzerführung bieten zu können.  *Ein ganz besonderer Dank geht an Recoll* .

Recoll findet man als `"Recoll - Local Text Search"`  im Unterpunkt "Dienstprogramme" des KDE-Menüs.

#### Schritt 1

Das Handbuch ist derzeit via apt für folgende Sprachen installierbar:  
de, en, pt-br.

~~~
apt-get update
apt-get install bluewater-manual-xx (-xx ist Platzhalter für die gewünschte Sprache)
~~~

#### Schritt 2

~~~
apt-get install recoll
~~~

#### Schritt 3

+ Recoll fragt beim ersten Start, ob eine Datenbank eingerichtet werden soll, was man ablehnt, indem man auf `cancel`  klickt, worauf ein Dialogfenster zur Index-Erstellung geöffnet wird.

+ Unter dem Menuepunkt  *Voreinstellungen - Indizierungskonfiguration*  geht man auf den Reiter "Globale Parameter" und klickt unterhalb von "Start-Verzeichnisse" auf das Plus-Zeichen `+`  und geht nach `/usr/share/bluewater-manual` . Dort wählt man die bevorzugte Sprache und klickt auf "ok". Als nächstes markiert man alle anderen Verzeichnisse inklusive die Tilde `~`  und klickt auf das Minuszeichen `-` , um sie zu löschen.  
  
Als "Wortstammerweiterungssprache" fügt man "German" hinzu.  
  
Man schließt das Unterfenster mit einem Klick auf "OK" rechts unten.

+ Abschließend erstellt man den Index, indem man im Hauptfenster von Recoll `Datei>Indizieren`  wählt. Nun können Begriffe im siduction-Handbuch gesucht werden.

Das Neuindizieren von Recoll nach einem Update des Handbuchs via apt erfolgt `als user $ in der Konsole` 

~~~
recollindex -z
~~~

und nach einem Neustart von Recoll durch den GUI-Befehl`Datei>Indizieren` .

Der Link 'Preview' öffnet ein neues Fenster, in dem alle Fundstellen des Suchbegriffs innerhalb einer Datei markiert sind.  
  
Der Link 'Open' hingegen öffnet Konqueror. In Konqueror verwendet man den `Suchen` -Dialog, um gewünschte Begriffe zu finden.

[Link zur Homepage von Recoll](http://www.lesbonscomptes.com/recoll/) .

<div id="rev">Page last revised 13/01/2012 1545 UTC</div>
