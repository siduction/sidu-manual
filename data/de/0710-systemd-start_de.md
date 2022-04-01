% Systemadministration - systemd

## Systemd, der System- und Dienste-Manager

*Anmerkung:*  
*Die folgende, allgemeine Einführung zu systemd wurde überwiegend der ins [deutsche übersetzten Manpage](https://manpages.debian.org/testing/manpages-de/systemd.1.de.html) entnommen. Der Dank geht an Helge Kreutzmann.*

**systemd** ist ein System- und Diensteverwalter, der beim Systemstart als erster Prozess (als PID 1) ausgeführt wird und somit als **Init-System** agiert, das System hochfährt und auf Anwendungsebene Dienste verwaltet.  
Entwickelt wird es federführend von den Red Hat Entwicklern Lennart Poettering und Kay Sievers.

In Debian wurde die Einführung des systemd als Standard-Init-System lange, kontrovers und emotional diskutiert bis im Februar 2014 der Technische Ausschuss für systemd stimmte.  

Seit der Veröffentlichung von 2013.2 "December" benutzt siduction bereits systemd als Standard-Init-System.

### Konzeption des systemd

Systemd stellt ein Abhängigkeitssystem zwischen verschiedenen Einheiten namens *"Units"* in 11 verschiedenen Typen (siehe unten) bereit. Units kapseln verschiedene Objekte, die für den Systemstart und -betrieb relevant sind.  
Units können *"aktiv"* oder *"inaktiv"*, sowie im Prozess der *"Aktivierung"* oder *"Deaktivierung"*, d.h. zwischen den zwei erstgenannten Zuständen sein. Ein besonderer Zustand *"fehlgeschlagen"* ist auch verfügbar, der sehr ähnlich zu inaktiv ist. Falls dieser Zustand erreicht wird, wird die Ursache für spätere Einsichtnahme protokolliert. Siehe die Handbuchseite [Sytemd-Journal](./systemd-journald_de.md#systemjournal).  
Mit systemd können viele Prozesse parallel gesteuert werden, da die Unit-Dateien mögliche Abhängigkeiten deklarieren und systemd erforderliche Abhängigkeiten automatisch hinzugefügt.

Die von systemd verwalteten Units werden mittels Unit-Dateien konfiguriert.  
Die Unit-Dateien sind in verschiedene Sektionen unterteilte, reine Textdateien im INI-Format. Dadurch ist ihr Inhalt ohne Kenntnis einer Scriptsprache leicht verständlich und editierbar. Alle Unit-Dateien müssen eine Sektion entsprechend des Unit Typs haben und können die generischen Sektionen [Unit] und [Install] enthalten.  
Die Handbuchseite [Systemd Unit-Datei](./systemd-unit-datei_de.md#systemd-unit-datei) erläutert den grundlegenden Aufbau der Unit-Dateien, sowie viele Optionen der generischen Sektionen [Unit] und [Install].

### Unit Typen

Bevor wir uns den Unit-Typen zuwenden, ist es ratsam die Handbuchseite [Systemd Unit-Datei](./systemd-unit-datei_de.md#systemd-unit-datei) zu lesen, um die Wirkungsweise der generischen Sektionen und ihrer Optionen zu verstehen.  
Die folgenden Unit-Typen sind verfügbar, und sofern verlinkt, führt der Link zu einer ausführlicheren Beschreibung in unserem Handbuch:

1. **Dienste-Units** [(systemd.service)](./systemd-service_de.md#systemd-service), die Daemons und die Prozesse, aus denen sie bestehen, starten und steuern. 

2. **Socket-Units** (systemd.socket), die lokale IPC- oder Netzwerk-Sockets im System kapseln, nützlich für Socket-basierte Aktivierung.

3. **Target-Units** [(systemd.target)](./systemd-target_de.md#systemd-target---ziel-unit) sind für die Gruppierung von Units nützlich. Sie stellen während des Systemstarts auch als Runlevel bekannte Synchronisationspunkte zur Verfügung.

4. **Geräte-Units** (systemd.device) legen Kernel-Geräte (alle Block- und Netzwerkgeräte) in systemd offen und können zur Implementierung Geräte-basierter Aktivierung verwandt werden.

5. **Mount-Units** [(systemd.mount)](./systemd-mount_de.md#systemd-mount) steuern Einhängepunkte im Dateisystem.

6. **Automount-Units** [(systemd.automount)](./systemd-mount_de.md#systemd-mount) stellen Fähigkeiten zum Selbsteinhängen bereit, für bedarfsgesteuertes Einhängen von Dateisystemen sowie parallelisiertem Systemstart.

7. **Zeitgeber-Units** [(systemd.timer)](./systemd-timer_de.md#systemd-timer) sind für das Auslösen der Aktivierung von anderen Units basierend auf Zeitgebern nützlich.

8. **Auslagerungs-Units** (systemd.swap) sind ähnlich zu Einhänge-Units und kapseln Speicherauslagerungs-Partitionen oder -Dateien des Betriebssystems.

9. **Pfad-Units** [(systemd.path)](./systemd-path_de.md#systemd-path) können zur Aktivierung andere Dienste, wenn sich Dateisystemobjekte ändern oder verändert werden, verwandt werden.

10. **Slice-Units** (systemd.slice) können zur Gruppierung von Units, die Systemprozesse (wie Dienste- und Bereichs-Units) in einem hierarchischen Baum aus Ressourcenverwaltungsgründen verwalten, verwandt werden.

11. **Scope-Units** (systemd.scope) sind ähnlich zu Dienste-Units, verwalten aber fremde Prozesse, statt sie auch zu starten.

### Systemd im Dateisystem

Die Unit-Dateien, die durch den Paketverwalter der Distribution installiert wurden, befinden sich im Verzeichnis `/lib/systemd/system/`. Selbst erstellte Unit-Dateien legen wir im Verzeichnis `/usr/local/lib/systemd/system/` ab. (Ggf. ist das Verzeichnis zuvor mit dem Befehl **`mkdir -p /usr/local/lib/systemd/system/`** anzulegen.)  
Die Steuerung des Status (enabled, disabled) einer Unit erfolgt über Symlink im Verzeichnis `/etc/systemd/system/`.  
Das Verzeichnis `/run/systemd/system/` beinhaltet zur Laufzeit erstellte Unit-Dateien.

### Weitere Funktionen von systemd

Systemd bietet noch weitere Funktionen. Eine davon ist [logind](https://www.freedesktop.org/software/systemd/man/systemd-logind.service.html)  als Ersatz für das nicht mehr weiter gepflegte  *ConsoleKit* . Damit steuert systemd Sitzungen und Energiemanagement. Nicht zuletzt bietet systemd eine Menge an weiteren Möglichkeiten wie beispielsweise das Aufspannen eines Containers (ähnlich einer Chroot) mittels [systemd-nspawn](http://0pointer.de/public/systemd-man/systemd-nspawn.html)  und viele weitere. Ein Blick in die Linkliste auf [Freedesktop](https://www.freedesktop.org/wiki/Software/systemd/) ermöglicht weitere Entdeckungen, unter anderem auch die ausführliche Dokumentation von Hauptentwickler Lennart Poettering zu systemd.

### Handhabung von Diensten

Einer der Jobs von systemd ist es Dienste zu starten, zu stoppen oder sonst wie zu steuern. Dazu dient der Befehl `systemctl`.

+ systemctl --all - listet alle Units, aktive und inaktive.
+ systemctl -t [NAME] - listet nur Units des bezeichneten Typ.
+ systemctl list-units - listet alle aktiven Units.
+ systemctl start [NAME...] - startet eine oder mehrere Units.
+ systemctl stop [NAME...] - stoppt eine oder mehrere Units.
+ systemctl restart [NAME] - stoppt eine Unit und startet sie sofort wieder. Wird z.B. verwendet um die geänderte Konfiguration eines Dienstes neu einzulesen.
+ systemctl status [Name] - zeigt den derzeitigen Status einer Unit.
+ systemctl is-enabled [Name] - zeigt nur den Wert "enabled" oder "disabled" des Status einer Unit.

Die beiden folgenden Befehle integrieren bzw. entfernen die Unit anhand der Konfiguration ihrer Unit-Datei. Dabei werden Abhängigkeiten zu anderen Units beachtet und ggf. Standardabhängigkeiten hinzugefügt, damit systemd die Dienste und Prozesse fehlerfrei ausführen kann.

+ systemctl enable [NAME] - gliedert eine Unit in systemd ein.
+ systemctl disable [NAME] - entfernt eine Unit aus systemd.

Oft ist es nötig, *"systemctl start"* und *"systemctl enable"* für eine Unit durchzuführen, um sie sowohl sofort als auch nach einem Reboot verfügbar zu machen. Beide Optionen vereint der Befehl:

+ systemctl enable --now [NAME]

Nachfolgend zwei Befehle deren Funktion unsere Handbuchseite [Systemd-Target](./systemd-target_de.md#systemd-target---ziel-unit) beschreibt.

+ systemctl reboot – Führt einen Reboot aus
+ systemctl poweroff - Fährt das System herunter und schaltet den Strom, sofern technisch möglich, aus.

**Beispiel**  
Anhand von Bluetooth demonstrieren wir die Funktionalität des systemd.  
Zuerst die Statusabfrage im Kurzformat.

~~~
# systemctl is-enabled bluetooth.service
enabled
~~~

Nun Suchen wir nach den Unit-Dateien, dabei kombinieren wir *"systemctl"* mit *"grep"*:

~~~
# systemctl list-unit-files | grep blue
bluetooth.service          enabled         enabled
dbus-org.bluez.service     alias           -
bluetooth.target           static          - 
~~~

Anschließend deaktivieren wir die Unit *"bluetooth.service"*.

~~~
# systemctl disable bluetooth.service
  Synchronizing state of bluetooth.service with SysV service script with /lib/systemd/systemd-sysv-install.
  Executing: /lib/systemd/systemd-sysv-install disable bluetooth
  Removed /etc/systemd/system/dbus-org.bluez.service.
  Removed /etc/systemd/system/bluetooth.target.wants/bluetooth.service.
~~~

In der Ausgabe ist gut zu erkennen, dass die Link (nicht die Unit-Datei selbst) entfernt wurden. Damit startet der *"bluetooth.service"* beim Booten des PC/Laptop nicht mehr automatisch. Zur Kontrolle fragen wir den Status nach einem Reboot ab.

~~~
# systemctl is-enabled bluetooth.service  
disabled
~~~

Um eine Unit nur zeitweise zu deaktivieren, verwenden wir den Befehl

~~~
# systemctl stop <unit>
~~~

Damit bleibt die Konfiguration in systemd erhalten. Mit dem entsprechenden "start"-Befehl aktivieren wir die Unit wieder.

### Quellen systemd

[Deutsche Manpage 'systemd'](https://manpages.debian.org/testing/manpages-de/systemd.1.de.html)  
[Deutsche Manpage 'systemd.unit'](https://manpages.debian.org/testing/manpages-de/systemd.unit.5.de.html)  
[Deutsche Manpage 'systemd.syntax'](https://manpages.debian.org/testing/manpages-de/systemd.syntax.7.de.html)

<div id="rev">Seite zuletzt aktualisiert 2021-11-29</div>
