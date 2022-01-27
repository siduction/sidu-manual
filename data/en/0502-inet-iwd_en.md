% Network - IWD

## IWD

Intel's [iNet wireless daemon](https://iwd.wiki.kernel.org/) (iwd) sends *wpa-supplicant* into well-deserved retirement. Only a tenth the size and much faster, *iwd* is the successor. It works alone or together with *NetworkManager*, *systemd-networkd*, and *conman*.  
Two things *iwd* still can't do are to connect via WPA/WPA2 Enterprise and to properly handle hidden networks. For such working environments, you should stay with *wpa-supplicant* or, if you use siduction from 2021.3.0, [switch back to wpa-supplicant](0502-inet-iwd_en.md#back-to-wpa_supplicant).

Further information can be found on the [Arch Linux wiki](https://wiki.archlinux.org/index.php/Iwd) or the [debian wiki](https://wiki.debian.org/NetworkManager/iwd). 

**Since siduction 2021.3.0**, *iwd* is used as the standard for establishing connections to WLAN.  Our implementation runs with *NetworkManager*.

**Since siduction 2021.1.0**, *iwd* has already been delivered in the flavours Xorg and NoX. If you want, you can install *iwd* on the other flavours. See below: [IWD instead of wpa_supplicant](0502-inet-iwd_en.md#iwd-instead-of-wpa_supplicant).

**Before siduction 2021.1.0**: Even with a slightly older snapshot, *iwd* can be installed (tested with siduction 2018.3.0 and linux-image-5.15.12-1-siduction-amd64). Please also follow the instructions at [IWD instead of wpa_supplicant](0502-inet-iwd_en.md#iwd-instead-of-wpa_supplicant).

### Graphical configuration programs

+ **NetworkManager**: For the *NetworkManager*, there are different graphical interfaces, e.g. *plasma-nm* for plasma-desktop/kde or *network-manager-gnome* for gnome and others. Their usage should be self-explanatory!
+ **conman** is a small and resource saving network manager developed by Intel. Read more about it on the [Arch-Wiki](https://wiki.archlinux.org/index.php/ConnMan)
+ **iwgtk** is not available in debian sources. It has to be built from source code and can be found on [github](https://github.com/J-Lentz/iwgtk).

### Configuration in terminal

**iwd and NetworkManager**

1. The fastest and easiest way to use *iwd* with *NetworkManager* is to open a terminal and type this command:

   ~~~txt
   ~$ nmtui
   ~~~

   This will start a text based graphical interface of the *NetworkManager* in the terminal. The program should be self-explanatory!

2. Use the *NetworkManager's* command line tool *nmcli*. Detailed information about this can be found on our manual page [NetworkManager in the terminal](0501-inet-nm-cli_en.md#network-manager-command-line-tool).

   The following is a brief description of the fastest way to set up a network with the help of *NetworkManager* on the command line. Provided you have all the information, this one-liner is enough:

   ~~~txt
   ~$ nmcli dev wifi con "ssid" password password name "name"
   ~~~

   (*ssid* denotes the name of the network.)

   For example:

   ~~~txt
   nmcli dev wifi con "HomeOffice" password R3allY+v3ry+s3creT name "HomeOffice"
   ~~~

**iwd standalone (without NetworkManager)**

Intel's *iwd* comes with its own command line tool called *iwctl*. Please only use *iwctl* if *NetworkManager* and *wpa_supplicant* are not installed or both are masked in *systemd*. 

First we should call the help of *iwctl* to see what is possible. For this, we enter the command *`iwctl`* into the terminal and then *`help`* into the input prompt.

![iwctl help](./images/iwd/iwctl-help.png)

To find out which WiFi interface we are using, we enter the following command:

~~~txt
[iwd]# device list
                     Devices                                *
-------------------------------------------------------------
  Name    Address             Powered   Adapter   Mode
-------------------------------------------------------------
  wlan0   00:01:02:03:04:05   on        phy0      station
~~~

In this case, it is *wlan0* and it is running (*powered on*) in *station* mode.

Now we scan for an active network:

~~~txt
[iwd]# station wlan0 scan
[iwd]# station wlan0 get-networks
~~~

After that, we can connect to our network:

~~~txt
[iwd]# station wlan0 connect SSID
~~~

(*SSID* means the name of the network.)

We are asked for the password and we should then be connected to our network. We can check this with *`station list`* or *`station wlan0 get-networks `*.

~~~txt
[iwd]# station list
            Devices in Station Mode
---------------------------------------------
  Name         State          Scanning
---------------------------------------------
  wlan0        connected
~~~

The whole process can be abbreviated by the following command if you have all the necessary information!

~~~txt
iwctl --passphrase passphrase station device connect SSID
~~~

For example:

~~~txt
~$ iwctl --passphrase W1rkl1chS3hrG3h31m station wlan0 connect HomeOffice
~~~

## IWD instead of wpa_supplicant

For those who want to use *iwd* as a replacement for *wpa_supplicant* with a slightly older snapshot than siduction 2021.3.0, please follow the instructions below.

### Install IWD

> Note:  
> It is possible that non-free firmware must be installed from a USB stick or via LAN!
> Under Debian, it is unfortunately not possible to install the *NetworkManager* (standalone) without *wpa_supplicant*.
 
If you want to do this, there are two options. The second one is more sensible and easier.

1. Install *NetworkManager* from the sources.
2. Do not start or mask the *wpa_supplicant.service*.
   Since siduction uses *systemd*, we will not go into how *iwd* is configured without *systemd*!

If you want to use iwd without *NetworkManager*, you don't have to worry about that, but you have to remove *NetworkManager* and *wpa_supplicant* from the disk together with their configuration: 

~~~txt
~# apt purge network-manager wpasupplicant
~~~

**Procedure with NetworkManager installed**  
**and iwd < 1.21-2**

+ First **iwd** is installed, 
+ then the **NetworkManager.service** is stopped,
+ then the **wpa_supplicant.service** is stopped and masked.
+ Now we create the file `/etc/NetworkManager/conf.d/nm.conf` and enter **iwd** there, 
+ then we create the file `/etc/iwd/main.conf` and fill it with appropriate content, 
+ activate and start the **iwd.service**, 
+ and start the **NetworkManager.service**.

Now just run the following commands as **root** in the terminal to use iwd:

~~~txt
~# apt update
~# apt install iwd
~# systemctl stop NetworkManager.service
~# systemctl disable --now wpa_supplicant.service
~# echo -e '[device]\nwiFi.backend=iwd' > /etc/NetworkManager/conf.d/nm.conf
~# touch /etc/iwd/main.conf
~# echo -e '[General]\nEnableNetworkConfiguration=true \n\n[Network]\nNameResolvingService=systemd' > /etc/iwd/main.conf
~# systemctl enable -now iwd.service
~# systemctl start NetworkManager.service
~~~

**See if it worked**  
We display the two configuration files.

+ /etc/NetworkManager/conf.d/nm.conf

~~~txt
~$ cat /etc/NetworkManager/conf.d/nm.conf
[device]
wiFi.backend=iwd
~~~

+ /etc/iwd/main.conf

~~~txt
~$ cat /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
~~~

**Procedure with NetworkManager installed**  
**and iwd >= 1.21-2**

From version 1.21-2 on, *iwd* brings its own configuration file `/etc/iwd/main.conf`. The procedure is similar to the one just mentioned with the exception that we do not create the configuration file anymore, but remove the comment sign in front of "EnableNetworkConfiguration=true" in it.

Please execute the following commands as **root** in the terminal:

~~~txt
~# apt update
~# apt install iwd
~# systemctl stop NetworkManager.service
~# systemctl disable --now wpa_supplicant.service
~# echo -e '[device]\nwiFi.backend=iwd' > /etc/NetworkManager/conf.d/nm.conf
~# sed -i 's/#EnableNetworkConfiguration=true/EnableNetworkConfiguration=true/' /etc/iwd/main.conf
~# systemctl enable -now iwd.service
~# systemctl start NetworkManager.service
~~~

**See if it worked**  
We display the two configuration files.

+ /etc/NetworkManager/conf.d/nm.conf

~~~txt
~$ cat /etc/NetworkManager/conf.d/nm.conf
[device]
wiFi.backend=iwd
~~~

+ /etc/iwd/main.conf

~~~txt
~$ cat /etc/iwd/main.conf

[...]
[General]
# iwd is capable of performing network configuration on its own, including
# DHCPv4 based address configuration.  By default this behavior is
# disabled, and an external service such as NetworkManager, systemd-network
# or dhcpclient is required.  Uncomment the following line if you want iwd
# to manage network interface configuration.
#
EnableNetworkConfiguration=true
#
[...]
~~~

With the commands described above, you are now able to display WiFi hardware in the terminal  [**nmtui**, **nmcli** or **iwctl**](0502-inet-iwd_en.md#configuration-in-terminal), configure it, and connect to a network.  
Or you can use the NetworkManager in the graphical user interface. See: [graphical-configuration-programs](0502-inet-iwd_en.md#graphical-configuration-programs)

### Back to wpa_supplicant

*(Provided NetworkManager and wpa_supplicant are installed.)*

+ Stop the **NetworkManager.service**.
+ Stop the **iwd.service** and mask it.
+ Rename the **/etc/NetworkManger/conf.d/nm.conf** file.
+ Unmask and start the **wpa_supplicant.service**.
+ Restart the **NetworkManager.service**.

~~~txt
~# systemctl stop NetworkManager.service
~# systemctl disable --now iwd.service
~# mv /etc/NetworkManager/conf.d/nm.conf /etc/NetworkManager/conf.d/nm.conf~
~# systemctl unmask wpa_supplicant.service
~# systemctl enable --now wpa_supplicant.service
~# systemctl start NetworkManager.service
~~~

Now *wpa_supplicant* is used to connect to the WiFi hardware.

<div id="rev">Last edited: 2022/01/27</div>
