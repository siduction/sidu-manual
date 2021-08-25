BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC2**

Necessary work:

+ check spelling  

Work done

+ check intern links  
+ check extern links  
+ check layout  

END   INFO AREA FOR THE AUTHORS  
% Systemd - timer

## systemd-timer

The basic and introductory information about Systemd is contained in the manual page [systemd-start](0710-systemd-start_en.md#systemd---the-system-and-services-manager) The sections *[Unit]* and *[Install]* concerning all unit files are dealt with in our manual page [systemd unit file](0711-systemd-unit-datei_en.md#systemd-unit-file).  
In this manual page we explain the function of the unit **systemd.timer**, which can be used to trigger time-controlled actions.

The "*.timer*"-Unit is mostly used to do regularly occurring actions. For this a "*.service*" unit of the same name is necessary, in which the actions are defined. As soon as the system timer matches the time defined in the "*.timer*" unit, the "*.timer*" unit activates the "*.service*" unit of the same name.  
If configured accordingly, missed runs while the machine was off can be made up.  
It is also possible for a "*.timer*" unit to trigger the desired actions only once at a previously defined time.

### Required files

The **systemd-timer** unit needs two files with the same base name in the directory */usr/local/lib/systemd/system/* for its function. (If necessary, create the directory beforehand with the command `mkdir -p /usr/local/lib/systemd/system/`). These are the

+ timer unit file (xxxxx.timer), which contains the timing and trigger for the service unit  
    and the  
+ service unit file (xxxxx.service), which contains the action to be started.

For more extensive actions, the third file is a script in */usr/local/bin/* that is executed by the service unit.

In the example we create a regular backup with *rsync*.

### service unit for timer

The *.service-unit* that executes the backup is activated and controlled by the *.timer-unit* and therefore does not need an *[Install]* section. Thus the description of the unit in the *[Unit]* section is sufficient. Your section *[Service]* contains the command to be executed after the option *ExecStart=*.

We create the file **backup.service** in the directory */usr/local/lib/systemd/system/* with the following content.

~~~
[Unit]
Description="Command to backup my home directory"

[Service]
Type=oneshot
ExecStart=/usr/bin/rsync -a --exclude=.cache/* /home/<user> /mnt/sdb5/backup/home/
~~~

Please replace the string \<user\> with your own user.

### create timer unit

We create the file **backup.timer** in the directory */usr/local/lib/system/system/* with the following content.

~~~
[Unit]
Description="Backup my home directory"

[Timer]
OnCalendar=*-*-* 19:00:00
Persistent=true

[Install]
WantedBy=timers.target
~~~

**Explanations**  
The *.timer-Unit* must contain the section *[Timer]*, which defines when and how the corresponding *.service-Unit* is triggered.  
There are two timer types available:

1. realtime timers,  
    which defines a realtime (i.e. wall clock) timer with the `OnCalendar=` option.  
    (the example "*OnCalendar=\*-\*-\* 19:00:00*" means "daily at 19:00"),
    
    and  
2. monotonic timers,  
    which defines a timer relative to the option with the options `OnActiveSec=, OnBootSec=, OnStartupSec=, OnUnitActiveSec=, OnUnitInactiveSec=`.  
    "*OnBootSec=90*" means "90 seconds after bootup" and  
    "*OnUnitActiveSec=1d*" means "One day after the timer was last activated".  
    Both options together trigger the associated *.service-Unit* 90 seconds after the boots and then exactly every 24 hours as long as the machine is not shut down.

The "*Persistent=*" option included in the example saves the time when the *.service-Unit* was last triggered as an empty file in the */var/lib/systemd/timers/* directory. This is useful for catching up on missed runs when the machine was off.

**mount timer unit**

We incorporate the *.timer unit* into systemd with the following command.

~~~
# systemctl enable backup.timer
Created symlink /etc/systemd/system/timers.target.wants/backup.timer \
  → /usr/local/lib/systemd/system/backup.timer.
~~~

The analogous command for the *.service-unit* is not necessary and would also lead to an error, since there is no *[install]* section in it.

**Trigger timer unit manually**.

Not the *.timer-Unit*, but the *.service-Unit* to be triggered by it is called.

~~~
# systemctl start backup.service
~~~

### timer unit as cron replacement

"*cron*" and "*anacron*" are the best known and widely used job timers. Systemd timers can be an alternative. We briefly look at the benefits of, and caveats to Systemd timers.

**Benefits**

+ Jobs can have dependencies (depend on other Systemd services).
+ Timer units are logged in the Systemd journal.
+ You can easily call a job independently from its timer.
+ You can give Timer Units a nice value or use cgroups for resource management.
+ Systemd Timer Units can be triggered by events like booting or hardware changes.
+ They can be easily enabled or disabled with systemctl.

**Caveats**

+ Configuring a cron job is a simple process.
+ Cron can send emails using the MAILTO variables. 

### Sources systemd-timer

~~~
man systemd.timer
~~~

[Archlinux Wiki, Timers](https://wiki.archlinux.org/index.php/Systemd/Timers)  
[PRO-LINUX.DE, Systemd Timer Units...](https://www.pro-linux.de/artikel/2/1992/systemd-timer-units-f%C3%BCr-zeitgesteuerte-aufgaben-verwenden.html)

<div id="rev">Page last updated 2021/25/08</div>
