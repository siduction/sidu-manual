<div id="main-page"></div>
<div class="divider" id="ssh"></div>
## SSH

In computing, Secure Shell or SSH is a set of standards and an associated network protocol that allows establishing a secure channel between a local and a remote computer. It uses public-key cryptography to authenticate the remote computer and (optionally) to allow the remote computer to authenticate the user. SSH provides confidentiality and integrity of data exchanged between the two computers using encryption and message authentication codes (MACs). SSH is typically used to log into a remote machine and execute commands, but it also supports tunneling, forwarding arbitrary TCP ports and X11 connections; it can transfer files using the associated SFTP or SCP protocols. An SSH server, by default, listens on the standard TCP port 22.  [Referenced from wikipedia](http://en.wikipedia.org/wiki/Secure_Shell) 

<div class="divider" id="ssh-s"></div>
## Enabling good security protocols for SSH

Allowing root login, via ssh, is not secure. we do not want root users logging in at all by default, debian should be secure, not insecure nor do we want to give users 10 minutes to do a quick dictionary password attack on our ssh login therefore, its up to you to limit the time and attempts!

To help make your ssh more secure, simply take your favorite text editor, and open it with root privileges, then open this file:

~~~  
/etc/ssh/sshd_config  
~~~

Then we locate the offending items, and change them.

###### The offending items you need to locate are the following:

`Port <desired port>:`  This must be set to the correct port that you are forwarding from your router. Port forwarding must also be setup in your router. If you don't know how to do that, maybe you shouldn't be using ssh remotely. Debian sets the default to port 22, however its recommended that you use a port out of the standard scan range. let's say we use port 5874 so that becomes:

~~~  
Port 5874  
~~~

`ListenAddress <ip of machine or network interface>:`  Now, of course, since you are forwarding a port from your router, you need the machine to have a static ip address on the network, unless you are using a dns server locally, but if you're doing something that complicated and need these directions you are probably making a huge mistake So let's say it's this: 

~~~  
ListenAddress 192.168.2.134  
~~~

Next, Protocol 2 is already a debian default, but check to make sure:

`LoginGraceTime <seconds to allow for login>:`  This has an absurd default of 600 seconds. It does not take you 10 minutes to type in your user name and password, so lets make that sane:

~~~  
LoginGraceTime 45  
~~~

Now you have 45 seconds to login and hackers do not have 600 seconds each attempt to crack your password

`PermitRootLogin <yes>:`  Why debian makes PermitRootLogin 'yes', is incomprehensible so we fix that to 'no'

~~~  
PermitRootLogin no  
~~~

~~~  
StrictModes yes  
~~~

`MaxAuthTries <xxx>:`  Number of attempts to login, you can make it 3 or 4 attempts but no more than that

~~~  
MaxAuthTries 2  
~~~

You may need to add any of these items if they are not present:

~~~  
AllowUsers <user names with spaces allowed to access via ssh>  
~~~

`AllowUsers <xxx>:`  make an ssh only user with no rights use adduser to add the user, then put their name here, like:

~~~  
AllowUsers whomevertheuseris  
~~~

`PermitEmptyPasswords <xxx>:`  give that user a nice long password that is impossible to guess ever in a million years that is the only user allowed to ssh in. Once you are in, you can just su to root:

~~~  
PermitEmptyPasswords no  
~~~

`PasswordAuthentication <xxx>:`  obviously, for password login, not key login, you need passwords to be full unless using keys, you need this to be yes

~~~  
PasswordAuthentication yes [unless using keys]  
~~~

Finally:

~~~  
/etc/init.d/ssh restart  
~~~

Now you have somewhat more secure ssh not fully secure, just better, including creating an ssh only user with adduser

`Note:`  If you get an error message and ssh refuses to connect you, go to your $HOME and look for a hidden folder called `.ssh`  and delete the file called`known_hosts`  and try again. This error mainly occurs when you have dynamically set IP addresses (DCHP)

<div class="divider" id="ssh-x"></div>
## Using X Window Applications Via Network Through SSH

ssh -X allows you to log into a remote computer and have its graphical user interface X displayed on your local machine. As $user (and note the X is to be a capital):

~~~  
$ ssh -X username@xxx.xxx.xxx.xxx (or IP)  
~~~

Enter the password for the username on the remote computer and run the X-application in the shell:

~~~  
$ iceweasel OR oocalc OR oowriter OR kspread  
~~~

Some really slow network connections from your PC may benefit from having a level of compression to help speed transfers, therefore add an extra option, on fast networks it has the opposite effect:

~~~  
$ ssh -C -X username@xxx.xxx.xxx.xxx (or IP)  
~~~

Read:

~~~  
$man ssh  
~~~

`Note:`  If you get an error message and ssh refuses to connect you, go to your $HOME and look for a hidden folder called `.ssh`  and delete the file called`known_hosts`  and try again. This error mainly occurs when you have dynamically set IP addresses (DCHP)

<div class="divider" id="ssh-scp"></div>
## Copying files and directories remotely via ssh with scp

scp uses the command line, (terminal/cli), to copy files between hosts on a network. It uses ssh authentication and security for data transfer, therefore, scp will ask for passwords or passphrases as required for authentication.

Assuming you have ssh rights to a remote PC or a server, scp allows you to copy partitions, directories or file, to and from that PC, to a specified location or destination of your choosing where you also have permissions. For example, this could include a PC or server you have the permission to access on your LAN, (or anywhere else in the world), to enable a transfer of data to a USB hard Drive connected to your PC.

You can recursively copy entire partitions and directories with the `scp -r`  option. Note that scp -r follows symbolic links encountered in the tree traversal.

### Examples:

`Example 1:`  Copy a partition:

~~~  
scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/ /media/diskXpartX/  
~~~

`Example 2:`  Copy a directory on a partition, in this case a directory called photos in $HOME:

~~~  
scp -r <user>@xxx.xxx.x.xxx:~/photos/ /media/diskXpartX/xx  
~~~

`Example 3:`  Copy a file from a directory on a partition, in this case a file in $HOME:

~~~  
scp <user>@xxx.xxx.x.xxx:~/filename.txt /media/diskXpartX/xx  
~~~

`Example 4:`  Copy a file on a partition:

~~~  
scp <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt /media/diskXpartX/xx  
~~~

`Example 5:`  If you are already in the drive/directory that you wish to copy any directory or files to, use a '**` **.** `** ' (dot) :

~~~  
scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt.** `**   
~~~

`Example 6:`  To copy files from your PC/server to a another, (use `scp -r`  if copying a partition or a directory):

~~~  
scp /media/disk1part6/filename.txt <user>@xxx.xxx.x.xxx:/media/diskXpartX/xx  
~~~

Read:

~~~  
man scp  
~~~

<div class="divider" id="ssh-w"></div>
## Remote access ssh with X-Forwarding from a Windows-PC:

* Download and burn the  [Cygwin XLiveCD](http://xlivecd.indiana.edu/)   
* Put the CD into the CD-ROM tray of the Windows-PC and wait for the autorun.  
Click "continue" until a shell window pops up and enter:

~~~  
ssh -X username@xxx.xxx.xxx.xxx  
~~~

Note: xxx.xxx.xxx.xxx is the IP of the linux remote computer or its URL (for example a dyndns.org account) and the username is of course one user account that exists on the remote machine. After successfull login, start "kmail" for example and check your mails!

Important: make sure hosts.allow has an entry to allow access from PCs from other networks. If you are behind a NAT-Firewall or a router make sure port 22 is forwarded to your linux machine

<div class="divider" id="ssh-f"></div>
## SSH with Dolphin

Dolphin and Krusader are both able to access remote data, using `sftp://`  and both use the ssh protocol.

How it works:  
1) Open a new Dolphin window  
2) Enter into the address bar: `sftp://username@ssh-server.com` 

Example 1: 

~~~  
sftp://siduction1@remote_hostname_or_ip  
(Note: A popup opens that asks for your ssh password, enter it and click OK)  
~~~

Example 2: 

~~~  
sftp://username:password@remote_hostname_or_ip  
(In this form you will NOT  get a popup asking for a password you will be directly connected.)  
~~~

For a LAN environment

~~~  
sftp://username@10.x.x.x or 198.x.x.x.x  
(Note: A popup opens that asks for your ssh password, enter it and click OK)  
~~~

The Dolphin SSH GUI connection now is initialised. With this Dolphin window, you can work with the files (copy/view) that are on the SSH server just as if the files would be in a folder on your local machine.

`NOTE: If you have set the ssh port to use another port, other than the default of 22, you need to specify the port that sftp is to use:`

~~~  
sftp://user@ip:port  
~~~

'user@ip:port' is standard syntax for many programs like sftp and smb.

<div class="divider" id="ssh-fs"></div>
## SSHFS - Mounting Remotely

SSFS is an easy, fast and secure method that uses FUSE to mount a remote filesystem. The only server-side requirement is a running ssh deamon.

On client side you propably have to install sshfs: `installing fuse and groups is not necessary on siduction 2011.1 forward as it is installed by default.` 

On client side you propably have to install sshfs: 

~~~  
apt-get update && apt-get install sshfs  
~~~

`Now you must log out and log back in again`

Mounting a remote filesystem is very easy:

~~~  
sshfs -o idmap=user username@remote_hostname:directory local_mount_point  
~~~

If no directory is given the home directory of the remote user will be mounted.`Attention: The colon **` **:**`**  is essential even if no directory is given!` 

After mounting the remote directory behaves like any other local filesystem, you can browse files, edit them and run scripts on them, just as you can do with a local filesystem.

If you want to unmount the remote host use the following command:

~~~  
fusermount -u local_mount_point  
~~~

If you use sshfs frequently it would be a good choice to add an fstab entry:

~~~  
sshfs#remote_hostname://remote_directory /local_mount_point fuse -o idmap=user ,allow_other,uid=1000,gid=1000,noauto,fsname=sshfs#remote_hostname://remote_directory 0 0  
~~~

Next uncomment `user_allow_other`  in `/etc/fuse.conf` :

~~~  
# Allow non-root users to specify the 'allow_other' or 'allow_root'  
# mount options.  
#  
user_allow_other  
~~~

This will allow every user which is part of the group fuse to mount the filesystem by using the well known mount command:

~~~  
mount /path/to/mount/point  
~~~

With that line in your fstab you can of course use the umount command too:

~~~  
umount /path/to/mount/point  
~~~

To check whether you are in that group or not use the following command:

~~~  
cat /etc/group | grep fuse  
~~~

You should see something like:

~~~  
fuse:x:117: <username>  
~~~

If your username is not listed use the adduser command as root:

~~~  
adduser <username> fuse  
~~~

Now your username should be listed und you should be able to run the command:

`Note: The "id" will not list in the "fuse" group, until you have logged out and logged back in again`

~~~  
mount local_mount_point  
~~~

and

~~~  
umount local_mount_point  
~~~

<div id="rev">Content last revised 10/01/2012 1300 UTC</div>
