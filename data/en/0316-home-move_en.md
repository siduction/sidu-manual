% home move

## Move the home directory

> Important information  
> An existing **/home** should not be used or shared with another distribution as there may/will be conflicts with the configuration files.

Therefore, we generally advise against creating a **/home** partition.  
The directory `/home` should be the place where the individual configurations are stored, and only these. For all other private data, a separate data partition should be created, and this should be mounted under `/data`, for example. The advantages for data stability, data backup, and also in case of data recovery are almost immeasurable.  
If data is to be shared for parallel installations, this procedure is particularly advisable.

**Preparations**

The necessary steps will be explained on a realistic example.  
The initial situation:

* The old, meanwhile too small hard disk has three partitions (**/boot/efi**, **/**, **swap**).
* There is no separate data partition yet.
* An additional built-in hard disk has four partitions with the **ext4** file system.  
  We will use this partition's **sdb4** as the new data partition, which we mount to `/data`.

Our previous `/etc/fstab` has the content:

~~~
$ cat /etc/fstab
...
UUID=B248-1CCA                            /boot/efi vfat   umask=0077 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb /         ext4   defaults,noatime 0 1
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256 swap      swap   defaults,noatime 0 2
tmpfs                                     /tmp      tmpfs  defaults,noatime,mode=1777 0 0
~~~

We need the UUID information of the additional hard disk. See also the manual page [customize fstab](0311-part-uuid_en.md#adjusting-the-fstab).  
The command **`blkid`** returns the following information:

~~~
$ /sbin/blkid
...
/dev/sdb4: UUID="e2164479-3f71-4216-a4d4-af3321750322" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="000403b7-04"
~~~

**Backup of the old /home**

Before making any changes to the existing file system, we use **root** privileges to backup everything inside `/home` into a tar archive. 

~~~
# cd /home
# tar cvzpf somewhere/home.tar.gz ./
~~~

**Mountpoint of the data partition**

We create the directory `Data` in `/` and mount the partition **sdb4** there. As owner and group we set our own names. Some time later, we will copy the private data, but not the configurations, from the existing `/home` into it.

Create mountpoint and mount partition (as **root**):

~~~
# mkdir /data
# chown <user>:<group> /data
# mount -t ext4 /dev/sdb4 /data
~~~

### Move private data

**Analysis of /home**

Let's first take a close look at our home directory.  
(The output has been sorted for clarity.)

~~~
~$ ls -la
total 169
drwxr-xr-x 19 <user><group> 4096  4 Oct 2020 .
drwxr-xr-x 62 <user><group> 4096  4 Oct 2020 ..
-rw------- 1  <user><group> 330  15 Oct 2020 .bash_history
-rw-r--r-- 1  <user><group> 220   4 Oct 2020 .bash_logout
-rw-r--r-- 1  <user><group> 3528  4 Oct 2020 .bashrc
drwx------ 19 <user><group> 4096 15 Oct 2020 .cache
drwxr-xr-x 22 <user><group> 4096 15 Oct 2020 .config
-rw-r--r-- 1  <user><group>   24  4 Oct 2020 .dmrc
drwx------ 3  <user><group> 4096 15 Oct 2020 .gconf
-rw-r--r-- 1  <user><group>  152  4 Oct 2020 .gitignore
drwx------ 3  <user><group> 4096 15 Oct 2020 .gnupg
-rw------- 1  <user><group> 3112 15 Oct 2020 .ICEauthority
-rw-r--r-- 1  <user><group>  140  4 Oct 2020 .inputrc
drwx------ 3  <user><group> 4096  4 Oct 2020 .local
drwx------ 5  <user><group> 4096 15 Oct 2020 .mozilla
-rw-r--r-- 1  <user><group>  807  4 Oct 2020 .profile
drwx------ 2  <user><group> 4096  4 Oct 2020 .ssh
drwx------ 5  <user><group> 4096 15 Oct 2020 .thunderbird
-rw------- 1  <user><group>   48 15 Oct 2020 .Xauthority
-rw------- 1  <user><group> 1084 15 Oct 2020 .xsession-error
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Desktop
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Documents
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Downloads
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Music
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Pictures
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Public
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Templates
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Videos
~~~

The output shows the home directory shortly after installation with only minor changes.  
We put our private documents into the, by default created, directories `Desktop` to `Videos` at the end of the list. These and possibly additional, self-created directories with private data, will be moved into the new data partition later.  
"Hidden" files and directories beginning with a dot (.) contain configuration and program-specific data that we do not move, with three exceptions. These exceptions are:  
the cache `.cache`,  
the internet browser `.mozilla`, and  
the mail program `.thunderbird`.  
All three reach a considerable volume over time, and they also contain a lot of private data. Therefore, we move them to the new data partition, too.

**Copying the private data**

For copying, we use the command `cp` with the archive option `-a`. Thus the rights, owners, and the timestamp are kept, and it is copied recursively.

~~~
~$ cp -a * /data/
~$ cp -a .cache /data/
~$ cp -a .mozilla /data/
~$ cp -a .thunderbird /data/
~~~

The first command copies all files and directories except for the hidden ones.  
The following output shows the result:

~~~
~$ ls -la /data/
total 45
drwxr-xr-x 13 <user><group> 4096  4 May 2020 .
drwxr-xr-x 20 root  root    4096  4 Oct 2020 ..
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 images-en
drwx------ 19 <user><group> 4096 15 Oct 2020 .cache
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Desktop
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Documents
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Downloads
drwx------ 5  <user><group> 4096 15 Oct 2020 .mozilla
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 music
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Public
drwx------ 5  <user><group> 4096 15 Oct 2020 .thunderbird
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 Videos
drwxr-xr-x 2  <user><group> 4096  4 Oct 2020 templates
~~~

To check the copy action for errors, you can use the command  
**`dirdiff /home/<user>/ /data/`**. Only the files and directories that we did not copy should be listed.

Now all private data from the old `/home` are additionally on the new partition.

**Delete in /home**.

For this action, all program windows should be closed, except for the terminal we use.  
Depending on the desktop environment, various applications use the directories created by default during installation (e.g. `Music`) to store files there. In order to enable the access of the applications to the directories, these must be linked back, thus refer to the corresponding directories of the **/data** partition.

> Please check the commands carefully before executing them so you don't accidentally delete something wrong.

~~~
~$ rm -r Desktop/ && ln -s /Data/Desktop/ ./Desktop
~$ rm -r Documents/ && ln -s /Data/Documents/ ./Documents
~$ rm -r Downloads/ && ln -s /Data/Downloads/ ./Downloads
~$ rm -r Music/ && ln -s /Data/Music/ ./Music
~$ rm -r Pictures/ && ln -s /data/Pictures/ ./Pictures
~$ rm -r Public/ && ln -s /Data/Public/ ./Public
~$ rm -r Templates/ && ln -s /Data/Templates/ ./Templates
~$ rm -r Videos/ && ln -s /Data/Videos/ ./Videos
~$ rm -r .cache/ && ln -s /data/.cache/ ./.cache
~$ rm -r .mozilla/ && ln -s /data/.mozilla/ ./.mozilla
~$ rm -r .thunderbird/ && ln -s /data/.thunderbird/ ./.thunderbird
~~~

The data remaining in the `/home` directory will only occupy less than 10 MB of space.

### Adjust fstab

In order for the new data partition to be mounted and available to the user at system startup, the `fstab` file must be modified. Additional information about the `fstab` can be found in our manual [adaptation of the fstab](0311-part-uuid_en.md#adjusting-the-fstab).  
We need the data partition's already read out UUID information. Before modifying the file, we create a backup copy of the `fstab` with date attachment:

~~~
# cp /etc/fstab /etc/fstab_$(date +%F) 
# mcedit /etc/fstab
~~~

According to our example, we add the following line to fstab.

**`UUID=e2164479-3f71-4216-a4d4-af3321750322 /data ext4 defaults,noatime 0 2`**

The `fstab` should now look like this:

~~~
UUID=B248-1CCA                            /boot/efi vfat   umask=0077 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb /         ext4   defaults,noatime 0 1
UUID=e2164479-3f71-4216-a4d4-af3321750322 /data     ext4   defaults,noatime 0 2
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256 swap      swap   defaults,noatime 0 2
tmpfs                                     /tmp      tmpfs  defaults,noatime,mode=1777 0 0
~~~

Save the file with **`F2`** and quit the editor with **`F10`**.

If, nonetheless, anything goes wrong, we still have our data in the saved tar archive.

<div id="rev">Last edited: 2022/04/01</div>
