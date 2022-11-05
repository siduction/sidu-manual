% Nala für das Paketmanagement

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

+ Neu im Handbuch

ENDE   INFOBEREICH FÜR DIE AUTOREN

## Nala Paketverwaltung

**Benutzerfreundlicher und leistungsstärker als APT**

Nala ist ein Kommandozeilen-Frontend für den APT-Paketmanager. Es benutzt dabei die Python-apt-API statt der APT-Bibliotheken zur Verwaltung der Pakete. Das Ziel von Nala ist es, erstens eine übersichtlichere und benutzerfreundlichere Darstellung sowohl des aktuellen Paketbestands, als auch der angeforderten Aktionen und deren Durchführung zu erhalten und zweitens den Download von Paketen zu beschleunigen.

Nala beinhaltet viele gleichlautende Befehle von APT, bspw. `install`, `remove`, `purge`, `update`, `show` und `search`. Außerdem implementiert es den Befehl `history`, um vergangene Transaktionen zu sehen und dem Benutzer die Möglichkeit zu geben diese rückgängig zu machen und den Befehl `fetch`, der eine Liste der schnellsten Spiegelserver zur Auswahl anzeigt. In der Grundeinstellung beschleunigt Nala den Download dadurch, dass drei Pakete gleichzeitig von einem Server geholt werden.

### Nala verwenden

Ab siduction 2022.12.0 wird Nala automatisch installiert und ist sofort verwendbar. Ein Blick in die manpage **`man nala`** sollte obligatorisch sein. Vor der Anwendung empfehlen wir eine Änderung in der Konfigurationsdatei `/etc/nala/nala.conf` vorzunehmen.  
Den Wert für die Konfigurationsoption `auto_remove` ändern wir zu `false`, so wie es das folgende Listing zeigt.

~~~
# Set to false to disable auto auto-removing
auto_remove = false
~~~

Der Grund hierfür liegt in der Verwendung von *debian sid* als Basis für siduction. Bei einem Upgrade von sid kann gelegentlich eine Situation entstehen in der wesentliche Teile des Systems entfernt werden sollen. Mit der Option `auto_remove = true` haben wir keine Möglichkeit zu recherchieren, zu prüfen und selbst zu entscheiden ob oder welche Pakete zu entfernen sind.

### Befehle analog zu APT

Viele der von APT her bekannten Befehle sind in Nala identisch. In der Grundeinstellung erwartet Nala vor dem Ausführen einer angeforderten Aktion, die das System ändert, immer eine Bestätigung.

+ **`nala update`**  
  Aktualisiert die Paketinformationen der konfigurierten Paketquellen.
  
+ **`nala install <Paketname>`**  
  Installiert das benannte Paket in unser System.
  
+ **`nala remove <Paketname>`**  
  Entfernt das benannte Paket aus unserem System.
  
+ **`nala purge <Paketname>`** oder **`nala remove --purge <Paketname>`**  
  Entfernt das benannte Paket mit seinen Konfigurationsdateien aus unserem System.
  
+ **`nala upgrade`**  
  Führt ein Dist Upgrade aus.

Die benutzerfreundliche Aufbereitung der Ausgabe im Terminal erleichtert die Übersicht, wie das Beispiel zeigt.  
(Um root-Rechte zu erlangen wurde im Befehl *"doas"* verwendet.)

~~~
user1@pc1:~$ doas nala install yapf3
============================================================
 Installieren
============================================================
  Paket:              Version:                      Größe:
  python3-yapf        0.32.0-1                      133 KB
  yapf3               0.32.0-1                       30 KB

============================================================
 Zusammenfassung
============================================================
 Installieren 2 Pakete

 Speicherplatz erforderlich  892 KB

Möchtest du fortfahren? [J/n] j
╭─ Pakete installieren ────────────────────────────────────╮
│Auspacken:       python3-yapf (0.32.0-1)                  │
│Auspacken:       yapf3 (0.32.0-1)                         │
│Konfigurieren:   python3-yapf (0.32.0-1)                  │
│Konfigurieren:   yapf3 (0.32.0-1)                         │
│Wird bearbeitet: triggers for runit (2.1.2-50)            │
│Wird bearbeitet: triggers for man-db (2.11.0-1+b1)        │
│Running kernel seems to be up-to-date.                    │
│No services need to be restarted.                         │
│No containers need to be restarted.                       │
│No user sessions are running outdated binaries.           │
│No VM guests are running outdated hypervisor (qemu)       │
│binaries on this host.                                    │
│╭────────────────────────────────────────────────────────╮│
││✔ Ausführen von dpkg … ━━━━━━━━━━ 100.0% • 0:00:00 • 5/5││
│╰────────────────────────────────────────────────────────╯│
╰──────────────────────────────────────────────────────────╯
Erfolgreich beendet
~~~

Im ersten Teil der Ausgabe erhalten wir eine Liste der zu installierenden Pakete mit der Angabe ihrer Versionen und Größe. Nach der Bestätigung listet der zweite Teil die ausgeführten Aktionen auf.


### Befehle die APT nicht enthält

**Befehl "fetch"**

Der Befehl **`nala fetch`**, ohne weitere Optionen ausgeführt, ermittelt automatisch die Distribution und das Release unserer Installation, sucht nach den schnellsten Spiegelservern, listet diese zur interaktiven Auswahl auf und legt nach der Auswahl eines oder mehrerer Server die Datei `/etc/apt/sources.list.d/nala-sources.list` an.

Die Option `-c, --country` beschränkt die Suche mit Hilfe des ISO-Ländercodes. Eine mehrfache Angabe der Option ist erlaubt.  
Die Option `--non-free` ergänzt die Datei um contrib und non-free Komponenten.

Bei einem Download werden von jedem der Server bis zu drei Pakete gleichzeitig geholt.

**Befehl "history"**

Der Befehl **`nala history`**, ohne Unterbefehl aufgerufen, zeigt eine Zusammenfassung aller mit Nala durchgeführten Aktionen. Jede Zeile entspricht einer Aktion und enthält die ID, das Kommando, den Zeitstempel, die Anzahl der geänderten Pakete und den User, der die Aktion angefordert hat. Aktionen die mit anderen Programmen erfolgten werden nicht erfasst.

~~~
user1@pc1:~$ nala history
 ID  Command                      Date and Time            Altered  Requested-By
  [...]
 66  upgrade libsmbclient samba…  2022-10-23 15:49:40 CET        5  root (0)
 67  upgrade apt apt-transport-…  2022-11-02 11:38:41 CET      308  root (0)
 68  install yapf3                2022-11-04 12:56:25 CET        2  user1 (1000)
~~~

Details zu einer Aktion aus der History zeigt der gleiche Befehl mit dem angehängten Unterbefehl `info [Nr]`.

~~~
user1@pc1:~$ nala history info 68
============================================================
 Installiert
============================================================
  Paket:              Version:                      Größe:
  python3-yapf        0.32.0-1                      133 KB
  yapf3               0.32.0-1                       30 KB

============================================================
 Zusammenfassung
============================================================
 Installiert 2 Pakete
~~~

Wollen wir nun die Installation von *"yapf3"* mit den Abhängigkeiten, in unserem Fall *"python3-yapf"*, rückgängig machen, benutzen wir den Unterbefehl `undo [Nr]` dafür.   
(Auch hier erlangt **user1** root-Rechte durch die Verwendung von *"doas"*.)

~~~
user1@pc1:~$ doas nala history undo 68
============================================================
 Entfernen
============================================================
  Paket:              Version:                      Größe:
  python3-yapf        0.32.0-1                      849 KB
  yapf3               0.32.0-1                       43 KB

============================================================
 Zusammenfassung
============================================================
 Entfernen 2 Pakete
 
 Speicherplatz freizugeben  892 KB

Möchtest du fortfahren? [J/n] j
╭─ Verlauf rückgängig machen 68 ───────────────────────────╮
│Entferne:        yapf3 (0.32.0-1)                         │
│Entferne:        python3-yapf (0.32.0-1)                  │
│Wird bearbeitet: triggers for runit (2.1.2-50)            │
│Wird bearbeitet: triggers for man-db (2.11.0-1+b1)        │
│╭────────────────────────────────────────────────────────╮│
││✔ Ausführen von dpkg … ━━━━━━━━━━ 100.0% • 0:00:00 • 5/5││
│╰────────────────────────────────────────────────────────╯│
╰──────────────────────────────────────────────────────────╯
Erfolgreich beendet
~~~

Im ersten Teil der Ausgabe sehen wir die zu entfernenden Pakete mit der Angabe ihrer Versionen und Größe. Nach der Bestätigung listet der zweite Teil die ausgeführten Aktionen auf.  
Sollten wir es uns noch einmal anders überlegen und die Pakete doch wieder verwenden wollen, hilft der Befehl `nala history redo [Nr]` weiter um die Aktion noch einmal auszuführen.

In der hier beschriebenen Nala Version 0.11.1 unterstützen die Unterbefehle `undo [Nr]` und `redo [Nr]` derzeit nur die Aktionen Installieren oder Entfernen.

<div id="rev">Zuletzt bearbeitet: 2022-11-05</div>
