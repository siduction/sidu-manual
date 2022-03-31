% Systemd - timer

## systemd-timer

Die grundlegenden und einführenden Informationen zu Systemd enthält die Handbuchseite [Systemd-Start](./systemd-start_de.md#systemd-der-system--und-dienste-manager) Die alle Unit-Dateien betreffenden Sektionen *[Unit]* und *[Install]* behandelt unsere Handbuchseite [Systemd Unit-Datei](./systemd-unit-datei_de.md#systemd-unit-datei)  
In der vorliegenden Handbuchseite erklären wir die Funktion der Unit **systemd.timer**, mit der zeitgesteuert Aktionen ausgelöst werden können.

Die "*.timer*"-Unit wird meist eingesetzt, um regelmäßig anfallende Aktionen zu erledigen. Dazu ist eine gleichnamige "*.service*"-Unit notwendig, in der die Aktionen definiert sind. Sobald der Systemzeitgeber mit der in der "*.timer*"-Unit definierten Zeit übereinstimmt, aktiviert die "*.timer*"-Unit die gleichnamige "*.service*"-Unit.  
Bei entsprechender Konfiguration können verpasste Läufe, während die Maschine ausgeschaltet war, nachgeholt werden.  
Auch ist es möglich, dass eine "*.timer*"-Unit die gewünschten Aktionen nur ein einziges Mal zu einem vorher definierten Termin auslöst.

### Benötigte Dateien

Die **systemd-timer**-Unit benötigt zwei Dateien mit dem gleichen Basename im Verzeichnis */usr/local/lib/systemd/system/* für ihre Funktion. (Ggf. ist das Verzeichnis zuvor mit dem Befehl **`mkdir -p /usr/local/lib/systemd/system/`** anzulegen.) Das sind die

+ Timer-Unit-Datei (xxxxx.timer), welche die Zeitsteuerung und den Auslöser für die service-Unit enthält  
    und die  
+ service-Unit Datei (xxxxx.service), welche die zu startende Aktion enthält.

Für umfangreichere Aktionen erstellt man als dritte Datei ein Skript in */usr/local/bin/*, das von der service-Unit ausgeführt wird.

Wir erstellen in dem Beispiel ein regelmäßiges Backup mit *rsync*.

### service-Unit für timer

Die *.service-Unit*, die das Backup ausführt, wird von der *.timer-Unit* aktiviert und kontrolliert und benötigt daher keine *[Install]* Sektion. Somit reicht die Beschreibung der Unit in der Sektion *[Unit]*. Ihrer Sektion *[Service]* enthält den auszuführenden Befehl nach der Option *ExecStart=*.

Wir legen die Datei **backup.service** im Verzeichnis */usr/local/lib/systemd/system/* mit folgendem Inhalt an.

~~~
[Unit]
Description="Command to backup my home directory"

[Service]
Type=oneshot
ExecStart=/usr/bin/rsync -a --exclude=.cache/* /home/<user> /mnt/sdb5/backup/home/
~~~

Den String \<user\> bitte durch den eigenen User ersetzen.

### timer-Unit anlegen

Wir legen die Datei **backup.timer** im Verzeichnis */usr/local/lib/systemd/system/* mit folgendem Inhalt an.

~~~
[Unit]
Description="Backup my home directory"

[Timer]
OnCalendar=*-*-* 19:00:00
Persistent=true

[Install]
WantedBy=timers.target
~~~

**Erklärungen**  
Die *.timer-Unit* muss zwingend die Sektion *[Timer]* enthalten, in der festgelegt wird wann und wie die zugehörige *.service-Unit* ausgelöst wird.  
Es stehen zwei Timer-Typen zur Verfügung:

1. Realtime timers,  
    die mit der Option `OnCalendar=` einen Echtzeit- (d.h. Wanduhr-)Zeitgeber definiert  
    (das Beispiel "*OnCalendar=\*-\*-\* 19:00:00*" bedeutet "täglich um 19:00 Uhr"),  
    und  
2. Monotonic timers,  
    die mit den Optionen `OnActiveSec=, OnBootSec=, OnStartupSec=, OnUnitActiveSec=, OnUnitInactiveSec=` einen zu der Option relativen Zeitgeber definiert.  
    "*OnBootSec=90*" bedeutet "90 Sekunden nach dem Booten" und  
    "*OnUnitActiveSec=1d*" bedeutet "Einen Tag nachdem der Zeitgeber letztmalig aktiviert wurde".  
    Beide Optionen zusammen lösen die zugehörige *.service-Unit* 90 Sekunden nach den Booten und dann genau im 24 Stunden-Takt aus, solange die Maschine nicht heruntergefahren wird.

Die im Beispiel enthaltene Option "*Persistent=*" speichert den Zeitpunkt, zu dem die *.service-Unit* das letzte Mal ausgelöst wurde, als leere Datei im Verzeichnis */var/lib/systemd/timers/*. Dies ist nützlich, um verpasste Läufe, als die Maschine ausgeschaltet war, nachzuholen.

**timer-Unit eingliedern**

Mit dem folgenden Befehl gliedern wir die *.timer-Unit* in systemd ein.

~~~
# systemctl enable backup.timer
Created symlink /etc/systemd/system/timers.target.wants/backup.timer \
  → /usr/local/lib/systemd/system/backup.timer.
~~~

Der analoge Befehl für die *.service-Unit* ist nicht notwendig und würde auch zu einem Fehler führen, da in ihr keine *[Install]* Sektion enthalten ist.

**timer-Unit manuell auslösen**

Es wird nicht die *.timer-Unit*, sondern die von ihr auszulösende *.service-Unit* aufgerufen.

~~~
# systemctl start backup.service
~~~

### timer-Unit als cron Ersatz

*"cron"* und *"anacron"* sind die bekanntesten und weit verbreiteten Job-Zeitplaner. Systemd Timer können eine Alternative sein. Wir betrachten kurz den Nutzen von, und die Vorbehalte gegen Systemd Timer.

**Nutzen**

+ Jobs können Abhängigkeiten haben (von anderen systemd-Diensten abhängen).
+ Timer Units werden im systemd-Journal geloggt.
+ Man kann einen Job sehr einfach unabhängig von seinem Timer aufrufen.
+ Man kann Timer Units einen Nice-Wert geben oder cgroups für die Ressourcenverwaltung nutzen.
+ Systemd Timer Units können von Ereignissen wie dem Booten oder Hardware-Änderungen ausgelöst werden.
+ Sie können auf einfache Weise mit systemctl aktiviert oder deaktiviert werden.

**Vorbehalte**

+ Die Konfiguration eines Cron-Jobs ist ein einfacher Vorgang.
+ Cron kann E-Mails mit Hilfe der MAILTO-Variablen senden. 

### Quellen systemd-timer

[Deutsche Manpage 'systemd.timer'](https://manpages.debian.org/testing/manpages-de/systemd.timer.5.de.html)  
[Archlinux Wiki, Timers](https://wiki.archlinux.org/index.php/Systemd/Timers)  
[PRO-LINUX.DE, Systemd Timer Units...](https://www.pro-linux.de/artikel/2/1992/systemd-timer-units-f%C3%BCr-zeitgesteuerte-aufgaben-verwenden.html)

<div id="rev">Seite zuletzt aktualisiert 2021-11-29</div>
