% Network - IWD

## IWD instead of wpa_supplicant

Intel's [iNet wireless daemon](https://iwd.wiki.kernel.org/) (iwd) sends the WPA Supplicant into well-deserved retirement. Only one tenth the size and much faster, iwd is the successor. 

Further information can be found on the [Arch Linux wiki](https://wiki.archlinux.org/index.php/Iwd) or the [debian wiki](https://wiki.debian.org/NetworkManager/iwd). 

If you want, you can use iwd as a replacement for wpa_supplicant, either standalone or in conjunction with NetworkManager. 

### Install IWD

> Note:  
> Under Debian it is unfortunately not possible to install the NetworkManager (standalone) without wpa_supplicant.
 
If you want to do this, there are two options, the second option is the more sensible and easier.

1. install NetworkManager from the sources
2. do not start or mask the wpa_supplicant.service, because it will be installed if you use apt.

If you want to use iwd without installing NetworkManager, you don't have to worry about this.
    
Furthermore we point out that siduction uses systemd. So we will not go into how to configure iwd without systemd!

Procedure with NetworkManager installed

+ first **iwd** is installed, 
+ then the **wpa_supplicant.service** is stopped and masked,
+ then the **NetworkManager.service** is stopped,
+ now we create the file `/etc/NetworkManager/conf.d/nm.conf` and enter **iwd** there, 
+ then we create the file `/etc/iwd/main.conf` and fill it with appropriate content, 
+ activate and start the **iwd.service**, 
+ and start the **NetworkManager.service**.

Now just run the following commands as root in the terminal to use iwd:

~~~sh
~# apt update
~# apt install iwd
~# systemctl stop wpa_supplicant.service
~# systemctl mask wpa_supplicant.service
~# systemctl stop NetworkManager.service
~# touch /etc/NetworkManager/conf.d/nm.conf
~# echo -e '[device]\nWiFi.backend=iwd' > /etc/NetworkManager/conf.d/nm.conf
~# touch /etc/iwd/main.conf
~# echo -e '[General]\nEnableNetworkConfiguration=true \n\n[Network]\nNameResolvingService=systemd' > /etc/iwd/main.conf
~# systemctl enable -now iwd.service
~# systemctl start NetworkManager.service
~~~

See if it worked

+ /etc/NetworkManager/conf.d/nm.conf

~~~sh
~$ cat /etc/NetworkManager/conf.d/nm.conf
[device]
WiFi.backend=iwd
~~~

+ /etc/iwd/main.conf

~~~sh
~$ cat /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
~~~

Now you are able to start an interactive shell in the terminal with the command [**iwctl**](#wifi-connection-with-iwctl). Typing "help" will output all options to view, configure WiFi hardware and connect to a network. Also, you can use **nmtui** or [**nmcli**](#wifi-connection-with-nmcli) in the terminal or NetworkManager in the graphical interface, respectively.

> Note:  
> It is possible that non-free firmware must be installed from a USB stick or via LAN!

### WiFi connection with IWD

The fastest and easiest way to use iwd is to open a console and enter this command *(Provided you use the NetworkManager.service)*:

~~~sh
~$ nmtui
~~~

This should be self-explanatory!

### WiFi connection with nmcli

**Setting up a WiFi connection with *nmcli**.

I describe here only briefly the fastest way to set up a network with the help of the NetworkManager in the command line.

To establish a connection, provided you have all the information, this one-liner is enough. All other information about *nmcli* can be found on the following page, [Network Manager in Terminal](0501-inet-nm-cli_en.md#network-manager-command-line-tool)

~~~sh
~$ nmcli dev WiFi con "ssid" password name "name"
~~~

(*ssid* denotes the name of the network).

For example:

~~~
nmcli dev WiFi con "HomeOffice" password W1rkl1chS3hrG3h31m name "HomeOffice"
~~~

### WiFi connection with iwctl

**Set up a WiFi connection with *iwctl*, without the NetworkManager**.

The first thing to do is to call the help for *iwctl* to see what all is possible.

For this we enter the command *`iwctl`* in the terminal, then at the input prompt *help*.

 ![iwctl help](./images/iwd/iwctl-help.png)

To find out which WiFi interface we are using we enter the following command.

~~~sh
[iwd]# device list
                     Devices *
-------------------------------------------------------------
  Name Address Powered Adapter Mode
-------------------------------------------------------------
  wlan0 00:01:02:03:04:05 on phy0 station
~~~

In this case it is *wlan0* and it is running (*powered on*) in *station* mode.

Now we scan for an active network

~~~sh
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
~~~

Now we can connect to our network.

~~~sh
[iwd]# station wlan0 connect SSID
~~~

(*SSID* means the name of the network)

We are asked for the password and we should be connected to our network, we can check this with *"station list "* or *"station wlan0 get-networks "*.

~~~sh
[iwd]# station list
               Devices in Station Mode
---------------------------------------------
  Name State Scanning
---------------------------------------------
  wlan0 connected
~~~

The whole thing can be abbreviated with the following command, so you have all the necessary information!

~~~sh
iwctl --passphrase passphrase station device connect SSID
~~~

For example:

~~~sh
~$ iwctl --passphrase W1rkl1chS3hrG3h31m station wlan0 connect HomeOffice

~~~

### Graphical configuration programs

+ NetworkManager, there are various graphical interfaces for the NetworkManager e.g. for plasma-desktop/kde plasma-nm or for gnome network-manager-gnome and others. Their use should be self-explanatory!
+ conman is a network manager developed by Intel, small and resource saving, more about it in the [Arch-Wiki](https://wiki.archlinux.org/index.php/ConnMan)
+ iwgtk, is not in debian-sources, it has to be built from source and can be found on [github](https://github.com/J-Lentz/iwgtk).

### Back to wpa_supplicant

*(Vorausgstezt NetworkManager and wpa_supplicant are installed)*.

+ Stop the **iwd.service** and mask it.
+ Stop the **NetworkManager.service**.
+ Rename the **/etc/NetworkManger/conf.d/nm.conf** file.
+ Unmask and start the **wpa_supplicant.service**.
+ Restart the **NetworkManager.service**.

~~~sh
~# systemctl stop iwd.service
~# systemctl mask iwd.service
~# systemctl stop NetworkManager.service
~# mv /etc/NetworkManager/conf.d/nm.conf /etc/NetworkManager/conf.d/nm.conf~
~# systemctl unmask wpa_supplicant.service
~# systemctl enable --now wpa_supplicant.service
~# systemctl start NetworkManager.service
~~~

Now *wpa_supplicant* is used to connect to the WiFi hardware.

<div id="rev">Last edited: 2021-14-08</div>
