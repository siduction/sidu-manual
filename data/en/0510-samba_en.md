% SAMBA

## SAMBA

### Client configuration

**How to access a Windows network share using siduction**

+ All commands are executed in a terminal or console as **root**.

+ The URL is called in Dolphin as **normal user** .  
    *"server"* = server name or IP of the Windows machine  
    *"share"* = name of the share
    
    In the KDE file manager Dolphin, the URL is entered as follows: `smb://server` or with the full path: `smb://server/share`. 

In a console, the shares on a server can be displayed with:

~~~
smbclient -L <server>
~~~

To see a share in a directory (with access for ALL users), a mount point must exist. 
If not, a directory must be created as a mount point (the name is arbitrary):

~~~
mkdir -p /media/server_share
~~~

A share is mounted with this command:

~~~
mount -t cifs -o username=administrator,uid=$UID,gid=$GID //server/share /mnt/server_share
~~~

If you get an error message here, it may be due to the SMB protocol version you are using.
In Debian, SMB 1.0 is no longer used for security reasons. Unfortunately, there are still systems which 
provide only SMB 1.0. To get access to such a share, the mount option `vers=1.0` is needed. The complete command is:

~~~
mount -t cifs -o username=Administrator,vers=1.0,uid=$UID,gid=$GID //server/share /mnt/server_share
~~~

A connection is terminated with this command:

~~~
umount /media/server_share
~~~

To mount a Samba share automatically, the `/etc/fstab` file can be amended according to this pattern:

~~~
//server/share /mnt/server_share cifs noauto,x-systemd.automount,x-systemd.idle-timeout=300,\
user=username,password=**********,uid=$UID,gid=$GID 0 0
~~~

However, it is not recommended to write the password in plain text to fstab.
A better alternative is to create `.smbcredentials` with the following content:

~~~
username=<user>
password=<password>
~~~

The resulting entry for `/etc/fstab` is:

~~~
//server/share /mnt/server_share cifs noauto,x-systemd.automount,x-systemd.idle-timeout=300,\
credentials=</path/to/.smbcredentials>,uid=$UID,gig=$GID 0 0
~~~

*"$UID"* and *"$GID"* are the corresponding uid and gid of the user whom the share should be given to.
But you can also write *"uid=username gid=users"*.

### siduction as samba server

Of course, siduction can also provide an SMB server. Describing the setup as a Samba server here in the manual 
would go beyond its scope. The internet provides many HowTo's on this topic.

Our recommendations:

[debian - a minimal Samba setup](https://wiki.debian.org/Samba/ServerSimple)  
[Raspberry Pi - samba server](https://pimylifeup.com/raspberry-pi-samba/)  
[ubuntu - install and configure samba](https://ubuntu.com/tutorials/install-and-configure-samba#1-overview)  
[redhat - using samba as a server](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/deploying_different_types_of_servers/assembly_using-samba-as-a-server_deploying-different-types-of-servers)

There are many more sites on this topic on the web.

<div id="rev">Last edited: 2022/04/03</div>
