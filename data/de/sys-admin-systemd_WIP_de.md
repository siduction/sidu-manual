ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: In Arbeit**

Änderungen 2020-04:
+ Entfernen des Kapitels "Installation und Einrichten von Systemd"
+ Neu "Init-System - .target Ziel-Unit"
+ Neu "systemd - .service Unit"
+ Neu "systemd - .timer Unit"
+ Korrektur und Aktualisierung aller Links

ENDE   INFOBEREICH FÜR DIE AUTOREN

<div class="divider" id="systemd"></div>

## systemd der System- und Dienste-Manager

**systemd** ist ein System- und Diensteverwalter, der beim Systemstart als erster Prozess (als PID 1) ausgeführt wird und somit als **Init-System** agiert, das System hochfährt und auf Anwendungsebene **Dienste verwaltet.** Entwickelt wird es federführend von den Red Hat Entwicklern Lennart Poettering und Kay Sievers. Seit der Veröffentlichung von 2013.2 "December" benutzt siduction bereits Systemd als Standard-Init-System.

In diesem Abschnitt wird für eine ganze Reihe von Aufgaben die Syntax des sytemd ausführlich erklärt, da sicherlich jeder einmal mit ihr in Berührung kommt.

---

<div class="divider" id="systemd-target"></div>

### systemd.target - Ziel-Unit (Runlevel)

Die verschiedenen Runlevel, in die gebootet oder gewechselt wird, beschreibt systemd als **Ziel-Unit**. Sie besitzen die Erweiterung **.target**.  
Die alten sysvinit-Befehle werden weiterhin unterstützt. (Hierzu ein Zitat aus *man systemd*: "... wird aus Kompatibilitätsgründen und da es leichter zu tippen ist, bereitgestellt.")

| Ziel-Unit | Beschreibung | 
| ---- | ---- |
| **emergency.target** | Startet in eine Notfall-Shell auf der Hauptkonsole. Es ist die minimalste Version eines Systemstarts, um eine interaktive Shell zu erlangen. Mit dieser Unit kann der Bootvorgang Schritt für Schritt begleitet werden.| 
| **rescue.target** | Startet das Basissystem (einschließlich Systemeinhängungen) und eine Notfall-Shell. Im Vergleich zu multi-user.target könnte dieses Ziel als single-user.target betrachtet werden. |
| **multi-user.target** | Mehrbenutzersystem mit funktionierendem Netzwerk, ohne Grafikserver X. Diese Unit wird verwendet, wenn man X stoppen bzw. nicht in X booten möchte. [Auf dieser Unit wird eine Systemaktualisierung (dist-upgrade) durchgeführt](sys-admin-apt_de.md#apt-upgrade) . |
| **graphical.target** | Die Unit für den Mehrbenutzermodus mit Netzwerkfähigkeit und einem laufenden X-Window-System. |
| **default.target** | Die Vorgabe-Unit, die Systemd beim Systemstart startet. In siduction ist dies ein Symlink auf graphical.target (außer NoX). |

Ein Blick in die Dokumentation `man SYSTEMD.SPECIAL(7)` ist obligatorisch um die Zusammenhänge der verschiedenen *.target* - *Unit* zu verstehen.

Bei den Ziel-Unit sind drei Besonderheiten zu beachten:

1. Die Verwendung auf der **Kernel-Befehszeile** beim Bootvorgang.  
    Um im Bootmanager Grub in den Editiermodus zu gelangen, muss man beim Erscheinen der Bootauswahl die Taste `e` drücken. Anschließend hängt man an die Kernel-Befehszeile das gewünschte Ziel mit der folgenden Syntax: "systemd.unit=xxxxxxx.target" an. Die Tabelle listet die Kernel-Befehle und ihre noch gültigen Entsprechungen auf.

    | Ziel-Unit | Kernel-Befehl | Kernel-Befehl alt |
    | --------- | ------------- | :----------: |
    | emergency.target | systemd.unit=emergency.target | - |
    | rescue.target | systemd.unit=rescue.target | 1 |
    | multi-user.target | systemd.unit=multi-user.target | 3 |
    | graphical.target | systemd.unit=graphical.target | 5 |
    
    Die alten Runlevel 2 und 4 verweisen auf multi-user.target


2. Die Verwendung im **Terminal** während einer laufenden Sitzung.
    Vorrausgesetzt man befindet sich in einer laufenden graphischen Sitzung, kann man mit der Tastenkombination `CTRL`+`ALT`+`F2` zum virtuellen Terminal tty2 wechseln. Hier meldet man sich als User **root** an. Die folgende Tabelle listet die **Terminal-Befehle** auf, wobei der Ausdruck *isolate* dafür sorgt, dass alle Dienste die die Ziel-Unit nicht anfordert, beendet werden.

    | Ziel-Unit | Terminal-Befehl | init-Befehl alt |
    | --------- | --------------- | :-------------: |
    | emergency.target | systemctl isolate emergency.target | - |
    | rescue.target | systemctl isolate rescue.target | init 1 |
    | multi-user.target | systemctl isolate multi-user.target | init 3 |
    | graphical.target | systemctl isolate graphical.target | init 5 |


3. Ziel-Unit, die **nicht direkt aufgerufen** werden sollen.  
    Eine ganze Reihe von Ziel-Unit sind dazu da während des Bootvorgangs oder des .target-Wechsels Zwischenschritte mit Abhängigkeiten zu gruppieren. Die folgende Liste zeigt drei häufig verwendete Kommandos die **nicht** mit der Syntax "isolate xxxxxxx.target" aufgerufen werden sollen.


    | Ziel | Terminal-Befehl | init-Befehl alt |
    | --------- | --------------- | :-------------: |
    | halt | systemctl halt | - |
    | poweroff | systemctl poweroff | init 0 |
    | reboot | systemctl reboot | init 6 |

*halt*, *poweroff* und *reboot* holen mehrere Unit in der richtigen Reihenfolge herein, um das System geordnet zu beenden und ggf. einen Neustart auszuführen.

-----

<div class="divider" id="systemd-service"></div>

### systemd.service



~~~
# systemctl disable bluetooth.service
  Synchronizing state of bluetooth.service with SysV service script with /lib/systemd/systemd-sysv-install.
  Executing: /lib/systemd/systemd-sysv-install disable bluetooth
  insserv: Script ssh has overlapping Default-Start and Default-Stop runlevels (2 3 4 5) and (2 3 4 5). This should be fixed.
  insserv: Script cron has overlapping Default-Start and Default-Stop runlevels (2 3 4 5) and (2 3 4 5). This should be fixed.
  insserv: Script rsync has overlapping Default-Start and Default-Stop runlevels (2 3 4 5) and (2 3 4 5). This should be fixed.
  insserv: warning: current start runlevel(s) (empty) of script `bluetooth' overrides LSB defaults (2 3 4 5).
  insserv: warning: current stop runlevel(s) (0 1 2 3 4 5 6) of script `bluetooth' overrides LSB defaults (0 1 6).
  Removed /etc/systemd/system/dbus-org.bluez.service.
  Removed /etc/systemd/system/bluetooth.target.wants/bluetooth.service.
~~~
  

~~~
# systemctl is-enabled bluetooth.service  
disabled
~~~


-----

<div class="divider" id="systemd-timer"></div>

### systemd.timer
















-----

### Journalctl beherrschen

Jetzt kannst Du das Journal als einfacher User benutzen. Hier sind einige Beispiele:

+ journalctl --all - gibt das volle Journal aller User aus

+ journalctl -b – zeigt das Protokoll des letzten Bootvorgangs

+ journalctl -b -p err - limitiert auf den letzten Boot und die Priorität ERROR

+ journalctl --since=yesterday - zeigt das Journal seit gestern

+ journalctl /dev/sda - zeigt das Journal der Gerätedatei /dev/sda

+ journalctl /usr/bin/dbus-daemon - zeigt alle Logs des D-Bus-Daemon

+ journalctl -k -b -1 - zeigt alle Kernelmeldungen des vorherigen Bootvorgangs (-1)

+ journalctl -f - zeigt eine Liveansicht des Journal; früher: tail -f /var/log/messages)

Der zusätzliche Parameter  **-x**  ergänzt die jeweilige Ausgabe um Hilfstexte, sofern vorhanden.

Eine weitere Neuerung beim Protokollieren ist die Tab-Vervollständigung für Journalctl. Wenn Du  *journalctl*  schreibst und die TAB-Taste drückst, erscheint eine Liste möglicher Vervollständigungen:

~~~
$ journalctl
_AUDIT_FIELD_APPARMOR=        ERRNO=                        SEAT_ID=
_AUDIT_FIELD_CAPABILITY=      _EXE=                         _SELINUX_CONTEXT=
_AUDIT_FIELD_CAPNAME=         EXECUTABLE=                   SESSION_ID=
_AUDIT_FIELD_DENIED_MASK=     EXIT_CODE=                    SHUTDOWN=
_AUDIT_FIELD_INFO=            EXIT_STATUS=                  SLEEP=
_AUDIT_FIELD_NAME=            _FSUID=                       _SOURCE_MONOTONIC_TIMESTAMP=
_AUDIT_FIELD_OPERATION=       _GID=                         _SOURCE_REALTIME_TIMESTAMP=
_AUDIT_FIELD_OUID=            GLIB_DOMAIN=                  _STREAM_ID=
_AUDIT_FIELD_PEER=            GLIB_OLD_LOG_API=             SYSLOG_FACILITY=
_AUDIT_FIELD_PROFILE=         _HOSTNAME=                    SYSLOG_IDENTIFIER=
_AUDIT_FIELD_REQUESTED_MASK=  INVOCATION_ID=                SYSLOG_PID=
_AUDIT_FIELD_SIGNAL=          JOB_ID=                       SYSLOG_RAW=
_AUDIT_ID=                    JOB_RESULT=                   SYSLOG_TIMESTAMP=
_AUDIT_LOGINUID=              JOB_TYPE=                     _SYSTEMD_CGROUP=
_AUDIT_SESSION=               JOURNAL_NAME=                 _SYSTEMD_INVOCATION_ID=
_AUDIT_TYPE=                  JOURNAL_PATH=                 _SYSTEMD_OWNER_UID=
_AUDIT_TYPE_NAME=             _KERNEL_DEVICE=               _SYSTEMD_SESSION=
AVAILABLE=                    _KERNEL_SUBSYSTEM=            _SYSTEMD_SLICE=
AVAILABLE_PRETTY=             KERNEL_USEC=                  _SYSTEMD_UNIT=
_BOOT_ID=                     LEADER=                       _SYSTEMD_USER_SLICE=
_CAP_EFFECTIVE=               LIMIT=                        _SYSTEMD_USER_UNIT=
_CMDLINE=                     LIMIT_PRETTY=                 THREAD_ID=
CODE_FILE=                    _LINE_BREAK=                  TIMESTAMP_BOOTTIME=
CODE_FUNC=                    _MACHINE_ID=                  TIMESTAMP_MONOTONIC=
CODE_LINE=                    MAX_USE=                      _TRANSPORT=
_COMM=                        MAX_USE_PRETTY=               _UDEV_DEVNODE=
COMMAND=                      MESSAGE=                      _UDEV_SYSNAME=
CONFIG_FILE=                  MESSAGE_ID=                   _UID=
CONFIG_LINE=                  NM_CONNECTION=                UNIT=
CURRENT_USE=                  NM_DEVICE=                    UNIT_RESULT=
CURRENT_USE_PRETTY=           NM_LOG_DOMAINS=               USER_ID=
DISK_AVAILABLE=               NM_LOG_LEVEL=                 USER_INVOCATION_ID=
DISK_AVAILABLE_PRETTY=        N_RESTARTS=                   USERSPACE_USEC=
DISK_KEEP_FREE=               _PID=                         USER_UNIT=
DISK_KEEP_FREE_PRETTY=        PRIORITY=                     
~~~

Die meisten davon sind selbsterklärend. Beispielsweise COMM, was für  *command*  steht, bedient eine Menge an Optionen:

 *journalctl _COMM=*  listet nach einem weiterer Druck auf TAB die möglichen Applikationen:

~~~
$ journalctl _COMM=
acpid           cups            kdm            ntp            sensors         systemd-shutdow
acpi-fakekey    dbus-daemon     keyboard-setup ntpd           sh              systemd-udevd
acpi-support    ddclient        loadcpufreq    ntpdate        smartmontools   teamviewerd
alsactl         docvert-convert logger         ofono          smbd            udev-configure-
anacron         glances         login          ofonod         ssh             udisksd
apache2         gpasswd         lvm            pkexec         sshd            udisks-daemon
backlighthelper gpm             lvm2           polkitd        su              umount
bash            groupadd        mbmon          pulseaudio     sudo            uptimed
bluetoothd      hddtemp         mdadm          pywwetha       sysstat         useradd
chfn            hdparm          mdadm-raid     pywwetha.py    systemd         usermod
chrome          hp              mtp-probe      resolvconf     systemd-fsck    vboxdrv
console-kit-dae hpfax           mysql          rpcbind        systemd-hostnam VBoxExtPackHelp
console-setup   ifup            networking     rpc.statd      systemd-journal vdr
cpufrequtils    irqbalance      nfs-common     samba-ad-dc    systemd-logind  winbind
cron            kbd             mbd            saned          systemd-modules	
~~~

Beispielsweise könnte der Befehl

    $ journalctl _COMM=ntp

etwas ähnliches für NTP aus dem Log filtern: 

~~~
-- Logs begin at Fr 2014-01-17 00:40:01 CET, end at Di 2014-04-08 11:58:36 CEST. --
Jan 17 14:27:33 siductionbox ntp[1221]: Starting NTP server: ntpd.
^[[1;39m-- Reboot --
Feb 01 00:21:20 siductionbox ntp[1187]: Starting NTP server: ntpd.
^[[1;39m-- Reboot --
Feb 14 14:17:05 siductionbox ntp[1127]: Starting NTP server: ntpd.
^[[1;39m-- Reboot --
Feb 14 14:22:25 siductionbox ntp[1195]: Starting NTP server: ntpd.
^[[1;39m-- Reboot --
Feb 14 23:23:38 siductionbox ntp[3162]: Stopping NTP server: ntpd.
^[[1;39m-- Reboot --
Mär 27 15:15:11 siductionbox ntp[12735]: Stopping NTP server: ntpd.
~~~

Jetzt kann man die Ausgabe weiter filtern und zeitlich eingrenzen:   
journalctl _COMM=dbus-daemon --since=2014-04-06 --until="2014-04-07 23:59:59":

~~~
...
Apr 07 22:59:04 siductionbox org.gtk.Private.GPhoto2VolumeMonitor[2006]: ### debug: in handle_supported
Apr 07 22:59:04 siductionbox org.gtk.Private.GPhoto2VolumeMonitor[2006]: ### debug: in handle_list
Apr 07 22:59:04 siductionbox org.gtk.Private.GoaVolumeMonitor[2006]: ### debug: in handle_supported
Apr 07 22:59:04 siductionbox org.gtk.Private.GoaVolumeMonitor[2006]: ### debug: in handle_list
Apr 07 23:03:09 siductionbox org.gtk.Private.GPhoto2VolumeMonitor[2006]: ### debug: Name owner ':1.4320' vanished
Apr 07 23:03:09 siductionbox org.gtk.Private.GoaVolumeMonitor[2006]: ### debug: Name owner ':1.4320' vanished
Apr 07 23:03:09 siductionbox org.gtk.Private.AfcVolumeMonitor[2006]: ### debug: Name owner ':1.4320' vanished
Apr 07 23:03:09 siductionbox org.gtk.Private.MTPVolumeMonitor[2006]: ### debug: Name owner ':1.4320' vanished
~~~

Weitere Optionen bietet die Manpage von  *journalctl*.

### Handhabung von Diensten mittels Systemd

Einer der Jobs von Systemd ist es Dienste zu starten, zu stoppen oder sonstwie zu steuern. Dazu dient der Befehl `systemctl`.

+ systemctl --all - shows all units, including dead/empty ones

+ systemctl --t [NAME] - lists only units of a particular type

+ systemctl list-units - lists all units (where unit is the term for a job/service

+ systemctl start [NAME...] - starts (activate) one or more units

+ systemctl stop [NAME...] - stops (deactivates) one or more units

+ systemctl disable [NAME...] - disables one or more unit files

+ systemctl status [Name] - shows runtime status of one or more units

+ systemctl reboot – reboots the system

+ systemctl poweroff - powers down the system

Systemctl kann auch beispielsweise mit  *grep*  kombiniert werden:

~~~
systemctl list-unit-files |grep enabled
~~~

### Zwischen Runleveln wechseln

Systemd kennt neue Regeln zum Wechseln zwischen dem, was bisher als Runlevel bekannt war. Der neue Terminus ist `target` 
Die Eingabe im root-Terminal lautet:

+ `systemctl isolate graphical.target`  
Wechselt in die graphische Oberfläch mit Netzwerk und Multiuser (bisher init 5). Das ist das Standardziel beim booten von siduction.

+ `systemctl isolate multi-user.target`  
Wechselt in den Multiuser-Level ohne graphische Oberfläche mit Netzwerk (bisher init 3). Dieses Ziel ist für die Systemaktualisierung zu benutzen.

Um zum Beispiel gleich in den Modus für die Systemaktualisierung zu booten, muss im Bootmanager an die Kernelbefehlszeile folgendes Komando angehängt werden:

+ `systemd.unit=multi-user.target`

Weitere Optionen zu den boot - target bieteten die Manpage von *systemd.special(7)* und *systemd.target(5)*.

### Wichtig: Nutzung der bisher gewohnten Befehle:

Solange  *systemd-sysv*  installiert ist, kannst Du selbst entscheiden, ob Du die gewohnten Befehle verwenden willst oder die neuen Befehle von Systemd übernehmen willst. Du kannst auch beide Arten mixen bis die neuen Befehle im Gedächtnis verankert sind. Diese Kompatibilität wird vermutlich für die Lebensspanne von Debian 8 "Jessie" erhalten bleiben, also rund 4-5 Jahre.

### Andere Funktionen von Systemd

Systemd bietet noch weitere Funktionen. Eine davon ist [logind](http://www.freedesktop.org/software/systemd/man/systemd-logind.service.html)  als Ersatz für das nicht mehr weiter gepflegte  *ConsoleKit* . Damit steuert Systemd Sitzungen und Powermanagement. Nicht zuletzt bietet Systemd eine Menge an weiteren Möglichkeiten wie beispielsweise das Aufspannen einen Containers (ähnlich einer Chroot) mittels [systemd-nspawn](http://0pointer.de/public/systemd-man/systemd-nspawn.html)  und viele weitere. Ein Blick in die Linkliste auf   [Freedesktop](http://www.freedesktop.org/wiki/Software/systemd/)  ermöglicht weitere Entdeckungen, unter anderem auch die ausführliche Dokumentation von Lennart Poettering zu Systemd.

<div id="rev">Seite zuletzt aktualisert 22.11.2014 1800 UTC</div>
