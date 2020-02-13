<div id="main-page"></div>
<div class="divider" id="net-set1"></div>
## Setting up for WiFi Roaming with wpa

`You will most likely need non-free firmware to be available on a USB-stick to install on the operating system. Please refer to  [non-free firmware debs on a stick](nf-firm-en.htm#non-free-firmware) .` 

### Overview

wpa-roaming is a method with which you can browse and connect to wireless networks `with and/or without a graphical desktop environment` .

The result of the following set up is that if an ethernet cable is not attached, wlan0 takes precedence and connects you to your desired wireless network or to an available open wireless network or a predetermined wireless network. If you connect an ethernet cable, the cabled network connection immediatly shuts down WiFi access and eth0 then connects you to the cabled network. By unplugging the network cable the wireless connection will instantly be available again.

### Setting up the network configuration

As `root`  adapt your `/etc/network/interfaces`  file so that it looks like this. (the name of the interface may be varied):

~~~  
# The loopback network interface  
auto lo  
iface lo inet loopback  
#Added by user  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
#this line must always be here  
iface default inet dhcp  
~~~

Next wpa_supplicant needs a .conf file, wpa-roam.conf

~~~  
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf /etc/wpa_supplicant/wpa-roam.conf  
~~~

Use a text editor to open the file

~~~  
<editor> /etc/wpa_supplicant/wpa-roam.conf  
~~~

Uncomment line 30 (remove the **`#`** ). This must be done otherewise configs will not be saved to file:

~~~  
update_config=1  
~~~

To set up a laptop or a desktop that only needs to access a secured network immediately, uncomment lines, (remove the **`#`** ),for WPA-WPA2PSK as applicable: 

WPA example:

~~~  
network={  
ssid="siduction_Worldwide" #Example WPA Network  
psk="mysecretpassphrase"  
}  
~~~

The next step secures wpa-roam.conf from unwanted access. This is necessary, because secret keys of private networks are saved in this file:

~~~  
chmod 600 /etc/wpa_supplicant/wpa-roam.conf  
~~~

Bring up the wireless connection

~~~  
ifup wlan0  
~~~

Next check to see if you are connected to the network:

~~~  
wpa_cli status  
~~~

The output should look someting like this:

~~~  
Selected interface 'wlan0'  
bssid=94:0c:6d:aa:f4:42  
ssid=siduction_Melbourne  
id=3  
pairwise_cipher=CCMP  
group_cipher=CCMP  
key_mgmt=WPA2-PSK  
wpa_state=COMPLETED  
ip_address=192.168.1.102  
~~~

If you can not see ip_address= numbers you are not connected so recheck the configs by first stopping wlan0:

~~~  
wpa_action wlan0 stop  
~~~

Should you require specialised networking configs see  [here](#net-set3) 

<div class="divider" id="net-set2"></div>
## To enable switching between wired and wireless networks

First see  [Switching between cable and wireless](inet-ifplug-en.htm)  because if its not set up correctly switching and connection to the network will not happen.

After setting up ifplugd the final config should look like this: 

~~~  
auto lo  
iface lo inet loopback  
# governed by ifplugd ... do not use allow-hotplug or auto options  
iface eth0 inet dhcp  
#Added by user  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
#this line must always be here  
iface default inet dhcp  
~~~

<div class="divider" id="net-set3"></div>
## Using wpa-roam.conf with manually specified network configurations

With the help of `IDString`  and `Priority`  you can direct to which network the box is connected at boot time. Highest priority is `1000` , lowest priority is `0` . You have to add the `id_str`  to `/etc/network/interfaces`  as well.

###### The syntax for /etc/network/interfaces.

First is for the connection to DHCP servers, the second is if you are provided with a fixed IP address. To adjust your settings:

~~~  
# id_str="home_dhcp"  
iface home_dhcp inet dhcp  
#this line must always be here  
iface default inet dhcp  
# id_str="home_static"  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
~~~

###### Practical Examples

If you want to be automatically connected to your home WLAN when at home, give the the IDString "home" and priority "15". If you are travelling, and want the laptop to connect to any free, non passworded network which is available, give it the IDString "stalk" and priority "1" (very low). But please, always check if your connection is legal and disconnect if it is obviously not intended to be free.

Example stanzas in /etc/network/interfaces:

~~~  
# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)  
# The loopback interface  
# automatically added when upgrading  
auto lo  
iface lo inet loopback  
allow-hotplug eth0  
iface eth0 inet dhcp  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
#this line must always be here  
iface default inet dhcp  
iface home inet dhcp  
iface stalk inet dhcp  
~~~

Example /etc/wpa_supplicant/wpa-roam.conf (SSID and passwords are changed or just explained):

~~~  
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev  
update_config=1  
network={  
ssid="my_ssid"  
scan_ssid=1  
psk=123ABC ##here comes the passphrase in hexadecimal code!!  
# psk="password_in_ascii" ##you dont need to  
key_mgmt=WPA-PSK  
pairwise=TKIP  
group=TKIP  
auth_alg=OPEN  
priority=15  
id_str="home"  
}  
network={  
ssid=""  
scan_ssid=1  
key_mgmt=NONE  
auth_alg=OPEN  
priority=1  
disabled=1 ## no automatic connection, one needs wpa_cli or wpa_gui  
id_str="stalk"  
}  
~~~

With "disabled=1" you will not be automatically connected to a defined network block (open WLANs), you have to initiate roaming through wpa_gui or wpa_cli. For automatic roaming don't use the option at all or comment the line with the "disabled" option using a #.

### Notes

###### 1. Easy to reuse

Once set up, you can easily reuse your setup on other laptops or desktops with WLAN cards. Just copy /etc/network/interfaces (adjust the name of the interface if needed) and /etc/wpa_supplicant/wpa-roam.conf to your new box. There is no need of "installing" anything after that.

###### 2. Backup

It is a good idea to backup /etc/network/interfaces and /etc/wpa_supplicant/wpa-roam.conf, but `encrypt your backup because it contains sensitive information` .

A good method to safely backup and encrypt the config files is with tar and gpg. As root:

~~~  
tar -cf- /etc/network/interfaces /etc/wpa_supplicant/wpa-roam.conf | gpg -c > backup_name.tar.gpg  
~~~

A file has now been created in $ HOME:  
backup_name.tar.gpg

To list the contents of the backup_name.tar.gpg file:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vtf -  
~~~

To extract and decrypt the contents of the archive backup_name.tar.gpg file:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vxf -  
~~~

###### 3. Hidden SSIDs

Hidden SSIDs are detected when `scan_ssid=1`  is defined in the network block.

<div class="divider" id="rousec-wifi"></div>
## Basic wireless modem/router security

Where you have control of the wireless router/modem, there are a few basic security policies to implement to help protect your side of the network from intruders.

###### Basic protocol choices

+ WPA2-PSK is the better option.  
+ For encryption protocol choose AES.  
+ The passphrase should be really strong.  

###### Passphrase / passwords

For a passphrase/password that is strong and not really able to be memorised, use pwgen in a terminal (also read: man pwgen):

~~~  
$ pwgen -s 63 1  
VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

+ -s = secure (no mnemonics)  
+ 63 = amount of characters  
+ 1 = only generate one random password  

Without the -s you get speaking type passwords. however it is unlikley you would want that:

~~~  
$ pwgen 8 3  
Sooxae2s Niew9ugh Hi7eeloo  
~~~

Once you have generated the passphrase/password store it in a text file on a USB-stick and apply the passphrase/password to the other computers that use your wireless network. Do not store the passphrase/password on your computer.

###### Example of final router setup:

~~~  
Version: WPA2-PSK  
Encryption: AES  
PSK Password: VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

<!-- all occurances of WEP have been removed, as it cannot be recommended anmore -->
<div id="rev">Content last revised 08/01/2012 1800 UTC</div>
