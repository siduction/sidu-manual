<div id="main-page"></div>
<div class="divider" id="start-services"></div>
## Enabling services in siduction

### insserv : To start/stop already installed services:

**`Read `/usr/share/doc/insserv/README.Debian` , the release notes and the man pages carefully:`** 

~~~  
$ man insserv  
$ man invoke-rc.d  
$ man update-rc.d  
google LSB headers  
~~~

For 'start':

~~~  
/etc/init.d/<service> start  
~~~

For 'stop':

~~~  
/etc/init.d/<service> stop  
~~~

For 'restart':

~~~  
/etc/init.d/<service> restart  
~~~

To prevent services running at-startup:

~~~  
update-rc.d <service> remove  
[will remove all startup links]  
~~~

To set a service to default value at boot [not necessarily required]:

~~~  
update-rc.d <service> defaults  
[will make missing startup links]  
~~~

To read the current list of services with default values:

~~~  
ls /etc/rc5.d  
~~~

`S`  means the service will start in runlevel 5.  
`K`  means service will not start (manual override).

<div class="divider" id="bum"></div>
## Boot-Up Manager (bum) - Graphical services configuration tool

If the logic of a debian system boot up sequence is not very clear and familiar to you, you should not play with symlinks, permissions and so forth. In order to avoid messing up your system. Boot-Up Manager will help you to automate your configuration.

Boot-Up Manager is a GUI runlevel configuration editor which allows you to configure what init services are invoked when the system boots up or reboots. It displays a list of every service which could be started at boot. You can toggle individual services on and off.

~~~  
apt-get install bum  
~~~

To use the Boot-Up Manager GUI:

~~~  
$ suxterm  
password:  
bum  
~~~

  [Detailed documentation on Boot-Up Manager (bum)](http://www.marzocca.net/linux/bumdocs.html) . 

<div class="divider" id="pkill"></div>
## Killing a service or process

`pkill`  is very useful as its human readable and can work in both user and root mode in the terminal or at tty

~~~  
pkill -n service  
~~~

If you are not sure of the correct spelling of the process or service you wish to kill `pkill <tab> <tab>`  will provide a list 

htop is also good a alternative. (killall -9 is your last alternative).

<div class="divider" id="init"></div>
## siduction runlevels - init

This is the list for the siduction operating system runlevels, please note that it does differ from Debian default runlevels:

| Runlevel | siduction | Debian | 
| ---- | ---- | ---- |
|  **init 0**  |  Powers off the PC. |  Powers off the PC. | 
|  **init 1**  | Single user (safety or rescue mode). Dæmons like apache and sshd are stopped. Do not go to this level via remote access. | Single user, stops services (safety or rescue mode). Do not go to this level via remote access. | 
|  **init 2**  |  Multi-User mode with the network running, with the X-Window System not running, and/or to stop or not enter the X-Window System. | Debians' default runlevel for Multi-User mode with the network running the X-Window System. | 
|  **init 3**  |  Multi-User mode with the network running, with the X-Window System not running, and/or to stop or not enter the X-Window System.  [This is where a dist-upgrade is actioned](sys-admin-apt-en.htm#apt-upgrade) . | Same as runlevel 2 / init 2. | 
|  **init 4**  |  Multi-User mode with the network running, with the X-Window System not running, and/or to stop or not enter the X-Window System. | Same as runlevel 2 / init 2. | 
|  **init 5**  | The siduction default for Multi-User mode with the network running the the X-Window System, and/or to start the X-Window System. | Same as runlevel 2 / init 2. | 
|  **init 6**  |  Restart/reboot the system. |  Restart/reboot the system. | 
|  **init S**  |  This is where early boot time services are executed on a 'once only basis'. You cannot switch to it after it has been run. | This is where early boot time services are executed on a 'once only basis'. You cannot switch to it after it has been run. | 


---

To ascertain the runlevel (init) you are currently in:

~~~  
who -r  
~~~

Required reading for any siduction and Debian system administrator regarding runlevels:

~~~  
man init  
~~~

<div class="divider" id="pw-lost"></div>
## Lost root passwords

You cannot recover a lost password but you can set a new one.

First boot from the Live-CD.

As root mount your root partition (for example /dev/sdb2)

~~~  
mount /dev/sdb2 /media/sdb2  
~~~

Now chroot into your old root-Partition with and set a new password:

~~~  
chroot /media/sdb2 passwd  
~~~

<div class="divider" id="pw-new"></div>
## Setting new passwords

To change your 'user' password, as `$ user` :

~~~  
$ passwd  
~~~

To change your 'root' password, as `# root` :

~~~  
passwd  
~~~

To change a user's password as an administrator, as `# root` :

~~~  
passwd <user>  
~~~

<div class="divider" id="fonts"></div>
## Fonts in siduction

##### Correct dpi settings - Basic Philosophy

DPI settings are problematic to guess, but are actually perfectly done by X.

##### Correct resolutions and refresh rates

Every monitor has its own perfect settings combination, but unfortunately not all of them report the right DCC values, and sometimes it is in need of a manual overwride.

<!--##### Correct graphics adapter drivers

Some newer ATI and Nvidia cards simply don't play well with the free Xorg drivers, and the only reasonable solution in such case are the commercial closed source drivers. siduction will not pre-install those for legal reasons,  [The solutions can be found here.](gpu-en.htm#foss-xorg) 

-->
##### Default Font selections, rendering and sizes

siduction uses (Debian) pre-selected free fonts which have proved to be very balanced, your own fonts selection can/may deteriorate the quality of rendering. But there are a few powerful options in Debian (apart from KDE>systemsettings ) that can help providing spotless rendering with other fonts as well. But please be aware that every font has just a few real perfect sizes, other sizes may not play well.

Playing with the dpi size with the command may also be of assistance:

~~~  
fix-dpi-kdm  
~~~

It should show the DPI for your screensize, but you can play with that as well.You will need to go to init 3 and back to init 5 to make it work or do a reboot.

 After having changed font type or DPI (in X or Firefox/Iceweasel), you might need some readjustments to get results to your liking, especially. after a change from Bitmap Fonts to True Type Fonts or the other way round through:

~~~  
dpkg-reconfigure fontconfig-config  
~~~

Choose native and autohinter on automatic. Otherwise play around with it.

Should you need to rebuild your font cache:

~~~  
fc-cache -f -vv  
~~~

If that does not work you might need to reinstall the package with a default config file of your fonts cache by:

~~~  
apt-get install --reinstall --yes -o DPkg::Options::=--force-confmiss -o DPkg::Options::=--force-confnew fontconfig fontconfig-config  
~~~

##### GTK based applications like Firefox/Iceweasel

GTK-based apps in general are problematic with KDE defaults. This could be solved by this:

~~~  
apt-get install gtk2-engines system-config-gtk-kde gtk-qt-engine gtk2-engines-qtcurve  
~~~

In `System Settings >Appearance`  you will have a new menu item called `GTK Styles and Fonts` . Set 'GTK Styles' to use 'Cleanlooks' and have the 'GTK Fonts' set to use 'KDE fonts' `or`  experiment with the various options to suit your preferences.

This MAY fix your font rendering in gtk apps.

<div class="divider" id="cups"></div>
## CUPS

KDE has a large section inbuilt in the KDE help, however dist-upgrades often can cause cups to misbehave, this is one known solution,:

~~~  
modprobe lp  
echo lp >> /etc/modules  
apt-get purge cupsys cups  
apt-get install cups  
        OR  
apt-get install cups printer-driver-gutenprint hplip  
~~~

Make sure CUPS is running:

~~~  
/etc/init.d/cups restart  
~~~

 Then in a web browser: 

~~~  
http://localhost:631  
~~~

Another gotcha is when setting up cups via the GUI method, is that it brings up a dialog box asking for you to put in your password, however the dialog box has your user name, prefilled, so when you put in your user password, it does not work, What is really wants is for you to change the user name to **`root`**  and put in your **`root password`** .

 [The OpenPrinting database](http://www.linuxfoundation.org/collaborate/workgroups/openprinting/database/databaseintro)  contains a wealth of information about specific printers, along with extensive driver information, the drivers themselves, basic specifications, and an associated set of configuration tools. 

<div class="divider" id="sound"></div>
## Sound in siduction

`Sound is muted by default in siduction.` 

The KDE version uses Kmix and XFCE uses Mixer.

Often it is only a matter of clicking on the sound icon in the taskbar and unchecking the 'Mute box'.

###### Kmix

In Kmix you will need to activate the options you prefer for channel options, `Kmix>Setting>Configure Channels.`  Or in a terminal:

~~~  
$ kmix  
~~~

###### XFCE

In XFCE run the mixer application and add some controls via the `Multimedia>Mixer`  and click the `Select Controls box.`  Or in a terminal:

~~~  
$ xfce4-mixer  
~~~

### Alsamixer

If you prefer to use Alsamixer, it is in the alsa-utils package:

~~~  
apt-get update  
apt-get install alsa-utils  
exit  
~~~

Set your preferred sound settings as **`$user`**  from the terminal:

~~~  
$ alsamixer  
~~~

<!-- [See wiki.]() 

-->
<div id="rev">Content last revised 24/07/2012 1830 UTC</div>
