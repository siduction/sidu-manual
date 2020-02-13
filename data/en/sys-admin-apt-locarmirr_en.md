<div id="main-page"></div>
<div class="divider" id="approx"></div>
## dist-upgrade of PCs where bandwidth/speed is a problem

For users that have more than 1 PC, or those who have more than 1 PC and face bandwidth restrictions, or those who need to get a PC up to date when there are ISP speed restrictions and/or mixed with bandwidth restrictions, there are solutions to help keep all the PCs maintained to an 'up to date' state, whether its on a permanent or temporary LAN.

The solution is to use a local archive mirror on one of the PCs in which other PCs on the LAN can use to dist-upgrade with thus conserving bandwidth usage for really important day to day activities.

### Prerequisites

Ensure that you have 6 gig of freespace available for the cache.

## Using approx as a local archive mirror

When the client PC asks for files it will provide cached ones, provided you have run `apt-get update` , `dist-upgrade -d`  or `dist-upgrade`  on the PC that is hosting an `approx server` .

#### Step 1: Configuring the Server for Clients to use approx

~~~  
apt-get install approx  
~~~

~~~  
mcedit /etc/approx/approx.conf  
~~~

Enable the `approx.conf`  file to use the online mirrors:

~~~  
# Here are some examples of remote repository mappings.  
# See http://www.debian.org/mirror/list for mirror sites.  
debian http://ftp.iinet.net.au/debian/ `<< change to your local debian mirror   
siduction http://siduction.net/debian/  
~~~

`Apply the same style of syntax to other repositories that you want locally mirror.` 

Start the approx server with:

~~~  
update-inetd --enable approx  
~~~

If it fails to work, reboot the PC that you have installed approx on to act as a server as approx is known to be stubborn to start.

After the reboot run `apt-get update`  and `dist-upgrade`  or `dist-upgrade -d` . This will ensure that approx can access the latest packages for your client PCs unless there are some packages installed on the client PCs that are not on the host server. Should this be the case approx will go and get the appropriate packages.

The packages accumulate in `/var/cache/approx`  which is populated after the first run of the clients.

#### Step 2: Configuring the Clients to use the approx Server

First: alter `/etc/apt/sources.list.d/*.list`  files to use approx as your debian and siduction mirrors.

<!--###### This para is most likely complete and utter rubbish, but put here as a reminder maybe better adding an approx.list and renaming the debian and siduction .lists 

<p></p>-->
With mcedit, comment out your current direct link URLs (place a `#`  in front of them) and add the following lines and save the changes, for example:

###### Debian sources list

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

~~~  
#deb your current debian mirror  
deb http://approx:9999/debian/ sid main contrib non-free  
~~~

###### siduction sources list

~~~  
mcedit /etc/apt/sources.list.d/siduction.list  
~~~

~~~  
#deb your current siduction mirror  
deb http://approx:9999/siduction/ sid main fixes  
~~~

###### Other sources lists

Apply the same style of syntax reflecting other sources.list files as required.

###### Proxy Hosts

Next edit `/etc/hosts`  to add the local proxy to access the IP address of your server:

~~~  
mcedit /etc/hosts  
~~~

~~~  
10.1.1.X approx  
~~~

Now run `apt-get update`  and `dist-upgrade`  or `dist-upgrade -d` . The first run on each of your client PCs will be slow and may even time out, so try it again. Subsequent runs should provide you with the long term gains you are looking for.

<div id="rev">Content last revised 15/01/2012 1300 UTC</div>
