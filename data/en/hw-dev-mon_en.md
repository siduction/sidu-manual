<div id="main-page"></div>
<div class="divider" id="mon-res"></div>
## Changing the Screen Resolutions

#### xrandr

##### Supported Card Drivers

+  xserver-xorg-video-intel (since 2.0)  
+ xserver-xorg-video-nouveau ([Refer to the nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (since 6.7.192)  

First step is just to type xrandr to see if it is supported, if xrandr is not supported check the xorg version and driver used.

To change the resolution of your primary screen assuming your card can support it, for example:

~~~  
xrandr --output VGA --mode 1440x900  
~~~

<div class="divider" id="xrandr"></div>
## Dual Monitors and xrandr

 <span class="highlight-2">xorg.conf is deprecated, if you use free drivers.</span> If you have an xorg.conf stanza under <span class= "highlight-3">/etc/X11/xorg.conf.d</span>, because you use proprietary drivers for your graphics card, you should save it now before proceeding.

xorg.conf, if present at all, is now modular, for example, each module contains everything referring a "device" for instance, the display or a mouse.

With xrandr you can configure your primary and secondary screen without restarting X, (hotplug). xrandr replaces xinerama and mergedFB. With xrandr 1.2 enabled, the "old way configuration" in xorg.conf ( xinerama and mergedFB) may not work anymore.

##### Supported Card Drivers

+  xserver-xorg-video-intel (since 2.0)  
+ xserver-xorg-video-nouveau ([Refer to the nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (since 6.7.192)  

### Preparation for xrandr configurations of a PC with Dualhead

**`Note:`**  Ideally, if you are running 2 monitors from a PC all the time, your `xorg.conf`  should be altered to be permanently to reflect that mode.

A laptop/notebook needs to be dynamically configured (as opposed to a PC with 2 monitors) and when you reboot you will need to start over, unless you set up the dual-head with whatever parameters you use in xrandr, then you copy/paste that in a script to`~/.kde/Autostart/` .

#### Getting familiar with xrandr

First step is just to type xrandr in a shell as user to get familiar with the output:

~~~  
xrandr  
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768  
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm  
1024x768 60.0+ 75.1 70.1 60.0 59.9  
832x624 74.6  
800x600 72.2 75.0 60.3 56.2  
640x480 75.0 72.8 66.7 60.0  
720x400 70.1  
~~~

Here you see that only vga, for the PC (see  [Appendix A](hw-dev-mon-en.htm#aa)  for output name explanation). You see the resolutions that are supported by that screen and (which is important for dual head) the maximum screen size (here 2048x768).

Now connect your other external screen and run xrandr again:

~~~  
$ xrandr  
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768  
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm  
1024x768 60.0+ 75.1 70.1 60.0 59.9  
832x624 74.6  
800x600 72.2 75.0 60.3 56.2  
640x480 75.0 72.8 66.7 60.0  
720x400 70.1  
DVI-0 connected 1024x768+1024+0 (normal left inverted right x axis y axis) 310mm x 230mm  
1024x768_85.00 85.0+  
1024x768 85.0 + 84.9 74.9 75.1 70.1 60.0 43.5  
832x624 74.6  
800x600 84.9 72.2 75.0 60.3 56.2  
640x480 84.6 75.0 72.8 66.7 60.0  
720x400 87.8 70.1  
S-video disconnected (normal left inverted right x axis y axis)  
~~~

Here you see that a DVI screen is connected as well, and it supports resolutions from 720x400 to 1024x768 at given refresh rates.

###### Configuration scenarios

Basic syntax

~~~  
xrandr --output <output> --rate <rate> --mode <mode> --left-of|--right-of|--above|--below|--same-as <output>  
~~~

Where:

+ &lt;output&gt; is output name (see  [Appendix A](hw-dev-mon-en.htm#aa))  
+ &lt;rate&gt; is refresh rate given by xrandr output (optional)  
+ &lt;mode&gt; is resolution given by xrandr output (optional)  

##### Change resolution of primary screen

~~~  
xrandr --output VGA --mode 1024x768  
~~~

###### Clone

As many external screens / video projectors do not run on 1280x800 but on e.g. 1024x768, choose this as an example:

~~~  
xrandr --output VGA --mode 1024x768 --output LVDS --mode 1024x768  
~~~

To turn off secondary screen and get back normal resolution on primary screen just do a:

~~~  
xrandr --output VGA --off --output LVDS --mode 1280x800  
~~~

##### Multiple display desktop

As intel GMA &lt;=945GM/GMS looses 3d support with a virtual screen &gt;2048x2048, you cannot put both screens next to each other in high resolution, both at 1024x768 work well:

~~~  
xrandr --output LVDS --mode 1024x768 --output VGA --mode 1024x768 --left-of LVDS  
~~~

To disable multi screen just disable secondary screen and change resolution of primary screen back (if needed):

~~~  
xrandr --output VGA --off (--output LVDS --mode 1280x800)  
~~~

Another option is to put the secondary screen above/below the primary:

~~~  
xrandr --output LVDS --mode 1280x800 --output VGA --mode 1280x1024 --above LVDS  
~~~

The result is a virtual screen resolution of 1280x1824 which is below 2048x2048 Another solution could be to rotate the screen:

~~~  
xrandr --verbose --output LVDS --mode 1280x800 --output VGA --mode 1024x768 --rotate left --left-of LVDS  
~~~

NOTE: This only works if you can rotate your physical screen as well

###### Example of a permanently configured PC with dual monitors with xrandr with code snippet in `/etc/X11/xorg.conf.d/30-screen.conf` :

~~~  
#30-screen.conf  
Section "Monitor"  
Identifier "DVI-0"  
Option "Primary" "true"  
EndSection  
Section "Monitor"  
Identifier "DVI-1"  
Option "RightOf" "DVI-0"  
EndSection  
Section "Device"  
Identifier "ATI Radeon HD 2600"  
Option "Monitor-DVI-0" "DVI-0"  
Option "Monitor-DVI-1" "DVI-1"  
EndSection  
~~~

Note

+ Virtual screen is limited to 2048x2048 for intel, Though it's possible to set a higher virtual resolution you will loose DRI support. There does not seem to be limits for nvidia/ati.   
+ TV Out does not work with ATI  
+  if DDC probing does no work correctly with ATI (Xorg.0.log: (WW) RADEON(0): DDC2/I2C is not properly initialised), you might not be able to overide the values with modelines  
+ When trying to setup a big desktop (dual-head) and xrandr says the resolution you're requesting is bigger than the one xrandr can support, You should use "Virtual" and the wanted resolution. (Look for the Screen Section in Apendix A)  
+ For any video card, but intel, the virtual resolution should be big enough for both monitor's resolution. example: monitor1= 1024x768 and monitor2=1280x1024, then the virtual screen should be (1024+1280)x(1024>768) -> 2304x1024  

<div class="divider" id="aa"></div>
###### Appendix A

###### Intel

~~~  
Output names:  
* LVDS: internal laptop panel  
* TMDS-1: external DVI port  
* VGA: external VGA port  
* TV: external TV output  
~~~

###### ATI

~~~  
Output names:  
* LVDS: internal laptop panel  
* DVI-0: first external DVI port  
* DVI-1: second external DVI port (if present)  
* VGA-0: first external VGA port  
* VGA-1: second external VGA port (if present)  
* S-video  
~~~

###### Nvidia

~~~  
nv driver supports RandR1.2 on G80 boards  
Output names:  
* LVDS: internal laptop panel  
* DVI0: first external DVI port  
* DVI1: second external DVI port (if present)  
~~~

###### Links

 [http://wiki.debian.org/XStrikeForce/HowToRandR12](http://wiki.debian.org/XStrikeForce/HowToRandR12) 

 [http://bgoglin.livejournal.com/9846.html](http://bgoglin.livejournal.com/9846.html) 

 [http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419) 

 [http://www.thinkwiki.org/wiki/Xorg_RandR_1.2](http://www.thinkwiki.org/wiki/Xorg_RandR_1.2) 

<div class="divider" id="mon-binary"></div>
## Dual Monitors (using binaries)

 `For proprietary drivers read the documentation from your graphic card manufacturer.` 

### nvidia

Use the nvidia xorg configurator  [http://www.sorgonet.com/linux/nv-online/](http://www.sorgonet.com/linux/nv-online/)  and alter your xorg files accordingly.

### Native ATI - radeon

NOTE: You will need to get the configuration information of the second monitor. To do this, you need to unplug one monitor and boot the liveCD to generate xorg.conf, copy it, then do the same with the other one.

For full configuration information see  [http://ftp.x.org/pub/X11R6.9.0/doc/html/radeon.4.html](http://ftp.x.org/pub/X11R6.9.0/doc/html/radeon.4.html) 

<div id="rev">Page last revised 08/01/2012 1800 UTC</div>
