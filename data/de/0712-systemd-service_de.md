% Systemd - service

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

Änderungen 2021-04:

+ Neu "systemd-service"
+ Für die Verwendung mit pandoc optimiert.

ENDE   INFOBEREICH FÜR DIE AUTOREN

## systemd-service

Die grundlegenden und einführenden Informationen zu Systemd enthält die Handbuchseite [Systemd-Start](./0710-systemd-start_de.md#systemd-der-system--und-dienste-manager) Die alle Unit-Dateien betreffenden Sektionen *[Unit]* und *[Install]* behandelt unsere Handbuchseite [Systemd Unit-Datei](./0711-systemd-unit-datei_de.md#systemd-unit-datei)  
In der vorliegenden Handbuchseite erklären wir die Funktion der Unit **systemd.service**. Die Unit-Datei mit der Namensendung ".service" ist der am häufigsten anzutreffende Unit-Typ in systemd.

Die Servic-Unit-Datei muss eine Sektion [Service] enthalten, die Informationen über den Dienst und den Prozess, den er überwacht, konfiguriert. 

### service-Unit anlegen

Selbst erstellte Unit-Dateien legen wir vorzugsweise im Verzeichnis */usr/local/lib/systemd/system/* ab. (Ggf. ist das Verzeichnis mit dem Befehl **`mkdir -p /usr/local/lib/systemd/system/`** anzulegen.) Das hat den Vorteil, dass sie Vorrang gegenüber den System-Units, die durch den Paketverwalter der Distribution installiert wurden, erhalten und gleichzeitig Steuerungslinks sowie Änderungsdateien, die mit **`systemctl edit <UNIT_DATEI>`** erzeugt wurden, im seinerseits vorrangigen Verzeichnis */etc/systemd/system/* abgelegt werden. Siehe: [Hirarchie der Ladepfade](./systemd-unit-datei_de.htm#ladepfad-der-unit-dateien).
 
### Sektion Service

Für diese Sektion sind über dreißig Optionen verfügbar, von denen wir hier besonders häufig verwendete beschreiben.

---               ----
Type=             PIDFile=
RemainAfterExit=  GuessMainPID=
ExecStart=        Restart=
ExecStartPre=     RestartSec=
ExecStartPost=    SuccessExitStatus=
ExecCondition=    RestartPreventExitStatus=
ExecReload=       RestartForceExitStatus=
ExecStop=         NonBlocking=
ExecStopPost=     NotifyAccess=
TimeoutStopSec=   RootDirectoryStartOnly=
TimeoutStartSec=  FileDescriptorStoreMax=
TimeoutAbortSec=  USBFunctionDescriptors=
TimeoutSec=       USBFunctionStrings=
RuntimeMaxSec=    Sockets=
WatchdogSec=      BusName=
                  OOMPolicy=
---               ----

+ **Type=**  
    Definiert den Prozessstarttyp und ist damit eine der wichtigsten Optionen.  
    Die möglichen Werte sind: simple, exec, forking, oneshot, dbus, notify oder idle.  
    Der Standard *simple* wird verwendet, falls *ExecStart=* festgelegt ist, aber weder *Type=* noch *BusName=* gesetzt sind.

    + **simple**  
        Eine Unit vom Typ *simple* betrachtet systemd als erfolgreich gestartet, sobald der mit *ExecStart=* festgelegte Hauptprozess mittels *fork* gestartet wurde. Anschließend beginnt systemd sofort mit dem Starten von nachfolgenden Units, unabhängig davon, ob der Hauptprozess erfolgreich aufgerufen werden kann.

    + **exec**  
        Ähnelt *simple*, jedoch wartet systemd mit dem Starten von nachfolgenden Units bis der Hauptprozess erfolgreich beendet wurde. Das ist auch der Zeitpunkt, an dem die Unit den Zustand "active" erreicht.

    + **forking**  
        Hier betrachtet systemd den Dienst als gestartet, sobald der mit *ExecStart=* festgelegte Prozess sich in den Hintergrund verzweigt und das übergeordnete System sich beendet. Dieser Typ findet oft bei klassischen Daemons Anwendung. Hier sollte auch die Option *PIDFile=* angeben werden, damit das System den Hauptprozess weiter verfolgen kann.

    + **oneshot**  
        Ähnelt *exec*. Die Option *Type=oneshot* kommt oft bei Skripten oder Befehlen zum Einsatz, die einen einzelnen Job erledigen und sich dann beenden. Allerdings erreicht der Dienst niemals den Zustand "active", sondern geht sofort, nachdem sich der Hauptprozess beendet hat, vom Zustand "activating" zu "deactivating" oder "dead" über. Deshalb ist es häufig sinnvoll diese Option mit "RemainAfterExit=yes" zu verwenden, um den Zustand "active" zu erreichen.

    + **dbus**  
        Verhält sich ähnlich zu *simple*, systemd startet nachfolgende Units, nachdem der D-Bus-Busname erlangt wurde. Units mit dieser Option, erhalten implizit eine Abhängigkeit auf die Unit "dbus.socket".

    + **notify**  
        Der Type=notify entspricht weitestgehend dem Type *simple*, mit dem Unterschied, dass der Daemon ein Signal an systemd sendet, wenn er bereitsteht.

    + **idle**  
        Das Verhalten von *idle* ist sehr ähnlich zu *simple*; allerdings verzögert systemd die tatsächliche Ausführung des Dienstes, bis alle aktiven Aufträge erledigt sind. Dieser Typ ist nicht als allgemeines Werkzeug zum Sortieren von Units nützlich, denn er unterliegt einer Zeitüberschreitung von 5 s, nach der der Dienst auf jeden Fall ausgeführt wird.

+ **RemainAfterExit=**  
    Erwartet einen logischen Wert (Standard: *no*), der festlegt, ob der Dienst, selbst wenn sich alle seine Prozesse beendet haben, als aktiv betrachtet werden sollte. Siehe *Type=oneshot*.

+ **GuessMainPID=**  
    Erwartet einen logischen Wert (Standard: *yes*). Systemd verwendet diese Option ausschließlich, wenn *Type=forking* gesetzt und *PIDFile=* nicht gesetzt ist, und versucht dann die Haupt-PID eines Dienstes zu raten, falls es sie nicht zuverlässig bestimmen kann. Für andere Typen oder mit gesetzter Option *PIDFile=* ist die Haupt-PID immer bekannt.

+ **PIDFile=**  
    Akzeptiert einen Pfad zur PID-Datei des Dienstes. Für Dienste vom *Type=forking* wird die Verwendung dieser Option empfohlen. 

+ **BusName=**  
    Hier ist der D-Bus-Busname, unter dem dieser Dienst erreichbar ist, anzugeben. Die Option ist für Dienste vom *Type=dbus* verpflichtend.

+ **ExecStart=**  
    Enthält Befehle mit ihren Argumenten, die ausgeführt werden, wenn diese Unit gestartet wird. Es muss genau ein Befehl angegeben werden, außer die Option *Type=oneshot* ist gesetzt, dann kann *ExecStart=* mehrfach verwendet werden. Der Wert von *ExecStart=* muss den in der deutsche Manpage [systemd.service](https://manpages.debian.org/testing/manpages-de/systemd.service.5.de.html) detailliert beschriebenen Regeln entsprechen.

+ **ExecStop=**  
    Kann mehrfach verwendet werden und enthält Befehle, die dem Stoppen eines mittels *ExecStart=* gestarteten Dienstes, dienen. Die Syntax ist identisch zu *ExecStart=*.

+ **ExecStartPre=, ExecStartPost=, ExecStopPost=**  
    Zusätzliche Befehle, die vor bzw. nach dem Befehl in *ExecStart=* oder *ExecStop* gestartet werden. Auch hier ist die Syntax identisch zu *ExecStart=*. Es sind mehrere Befehlszeilen erlaubt und die Befehle werden seriell einer nach dem anderen ausgeführt. Falls einer dieser Befehle (dem nicht "-" vorangestellt ist) fehlschlägt, wird die Unit sofort als fehlgeschlagen betrachtet.

+ **RestartSec=**  
    Bestimmt die vor dem Neustart eines Dienstes zu schlafende Zeit. Eine einheitenfreie Ganzzahl definiert Sekunden, eine Angabe von "3min 4s" ist auch möglich.  
    Die Art der Zeitwertdefinition gilt für alle zeitgesteuerten Optionen.

+ **TimeoutStartSec=, TimeoutStopSec=, TimeoutSec=**  
    Bestimmt die Zeit, die auf das Starten bzw. Stoppen gewartet werden soll. *TimeoutSec=* vereint die beiden zuvor genannten Optionen.  
    *TimeoutStopSec=* konfiguriert zusätzlich die Zeit, die, soweit vorhanden, für jeden *ExecStop=*-Befehl gewartet werden soll.

+ **Restart=**  
    Konfiguriert, ob der Dienst neu gestartet werden soll, wenn der Diensteprozess sich beendet, getötet oder eine Zeitüberschreitung erreicht wird. Wenn der Tod des Prozesses das Ergebnis einer Systemd-Aktion ist, wird der Dienst nicht neu gestartet.  
    Die erlaubten Werte sind: no, always, on-success, on-failure, on-abnormal, on-abort oder on-watchdog.  
    Folgende Tabelle zeigt den Effekt der *Restart=* Einstellung auf die Exit-Gründe.

    ------------------- -------- --------- --------- ---------- ------- ----------
                                  on        on        on         on      on
    ► Restart= ►         always   success   failure   abnormal   abort   watchdog
    ▼ Exit-Grund ▼
    Sauberer Exit          X        X
    Unsauberer Exit        X                  X
    Unsauberes Signal      X                  X         X          X
    Zeitüberschreitung     X                  X         X
    Watchdog               X                  X         X                  X
    ------------------- -------- --------- --------- ---------- ------- ----------

    Die bei Bedarf gesetzten Optionen *RestartPreventExitStatus=* und *RestartForceExitStatus=* ändern dieses Verhalten.

**Beispiele**  
Einige selbst erstellte Service-Units finden sich auf unseren Handbuchseiten

[service-Unit für systemd Timer](./0716-systemd-timer_de.md#service-unit-anlegen)  
[service-Unit für systemd Path](./0715-systemd-path_de.md#service-unit-anlegen)  
und mit der bevorzugten Suchmaschine im Internet.  
[LinuxCommunity, Systemd-Units selbst erstellen](https://www.linux-community.de/ausgaben/linuxuser/2018/07/handarbeit-2/)

### Quellen systemd-service

[Deutsche Manpage, systemd.service](https://manpages.debian.org/testing/manpages-de/systemd.service.5.de.html)  
[LinuxCommunity, Systemd-Units selbst erstellen](https://www.linux-community.de/ausgaben/linuxuser/2018/07/handarbeit-2/)  

<div id="rev">Seite zuletzt aktualisert 2021-04-07</div>
