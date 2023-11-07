% systemd-target

## systemd-target - target unit

The basic and introductory information about Systemd can be found on the manual page [systemd-start](0710-systemd-start_en.md#systemd---the-system-and-services-manager). The sections *[Unit]* and *[Install]* concerning all unit files are covered by our manual page [systemd unit file](0711-systemd-unit-datei_en.md#systemd-unit-file).  
Now the function of the **systemd.target** unit will be explained in more detail, which is similar to the commonly known runlevels.

The different runlevels that are booted or switched to are described by systemd as target units. They have the extension ".target".

The old sysvinit commands are still supported. (For this a quote from `man systemd`: "... is provided for compatibility reasons and because it is easier to type.")

| target unit | description | 
| --- | -------- |
| **emergency.target** | launches into an emergency shell on the main console. It is the most minimal version of a system boot to get an interactive shell. This unit can be used to guide the boot process step by step. 
| **rescue.target** | starts the base system (including system mounts) and an emergency shell. Compared to multi-user.target, this target could be considered as single-user.target. |
| **multi-user.target** | starts a multi-user system with a working network, without graphics server X. This unit is used when you want to stop X or not to boot into it. [This unit is used in special cases (when X itself or the desktop environment are upgraded) to perform a system upgrade (dist-upgrade)](0705-sys-admin-apt_en.md#run-full-upgrade). |
| **graphical.target** | is the unit for multi-user mode with network capability and a running X window system. |
| **default.target** | is the default unit that systemd launches at system startup. In siduction this is a symlink to graphical.target (except for the noX variant). |

A look at the documentation `man SYSTEMD.SPECIAL(7)` is mandatory to understand the relationships of the different target units.

### Special features

There are three special features to be considered for the target units:

1. The use on the kernel command line during the boot process  
    In order to get into the edit mode in the boot manager Grub, you must press the **`e`** key when the boot selection appears. Then append the desired target to the kernel command line with the following syntax: "systemd.unit=xxxxx.target". The table lists the kernel commands and their still valid numeric equivalents.

    | target unit | kernel command | kernel command old |
    | --------- | ------------- | :---: |
    | emergency.target | systemd.unit=emergency.target | - |
    | rescue.target | systemd.unit=rescue.target | 1 |
    | multi-user.target | systemd.unit=multi-user.target | 3 |
    | graphical.target | systemd.unit=graphical.target | 5 |

    The old runlevels 2 and 4 refer to multi-user.target

2. The use in the terminal during a running session  
    Provided you are in a running graphical session, you can switch to the virtual terminal tty3 with the key combination **`CTRL`**+**`ALT`**+**`F3`**. Here you log in as **root** user. The following table lists the terminal commands, where the expression *"isolate"* ensures that all services not requested by the target unit are terminated.

    | target unit | terminal command | init command alt |
    | --------- | --------------- | :----: |
    | emergency.target | systemctl isolate emergency.target | - |
    | rescue.target | systemctl isolate rescue.target | init 1 |
    | multi-user.target | systemctl isolate multi-user.target | init 3 |
    | graphical.target | systemctl isolate graphical.target | init 5 |


3. Target units that should not be called directly  
    A number of target units are used to group intermediate steps with dependencies during the boot process or the .target change. The following list shows three frequently used commands that **should not** be called with the syntax "isolate xxxxx.target".

    | target | terminal command | init command alt |
    | -------- | --------------- | :--------: |
    | halt | systemctl halt | - |
    | poweroff | systemctl poweroff | init 0 |
    | reboot | systemctl reboot | init 6 |

    *"halt"*, *"poweroff"*, and *"reboot"* fetch several units in the correct order to terminate the system in an orderly fashion and to reboot if necessary.

### Sources systemd-target

~~~
man systemd.target
~~~

<div id="rev">Last edited: 2022/04/09</div>
