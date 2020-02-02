### Hinweise für Autoren von MarkDown Dokumenten innerhalb des siduction Handbuchs
Bei der Konvertierung der deutschen Handbuchseiten zu md traten einige Besonderheiten auf, die sicherlich auch für Autoren interessant sein dürften.

Ich habe mich an die [GitHub Flavored Markdown Spec](https://github.github.com/gfm/) gehalten  
und das Ergebnis mit [markdown-it demo](https://markdown-it.github.io/) getestet.

Hier ein kurzer Überblick.

-----
#### Hervorgehobener Text

Anmerkung:  
Innerhalb dieser Bereiche findet kein parsen durch MarkDown statt. Die zusätzlichen Textauszeichnungen *, **, ` und ~~ haben keine Wirkung auf den Text, sondern werden literal dargestellt.

Die inline span-Bereiche werden mit Backtick \` (normaler Text), Asterisk und Backtick \*\` (kursiver Text) sowie doppeltem Asterisk und Backtick \*\*\` (fetter Text) dargestellt.

Folgende Vereinheitlichungen wurden vorgenommen:

<span class="highlight-1"> (ehemals grüner Text)  
<span class="highlight-3"> (ehemals violetter Text, ähnlich besuchter Links)  
<span class="highlight-4"> (ehemals brauner Text)  
Umwandlung in `Mustertext` (inline Bereich, hellgrau hinterlegt, Text rot)

<span class="highlight-2"> (ehemals roter Text)  
Umwandlung in **`Mustertext`** (inline Bereich, hellgrau hinterlegt, Text rot und fett)

---
#### Qellcode, hervorgehobene Absätze
In HTML: <pre> und <code>

Anmerkung:  
Auch innerhalb dieser Bereiche findet kein parsen durch MarkDown statt. Die zusätzlichen Textauszeichnungen *, **, ` und ~~ haben keine Wirkung auf den Text, sondern werden literal dargestellt. Ebenso die Zeichen <, > und &. Die Notation \&gt; usw. ist nicht notwendig!

In den Zeilen vor und nach dem Block jeweils drei Tilden an den Zeilenanfang setzen "~~~". Dies hat gegenüber der Einrückung um vier Leerzeichen zwei wichtige Vorteile.

1.  Es ist Syntax Highlighting realisierbar, indem nach den ersten Tilden der Dialekt angegeben wird.  
z.B.: ~~~ bash

    ~~~ bash
    user1@pc1:~$ TEXT=irgendwas
    user1@pc1:~$ printf "\t$TEXT\n"
        irgendwas
    ~~~

-----
2.  Die Einrückungen innerhalb von Listen sind für Code-Blöcke und Text bei Verwendung der Tilden gleich. Wenn nur Leerzeicheneinrückung für beide Funktionen vorgenommen wird, geht spätestens ab der zweiten Ebene die Übersicht und damit die Lesbarkeit komplett verloren.

    Im unteren Beispiel sind die Einrückungen für beide Ebenen und Funktionen identisch. Quellcode und Bildschirmanzeige gleichen sich bis auf die am Bildschirm nicht sichtbaren Tilden.
*   Text
*   ~~~
    Code Block
    ~~~
    *   Text

    *   ~~~
        code Block
        ~~~
*   Text
*   Text

-----
#### Warnungen
Bei besonders wichtigen Hinweisen "warning" verwenden!  
Das erzeugt ein gelb hinterlegtes Blockelement mit Padding.

:::warning
**Achtung:**  
Damit gehen alle Daten verloren!
:::
---
So sieht der Qulltext aus:
~~~
::: warning
**Achtung**  
damit gehen alle Daten verloren!
:::
~~~

-----
#### Anker
<div class="divider" id="pkill"></div>

--> Ein Anker für internen Link
  
Der Link zu einem Anker ist in md problemlos möglich, der Anker selbst nur in HTML!  
Das heißt, die Anker müssen bei der Konvertierung im md-Dokument erhalten bleiben bzw im HTML-Format hineingeschrieben werden.

-----
#### Überschriften
In einigen HTML-Dokumenten befanden sich Überschriften <h6>. In der Darstellung in md ist die Schrift deutlich kleiner als die Standardschriftgröße. Ich habe sie bei der Konvertierung auf die Größe #### angehoben und die Überschriften <h5> und <h4> jeweils um einen Wert nach #### und ### vergrößert.

In einigen Dokumenten waren alle Überschriften zusätzlich Fett ausgezeichnet.  
Dazu die Frage an die Autoren und Maintainer:  
Wie sollen die Überschriften aussehen, einheitlich Normaltext oder fett?

---- 
#### Header und Footer in den neuen Dateien? 
Frage an die Autoren und Maintainer:  
Was soll davon erhalten bleiben?

-----

Stand 2020-02-01, Autor: akli
