### Hinweise für Autoren von MarkDown Dokumenten innerhalb des siduction Handbuchs
#### Das von mir geschriebene Script "html2md.pl" befindet sich im git-repo des Handbuchs im Ordner /sidu/development .
Bei der Konvertierung der deutschen Handbuchseiten zu md traten einige Besonderheiten auf, die sicherlich auch für Autoren interessant sein dürften.

Ich habe mich an die [GitHub Flavored Markdown Spec](https://github.github.com/gfm/) gehalten und das Ergebnis mit dem **Markdown Viewer Webext** PlugIn für Firefox getestet.  
Dabei verwendete ich folgende Einstellungen:  
markdown "github"  
code style "default"  
und den zusätzlichen css-Code

~~~ css
code {
    display: block;
    background-color: #E8E8E8;
    padding: 0.5em;
}
p code, li code {
    display: inline;
    color: #C00;
    padding: 0.15em;
}
hr {
    height: 0.2em;
    background-color: darkgrey;
    border: 0;
    margin-bottom: 2em;
}
warning {
    display: block;
    background-color: yellow;
    line-height: 1.3em;
    font-size: 1em;
    padding: 10px;
}
~~~

Hier ein kurzer Überblick.

-----
#### Hervorgehobener Text

Anmerkung:  
Innerhalb dieser Bereiche findet kein parsen durch MarkDown statt. Die zusätzlichen Textauszeichnungen *, **, ` und ~~ haben keine Wirkung auf den Text, sondern werden literal dargestellt.

Die **inline span-Bereiche** werden mit  
Backtick \` `(normaler Text)`,  
Asterisk und Backtick \*\` *`(kursiver Text)`*  
doppeltem Asterisk und Backtick \*\*\` **`(fetter Text)`**  
vor und in umgedrehter Reihenfolge hinter dem zu markierenden Text  und ohne Leerzeichen dargestellt.
~~~
Beispiel:
**`(fetter Text)`**
~~~

Folgende Vereinheitlichungen wurden vorgenommen:

`<span class="highlight-1">` (ehemals grüner Text)  
`<span class="highlight-3">` (ehemals magenta Text, ähnlich besuchter Links)  
`<span class="highlight-4">` (ehemals brauner Text)  
`<span class="highlight-5">` (ehemals hellblauer Text)  
Umwandlung in `Mustertext` (inline Bereich, hellgrau hinterlegt, Text rot)

`<span class="highlight-2">` (ehemals roter Text)  
Umwandlung in **`Mustertext`** (inline Bereich, hellgrau hinterlegt, Text rot und fett)

---

#### Qellcode, hervorgehobene Absätze

In HTML: `<pre>` und `<code>`

Anmerkung:  
Auch innerhalb dieser Bereiche findet kein parsen durch MarkDown statt. Die zusätzlichen Textauszeichnungen *, **, ` und ~~ haben keine Wirkung auf den Text, sondern werden literal dargestellt. Ebenso die Zeichen <, > und &. Die Notation \&gt; usw. ist nicht notwendig!

In den Zeilen vor und nach dem Block jeweils drei Tilden an den Zeilenanfang setzen "~~~". Dies hat gegenüber der Einrückung um vier Leerzeichen zwei wichtige Vorteile.

1.  Es ist Syntax Highlighting realisierbar, indem nach den ersten Tilden der Dialekt angegeben wird.  
z.B.: ~~~ bash

    ~~~ bash
    user1@pc1:~$ $TEXT=irgendwas
    user1@pc1:~$ print "\t$TEXT\n"
        irgendwas
    ~~~

2.  Die Einrückungen innerhalb von Listen sind für Code-Blöcke und Text bei Verwendung der Tilden gleich. Wenn nur Leerzeicheneinrückung für beide Funktionen vorgenommen wird, geht spätestens ab der zweiten Ebene die Übersicht und damit die Lesbarkeit komplett verloren.

    Im unteren Beispiel sind die Einrückungen für beide Ebenen und Funktionen identisch. Quellcode und Bildschirmanzeige gleichen sich bis auf die am Bildschirm nicht sichtbaren Tilden.
*   Text
*   ~~~
    Code_Block
    ~~~
    *   Text

    *   ~~~
        Code_Block_2
        ~~~
*   Text
*   Text

---
So sieht der md-Code aus:

~~~
*   Text
*   ~~~
    Code_Block
    ~~~
    *   Text

    *   ~~~
        Code_Block_2
        ~~~
*   Text
*   Text
~~~

-----

#### Warnungen

Bei besonders wichtigen Hinweisen `<warning>` als HTML-Tag verwenden!  
Das erzeugt ein gelb hinterlegtes Blockelement mit Padding.  
Für den Titel als Einzeiler innerhalb der md-Betonung fett `**` und für den Inhalt die HTML-Tag je auf einer eigenen Zeile.

**<warning>Achtung:</warning>**
<warning>
Damit gehen alle Daten verloren!
</warning>

So sieht der Qulltext aus:
~~~
**<warning>Achtung</warning>**
<warning>
Damit gehen alle Daten verloren!
</warning>
~~~

-----
#### Anker
`<div class="divider" id="pkill"></div>`
und  
`<a name="Absatz_3">` (Das ist seit HTML5 obsolet)

Der Link zu einem Anker ist in md problemlos möglich, der Anker selbst nur in HTML!  
Das heißt, die Anker müssen bei der Konvertierung im md-Dokument erhalten bleiben bzw im HTML-Format hineingeschrieben werden.

-----

#### Überschriften
In einigen HTML-Dokumenten befanden sich Überschriften `<h6>`. In der Darstellung in md ist die Schrift deutlich kleiner als die Standardschriftgröße. Soll das wirklich so bleiben???

In einigen Dokumenten waren alle Überschriften zusätzlich Fett ausgezeichnet.  
Dazu die Frage an die Autoren und Maintainer:  
Wie sollen die Überschriften einheitlich aussehen, Normaltext oder fett?  
AKTUALISIERUNG 2020-05-12: Bei Verwendung des github-md-Dialktes erübrigt sich die Frage.

---- 

#### Header und Footer in den neuen Dateien? 
Frage an die Autoren und Maintainer:  
Was soll, was muss davon erhalten bleiben?

-----

Stand 2020-05-11, Autor: akli
