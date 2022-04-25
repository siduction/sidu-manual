% siduction system administration

## System administration in general

### Boot options cheat codes

At the beginning of the boot process, the kernel command line can be edited by pressing the **`e`** key as soon as the Grub menu appears. In edit mode, use the arrow keys to navigate to the kernel line and insert the desired cheatcode(s) at the end. The space character serves as separator. To conitnue the boot process, enter **`Ctrl`**+**`X`**.

The following links lead to the manual page with the tables for the boot options.

1. [siduction specific parameters (Live-CD only)](0204-cheatcodes_en.md#siduction-specific-parameters)
2. [Bootoptions for graphics server X](0204-cheatcodes_en.md#boot-options-for-the-graphics-server-x)
3. [General parameters of the linux kernel](0204-cheatcodes_en.md#general-parameters-of-the-linux-kernel)
4. [Values for the general parameter **vga**](0204-cheatcodes_en.md#vga-codes)

[Detailed reference list for kernel bootcodes from kernel.org](http://files.kroah.com/lkn/lkn_pdf/ch09.pdf) 

### systemd - managing services

systemd knows a total of 11 unit types. The units we deal with most often in everyday life are:

+ systemd.service
+ systemd.target
+ systemd.device
+ systemd.timer
+ systemd.mount
+ systemd.path

We briefly introduce some of the unit types here. Their names already give an indication of their intended functionality. More detailed explanations of the units can be found on our manual page [System administration - systemd](0710-systemd-start_en.md#systemd---the-system-and-services-manager). The complete documentation can be found in the man pages `man systemd.unit`, `man systemd.special`, and `man systemd.<unit_type>` respectively.

The systemd system can be controlled with follwing command, which requires **user** or **root** rights depending on the units:

~~~
systemctl [OPTIONS...] command [UNIT...]
~~~

`systemctl` knows autocompletion by **`TAB`** and the display of all variations by **`TAB`** **`TAB`**. Please read the man page `man systemctl`.

A list sorted by types with all active units or unit files can be output with the following commands:

~~~
$ systemctl list-units # for units
$ systemctl list-unit-files # for unit files
~~~

With the `-a` option all inactive units or unit files are also output.

### systemd.service 

To start or stop a .service unit, use the commands:

~~~
$ systemctl start <UNIT>.service
$ systemctl stop <UNIT>.service
$ systemctl restart <UNIT>.service
~~~

"*Restart*" is useful, for example, to notify the service of a changed configuration. If **root** privileges are required for the action, the root password is requested.  
The command can also be used to terminate a service:

~~~
$ systemctl kill -s SIGSTOP --kill-who=control <UNIT>.service
~~~

With "*kill*", in contrast to "*stop*", the options `-s`, `--signal=`, and `--kill-who=` are available.

+ *"-s"* sends one of the signals `SIGTERM`, `SIGINT`, or `SIGSTOP`. Default is *"SIGTERM"*.
+ *"--kill-who="* allows selection of the processes within the hierarchy to which a signal should be sent. The options are `main`, `control`, or `all`. This sends the signal to the main process, the child processes, or both. Default is *"all"*.

This behavior is similar to the old and still usable command pkill, which is explained below in the section [Terminating a process](0702-sys-admin-gen_en.md#terminating-a-process).


### systemd - UNIT inclusion

To have a (self-made) unit loaded automatically when the computer is booted, enter as **root**:

~~~
# systemctl enable <UNIT_file>
~~~

This creates a group of symlinks according to the requirements in the unit's configuration. Following this, the system manager configuration is automatically reloaded.

The command

~~~
# systemctl disable <UNIT_file>
~~~

removes the symlinks again.

**Example**  
If a PC or laptop without Bluetooth hardware is in use, or you don't want to use Bluetooth, the command (as **root**)

~~~
# systemctl disable bluetooth.service
~~~

will remove the symlinks from all requirements and dependencies within systemd and the service will no longer be available and will not be started automatically.


### systemd-target - formerly runlevel

Already since the 2013.2 "December" release, siduction has been using systemd as the default init system.  
The old sysvinit commands are still supported. (for this a quote from `man systemd`: "... is provided for compatibility reasons and because it is easier to type.")  
More detailed information about systemd can be found on the manual page [System administration - systemd](0710-systemd-start_en.md#systemd---the-system-and-services-manager).  
The various runlevels that are booted or switched to are described by systemd as **target** units. They have the extension **.target**.

| Target Unit | Description | 
| ---- | ---- |
| emergency.target | starts into an emergency shell on the main console. It is the minimum version of a system boot to obtain an interactive shell. This unit can be used to guide the boot process step by step. | 
| rescue.target | starts the base system (including system mounts) and an emergency shell. Compared to multi-user.target, this target could be considered as single-user.target. |
| multi-user.target | starts a multi-user system with a working network, without graphics server X. This unit is used when you want to stop X or to not boot into X. [A system update (dist-upgrade) is performed on this unit](0705-sys-admin-apt_en.md#updating-the-system) . |
| graphical.target | starts multi-user mode with network capability and a running X Window System. |
| default.target | is the default unit that systemd starts at system startup. In siduction this is a symlink to graphical.target (except NoX). |

A look into the documentation **`man SYSTEMD.SPECIAL(7)`** is mandatory to understand the relationships of the different *".target - units"*.

To switch to the system update runlevel, use the following command as **root** in the terminal:

~~~
# systemctl isolate multi-user.target
~~~

Important here is the *"isolate"* command, which ensures the termination of all processes and services that the selected unit does not request.

To shut down or restart the system, the command 

~~~
# systemctl poweroff
   or
# systemctl reboot
~~~

can be used. *"poweroff"* or *"reboot"* (each without .target) are commands that starts several units in the correct order to terminate the system in an orderly fashion and to reboot if necessary.

### Terminating a process

**pgrep and pkill**

Independently of systemd, `pgrep` and `pkill` are a very useful duo to terminate unwelcome processes. Run with **user** or **root** privileges in a console or TTY:

~~~
$ pgreg <tab> <tab>
~~~

The command lists all processes with their name, but without the process ID (PID). We use Firefox as an example in the following.  
The `-l` option prints the PID and the full name:

~~~
$ pgrep -l firefox
4279 firefox-esr
~~~

To display subprocesses, if any, we also use the `-P` option and only the PID:

~~~
$ pgrep -l -P 4279
4387 WebExtensions
4455 file:// Content
231999 Web Content
~~~

then

~~~
$ pkill firefox-esr
~~~

terminates Firefox with the default signal *SIGTERM*.  
With the option **--signal**, followed by the signal number or the signal name, *pkill* sends the desired signal to the process. A clear list of signals can be obtained with *kill -L*.

**htop**

Entered in the terminal, htop is a good alternative because a lot of useful information about the processes and the system load is presented. This includes a tree view, filter and search function, kill signal, and some more. The operation is self-explanatory.

**Emergency exit**

As a last resort before pulling the power plug, you can use the command **`killall -9`** in the terminal.

### Forgotten root password

A forgotten root password cannot be recovered, but a new one can be set.

To do this, the live CD must first be booted.

The root partition must be mounted as **root** (e.g. as /dev/sdb2)

~~~
mount /dev/sdb2 /media/sdb2
~~~

Now enter the root partition with chroot (chroot = changed root) and define a new password:

~~~
chroot /media/sdb2 passwd
~~~

### Setting new passwords

To change a user password, as **user** :

~~~
$ passwd
~~~

To change the root password, as **root** :

~~~
# passwd
~~~

To change a user password as administrator, as **root** :

~~~
# passwd <user>
~~~

### Fonts in siduction

To improve the display of fonts, if necessary, it is important to check the correct settings and configurations of the hardware beforehand.

**Check settings**

- **Correct graphics drivers**  
    Some newer ATI and Nvidia graphics cards do not harmonize very well with the free Xorg drivers. The only reasonable solution in these cases is to install proprietary, non open source drivers. For legal reasons, siduction cannot pre-install these. Instructions for installing these drivers can be found on the [Graphics Drivers](0600-gpu_en.md#graphics-drivers) page of the manual.

- **Correct screen resolutions and refresh rates**.  
    First, it's a good idea to look at the manufacturer's technical documentation, either in print or online. Each monitor has its own perfect combination of settings. These DCC values are usually passed correctly to the operating system. Only sometimes it is necessary to intervene manually to overwrite the basic settings.

    To check which settings the X server is currently using, we use xrandr in the terminal:

   ~~~
    $ xrandr
    Screen 0: minimum 320 x 200, current 1680 x 1050,
    maximum 16384 x 16384
    HDMI-1 disconnected
      (normal left inverted right x axis y axis)
    HDMI-2 connected 1680x1050+0+0 (normal left
      inverted right x axis y axis)  474mm x 296mm
      
      1680x1050     59.95*+
      1280x1024     75.02    60.02
      1440x900      59.90
      1024x768      75.03    60.00
      800x600       75.00    60.32
      640x480       75.00    59.94
      720x400       70.08
    DP-1 disconnected
      (normal left inverted right x axis y axis)
   ~~~

    The value marked with "\*" indicates the setting used,  
    1680 x 1050 pixels with a physical size of 474 x 296 mm.
    In addition, we calculate the actual resolution in px/inch (dpi) to get an indication of the settings for the fonts. With the values given above we get 90 dpi.  
    1680 Px `x` 25,4 mm/inch `/` 474 mm `=` 90 Px/inch (dpi)

- **Check**  
    We use a folding rule or tape measure to determine the actual size of the monitor. The result should differ by less than three millimeters from the values output by xrandr.  

**Basic font configuration**

siduction uses free fonts that have proven to be balanced in Debian. In the graphical user interface TTF or outline fonts are used. If own fonts are chosen, new configuration adjustments may have to be made to get the desired font appearance. 

The system-wide basic configuration is done in the terminal as **root**, using:

~~~
# dpkg-reconfigure fontconfig-config
~~~

For the dialogs called, these settings have proven to be useful:

1. For screen display, please select the preferred method for font tuning.  
   **`autohinter´**
2. Please select to what extent font hinting is applied by default.  
   **`medium`**
3. The inclusion of the subpixel layer improves the text display on flat panel displays (LCD).  
   **`automatic`**
4. By default, applications that support fontconfig use only outline fonts. Use bitmap fonts by default?  
   **`no`**

Subsequently 

~~~
# dpkg-reconfigure fontconfig
~~~

is necessary to rewrite the configuration.

Sometimes rebuilding the font cache is a solution (the first command is for saving data with a date appendix, the second command is to be entered without a line break, i.e. on one line):

~~~
# mv /etc/fonts/ /etc/fonts_$(date +%F)/

# apt-get install --reinstall --yes -o DPkg::Options::=
--force-confmiss -o DPkg::Options::=--force-confnew
 fontconfig fontconfig-config
~~~

### User configuration

**Display type, size, 4K display**

It should be noted that each font has an ideal size range, so identical size settings do not necessarily lead to the same good result for each font.  
The settings can be made conveniently in the graphical interface. They take effect on the desktop immediately, applications have to be restarted to some extent.  
The list shows where in the menu the settings can be found.

+ KDE Plasma
  + *"System Preferences"* > *"Fonts"* > *"Fonts"*
  + *"System Preferences"* > *"Display Setup"* > *"Display Setup"* > *"Global Scaling"*

+ Gnome (Tweak Tool)  
  *"Applications"* > *"Optimizations"* > *"Fonts"*

+ Xfce  
  *"Preferences"* > *"Appearance"* > tab: *"Fonts"*

**Explanation of terms**  
*"Edge smoothing / Antialising"*:  
This is the brightness gradation of the neighboring pixels at the edges to reduce the staircase effect on curves. However, it causes some blurring of the characters.

*"Subpixel rendering / color order / RGB"*:  
This is an extension of antialising for LCD screens by additionally controlling the color components of a pixel.

*"Hinting"*:  
This is the adaptation (change) of the characters to the pixel grid of the screen. It reduces the need for antialiasing, but the font shape no longer conforms exactly to the specifications, unless the font developers have already incorporated hinting variations. For **4K** screens, hinting is usually not necessary.

*"DPI value / scaling factor"*:  
This setting allows a different DPI value or size for the fonts only. Here the display on a **4K** screen can be improved quickly. The following table illustrates the relationship between screen diagonal and DPI value for **4K** screens.

4K resolution: 3840 x 2160 (16:9)

| Diagonal | X-axis | Y-axis | DPI |
| :----: | :----: | :----: | :----: |
| 24 inch | 531 mm | 299 mm | 184 |
| 27 inch | 598 mm | 336 mm | 163 |
| 28 inch | 620 mm | 349 mm | 157 |
| 32 inch | 708 mm | 398 mm | 138 |
| 37 inch | 819 mm | 461 mm | 119 |
| 42 inch | 930 mm | 523 mm | 105 |

Accordingly, a scaling factor of 2.0 is required for 4k screens with a diagonal of 24 inches, and a scaling factor of 1.2 is required for screens with a diagonal of 37 inches in order to obtain approximately equal displays corresponding to SXGA or WSXGA screens with 90 DPI.

### CUPS - the printing system

KDE has a large section on CUPS in the KDE help. Nevertheless, here is a guide on what to do if you have problems with CUPS after a full-upgrade. One of the known solutions is:

~~~
# modprobe lp
# echo lp >> /etc/modules
# apt purge cups
# apt install cups
        OR
# apt install cups printer-driver-gutenprint hplip
~~~

CUPS will now be restarted:

~~~
# systemctl restart cups.service
~~~

Afterwards open a web browser and type this into the address line:

http://localhost:631

A small problem occurs when CUPS opens the corresponding dialog box for legitimation. Occasionally, the user's own user name is already entered there and the password is expected. However, entering the user password does not work. Nothing works. The solution is to change the user name to **root** and enter the root password.

[The OpenPrinting database](https://wiki.linuxfoundation.org/openprinting/database/databaseintro) contains extensive information about various printers and their drivers. Drivers, specifications, and configuration tools are available. Samsung used to supply its own Linux drivers for its printers. After the printer division had been sold to HP, the download page has no longer been available, and HP unfortunately did not include the Samsung drivers in *"hplib"*. Currently, the package printer-driver-splix works best for Samsung printers and Samsung multifunction devices. CUPS is currently in transition and is moving towards printing without drivers via [PWG - IPP Everywhere](https://www.pwg.org/ipp/everywhere.html), see also [debian - an introduction to IPP-Everywhere](https://wiki.debian.org/CUPSIPPEverywhere/).

### Sound in siduction

*In older siduction installations, sound is disabled by default.*

Most sound problems can be solved by clicking on the sound icon in the control bar, opening the mixer, and unchecking "mute", or using the appropriate slider. If the speaker icon is not present, a right click on the control bar is sufficient, then select

in KDE: *"Control Panel Options"* > *"Add Mini Programs..."*  
in Xfce: *"Bar"* > *"Add new items..."*

and select the desired module.

**KDE Plasma**

A right click on the speaker icon in the control bar opens the sound output settings window. The user interface is self-explanatory.

**Gnome**

Right-clicking on the speaker icon in the control bar opens a drop-down menu that contains a slider for the volume.  
Further settings are possible as follows:

Right-click on the desktop > *"Settings"* > *"Audio"*

**Xfce Pulse Audio**

The settings are made via the speaker icon (pulse audio module) in the control bar. Again, the user guidance is self-explanatory. If the icon is missing, you can quickly get started with a terminal by entering the command

~~~
$ pavucontrol
~~~

and configuring the settings in the appearing window.

**Alsamixer**

If you prefer alsamixer, you can find it in the alsa-utils package:

~~~
# apt update
# apt install alsa-utils
# exit
~~~

The desired sound settings are made as **user** from a terminal:

~~~
$ alsamixer
~~~

<div id="rev">Last edited: 2022/04/05</div>
