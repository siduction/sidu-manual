% WLAN configuration

## Configuration of networks

The `NetworkManager` integrated in all graphical user interfaces of siduction offers a quick configuration of network cards (WLAN and Ethernet). In the terminal, the script `nmcli` provides access to the functionality of the NetworkManager.  

Wireless networks are scanned. You can connect to the networks found and make settings for the encryption method, the IPv4 or IPv6 Internet protocol and a proxy server. The backend is `iwd`. The Ethernet configuration takes place automatically when using a DHCP server on the router (dynamic assignment of an IP address), but there is also the option of a manual setup (from netmasks to name servers).  

On the live medium and after installation, the NetworkManager with its backend iwd is already configured and ready for use.

### NetworkManager

In the graphical user interface, the NetworkManager is located in the taskbar. It is largely self-explanatory.

With **`nmcli`** or **`nmtui`** a powerful command line client is available for the daily use of the NetworkManager. *nmtui* offers a user-friendly ncurses interface within the terminal. Here too, the function is largely self-explanatory. If the script is not available, install it with :

~~~
apt install network-manager
~~~

The start command in the console is **`nmcli`**.  
More information at [network - nmcli](0501-inet-nm-cli_en.md#network-manager-command-line-tool).

If you have all the necessary information to hand, a single command line is sufficient.  
Example:  
Device Name = wlan0  
Device Type = wifi  
SSID = HOME_WLAN  
Passwodt = s3Hrg3he!m

Command to set up the WLAN connection:

~~~
nmcli device wifi connect "HOME_WLAN" password "s3Hrg3he!m"
~~~

Disconnect with:

~~~
nmcli device down wlan0
~~~

NetworkManager saves the connection data entered once. If you are within range of this router again, NetworkManager automatically re-establishes the connection. To change the behavior, please read the man pages  
**`man NetworkManager`**  
and  
**`man nm-settings`**

<div id="rev">Last edited: 2023/11/15</div>
