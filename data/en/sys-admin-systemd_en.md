<div id="main-page"></div>
<div class="divider" id="systemd"></div>
## Systemd: system and service manager

`Systemd is a system and service manager, that with it's init component competes with the weathered sysvinit and Ubuntu's upstart. It is developed mainly by Red Hat developer Lennart Poettering. Debian will use systemd as standard with the release of Debian 8 "Jessie", Ubuntu will give up on upstart and also move to systemd. Since the release of 2013.2 "December" siduction already ships systemd as our default init system and for different administration tasks.` 


---

If you are using an older version of siduction than 2013.2 "December" and would like to update to systemd, this is not complicated or error prone at all, it is a straight forward process of installing a few packages, setting some rights and letting the system know that you would like to boot with systemd from now on.

### Installing and setting up systemd

Lets start with installing the needed packages:

~~~  
# apt update && apt install systemd libpam-systemd systemd-ui  
~~~

It may happen that, because sysvinit is tagged as an essential package, that you have to confirm the following warning

~~~  
WARNING: The following essential packages will be removed: sysvinit  
This should NOT be done unless you know exactly what you are doing!  
You are about to do something potentially harmful.  
To continue type in the phrase 'Yes, do as I say!'  
~~~

To answer that correctly, you need to type exactly that:

~~~  
Yes, do as I say!  
~~~

Now, if you like, you can install a fallback solution to be able to start your computer, should systemd refuse to boot:

~~~  
# cp -av /sbin/init /sbin/init.sysvinit  
~~~

With this safety net you can always switch back to sysvinit by adding to the kernel commandline at boot:

~~~  
init=/sbin/init.sysvinit  
~~~

Now you need to install one more package that will warrant compatibility to sysvinit for now, meaning you can choose if you want to use systemd's new commands or the ones you are used to:

~~~  
# apt install systemd-sysv  
~~~

To test systemd before switching to it by default, you can add the following boot parameter to the kernel commandline, when booting:

~~~  
init=/lib/systemd/systemd  
~~~

After a reboot you can check if systemd runs as PID 1 by:

~~~  
ps -p 1  
~~~

Your output should look something like:

~~~  
 1 ? 00:00:07 systemd  
~~~

That means, systemd is running as your first process, the init, that starts everything else.

If everything works ok, you can make the settings permanent. To use systemd as your init system permanently, you need to edit `/etc/default/grub` 

In the second paragraph you find a line like:

~~~  
GRUB_CMDLINE_LINUX_DEFAULT="quiet"  
~~~

Edit the line to make it look like:

~~~  
GRUB_CMDLINE_LINUX_DEFAULT="quiet init=/lib/systemd/systemd"  
~~~

To make the changes known to GRUB, you need to run:

~~~  
# update grub  
~~~

Another reboot and check for PID 1 should show systemd as init. The initial install and testing is done now. Lets look at some things that systemd does better than sysvinit or that sysvinit does not do at all since it is a pure init handling system.

### Setting up the journal

First of all, wevset up the  *journal* . It is a substitute for the trusty and rusty old  *rsyslog* . Journal does a few things better than  *rsyslog* . The biggest gain is, that it starts logging a lot earlier in the boot process than  *rsyslog* . That is possible because it drafts from the kernels logging system  *kmesg* . Besides that, the options to query the journal are superiour to the old ways. So you can either remove  *rsyslog*  now or do that later. You can also run both side by side. The journal can also be read and queried as a simple user, no root needed. For that you have to add your user to a new group and grant the appropriate rights. The following steps are only needed if you run siduction 2013.2 or earlier. From siduction 2014.1.0 these settigs are integrated already.

First you set up the new group:

~~~  
# addgroup --system systemd-journal  
~~~

Then you create a directory for the journal, as debian does not do that for you yet:

~~~  
# mkdir -p /var/log/journal  
~~~

Now you set the ownership of that directory:

~~~  
# chown root:systemd-journal /var/log/journal  
~~~

You just need to add your user to the new group now and be done with it:

~~~  
# gpasswd -a $user systemd-journal  
~~~

You need to substitute your actual user with $user

### Mastering journalctl

Now you can access the journal as user. Lets see how that is done:

+ journalctl --all - gives you the full journal of the system and all users  
+ journalctl -b – shows the protocol of the last boot  
+ journalctl -b -p err - limits it to the last boot and limits it to priority ERROR  
+ journalctl --since=yesterday - since Linux people normaly do not reboot often, this might be limiting it more than -b  
+ journalctl /dev/sda - shows all logs of the kernel device node /dev/sda  
+ journalctl /usr/bin/dbus-daemon - shows all logs generated by the D-Bus executable  
+ journalctl -k -b -1 - shows all kernel logs from previous boot (-1))  
+ journalctl -f - gives you a live view of the journal as it grows (used to be tail -f /var/log/messages)  

Another fine feature is the tab completion of journalctl. If you enter journalctl and hit your [TAB] key, you will get a list of possible options 

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

Most of these are self explanatory. Lets pick a common one like COMM for command and see what we can do with it:

journalctl _COMM= and hitting TAB will list the available apps:

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

Now we can specify what we want to look at.  
~~~    
$ journalctl _COMM=ntp could output something like: 

  
~~~

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

You can now further finegrain that down to hours, minutes and even seconds with e.g.:  
~~~    
journalctl _COMM=dbus-daemon --since=2014-04-06 --until="2014-04-07 23:59:59"which will yield something like:

  
~~~

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

### Handling services with systemd

One of systemd's main jobs is to start, stop or query services. This is done by the <span class="highlight-3">systemctl<span>-command
+ systemctl --all - shows all units, including dead/empty ones  
+ systemctl --t [NAME] - lists only units of a particular type  
+ systemctl list-units - lists all units (where unit is the term for a job/service  
+ systemctl start [NAME...] - starts (activate) one or more units  
+ systemctl stop [NAME...] - stops (deactivates) one or more units  
+ systemctl disable [NAME...] - disables one or more unit files  
+ systemctl status [Name] - shows runtime status of one or more units  
+ systemctl reboot – reboots the system  
+ systemctl poweroff - powers down the system  

Systemctl can be also paired with grep to do things like:

~~~  
systemctl list-unit-files |grep enabled  
~~~

### Switching between runlevels

Systemd has new commands for switching, what was until now called runlevels. The new term is `targets` 

+ systemctl isolate graphical.target - will take you to what you know as init 5  
+ systemctl isolate multi-user.target - will take you to what you know as init 3  

### Important: Using the commands you used before systemd

As long as systemd-sysv is installed, you can decide if you want to use the old commands you are used to or learn and use the new ones. You can also use a mix of both. This goes for as long as systemd-sysv exists. Most likely it will at least be around until the end of life for the upcoming Debian 8 "Jessie", which means at least 4-5 years.

### Other systemd functionality

Sysmtemd offers some more functionality. One of those is  [logind](http://www.freedesktop.org/software/systemd/man/systemd-logind.service.html)  as the successor to the unmaintained  *ConsoleKit* . Last but not least, let me introduce one of the power options systemd offers. With  [systemd-nspawn](http://0pointer.de/public/systemd-man/systemd-nspawn.html)  one can quickly spawn a container for debugging and testing things. There is a lot more to it, so a look into the  [Linklist at Freedesktop](http://www.freedesktop.org/wiki/Software/systemd/) .

 will reveal a lot more, including the systemd blog by Lennart Poettrering.
<div id="rev">Page last revised by devil, 22/11/2014 2100 UTC</div>
