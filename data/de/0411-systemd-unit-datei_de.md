% Systemd - Unit-Datei

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

Änderungen 2021-04:

+ Neu "systemd-unit"
+ Für die Verwendung mit pandoc optimiert.

ENDE   INFOBEREICH FÜR DIE AUTOREN

## systemd unit-Datei

Die grundlegenden und einführenden Informationen zu Systemd enthält die Handbuchseite [Systemd-Start](./systemd-start_de.md#systemd-der-system--und-dienste-manager)  
In der vorliegenden Handbuchseite erklären wir den Aufbau der **Unit-Dateien** und die generischen Sektionen "[Unit]" und "[Install]".

Die Unit-Datei ist eine reine Textdatei im INI-Format. Sie enthält Konfigurationsanweisungen von der Art "*Schlüssel=Wert*" in verschiedene Sektionen. Leere Zeilen und solche, die mit "#" oder ";" beginnen, werden ignoriert.
Alle Unit-Dateien müssen eine Sektion entsprechend des Unit Typ enthalten. Die generischen Sektionen "[Unit]" am Beginn und "[Install]" am Ende der Datei sind optional, wobei die Sektion "[Unit]" dringend empfohlen wird. 

### Ladepfad der Unit-Dateien

Die Ausgabe zeigt die Reihenfolge der Verzeichnisse, aus denen die Unit-Dateien geladen werden.

~~~
# systemd-analyze unit-paths
/etc/systemd/system.control
/run/systemd/system.control
/run/systemd/transient
/run/systemd/generator.early
/etc/systemd/system
/etc/systemd/system.attached
/run/systemd/system
/run/systemd/system.attached
/run/systemd/generator
/usr/local/lib/systemd/system
/lib/systemd/system
/usr/lib/systemd/system
/run/systemd/generator.late
~~~

Unit-Dateien, die in früher aufgeführten Verzeichnissen gefunden werden, setzen Dateien mit dem gleichen Namen in Verzeichnissen, die weiter unten in der Liste aufgeführt sind, außer Kraft. So hat eine Datei in "/etc/systemd/system" Vorrang vor der gleichnamigen in "/lib/systemd/system".

Nur ein Teil der zuvor aufgeführten Verzeichnisse existiert per default in siduction. Die Verzeichnisse 

+ **/lib/systemd/system/**  
  beinhalten System-Units, die durch den Paketverwalter der Distribution installiert wurden und ggf. vom Administrator erstellte Unit-Dateien.  
+ **/etc/systemd/system/**  
  beinhalten Symlinks auf Unit-Dateien in */lib/systemd/system/* für aktivierte Units und ggf. vom Administrator erstellte Unit-Dateien.  
+ **/usr/local/lib/systemd/system/**  
  dieses Verzeichnis muss erstellt werden und ist für vom Administrator erstellte Unit-Dateien vorgesehen.  
+ **/run/systemd/**  
  beinhalten Laufzeit-Units und dynamische Konfiguration für flüchtige Units. Für den Administrator hat dieses Verzeichnis ausschließlich informellen Wert.

Wir empfehlen eigene Unit-Dateien in */usr/local/lib/systemd/system/* abzulegen.

### Aktivierung der Unit-Datei

Um systemd die Konfiguration einer Unit zugänglich zu machen, muss die Unit-Datei aktiviert werden. Dies geschieht mit dem Aufruf:

~~~
# systemctl daemon-reload
# systemctl enable --now <UNIT_DATEI>
~~~

Der erste Befehl lädt die komplette Daemon-Konfiguration neu, der zweite startet die Unit <UNIT_DATEI> sofort (Option "--now") und gliedert sie in systemd ein, sodass sie bei jedem Neustart des PC ausgeführt wird.  
Der Befehl

~~~
# systemctl disable <UNIT_DATEI>
~~~

bewirkt, dass sie nicht mehr bei jedem Neustart des PC ausgeführt wird. Sie kann aber weiterhin manuell mit dem Befehl **`systemctl start <UNIT_DATEI>`** gestartet und mit **`systemctl stop <UNIT_DATEI>`** gestopt werden.  
Falls eine Unit-Datei leer ist (d.h. die Größe 0 hat) oder ein Symlink auf */dev/null* ist, wird ihre Konfiguration nicht geladen und sie erscheint mit einem Ladezustand "masked" und kann nicht aktiviert werden. Dies ist eine wirksame Methode um eine Unit komplett zu deaktivieren und es auch unmöglich zu machen, sie manuell zu starten.

### Sektionen der Unit-Datei

Die Unit-Datei besteht in der Regel aus der Sektionen [Unit], der Typ spezifischen Sektion und der Sektion [Install]. Die Typ spezifische Sektion fließt als Suffix in den Dateinamen ein. So besitzt zum Beispiel eine Unit-Datei, die einen Zeitgeber konfiguriert, immer die Endung "*.timer*" und muss "[Timer]" als Typ spezifische Sektion enthalten.

#### Sektion Unit

Diese Sektion enhält allgemeine Informationen über die Unit, definiert Abhängigkeiten zu anderen Units, wertet Bedingungen aus und sorgt für die Einreihung in den Bootprozess.

1. Allgemeine Optionen

    a. "*Description=*"  
       Identifiziert die Unit durch einen menschenlesbaren Namen, der von systemd als Bezeichnung für die Unit verwandt wird und somit im systemjournal erscheint ("Starting *description*...") und dort als Suchmuster verwand werden kann.

    b. "*Documentation=*"  
       Ein Verweis auf eine Datei oder Webseite, die Dokumentation für diese Unit oder ihre Konfiguration referenzieren. Z. B.: "Documentation=man:cupsd(8)" oder "Documentation=http://www.cups.org/doc/man-cupsd.html".

2. Bindungsabhängigkeiten zu anderen Units

    a. "*Wants=*"  
       Hier aufgeführte Units werden mit der konfigurierten Unit gestartet.

    b. "*Requires=*"  
       Ähnlich zu *Wants=*, erklärt aber eine stärkerere Bindung an die aufgeführten Units.  
       Wenn diese Unit aktiviert wird, werden die aufgeführten Units ebenfalls aktiviert.  
       Schlägt die Aktivierung einer der anderen Units fehl **und** die Ordnungsabhängigkeit *After=* ist auf die fehlgeschlagene Unit gesetzt, dann wird diese Unit nicht gestartet.  
       Falls eine der anderen Units inaktiv wird, bleibt diese Unit aktiv, nur wenn eine der anderen Units gestoppt wird, wird diese Unit auch gestoppt.

    c. "*Requisite=*"  
       Ähnlich zu *Requires=*. Der Start dieser Unit wird sofort fehlschlagen, wenn die hier aufgeführten Units noch nicht gestartet wurden. *Requisite=* sollte mit der Ordnungsabhängigkeit *After=* kombiniert werden, um sicherzustellen, dass diese Unit nicht vor der anderen Unit gestartet wird.

    d. "*BindsTo=*"  
       *BindsTo=* ist der stärkste Abhängigkeitstyp: Es bewirkt zusätzlich zu den Eigenschaften von *Requires=*, dass die gebundene Unit im aktiven Status sein muss, damit diese Unit auch aktiv sein kann.  
       Beim Stoppen oder inaktivem Zustand der gebundenen Unit wird diese Unit immer gestoppt.  
       Um zu verhindern, dass der Start dieser Unit fehlschlägt, wenn die gebundene Unit nicht, oder noch nicht, in einem aktiven Zustand ist, sollte *BindsTo=* am besten mit der Ordnungsabhängigkeit *After=* kombiniert werden.

    e. "*PartOf=*"  
       Ähnlich zu *Requires=*, aber begrenzt auf das Stoppen und Neustarten von Units.  
       Wenn Systemd die hier aufgeführten Units stoppt oder neustartet, wird die Aktion zu dieser Unit weitergeleitet.  
       Das ist eine Einwegeabhängigkeit. Änderungen an dieser Unit betreffen nicht die aufgeführten Units.

    f. "*Conflicts=*"  
       Deklariert negative Anforderungsabhängigkeiten. Die Angabe einer durch Leerzeichen getrennten Liste ist möglich.  
       *Conflicts=* bewirkt, dass die aufgeführte Unit gestoppt wird, wenn diese Unit startet und umgekehrt.  
       Da *Conflicts=* keine Ordnungsabhängigkeit beinhaltet, muss eine Abhängigkeit *After=* oder *Before=* erklärt werden, um sicherzustellen, dass die in Konflikt stehende Unit gestoppt wird, bevor die andere Unit gestartet wird.

3. Ordnungsabhängigkeiten zu anderen Units

    a. "*Before=*"  
       Diese Einstellung konfiguriert Ordnungsabhängigkeiten zwischen Units. *Before=* stellt sicher, dass die aufgeführte Unit erst mit dem Starten beginnt, nachdem der Start der konfigurierte Unit abgeschlossen ist.  
       Die Angabe einer durch Leerzeichen getrennten Liste ist möglich.

    b. "*After=*"  
       Diese Einstellung stellt das Gegenteil von *Before=* sicher. Die aufgeführte Unit muss vollständig gestartet sein, bevor die konfigurierte Unit gestartet wird.

    c. "*OnFailure=*"  
       Units, die aktiviert werden, wenn diese Unit den Zustand »failed« einnimmt.

4. Bedingungen  
   Unit-Dateien können auch eine Reihe von Bedingungen enthalten.  
   Bevor die Unit gestartet wird, wird Systemd nachweisen, dass die festgelegten Bedingungen wahr sind. Falls nicht, wird das Starten der Unit (fast ohne Ausgabe) übersprungen.  
   Fehlschlagende Bedingungen führen nicht dazu, dass die Unit in den Zustand »failed« überführt wird.  
   Falls mehrere Bedingungen festgelegt sind, wird die Unit ausgeführt, falls alle von ihnen zutreffen.  
   In diesem Abschnitt führen wir nur Bedingungen auf, die uns für selbst erstellte Units hilfreich erscheinen, denn viele Bedingungen dienen dazu, um Units zu überspringen, die auf dem lokalen System nicht zutreffen.  
   Der Befehl **`systemd-analyze verify <UNIT_DATEI>`** kann zum Testen von Bedingungen verwandt werden.

   a. "*ConditionVirtualization=*"  
      Prüft, ob das System in einer virtualisierten Umgebung ausgeführt wird und testet optional, ob es eine bestimmte Implementierung ist.

   b. "*ConditionACPower=*"  
      Prüft, ob das System zum Zeitpunkt der Aktivierung der Unit am Netz hängt oder ausschließlich über Akku läuft.

   c. "*ConditionPathExists=*"  
      Prüft auf die Existenz einer Datei. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

   d. "*ConditionPathExistsGlob=*"  
      Wie zuvor, nur dass ein Suchmuster angegeben wird. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

   e. "*ConditionPathIsDirectory=*"  
      Prüft auf die Existenz eines Verzeichnisses. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

   f. "*ConditionPathIsSymbolicLink=*"  
      Überprüft ob ein bestimmter Pfad existiert und ein symbolischer Link ist. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

   g. "*ConditionPathIsMountPoint=*"  
      Überprüft ob ein bestimmter Pfad existiert und ein Einhängepunkt ist. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

   h. "*ConditionPathIsReadWrite=*"  
      Überprüft ob das zugrundeliegende Dateisystem les- und schreibbar ist. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

   i. "*ConditionDirectoryNotEmpty=*"  
      Überprüft ob ein bestimmter Pfad existiert und ein nicht leeres Verzeichnis ist. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

   j. "*ConditionFileNotEmpty=*"  
      Überprüft ob ein bestimmter Pfad existiert und sich auf eine normale Datei mit einer von Null verschiedenen Größe bezieht. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

   k. "*ConditionFileIsExecutable=*"  
      Überprüft ob ein bestimmter Pfad existiert und sich auf eine normale, als ausführbar gekennzeichnete Datei bezieht. Mit einem Ausrufezeichen ("!") vor dem Pfad wird der Test negiert.

Die vollständige Dokumentation zu allen Optionen der Sektion "[Unit]" bitte in der [Deutschen Manpage, systemd.unit](https://manpages.debian.org/testing/manpages-de/systemd.unit.5.de.html) nachlesen.

#### Typ spezifische Sektion

Diese Sektion enthält die speziellen Optionen der elf möglichen Typen. Ausführliche Beschreibungen enthalten die verlinkten Handbuchseiten, oder ersatzweise die jeweilige deutsche Manpage.

+ [[Service]](./systemd-service_de.md#systemd-service)konfiguriert einen Dienst

+ [[Socket]](https://manpages.debian.org/testing/manpages-de/systemd.socket.5.de.html) konfiguriert ein Socket

+ [[Device]](https://manpages.debian.org/testing/manpages-de/systemd.device.5.de.html) konfiguriert ein Gerät

+ [[Mount]](./systemd-mount_de.md#systemd-mount)konfiguriert einen Einhängepunkt

+ [[Automount]](./systemd-mount_de.md#systemd-mount)konfiguriert einen Selbsteinhängepunkt

+ [[Swap]](https://manpages.debian.org/testing/manpages-de/systemd.swap.5.de.html) konfiguriert eine Auslagerungsdatei oder -partition

+ [[Target]](./systemd-target_de.md#systemd-target---ziel-unit)konfiguriert ein Startziel

+ [[Path]](./systemd-path_de.md#systemd-path)konfiguriert einen überwachten Dateipfad

+ [[Timer]](./systemd-timer_de.md#systemd-timer)konfiguriert einen von systemd gesteuerten und überwachten Zeitgeber

+ [[Slice]](https://manpages.debian.org/testing/manpages-de/systemd.slice.5.de.html) konfiguriert eine Ressourcenverwaltungsscheibe

+ [[Scope]](https://manpages.debian.org/testing/manpages-de/systemd.scope.5.de.html) konfiguriert eine Gruppe von extern erstellten Prozessen.

#### Sektion Install

Unit-Dateien können diese Sektion enthalten.  
Die Optionen der *[Install]*-Sektion werden von den Befehlen **`systemctl enable <UNIT_DATEI>`** und **`systemctl disable <UNIT_DATEI>`** während der Installation einer Unit verwandt.  
Unit-Dateien ohne *[Install]*-Sektion lassen sich manuell mit dem Befehl **`systemctl start <UNIT_DATEI>`**, oder von einer anderen Unit-Datei starten.

Beschreibung der Optionen:

+ "*Alias=*"  
  Eine Liste von zusätzlichen Namen, unter der diese Unit installiert werden soll. Die hier aufgeführten Namen müssen die gleiche Endung wie die Unit-Datei haben.

+ "*WantedBy=*"  
  Diese Option kann mehrfach verwendet werden oder eine durch Leerzeichen getrennte Liste enthalten.  
  Im .wants/-Verzeichnis jeder der aufgeführten Units wird bei der Installation ein symbolischer Link erstellt. Dadurch wird eine Abhängigkeit vom Typ *Wants=* von der aufgeführten Unit zu der aktuellen Unit hinzugefügt. Das Hauptergebnis besteht darin, dass die aktuelle Unit gestartet wird, wenn die aufgeführte Unit gestartet wird.  
  Verhält sich wie die Option *Wants=* in der Sektion *[Unit]*.

  Beispiel:  
  WantedBy=graphical.target

  Das teilt systemd mit, die Unit beim Starten von graphical.target (früher "init 5") hereinzuziehen. 

+ "*RequiredBy=*"  
  Diese Option kann mehrfach verwendet werden oder eine durch Leerzeichen getrennte Liste enthalten.  
  Im .requires/-Verzeichnis jeder der aufgeführten Units wird bei der Installation ein symbolischer Link erstellt. Dadurch wird eine Abhängigkeit vom Typ *Requires=* von der aufgeführten Unit zu der aktuellen Unit hinzugefügt. Das Hauptergebnis besteht darin, dass die aktuelle Unit gestartet wird, wenn die aufgeführte Unit gestartet wird.  
  Verhält sich wie die Option *Requires=* in der Sektion *[Unit]*.

+ "*Also=*"  
  Zusätzliche Units, die installiert/deinstalliert werden sollen, wenn diese Unit installiert/deinstalliert wird.

+ "*DefaultInstance=*"  
  Diese Option zeigt nur bei Vorlagen-Unit-Dateien Wirkung.  
  Deklariert, welche Instanz der Unit freigegeben werden soll. Die angegebene Zeichenkette muss zur Identifizierung einer Instanz geeignet sein.

Hinweis:
Um die Konfiguration einer Unit-Datei zu prüfen, eignet sich der Befehl **`systemd-analyze verify <UNIT_DATEI>`**.

### Beispiel cupsd

Der *cupsd*, Auftragsplaner (Scheduler) für das Common UNIX Printing System, wird von systemd mit seinen drei Unit Dateien "*cups.socket*", "*cups.service*" und "*cups.path*" gesteuert und eignet sich gut, um die Abhängigkeiten zu verdeutlichen.  
Hier die drei Dateien.

~~~
Datei /lib/systemd/system/cups.service:

[Unit]
Description=CUPS Scheduler
Documentation=man:cupsd(8)
After=network.target sssd.service ypbind.service nslcd.service
Requires=cups.socket
    After=cups.socket (nicht in der Datei, da implizit vorhanden.)
    After=cups.path   (nicht in der Datei, da implizit vorhanden.)

[Service]
ExecStart=/usr/sbin/cupsd -l
Type=notify
Restart=on-failure

[Install]
Also=cups.socket cups.path
WantedBy=printer.target
~~~

~~~
Datei /lib/systemd/system/cups.path:

[Unit]
Description=CUPS Scheduler
PartOf=cups.service
    Before=cups.service (nicht in der Datei, da implizit vorhanden.)

[Path]
PathExists=/var/cache/cups/org.cups.cupsd

[Install]
WantedBy=multi-user.target
~~~

~~~
Datei /lib/systemd/system/cups.socket:

[Unit]
Description=CUPS Scheduler
PartOf=cups.service
    Before=cups.service (nicht in der Datei, da implizit vorhanden.)

[Socket]
ListenStream=/run/cups/cups.sock

[Install]
WantedBy=sockets.target
~~~

**Die Sektion [Unit]**  
enthält für alle drei Dateien die gleiche Beschreibung. Die Dateien *cups.path* und *cups.socket* zusätzlich die  Bindungsabhängigkeit *PartOf=cups.service*, was bedeutet, dass diese zwei Units abhängig von *cups.service* gestoppt oder neu gestartet werden.  
Die socket-Unit ebenso wie die path-Unit schließen die Ordnungsabhängigkeit "Before=" zu ihrer namensgleichen service-Unit ein. Deshalb ist es nicht notwendig in der *cups.service*-Unit die Ordnungsabhängigkeiten "After=cups.socket" und "After=cups.path" einzutragen. (Siehe unten die Ausgabe von "systemd-analyze dump" mit dem Vermerk "destination-implicit".) Beide Abhängigkeiten gemeinsam bewirken, dass unabhängig davon welche Unit zuerst startet, immer alle drei Units starten und die *cups.service*-Unit erst, nachdem der Start der *cups.path*-Unit und der *cups.socket*-Unit erfolgreich abgeschlossen wurde.

Die vollständige Konfiguration der Units erhalten wir mit dem Befehl **`systemd-analyze dump`**, der eine sehr, sehr lange Liste ( > 32000 Zeilen) des systemd Serverstatus ausgibt. 

~~~
# systemd-analyze dump
[...]
-> Unit cups.service:
    Description: CUPS Scheduler.service
    [...]
    WantedBy: printer.target (destination-file)
    ConsistsOf: cups.socket (destination-file)
    ConsistsOf: cups.path (destination-file)
    Before: printer.target (destination-default)
    After: cups.socket (destination-implicit)
    After: cups.path (destination-implicit)
[...]
-> Unit printer.target:
    Description: Printer
    [...]
    Wants: cups.service (origin-file)
    After: cups.service (origin-default)
[...]
~~~

**Die Sektion [Install]**  
der *cups.service*-Unit enthält mit der Option "Also=cups.socket cups.path" die Anweisung, diese beiden Units auch zu installieren und alle drei Units haben unterschiedliche "WantedBy=" Optionen:

+ cups.socket:  WantedBy=sockets.target  
+ cups.path:    WantedBy=multi-user.target  
+ cups.service: WantedBy=printer.target

Um zu verstehen, warum unterschiedliche Werte für die Option "WantedBy=" Verwendung finden, benötigen wir zusätzliche Informationen, die wir mit den Befehlen *systemd-analyze dot* und *systemd-analyze plot* erhalten.

~~~
$ systemd-analyze dot --to-pattern='*.target' --from-pattern=\
    '*.target' | dot -Tsvg > targets.svg

$ systemd-analyze plot > bootup.svg
~~~

Der erste liefert uns ein Flussdiagramm mit den Abhängigkeiten der verschiedenen *Targets* zueinander und der zweite eine graphisch aufbereitete Auflistung des Bootprozesses mit den Zeitpunkten wann ein Prozess gestartet wurde, welche Zeit er beanspruchte und seinen Aktivitätszustand.

Der *targets.svg* und der *bootup.svg* entnehmen wir, dass

1.  **sysinit.target**  
    aktiviert wird und

2.  **basic.target**  
    erst startet, wenn *sysinit.target* erreicht wurde.

    1.  **sockets.target**  
        von *basic.target* angefordert wird,

        1.   **cups.socket**  
              und alle weiteren *.socket*-Units von *sockets.target* hereingeholt werden.

    2.  **paths.target**  
        von *basic.target* angefordert wird,

        1.   **cups.path**  
              und alle weiteren *.path*-Units von *paths.target* hereingeholt werden.

3.  **network.target**  
    erst startet, wenn *basic.target* erreicht wurde.

4.  **cups.service**  
    erst startet, wenn *network.target* erreicht wurde.

5.  **multi-user.target**  
    erst startet, wenn *network.target* erreicht wurde.

6.  **multi-user.target**  
    erst dann erreicht wird, wenn *cups.service* erfolgreich gestartet wurde.  
    (Genau genommen liegt es daran, dass der *cups-browsed.service*, der vom  
    *cups.service* abhängt, erfolgreich gestartet sein muss.)

6.  **printer.target**  
    wird erst aktiv, wenn Systemd dynamisch Geräte-Units für die Drucker generiert.  
    Dazu müssen die Drucker angeschlossen und eingeschaltet sein.

Weiter oben stellten wir fest, dass der Start einer *cups.xxx*-Unit ausreicht, um alle drei Units hereinzuholen. Betrachten wir noch einmal die "WantedBy="-Optionen in der [Install]-Sektion, so haben wir die *cups.socket*-Unit, die über das *sockets.target* bereits während des *basic.target* hereingeholt wird, die *cups.path*-Unit, die während des *multi-user.target* hereingeholt wird und den *cups.service*, der vom *printer.target* hereingeholt wird.  
Während des gesamten Bootprozesses werden die drei *cups.xxx*-Units wiederholt bei systemd zur Aktivierung angefordert. Das härtet den *cupsd* gegen unvorhergesehene Fehler, spielt für systemd aber keine Rolle, denn es ist unerheblich wie oft ein Service angefordert wird, wenn er sich in der Warteschlange befindet.  
Zusätzlich fordert immer dann das *printer.target* den *cups.service* an, wenn ein Drucker neu von systemd erkannt wird.

### Werkzeuge

Systemd beinhaltet einige nützliche Werkzeuge für die Analyse, Prüfung und Bearbeitung der Unit-Dateien.  
Bitte auch die Manpages [systemd-analyze](https://manpages.debian.org/testing/manpages-de/systemd-analyze.1.de.html)  und [systemctl](https://manpages.debian.org/testing/manpages-de/systemctl.1.de.html) zu Rate ziehen.


+ edit

  ~~~
  # systemctl edit <UNIT_DATEI>
  # systemctl edit --full <UNIT_DATEI>
  # systemctl edit --full --force <UNIT_DATEI>
  ~~~

  *systemctl edit* öffnet die ausgewählte Unit-Datei im konfigurierten Editor.

  **systemctl edit <UNIT_DATEI>** erstellt unterhalb */etc/systemd/system/* ein neues Verzeichnis mit dem Namen "\<UNIT_DATEI\>.d" und darin die Datei "override.conf", die ausschließlich die Änderungen gegenüber der ursprünglichen Unit-Datei enthält. Dies gilt für alle Unit-Dateien in den Verzeichnissen, die in der [Hirarchie der Ladepfade](#ladepfad-der-unit-dateien) inklusive */etc/systemd/system/* abwärts eingetragen sind.

  **systemctl edit - -full <UNIT_DATEI>** erstellt eine neue, namensgleiche Datei im Verzeichnis */etc/systemd/system/*. Dies gilt für alle Unit-Dateien in den Verzeichnissen, die in der [Hirarchie der Ladepfade](#ladepfad-der-unit-dateien) unterhalb */etc/systemd/system/* eingetragen sind. Dateien, die sich bereits im Verzeichnis */etc/systemd/system/* befinden, werden überschrieben.

  **systemctl edit - -full - -force <UNIT_DATEI>** erstellt eine neue Datei im Verzeichnis */etc/systemd/system/*. Ohne die Option *- -full* würde nur eine Datei "override.conf" im neuen Verzeichnis */etc/systemd/system/\<UNIT_DATEI\>.d* generiert, der die zugehörige Unit-Datei fehlt.

  Wird der Editor beendet, so führt systemd automatisch den Befehl **`systemctl daemon-reload`** aus.

+ revert

  ~~~
  # systemctl revert <UNIT_DATEI>
  ~~~

  macht die mit *systemctl edit* und *systemctl edit - -full* vorgenommenen Änderungen an Unit-Dateien rückgängig. Dies gilt nicht für geänderte Unit-Dateien die sich bereits im Verzeichnis */etc/systemd/system/* befanden.  
  Zusätzlich bewirkt der Befehl die Rücknahme der mit *systemctl mask* vorgenommenen Änderungen.

+ daemon-reload

  ~~~
  # systemctl daemon-reload
  ~~~

  Lädt die Systemverwalterkonfiguration neu. Dies führt alle Generatoren neu aus, lädt alle Unit-Dateien neu und erstellt den gesamten Abhängigkeitsbaum neu.

+ cat

  ~~~
  $ systemctl cat <UNIT_DATEI>
  ~~~

  Gibt entsprechend des Konsolebefehls *cat* den Inhalt der Unit-Datei und aller zugehörigen Änderungen aus.

+ analyze verify

  ~~~
  $ systemd-analyze verify <UNIT_DATEI>
  ~~~

  überprüft die Konfigurationseinstellungen einer Unit-Datei und gibt Hinweise aus. Dies ist ein sehr hilfreicher Befehl um die Konfiguration selbst erstellter oder geänderter Unit-Dateien zu prüfen.

+ systemd-delta

  ~~~
  $ systemd-delta
  ~~~

  präsentiert in der Ausgabe Unit-Dateien und die vorgenommenen Änderungen an ihnen. Das Schlüsselwort am Anfang der Zeile definiert die Art der Änderung bzw. Konfiguration.  
  Hier ein Beispiel:

  ~~~
  $ systemd-delta --no-pager
  [MASKED]     /etc/sysctl.d/50-coredump.conf → /usr/lib/sysctl.d/50-coredump.conf
  [OVERRIDDEN] /etc/tmpfiles.d/screen-cleanup.conf → /usr/lib/tmpfiles.d/screen-cleanup.conf
  [MASKED]     /etc/systemd/system/NetworkManager-wait-online.service → /lib/systemd/system/NetworkManager-wait-online.service
  [EQUIVALENT] /etc/systemd/system/tmp.mount → /lib/systemd/system/tmp.mount
  [EXTENDED]   /lib/systemd/system/rc-local.service → /lib/systemd/system/rc-local.service.d/debian.conf
  [EXTENDED]   /lib/systemd/system/systemd-localed.service → /lib/systemd/system/systemd-localed.service.d/locale-gen.conf

  6 overridden configuration files found.
  ~~~

+ analyze dump

  ~~~
  $ systemd-analyze dump > systemd_dump.txt
  ~~~

  erstellt die Textdatei *systemd_dump.txt* mit der vollständigen Konfiguration alle Units des systemd. Die sehr lange Textdatei gibt Aufschluss über alle Konfigurationseinstellungen aller systemd-Units und lässt sich mit einem Texteditor und unter Verwendung von RegEx-Pattern gut durchsuchen.

+ analyze plot

  ~~~
  $ systemd-analyze plot > bootup.svg
  ~~~

  erstellt die Datei *bootup.svg* mit der zeitlichen Abfolge des Bootprozesses. Es ist eine graphisch aufbereitete Auflistung des Bootprozesses mit den Start- und Endzeitpunkten aller Units, welche Zeit sie beanspruchten und ihren Aktivitätszuständen.

+ analyze dot

  ~~~
  $ systemd-analyze dot --to-pattern='*.target' --from-pattern=\
    '*.target' | dot -Tsvg > targets.svg
    Color legend: black     = Requires
                  dark blue = Requisite
                  dark grey = Wants
                  red       = Conflicts
                  green     = After
  ~~~

  erstellt das Flussdiagramm *targets.svg*, dass die Abhängigkeiten der im Bootprozess verwendeten Targets darstellt. Die Beziehungen der *.target*-Units werden zur besseren Übersicht farblich dargestellt.

Die hier genannten Hilfsmittel stellen nur einen Teil der mit systemd ausgelieferten Werkzeuge dar. Bitte entnehme den man-Pages die vollständige Dokumentation.

### Quellen systemd-unit-Datei

[Deutsche Manpage, systemd.unit](https://manpages.debian.org/testing/manpages-de/systemd.unit.5.de.html)  
[Deutsche Manpage, systemd.syntax](https://manpages.debian.org/testing/manpages-de/systemd.syntax.7.de.html)  
[Deutsche Manpage, systemd.device](https://manpages.debian.org/testing/manpages-de/systemd.device.5.de.html)  
[Deutsche Manpage, systemd.scope](https://manpages.debian.org/testing/manpages-de/systemd.scope.5.de.html)  
[Deutsche Manpage, systemd.slice](https://manpages.debian.org/testing/manpages-de/systemd.slice.5.de.html)  
[Deutsche Manpage, systemd.socket](https://manpages.debian.org/testing/manpages-de/systemd.socket.5.de.html)  
[Deutsche Manpage, systemd.swap](https://manpages.debian.org/testing/manpages-de/systemd.swap.5.de.html)  
[Deutsche Manpage, systemd-analyze](https://manpages.debian.org/testing/manpages-de/systemd-analyze.1.de.html)  
[Deutsche Manpage, systemctl](https://manpages.debian.org/testing/manpages-de/systemctl.1.de.html)

Dank an Helge Kreuzmann für die deutschen Übersetzungen.

<div id="rev">Seite zuletzt aktualisert 2021-05-05</div>
