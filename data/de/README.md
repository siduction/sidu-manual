**We need someone who can translate this document!**

# Hinweise für Autoren

der MarkDown Dokumente innerhalb des siduction Handbuchs.

Ich habe mich an die [GitHub Flavored Markdown Spec](https://github.github.com/gfm/) gehalten und das Ergebnis mit dem **Markdown Viewer Webext** PlugIn für Firefox getestet. Die dabei verwendeten Einstellungen stehen in der Datei [/development/css_FF_Plugin_Markdown-Viewer-Webext](https://github.com/siduction/sidu-manual/blob/WIP/development/css_FF_Plugin_Markdown-Viewer-Webext).  
Die Einstellungen des Plugin lauten:  
markdown "github"  
code style "default"

## Dateinamen

Die Dateinamen des neuen Handbuches beginnen mit einer vierstelligen Ziffer gefolgt von einem Bindestrich.  
Die ersten zwei Ziffern ordnen die Datei der Hauptgruppe zu, z.B. "03XX-" für die Hauptgruppe "Installation".  
Ziffer drei und vier reiht die Datei innerhalb der Hauptgruppe ein.  
Lücken in der Ziffernfolge sind für die Erzeugung der .html-Dateien und des PDF unschädlich und für eventuell zukünftig hinzukommende Dateien sinnvoll.

## Überblick MD-Code

### Titel

Jede .md-Datei benötigt in der ersten Zeile einen Titel in der Notation **`% Mein Titel`**. Der Text des Titels darf ruhig von der ersten im Dokument verwendeten Überschrift abweichen. Er ist für die Erstellung der .html-Dateien notwendig und wird im Webbrowser in der Titelzeile oder dem Tab angezeigt.

### Überschriften

+ Überschriftenklassen:  
  + **#**  
    Nur für Hauptgruppen und nur einmal in der ersten Datei der Hauptgruppe verwenden.  
    Hauptgruppen sind z.B.: "Installation", "Systemadministration" oder "Netzwerk".  
  + **##** und **###**  
    Standard in den .md-Dateien.  
  + **####**  
    Selten bis nicht anzutreffen in .md-Dateien.  
    Diese Überschriften integriert pandoc (LaTex) als fett ausgezeichneten Text in die erste Zeile des folgenden Absatzes. Das führt besonders bei folgenden Listen oder Tabellen zu unerwarteten und unerwünschten Effekten. Meistens ist ein Zeile mit fettem Text sinnvoller.  
+ Sonderzeichen  
  Erlaubt sind das **Leerzeichen**, der **Punkt** und der **Bindestrich** bzw. das Minuszeichen.  
  Nicht erlaubt sind diese, und noch viele weitere Zeichen:
  
  ~~~
  , ; : ! ? ^ " ´ ` ' „ “ § $ % & / \  
  ( ) { } [ ] + * ~ # | < > » « &#8482 &gth;
  ~~~
  
+ Überschriften einzigartig, prägnant und kurz  
  + Überschriften, auf die eventuell verlinkt wird, müssen einzigartig sein.  
  + Überschriften sollen kurz sein.  
+ Sparsam mit Überschriften umgehen  
  + Bitte Überschriften sparsam einsetzen.  
    Eine Überschrift, dann ein Absatz mit zwei oder drei Zeilen und wieder eine Überschrift ist Unsinn.
    
### Hervorgehobener Text

Innerhalb dieser Bereiche findet kein parsen durch MarkDown statt. Die zusätzlichen Textauszeichnungen **\***, **\*\***, **\`** und **\~~** haben keine Wirkung auf den Text und codierte Zeichen **`&gth;`** werden literal dargestellt.

+ **inline Bereiche** werden mit  
  Backtick \` `(normaler Text)`,  
  Asterisk und Backtick \*\` *`(kursiver Text)`*  
  doppeltem Asterisk und Backtick \*\*\` **`(fetter Text)`**  
  vor und in umgedrehter Reihenfolge hinter dem zu markierenden Text  und ohne Leerzeichen dargestellt.
  ~~~
  Beispiel:
  **`(fetter Text)`**
  ~~~

+ **Absätze, Qellcode**  
  Vor und nach dem Block jeweils eine Leerzeile einfügen. Die erste und die letzte Zeile besteht aus drei Tilden "\~\~\~". Dies hat gegenüber der Einrückung um vier Leerzeichen zwei wichtige Vorteile.  
  + Es ist Syntax Highlighting realisierbar, indem nach den ersten Tilden der Dialekt angegeben wird. z.B.: \~\~\~sh  
  + Die Einrückungen innerhalb von Listen sind für Code-Blöcke und Text bei Verwendung der Tilden gleich. Wenn nur Leerzeicheneinrückung für beide Funktionen vorgenommen wird, geht spätestens ab der zweiten Ebene die Übersicht und damit die Lesbarkeit komplett verloren.  
    Im unteren Beispiel (mit Tilden) sind die Einrückungen für beide Ebenen und Funktionen identisch. Quellcode und Bildschirmanzeige gleichen sich bis auf die am Bildschirm nicht sichtbaren Tilden.  
    
    * Text

      ~~~     
      Code_Block  
      ~~~  

      * Text  

        ~~~  
        Code_Block_2  
        ~~~  

    So sieht der md-Code aus:

~~~
    * Text

      ~~~
      Code_Block
      ~~~

      * Text

        ~~~
        Code_Block_2
        ~~~
~~~

### Warnungen

Bei besonders wichtigen Hinweisen die Zeilen quoten: "> "  
Das erzeugt in MD ein Zitat (einen Einzug mit grauem, senkrechten Balken und ausgegrauter Schrift), in PDF- und .html-Dokumenten ein farblich hinterlegtes Blockelement mit Padding.

+ **Zeilenumbruch** innerhalb der Warnungen:  
    Die Zeilen **müssen** mit **zwei Leerzeichen** enden!  
    Beispiel:
    
    > **Achtung:**  
    > Damit gehen alle Daten verloren!

    So sieht der Qulltext aus:
    ~~~
    > **Achtung**  
    > Damit gehen alle Daten verloren!
    ~~~

### Footer in den neuen Dateien

Die letzte Zeile der .md-Dateien enthält den Bearbeitungshinweis in HTML-Notation:

~~~
<div id="rev">Zuletzt bearbeitet: 2021-05-04</div>
~~~

Er wird in .md-Dateien (nur lokal im FF) und .html-Dateien rechtsbündig, verkleinert und ausgegraut dargestellt.

### Tabellen, Listen , Link, sonstiges

Alles weitere richtet sich nach [GitHub Flavored Markdown Spec](https://github.github.com/gfm/), allerdings mit einer Ausnahme.  
**Keine horizontalen Linen** verwenden.

Stand 2021-05-11, Autor: akli
