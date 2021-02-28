# Release Notes für siduction 2014.1.0
Wir freuen uns sehr, euch jetzt siduction 2014.1.0 -  *Indian Summer*  - präsentieren zu dürfen.  Siduction basiert auf dem Unstable-Zweig von Debian und wir sind bemüht, im Verlauf eines Jahres mehrere Snapshots erscheinen zu lassen. In 2014 haben wir lediglich dieses eine Release herausgebracht. Jedoch waren wir nicht untätig und haben eine Menge Zeit und Energie in  die Stabilisierung des Systems investiert. Zudem haben wir Systemd integriert und mehrere Dev-Releases herausgebracht. Wir wissen, dass es  nicht ideal ist ein Installationsmedium zu haben, dass älter als sechs Monate ist, deshalb nehmt bitte unsere Entschuldigung an; wir werden uns bemühen, in Zukunft häufiger zu veröffentlichen. 

Alle unsere Varianten sind in sehr guter Verfassung, sodass wir keine Zeit mit RC´s verschwenden wollen, sondern direkt mit einem echten Release kommen.

siduction 2014.1.0 -  *Indian Summer*  wird mit 6 Desktop-Umgebungen ausgeliefert: KDE SC, XFCE, LXDE, LXQt, GNOME und Cinnamon, alle jeweils in 32- und 64-bit Versionen. Von den angebotenen Varianten passt lediglich LXDE noch auf eine CD mit 700 MByte. Da aber das Medium CD zunehmend an Bedeutung verliert, versuchen wir nicht, unsere Images unter dieser Marge zu halten, sondern empfehlen die Verwendung von USB-Sticks zur Installation.

Die veröffentlichten ISOs sind ein Snapshot von Debian Sid vom 22.11.2014, ergänzt mit ein paar nützlichen Paketen und Skripten, einem   Installer und unserer eigenen gepatchten Version des Kernels 3.17 sowie X-Server 1.16.1.

Neben diesen Desktop-Umgebungen ist auch  *noX*  als Arbeitsumgebung ohne X-Server wieder vertreten. Neu hinzugekommen ist mit    *Xorg*  ein Image, das einen X-Server und den minimalistischen Window-Manager Fluxbox mitbringt.

Vor einem Jahr haben wir uns für die Implementation von  *Systemd*  entschieden. Debian hat inzwischen für Debian 8 "Jessie" auch Systemd   gewählt. Auch Ubuntu wird Upstart aufgeben und Systemd einsetzen. Somit war unsere Entschedung vor einem Jahr goldrichtig. Es ist, wenn auch  immer noch kontrovers diskutiert, das derzeit technisch am weitesten entwickelte verfügbare Init-System und Systemmanagement-Werkzeug. Wir  haben eine eigene Sektion für Systemd in unser Handbuch eingefügt, die nach und nach erweitert und in andere Sprachen übersetzt werden wird.  

## Was gibt´s Neues

### Cinammon

Da unser Dev-Release im Oktober sehr gut angenommen wurde, liefern wir nun Cinammon als volles Mitglied unserer siduction Varianten aus.  Für weitere Informationen über das Innenleben dieser auf GTK+ 3 basierenden Benutzeroberfläche schaut euch die aktuellen  [Release notes](http://news.siduction.org/2014/10/release-notes-for-sidcution-cinnamon-dev-release/) zu Cinammon an.

Wir gewinnen zwei Desktops und verlieren einen. Razor-QT wird nicht mehr von uns unterstützt. Es ist mittlerweile in LXQt eingeflossen. So   haben wir die Freude, nun über unseren zweiten Zuwachs der siduction Familie zu sprechen. Durch unseren Entwickler agaida, der in die  Weiterentwicklung von LXQt eingebunden ist, werden wir jederzeit die aktuellsten funktionierenden Pakete in unseren Quellen haben. LXQt ist  sehr gereift und verdient es, Teil der Familie zu sein. Auch wenn es bislang nicht so ausentwickelt ist wie LXDE, befindet es sich doch auf  einem guten Weg. Da LXQt mittlerweile komplett in Qt 5 gebaut ist, ist es in weiten Teilen auf Wayland vorbereitet.

### Und sonst?

### KDE SC

KDE SC ist zu Version 4.14.2, einer der letzten Stufen des KDE 4 Kapitels, herangereift. Wir haben das Kickoff-Menü herausgenommen und durch   Homerun ersetzt. Die Systemeinstellungen haben zwei neue Module, die bislang auch Debian (noch nicht) hat. Eine davon nennt sich 'Desktop  Search Advanced' und ist ein detailierteres Konfigurationsmodul für Baloo, den Nachfolger von Nepomuk. Das andere neue Modul in den  Systemeinstellungen trägt die Bezeichnung Systemd und enthält eine Fülle von bei der Konfiguration des Systemd Daemon äußerst hilfreichen  Einstellungen. Als zweites Suchwerkzeug für Baloo haben wir neben Dolphin auch  Milou mit hinein genommen, welches im Systemabschnitt der Taskleiste sitzt

Ihr könnt mit Sicherheit davon ausgehen, dass dies das letzte siduction Release ist, das Software der KDE 4er-Reihe enthält. Unser nächstes   Release wird  mit Frameworks 5 und Plasma 5 ausgeliefert werden.

### GNOME

Das von uns gewählte GNOME in Version 3.14.1 bringt einige neue Funktionen mit. Da Gnome noch relativ neu in unserem Release-Zyklus ist,   hier ein paar Tipps um eine GNOME-Session zu handhaben:

Es gibt zwei Wege, eine GNOME-Session zu starten:

*  *gnome-fallback* , das dem GNOME 2-Look entspricht

*  *gnome* , dass GNOME 3 entspricht und Desktop-Effekte mitbringt  

Um GNOME 3 starten zu können braucht es eine 3D-beschleunigte Grafikkarte. Nutzer von ATI-Karten müssen  *firmware-linux-nonfree* 
installieren, um GNOME 3 nutzen zu können. Im Live-Mode ist standardmäßig GNOME-Fallback eingestellt. Nach der Installation wird auf GNOME 3 
umgeschaltet, wenn vor der Installation  *firmware-linux-nonfree*  installiert wurde. 
Boot-Cheatcode "gnome" wurde entfernt, da er überholt ist. Das Aussehen der Fenster in GNOME hat sich geändert, da die Entwickler die Knöpfe   zum Minimieren und Maximieren entfernt haben. Um ein Fenster zu minimieren oder zu maximieren muss man nun einen Rechtsklick in der oberen  Titelleiste machen und aus dem Menü ads jeweilige auswählen. Um das Fenster zu maximieren kann man auch einen Doppelklick in der Fensterleiste  ausführen. Wir haben einige der meistbenutzten Anwendungen zu den Favoriten (aka Dash) hinzugenommen. Dort findet sich nun etwa hexchat,  transmission, libreoffice, siduction bug report tool, gnome-terminal und viele weitere.

Zum zweiten Mal ist  **noX** , das im Oktober 2012 als Development Release veröffentlicht wurde, als offizielles Release mit dabei. Da noX   keine grafische Umgebung bietet, muss die Installation per  *cli-installer*  erfolgen.

 **XFCE**  ist immer noch in Version 4.10.1 mit dabei und solide wie immer.

Neben  **LXQt**  bieten wir die neueste Version von  **LXDE** , ebenfalls ein Leichtgewicht aber anstelle von Qt auf GTK+2 basiert. LXDE   wird solange weiterentwickelt, wie GTK+2 nutzbar erscheint.

Viel Zeit verschlang erneut die Anpassung der von uns übernommenen Codebase an eigene Bedürfnisse, ebenso wie die Integration von Systemd.   Die Arbeit am sidu-manual, wie es nun heißt, wird fortgesetzt um das Hinzufügen neuer Informationen zu erleichtern. 

wir seit dem letzten Release
[etwa 230 Fehler beseitigt.](http://bugs.siduction.org/projects/siduction/issues/report)  

Zusammenhang. Die Unterstützung von  *btrfs*  ist immer noch als experimentell anzusehen und es sollte noch nicht auf Produktivsystemen 
eingesetzt werden. Regelmäßige Backups sind absolut Pflicht! Der Installer wurde erstmal auf einige Basisfunktionen beschränkt, bis einige 
Sachen verlässlicher funktionieren. Aufgrund einiger interner Änderungen von fdisk müssen einige Teile der automatischen Partitionierung 
umgeschrieben werden. Da dies noch nicht vollständig geschehen ist, haben wir die automatische Partitionierung vorerst entfernt.

Wir mussten das Konzept unseres Artwork ändern. In der Vergangenheit widmeten wir jedes Release einem Rocksong und versuchten ein dazu passendes Artwork zu haben. Aus zwei Gründen haben wir diese Idee aufgegeben. Erstens, weil wir in diesem Jahr lange Zeit überhaupt kein Art-Team hatten. Zweitens, weil es doch viel Zeit und Arbeit kostet, das Artwork in die Infrastruktur zu integrieren. Mit dem neuen Konzept wurden die Dinge etwas einfacher. Grundsätzlich müssen wir nun lediglich die Farben und Formen des vorhandenen Artwork etwas verändern. Das von uns für dieses und die nächsten Releases genutzte Artwork wurde von Bob, einem professionellen Künstler, kreiert. Vielen Dank für deinen Beitrag!

### Unsere Ressourcen

[siduction Forum](http://siduction.org) 
[siduction Blog](http://news.siduction.org) 
[Git Archiv](http://git.siduction.org) 
[Distro News](http://siduction.org/)
[Bug-Tracker](http://bugs.siduction.org/projects/siduction/issues/new) 
[siduction-Map](http://bugs.siduction.org/projects/siduction/wiki/Map_Siduction) 
  
Support gibt es in unserem Forum und im IRC. Die Kanäle im OFTC Netzwerk sind  *#siduction-de*  für den deutschsprachigen Support und  *#siduction-core* , falls Du bei uns mitmachen oder uns helfen willst. Auf dem  Desktop findet sich außerdem ein Icon, mit dem man direkt in den Supportkanal gelangt, abhängig von dergewählten Systemsprache. 

Um auch als Testfeld für Debian dienen zu können, haben wir unseren eigenen  Bugtracker. Lass Dir kurz erklären, wie Du uns und Debian helfen kannst, zum Beispiel mit Bug-Reports zu kaputten Paketen. Erfahrene Nutzer werden wissen, wie sie Fehlerberichte direkt an Debians BTS (Bug Tracking System) geben können. Für nicht so erfahrene User haben wir  *reportbug-ng*  vorinstalliert.

Wenn Du denkst, einen Fehler in einem Debian-Paket gefunden zu haben, starte   *reportbug-ng*  und schreibe den Namen des Paketes in die Adresszeile oben. Die Anwendung wird nun die bereits bekannten Bugs durchstöbern und diese anzeigen. Jetzt ist es an Dir, zu bestimmen, ob "Dein" Fehler bereits bekannt ist oder ob es sich um einen bislang unbekannten Fehler handelt. Falls schon bekannt, überlege Dir, ob Du irgendwelche relevanten Information beisteuern kannst, oder vielleicht sogar einen Patch. Falls nicht, bist Du hier schon fertig. Wenn der Fehler noch nicht gemeldet wurde, und Du Dich nicht sonderlich gut mit dem BTS auskennst, kannst Du ihn in unserem [Bug-Tracker](http://bugs.siduction.org/projects/siduction/issues/new)  posten. Hier gehören auch grundsätzlich alle Fehler in siduction-eigenen Paketen hin. Wir sortieren die Fehler dann und packen sie an die richtige Stelle, falls sie reproduzierbar sind. Falls Dir das zu kompliziert ist, schreib einfach im Bug Thread in unserem Forum, das klappt noch mindestens bis zum endgültigen Release. 

  Über unseren Release-Zyklus können wir nur sagen, dass wir bemüht sind, mehrere Releases im Jahr zu schaffen.  Das kann jedoch, abhängig von der Entwicklung von siduction einerseits und Debian Unstable andererseits, stark schwanken.

  Da wir immer nach weiteren Helfern suchen, freuen wir uns, wenn Du Dich im IRC-Kanal  *#siduction-core*  einfindest und uns sagst, wobei Du dem Projekt helfen kannst und möchtest. Wie Du weiter unten bei den Danksagungen sehen kannst, haben wir derzeit  **kein Art-Team** . Wenn Du uns dort aushelfen kannst, wären wir hocherfreut.

### Hardware Tipps

Solltest Du eine ATI Radeon Grafikkarte besitzen, so benutze bitte beim Booten die "failsafe" Option. Diese Option hängt die Cheatcodes    *radeon.modeset=0 xmodule=vesa*  an die Kernel-Bootline an und gewährleistet das Booten nach X. Vor der Installation vom Live-ISO installiere bitte  *firmware-linux-nonfree* . Dazu öffne Deine  */etc/apt/sources.list.d/debian.list*  mit Deinem bevorzugten Editor als Root und hänge  *contrib non-free*  ans Ende der ersten Zeile. Speichern und dann: `apt-get update &amp;&amp; apt-get install firmware-linux-nonfree` Wenn Du jetzt siduction installierst, wird das  Paket mit in die Installation übernommen und gewährleistet, dass der Rechner beim Reboot nach der Installation nach X booten kann. Denk daran, dass, solltet ihr  vor der Installation rebooten, die Änderungen verloren sind.

Einige WLAN-Karten können nicht automatisch von den mitgelieferten freien Treibern unterstützt werden, daher startest Du am besten mit   kabelgebundenem Netz. Das Skript  *fw-detect*  liefert Informationen zur Einbindung entsprechender Firmware, der Installer führt dieses  Skript ebenfalls aus und leitet Dich bei der Installation der benötigten Firmware an.

Zum Schluss noch ein Hinweis für die Anwender des Hypervisors KVM. Das Frontend für die Kernel-basierte virtuelle Maschine KVM begann als   Fork von Qemu und ist nun mit allen Entwicklungen der letzten Jahre dorthin zurückgekehrt. Außerdem bewegt sich auf dem Feld der Virtualisation  eine ganze Menge. Deshalb gibt es auch viel Veraltetes dazu. Eine Anleitung zum neuen Quemu gibt es [in unserem Wiki](http://wiki.siduction.de/index.php?title=Virtualize_siduction_with_qemu-system-x86_64).

### Danksagung für siduction 2014.1.0

### Core Team:

Alf Gaida (agaida) 

Angelescu Ovidiu (convbsd) 

Axel Beu (ab) 

Ferdinand Thommes (devil) 

J. Theede (musca) 

Tom Wroblewski (GoingEasy9) 

Torsten Wohlfarth (towo) 

### Maintainer der siduction Desktop Environments:

 **Cinnamon** : J. Theede (musca)

 **GNOME** : Angelescu Ovidiu (convbsd)

 **KDE** : Ferdinand Thommes (devil), José Manuel Santamaría Lema (santa)

 **LXDE** : Alf Gaida (agaida)

 **LXQt** : Alf Gaida (agaida)

 **noX** : Alf Gaida (agaida)

 **XFCE** : Torsten Wolfahrt (towo)

 **XORG** : convbsd/agaida

### Art Team:

Bob 

Wir  **brauchen**  mehr Künstler für Release-Art

### Code, Ideen, Unterstützung:

ayla

bluelupo

der_bud

J. Hamatoma (hama)

Markus Schimpf (arno911)

bodhi 

### Danke!

Ebenso danken wir allen Testern und all den Leuten, die uns auf alle erdenklichen  Arten unterstützt haben. Dieses neue Release ist auch Euer Verdienst!

Wir danken auch  **Debian** , dessen Basis wir uns bedienen  
Im Namen des siduction Team:  
Ferdinand Thommes 
