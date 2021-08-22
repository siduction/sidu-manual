BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC1**

Necessary work:

+ check intern links  
+ check extern links  
+ check layout  
+ check spelling  

Work done


END   INFO AREA FOR THE AUTHORS  
% systemd-mount

## systemd-mount

The basic and introductory information about Systemd is contained in the manual page [Systemd-Start](./systemd-start_en.md#systemd-der-system--und-dienste-manager) The sections *[Unit]* and *[Install]* concerning all unit files are covered in our manual page [Systemd Unit file](./systemd-unit-datei_en.md#systemd-unit-file).  
In this manual page we explain the function of the systemd units **mount** and **automount**. They are used by systemd to manage mount points for drives and their partitions, which can be accessible both locally and over the network.

The **mount** unit is a configuration file that provides systemd with information about a mount point.  
The **automount** unit monitors the file system and activates the *.mount unit* of the same name if the file system designated therein is available.

For drives and their partitions directly installed in the PC we only use the *mount* unit. It is enabled and started to mount the drives at each boot.  
For network file systems, the *mount* unit has the advantage of being able to declare dependencies so that the unit only becomes active when the network is ready. Again, we use only the *mount* unit and activate and start it to mount the network file system at each boot. The *mount* unit supports all types of network file systems (NFS, SMB, FTP, WEBDAV, SFTP, SSH).

Removable devices, such as USB sticks, and network file systems that are not permanently accessible must always be attached to a *.automount* unit. In this case, the *mount* unit must not be activated and should not contain an [Install] section.

*mount* and *automount* units must be named after the mount point they control. For example, the mount point "/home/musteruser" must be configured in a unit file "home-musteruser.mount", or "home-musteruser.automount".

The devices declared in "*/etc/fstab*" and their mount points are translated into native *mount* units by systemd in the early boot phase using the "*systemd-fstab-generator*".

### Contents of the mount unit

The *mount* unit has the following options in the mandatory [mount] section:

+ **What=** (mandatory).  
 	Contains the absolute path of the mounted device, e.g., disk partitions such as /dev/sda8 or a network share such as NFSv4 or Samba.

+ **Where=** (mandatory)  
 	Here you specify the mount point, i.e. the folder where the partition, network drive or device should be mounted. If it does not exist, it will be created during the mount process.

+ **Type=** (optional)  
    Here the type of the file system is specified, according to the mount parameter -t.

+ **Options=** (optional)  
 	Contains all used options in a comma separated list, according to the mount parameter -o.

+ **LazyUmount=** (default: off)  
 	If set to true, the filesystem will be unmounted as soon as it is no longer needed. 

+ **SloppyOptions=** (default: off)  
    If true, a relaxed evaluation of the options specified in *Options=* is performed and unknown mount options are tolerated. This is equivalent to the mount parameter -s.

+ **ReadWriteOnly=** (default: off)  
    If false, the file system or device that should be mounted read-write, but the mount fails, is attempted to be mounted read-only. If true, the process immediately ends with an error if the read-write mount fails. This is equivalent to the -w mount parameter. 

+ **ForceUnmount=** (default: off).  
    If true, unmounting is forced if, for example, an NFS file system is unreachable. This corresponds to the mount parameter -f. 

+ **DirectoryMode=** (default: 0755)  
    The, if necessary, automatically created directories of mount points, get the declared file system access mode. Accepts an access mode in octal notation.

+ **TimeoutSec=** (default value from the *DefaultTimeoutStartSec=* option in systemd-system.conf).  
    Configures the time to wait for the mount command to finish. If a command does not finish within the configured time, the mount is considered to have failed and is shut down again. Accepts a unit-free value in seconds or a duration value such as "5min 20s". Passing "0" will disable the timeout logic.

### Contents of automount unit

The *automount* unit has the following options in the mandatory [Automount] section:

+ **Where=** (mandatory)  
 	This specifies the mount point, i.e. the folder where the partition, network drive or device is to be mounted. If it does not exist, it will be created during the mount process.

+ **DirectoryMode=** (default: 0755)  
    The, if necessary, automatically created directories of mount points get the declared file system access mode. Accepts an access mode in octal notation.

+ **TimeoutIdleSec=** (default: 0)  
    Specifies the time of inactivity after which systemd attempts to unmount the file system. Accepts a unitless value in seconds or a duration value such as "5min 20s". The value "0" disables the option.

### Examples

Systemd reads the mount point from the name of the *mount* and *automount* units. Therefore, they must be named after the mount point they control.  
Care must be taken not to use hyphens "-" in the filenames, because they declare a new subdirectory in the directory tree. Some examples:

+ invalid: /data/home-backup
+ allowed: /data/home_backup
+ allowed: /data/home\x2dbackup

To get an error-free file name for the *mount* and *automount* units, we use the "systemd-escape" command in the terminal.

~~~
$ systemd-escape -p --suffix=mount "/data/home-backup"
  data/home\x2dbackup.mount
~~~

**Disk partition**  
A partition should be accessible under "/disks/TEST" after every system start.  
We create with a text editor the file "disks-TEST.mount" in the directory "/usr/local/lib/systemd/system/". (If necessary, create the directory beforehand with the command **`mkdir -p /usr/local/lib/systemd/system/`**).

~~~
[Unit]
Description=Mount /dev/sdb7 at /disks/TEST
After=blockdev@dev-disk-by\x2duuid-a7af4b19\x2df29d\x2d43bc\x2d3b12\x2d87924fc3d8c7.target
Requires=local-fs.target
Wants=multi-user.target

[Mount]
Where=/disks/TEST
What=/dev/disk/by-uuid/a7af4b19-f29d-43bc-3b12-87924fc3d8c7
Type=ext4
Options=defaults,noatime

[Install]
WantedBy=multi-user.target
~~~

Then we activate and start the new *.mount* unit.

~~~
# systemctl enable --now disks-TEST.mount
~~~

**NFS**  
The "document-root" directory of an Apache web server in the home network is to be mounted into the home directory of the workstation computer using NFS.  
We create the file "home-\<user\>-www_data.mount" in the directory "/usr/local/lib/systemd/system/" using a text editor.  
Please replace "\<user\>" with your own name.

~~~
[Unit]
Description=Mount server1/var/www/ using NFS
After=network-online.target
Wants=network-online.target

[Mount]
What=192.168.3.1:/
Where=/home/<user>/www_data
Type=nfs
Options=nfsvers=4,rw,users,soft
ForceUnmount=true
~~~

This file does not contain an [Install] section and will not be activated. The control is taken over by the now following file "home-\<user\>-www_data.automount" in the same directory.

~~~
[Unit]
Description=Automount server1/var/www/ using NFS
ConditionPathExists=/home/<user>/www_data
Requires=NetworkManager.service
After=network-online.target
Wants=network-online.target

[Automount]
Where=/home/<user>/www_data
TimeoutIdleSec=60

[Install]
WantedBy=remote-fs.target
WantedBy=multi-user.target
~~~

Afterwards:

~~~
# systemctl enable --now home-<user>-www_data.automount
~~~

Now the "document-root" directory of the Apache web server will be mounted as soon as we change to the "/home/\<user\>/www_data" directory.  
The status prompt confirms the action.

~~~
# systemctl status home-<user>-www_data.mount --no-pager
● home-<user>-www_data.mount - Mount server1/var/www/ using NFS
     Loaded: loaded (/usr/local/lib/systemd/system/home-<user>-www_data.mount; disabled; vendor preset: enabled)
     Active: active (mounted) since Wed 2021-03-10 16:27:58 CET; 8min ago
TriggeredBy: ● home-<user>-www_data.automount
      Where: /home/<user>/www_data
       What: 192.168.3.1:/
      Tasks: 0 (limit: 4279)
     Memory: 120.0K
        CPU: 5ms
     CGroup: /system.slice/home-<user>-www_data.mount
[...]

# systemctl status home-<user>-www_data.automount --no-pager
● home-<user>-www_data.automount - automount server1/var/www/ usuing NFS
     Loaded: loaded (/usr/local/lib/systemd/system/home-<user>-www_data.automount; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-03-10 16:27:58 CET; 8min ago
   Triggers: ● home-<user>-www_data.mount
      Where: /home/<user>/www_data
[...]
~~~

The journal excerpt vividly logs the operation of "TimeoutIdleSec=60" to unmount the file system and mount it again by starting the file manager Thunar and a call to "/home/\<user\>/www_data" in the terminal.

~~~
# journalctl -f -u home-<user>-www_data.*
[...]
Mar 10 17:56:14 pc1 systemd[1]: Mounted mount server1/var/www/ using NFS.
Mar 10 17:57:34 pc1 systemd[1]: Unmounting Mount server1/var/www/ using NFS...
Mar 10 17:57:35 pc1 systemd[1]: home-<user>-www_data.mount: Succeeded.
Mar 10 17:57:35 pc1 systemd[1]: Unmounted mount server1/var/www/ using NFS.
Mar 10 17:58:14 pc1 systemd[1]: home-<user>-www_data.automount: Got automount request for /home/<user>/www_data, triggered by 2500 (Thunar).
Mar 10 17:58:14 pc1 systemd[1]: Mounting Mount server1/var/www/ using NFS...
Mar 10 17:58:14 pc1 systemd[1]: Mounted Mount server1/var/www/ using NFS.
Mar 10 18:00:15 pc1 systemd[1]: Unmounting Mount server1/var/www/ using NFS...
Mar 10 18:00:15 pc1 systemd[1]: home-<user>-www_data.mount: Succeeded.
Mar 10 18:00:15 pc1 systemd[1]: Unmounted mount server1/var/www/ using NFS.
Mar 10 18:00:30 pc1 systemd[1]: home-<user>-www_data.automount: Got automount request for /home/<user>/www_data, triggered by 6582 (bash).
Mar 10 18:00:30 pc1 systemd[1]: Mounting Mount server1/var/www/ using NFS...
Mar 10 18:00:30 pc1 systemd[1]: Mounted Mount server1/var/www/ using NFS.
Mar 10 18:01:51 pc1 systemd[1]: Unmounting Mount server1/var/www/ using NFS...
Mar 10 18:01:51 pc1 systemd[1]: home-<user>-www_data.mount: Succeeded.
Mar 10 18:01:51 pc1 systemd[1]: Unmounted mount server1/var/www/ using NFS.
[...]
~~~

**More examples**  
Using your favorite search engine, you can find many examples for using the *mount* and *automount* units on the Internet. The chapter "Sources" contains some websites with a lot of further examples. Urgently recommended are also the man pages.

### Sources systemd-mount

[German man page, systemd.mount](https://manpages.debian.org/testing/manpages-de/systemd-mount.1.de.html)  
[German man page, mount](https://manpages.debian.org/testing/manpages-de/mount.8.de.html)  
[Manjaro Forum, systemd.mount](https://forum.manjaro.org/t/root-tip-systemd-mount-unit-samples/1191)  
[Manjaro Forum, Use systemd to mount ANY device](https://forum.manjaro.org/t/root-tip-use-systemd-to-mount-any-device/1185)  
[Linuxnews, nfs via systemd](https://linuxnews.de/2019/12/nfs-freigaben-per-systemd-einbinden/)  
[Debianforum, Mount network drives](https://wiki.debianforum.de/Netzlaufwerke_einbinden)  
[Ubuntuusers, mount units](https://wiki.ubuntuusers.de/systemd/Mount_Units/)

<div id="rev">Page last updated 2021-14-08</div>
