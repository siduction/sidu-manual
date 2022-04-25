% Systemd - timer

## systemd-timer

The basic and introductory information about systemd can be found on the manual page [systemd-start](0710-systemd-start_en.md#systemd---the-system-and-services-manager). The sections *[Unit]* and *[Install]* concerning all unit files are dealt with on our manual page [systemd unit file](0711-systemd-unit-datei_en.md#systemd-unit-file).  
On this manual page we explain the function of the unit **systemd.timer**, which can be used to trigger time-controlled actions.

The timer unit is mostly used to do regularly occurring actions. For this a service unit of the same name is necessary, in which the actions are defined. As soon as the system timer matches the time defined in the timer unit, the latter activates the service unit of the same name.  
If configured accordingly, missed runs while the machine was off can be made up.  
It is also possible for a timer unit to trigger the desired actions only once at a previously defined time.

### Required files

The **systemd-timer** unit needs two files with the same base name in the directory `/usr/local/lib/systemd/system/` for its function. (If necessary, create the directory beforehand with the command **`mkdir -p /usr/local/lib/systemd/system/`**.) These are

+ the timer unit file (xxxxx.timer), which contains the timing and trigger for the service unit  
    and  
+ the service unit file (xxxxx.service), which contains the action to be started.

For more extensive actions, you can create a script in `/usr/local/bin/` as a third file that is executed by the service unit.

In the example we create a regular backup with `rsync`.

### Service unit for timer

The service unit that executes the backup is activated and controlled by the timer unit and therefore does not need an [Install] section. Thus the unit's description in the [Unit] section is sufficient. Your [Service] section contains the command to be executed after the option `ExecStart=`.

We create the file `backup.service` in the directory `/usr/local/lib/systemd/system/` with the following content:

~~~
[Unit]
Description="Command to backup my home directory"

[Service]
Type=oneshot
ExecStart=/usr/bin/rsync -a --exclude=.cache/* /home/<user> /mnt/sdb5/backup/home/
~~~

Please replace the \<user\> string with your own user.

### Create timer unit

We create the file `backup.timer` in the directory `/usr/local/lib/system/system/` with the following content:

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
The timer unit must contain the [Timer] section, which defines when and how the corresponding service unit is triggered.  
There are two available timer types:

1. Realtime timers,  
    which define a realtime (i.e. wall clock) timer with the `OnCalendar=` option.  
    (the example *"OnCalendar=\*-\*-\* 19:00:00"* means "daily at 19:00"),
    
    and  
2. Monotonic timers,  
    which define a timer relative to one of the options `OnActiveSec=`, `OnBootSec=`, `OnStartupSec=`, `OnUnitActiveSec=`, `OnUnitInactiveSec=`.  
    *"OnBootSec=90"* means "90 seconds after bootup" and  
    *"OnUnitActiveSec=1d"* means "One day after the timer was last activated".  
    Both options together trigger the associated service unit 90 seconds after boot and then exactly every 24 hours as long as the machine is not shut down.

The `Persistent=` option included in the example saves the time when the service unit was last triggered as an empty file in the `/var/lib/systemd/timers/` directory. This is useful for catching up on missed runs when the machine was off.

**Include timer unit**

We include the timer unit into systemd with the following command:

~~~
# systemctl enable backup.timer
Created symlink
 /etc/systemd/system/timers.target.wants/backup.timer →
   /usr/local/lib/systemd/system/backup.timer.
~~~

The analogous command for the service unit is not necessary and would also lead to an error, since there is no [Install] section in it.

**Trigger timer unit manually**.

Not the timer unit, but the service unit to be triggered by it is called.

~~~
# systemctl start backup.service
~~~

### Timer unit as cron replacement

"cron" and "anacron" are the best known and widely used job timers. systemd timers can be an alternative. We briefly look at the benefits of and caveats to systemd timers.

**Benefits**

+ Jobs can have dependencies (depend on other systemd services).
+ Timer units are logged in the systemd journal.
+ You can easily call a job independently from its timer.
+ You can give timer units a nice value or use cgroups for resource management.
+ systemd timer units can be triggered by events like booting or hardware changes.
+ They can be easily enabled or disabled with systemctl.

**Caveats**

+ Configuring a cron job is a simple process.
+ cron can send emails using the MAILTO variables. 

### Sources systemd-timer

~~~
man systemd.timer
~~~

[Archlinux Wiki, Timers](https://wiki.archlinux.org/index.php/Systemd/Timers)  
[PRO-LINUX.DE, Systemd Timer Units...](https://www.pro-linux.de/artikel/2/1992/systemd-timer-units-f%C3%BCr-zeitgesteuerte-aufgaben-verwenden.html)

<div id="rev">Last edited: 2022/04/10</div>
