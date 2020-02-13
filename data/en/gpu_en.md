<div id="main-page"></div>
<div class="divider" id="foss-xorg"></div>
## Open Source Xorg drivers for ATI/AMD, Intel &amp; nVidia

Open Source Xorg drivers for nVidia (nouveau), ATI/AMD (Radeon), Intel and others are pre-installed with siduction. 

`Note: An xorg.conf is not generally needed anymore for open source drivers. Exceptions can be e.g. Dual-Screen` 

If you have been running proprietary drivers and wish to revert back to opensource drivers, delete the`/etc/X11/xorg.conf.d/xx-xxxx.conf`  stub.

To revert to **`nouveau`**  from the Nvidia proprietary drivers refer to the german siduction-wiki (sorry we only have a german version online, if you wanna help to translate the wiki,anounce it in the forum or irc) [german siduction-wiki](http://wiki.siduction.de/index.php?title=Wie_entferne_ich_propriet%C3%A4re_nVidia-Treiber%3F) .

More information about:  [ATI/AMD](http://www.x.org/wiki/radeon)   [Intel](http://www.x.org/wiki/IntelGraphicsDriver)  &nbsp;  [nouveau](http://nouveau.freedesktop.org/wiki/FeatureMatrix)  &nbsp;  [X.Org](http://xorg.freedesktop.org) 

<div class="divider" id="x2d"></div>
## 2D video drivers

The drivers for the X.Org X server (see xserver-xorg for a further description) provides support in 2D for Nvidia Riva, TNT, GeForce, and Quadro cards and the ATI Mach, Rage, Radeon, and FireGL cards along with atimisc, r128, r6xx/r7xx and radeon sub-drivers. Radeon and Intel both support 2d acceleration (textured xv) for video playback.

<div class="divider" id="ati-3d"></div>
## ATI/AMD 3D Drivers

Some ATI/AMD cards also support 3D, (and KDE animations), with `xserver-xorg-video-radeon` . So far chipsets up to r700 are supported. Current info on the development state of the radeon driver can always be seen at the  [Radeon-Wiki](http://wiki.x.org/wiki/RadeonFeature) 

To automatically inherit newly packaged non-free firmware when they get updated for 2D and 3D video cards:

~~~  
apt-get install firmware-linux-nonfree  
~~~

Then reboot the computer.

<div class="divider" id="intel"></div>
## Intel 2D and 3D

Intel drivers should work perfectly for 2D and 3D video acceleration as the drivers are included in the Intel free series.

<div class="divider" id="nvidia"></div>
## Binary, closed source drivers for: nVidia with dkms &amp; xorg.conf.d

`You will need to add <contrib non-free> to your debian.list, refer to  [Adding non-free to sources](nf-firm-en.htm#non-free-firmware)` 

For the most complete and accurate listing of supported nvidia GPUs please see the Supported Products List available from the  [NVIDIA Linux Graphics Driver download page](http://www.nvidia.com/object/unix.html) .

You can also read  [nvnews](http://www.nvnews.net/vbulletin/showthread.php?t=122606)  for other options.

New and old installs will need to ensure that the systemwide config `/etc/X11/xorg.conf.d`  exists and add a file to the directory called `20-nvidia.conf`  : 

~~~  
mkdir /etc/X11/xorg.conf.d  
touch /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

With your favourite text editor, (e.g. kwrite, kate, mousepad, mcedit, vi, vim) open the file:

~~~  
<editor> /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

and add the following codebox in its entirety to 20-nvidia.conf:

~~~  
#  
Section "Device"  
Identifier "Device0"  
Driver "nvidia"  
EndSection  
# This is a trailing line, it is needed so that End Section is not the last line  
~~~

If you have more than one graphics card you will need ascertain the PCI and to include it in the 20-nvidia.conf:

~~~  
lspci | grep -i vga  
~~~

This should return syntax similar to this:

~~~  
01:00.0 VGA compatible controller:  
~~~

Add the 01:00.0 busid as an extra line under the 'Driver' line, however note that the syntax is `PCI:x:y:z:`  with zeros dropped and colons added, therefore:

~~~  
BusID "PCI:1:0:0"  
~~~

#### Installing the nvidia drivers

`NOTE: Use apt-cache search nvidia and apt-cache show <package> to ascertain the correct driver for you. There are basically 2 types of nvidia drivers, the current Debian Sid 3D drivers and the legacy Debian Sid 3D drivers.` 

##### For current 3d nvidia drivers &ge; GeForce 6xxx :

Prepare the module:

~~~  
apt-get install nvidia-driver  
~~~

Reboot PC for installation of the module to take effect.

When xorg updates you only need to reinstall nvidia-driver:

~~~  
apt-get install --reinstall nvidia-driver  
~~~

#### Naming scheme for legacy nvidia drivers in Debian

+ nvidia-kernel-legacy-96xx is for GeForce 4  
+ nvidia-kernel-legacy-173xx is for GeForce 5  
+ nvidia-kernel-legacy-304xx: GeForce 6, GeForce7  

##### Example for legacy 3d nvidia drivers using &le; GeForce 5xxx :

For other legacy drivers just replace 173xx number with your driver number.

~~~  
apt-get install nvidia-legacy-173xx-driver  
~~~

When xorg updates you only need to reinstall nvidia-legacy:

~~~  
apt-get install --reinstall nvidia-legacy-173xx-driver (or the appropriate version)  
~~~

#### Module load failure

Should nvidia fail to load, for whatever reason:

~~~  
modprobe nvidia  
~~~

Then reboot the computer.

<div id="rev">Page last revised 25/11/2013 20:55 UTC</div>
