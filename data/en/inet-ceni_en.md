<div id="main-page"></div>
<div class="divider" id="netcardconfig"></div>
## Getting online / How to configure the network with Ceni

`You will most likely need non-free firmware to be available on a USB-stick to install on the operating system. Please refer to  [non-free firmware debs on a stick](nf-firm-en.htm#fw-detect) .` 

If you have a DHCP server in your LAN and your computer is connected to it while booting up. Your network-settings should be configured automatically - otherwise you need to start `Ceni`  Click `Kmenu>Internet>Ceni` . This will open a terminal/konsole whereupon it will ask you for your root password, ( on a live-Cd there is no password set).

The fast way to access Ceni is to open the terminal/konsole and type 

~~~  
ceni  
~~~

whereupon it will ask you for your root password.

![Ceni Network Interfaces](../images-common/images-netcard/Ceni-interface-selection-01.png "Ceni Network Interfaces") 

![Ceni Network Settings](../images-common/images-netcard/Ceni-static-network-configuration-02.png "Ceni Network Settings") 


---

`One of the Ceni strengths is its ability to configure WiFi wireless cards on the fly, an alternative is here:  [WiFi - Basic setup guide](inet-wpa-en.htm#wpa-basic) : `

![Ceni Wireless Settings](../images-common/images-netcard/Ceni-wireless-network-selection-02.png "Ceni Wireless Settings") 

![Scan or Roam](../images-common/images-netcard/Ceni-wireless-network-configuration-01.png "Ceni Scan or Roam") 

<div class="divider" id="dial-mod"></div>
## Connecting with a 56k Dial-up Modem

KDE has a front end for dial up modems called `KPPP Internet Dial-up Tool` , found in the main menu under Internet.

The application has an internal help manual built in and provides a comprehensive guide to setting up your modem to enable you to get on line. 

<div class="divider" id="firewalls"></div>
## Firewalls

Firewalls are usually not needed if behind a properly configured router. However they play a very important security role if you need to connect to the internet with a adsl usb modem or via dial-up modem:

~~~  
apt-get install shorewall  
~~~

or
~~~  
apt-get install shorewall6  
~~~

for use with IPv6
 [Shorewall - A graphical netfilter configurator for Linux.](http://www.shorewall.net/)  [Please do not install shorewall on remote machines, you will most definitely lock yourself out!]

<div id="rev">Content last revised 02/09/2012 1800 UTC</div>
