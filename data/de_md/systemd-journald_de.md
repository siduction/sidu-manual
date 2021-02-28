% Systemadministration - journald

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: WIP**

Änderungen 2021-02:

+ Datei neu angelegt und Journald aus sys-admin-systemd_de.md entfernt.
+ Für die Verwendung mit pandoc optimiert.

ENDE   INFOBEREICH FÜR DIE AUTOREN

---

## Systemjournal

---

### Journalctl beherrschen

Jetzt kannst Du das Journal als einfacher User benutzen. Hier sind einige Beispiele:

+ systemctl is-failed *.service


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

---

<div id="rev">Seite zuletzt aktualisert 2021-02-06</div>
