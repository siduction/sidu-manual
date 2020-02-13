<div id="main-page"></div>
<div class="divider" id="configure"></div>
## Configuring siduction to use SAMBA (Windows) Shares from Remote Machines

Do all commands as  **root**  (in a Terminal or Konsole) Put the URL in Dolphin (run Dolphin as normal user).

`server = servername or IP of the Windows Machine  
`share = name of the share` `

In KDE - Dolphin put in the URL `smb://server`  or the complete URL `smb://server/share` 

In a konsole you can see the shares located on a server by:

~~~  
smbclient -L server  
~~~

To mount a share in a directory -(with full access for ALL Users) remember this: Mountpoint must exist. If it does not, you must first create directory like this (Name is arbitrary):

~~~  
mkdir -p /mnt/server_share  
~~~

Then mount the share - remote filesystem VFAT:

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777 //server/share /mnt/server_share  
~~~

or remote filesystem NTFS:

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777,lfs //server/share /mnt/server_share  
~~~

To terminate the connection, use:

~~~  
umount /mnt/server_share  
~~~

If you want to put an entry in  */etc/fstab*  to make the mount easier then insert the following line in that file:

~~~  
//server/share /mnt/server_share cifs defaults,username=your_username,password=**********,file_mode=0777,dir_mode=0777 0 0  
~~~

<div class="divider" id="setup"></div>
## How to set up siduction as Samba-Server

As samba is not pre-installed you will need to do the following to have samba access:

~~~  
suxterm  
apt-get update  
apt-get install samba samba-tools smbclient smbfs samba-common-bin  
~~~

#### HD installations:

##### Example 1:

On a HD-Install it is neccessary to adjust the Samba Configuration. Here is a simple example. If you want to know more about the usage of Samba and the setup of a Linux Samba Server  [advisable to read the Samba Documentation.](http://us5.samba.org/samba/) .

To adjust the samba-configuration you do as follows:

Open the file `/etc/samba/smb.conf`  in an editor (e.g. kedit or kwrite) and enter this:

~~~  
# Global Changes - Proposal everything simple as  
#possible - no passwords, perform like Windows 9x  
[global]  
security = share  
workgroup = WORKGROUP  
# Share without write-permission -important if NTFS Filesystems are to be shared!  
[WINDOWS]  
comment = Windows Partition  
browseable = yes  
writable = no  
path = /media/sda1 # <-- adjust to your partition  
public = yes  
# Sharing a partition with permission to write- the partition has to be mounted  
# writable - makes sense with e.g. FAT32.  
[DATA]  
comment = Data Partition (first extended Partition)  
browseable = yes  
writable = yes  
path = /media/sda5  
public = yes  
~~~

Restart the samba server

~~~  
/etc/init.d/samba restart  
~~~

#### Example 2:

~~~  
groupadd smbuser  
useradd -g smbuser <the-user-you-want>  
smbpasswd -a <the-user-you-want>  
smbpasswd -e <the-user-you-want>  
~~~

Next edit `/etc/samba/smb.conf`  to give it share permissions, (be careful with what folders you enable), for example:

~~~  
[homes]  
comment = Home Directories  
browseable = yes.  
writeable = yes  
[media, be careful!]  
path = /media  
browseable = yes  
read only = no  
#read only = yes  
guest ok = no  
writeable = yes  
[video]  
path = /var/lib/video  
browseable = yes  
#read only = no  
read only = yes  
guest ok = no  
#any other folder you want to share with windows/linux/mac  
#path = path = /media/xxxx/xxxx  
#browseable = yes  
#read only = no  
#read only = yes  
#guest ok = no  
~~~

Restart the samba server

~~~  
/etc/init.d/samba restart  
~~~

## Checking the shares in samba

To set the shares without regard to security in samba do the folowing commands (i.e. for a LAN setup):

Set folder and its content at least -rwxr-xr-x:

~~~  
ls -la pathTo/dirShareName/*  
~~~

If not, do:

~~~  
chmod -R 755 pathTo/dirShareName  
~~~

If you want it to be writable:

~~~  
chmod -R 777 dirShareName  
~~~

A way to make sure your share is working: ( do not forget to start the server):

~~~  
smbclient -L localhost  
~~~

You should see something like:

~~~  
smbclient -L localhost  
Password:  
Domain=[HOME] OS=[Unix] Server=[Samba 3.0.26a]  
Sharename Type Comment  
--------- ---- -------  
IPC$ IPC IPC Service (3.0.26a)  
MaShare Disk comment  
print$ Disk Printer Drivers  
Domain=[MSHOME] OS=[Unix] Server=[Samba 3.0.26a]  
~~~

If you did not set a password, just press ENTER

Do not forget to save. You can now start/stop samba with:

~~~  
/etc/init.d/samba start  
~~~

and:

~~~  
/etc/init.d/samba stop  
~~~

You can also start/stop samba automaticaly at boot-time. Issue this call:

~~~  
update-rc.d samba defaults  
~~~

Now samba starts when you boot and stops when you shutdown.

 [More samba information here](http://wiki.linuxquestions.org/wiki/Samba) .

<div id="rev">Page last revised 15/01/2012 1000 UTC</div>
