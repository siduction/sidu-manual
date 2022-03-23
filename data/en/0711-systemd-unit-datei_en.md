% systemd - unit file

## systemd unit file

The basic and introductory information about systemd can be found on the manual page [systemd-start](0710-systemd-start_en.md#systemd---the-system-and-services-manager) .  
On the following manual page we explain the structure of the **unit files** and the generic sections "[Unit]" and "[Install]".

The unit file is a plain text file in INI format. It contains configuration statements of the type "*key=value*" in various sections. Empty lines and those starting with "#" or ";" are ignored.
All unit files must contain a section corresponding to the unit type. The generic sections "[Unit]" at the beginning and "[Install]" at the end of the file are optional, but the "[Unit]" section is strongly recommended. 

### Loading path of the unit files

The output shows the order of the directories from which the unit files are loaded.

~~~
# systemd-analyze unit-paths
/etc/systemd/system.control
/run/systemd/system.control
/run/systemd/transient
/run/systemd/generator.early
/etc/systemd/system
/etc/systemd/system.attached
/run/systemd/system
/run/systemd/system.attached
/run/systemd/generator
/usr/local/lib/systemd/system
/lib/systemd/system
/usr/lib/systemd/system
/run/systemd/generator.late
~~~

Unit files found in directories listed earlier override files with the same name in directories further down the list. For example, a file in **/etc/systemd/system** overrides one with the same name in **/lib/systemd/system**.

Only some of the previously listed directories exist in siduction by default: 

+ **/lib/systemd/system/**  
  contains system units installed by the distribution's package manager and any unit files created by the administrator.  
+ **/etc/systemd/system/**  
  contains symlinks to unit files in **/lib/systemd/system/** for enabled units and administrator-created unit files, if any.  
+ **/usr/local/lib/systemd/system/**  
  must be created and is meant to contain administrator-created unit files.  
+ **/run/systemd/**  
  contains runtime units and dynamic configuration for volatile units. For the administrator, this directory has informal value only.

We recommend storing your own unit files in **/usr/local/lib/systemd/system/**.

### Activating the unit file

To make the configuration of a unit accessible to systemd, the unit file must be activated. This is done with the call:

~~~
# systemctl daemon-reload
# systemctl enable --now <UNIT_FILE>
~~~

The first command reloads the complete daemon configuration, the second one starts the <UNIT_FILE> unit immediately (option "--now") and incorporates it into systemd so that it is executed every time the PC is rebooted.  
The command

~~~
# systemctl disable <UNIT_FILE>
~~~

causes it to stop running every time the PC is rebooted. However, it can still be started manually with the command **`systemctl start <UNIT_FILE>`** and stopped with **`systemctl stop <UNIT_FILE>`**.  
If a unit file is empty (i.e. has size 0) or is a symlink on */dev/null*, its configuration will not be loaded and it will appear with a load state of "masked" and cannot be activated. This is an effective way to completely disable a unit and also make it impossible to start it manually.

### Sections of the unit file

The unit file usually consists of the [Unit] section, the type-specific section and the [Install] section. The type-specific section is included as a suffix in the file name. For example, a unit file that configures a timer always has the extension "*.timer*" and must contain "[Timer]" as the type-specific section.

#### Section Unit

This section contains general information about the unit, defines dependencies to other units, evaluates conditions and takes care of the enumeration in the boot process.

1. General options

    a. "*Description=*"  
       Identifies the unit by a human readable name, which is used by systemd as a description for the unit and thus appears in the systemjournal ("Starting *description*...") and can be used as a search pattern there.

    b. "*Documentation=*"  
       A reference to a file or web page that references documentation for this unit or its configuration, e.g. "Documentation=man:cupsd(8)" or "Documentation=http://www.cups.org/doc/man-cupsd.html".

2. Binding dependencies to other units

    a. "*Wants=*"  
       Units listed here are started with the configured unit.

    b. "*Requires=*"  
       Similar to *Wants=*, but declares a stronger binding to the listed Units.  
       When this unit is activated, the listed units are also activated.  
       If activation of one of the other units fails **and** the order dependency *After=* is set on the failed unit, then that unit will not be started.  
       If one of the other units becomes inactive, this unit will remain active. Only if one of the other units is stopped, this unit will also be stopped.

    c. "*Requisite=*"  
       Similar to *Requires=*. The start of this unit will fail immediately if the units listed here have not been started yet. *Requisite=* should be combined with the order dependency *After=* to ensure that this unit is not started before the other unit.

    d. "*BindsTo=*"  
       *BindsTo=* is the strongest dependency type: it causes, in addition to the properties of *Requires=*, that the bound unit must be in active state for this unit to be active.  
       When the bound unit is stopped or in an inactive state, this unit will always be stopped.  
       To prevent the start of this unit from failing when the bound unit is not (or not yet) in an active state, *BindsTo=* is best combined with the order dependency *After=*.

    e. "*PartOf=*"  
       Similar to *Requires=*, but limited to stopping and restarting units.  
       When Systemd stops or restarts the units listed here, the action is forwarded to that unit.  
       This is a one-way dependency. Changes to this Unit do not affect the units listed.

    f. "*Conflicts=*"  
       Declares negative request dependencies. It is possible to specify a space-separated list.  
       *Conflicts=* causes the listed unit to stop when this unit starts and vice versa.  
       Since *Conflicts=* does not include an order dependency, an *After=* or *Before=* dependency must be declared to ensure that the conflicting unit is stopped before the other unit is started.

3. Order dependencies to other units

    a. "*Before=*"  
       This setting configures order dependencies between units. *Before=* ensures that the listed unit will only start after the configured unit has finished starting.  
       Specifying a space-separated list is possible.

    b. "*After=*"  
       This setting ensures the opposite of *Before=*. The listed unit must have been completely started before the configured unit is started.

    c. "*OnFailure=*"  
       Units that will be activated when this unit takes the "failed" state.

4. Conditions  
   Unit files can also contain a set of conditions.  
   Before starting the unit, systemd will check if the specified conditions are true. If not, the start of the unit (almost without output) will be skipped.  
   Failing conditions will not cause the unit to enter the "failed" state.  
   In case multiple conditions are specified, the unit will be executed if all of them are true.  
   In this section, we list only conditions that we think are useful for user-created units, because many conditions are used to skip units that do not apply on the local system.  
   The command **`systemd-analyze verify <UNIT_FILE>`** can be used to test conditions.

   a. "*ConditionVirtualization=*".  
      Checks if the system is running in a virtualized environment and optionally tests if it is a specific implementation.

   b. "*ConditionACPower=*"  
      Checks if the system is on the mains or running solely on battery power at the time the unit is activated.

   c. "*ConditionPathExists=*"  
      Checks for the existence of a file. With an exclamation mark ("!") in front of the path, the test is negated.

   d. "*ConditionPathExistsGlob=*"  
      As before, except that a search pattern is specified. With an exclamation mark ("!") in front of the path, the test is negated.

   e. "*ConditionPathIsDirectory=*"  
      Tests for the existence of a directory. With an exclamation mark ("!") in front of the path, the test is negated.

   f. "*ConditionPathIsSymbolicLink=*"  
      Checks if a given path exists and is a symbolic link. With an exclamation mark ("!") in front of the path, the test is negated.

   g. "*ConditionPathIsMountPoint=*"  
      Checks if a given path exists and is a mount point. With an exclamation mark ("!") in front of the path, the test is negated.

   h. "*ConditionPathIsReadWrite=*"  
      Checks if the underlying file system is readable and writable. With an exclamation mark ("!") in front of the path, the test is negated.

   i. "*ConditionDirectoryNotEmpty=*"  
      Checks if a given path exists and is a non-empty directory. With an exclamation mark ("!") in front of the path the test is negated.

   j. "*ConditionFileNotEmpty=*"  
      Checks if a given path exists and refers to a normal file with a non-zero size. With an exclamation mark ("!") in front of the path, the test is negated.

   k. "*ConditionFileIsExecutable=*"  
      Checks if a given path exists and refers to a normal file marked as executable. With an exclamation mark ("!") in front of the path, the test is negated.

For full documentation on all options of the "[Unit]" section, please refer to the manpage `man systemd.unit`.

#### Type-specific section

This section contains the special options of the eleven possible types. Detailed descriptions can be found in the linked manual pages, or on the respective manpage.

+ [[Service]](0712-systemd-service_en.md#systemd-service) configures a service

+ [Socket] configures a socket (`man systemd.socket`)

+ [Device] configures a device (`man systemd.device`)

+ [[Mount]](0713-systemd-mount_en.md#systemd-mount) configures a mount point

+ [[Automount]](0713-systemd-mount_en.md#systemd-mount) configures a self-mount point

+ [Swap] configures a swap file or partition (`man systemd.swap`)

+ [[Target]](0714-systemd-target_en.md#systemd-target---target-unit) configures a start target

+ [[Path]](0715-systemd-path_en.md#systemd-path) configures a monitored file path

+ [[Timer]](0716-systemd-timer_en.md#systemd-timer) configures a timer controlled and monitored by systemd

+ [slice] configures a resource management slice (`man systemd.slice`)

+ [Scope] configures a group of externally created processes (`man systemd.scope`)

#### Install section

Unit files may contain this section.  
The options in the *[Install]* section are related by the **`systemctl enable <UNIT_FILE>`** and **`systemctl disable <UNIT_FILE>`** commands during installation of a unit.  
Unit files without *[Install]* section can be started manually with the command **`systemctl start <UNIT_FILE>`** or from another unit file.

Description of options:

+ "*Alias=*"  
  A list of additional names under which this unit should be installed. The names listed here must have the same extension as the unit file.

+ "*WantedBy=*"  
  This option can be used multiple times or contain a space-separated list.  
  A symbolic link is created in the .wants/ directory of each of the listed units during installation. This adds a dependency of the type *Wants=* from the listed unit to the current unit. The main result is that the current unit is started when the listed unit is started.  
  Behaves like the *Wants=* option in the *[Unit]* section.

  Example:  
  WantedBy=graphical.target

  This tells systemd to launch the unit when starting graphical.target (formerly "init 5"). 

+ "*RequiredBy=*"  
  This option can be used multiple times or contain a space-separated list.  
  A symbolic link is created in the .requires/ directory of each of the listed units during installation. This adds a dependency of type *Requires=* from the listed unit to the current unit. The main result is that the current unit is started when the listed unit is started.  
  Behaves like the *Requires=* option in the *[Unit]* section.

+ "*Also=*"  
  Additional units to install/uninstall when this unit is installed/uninstalled.

+ "*DefaultInstance=*"  
  This option has effect only for template unit files.  
  Declares which instance of the unit should be released. The specified string must be suitable for identifying an instance.

Hint:
To verify the configuration of a unit file, the **`systemd-analyze verify <UNIT_FILE>`** command is suitable.

### Example cupsd

*cupsd*, the job scheduler for the Common UNIX Printing System, is controlled by systemd through its three unit files *cups.socket*, *cups.service*, and *cups.path* and is well suited to illustrate the dependencies.  
Here are the three files.

~~~
File /lib/system/system/cups.service:

[Unit]
Description=CUPS Scheduler
Documentation=man:cupsd(8)
After=network.target sssd.service ypbind.service nslcd.service
Requires=cups.socket
    After=cups.socket (not in the file, because implicitly present)
    After=cups.path (not in the file, because implicitly present)

[Service]
ExecStart=/usr/sbin/cupsd -l
Type=notify
Restart=on-failure

[Install]
Also=cups.socket cups.path
WantedBy=printer.target
~~~

~~~
File /lib/system/system/cups.path:

[Unit]
Description=CUPS Scheduler
PartOf=cups.service
    Before=cups.service (not in the file, because implicitly present)

[Path]
PathExists=/var/cache/cups/org.cups.cupsd

[Install]
WantedBy=multi-user.target
~~~

~~~
File /lib/system/system/cups.socket:

[Unit]
Description=CUPS Scheduler
PartOf=cups.service
    Before=cups.service (not in the file, because implicitly present).

[Socket]
ListenStream=/run/cups/cups.sock

[Install]
WantedBy=sockets.target
~~~

**The [Unit] section**  
contains the same description for all three files. The files *cups.path* and *cups.socket* additionally contain the binding dependency *PartOf=cups.service*, which means that these two units are stopped or restarted depending on *cups.service*.  
The socket unit as well as the path unit include the order dependency "*Before=*" to their service unit with the same name. Therefore it is not necessary to include the order dependencies "After=cups.socket" and "After=cups.path" in the *cups.service* unit (see below the output of "systemd-analyze dump" with the notation "destination-implicit"). The effect of both dependencies together is that regardless of which unit starts first, all three units will always start, and the *cups.service* unit will only start after the *cups.path* unit and the *cups.socket* unit have successfully started.

We get the complete configuration of the units with the command **`systemd-analyze dump`**, which prints a very, very long list ( > 32000 lines) of the systemd server state. 

~~~
# systemd-analyze dump
[...]
-> Unit cups.service:
    Description: CUPS Scheduler.service
    [...]
    WantedBy: printer.target (destination-file)
    ConsistsOf: cups.socket (destination-file)
    ConsistsOf: cups.path (destination-file)
    Before: printer.target (destination-default)
    After: cups.socket (destination-implicit)
    After: cups.path (destination-implicit)
[...]
-> Unit printer.target:
    Description: Printer
    [...]
    Wants: cups.service (origin-file)
    After: cups.service (origin-default)
[...]
~~~

**The [Install] section**  
of the *cups.service* unit contains the option "Also=cups.socket cups.path", i.e. the instruction to install these two units as well and all three units have different "*WantedBy=*" options:

+ cups.socket: WantedBy=sockets.target  
+ cups.path: WantedBy=multi-user.target  
+ cups.service: WantedBy=printer.target

To understand why different values are used for the "WantedBy=" option, we need additional information, which we can obtain with the *systemd-analyze dot* and *systemd-analyze plot* commands.

~~~
$ systemd-analyze dot --to-pattern='*.target' --from-pattern=\
    '*.target' | dot -Tsvg > targets.svg

$ systemd-analyze plot > bootup.svg
~~~

The first one gives us a flowchart with the dependencies of the different *targets* to each other and the second one a graphical listing of the boot process with when a process was started, how much time it took, and its activity state.

From the *targets.svg* and the *bootup.svg* we can see that

1. **sysinit.target**  
    is activated and

2. **basic.target**  
    will not start until *sysinit.target** has been reached.

    1. **sockets.target**  
        is requested by *basic.target*,

        1. **cups.socket**  
              and all other *.socket* units are fetched from *sockets.target*.

    2. **paths.target**  
        is requested by *basic.target*,

        1. **cups.path**  
              and all other *.path* units are fetched from *paths.target*.

3. **network.target**  
    will not start until *basic.target* has been reached.

4. **cups.service**  
    will not start until *network.target* has been reached.

5. **multi-user.target**  
    will not start until *network.target* has been reached.

6. **multi-user.target**  
    is not reached until *cups.service* has been started successfully.  
    (Strictly speaking, this is because the *cups-browsed.service*, which depends on the  
    *cups.service*, must have been started successfully).

6. **printer.target**  
    becomes active only when systemd dynamically generates device units for the printers.  
    For this to happen, the printers must be connected and turned on.

Further above we noted that starting a *cups.xxx* unit is sufficient to bring in all three units. If we look again at the "*WantedBy=*" options in the [Install] section, we have the *cups.socket* unit being brought in via the *sockets.target* already during the *basic.target*, the *cups.path* unit being brought in during the *multi-user.target*, and the *cups.service* being brought in by the *printer.target*.  
Throughout the boot process, the three *cups.xxx* units are repeatedly requested from systemd for activation. This hardens the *cupsd* against unforeseen errors, but does not matter to systemd because it does not matter how many times a service is requested if it is in the queue.  
Additionally, the *printer.target* requests the *cups.service* whenever a printer is newly detected by systemd.

### Tools

Systemd includes some useful tools for analyzing, checking and editing unit files.  
Please also refer to the man pages `man systemd-analyze` and `man systemctl`.


+ edit

  ~~~
  # systemctl edit <UNIT_FILE>
  # systemctl edit --full <UNIT_FILE>
  # systemctl edit --full --force <UNIT_FILE>
  ~~~

  *systemctl edit* opens the selected unit file in the configured editor.

  **systemctl edit <UNIT_DATEI>** creates a new directory under **/etc/systemd/system/** named "\<UNIT_FILE\>.d" and in it the file *override.conf* which contains only the changes from the original unit file. This applies to all unit files in the directories entered in the [Hirarchy of load paths](#load-path-of-unit-files) including **/etc/systemd/system/** downwards.

  **systemctl edit - -full <UNIT_FILE>** creates a new file with the same name in the **/etc/systemd/system/** directory. This applies to all unit files in the directories entered in the [Hirarchy of load paths](#load-path-of-unit-files) below **/etc/systemd/system/**. Files already existing in the **/etc/systemd/system/** directory will be overwritten.

  **systemctl edit - -full - -force <UNIT_FILE>** creates a new file in the directory **/etc/systemd/system/**. Without the *- -full* option, only an *override.conf* file would be generated in the new directory **/etc/systemd/system/\<UNIT_FILE\>.d/**, which lacks the associated unit file.

  When the editor is terminated, systemd automatically executes the command **`systemctl daemon-reload`**.

+ revert

  ~~~
  # systemctl revert <UNIT_FILE>
  ~~~

  reverts the changes made to unit files with *systemctl edit* and *systemctl edit - -full*. This does not apply to changed unit files that were already existing in the **/etc/systemd/system/** directory.  
  In addition, the command undoes the changes made with *systemctl mask*.

+ daemon-reload

  ~~~
  # systemctl daemon-reload
  ~~~

  Reloads the system administrator configuration. This re-runs all generators, reloads all unit files, and rebuilds the entire dependency tree.

+ cat

  ~~~
  $ systemctl cat <UNIT_FILE>
  ~~~

  Prints the contents of the unit file and all associated changes according to the console command *cat*.

+ analyze verify

  ~~~
  $ systemd-analyze verify <UNIT_FILE>
  ~~~

  checks the configuration settings of a unit file and prints hints. This is a very useful command to check the configuration of self created or changed unit files.

+ systemd-delta

  ~~~
  $ systemd-delta
  ~~~

  presents in the output unit files and the changes made to them. The keyword at the beginning of the line defines the type of change or configuration.  
  Here is an example:

  ~~~
  $ systemd-delta --no-pager
  [MASKED] /etc/sysctl.d/50-coredump.conf → /usr/lib/sysctl.d/50-coredump.conf
  [OVERRIDDEN] /etc/tmpfiles.d/screen-cleanup.conf → /usr/lib/tmpfiles.d/screen-cleanup.conf
  [MASKED] /etc/systemd/system/NetworkManager-wait-online.service → /lib/systemd/system/NetworkManager-wait-online.service
  [EQUIVALENT] /etc/systemd/system/tmp.mount → /lib/systemd/system/tmp.mount
  [EXTENDED] /lib/systemd/system/rc-local.service → /lib/systemd/system/rc-local.service.d/debian.conf
  [EXTENDED] /lib/systemd/system/systemd-localed.service → /lib/systemd/system/systemd-localed.service.d/locale-gen.conf

  6 overridden configuration files found.
  ~~~

+ analyze dump

  ~~~
  $ systemd-analyze dump > systemd_dump.txt
  ~~~

  creates the text file *systemd_dump.txt* with the complete configuration of all systemd units. The very long text file gives information about all configuration settings of all systemd units and can be easily searched with a text editor and using regex patterns.

+ analyze plot

  ~~~
  $ systemd-analyze plot > bootup.svg
  ~~~

  creates the file *bootup.svg* with the chronological sequence of the boot process. It is a graphical listing of the boot process with the start and end times of all units, what time they took, and their activity states.

+ analyze dot

  ~~~
  $ systemd-analyze dot --to-pattern='*.target' --from-pattern=\
    '*.target' | dot -Tsvg > targets.svg
    Color legend: black = Requires
                  dark blue = Requisite
                  dark grey = Wants
                  red = Conflicts
                  green = After
  ~~~

  creates the *targets.svg* flowchart that shows the dependencies of the targets used in the boot process. The relationships of the *.target* units are shown in color for a better overview.

The tools mentioned here represent only a part of the tools shipped with systemd. Please refer to the man pages for full documentation.

### Sources systemd-unit file

We recommend to read the following manpages:

~~~
man systemd.unit
man systemd.syntax
man systemd.device
man systemd.scope
man systemd.slice
man systemd.socket
man systemd.swap
man systemd-analyze
man systemctl
~~~

<div id="rev">Page last updated 2022/03/22</div>
