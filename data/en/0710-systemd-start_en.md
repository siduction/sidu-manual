% System Administration - systemd

## Systemd - the system and services manager

*Note:*  
*The following general introduction to systemd was mainly taken from the extensive systemd manpages.*

**systemd** is a system and service manager that runs as the first process (as PID 1) at system startup and thus acts as an **init system**, booting the system and managing services at the application level.  
It is lead developed by Red Hat developers Lennart Poettering and Kay Sievers.

In Debian, the introduction of systemd as the default init system was discussed long, controversially, and emotionally until the Technical Committee voted in favor of systemd in February 2014.  

siduction has been using systemd as default init system since release 2013.2 "December".

### Concept of systemd

Systemd provides a dependency system between different *"units"* of 11 different types (see below). Units encapsulate various objects relevant to system startup and operation.  
Units can be *"active"* or *"inactive"*, as well as in the process of *"activation"* or *"deactivation"*, i.e. between the two former states. A special state *"failed"*, which is very similar to *"inactive"*, is also available. When this state is reached, the cause is logged for later inspection. See the manual page [systemd-journal](0717-systemd-journald_en.md#system-journal).  
With systemd, many processes can be controlled in parallel because the unit files declare possible dependencies and systemd adds required dependencies automatically.

The units managed by systemd are configured using unit files.  
The unit files are pure text files in INI format, divided into different sections. This makes their contents easy to understand and edit without knowledge of a scripting language. All unit files must have a section corresponding to the unit type and may contain the generic sections [Unit] and [Install].  
The manual page [systemd unit file](0711-systemd-unit-datei_en.md#systemd-unit-file) explains the basic structure of the unit files, as well as many options of the generic sections [Unit] and [Install].

### Unit types

Before we turn to the unit types, it is advisable to read the manual page [systemd unit file](0711-systemd-unit-datei_en.md#systemd-unit-file) to understand the operation of the generic sections and their options.  
The following unit types are available, and if a link is available, it will take you to a more detailed description in our manual:

1. **Service units** [(systemd.service)](0712-systemd-service_en.md#systemd-service) start and control daemons as well as the processes that make them up. 

2. **Socket units** (systemd.socket) encapsulate local IPC or network sockets in the system (useful for socket-based activation).

3. **Target units** [(systemd.target)](0714-systemd-target_en.md#systemd-target---target-unit) are useful for grouping units. They also provide synchronization points known as runlevels during system startup.

4. **Device units** (systemd.device) expose kernel devices (all block and network devices) in systemd and can be used to implement device-based activation.

5. **Mount units** [(systemd.mount)](0713-systemd-mount_en.md#systemd-mount) control mount points in the file system.

6. **Automount units** [(systemd.automount)](0713-systemd-mount_en.md#systemd-mount) provide self-mount capabilities for on-demand file system mounts and parallelized boot.

7. **Timer units** [(systemd.timer)](0716-systemd-timer_en.md#systemd-timer) are useful for triggering the activation of other units based on timers.

8. **Swap units** (systemd.swap) are similar to mount units and encapsulate memory swap partitions or files of the operating system.

9. **Path units** [(systemd.path)](0715-systemd-path_en.md#systemd-path) can be used to enable other services when file system objects change or are modified.

10. **Slice units** (systemd.slice) can be used to group units that manage system processes (such as service and scope units) in a hierarchical tree for resource management reasons.

11. **Scope units** (systemd.scope) are similar to service units, but manage foreign processes instead of starting them as well.

### Systemd in the file system

The unit files installed by the distribution's package manager are located in the `/lib/systemd/system/` directory. Self-created unit files are placed into the directory `/usr/local/lib/systemd/system/`. (If necessary, create the directory beforehand with the command **`mkdir -p /usr/local/lib/systemd/system/`**.)  
You can control the status (enabled, disabled) of a unit via symlink in the directory `/etc/systemd/system/`.  
The directory `/run/systemd/system/` contains unit files created at runtime.

### Further functions of systemd

Systemd provides other functions as well. One of them is [logind](https://www.freedesktop.org/software/systemd/man/systemd-logind.service.html) as a replacement for the no longer maintained *ConsoleKit*. With this, systemd controls sessions and power management. Last but not least systemd offers a lot of other possibilities like spinning up a container (similar to a chroot) using [systemd-nspawn](http://0pointer.de/public/systemd-man/systemd-nspawn.html) and many more. A look at the link list on [Freedesktop](https://www.freedesktop.org/wiki/Software/systemd/) allows further discoveries, including the extensive documentation on systemd by lead developer Lennart Poettering.

### Handling services

One of the jobs of systemd is to start, stop, or otherwise control services. For this purpose the command `systemctl` can be used.

+ systemctl --all - lists all units, active and inactive.
+ systemctl -t [NAME] - lists only units of the specified type.
+ systemctl list-units - lists all active units.
+ systemctl start [NAME...] - starts one or more units.
+ systemctl stop [NAME...] - stops one or more units.
+ systemctl restart [NAME] - stops a unit and restarts it immediately. Used e.g. to re-read the changed configuration of a service.
+ systemctl status [NAME] - shows the current status of a unit.
+ systemctl is-enabled [name] - shows only the value "enabled" or "disabled" of a unit's status.

The following two commands integrate or remove the unit based on the configuration of its unit file. Dependencies to other units are taken into account and default dependencies are added if necessary so that systemd can execute the services and processes without errors.

+ systemctl enable [NAME] - adds a unit to systemd.
+ systemctl disable [NAME] - removes a unit from systemd.

It is often necessary to perform `systemctl start` and `systemctl enable` on a unit to make it available both immediately and after a reboot. Both options are combined by the command:

+ systemctl enable --now [NAME]

The following are two commands whose function is described on our manual page [systemd-target](0714-systemd-target_en.md#systemd-target---target-unit).

+ systemctl reboot - performs a reboot.
+ systemctl poweroff - shuts down the system and turns off the power if technically possible.

**Example**  
Using Bluetooth we demonstrate systemd's functionality.  
First the status query in short format:

~~~
# systemctl is-enabled bluetooth.service
enabled
~~~

Now we search for the unit files, combining `systemctl` with `grep`:

~~~
# systemctl list-unit-files | grep blue
bluetooth.service enabled enabled
dbus-org.bluez.service alias -
bluetooth.target static - 
~~~

Then we disable the unit *"bluetooth.service"*.

~~~
# systemctl disable bluetooth.service
  Synchronizing state of bluetooth.service with SysV service script with /lib/systemd/systemd-sysv-install.
  Executing: /lib/systemd/systemd-sysv-install disable bluetooth
  Removed /etc/systemd/system/dbus-org.bluez.service.
  Removed /etc/system/system/bluetooth.target.wants/bluetooth.service.
~~~

In the output you can clearly see that the links (not the unit file itself) have been removed. This means that the *"bluetooth.service"* will no longer start automatically when booting the PC/laptop. We check the status after a reboot.

~~~
# systemctl is-enabled bluetooth.service  
disabled
~~~

To disable a unit only temporarily, we use the command

~~~
# systemctl stop <unit>
~~~

This will keep the configuration in systemd. We reactivate the unit with the corresponding `start` command.

### Sources systemd

~~~
man systemd
man systemd.unit
man systemd.syntax
~~~

<div id="rev">Last edited: 2022/04/08</div
