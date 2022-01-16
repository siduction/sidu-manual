% UUID - naming of block devices

## UUID - naming of block devices

**UUID (Universally Unique Identifier) and partition label**.

The permanent naming of block devices was made possible with the introduction of udev. The advantage is independence from the used controllers as well as from the type and number of connected devices. The *fstab* file created during the installation of siduction contains corresponding entries for all block devices connected at that time.

### Types of block device naming

Currently, Linux uses five types of identifiers for block devices. All identifiers can be found below the **/dev/disk/** directory and are created automatically by the system. For *labels* this only applies if they have been assigned to the block devices beforehand.

1. **UUID**  
  It is a unique identifier on file system level and stored in the file system's metadata. To read it, the file system type must be known and readable. It is unique because a new UUID is already created when a partition is formatted.  
  A UUID is a 128-bit number. Anyone can create and use a UUID. The probability that a UUID is duplicated is not zero, but it is so small that the case can be neglected. All Linux file systems including swap support UUID. Although FAT and NTFS file systems do not support UUID, they are listed in */dev/disk/by-uuid*.

2. **PARTUUID**.  
  It is an identifier on partition table level that has been introduced with GTP. The PARTUUID is preserved when the partition is reformatted and is therefore not unique. For example, mounting through an fstab entry based on PARTUUID will fail if the partition was given a different filesystem without modifying fstab.

3. **Device ID (ID)**  
  The ID is created from the metadata of the device (manufacturer, connection type, construction type, storage volume, etc.) and does neither take into account the partitioning nor the file systems in the partitions. It is unsuitable as a permanent identifier in fstab.

4. **PATH**  
  It is composed of the controller name, the device type, and the partition number. As with ID, it is unsuitable as a permanent identifier in fstab.

5. **LABEL**  
  Labels are easily recognizable identifiers assigned by the user. They are not unique, so care must be taken to avoid overlapping names. 

**By default, siduction uses UUID in /etc/fstab for the above reasons.**

### Use label

The label of a block device has the advantage for us humans to be easily understandable and recognizable. 
Practically every type of file system can have a label. Partitions with a label can be found in the directory **/dev/disk/by-label**:

~~~
$ ls -l /dev/disk/by-label
total 0
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2
lrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda6
lrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1
lrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5
lrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1
~~~

The label can be created or changed with the following commands:

| File system | Command |
| :--- | :--- |
| swap | swaplabel -L <LABEL> /dev/sdXx |
| ext2/ext3/ext4 | e2label /dev/sdXx <LABEL> or tune2fs -L <LABEL> /dev/sdXx |
| jfs | jfs_tune -L <LABEL> /dev/sdXx |
| xfs | xfs_admin -L <LABEL> /dev/sdXx |
| reiserFS | reiserfstune -l <LABEL> /dev/sdXx |
| fat | fatlabel /dev/sdXx <LABEL> |
| ntfs | ntfslabel /dev/sdXx <LABEL> |

An NTFS and FAT partition's label should consist only of uppercase letters, digits, and special characters that Windows™ allows for file names.

The syntax in fstab for the *file system* is **LABEL=\<label\>**.

> It is essential to note:  
> The labels must have a singular name in order to work when mounted. This also applies to external devices (hard disks, sticks, etc.) that are mounted via USB or Firewire.

## The fstab

The file */etc/fstab* is read during system startup to mount the desired partitions. Here is an example of an fstab:

~~~
# <file system> <mount point> <type> <options> <dump> <pass>
UUID=2e3a21ef-b98b-4d53-af62-cbf9666c1256 swap swap defaults,noatime 0 2
UUID=1c257cff-1c96-4c4f-811f-46a87bcf6abb / ext4 defaults,noatime 0 1
UUID=35336532-0cc8-4613-9b1a-f31b12ea58c3 /home ext4 defaults,noatime 0 2
tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0
UUID=e2164479-3f71-4216-a4d4-af3321750322 /mnt/TEST_root ext4 noauto,noatime 0 0
LABEL=TEST_HOME /mnt/TEST_home ext4 noauto,users,noatime 0 0
UUID=B248-1CCA /mnt/TEST_boot vfat noauto,users,rw,noatime 0 0
UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5 /mnt/TEST_res ext4 noauto,users,rw,noatime 0 0
~~~

Partitions listed in fstab can be mounted with their \<file system\> identifier or with the \<mount point\>.

~~~
$ mount UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5
    or
$ mount /mnt/TEST_res
    or
$ mount LABEL=TEST_HOME
~~~

### Adjusting the fstab

If you want the ability to use newly created partitions (let's take sda5 and sdb7 as examples) that do not appear in fstab or cannot be mounted with the previously mentioned commands, type the following command into the console as **user**:

~~~
$ ls -l /dev/disk/by-uuid
~~~

It will print something similar to this:

~~~
lrwxrwx 1 root root 10 May 29 17:51 1c257cff-1c96-4c4f-811f-46a87bcf6abb -> ../../sda2
lrwxrwxrwx 1 root root 10 May 29 17:51 2e3a21ef-b98b-4d53-af62-cbf9666c1256 -> ../../sda1
lrwxrwxrwx 1 root root 10 May 29 17:51 2ef32215-d545-4e12-bc00-d0099a218970 -> ../../sda5
lrwxrwxrwx 1 root root 10 May 29 17:51 35336532-0cc8-4613-9b1a-f31b12ea58c3 -> ../../sda4
lrwxrwxrwx 1 root root 10 May 29 17:51 4c4b9246-2904-40d1-addc-724fc90a2b6a -> ../../sdb3
lrwxrwxrwx 1 root root 10 May 29 17:51 a7aeabe9-f09d-43b5-bb12-878b4c3d98c5 -> ../../sdb7
lrwxrwxrwx 1 root root 10 May 29 17:51 B248-1CCA -> ../../sdb1
lrwxrwxrwx 1 root root 10 May 29 17:51 d5b01bbc-700c-43ce-a382-1ba95a59de78 -> ../../sdb6
lrwxrwxrwx 1 root root 10 May 29 17:51 e2164479-3f71-4216-a4d4-af3321750322 -> ../../sdb5
lrwxrwx 1 root root 10 May 29 17:51 f5ed412d-7b7b-41c1-80ce-53337c82405b -> ../../sdb2
~~~

In this example,  
**`2ef32215-d545-4e12-bc00-d0099a218970`** is the missing entry for sda5 and  
**`a7aeabe9-f09d-43b5-bb12-878b4c3d98c5`** is the missing entry for sdb7.

The next step is to add the UUID partitions to */etc/fstab*. To achieve this, use a text editor (like *mcedit*, *kate*, *kwrite* or *gedit*) with **root** privileges. In this example, the entry would look like this:

~~~
# <file system> <mount point> <type> <options> <dump><pass>    
UUID=2ef32215-d545-4e12-bc00-d0099a218970 /media/disk1part5 ext4 auto,users,exec 0 2
UUID=a7aeabe9-f09d-43b5-bb12-878b4c3d98c5 /media/disk2part7 ext4 auto,users,exec 0 2
~~~

### Creation of new mount points
  
**Note:**
A mount point that is specified in fstab must be associated with an existing directory. During the live session, these directories are created by siduction in **/media** and have the naming scheme **diskXpartX**.

Now, if the partition table was changed after the installation and fstab was adjusted (for example, two new partitions were created), no mount point exists yet. It must be created manually.

**Example**  
First, become **root** and determine the existing mount points:

~~~
cd /media
ls
~~~

The output shows for example:

~~~
disk1part1 disk1part3 disk2part1
~~~

The mount points of the new partitions are now created in the **/media** directory:

~~~
mkdir disk1part5
mkdir disk2part7
~~~

Thus, the new partitions can be used or tested immediately:

~~~
mount /media/disk1part5
mount /media/disk2part7
~~~

After a reboot, the new file systems are mounted automatically if *auto* or *defaults* is entered in the fstab under \<options\>. See also:

~~~
man mount
~~~

Of course, you don't have to follow the naming scheme *'diskXpartX'*. Mount points and their associated identifiers in fstab can be assigned meaningful names, for example, *'data'* or *'music'*.

<div id="rev">Last edited: 2022/01/16</div>
