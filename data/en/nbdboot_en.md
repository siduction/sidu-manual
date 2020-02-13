<div id="main-page"></div>
<div class="divider" id="nbd1"></div>
## Booting siduction over a network (network block device - nbd)

**`Warning: dnsmasq includes a dhcp server which can conflict with an existing dhcp server on your network (your router may provide one).`**  `The safest option is to only use one dhcp server on any network. This means you should disable any other dhcp servers on the same network. The dnsmasq proxy options outlined below should be able to co-exist with another dhcp server on the same network, however please do not try this unless you administer the network and are ready to deal with any unforeseen consequences which might crop up.` 

#### The basics

Network booting first requires that you have a machine capable of network booting, which can be connected via a network you run, to a machine which you can setup to offer the network booting services. 

You do not want to do this on your workplace network, or any other network you do not control, unless you run that network or get permission and guidance from those who do. If you are co-operating in a larger network you can investigate all the options to dnsmasq, such as limiting the interfaces it listens on or the clients it will respond to, to restrict the impact of your setup on the network.

#### The prerequisites

A 2011.1 (or newer) siduction iso booted up to use as the network boot server. The instructions should be basically the same with any up to date siduction or debian sid machine and should provide all the clues you need to use on other systems. Linux is required to serve nbd devices.

dnsmasq will be used to provide everything for the initial booting phases, again it shouldn't be hard to translate the required knowledge to other software.

###### Installation

~~~  
apt-get install nbd-server dnsmasq  
~~~

### Setting up the nbd-server

 Presuming the iso can be found at `/dev/scd0` , (which it probably can be if you booted from cd, otherwise substitute in any suitable file or device), then you can setup a nbd-server conf file called `nbd-siduction.conf`  with a section called siduction-iso to export the cd by running the following:

~~~  
echo '[generic]' > nbd-siduction.conf  
nbd-server 0.0.0.0:10809 /dev/scd0 -o siduction-iso >> nbd-siduction.conf  
~~~

The generic header is always required. If you want to setup the nbd-server to work automatically on a real system you will probably want to setup /etc/nbd-server.conf instead. There are a lot more options to nbd-server than shown here, see `man nbd-server.` 

To actually start the server now, as a normal user and without bothering setting up or copying the file to `/etc/nbd-server.conf` , you can just run:

~~~  
nbd-server -C nbd-siduction.conf  
~~~

The target of the nbd-server does not have to be an iso or a cd/dvd/usb stick, it just has to contain a suitable filesystem image.

#### dnsmasq

The following example assumes you are running on a simple network where your machine has one ethernet connection which is setup by dhcp from another machine and which the network boot clients can use to setup their interfaces by dhcp.

The main relevant options for dnsmasq to network boot siduction are to setup a path for the tftp server files and a file for it to boot from there. 

Create a `tftp`  directory for booting in `/home`  (you can create it where you want if you prefer another place). Thus the path becomes `/home/tftp` .

Next create a file called `pxe-siduction.conf`  and paste in the following:

~~~  
dhcp-range=0.0.0.0,proxy  
pxe-service=x86PC, &quot;boot linux&quot;, pxelinux  
enable-tftp  
tftp-root=/home/tftp  
tftp-secure  
~~~

When using the dhcp proxy you need to provide a pxe menu with pxelinux as the only entry which will therefore start it automatically. This is what the lone pxe-service item is above.

As root, move the newly created `pxe-siduction.conf`  file to `/etc/dnsmasq.d/` :

~~~  
suxterm  
mv pxe-siduction.conf /etc/dnsmasq.d/  
~~~

Note: For a network (e.g. 192.168.0.*) with no other dhcp server you could swap the first two lines for:

~~~  
dhcp-range=192.168.0.100,192.168.0.199,1h  
dhcp-boot=pxelinux.0  
~~~

To give out ip addresses starting with 192.168.0.100 and ending with 192.168.0.199 with a lease time of an hour, and to provide the filename to just run pxelinux.0 as part of the dhcp request (when using the proxy you instead provide a pxe menu with only pxelinux as an entry which will therefore automatically start it). This probably won’t setup your network as you wish though unless your dnsmasq server should also be your dns server and gateway for the boot clients.

To enable the new file you will need to uncomment the `conf-dir=/etc/dnsmasq.d`  setting at the bottom of `/etc/dnsmasq.conf`  and then restart dnsmasq.

dnsmasq has a lot of options and can act as a dns server as well as a dhcp, pxe and tftp server. The above is simply a minimal outline of the pieces needed to use pxelinux.

#### tftp

tftp is the network equivalent of the boot directory. Using the continuing example of the `/home/tftp`  directory you need to populate it. If the cdrom is mounted on `/fll/scd0` :

~~~  
cp /fll/scd0/boot/isolinux/* /home/tftp  
mkdir /home/tftp/pxelinux.cfg  
mv /home/tftp/isolinux.cfg /home/tftp/pxelinux.cfg/default  
mkdir /home/tftp/boot  
cp /fll/scd0/boot/vmlin /fll/scd0/boot/initr /fll/scd0/boot/memtest /home/tftp/boot/  
cp /usr/lib/syslinux/pxelinux.0 /home/tftp/  
# required for the tftp-secure option to dnsmasq  
chown -R dnsmasq.dnsmasq /home/tftp/*  
~~~

Now you can edit boot options to your satisfaction in `/home/tftp`  on both the `pxelinux.cfg/default`  and the `gfxboot.cfg`  file. 

In particular it is suggested that under the `[install]`  section you set the `install=` to `install=nbd` , `install.nbd.server`  to the server's IP on the network and `install.nbd.port`  to the name of the nbd export section, for example. siduction-iso (as nbd exports are named now rather then simply using port numbers).

Alternatively you could disable the F3 menu completely and edit the kernel command lines to use something like:

~~~  
fromhd=/dev/nbd0 root=/dev/nbd0 nbdroot=192.168.1.23,siduction-iso nonetwork  
~~~

###### toram boot code

If you add toram to the boot options, machines with enough ram will release the server as soon as they copy the file and machines without sufficient ram will carry on and boot normally. At least 1 gig of ram, (ideally 2 gig or more), is required for toram.

#### Network booting

Ensure that the client PC's BIOS is set to use `Boot from Network` . 

As long as your bios supports booting from the network, the machine is connected to a network with your server and the siduction kernel and initrd.img support your network card, you should be able to boot siduction from the network. 

Some network cards may require non-free firmware which will require rebuilding the initrd image to include the firmware.

<div id="rev">Page last revised 13/01/2012 1800 UTC</div>
