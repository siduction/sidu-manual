**We need someone who can translate this document!**

# Hinweise für Autoren

der MarkDown Dokumente innerhalb des siduction Handbuchs.

**Inhalt**

+ Dateinamen
+ Handbuch und Hilfsdateien erzeugen
  + PDF Handbuch
  + HTML Handbuch
  + Überschriftenlisten
+ Überblick MD-Code
  + Titel
  + Überschriften
  + Link zu Überschriften
  + Hervorgehobener Text
  + Warnungen
  + Footer in den neuen Dateien
  + Tabellen Listen Link sonstiges

Ich habe mich an die [GitHub Flavored Markdown Spec](https://github.github.com/gfm/) gehalten und das Ergebnis mit dem **Markdown Viewer Webext** PlugIn für Firefox getestet. Die dabei verwendeten Einstellungen stehen in der Datei [/development/css_FF_Plugin_Markdown-Viewer-Webext](https://github.com/siduction/sidu-manual/blob/WIP/development/css_FF_Plugin_Markdown-Viewer-Webext).  
Die Einstellungen des Plugin lauten:  
markdown "github"  
code style "default"

## Dateinamen

Die Dateinamen des neuen Handbuches beginnen mit einer vierstelligen Ziffer gefolgt von einem Bindestrich.  
Die ersten zwei Ziffern ordnen die Datei der Hauptgruppe zu, z.B. "03XX-" für die Hauptgruppe "Installation".  
Ziffer drei und vier reiht die Datei innerhalb der Hauptgruppe ein.  
Lücken in der Ziffernfolge sind für die Erzeugung der .html-Dateien und des PDF unschädlich und für eventuell zukünftig hinzukommende Dateien sinnvoll.

## Handbuch und Hilfsdateien erzeugen

### PDF Handbuch

Das Script **/development/md2pdf** im Ordner "data/de/" mit "../../development/md2pdf" ausführen. Die intern verwendete Datei "pandoc-header-pdf.tex" steuert das Erscheinungsbild der Ausgabe. Es werden nur die numerierten Dateien verwendet. Das PDF wird im Ordner "data/de/pdf/" abgelegt.

### HTML Handbuch

Für die einzelnen HTML-Seiten sind es die Scripte **/development/md2html\_pre.pl** und **/development/md2html5.sh**. Letzteres ruft intern das erste auf. Die Scripte liegen im Verzeichnis /development, ebenso wie das notwendige Template "pandoc_template.html5" mit den css-Codes. Erstellung der Dateien im Ordner "data/de/" mit "../../development/md2html5.sh". Die Dateien liegen anschließend im Ordner "data/de/html".

Eine einzelne Menue-Datei (für die Verwendung in der Sidebar) generiert das Script **/development/menue-extract.pl** und benutzt dabei für den Header die Datei "tree-menue-header.html". Der Aufruf erfolgt aus dem Ordner "data/de/" mit "../../development/menue-extract.pl". Das erstellte Menue mit dem Namen "tree-menue.html" befinden sich dann auch im Ordner "data/de/html/".

### Überschriftenlisten

Die Dateien "headline-by-file" und "headline-by-text" unterstützen dich beim Verlinken auf Handbuch interne Seiten.
Um sie zu erzeugen in den Ordner "data/de/" wechseln und "../../development/headline-extract.pl." eingeben. Die erstellten Überschriftenlisten befinden sich dann im Ordner /development.

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
    Selten bis nicht anzutreffen in .md-Dateien. Meistens ist ein Zeile mit fettem Text sinnvoller.  
    Diese Überschriften integriert pandoc (LaTex) als fett ausgezeichneten Text in die erste Zeile des folgenden Absatzes. Das führt besonders bei folgenden Listen oder Tabellen zu unerwarteten und unerwünschten Effekten.  
+ Sonderzeichen  
  Erlaubt sind das **Leerzeichen**, der **Punkt** und der **Bindestrich** bzw. das Minuszeichen.  
  Verboten sind diese, und noch viele weitere Zeichen, weil eine Verlinkung auf Überschriften mit diesen Zeichen nicht möglich ist:
  
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

### Link zu Überschriften

Soll auf Handbuch interne Seiten verlinkt werden, **muss** der Link **immer** einen Anker (#name-der-überschrift) enthalten.

+ Richtige Schreibweise des Link  
  Nach dem Dateinamen folgt immer die Raute "#" und die Zielüberschrift (Sprungadresse bzw. Anker).    
  Es gilt vollständige Kleinschreibung und Leerzeichen sind durch "-" zu ersetzen.
  Die Schreibweise bezieht sich auf die Überschrift "### Copyright Rechts- und Lizenzhinweise" im .md-Dokument "0000-welcome_de.md".
  
  ~~~
  [Siehe Copyright](0000-welcome_de.md#copyright-rechts--und-lizenzhinweise)
  ~~~

+ Überschriftenlisten  
  Die Dateien [headline-by-file](https://github.com/siduction/sidu-manual/blob/WIP/development/headline-by-file) und [headline-by-text](https://github.com/siduction/sidu-manual/blob/WIP/development/headline-by-text) unterstützen dich beim Verlinken auf Handbuch interne Seiten.
    
### Hervorgehobener Text

Innerhalb dieser Bereiche findet kein parsen durch MarkDown statt. Die zusätzlichen Textauszeichnungen **\***, **\*\***, **\`** und **\~~**, sowie codierte Zeichen **`&gth;`**, haben keine Wirkung auf den Text sondern werden literal dargestellt.

+ **inline Bereiche** werden mit  
  Backtick \` `(normaler Text)`,  
  Asterisk und Backtick \*\` *`(kursiver Text)`*  
  doppeltem Asterisk und Backtick \*\*\` **`(fetter Text)`**  
  vor und in umgedrehter Reihenfolge hinter dem zu markierenden Text und ohne Leerzeichen dargestellt.
  
  ~~~
  Beispiel:
  **`(fetter Text)`**
  ~~~

+ **Absätze Quellcode**  
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

### Tabellen Listen Link sonstiges

Alles weitere richtet sich nach [GitHub Flavored Markdown Spec](https://github.github.com/gfm/), allerdings mit einer Ausnahme.  
**Keine horizontalen Linen** verwenden.

Stand 2021-06-18, Autor: akli
