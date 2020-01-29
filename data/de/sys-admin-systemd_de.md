<div class="divider" id="systemd"></div>

## **Systemd** - System- und Dienste-Manager

`Systemd ist ein System- und Service-Manager, der mit seiner Init-Komponente in Konkurrenz zum alteingesessenen Sysvint und Ubuntus Upstart steht. Entwickelt wird es federführend von den Red Hat Entwicklern Lennart Poettering und Kay Sievers. Debian wird Systemd als Standard bei Debian 8 "Jessie" einführen, Ubuntu wird die Entwicklung von Upstart zugunsten von Systemd aufgeben. Seit der Veröffentlichung von 2013.2 "December" benutzt siduction bereits Systemd als Standard-Init-System .` 

---

Wenn Du eine ältere Version als siduction 2013.2 "December" verwendest und auf Systemd umsteigen möchtest, so ist das weder schwierig noch fehleranfällig und in ein paar Schritten erledigt. Nach der Installation einiger Pakete und dem Setzen einiger Rechte muss lediglich noch sichergestellt werden, dass Systemd auch als Standard verwendet wird.

### Installation und Einrichten von Systemd

Den Anfang macht die Installation der Pakete :

~~~
# apt update && apt install systemd libpam-systemd systemd-ui
~~~

Es kann vorkommen, da Sysvinit ein essentielles Paket ist, das beim Entfernen desselbigen folgende Warnmeldung bestätigt werden muss.

~~~
WARNING: The following essential packages will be removed: sysvinit
This should NOT be done unless you know exactly what you are doing!
You are about to do something potentially harmful.
To continue type in the phrase 'Yes, do as I say!'
~~~

Die Antwort muss lauten:

~~~
Yes, do as I say!
~~~

Jetzt ist der Zeitpunkt, eine kleine Sicherung einzubauen, falls Systemd sich einmal weigern sollte, den Rechner zu starten:

~~~
# cp -av /sbin/init /sbin/init.sysvinit
~~~

Mit dieser Absicherung kann der Rechner notfalls mit Sysvinit gestartet werden, indem folgendes in die Bootzeile von GRUB angehängt wird:

~~~
init=/sbin/init.sysvinit
~~~

Nun bleibt nur noch ein Paket zu installieren, dass uns die Kompatibilität mit Sysvinit und den gewohnten Befehlen erhält:

~~~
# apt install systemd-sysv
~~~

Um Systemd zu testen bevor es als Standard festgelegt wird, kann während eines Reboots folgender Pfad an die Bootzeile in GRUB übergeben werden:

~~~
init=/lib/systemd/systemd
~~~

Nach erfolgtem Reboot kann der Erfolg überprüft werden:

~~~
# ps -p 1
~~~

Die Ausgabe sollte in etwa so aussehen:

~~~
 1 ? 00:00:07 systemd
~~~

Das bedeutet, sysytemd läuft als PID 1, der erste Prozess beim Start des Rechners.

Wenn alles zur Zufriedenheit funktioniert, können die Einstellingen permanent gemacht werden, indem `/etc/default/grub`  editiert wird

Im zweiten Absatz findet sich die Zeile:

~~~
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
~~~

Die Zeile muss editiert werden, um dann so auszusehen:

~~~
GRUB_CMDLINE_LINUX_DEFAULT="quiet init=/lib/systemd/systemd"
~~~

Nun muss GRUB noch von der Änderung erfahren. Das erledigt ein:

~~~
# update grub
~~~

Ein erneuter Neustart und der Check nach PID 1 sollte Systemd als PID 1 zeigen. Damit ist die Installation und Einrichtung abgeschlossen. Jetzt ist der Blick frei für die Dinge, die Systemd besser macht als der Vorgänger oder die Sysvinit als reiner Init-Dienst gar nicht konnte.

### Einrichten des Journals

Das  *Journal*  ist ein Ersatz für  *Syslog*  und macht einiges besser als sein Vorgänger. Journal protokolliert viel früher als Syslog, da es Informationen des Kernel-Loggers  *kmesg*  mit einbezieht. Zudem sind auch die Auswertungsmöglichkeiten des Journal deutlich besser als vorher. Das Journal kann außerdem auch als normaler User benutzt werden, wenn wir es entsprechend einrichten. Dazu müssen wir unseren User einer neuen Gruppe zufügen und die Rechte entsprechend setzten. Diese Schritte müssen nur bei siduction 2013.2 und früher vorgenommen werden. Bei siduction ab 2014.1 ist bereits alles entsprechend eingerichtet.

Zunächst richten wir die Gruppe ein:

~~~
# addgroup --system systemd-journal
~~~

Dann erstellen wir einen Ordner für das Journal, da das bei Debian noch nicht automatisch passiert:

~~~
# mkdir -p /var/log/journal
~~~

Und nun zu den Rechten:

~~~
# chown root:systemd-journal /var/log/journal
~~~

Nun fügen wir den neuen Nutzer noch der Gruppe hinzu:

~~~
# gpasswd -a $user systemd-journal
~~~

Für$user muss hier der eigene User eingetragen werden

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
devil@siductionbox:~$ journalctl 
_AUDIT_LOGINUID= COREDUMP_EXE= _MACHINE_ID= _SOURCE_REALTIME_TIMESTAMP= _TRANSPORT=
_AUDIT_SESSION= __CURSOR= MESSAGE= SYSLOG_FACILITY= _UDEV_DEVLINK=
_BOOT_ID= ERRNO= MESSAGE_ID= SYSLOG_IDENTIFIER= _UDEV_DEVNODE=
_CMDLINE= _EXE= __MONOTONIC_TIMESTAMP= SYSLOG_PID= _UDEV_SYSNAME=
CODE_FILE= _GID= _PID= _SYSTEMD_CGROUP= _UID=
CODE_FUNC= _HOSTNAME= PRIORITY= _SYSTEMD_OWNER_UID= 
CODE_LINE= _KERNEL_DEVICE= __REALTIME_TIMESTAMP= _SYSTEMD_SESSION= 
_COMM= _KERNEL_SUBSYSTEM= _SELINUX_CONTEXT= _SYSTEMD_UNIT= 
~~~

Die meisten davon sind selbsterklärend. Beispielsweise COMM, was für  *command*  steht, bedient eine Menge an Optionen:

 *journalctl _COMM=*  listet nach einem weiterer Druck auf TAB die möglichen Applikationen:

~~~
devil@siductionbox:~$ journalctl _COMM=
acpid chrome gpasswd kdm mtp-probe pkexec sensors systemd-fsck udisks-daemon
acpi-fakekey console-kit-dae gpm keyboard-setup mysql polkitd sh systemd-hostnam umount
acpi-support console-setup groupadd loadcpufreq networking pulseaudio smartmontools systemd-journal uptimed
alsactl cpufrequtils hddtemp logger nfs-common pywwetha smbd systemd-logind useradd
anacron cron hdparm login nmbd pywwetha.py ssh systemd-modules usermod
apache2 cups hp lvm ntp resolvconf sshd systemd-shutdow vboxdrv
backlighthelper dbus-daemon hpfax lvm2 ntpd rpcbind su systemd-udevd VBoxExtPackHelp
bash ddclient ifup mbmon ntpdate rpc.statd sudo teamviewerd vdr
bluetoothd docvert-convert irqbalance mdadm ofono samba-ad-dc sysstat udev-configure- winbind
chfn glances kbd mdadm-raid ofonod saned systemd udisksd 
~~~

Beispielsweise könnte etwas ähnliches für NTP aus dem Log filtern  

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


Jetzt kann man die Ausgabe weiter filtern und beispielsweise zeitlich eingrenzen:   journalctl _COMM=dbus-daemon --since=2014-04-06 --until="2014-04-07 23:59:59":

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

Weitere Optionen bietet die Manpage von  *journalctl* .Jetzt kann rsyslog entfernt werden, du kannst es aber auch neben dem Journal weiterlaufen lassen.

### Handhabung von Diensten mittels Systemd

Einer der Jobs von Systemd ist es Dienste zu starten, zu stoppen oder sonstwie zu steuern. Dazu dient der Befehl <span class="highlight-3">systemctl<span>-c
+ systemctl --all - shows all units, including dead/empty ones

+ systemctl --t [NAME] - lists only units of a particular type

+ systemctl list-units - lists all units (where unit is the term for a job/service

+ systemctl start [NAME...] - starts (activate) one or more units

+ systemctl stop [NAME...] - stops (deactivates) one or more units

+ systemctl disable [NAME...] - disables one or more unit files

+ systemctl status [Name] - shows runtime status of one or more units

+ systemctl reboot – reboots the system

+ systemctl poweroff - powers down the system

Systemctl kann auch beispielsweise mit  *grep *  kombiniert werden:

~~~
systemctl list-unit-files |grep enabled
~~~

### Zwischen Runleveln wechseln

Systemd kennt neue Regeln zum Wechseln zwischen dem, was bisher als Runlevel bekannt war Der neue Terminus ist `targets` 

+ systemctl isolate graphical.target - wechselt nach init 5

+ systemctl isolate multi-user.target - wechselt nach init 3

Weitere Optionen bietet die Manpage von  *systemctl* 

### Wichtig: Nutzung der bisher gewohnten Befehle:

Solange  *systemd-sysv*  installiert ist, kannst Du selbst entscheiden, ob Du die gewohnten Befehle verwenden willst oder die neuen Befehle von Systemd übernehmen willst. Du kannst auch beide Arten mixen bis die neuen Befehle im Gedächtnis verankert sind. Diese Kompatibilität wird vermutlich für die Lebensspanne von Debian 8 "Jessie" erhalten bleiben, also rund 4-5 Jahre.

### Andere Funktionen von Systemd

Systemd bietet noch weitere Funktionen. Eine davon ist [logind](http://www.freedesktop.org/software/systemd/man/systemd-logind.service.html)  als Ersatz für das nicht mehr weiter gepflegte  *ConsoleKit* . Damit steuert Systemd Sitzungen und Powermanagement. Nicht zuletzt bietet Systemd eine Menge an weiteren Möglichkeiten wie beispielsweise das Aufspannen einen Containers (ähnlich einer Chroot) mittels [systemd-nspawn](http://0pointer.de/public/systemd-man/systemd-nspawn.html)  und viele weitere. Ein Blick in die Linkliste auf   [Freedesktop](http://www.freedesktop.org/wiki/Software/systemd/)  ermöglicht weitere Entdeckungen, unter anderem auch die ausführliche Dokumentation von Lennart Poettering zu Systemd.

<div id="rev">Seite zuletzt aktualisert 22.11.2014 1800 UTC</div>
