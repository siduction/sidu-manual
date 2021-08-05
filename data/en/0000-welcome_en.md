% Siduction Handbuch

# Willkommen

**Das siduction™ GNU/Linux-Betriebssystem**

Der Name **siduction** ist ein Wortspiel aus zwei Begriffen: Dem Wort **sid**, also dem Codenamen von Debian Unstable und **seduction**, im Sinne von verführen.

siduction ist ein Betriebssystem, das auf dem [Linux-Kernel](https://kernel.org) und dem [GNU-Projekt](https://gnu.org) basiert. Dazu kommen Anwendungsprogramme von [Debian](https://debian.org). siduction ist den Grundwerten des [Debian Gesellschaftsvertrags](https://www.debian.org/social_contract.de.html) und den daran anschließenden "*Debian Free Software Guidelines*" verpflichtet.  
Siehe auch [DFSG](https://de.wikipedia.org/wiki/Debian_Free_Software_Guidelines)

### Allgemeines

Für Schnellentschlossene geht es hier weiter zur [Kurzanleitung](./wel-quickstart_de.md#siduction-kurzanleitung)

Das Handbuch des siduction Betriebssystems ist eine Referenz zum Kennenlernen des Systems wie auch zum Auffrischen der Kenntnisse über das System. Es vermittelt nicht nur Grundlagenwissen, sondern umfasst auch komplexe Themenkreise und unterstützt die Arbeit als Administrator von siduction-Systemen.

Es ist nach gleichartigen Themen unterteilt: Alles was zum Beispiel das Partitionieren betrifft, befindet sich im Kapitel "Installation/Partitionieren", und Themen, die WLAN betreffen befinden sich im Kapitel "Netzwerk".

Drucken von Handbuchseiten:  
Linuxbefehle können mehr als 120 Zeichen lang sein. Für eine optimierte Darstellung am Bildschirm findet kein automatischer Zeilenumbruch statt. Unser Handbuch im PDF-Format, dass auf allen ISO's und nach der Installation im System verfügbar ist, verwendet für die langen Befehle den Zeilenumbruch. Es steht auch [hier online](https://manual.siduction.org/manual.pdf) zur Verfügung.  
Zum Drucken von Handbuchseiten verwende bitte das PDF und drucke nur die benötigten Seiten.

Um Hilfe für ein spezifisches vorinstalliertes oder selbst installiertes Anwendungsprogramm (auch Paket genannt) zu erhalten, informiert man sich am besten in den FAQs, Online-Handbüchern oder Foren auf der Hompage bzw. im Hilfe-Menü der Anwendung.

Fast alle Anwendungsprogramme bieten Hilfestellung mittels einer zugehörigen "*Manual-Page*" (kurz Manpage). Sie wird im Terminal durch den Befehl **`man <Paketname>`** aufgerufen. Auch kann nachgesehen werden, ob sich eine Dokumentation in */usr/share/doc/\<paketname\>* befindet.

### Copyright Rechts- und Lizenzhinweise

Alle Rechte © 2006-2021 des siduction-manual sind lizenziert unter der [GNU Free Documentation License](https://gnu.org/licenses/fdl.txt). Eine informelle Übersetzung dieser Lizenz ins Deutsche befindet sich [hier](https://www.selflinux.org/selflinux/html/gfdl_de.html).  
Dies gestattet das Dokument nach den Bestimmungen der GNU Free Document License Version 1.3 oder neuer (wie veröffentlicht bei der Free Software Foundation) zu kopieren, verbreiten und/oder zu ändern; ohne unveränderliche Sektionen und ohne Umschlagstexte (Vorderseitentexte, Rückseitentexte).

Die Rechte von geschützten Marken bzw. Urheberrechte liegen bei den jeweiligen Inhabern, unabhängig davon, ob dies vermerkt ist oder nicht.

Irrtum vorbehalten (E&OE) 

### Haftungsausschluss

Dies ist experimentelle Software. Benutzung geschieht auf eigenes Risiko. Das siduction-Projekt, seine Entwickler und Teammitglieder können unter keinen Umständen haftbar gemacht werden für Schäden an Hard- oder Software, Datenverlust oder anderen, direkten oder indirekten Schäden, entstanden durch die Benutzung dieser Software.

Solltest Du mit diesen Bedingungen nicht einverstanden sein, so ist es Dir nicht gestattet, diese Software weiter zu benutzen oder zu verteilen.

<div id="rev">Zuletzt bearbeitet: 2021-07-19</div>

------------------------------------------------------- EN -------------------------------------------------------------------

% Siduction Manual

# Welcome

**The siduction™ GNU/Linux operating system**.

The name **siduction** is a wordplay of two terms: The word **sid**, meaning the code name of Debian Unstable, and **seduction**, meaning to seduce.

siduction is an operating system based on the [Linux kernel](https://kernel.org) and the [GNU project](https://gnu.org). In addition there are application programs from [Debian](https://debian.org). siduction is committed to the core values of the [Debian Social Contract](https://www.debian.org/social_contract.de.html) and the following "*Debian Free Software Guidelines*".  
See also [DFSG](https://de.wikipedia.org/wiki/Debian_Free_Software_Guidelines)

### General

For those who want to get started quickly, here is the [Quick Start Guide](./wel-quickstart_en.md#siduction-short-guide)

The siduction operating system manual is a reference for getting to know the system as well as for refreshing your knowledge of the system. It not only provides basic knowledge, but also covers complex topics and supports the work as an administrator of siduction systems.

It is divided into similar topics: Everything concerning partitioning, for example, is in the "Installation/Partitioning" chapter, and topics concerning WLAN are in the "Network" chapter.

Printing manual pages:  
Linux commands can be more than 120 characters long. For an optimized display on the screen, there is no automatic line break. Our manual in PDF format, which is available on all ISO and after installation in the system, uses line breaking for the long commands. It is also available [online here](https://manual.siduction.org/manual.pdf).  
To print manual pages, please use the PDF and print only the pages you need.

To get help for a specific pre-installed or self-installed application program (also called a package), it is best to consult the FAQs, online manuals or forums on the home page or help menu of the application.

Almost all application programs offer assistance by means of an associated "*Manual-Page*" (short manpage). (short man page). It is called in the terminal by the command **`man <package name>`**. You can also check if there is documentation in */usr/share/doc/\<packagename\>*.

### Copyright Legal and License Notices

All rights © 2006-2021 of the siduction-manual are licensed under the [GNU Free Documentation License](https://gnu.org/licenses/fdl.txt). An informal translation of this license into German can be found [here](https://www.selflinux.org/selflinux/html/gfdl_de.html).  
This permits copying, distribution and/or modification of the document under the terms of the GNU Free Document License version 1.3 or later (as published by the Free Software Foundation); without Invariant Sections and without Cover Texts (Front-Cover Texts, Back-Cover Texts).

The rights of protected trademarks or copyrights belong to the respective owners, regardless of whether this is noted or not.

Errors excepted (E&OE) 

### Disclaimer

This is experimental software. Use at your own risk. The siduction project, its developers and team members cannot be held liable under any circumstances for any damage to hardware or software, loss of data or any other direct or indirect damage caused by the use of this software.

If you do not agree with these terms, you are not allowed to further use or distribute this software.

<div id="rev">Last edited: 2021-07-19</div>


It is divided into similar topics: Everything concerning partitioning, for example, is in the "Installation/Partitioning" chapter, and topics concerning WLAN are in the "Network" chapter.

Printing manual pages:  
Linux commands can be more than 120 characters long. For an optimized display on the screen, there is no automatic line break. Our manual in PDF format, which is available on all ISO's and after installation in the system, uses line breaking for the long commands. It is also available [online here](https://manual.siduction.org/manual.pdf).  
To print manual pages, please use the PDF and print only the pages you need.

To get help for a specific pre-installed or self-installed application program (also called a package), it is best to consult the FAQs, online manuals or forums on the home page or help menu of the application.

Almost all application programs offer assistance by means of an associated "*Manual-Page*" (short manpage). (short man page). It is called in the terminal by the command **`man <package name>`**. You can also check if there is documentation in */usr/share/doc/\<packagename\>*.

### Copyright Legal and License Notices

All rights © 2006-2021 of the siduction-manual are licensed under the [GNU Free Documentation License](https://gnu.org/licenses/fdl.txt). An informal translation of this license into German can be found [here](https://www.selflinux.org/selflinux/html/gfdl_de.html).  
This permits copying, distribution and/or modification of the document under the terms of the GNU Free Document License version 1.3 or later (as published by the Free Software Foundation); without Invariant Sections and without Cover Texts (Front-Cover Texts, Back-Cover Texts).

The rights of protected trademarks or copyrights belong to the respective owners, regardless of whether this is noted or not.

Errors excepted (E&OE) 

### Disclaimer

This is experimental software. Use at your own risk. The siduction project, its developers and team members cannot be held liable under any circumstances for any damage to hardware or software, loss of data or any other direct or indirect damage caused by the use of this software.

If you do not agree with these terms, you are not allowed to further use or distribute this software.

<div id="rev">Last edited: 2021-08-05</div>

