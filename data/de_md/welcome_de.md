% siduction Handbuch
% siduction Team
% April 2021

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

**DIESE SEITE MUSS IMMER DIE ERSTE SEITE SEIN**
pandoc -i seite1.md seite2.md ... usw -o manual.pdf

Änderungen 2021-02

+ Inhalte aktualisiert.
+ Link geprüft und korrigiert.

Änderung 2021-04-13
+ für pandoc md nach pdf optimiert, die oberen % bezeichnen den Titel, den Author und das Datum (% \title, % \author, %\date)
+ fixed Kapitel Hierarchie ( wichtig, Seite immer mit '# KAPITEL' starten alle anderen Kapitel  als unter Kapitel ## bzw ### Kategorie. So wird der Themen Begin auf einer neuen Seite gewährleistet

ENDE   INFOBEREICH FÜR DIE AUTOREN

---

# siduction Manual 

## Willkommen zum Handbuch des siduction™ GNU/Linux-Betriebssystems

Der Name **siduction** ist ein Wortspiel aus zwei Begriffen. Dem Wort **sid**, dem Codenamen von Debian Unstable und **seduction**, im Sinne von verführen.

siduction ist ein Betriebssystem, das auf dem [Linux-Kernel](https://kernel.org) und dem [GNU-Projekt](https://gnu.org) basiert. Dazu kommen Anwendungsprogramme von [Debian](https://debian.org). siduction ist den Grundwerten des [Debian Gesellschaftsvertrags](https://www.debian.org/social_contract.de.html) und den daran anschließenden "*Debian Free Software Guidelines*" verpflichtet.  
Siehe auch [DFSG](https://de.wikipedia.org/wiki/Debian_Free_Software_Guidelines)

---

## Benutzungshinweise

Das Handbuch des siduction Betriebssystems ist eine Referenz zum Kennenlernen des Systems wie auch zum Auffrischen der Kenntnisse über das System. Es vermittelt nicht nur Grundlagenwissen, sondern umfasst auch komplexe Themenkreise und unterstützt die Arbeit als Administrator von siduction-Systemen.

---

Für Schnellentschlossene geht es hier weiter zur [Kurzanleitung](./wel-quickstart_de.htm).

---

## Copyright, Rechts- und Lizenzhinweise

Alle Rechte © 2006-2021 des siduction-manual sind lizenziert unter der [GNU Free Documentation License](https://gnu.org/licenses/fdl.txt). Eine informelle Übersetzung dieser Lizenz ins Deutsche befindet sich [hier](https://www.selflinux.org/selflinux/html/gfdl_de.html).  
Dies gestattet das Dokument nach den Bestimmungen der GNU Free Document License Version 1.3 oder neuer (wie veröffentlicht bei der Free Software Foundation) zu kopieren, verbreiten und/oder zu ändern; ohne unveränderliche Sektionen und ohne Umschlagstexte (Vorderseitentexte, Rückseitentexte).

Die Rechte von geschützten Marken bzw. Urheberrechte liegen bei den jeweiligen Inhabern, unabhängig davon, ob dies vermerkt ist oder nicht.

Irrtum vorbehalten (E&OE) 

## Allgemeines

Das Handbuch ist nach gleichartigen Themen unterteilt: Alles was zum Beispiel das Partitionieren betrifft, befindet sich im Kapitel "Partitionieren", und Themen, die WLAN betreffen befinden sich im Kapitel "Netzwerk".

Um Hilfe für ein spezifisches vorinstalliertes oder selbst installiertes Anwendungsprogramm (auch Paket genannt) zu erhalten, informiert man sich am besten in den FAQs, Online-Handbüchern oder Foren auf der Hompage bzw. im Hilfe-Menü der Anwendung.

Fast alle Anwendungsprogramme bieten Hilfestellung mittels einer zugehörigen "*Manual-Page*" (kurz Manpage). Sie wird im Terminal durch den Befehl **`man <Paketname>`** aufgerufen. Auch kann nachgesehen werden, ob sich eine Dokumentation in */usr/share/doc/\<paketname\>* befindet.

## Drucken von Handbuchseiten

Linuxbefehle können mehr als 120 Zeichen lang sein. Für eine optimierte Darstellung am Bildschirm findet kein automatischer Zeilenumbruch statt.  
Diese langen Zeilen sind nicht auf einem DIN-A4-Hochformat-Ausdruck mit der üblichen Zeichengröße von 12pt darstellbar. Das Drucken von Handbuchseiten in Hochformat (Portrait) erlaubt somit nicht das Drucken überlanger Codes innerhalb der physischen Papierränder.

Wir bitten dies zu berücksichtigen und zum Drucken der Handbuchseiten die Option "*Querformat (Landscape)*" zu benutzen. 

## Haftungsausschluss

Dies ist experimentelle Software. Benutzung geschieht auf eigenes Risiko. Das siduction-Projekt, seine Entwickler und Teammitglieder können unter keinen Umständen haftbar gemacht werden für Schäden an Hard- oder Software, Datenverlust oder anderen, direkten oder indirekten Schäden, entstanden durch die Benutzung dieser Software.

Solltest Du mit diesen Bedingungen nicht einverstanden sein, so ist es Dir nicht gestattet, diese Software weiter zu benutzen oder zu verteilen.

---

<div id="rev">Zuletzt bearbeitet: 2021-02-07</div>
