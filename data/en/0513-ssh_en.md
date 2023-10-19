% Secure Shell

## SSH

> **Enable SSH**.  
> For siduction, ssh is not enabled both on the live ISO and after installation!  
> To enable and disable *ssh* please use the scripts `sshactivate` and `sshdeactivate`. They are located in `/usr/sbin`.  
> Alternatively use the starters in the application menu > Internet/Network.

**Definition of SSH from [Wikipedia](http://de.wikipedia.org/wiki/Secure_Shell)** :

Secure Shell or SSH refers to both a network protocol and corresponding programs that can be used to establish an encrypted network connection with a remote device in a secure manner. Often this method is used to bring a remote command line to the local computer, i.e. the local console displays the output of the remote console and the local keyboard input is sent to the remote computer. This gives the effect of sitting in front of the remote console, which can conveniently be used for remote maintenance of, for example, a root server located in a remote data center. The newer protocol version SSH-2 offers further functions like data transfer via SFTP.

In general, SSH should only be configured and used for remote control if you are sure about the effects of the settings in the `/etc/ssh/sshd_config` file and, if applicable, the files in the `/etc/ssh/sshd_config.d/` directory.  
If in doubt, study the documentation in the man pages **`man sshd_config`**, **`man ssh_config`** or on the Internet, or seek the advice of competent persons.

### Securing SSH 

It is not secure to make root logins via SSH the default. Debian should be secure, not insecure. Likewise, attackers should not be able to perform a wordlist-based password attack (brute force attack) on the SSH login over a long period of time. Therefore, we make some changes in the `/etc/ssh/sshd_config` file.

**The following settings can be adjusted to increase security:**  
(To activate the function of the entries the comment character '#' must be removed).

+ **Port <desired port>**:  
  This entry must point to the port that is enabled on the router for forwarding. IANA has assigned TCP port 22 to the protocol and Debian sets it as the default. However, it is advisable to use a port outside the default scanning range. We therefore use port 5874, for example, to make attacks more difficult, since the SSH port is not known to the attacker.

  ~~~
  Port 5874
  ~~~

+ **ListenAddress <IP of the computer or network interface>**:  
  Since the port is forwarded by the router, the computer must use a static IP address unless a local DNS server is used. But if something as complicated as SSH is to be set up using a local DNS server and these instructions are needed, a serious error can occur easily. We'll use a static IP for the example:

  ~~~
  ListenAddress 192.168.2.134
  ~~~

  The SSH protocol 2 with its improved and extended features is already default in Debian.

+ **LoginGraceTime <timeframe of login>**:  
  By deault, the allowed time is 2 minutes. Since it usually doesn't take two minutes to enter a username and password, we set a slightly shorter time period:

  ~~~
  LoginGraceTime 30
  ~~~

  Now you have 30 seconds to log in, and hackers don't have two minutes each time they try to crack the password.

+ **PermitRootLogin <prohibit‐password>**:  
  Why Debian gives permission to log in as root here is not understandable. We correct to `no`:
  
  ~~~
  PermitRootLogin no
  StrictModes yes
  ~~~
  
  Alternatively, you can set this option to *forced-commands-only*. This will allow root to log in via asymmetric authentication, but only if the *command* option is set (which is useful for performing remote backups, even if root logins are not normally allowed). All other authentication methods for root remain disabled.

+ **MaxAuthTries <number of allowed login attempts>**:  
   More than 3 or 4 attempts should not be allowed:

  ~~~
  MaxAuthTries 3
  ~~~

**The following settings must be added if they are not present:**

+ **AllowUsers <xxx>**:  
  Usernames which are allowed to access via SSH, separated by spaces. Only registered users can use the access, and only with user rights. With `adduser` you should add a user that is specifically meant to use SSH:

  ~~~
  AllowUsers whoever1 whoever2
  ~~~

+ **PermitEmptyPasswords <xxx>**:  
  The user should be given a nice and long password that can't be guessed in a million years. They should be the only one with SSH access. Once logged in, they can become **root** with **`su`**:

  ~~~
  PermitEmptyPasswords no
  ~~~

+ **PasswordAuthentication <xxx>**:  
  Obviously, 'yes' must be set here (unless you use a KeyLogin).

  ~~~
  PasswordAuthentication yes
  ~~~

Finally:

~~~
systemctl restart ssh
~~~

Now you have a somewhat secure SSH configuration. Not completely secure, just better, especially if you have added a user specifically for using SSH.

### SSH for X Window Programs

**`ssh -X`** allows you to connect to a remote computer and display its X graphics server on your own local computer. You enter the command as **user** (not **root**) (and note that X is a capital letter):

~~~
$ ssh -X username@xxx.xxx.xxx.xxx (or IP)
~~~

Enter the password for the remote computer's username and start a graphical application in the shell. Examples:

~~~
$ iceweasel OR libreoffice OR kspread
~~~

On very slow connections, it may be advantageous to use the compression option to increase the transfer rate. However, for fast connections, the opposite effect may occur:

~~~
$ ssh -C -X username@xxx.xxx.xxx.xxx (or IP)
~~~

Further information can be obtained with **`man ssh`**.

**Note:**  
If ssh refuses a connection and you get an error message, search in `$HOME` for the hidden directory `.ssh`, delete the file `known_hosts` and try a new connection. This problem occurs mainly when you have assigned the IP address dynamically (DCHP).

### Copy scp via ssh

**scp** is a command line utility (Terminal/CLI) to copy files between network computers. It uses ssh for authentication and secure file transfer, so scp requires a password or passphrase to log in.

If you have ssh rights on a network PC or network server, scp allows you to copy partitions, directories, or files to or from a network computer (or an area on it) that you have access rights to. This can be, for example, a PC or server on the local network, a computer on a remote network, or a local USB drive. The copy operation can take place between remote computers/storage devices.

It is also possible to recursively copy entire partitions or directories with **`scp -r`**. Note that this command also follows symbolic links in the directory tree.

**Examples**

1. Copying a partition:

   ~~~
   scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/ /media/diskXpartX/
   ~~~

2. Copying a directory on a partition, in this case a directory named `photos` in `$HOME`:

   ~~~
   scp -r <user>@xxx.xxx.x.xxx:~/photos/ /media/diskXpartX/xx
   ~~~

3. Copying a file in a partition's directory, in this case a file in `$HOME`:

   ~~~
   scp <user>@xxx.xxx.x.xxx:~/filename.txt /media/diskXpartX/xx
   ~~~

4. Copying a file on a partition:

   ~~~
   scp <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt /media/diskXpartX/xx
   ~~~

5. If you are in the drive or directory where another directory or file shall be copied to, use only a **.**  (dot):

   ~~~
   scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt .
   ~~~

Additional information:

~~~
man scp
~~~

### SSH with Dolphin or Thunar

Dolphin and Thunar are capable of accessing data from a remote machine using the *"sftp "* protocol present in ssh.

This is how it is done:

1. **For a remote server**.  
  One opens a new file manager window or a new tab.  
  Enter into the address bar according to the pattern:  
    - `sftp://username@ssh-server.com`  
    Then a dialog window opens and asks for the SSH password. One enters the password and clicks OK,  
    - or the input already contains the password:  
    `sftp://username:password@remote_hostname_or_ip`  
    You will not be asked for a password, you will be connected directly.

2. **For a LAN environment**.  
  Following the same pattern as before:  
    - `sftp://username@192.168.x.x`  
    with dialog window for SSH password,  
    - or immediately with password:  
    `sftp://username:passwort@192.168.x.x`

Please enter the correct IP!  
A SSH connection is now established. In this window, you can work with the files on the SSH server as if they were local files.

**NOTE:**  
If a port other than 22 (default) is used, it must be specified when using sftp. The input then follows the syntax:  
`sftp://user@ip:port`,  
this is the default syntax for many protocols/programs like sftp and smb.

### SSHFS - mount on a remote computer

SSHFS is a simple, fast, and secure method using FUSE to mount a remote filesystem. On the server side, all you need is a running ssh daemon.

On the client side, you probably need to install sshfs first:


~~~
apt update && apt install sshfs
~~~

`fuse3` and `groups` are already on the ISO and do not need to be installed separately. 

Mounting a remote filesystem is very easy:

~~~
sshfs -o idmap=user username@remote_hostname:directory local_mountpoint
~~~

If no specific directory is specified, the remote user's home directory will be mounted. Please note: the colon *":"* is mandatory even if no directory is specified! 

Once mounted, the remote directory behaves like any other local file system. You can browse, read and modify files, and execute scripts just like on a local file system.

Mounting the remote host is accomplished with the following command:

~~~
fusermount -u local_mountpoint
~~~

If you use sshfs regularly, it is recommended to make an entry in `/etc/fstab` (all in one line):

~~~
sshfs#remote_hostname://remote_directory /local_mount_point
 fuse -o idmap=user ,allow_other,uid=1000,gid=1000,noauto,
 fsname=sshfs#remote_hostname://remote_directory 0 0 
~~~

Next, remove the comment character before *"user_allow_other"* in the file `/etc/fuse.conf`:

~~~
# Allow non-root users to specify the 'allow_other'
# or 'allow_root' mount options.
#
user_allow_other
~~~

This allows any user in the fuse group to mount or unmount the filesystem:

~~~
mount /path/to/mount/point # mount
umount /path/to/mount/point # unmount
~~~

Use this command to check if you are a member of the fuse group:

~~~
cat /etc/group | grep fuse
~~~

The answer should look something like this:

~~~
fuse:x:117: <username>
~~~

If the username is not listed, use the `adduser` command as **root**:

~~~
adduser <username> fuse
~~~

**Note:**  
The user will not be a member of the group "fuse" until he logs in again.  
Now the desired username should be listed and the following command should be executable:

~~~
mount local_mountpoint

    and

umount local_mountpoint
~~~

<div id="rev">Last edited: 2023/10/19</div>
