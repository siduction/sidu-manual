<div id="main-page"></div>
<div class="divider" id="hotswitch"></div>
## Switching between cable and wireless

`You will most likely need non-free firmware available on a USB-stick to install on the operating system. Please refer to  [non-free firmware debs on a stick](nf-firm-en.htm#non-free-firmware)` .

The easiest way to switch between a wired LAN connection and a wireless LAN connection is using the daemon ifplugd. It is installed by default.

<div class="divider" id="interfaces"></div>
###### Adjust your /etc/network/interfaces

First step to take is to make sure the eth0 is not configured:

~~~  
ifdown eth0  
~~~

###### Example for a working interfaces:

The configuration is easy: - the wired interface (here: eth0) should not be preceded by any configuration like "allow-hotplug" or others:

~~~  
auto lo  
iface lo inet loopback  
# governed by ifplugd ... do not use allow-hotplug or auto options  
iface eth0 inet dhcp  
~~~

Then reconfigure ifplugd:

~~~  
dpkg-reconfigure ifplugd  
~~~

###### Debconf settings of ifplugd

Leave static interfaces free:

![Static interfaces](../images-common/images-hotplug/ifplugd1.png "Static interfaces") 

Add your wired interface (here "eth0") to "hotplugged interfaces":

![Hotplugged interfaces](../images-common/images-hotplug/ifplugd2.png "Hotplugged interfaces") 

Help page for custom configurations:

![Configuration help](../images-common/images-hotplug/ifplugd3.png "Configuration help") 

Leave the default configurations, just hit OK:

![Default configuration](../images-common/images-hotplug/ifplugd4.png "Default configuraton") 

Tell ifplugd to stop before suspend, it will be restarted after resume automatically:

![Suspend behaviour](../images-common/images-hotplug/ifplugd5.png "Suspend behaviour") 

The result is a configuration file /etc/default/ifplugd containing:

~~~  
INTERFACES=""  
HOTPLUG_INTERFACES="eth0"  
ARGS="-q -f -u0 -d10 -w -I"  
SUSPEND_ACTION="stop"  
~~~

Your computer is now set up to move between various networks including wireless. To set up for wireless roaming, refer to  [Setting up for WiFi Roaming with wpa](inet-setup-en.htm) .

<div id="rev">Content last revised 08/01/2012 1800 UTC</div>
