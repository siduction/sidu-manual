<div id="main-page"></div>
<div class="divider" id="rdiff"></div>
## Backing-Up the System with rdiff-backup

rdiff-backup is a tool used to backup your files. (It can be run on a variety of *nix ports).

**`Run the commands as root in konsole, unless told otherwise`**

*great for recovering messed up dist-upgrades, kernel upgrades etc (and also just for restoring individual files).  
*only backs up what's changed like rsync does (so each backup doesn't take long).  
*keeps a history of changes (which means that you can restore a file you deleted three weeks ago!)  
*does secure backups over a network (using ssh).  
*backups partitions while they are mounted (so it's easy to automate a daily backup ... no unmounting necessary).  
*can restore everything if your hard drive goes belly-up and you have to buy a new one.  
*scales to backup large networks (linux is fine, windows is more difficult) and is used by businesses.  
*is a command-line-driven app, so it's great for those who like to do things like automate backups in a powerful way (ie a bash script which is called by cron).  
*remembers and deals with file ownerships and permissions, and also deals with symbolic links (and all that sort of stuff) so when you restore, you get things exactly as they were.

###### What you'll need

rdiff-backup keeps an entire (uncompressed) copy of the files you are backing up, and it also keeps a history (incremental backups), so this means that your backup space needs to be larger than what you're backing up. If you are backing up 100 gigs of space, you may need 120 gigs of space (on a separate hard drive preferably!).

###### How to set it up

Let's say that your pc has the following:  
* a 100 gig hard drive (sda) which is in use, with mounts sda1 used for the root partition, and sda5 used for storing music and other files, and sda6 for swap.  
* a spare 200 gig hard drive (sdb) which is not in use, with one mount sdb1 ... we'll use this one for our backups.  
* IP address 192.168.0.1

The first thing to do is to install rdiff-backup:

~~~  
# apt-get install rdiff-backup  
~~~

Now although you can backup any directory, this assumption is to back up entire partitions ... we want to back up sda1 and sda5 (we don't want to backup sda6), and so we make some directories to store the data:

~~~  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/root  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

You need the IP address distinguished because if you wish to use this computer to also backup another one (covered later on).

###### Backing up

rdiff-backup uses the syntax `rdiff-backup source-dir dest-dir` . Note: always specify directory names, not file names.

To back up sda5, run:

~~~  
# rdiff-backup /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

And to back up the root partition, run:

~~~  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
~~~

Any "AF_UNIX path too long" errors can be ignored. This may take a while as it's the first time the partition has been backed up, so rdiff-backup will have to back up the entire partition (not just the differences). Notice that we don't want to back up /tmp as this always changes, nor /proc or /sys as these don't contain real files, and also we don't want to back up mounts. If you did back up mounts, then you would be backing up sdb1, and could get into an infinite loop! One way around this is to backup the mounts separately.

Now the reason you put '/proc/*' instead of just '/proc' is that this will cunningly still backup the directory name /proc, but will ignore everything inside. The same is true to /tmp, /sys, and even more cunningly all the mount point names.

This way, if you destroy your root partition and do a full restore, /tmp, /proc, /sys and the mount points names will be created (just as they should). If /tmp doesn't exist when X starts up, it may complain. (See the man page for more on --exclude and --include).

###### Restoring directories from backups

rdiff-backup uses the syntax:

~~~  
rdiff-backup -r <from-when> <source-dir> <dest-dir>  
~~~

Now if you were to accidentally delete the directory /media/sda7/photos, you can restore it by doing:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5/photos /media/sda5/photos  
~~~

The "-r now" option means restore from the latest backup. If you have been backing everything up periodically (via crontab, say), and didn't realise that the photos directory were missing until a few days later, you would need to restore from a backup from a few days ago (and not "now", as the latest backup says that the photos directory doesn't exist). Or perhaps you just want to get back to a previous version of something.

If you want to restore from three days ago, then use the "-r 3D" ... but, as the man page says, note:

`"3D" refers to the instant 72 hours before the present, and if there was no backup made at that time, rdiff-backup restores the state recorded for the previous backup. For instance, in the above case, if "3D" is used, and there are only backups from 2 days and 4 days ago, the directory would be restored as it was 4 days ago (so you have to think about it before you restore).`

Using the following will list the date and times of when the backups were made for sda5:

~~~  
# rdiff-backup -l /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

##### Restoring partitions

You can also restore whole partitions (mounts), after all, a mount point is really just a directory.

**`WARNING: Don't restore the root partition while you are booted up into it! With one command you will lose all the files on all your partitions, including all the backups on a separate hard drive!! rdiff-backup does exactly what it was instructed to do ... if the the backup for the root partition has empty mount points, thus in order to restore to how the backup is, it deletes everything in the mounts to make everything like the backup.`**

To restore sda5 from the latest backup, we simply do:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5 /media/sda5  
~~~

##### Restoring the root partition

But to restore the root partition, it's not so simple. Don't restore the root partition while it's mounted (see the above warning). It's really useful to be able to restore the root partition, as then if you mess up things when installing/upgrading, or mess up installing a new kernel (etc), you have piece of mind that you can roll things back to how you had them, and it'll only take 20 minutes.

One way to restore the root partition is to boot into a spare linux partition if you have one on your hard disk. Then since you will be able to restore the partition you want, as it won't be mounted as root. After you restore the partition, boot up into it and it will be exactly has it was when it was backed up ... exactly! This is by far the easiest method.

Another way to restore the root partition is to boot up the siduction-live cd and do the restore from there. rdiff-backup is included in siduction. In case the siduction live-cd version you have does not include rdiff, you can type in the grub (Bootoptions, (Cheatcodes)) the cheatcode "unionfs" and that will mean you can install applications on the live cd. Just boot up and do the following commands:

~~~  
$ sudo su  
# wget -O /etc/apt/sources.list http://siduction.org/files/misc/sources.list  
# apt-get update  
# apt-get install rdiff-backup  
~~~

###### Now let's do the restore:

~~~  
# mount /dev/sda1 /media/sda1  
# mount /dev/sdb1 /media/sdb1  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

Note: If you don't have an siduction CD and your Live-CD is supported by klik you can install rdiff-backup using the Klik and calling:

~~~  
$ sudo ~/.zAppRun ~/Desktop/rdiff-backup_0.13.4-5.cmg rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

It is recommended that anyone backing up their root partition (with the intention of restoring from it if they have to) should test the restoring process. Nothing worse than thinking everything will be fine, and then coming across something unexpected during an emergency.

If the hard drive has been changed or reformatted, recheck the UUIDs, (or Labels), in `/boot/grub/menu.lst (grub-legacy) or files in /etc/grub.d (grub2)`  and `/etc/fstab` , and alter accordingly. An easy way to get the information to alter the menu.lst and fstab files, if required, is as root:

~~~  
blkid  
~~~

##### Backing up other pc's

You can back up other pc's onto the local pc, as long as our local pc can ssh to the other pc's (and as long as you have room on your hard drive). The ssh server (sshd) needs to be running on remote pc. The other pc's don't have to be in your local lan, they could be anywhere in the world.

Let's assume that your remote pc has the following:  
1) a 100 gig hard drive (sda) which is in use, with only mounts,  
2) sda1 used for the root partition,  
3) sda5 that we are storing some temporary files that we don't want backed up,  
4) and sda6 for swap  
5) IP address 192.168.0.2

Note: both 100 gig drives cannot usually be backed up on the 200 gig drive using rdiff-backup (since there would be no room for incremental files), but since you aren't backing up sda5 on the remote pc (and since hard drives aren't usually 100% full anyway, although don't rely on this) then you may calculate that you have enough room. Every time rdiff-backup performs another backup, more incremental files are created, and this takes up more and more room.

You can tell rdiff-backup only to keep a max of 1 months backups (this command is shown later on), and this would take up less room than telling rdiff-backup to keep a years worth of data. And of course if you want a years worth of data backed up, then you have to have the hard drive space to store a years worth of incremental files.

The first thing you have to do is to install rdiff-backup on the remote pc as well (every computer that you want to backup including the backup server must have rdiff-backup installed).

To back the remote pc up onto the local pc, run on the local pc (ie 192.168.0.1): `Note the use of the double colons ::` 

~~~  
# mkdir /media/sdb1/rdiff-backups/192.168.0.2/root  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' 192.168.0.2::/ /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Now if you want to restore a directory on the remote pc, initiate the restore on either the local pc, or the remote pc.

This is how you would restore the directory /usr/local/games on the remote pc, by initiating it from the remote pc:

~~~  
# rdiff-backup -r now 192.168.0.1::/media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games /usr/local/games  
~~~

This is how you would restore the directory /usr/local/games on the remote pc, by initiating it from the local pc:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games 192.168.0.2::/usr/local/games  
~~~

Use the same sort of syntax when restoring your root partition from a live cd (where the remote pc has been booted up via live cd ... see above).

##### Automating backups:

If you are backing up other pc's onto your local pc first thing to do is enable password-less ssh logins using ssh keys. **`Note that this is talking about password-less ssh logins as root. This can be tied down so that only rdiff-backup commands are performed, but this is outside the scope of this topic Please refer to  [SSH Configuration](ssh-en.htm#ssh-s) `**  We are going to assume complete trust, and we are going to set up the simplest way of achieving password-less logins.

From the local pc, do the following:

~~~  
# [ -f /root/.ssh/id_rsa ] || ssh-keygen -t rsa -f /root/.ssh/id_rsa  
~~~

And press enter twice for blank passwords. Then do:

~~~  
# cat /root/.ssh/id_rsa.pub | ssh 192.168.0.2 'mkdir -p /root/.ssh;\<!--dunno if this is wrong-->  
> cat - >>/root/.ssh/authorized_keys2'  
~~~

You will be prompted for your root password.

Now you can ssh to the remote pc as root without having to type a password, and rdiff-backup can be automated.

Next, create a bash script that contains all the rdiff-backup commands. Our bash script may look something like this:

~~~  
#!/bin/bash  
RDIFF=/usr/bin/rdiff-backup  
echo  
echo "=======Backing up 192.168.0.1 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
echo "(and purge increments older than 1 month)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/root  
echo  
echo "=======Backing up 192.168.0.1 mount sda5======="  
${RDIFF} --ssh-no-compression --exclude /media/sda5/myjunk /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo "(and purge increments older than 1 months)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo  
echo "=======Backing up 192.168.0.2 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' --exclude '/mnt/*/*' 192.168.0.2::/media/sdb1/rdiff-backups/192.168.0.2/root  
echo "(and purge increments older than 1 months)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Now you can name this bash script "myrdiff-backups.bash" and put it in /usr/local/bin on our local (backup server) machine, and change it to an executable. Run the bash script and make sure it works.

And lastly you can get cron to call it every night at 8pm. The following line in root's crontab will do the trick, call

~~~  
# crontab -e  
and insert the following line  
0 20 * * * /usr/local/bin/myrdiff-backups.bash  
~~~

<div id="rev">Content last revised 17/01/2012 1800 UTC</div>
