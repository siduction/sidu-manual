BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC1**

Necessary work:

+ check intern links  
+ check extern links  
+ check layout  
+ check spelling  

Work done


END   INFO AREA FOR THE AUTHORS  
% systemd - service

## systemd-service

The basic and introductory information about Systemd is contained in the manual page [Systemd-Start](./0710-systemd-start_en.md#systemd-der-system--und-dienste-manager) The sections *[Unit]* and *[Install]* concerning all unit files are covered by our manual page [Systemd Unit file](./0711-systemd-unit-file_en.md#systemd-unit-file).  
In this manual page we explain the function of the unit **systemd.service**. The unit file with the ".service" name extension is the most commonly encountered unit type in systemd.

The service unit file must contain a [service] section that configures information about the service and the process it is monitoring.

### create service unit

We prefer to place self-created unit files in the */usr/local/lib/systemd/system/* directory. (If necessary, create the directory with the command **`mkdir -p /usr/local/lib/systemd/system/`**). This has the advantage of giving them priority over system units installed by the distribution's package manager, while placing control links and change files created with **`systemctl edit <UNIT_DATEI>`** in the directory */etc/systemd/system/*, which itself has priority. See: [Hirarchy of load paths](0711-systemd-unit-file_en.md#load-path-of-unit-files).

### Service section

There are over thirty options available for this section, of which we describe particularly frequently used ones here.

---               ----
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
---               ----

+ **Type=**  
    Defines the process startup type and is therefore one of the most important options.  
    The possible values are: simple, exec, forking, oneshot, dbus, notify or idle.  
    The default *simple* is used if *ExecStart=* is set, but neither *Type=* nor *BusName=* are set.
    
    + **simple**  
       A unit of type *simple* considers systemd as successfully started as soon as the main process specified with *ExecStart=* has been started by *fork*. Then systemd immediately starts subsequent units, regardless of whether the main process can be called successfully.
    
    + **exec**  
       Similar to *simple*, but systemd waits to start subsequent units until the main process has finished successfully. This is also the time when the unit reaches the "active" state.
    
    + **forking**  
       Here systemd considers the service as started as soon as the process specified with *ExecStart=* branches to the background and the parent system terminates. This type is often used with classic daemons. The option *PIDFile=* should also be specified here so that the system can continue to follow the main process.
    
    + **oneshot**.  
       Similar to *exec*. The *Type=oneshot* option is often used with scripts or commands that do a single job and then exit. However, the service never reaches the "active" state, but goes from the "activating" to "deactivating" or "dead" state immediately after the main process terminates. Therefore it is often useful to use this option with "RemainAfterExit=yes" to reach the "active" state.
    
    + **dbus**  
       behaves similarly to *simple*, systemd starts subsequent units after the D-Bus bus name has been obtained. Units with this option, implicitly get a dependency on the unit "dbus.socket".
    
    + **notify**.  
       The type=notify is very similar to the type *simple*, with the difference that the daemon sends a signal to systemd when it is ready.
    
    + **idle**  
       The behavior of *idle* is very similar to *simple*; however, systemd delays the actual execution of the service until all active jobs are completed. This type is not useful as a general tool for sorting units, because it is subject to a 5 s timeout, after which the service is executed in any case.

+ **RemainAfterExit=**  
    Expects a logical value (default: *no*) that determines whether the service, even if all its processes have terminated, should be considered active. See *Type=oneshot*.

+ **GuessMainPID=**.  
    Expects a logical value (default: *yes*). Systemd uses this option only if *Type=forking* is set and *PIDFile=* is not set, and then tries to guess the main PID of a service if it cannot determine it reliably. For other types or with *PIDFile=* set, the main PID is always known.

+ **PIDFile=**  
    Accepts a path to the service's PID file. For services of *Type=forking* the use of this option is recommended. 

+ **BusName=**  
    The D-Bus bus name under which this service can be reached must be specified here. The option is mandatory for services of *Type=dbus*.

+ **ExecStart=**  
    Contains commands with their arguments that are executed when this unit is started. Exactly one command must be specified, unless the *Type=oneshot* option is set, in which case *ExecStart=* can be used multiple times. The value of *ExecStart=* must conform to the rules described in detail in the German man page [systemd.service](https://manpages.debian.org/testing/manpages-de/systemd.service.5.de.html).

+ **ExecStop=**  
    Can be used multiple times and contains commands to stop a service started by *ExecStart=*. The syntax is identical to *ExecStart=*.

+ **ExecStartPre=, ExecStartPost=, ExecStopPost=**  
    Additional commands that are started before or after the command in *ExecStart=* or *ExecStop*. Again, the syntax is identical to *ExecStart=*. Multiple command lines are allowed and the commands are executed serially one after the other. If one of these commands (not preceded by "-") fails, the unit is immediately considered to have failed.

+ **RestartSec=**  
    Specifies the time to sleep before restarting a service. A unit-free integer defines seconds, a specification of "3min 4s" is also possible.  
    The type of time value definition applies to all timed options.

+ **TimeoutStartSec=, TimeoutStopSec=, TimeoutSec=**  
    Defines the time to wait for starting or stopping. *TimeoutSec=* combines the two previously mentioned options.  
    *TimeoutStopSec=* additionally configures the time to wait for each *ExecStop=* command, if any.

+ **Restart=**  
    Configures whether the service should be restarted when the service process terminates, kills itself, or times out. If the death of the process is the result of a Systemd action, the service will not be restarted.  
    The allowed values are: no, always, on-success, on-failure, on-abnormal, on-abort, or on-watchdog.  
    The following table shows the effect of the *restart=* setting on the exit reasons.

    ------------------- -------- --------- --------- ---------- ------- ----------
                                  on on on on
    ► Restart= ► always success failure abnormal abort watchdog
    ▼ Exit reason ▼
    Clean exit X X
    Unclean exit X X
    Unclean signal X X X
    Timeout X X X
    Watchdog X X X
    ------------------- -------- --------- --------- ---------- ------- ----------

    The options *RestartPreventExitStatus=* and *RestartForceExitStatus=* set if required will change this behavior.

**Examples**  
Some self created service units can be found on our manual pages

[service-unit for systemd timer](0716-systemd-timer_en.md#create-timer-unit)  
[service-unit for systemd Path](0715-systemd-path_en.md#create-path-unit)  
and with the preferred search engine on the Internet.  
[LinuxCommunity, Create systemd units yourself](https://www.linux-community.de/ausgaben/linuxuser/2018/07/handarbeit-2/)

### Sources systemd-service

[German manpage, systemd.service](https://manpages.debian.org/testing/manpages-de/systemd.service.5.de.html)  
[LinuxCommunity, Create systemd units yourself](https://www.linux-community.de/ausgaben/linuxuser/2018/07/handarbeit-2/)  

<div id="rev">Page last updated 2021-14-08</div>
