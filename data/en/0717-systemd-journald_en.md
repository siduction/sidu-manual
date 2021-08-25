BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC2**

Necessary work:

+ check spelling  

Work done

+ check intern links (there was'nt any)  
+ check extern links  
+ check layout  

END   INFO AREA FOR THE AUTHORS  
% System journal

## system journal

The system journal consists of the *systemd-journald*, or **journald** for short, which collects and stores log messages, and the **journalctl**, which is used to manage, query and output the collected log messages.

### journald

*journald* is a system service that collects and stores log messages using the *systemd-journald.service* unit (and its associated socket units).  
It creates and maintains structured, indexed journals based on log messages from:

+ Kernel log messages
+ Simple system log messages
+ Structured system log messages via the native journal API
+ Standard output and standard error output from service units
+ Audit records coming from the kernel audit subsystem.

*journald* allows journal "namespaces". They are both a mechanism for logically isolating a log stream from the rest of the system, and also a mechanism for improving performance. Journal namespaces exist concurrently and side-by-side. Each has its own independent log data stream. After siduction is installed, only the system's default namespace exists.

By default, the *journald* stores the log data permanently at  
*/var/log/journal/MASCHINENKENNUNG*.

Log data for other namespaces can be found in  
*/var/log/journal/MASCHINENKENNUNG.NAMENSRAUM*.

The **systemd-cat** command provides two ways to pass data from a process to the journal independently of systemd units.  

1. **`systemd-cat <program> <option(s)>`**.  
  Used with a program call or command, *systemd-cat* redirects all standard input, standard output, and standard error output from a process to the journal.  
2. **Used in a pipe,**  
  *systemd-cat* serves as a filtering tool to send the previously created output to the journal.

If no parameter is passed, *systemd-cat* will send whatever it reads from standard input to the journal. The man-page `man systemd-cat` provides more information.

### journald over the network

The *systemd-journal* modules *upload*, *remote* and *gatewayd* allow system log data to be sent and received between different computers over the network. With their help remote computers can be monitored continuously. In this installation it makes sense to set up namespaces on the remote computer for the log data of the remote computers.  
For more information please read the man-pages [journal upload](https://manpages.debian.org/testing/systemd-journal-remote/systemd-journal-upload.8.en.html), [journal remote](https://manpages.debian.org/testing/systemd-journal-remote/systemd-journal-remote.service.8.en.html) and [journal gatewayd](https://manpages.debian.org/testing/systemd-journal-remote/systemd-journal-gatewayd.8.en.html).

### journald.conf

The following files configure various parameters of the systemd journal service.

+ /etc/systemd/journald.conf  
+ /etc/systemd/journald.conf.d/*.conf  
+ /etc/systemd/journald@NAMENSRAUM.conf (optional)  
+ /run/systemd/journald.conf.d/*.conf (optional)  
+ /usr/lib/systemd/journald.conf.d/*.conf (optional)

The default namespace managed by the systemd-journald.service (and its associated socket units) is configured in */etc/systemd/journald.conf* and associated additions.  
The configuration file contains the defaults as a commented out note to the administrator. To change settings locally, simply edit this file. 

Instances that manage other namespaces are only needed if there is a need to **deviate** from the defaults. Their configuration file is to be created according to the pattern "*etc/systemd/journald@NAMENSRAUM.conf*".  
Service units can be assigned to a particular journal namespace using the unit file setting "*LogNamespace=*".

By default, only the default namespace collects kernel and audit log messages.

**Rank order**

If packages need to customize configuration, they can install configuration snippets in */usr/lib/systemd/\*.conf.d/* or */usr/local/lib/systemd/\*.conf.d/*.

The main configuration file is read before any other from the configuration directories and has the lowest priority. Entries in a file in any of the configuration directories override entries in the main configuration file. Files in the *\*.conf.d/* subdirectories are sorted by their file name, regardless of which subdirectory they are in. If separate configuration files are necessary, it is recommended that all file names in these subdirectories be preceded by a two-digit number and a hyphen to simplify file sorting. 

### journalctl

**journalctl** is used to query the journal created by systemd-journald.  
When called without parameters, the entire contents from all accessible sources of the journal are displayed, starting with the oldest entry. The journal files used for output can be modified with the --user, --system, --directory, and --file options.  
The output is directed page by page by *less*. Long lines can be viewed using the "*arrow-left-*" and "*arrow-right-*" keys. The "*--no-pager*" option disables page-by-page viewing, shortening the lines to the width of the terminal.

**journalctl** offers, in addition to the options described below, a whole range of other options for filtering and formatting the output. Please also read the man page `man journalctl`.

**Rights**

The user root and all users who are members of the groups "*systemd-journal*", "*adm*" and "*wheel*" are granted access to the system journal and the journals of the other users. Siduction adds all configured USER to the "*systemd-journal*" group.

The journal contains trusted fields, i.e. fields that are implicitly added by the journal and cannot be changed by client code. They start with an underscore. (e.g.: _PID=, _UID=, _GID=, _COMM=, _EXE=, _CMDLINE= )

**Filter output**.

+ **options**: -user, - -system, - -directory=, - -file=, - -namespace=.  
  The options limit the **source** of the output to the named scope, directory or file.

+ **options**: -b, -k, -u, -p, -g, -S, -U.  
  The outputs of these options use all available journal files, unless one of the previously mentioned options is used in addition.

  + **-b** (- -boot=)  
    Shows messages from a particular system boot. Without an argument, the logs for the current system startup are displayed. The argument "-1" prints the messages of the system startup before the current one. The argument "5" presents the messages of the fifth system start since the beginning of the records.

  + **-k** (- -dmesg)  
    Displays only kernel messages. This includes the "-b" option so that only kernel messages since the current system start are printed.

  + **-u** (- -unit=)  
    This option requires the specification of a UNIT or a MUSTER.  
    Prints the journal entries for the specified systemd unit UNIT or for all units that match the MUSTER.

  + **-p** (- -priority=)  
    Filters the output by message priorities or priority ranges. Requires specification of a single protocol level, or a range of protocol levels in the form FROM..TO.  
    The log levels are the normal syslog log levels:  
    "emerg" (0), "alert" (1), "crit" (2), "err" (3), "warning" (4), "notice" (5), "info" (6), "debug" (7).  
    Both the names and the digits of the protocol levels can be used as arguments. If a single protocol level is specified, all messages with this or a lower protocol level will be displayed.

  + **-g** (- - grep=)  
    Requires the specification of a PERL-compatible regular expression to filter the output. The regular expression is applied to the "MESSAGE=" field in the journal entries.

  + **-S** (- -since=) and **-U** (- -until=)  
    The display will start with newer entries from the specified date or older entries up to the specified date. The date format should be "2012-10-30 18:17:16", but parts of it can be omitted. Alternatively, the strings "yesterday", "today", "tomorrow" are possible. The argument "now" refers to the current time. The specification of relative times allow a preceding "-" or "+", which refer to times before or after the specified time.

**Control output**

+ options: -f, -n, -r, -o, -x, - -no-pager

  + **-f** (- -follow)  
    Display only the newest journal entries and continuously output new entries. This includes the "-n" option. The output is similar to the old known command "*tail -f /var/log/messages*".

  + **-n** (- -lines=)  
    Shows the latest journal entries and limits the number of events to show. The argument is a positive integer. The default value is 10 if no argument is given.

  + **-r** (- -reverse)  
    The output starts with the newest entry.

  + **-o** (- -output=)  
    Controls the formatting of the displayed journal entries. A number of other options are subordinate to this option, of which we will only consider the "short-full" option here.

    **-o short-full**  
    The output is mostly identical to the formatting of classic syslog files. It displays one line per journal entry, but the timestamp is output in the format that the --since= and --until= options accept. Therefore, this output is very suitable to create a time-based filtering of journal entries in the following.

  + **-x** (- -catalog)  
    Adds explanatory help text to journal lines where available.

  + **- -no-pager**  
    This option disables page-by-page display, shortening the lines to the width of the terminal. Using it is only useful if only a small number of lines is expected for the output.

**control journalctl**

The following options handle the management of data written by *journald*.

+ **- -disk-usage**  
  Displays the current disk space usage of all journal files.

+ **- -vacuum-size=, - -vacuum-time=, - -vacuum-files=**  
  Removes the oldest archived journal files until the disk space they use falls below the specified size, or all archived journal files that do not contain data older than the specified time period, or so that no more than the specified number of separate journal files remain. Executing "*--vacuum-\**" does not include the active journal files.

+ **- -rotate**  
  Asks the journal daemon to rotate the journal files. Journal files rotation has the effect of marking all currently active journal files as archived and renaming them so that in the future they will never be written to again. Then new (empty) journal files will be created instead. This action can be combined with "--vacuum-\*" in a single command to actually achieve the arguments given to "--vacuum-\*".    

+ **- -verify**  
  Checks the journal files for internal consistency.

### control journalctl

As described above under permissions, you can use the journal as a simple user. Here are some examples:

| command | display |
| --- | ----- |
| journalctl | the full journal of all users, oldest entries first |
| journalctl -r | as before, newest entries first |
| journalctl -b | the log of the last boot |
| journalctl -b -1 -k | from the next to last boot (-1) all kernel messages |
| journalctl -b -p err | limited to the last boot and the priority ERROR |
| journalctl --since=yesterday | the journal since yesterday |
| journalctl /dev/sda | the journal of the device file /dev/sda |
| journalctl /usr/bin/dbus-daemon | all logs of the D-Bus daemon |
| journalctl -f | live view of the journal (formerly: tail -f /var/log/messages) |

The option "*--list-boots*" prints the corresponding list.

~~~
# journalctl --list-boots --no-pager
[...]
 -50 8fc07f387... Sun 2021-02-28 11:07:05 CET-Sun 2021-02-28 23:01:56 CET
 -49 aa49cb3af... Mon 2021-03-01 17:49:58 CET-Mon 2021-03-01 20:19:59 CET
 -48 3a6e55a4a... Tue 2021-03-02 12:18:46 CET-Tue 2021-03-02 20:47:24 CET
 -47 a46150a19... Wed 2021-03-03 11:06:29 CET-Wed 2021-03-03 20:33:09 CET
 -46 d42ed8b05... Thu 2021-03-04 10:59:56 CET-Thu 2021-03-04 19:53:26 CET
 -45 566f65991... Thu 2021-03-04 19:53:52 CET-Thu 2021-03-04 19:55:38 CET
 -44 8e2da4a61... Fri 2021-03-05 10:15:18 CET-Fri 2021-03-05 10:20:11 CET
[...]
~~~

Afterwards you can use the command **`journalctl -b -47`** to display the messages of the boot process of 3.3.2021.

Another new feature in logging is the tab completion for journalctl. If you type *journalctl*, and press the TAB key twice, a list of possible completions appears:

~~~
$ journalctl
_AUDIT_FIELD_APPARMOR= ERRNO= SEAT_ID=
_AUDIT_FIELD_CAPABILITY= _EXE= _SELINUX_CONTEXT=
_AUDIT_FIELD_CAPNAME= EXECUTABLE= SESSION_ID=
_AUDIT_FIELD_DENIED_MASK= EXIT_CODE= SHUTDOWN=
_AUDIT_FIELD_INFO= EXIT_STATUS= SLEEP=
_AUDIT_FIELD_NAME= _FSUID= _SOURCE_MONOTONIC_TIMESTAMP=
_AUDIT_FIELD_OPERATION= _GID= _SOURCE_REALTIME_TIMESTAMP=
_AUDIT_FIELD_OUID= GLIB_DOMAIN= _STREAM_ID=
_AUDIT_FIELD_PEER= GLIB_OLD_LOG_API= SYSLOG_FACILITY=
_AUDIT_FIELD_PROFILE= _HOSTNAME= SYSLOG_IDENTIFIER=
_AUDIT_FIELD_REQUESTED_MASK= INVOCATION_ID= SYSLOG_PID=
_AUDIT_FIELD_SIGNAL= JOB_ID= SYSLOG_RAW=
_AUDIT_ID= JOB_RESULT= SYSLOG_TIMESTAMP=
_AUDIT_LOGINUID= JOB_TYPE= _SYSTEMD_CGROUP=
_AUDIT_SESSION= JOURNAL_NAME= _SYSTEMD_INVOCATION_ID=
_AUDIT_TYPE= JOURNAL_PATH= _SYSTEMD_OWNER_UID=
_AUDIT_TYPE_NAME= _KERNEL_DEVICE= _SYSTEMD_SESSION=
AVAILABLE= _KERNEL_SUBSYSTEM= _SYSTEMD_SLICE=
AVAILABLE_PRETTY= KERNEL_USEC= _SYSTEMD_UNIT=
_BOOT_ID= LEADER= _SYSTEMD_USER_SLICE=
_CAP_EFFECTIVE= LIMIT= _SYSTEMD_USER_UNIT=
_CMDLINE= LIMIT_PRETTY= THREAD_ID=
CODE_FILE= _LINE_BREAK= TIMESTAMP_BOOTTIME=
CODE_FUNC= _MACHINE_ID= TIMESTAMP_MONOTONIC=
CODE_LINE= MAX_USE= _TRANSPORT=
_COMM= MAX_USE_PRETTY= _UDEV_DEVNODE=
COMMAND= MESSAGE= _UDEV_SYSNAME=
CONFIG_FILE= MESSAGE_ID= _UID=
CONFIG_LINE= NM_CONNECTION= UNIT=
CURRENT_USE= NM_DEVICE= UNIT_RESULT=
CURRENT_USE_PRETTY= NM_LOG_DOMAINS= USER_ID=
DISK_AVAILABLE= NM_LOG_LEVEL= USER_INVOCATION_ID=
DISK_AVAILABLE_PRETTY= N_RESTARTS= USERSPACE_USEC=
DISK_KEEP_FREE= _PID= USER_UNIT=
DISK_KEEP_FREE_PRETTY= PRIORITY=
~~~

Most of these are self-explanatory. For example COMM, which stands for *command*, serves a lot of options:

 "*journalctl \_COMM=*" lists the possible applications after another press of TAB:

~~~
$ journalctl _COMM=
acpid cups kdm ntp sensors systemd-shutdown
acpi-fakekey dbus-daemon keyboard-setup ntpd sh systemd-udevd
acpi-support ddclient loadcpufreq ntpdate smartmontools teamviewerd
alsactl docvert-convert logger ofono smbd udev-configure-
anacron glances login ofonod ssh udisksd
apache2 gpasswd lvm pkexec sshd udisks-daemon
backlighthelper gpm lvm2 polkitd su umount
bash groupadd mbmon pulseaudio sudo uptimed
bluetoothd hddtemp mdadm pywwetha sysstat useradd
chfn hdparm mdadm-raid pywwetha.py systemd usermod
chrome hp mtp-probe resolvconf systemd-fsck vboxdrv
console-kit-dae hpfax mysql rpcbind systemd-hostnam VBoxExtPackHelp
console-setup ifup networking rpc.statd systemd-journal vdr
cpufrequtils irqbalance nfs-common samba-ad-dc systemd-logind winbind
cron kbd mbd saned systemd-modules	
~~~

With "*journalctl \_COMM=su*" you can now see which user got root privileges with "su" and when.

~~~
# journalctl _COMM=su
-- boot 1b5d2b3fcd9043d88d8abce665b75ed4 --
Mar 10 13:45:53 pc1 su[75259]: (to root) siduser on pts/3
Mar 10 13:45:53 pc1 su[75259]: pam_unix(su:session): session opened for user root(uid=0) by (uid=1000)
Mar 10 16:27:22 pc1 su[105197]: (to root) siduser on pts/1
Mar 10 16:27:22 pc1 su[105197]: pam_unix(su:session): session opened for user root(uid=0) by (uid=1000)
Mar 10 17:54:33 pc1 su[105197]: pam_unix(su:session): session closed for user root
Mar 10 17:54:42 pc1 su[75259]: pam_unix(su:session): session closed for user root
-- boot 37b19f6321814620be1ed4deb3be467f --
Mar 10 17:56:35 pc1 su[3381]: (to root) siduser on pts/1
Mar 10 17:56:35 pc1 su[3381]: pam_unix(su:session): session opened for user root(uid=0) by (uid=1000)
Mar 10 19:07:17 pc1 su[3381]: pam_unix(su:session): session closed for user root
~~~

Another example:  
You can additionally time the output.  

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

Many of the above options can be combined to display only the journal entries you are looking for. The man-page of `man journalctl` describes all options in detail.

### sources journald

~~~
man systemd-journald
man journald.conf
man journalctl
man systemd-cat
~~~

and online for packages not installed by default  
[journal gatewayd](https://manpages.debian.org/testing/systemd-journal-remote/systemd-journal-gatewayd.8.en.html)  
[journal remote](https://manpages.debian.org/testing/systemd-journal-remote/systemd-journal-remote.service.8.en.html)  
[journal upload](https://manpages.debian.org/testing/systemd-journal-remote/systemd-journal-upload.8.en.html)

<div id="rev">Page last updated 2021/25/08</div>
