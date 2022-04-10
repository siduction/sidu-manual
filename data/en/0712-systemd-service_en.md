% systemd - service

## systemd-service

The basic and introductory information about systemd is contained on the manual page [systemd-start](0710-systemd-start_en.md#systemd---the-system-and-services-manager). The sections *[Unit]* and *[Install]* concerning all unit files are covered by our manual page [systemd unit file](0711-systemd-unit-datei_en.md#systemd-unit-file).  
On this manual page we explain the function of the unit **systemd.service**. The unit file with the ".service" name extension is the most commonly encountered unit type in systemd.

The service unit file must contain a [Service] section that configures information about the service and the process it is monitoring.

### Create service unit

We prefer to place self-created unit files in the `/usr/local/lib/systemd/system/` directory. (If necessary, create the directory with the command **`mkdir -p /usr/local/lib/systemd/system/`**.) This has the advantage of giving them priority over system units installed by the distribution's package manager, while placing control links and change files created with **`systemctl edit <UNIT_FILE>`** in the directory `/etc/systemd/system/`, which itself has a higher priority. See: [Hirarchy of load paths](0711-systemd-unit-datei_en.md#loading-path-of-the-unit-files).

### Service section

There are over thirty options available for this section, of which we describe particularly frequently used ones here.

~~~
Type=             PIDFile=
RemainAfterExit=  GuessMainPID=
ExecStart=        Restart=
ExecStartPre=     RestartSec=
ExecStartPost=    SuccessExitStatus=
ExecCondition=    RestartPreventExitStatus=
ExecReload=       RestartForceExitStatus=
ExecStop=         NonBlocking=
ExecStopPost=     NotifyAccess=
TimeoutStopSec=   RootDirectoryStartOnly=
TimeoutStartSec=  FileDescriptorStoreMax=
TimeoutAbortSec=  USBFunctionDescriptors=
TimeoutSec=       USBFunctionStrings=
RuntimeMaxSec=    Sockets=
WatchdogSec=      BusName=
                  OOMPolicy=
~~~

+ `Type=`  
    Defines the process startup type and is therefore one of the most important options.  
    The possible values are: simple, exec, forking, oneshot, dbus, notify, or idle.  
    The default simple is used if `ExecStart=` is set, but neither `Type=` nor `BusName=` are.
    
    + `simple`  
       systemd considers a simple type unit as successfully started as soon as the main process specified with `ExecStart=` has been started by *fork*. Then systemd immediately starts subsequent units, regardless of whether the main process can be called successfully.
    
    + `exec`  
       Similar to simple, but systemd waits to start subsequent units until the main process has finished successfully. This is also the time when the unit reaches the "active" state.
    
    + `forking`  
       Here systemd considers the service as started as soon as the process specified with `ExecStart=` branches to the background and the parent system terminates. This type is often used with classic daemons. The option `PIDFile=` should also be specified here so that the system can continue to follow the main process.
    
    + `oneshot`  
       The Type=oneshot option is similar to exec and often used with scripts or commands that do a single job and then exit. However, the service never reaches the "active" state, but goes from the "activating" to "deactivating" or "dead" state immediately after the main process terminates. Therefore it is often useful to use this option with `RemainAfterExit=yes` to reach the "active" state.
    
    + `dbus`  
       behaves similarly to simple. systemd starts subsequent units after the D-Bus bus name has been obtained. Units with this option implicitly get a dependency on the unit dbus.socket.
    
    + `notify`  
       The type=notify is very similar to the type simple, with the difference that the daemon sends a signal to systemd when it is ready.
    
    + `idle`  
       The behavior of idle is very similar to simple. However, systemd delays the actual execution of the service until all active jobs are completed. This type is not useful as a general tool for sorting units, because it is subject to a 5 s timeout, after which the service is executed in any case.

+ `RemainAfterExit=`  
    expects a logical value (default: no) that determines whether the service, even if all its processes have terminated, should be considered active. See Type=oneshot.

+ `GuessMainPID=`  
    expects a logical value (default: yes). systemd uses this option only if `Type=forking` is set and `PIDFile=` is not, and then tries to guess the main PID of a service if it cannot determine it reliably. For other types or with `PIDFile=` set, the main PID is always known.

+ `PIDFile=`  
    accepts a path to the service's PID file. For services of `Type=forking` the use of this option is recommended. 

+ `BusName=`  
    The D-Bus bus name under which this service can be reached must be specified here. The option is mandatory for services of `Type=dbus`.

+ `ExecStart=`  
    contains commands with their arguments that are executed when this unit is started. Exactly one command must be specified, unless the `Type=oneshot` option is set, in which case ExecStart= can be used multiple times. The value of ExecStart= must conform to the rules described in detail in the man page `man systemd.service`.

+ `ExecStop=`  
    can be used multiple times and contains commands to stop a service started by ExecStart=. The syntax is identical to ExecStart=.

+ `ExecStartPre=`, `ExecStartPost=`, `ExecStopPost=`  
    are additional commands that are started before or after the command in `ExecStart=` or `ExecStop`. Again, the syntax is identical to ExecStart=. Multiple command lines are allowed and the commands are executed serially one after the other. If one of these commands (not preceded by "-") fails, the unit is immediately considered to have failed.

+ `RestartSec=`  
    specifies the sleep time before restarting a service. A unit-free integer defines seconds, a specification of "3min 4s" is also possible.  
    The type of time value definition applies to all timed options.

+ `TimeoutStartSec=`, `TimeoutStopSec=`, `TimeoutSec=`  
    define the time to wait for starting or stopping. TimeoutSec= combines the two previously mentioned options.  
    TimeoutStopSec= additionally configures the time to wait for each `ExecStop=` command, if any.

+ `Restart=`  
    configures whether the service should be restarted when the service process terminates, kills itself, or times out. If the process' death is the result of a systemd action, the service will not be restarted.  
    The allowed values are: no, always, on-success, on-failure, on-abnormal, on-abort, or on-watchdog.  
    The following table shows the effect of the Restart= setting on the exit reasons.

    ~~~
                                  on        on        on         on      on
    ► Restart= ►         always   success   failure   abnormal   abort   watchdog
    ▼ exit reason ▼
    clean exit             X        X
    unclean exit           X                  X
    unclean signal         X                  X         X          X
    timeout                X                  X         X
    watchdog               X                  X         X                  X
    ~~~

    The options `RestartPreventExitStatus=` and `RestartForceExitStatus=` change this behavior.

**Examples**  
Some self created service units can be found on our manual pages

[service-unit for systemd timer](0716-systemd-timer_en.md#create-timer-unit),  
[service-unit for systemd Path](0715-systemd-path_en.md#create-path-unit),  
and with the preferred search engine on the Internet.  

### Sources systemd-service

~~~
man systemd.service
~~~

[LinuxCommunity, Create systemd units yourself](https://www.linux-community.de/ausgaben/linuxuser/2018/07/handarbeit-2/)  

<div id="rev">Last edited: 2022/04/08</div>
