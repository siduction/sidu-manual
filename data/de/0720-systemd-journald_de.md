% Systemjournal

## Systemjournal

Das Systemjournal besteht aus dem *systemd-journald*, kurz **journald**, der Protokollmeldungen sammelt und speichert, und dem **journalctl**, das der Verwaltung, Abfrage und Ausgabe der gesammelten Protokollmeldungen dient.

### journald

*journald* ist ein Systemdienst, der mit Hilfe der Unit *systemd-journald.service* (und seiner zugehörigen Socket-Units) Protokollmeldungen sammelt und speichert.  
Es erstellt und verwaltet strukturierte, indizierte Journale, basierend auf den Protokollmeldungen aus:

+ Kernel-Protokollmeldungen
+ Einfache System-Protokollmeldungen
+ Strukturierte System-Protokollmeldungen über die native Journal-API
+ Standardausgabe und Standardfehlerausgabe der Dienste-Units
+ Audit-Aufzeichnungen, stammend aus dem Kernel-Audit-Subsystem

*journald* erlaubt Journal-"Namensräume" (namespaces). Sie sind zum Einen ein Mechanismus zur logischen Isolation eines Protokoll-Datenstroms vom Rest des Systems, zum Anderen auch ein Mechanismus zur Steigerung der Leistung. Journal-Namensräume existieren gleichzeitig und nebeneinander. Jeder hat seinen eigenen, unabhängigen Protokolldatenstrom. Nach der Installation von siduction besteht nur der Vorgabe-Namensraum des Systems.

Der *journald* speichert die Protokolldaten standardmäßig dauerhaft unter  
`/var/log/journal/MASCHINENKENNUNG`.

Protokolldaten für andere Namensräume befinden sich in  
`/var/log/journal/MASCHINENKENNUNG.NAMENSRAUM`.

Der Befehl **`systemd-cat`** bietet zwei Möglichkeiten um unabhängig von systemd-Units Daten eines Prozesses an das Journal weiterzugeben.  

1. **`systemd-cat <Programm> <Option(en)>`**  
  Mit einem Programmaufruf oder Befehl verwendet, leitet *systemd-cat* alle Standardeingaben, Standardausgaben und Standardfehlerausgaben eines Prozesses zum Journal um.  
2. **In einer Pipe verwendet,**  
  dient *systemd-cat* als Filterwerkzeug, um die zuvor erstellte Ausgabe an das Journal zu senden.

Falls kein Parameter übergeben wurde, wird *systemd-cat* alles, was es von der Standardeingabe liest, an das Journal schicken. Die man-page [systemd-cat.1.de](https://manpages.debian.org/testing/manpages-de/systemd-cat.1.de.html) bietet weitere Informationen.

### journald über das Netzwerk

Die *systemd-journal*-Module *upload*, *remote* und *gatewayd* ermöglichen das Versenden und Empfangen von System-Protokolldaten zwischen verschiedenen Rechnern über das Netzwerk. Mit ihrer Hilfe lassen sich entfernte Rechner fortlaufend überwachen. In dieser Konstellation ist es sinnvoll auf dem Remoterechner Namensräume für die Protokolldaten der entfernten Rechner einzurichten.  
Für weitere Informationen bitte die man-pages [journal upload](https://manpages.debian.org/testing/manpages-de/systemd-journal-upload.8.de.html), [journal remote](https://manpages.debian.org/testing/manpages-de/systemd-journal-remote.8.de.html) und [journal gatewayd](https://manpages.debian.org/testing/manpages-de/systemd-journal-gatewayd.8.de.html) lesen.

### journald.conf

Die folgenden Dateien konfigurieren verschiedene Parameter des systemd-Journal-Dienstes.

+ /etc/systemd/journald.conf
+ /etc/systemd/journald.conf.d/*.conf
+ /etc/systemd/journald@NAMENSRAUM.conf (optional)
+ /run/systemd/journald.conf.d/*.conf (optional)
+ /usr/lib/systemd/journald.conf.d/*.conf (optional)

Der Vorgabe-Namensraum, den der systemd-journald.service (und seine zugehörigen Socket-Units) verwaltet, wird in `/etc/systemd/journald.conf` und zugeordneten Ergänzungen konfiguriert.  
Die Konfigurationsdatei enthält die Vorgaben als auskommentierten Hinweis für den Administrator. Um lokal Einstellungen zu ändern, genügt es diese Datei zu bearbeiten. 

Instanzen, die andere Namensräume verwalten, werden nur benötigt, wenn von den Vorgaben abgewichen werden muss. Deren Konfigurationsdatei ist nach dem Muster `etc/systemd/journald@NAMENSRAUM.conf` zu erstellen.  
Einem bestimmten Journal-Namensraum können Dienste-Units mittels der Unit-Dateieinstellung `LogNamespace=` zugeordnet werden.

Standardmäßig sammelt nur der Vorgabe-Namensraum Kernel- und Auditprotokollnachrichten.

**Rangfolge**

Wenn Pakete die Konfiguration anpassen müssen, können sie Konfigurationsschnipsel in `/usr/lib/systemd/*.conf.d/` oder `/usr/local/lib/systemd/*.conf.d/` installieren.

Die Hauptkonfigurationsdatei wird vor jeder anderen aus den Konfigurationsverzeichnissen gelesen und hat die niedrigste Priorität. Einträge in einer Datei in jedem der Konfigurationsverzeichnisse setzen Einträge in der Hauptkonfigurationsdatei außer Kraft. Dateien in den Unterverzeichnissen `*.conf.d/` werden nach ihrem Dateinamen sortiert, unabhängig davon, in welchem Unterverzeichnis sie sich befinden. Sofern eigene Konfigurationsdateien nötig sind, wird empfohlen, allen Dateinamen in diesen Unterverzeichnissen eine zweistellige Zahl und einen Bindestrich voranzustellen, um die Sortierung der Dateien zu vereinfachen. 

### journalctl

*journalctl* dient der Abfrage des von systemd-journald erstellten Journals.  
Beim Aufruf ohne Parameter wird der gesamte Inhalt aus allen zugreifbaren Quellen des Journals angezeigt, beginnend mit dem ältesten Eintrag.  
Die Ausgabe wird seitenweise durch *less* geleitet. Lange Zeilen kann man mittels der **`Pfeil-links`** und **`Pfeil-rechts`** Tasten betrachten. Die Option `--no-pager` deaktiviert die seitenweise Anzeige, wobei die Zeilen auf die Breite des Terminals verkürzt werden.

*journalctl* bietet zu den nachfolgend beschriebenen Optionen eine ganze Reihe weiterer Möglichkeiten der Filterung und Aufbereitung der Ausgaben. Bitte auch die man-Page [journalctl, Journalabfrage](https://manpages.debian.org/testing/manpages-de/journalctl.1.de.html) lesen.

**Rechte**

Dem Benutzer **root** und allen Benutzern die Mitglied der Gruppen **systemd-journal**, **adm** und **wheel** sind, wird Zugriff auf das System-Journal und die Journale der anderen Benutzer gewährt. Siduction fügt alle konfigurierten USER der Gruppe **systemd-journal** zu.

Das Journal enthält vertrauenswürdige Felder, d.h. Felder, die implizit vom Journal hinzugefügt werden und durch Client-Code nicht geändert werden können. Sie beginnen mit einem Unterstrich. (z.B.: _PID=, _UID=, _GID=, _COMM=, _EXE=, _CMDLINE= )

**Ausgabe filtern**

+ *Optionen*: `--user`, `--system`, `--directory=`, `--file=`, `--namespace=`  
  Die Optionen begrenzen die Quelle der Ausgabe auf den genannten Bereich, das Verzeichnis oder die Datei.

+ *Optionen*: `-b`, `-k`, `-u`, `-p`, `-g`, `-S`, `-U`  
  Die Ausgaben dieser Optionen verwenden alle zu Verfügung stehenden Journal-Dateien, es sei denn, eine der zuvor genannten Optionen wird zusätzlich verwendet.

  + `-b` `--boot=`  
    Zeigt Nachrichten von einem bestimmten Systemstart. Ohne Argument werden die Protokolle für den aktuellen Systemstart angezeigt. Das Argument "-1" gibt die Meldungen des Systemstarts vor dem Aktuellen aus. Das Argument "5" präsentiert die Meldungen des fünften Systemstarts seit Beginn der Aufzeichnungen.

  + `-k` `--dmesg`  
    Zeigt nur Kernelnachrichten. Dies beinhaltet die Option `-b`, sodass nur Kernelmeldungen seit dem aktuellen Systemstart ausgegeben werden.

  + `-u` `--unit=`  
    Diese Option benötigt die Angabe einer UNIT oder eines MUSTERs.  
    Gibt die Journaleinträge für die angegebene systemd-Unit UNIT oder für alle Units, die auf das MUSTER passen, aus.

  + `-p` `--priority=`  
    Filtert die Ausgabe nach Nachrichtenprioritäten oder Prioritätsbereichen. Benötigt die Angabe einer einzelnen Protokollstufe, oder einen Bereich von Protokollstufen in der Form VON..BIS.  
    Die Protokollstufen sind die normalen Syslog-Protokollstufen:  
    "emerg" (0), "alert" (1), "crit" (2), "err" (3), "warning" (4), "notice" (5), "info" (6), "debug" (7)  
    Als Argument können sowohl die Namen als auch die Ziffern der Protokollstufen verwendet werden. Falls eine einzelne Protokollstufe angegeben ist, werden alle Nachrichten mit dieser oder einer niedrigeren Protokollstufe angezeigt.

  + `-g` `--grep=`  
    Benötigt die Angabe eines PERL-kompatiblen regulären Ausdrucks, um die Ausgabe zu filtern. Der reguläre Ausdruck wird in den Journaleinträgen auf das Feld "MESSAGE=" angewendet.

  + `-S` `--since=` und `-U` `--until=`  
    Die Anzeige beginnt mit neueren Einträgen ab dem angegebenen Datum oder älteren Einträgen bis zum angegebenen Datum. Das Datumsformat sollte "2012-10-30 18:17:16" sein, es können aber auch Teile davon weggelassen werden. Alternativ sind die Zeichenketten "yesterday", "today", "tomorrow" möglich. Das Argument "now" bezieht sich auf die aktuelle Zeit. Die Angabe relativer Zeiten ermöglichen ein vorangestelltes "-" oder "+", die sich auf Zeiten vor bzw. nach der angegebenen Zeit beziehen.

**Ausgabe steuern**

+ Optionen: `-f`, `-n`, `-r`, `-o`, `-x`, `--no-pager`

  + `-f` `--follow`  
    Nur die neusten Journal-Einträge anzeigen und kontinuierlich neue Einträge ausgeben. Dies beinhaltet die Option `-n`. Die Ausgabe ist vergleichbar mit dem altbekannten Befehl `tail -f /var/log/messages`.

  + `-n` `--lines=`  
    Zeigt die neusten Journal-Einträge und begrenzt die Anzahl der zu zeigenden Ereignisse. Das Argument ist eine positive Ganzzahl. Der Vorgabewert ist 10, falls kein Argument angegeben wird.

  + `-r` `--reverse`  
    Die Ausgabe beginnt mit dem neusten Eintrag.

  + `-o` `--output=`  
    Steuert die Formatierung der angezeigten Journal-Einträge. Dieser Option sind eine ganze Reihe weiterer Optionen untergeordnet, von denen wir hier nur die Option "short-full" betrachten.

    `-o short-full`  
    Die Ausgabe ist größtenteils identisch zu der Formatierung klassischer Syslog-Dateien. Sie zeigt eine Zeile pro Journal-Eintrag an, aber der Zeitstempel wird im Format, das die Optionen --since= und --until= akzeptieren, ausgegeben. Deshalb eignet sich diese Ausgabe sehr gut um nachfolgend eine zeitbezogene Filterung der Journaleinträge zu erstellen.

  + `-x` - -catalog  
    Ergänzt Protokollzeilen mit erklärenden Hilfetexten, soweit diese verfügbar sind.

  + `--no-pager`  
    Die Option deaktiviert die seitenweise Anzeige, wobei die Zeilen auf die Breite des Terminals verkürzt werden. Sie zu benutzen ist nur sinnvoll, wenn für die Ausgabe nur eine geringe Anzahl an Zeilen erwartet wird.

**journalctl steuern**

+ Optionen: `--disk-usage`, `--vacuum-size=`, `--vacuum-time=`, `--vacuum-files`, `--rotate`, `--verify`  
  Die Optionen behandeln die Verwaltung der von *journald* geschriebenen Daten.

  + `--disk-usage`  
    Zeigt den aktuellen Plattenplatzverbrauch aller Journal-Dateien an.

  + `--vacuum-size=`, `--vacuum-time=`, `--vacuum-files`  
    Entfernt die ältesten archivierten Journal-Dateien, bis der Plattenplatz, den sie verwenden, unter die angegebene Größe fällt oder alle archivierten Journal-Dateien, die keine Daten älter als die angegebene Zeitspanne enthalten oder so dass nicht mehr als die angegebene Anzahl an separaten Journal-Dateien verbleiben. Die Ausführung von `--vacuum-xxx` bezieht nicht die aktiven Journal-Dateien ein.

  + `--rotate`  
    Bittet den Journal-Daemon, die Journal-Dateien zu rotieren. Journal-Dateien-Rotation hat den Effekt, dass alle derzeit aktiven Journal-Dateien als archiviert markiert und umbenannt werden, so dass in der Zukunft niemals mehr in sie geschrieben wird. Dann werden stattdessen neue (leere) Journal-Dateien erstellt. Diese Aktion kann mit `--vacuum-xxx` in einem einzigen Befehl kombiniert werden, um die `--vacuum-xxx` mitgegebenen Argumente tatsächlich zu erreichen.    

  + `--verify`  
    Prüft die Journal-Dateien auf interne Konsistenz.

### journalctl beherrschen

Wie oben unter Rechte beschrieben, kannst Du das Journal als einfacher User benutzen. Hier sind einige Beispiele:

| Befehl | Anzeige |
| --- | ----- |
| journalctl | das volle Journal aller User, älteste Einträge zuerst |
| journalctl -r | wie zuvor, neueste Einträge zuerst |
| journalctl -b | das Protokoll des letzten Bootvorgangs |
| journalctl -b -1 -k | vom vorletzten Bootvorgang (-1) alle Kernelmeldungen |
| journalctl -b -p err | limitiert auf den letzten Boot und die Priorität ERROR |
| journalctl --since=yesterday | das Journal seit gestern |
| journalctl /dev/sda | das Journal der Gerätedatei /dev/sda |
| journalctl /usr/bin/dbus-daemon | alle Logs des D-Bus-Daemon |
| journalctl -f | Liveansicht des Journal (früher: tail -f /var/log/messages) |

Die Option "`--list-boots*" gibt die entsprechende Liste aus.

~~~
# journalctl --list-boots --no-pager
[...]
 -50 8fc07f387... Sun 2021-02-28 11:07:05 CET-Sun [...] CET
 -49 aa49cb3af... Mon 2021-03-01 17:49:58 CET-Mon [...] CET
 -48 3a6e55a4a... Tue 2021-03-02 12:18:46 CET-Tue [...] CET
 -47 a46150a19... Wed 2021-03-03 11:06:29 CET-Wed [...] CET
 -46 d42ed8b05... Thu 2021-03-04 10:59:56 CET-Thu [...] CET
 -45 566f65991... Thu 2021-03-04 19:53:52 CET-Thu [...] CET
 -44 8e2da4a61... Fri 2021-03-05 10:15:18 CET-Fri [...] CET
[...]
~~~

Anschließend kannst du dir mit dem Befehl **`journalctl -b -47`** die Meldungen des Bootvorgangs vom 3.3.2021 anzeigen lassen.

Eine weitere Neuerung beim Protokollieren ist die Tab-Vervollständigung für journalctl. Wenn Du *journalctl* schreibst, und zwei mal die **`TAB`** Taste drückst, erscheint eine Liste möglicher Vervollständigungen:

~~~
$ journalctl
_AUDIT_FIELD_APPARMOR=        _KERNEL_SUBSYSTEM=
_AUDIT_FIELD_CAPABILITY=      KERNEL_USEC=
_AUDIT_FIELD_CAPNAME=         LEADER=
_AUDIT_FIELD_DENIED_MASK=     LIMIT=
_AUDIT_FIELD_INFO=            LIMIT_PRETTY=
_AUDIT_FIELD_NAME=            _LINE_BREAK=
_AUDIT_FIELD_OPERATION=       _MACHINE_ID=
_AUDIT_FIELD_OUID=            MAX_USE=
_AUDIT_FIELD_PEER=            MAX_USE_PRETTY=
_AUDIT_FIELD_PROFILE=         MESSAGE=
_AUDIT_FIELD_REQUESTED_MASK=  MESSAGE_ID=
_AUDIT_FIELD_SIGNAL=          NM_CONNECTION=
_AUDIT_ID=                    NM_DEVICE=
_AUDIT_LOGINUID=              NM_LOG_DOMAINS=
_AUDIT_SESSION=               NM_LOG_LEVEL=
_AUDIT_TYPE=                  N_RESTARTS=
_AUDIT_TYPE_NAME=             _PID=
AVAILABLE=                    PRIORITY=
AVAILABLE_PRETTY=             SEAT_ID=
_BOOT_ID=                     _SELINUX_CONTEXT=
_CAP_EFFECTIVE=               SESSION_ID=
_CMDLINE=                     SHUTDOWN=
CODE_FILE=                    SLEEP=
CODE_FUNC=                    _SOURCE_MONOTONIC_TIMESTAMP=
CODE_LINE=                    _SOURCE_REALTIME_TIMESTAMP=
_COMM=                        _STREAM_ID=
COMMAND=                      SYSLOG_FACILITY=
CONFIG_FILE=                  SYSLOG_IDENTIFIER=
CONFIG_LINE=                  SYSLOG_PID=
CURRENT_USE=                  SYSLOG_RAW=
CURRENT_USE_PRETTY=           SYSLOG_TIMESTAMP=
DISK_AVAILABLE=               _SYSTEMD_CGROUP=
DISK_AVAILABLE_PRETTY=        _SYSTEMD_INVOCATION_ID=
DISK_KEEP_FREE=               _SYSTEMD_OWNER_UID=
DISK_KEEP_FREE_PRETTY=        _SYSTEMD_SESSION=
ERRNO=                        _SYSTEMD_SLICE=
_EXE=                         _SYSTEMD_UNIT=
EXECUTABLE=                   _SYSTEMD_USER_SLICE=
EXIT_CODE=                    _SYSTEMD_USER_UNIT=
EXIT_STATUS=                  THREAD_ID=
_FSUID=                       TIMESTAMP_BOOTTIME=
_GID=                         TIMESTAMP_MONOTONIC=
GLIB_DOMAIN=                  _TRANSPORT=
GLIB_OLD_LOG_API=             _UDEV_DEVNODE=
_HOSTNAME=                    _UDEV_SYSNAME=
INVOCATION_ID=                _UID=
JOB_ID=                       UNIT=
JOB_RESULT=                   UNIT_RESULT=
JOB_TYPE=                     USER_ID=
JOURNAL_NAME=                 USER_INVOCATION_ID=
JOURNAL_PATH=                 USERSPACE_USEC=
_KERNEL_DEVICE=               USER_UNIT=
~~~

Die meisten davon sind selbsterklärend. Beispielsweise COMM, was für *command* steht, bedient eine Menge an Optionen:

 **`journalctl _COMM=`**  listet nach einem weiterer Druck auf TAB die möglichen Applikationen:

~~~
$ journalctl _COMM=
acpid           hddtemp        ntpdate       systemd
acpi-fakekey    hdparm         ntpd          systemd-fsck
acpi-support    hp             ofono         systemd-hostnam
alsactl         hpfax          ofonod        systemd-journal
anacron         ifup           pkexec        systemd-logind
apache2         irqbalance     polkitd       systemd-modules
backlighthelper kbd            pulseaudio    systemd-shutdow
bash            kdm            pywwetha      systemd-udevd
bluetoothd      keyboard-setup pywwetha.py   teamviewerd
chfn            loadcpufreq    resolvconf    udev-configure-
chrome          logger         rpcbind       udisksd
console-kit-dae login          rpc.statd     udisks-daemon
console-setup   lvm            samba-ad-dc   umount
cpufrequtils    lvm2           saned         uptimed
cron            mbd            sensors       useradd
cups            mbmon          sh            usermod
dbus-daemon     mdadm          smartmontools vboxdrv
ddclient        mdadm-raid     smbd          VBoxExtPackHelp
docvert-convert mtp-probe      ssh           vdr
glances         mysql          sshd          winbind
gpasswd         networking     su
gpm             nfs-common     sudo
groupadd        ntp            sysstat
~~~

Mit **`journalctl _COMM=su`** kannst du nun sehen, welcher User sich wann mit "su" root-Rechte verschafft hat.

~~~
# journalctl _COMM=su
-- boot 1b5d2b3fcd9043d88d8abce665b75ed4 --
Mar 10 16:27:22 pc1 su[105197]: (to root) siduser on pts/1
Mar 10 16:27:22 pc1 su[105197]: pam_unix(su:session):
     session opened for user root(uid=0) by (uid=1000)
Mar 10 17:54:33 pc1 su[105197]: pam_unix(su:session):
     session closed for user root
     
-- boot 37b19f6321814620be1ed4deb3be467f --
Mar 10 17:56:35 pc1 su[3381]: (to root) siduser on pts/1
Mar 10 17:56:35 pc1 su[3381]: pam_unix(su:session):
     session opened for user root(uid=0) by (uid=1000)
Mar 10 19:07:17 pc1 su[3381]: pam_unix(su:session):
     session closed for user root
~~~

Ein anderes Beispiel:  
Man kann die Ausgabe zusätzlich zeitlich eingrenzen.  

~~~
# journalctl _COMM=dbus-daemon --since=2020-04-06 --until="2020-04-07 23:40:00"
[...]
Apr 07 22:59:04 pc1 org.gtk.Private.GPhoto2VolumeMonitor[2006]: ### debug: in handle_supported
Apr 07 22:59:04 pc1 org.gtk.Private.GPhoto2VolumeMonitor[2006]: ### debug: in handle_list
Apr 07 22:59:04 pc1 org.gtk.Private.GoaVolumeMonitor[2006]: ### debug: in handle_supported
Apr 07 22:59:04 pc1 org.gtk.Private.GoaVolumeMonitor[2006]: ### debug: in handle_list
Apr 07 23:03:09 pc1 org.gtk.Private.GPhoto2VolumeMonitor[2006]: ### debug: Name owner ':1.4320' vanished
Apr 07 23:03:09 pc1 org.gtk.Private.GoaVolumeMonitor[2006]: ### debug: Name owner ':1.4320' vanished
Apr 07 23:03:09 pc1 org.gtk.Private.AfcVolumeMonitor[2006]: ### debug: Name owner ':1.4320' vanished
Apr 07 23:03:09 pc1 org.gtk.Private.MTPVolumeMonitor[2006]: ### debug: Name owner ':1.4320' vanished
~~~

Viele der oben genannten Optionen lassen sich miteinander kombinieren, damit nur die gesuchten Journaleinträge angezeigt werden. Die man-page von [journalctl](https://manpages.debian.org/testing/manpages-de/journalctl.1.de.html) beschreibt alle Optionen ausführlich.

### Quellen journald

[systemd-journald](https://manpages.debian.org/testing/manpages-de/systemd-journald.8.de.html)  
[journald Konfiguration](https://manpages.debian.org/testing/manpages-de/journald.conf.5.de.html)  
[journalctl, Journalabfrage](https://manpages.debian.org/testing/manpages-de/journalctl.1.de.html)  
[journal gatewayd](https://manpages.debian.org/testing/manpages-de/systemd-journal-gatewayd.8.de.html)  
[journal remote](https://manpages.debian.org/testing/manpages-de/systemd-journal-remote.8.de.html)  
[journal upload](https://manpages.debian.org/testing/manpages-de/systemd-journal-upload.8.de.html)  
[systemd-cat.1.de](https://manpages.debian.org/testing/manpages-de/systemd-cat.1.de.html)

Dank an Helge Kreuzmann für die deutschen Übersetzungen.

<div id="rev">Seite zuletzt aktualisiert 2021-11-29</div>
