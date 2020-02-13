<div id="main-page"></div>
<div class="divider" id="install-add"></div>
## Some useful KDE applications not preinstalled on siduction KDE Lite

 `You may need to have non-free enabled in /etc/apt/sources.list.d/debian.list` 

###### konq-plugins - plugins for Konqueror. 

This package contains a variety of useful plugins for Konqueror, the file manager, web browser and document viewer for KDE. Many of these plugins will appear in Konqueror's Tools menu.

~~~  
apt-get install konq-plugins  
~~~

Highlights for web browsing include web page translation, web page archiving, auto-refreshing, HTML and css structural analysis, a search toolbar, a sidebar news ticker, fast access to common options, bookmarklets, a crash monitor, a microformat availability indicator, a del.icio.us bookmarks sidebar, and integration with the aKregator RSS feed reader.

Highlights for directory browsing include directory filters, image gallery creation, archive compression and extraction, quick copy/move, a sidebar media player, a file information metabar/sidebar, a media folder helper, a graphical disk usage viewer and image conversions and transformations. 

###### KDE Deskop Search - (Nepomuk and Strigi) 

KDE's Nepomuk semantic desktop search is already enabled on an siduction-kde.iso. 

Expect the first iteration of indexing to take some time.  [More information about Nepomuk](http://nepomuk.kde.org/) . 

<div class="divider" id="kde-login"></div>
## Login problems to the system under KDE

The content of the /tmp directory is normally cleaned-up on each boot, so some directories and sockets needed by the X-Server are also deleted.

Normally, during the boot-process, the script x11-common for X-Org recreates these things.

Possibly these scripts are not being called during the boot process. To recreate the needed links by calling:

~~~  
# X-ORG: # dpkg-reconfigure x11-common  
~~~

KDE needs a 5% allocation of the partition where the directory /tmp resides for temporary files to be created upon login. If you are running with a 95% full partition you will not be able to login with KDE and will be dropped into tty.

The same goes for kdm looping but not allowing you to log in. A solution is to log into a tty so you can delete and/or clear out some no longer needed applications or files

Alternatively you can use an X window manager that does not require so much space from the system ( for instance fluxbox is already present in an siduction install), or chroot using an siduction live-CD/DVD to clean out the partition to allow you to boot to KDE.

85% is the recommended absolute maximum for a partition that KDE accesses for its /tmp files.(15% free).

<div class="divider" id="ch-th"></div>
## Installing siduction KDE Art and Themes

To install the latest siduction-art to an existing installation:

~~~  
apt-get install siduction-art-kde-xxxx siduction-art-wallpaper-xxxx  
(Where xxxx is the name of the release for example siduction-art-kde-onestepbeyond)  
~~~

This will install the siduction wallpaper and themes.

#### To change the Wallpaper:

`Right click` on your desktop and choose `Folder View Activity Settings` . Under the heading of `Wallpaper`  there is a sub heading called `Picture`  which provides a dropdown list for you to choose which wallpaper to display. You may also click on the Browse button next to the Picture box to use an image you may have on file elsewhere in your computer.

#### To change the Login screen:

To change the login screen, firstly open `systemsettings`  with root/administration privileges:

~~~  
Alt + F2 (to bring up krunner)  
~~~

~~~  
kdesu systemsettings  
~~~

Next click on the `Advanced tab`  and then click on `Login Manager` , go to the `Theme tab`  and choose your preferred theme. `To activate the new Login manager you need to reboot the computer` .

 [KDE information and links](http://kde.org)  

<div class="divider" id="xfce-notes"></div>
## Useful Xfce extras

<div class="divider" id="xfce-notes-1"></div>
### Installing siduction Xfce Art and Themes

To install the latest siduction-art to an existing installation:

~~~  
apt-get install siduction-art-xfce-xxxx siduction-art-wallpaper-xxxx  
(Where xxxx is the name of the release for example siduction-art-xfce-onestepbeyond)  
~~~

This will install the siduction wallpaper and themes, then change your defaults in the Settings menu of Xfce.

 [Xfce Documentation](http://www.xfce.org/documentation) 

 [Xfce wiki](http://wiki.xfce.org) 

<div class="divider" id="dm"></div>
## Installing other desktop environments along with a preinstalled desktop:

Whenever you install another desktop environment along with your current installation, (for example you installed the siduction-kde.iso and you now want to install the Xfce or LXDE desktop environment), a display manager (dm) will most likely be installed along with it or you may have installed it yourself, (gdm, slim or some other dm package).

The problem with this is you will end up with the default Debian runlevel configuration with the consequence that you will need to stop X manually in runlevel 3 before commencing a dist-upgrade.

The solution is:

~~~  
apt-get update  
apt-get install --reinstall distro-defaults  
update-rc.d <dm> remove  
update-rc.d <dm> defaults  
~~~

Examples for `update-rc.d <dm> defaults`  and note the dot **`.`**  :

~~~  
update-rc.d kdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d gdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d slim start 01 5 . stop 01 0 1 2 3 4 6 .  
~~~

<div class="divider" id="desk-freeze"></div>
## Desktop freezes

In such a situation you don't always need the reset button. This could damage the filesystem or lead to loss of data. In any way the filesystem wont be clean after a hard reset (filesystem not clean)

First try changing to a textconsole `alt-ctl-F1`  or restarting the X-server `alt-ctl-backspace` , (If either of these two options do not work, there is still hope):

The SYSRQ-key (print-key, on the upper right side of the keyboard) can help you to cleanly reboot a frozen system.

The following sequence of key-combinations are possible:  
*`alt+sysrq+r`  (should give back control of the keyboard)  
*`alt+sysrq+s`  (issues a sync)  
*`alt+sysrq+e`  (sends term to all processes but init)  
*`alt+sysrq+i`  (sends kill to all processes but init)  
*`alt+sysrq+u`  (filesystems are mounted readonly, prevents fsck at reboot)  
*`alt+sysrq+b`  (reboots the system, without the previous steps this is a 'hard reset').

Its best give every step a few seconds to complete, ending all processes for example could take a little while. The needed letters can be easily remembered with:  
 **"**`R`** eboot **`S`** ystem **`E`** ven **`I`** f **`U`** tterly **`B`** roken"** 

Another way to remember it is:  
 **"**`R`** aising **`S`** kinny **`E`** lephants **`I`** s **`U`** tterly **`B`** oring"** 

<div id="rev">Page last revised 17/01/2012 1800 UTC</div>
