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
% "Logical Volume" partitioning

## LVM partitioning - Logical Volume Manager

**The following is a basic introduction. It is up to the esteemed reader to delve deeper into the matter. Further sources of information can be found at the end of this text - the list does not claim to be complete.

Working with *Logical Volumes* is much easier than most users think. The best feature of LVM is that changes take effect without having to reboot the system. *Logical Volumes* can span multiple disks and are scalable. This distinguishes them from other methods of disk partitioning.

You should be familiar with three basic terms:

+ **Physical Volume (Physical Volume):** These are the physical, real-world, disks or partitions such as /dev/sda or /dev/sdb1 and are used for mounting/mounting. LVM can be used to combine multiple physical volumes into volume groups.

+ **Volume Group:** A volume group consists of *physical volumes* and is the location of *logical volumes*. A Volume Group can be seen as a "virtual disk" composed of *Physical Volumes*. To understand, here are some examples:

  + Multiple storage devices (e.g. hard disks, SSDs, M2 disks, external USB disks, etc.) can be combined into a volume group (a virtual drive).

  + Multiple partitions of a storage device can be combined into one volume group (a virtual drive).

  + A combination of the two aforementioned options. E.g. three SSDs, of which only two partitions from the first one and the other two are completely combined in the volume group.

+ Logical volumes are created within a *volume group* and mounted on the system. One can understand them also as "virtual" partitions. They are dynamically modifiable, can be resized, recreated, removed and used. A logical volume can span multiple physical volumes within the volume group.

### Six steps to logical volumes

> **Caution  
> We assume non-partitioned hard disks in our example. Note: If old partitions are deleted, all data will be irretrievably lost.

As partitioning program cfdisk or gdisk are needed, because currently GParted or the KDE partition manager do not support the creation of *Logical Volumes*. See also the manual pages:  
[Partitioning with cfdisk (msdos-MBR)](0314-part-cfdisk_en.md#partitioning-with-fdisk)  
[Partition with gdisk (GPT-UEFI)](0313-part-gdisk_en.md#partition-with-gdisk)

All of the following commands and actions require root privileges.

1. creation of a partition table

   ~~~
   cfdisk /dev/sda
   n -> creates a new partition on the drive
   p -> this partition becomes a primary partition
   1 -> the partition gets the number 1 as identification
   ### size allocation ### sets the first and last cylinder to default values. Press ENTER to span the whole drive
   t -> selects the partition type to create
   8e -> the hex code for a Linux LVM
   W -> writes changes to the drive
   ~~~

   The command "W" writes the partitioning table. If a mistake was made up to this point, the existing partitioning layout can be restored. For this purpose, enter the command "q", *cfdisk* exits without writing, and everything remains as it was before.

   If the volume group is to span more than one physical volume (disk), the above operation must be performed on each physical volume.

2. creating a physical volume

   ~~~
   pvcreate /dev/sda1
   ~~~

   The command creates the physical volume on the first partition of the first hard disk.  
   This process is repeated on each partition as needed.

3. creating a volume group

   Now we add the physical volumes to a volume group named *vulcan* (three drives in our example):

   ~~~
   vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1
   ~~~

   If this step was performed correctly, the result can be seen in the output of the following command:

   ~~~
   vgscan
   ~~~

   vgdisplay displays the size with:

   ~~~
   vgdisplay vulcan
   ~~~

4. creation of a logical volume

   At this point you have to decide how big the logical volume should be at the beginning. One advantage of LVM is the ability to adjust the size without rebooting.

   In our example we want a 300GB volume named *spock* inside the volume group named vulcan:

   ~~~
   lvcreate -n spock --size 300g vulcan
   ~~~

5. format the logical volume.

   Please be patient, this process may take longer time.

   ~~~
   mkfs.ext4 /dev/vulcan/spock
   ~~~

6. mounting the logical volume

   Create the mount point with

   ~~~
   mkdir /media/spock/
   ~~~

   To mount the volume during the boot process, fstab must be customized with a text editor.  
   Using **/dev/vulcan/spock** is preferable to using UUID numbers with an LVM because it makes it easier to clone the file system (no UUID collisions). Especially with an LVM file systems with the same UUID number can be created (sample snapshots).

   ~~~
   mcedit /etc/fstab
   ~~~

   and then insert the following line according to our example.

   ~~~
   /dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2
   ~~~

   Optional:  
   The owner of the volume can be changed so that other users have read/write access to the logical volume:

   ~~~
   chown root:users /media/spock
   chmod 775 /media/spock
   ~~~

We can now repeat steps 4 to 6 for the new logical volume "kirk" to be created.

A simple LVM should now be created.

### Resizing a volume

We recommend using a live ISO to resize partitions. Although increasing the size of a partition of the running system can be done without error, decreasing the size of a partition cannot. Anomalies can lead to data loss, especially if the **/** (root) or **/home** directories are affected.

**Example of an enlargement**

A partition is to be enlarged from 300GB to 500GB:

~~~
umount /media/spock/
~~~

Extend the logical volume:

~~~
lvextend -L+200g /dev/vulcan/spock
~~~

To the *lvextend* command, specify the size**change** value as an option, not the total size desired.

Then resize the file system:  
The first command forcibly performs a check, even if the file system appears to be clean,  
the last command remounts the logical volume.

~~~
e2fsck -f /dev/vulcan/spock
resize2fs /dev/vulcan/spock
mount /media/spock
~~~

**Example of a resize**

A partition is resized from 500GB to 280GB:

~~~
umount /media/spock/
~~~

Reduce the size of the file system:

~~~
e2fsck -f /dev/vulcan/spock
resize2fs /dev/vulcan/spock 280g
~~~

After that, the logical volume is changed.

~~~
lvreduce -L-220g /dev/vulcan/spock
resize2fs /dev/vulcan/spock
mount /media/spock
~~~

Again, the *lvreduce* command must be given the resize** value as an option.  
The resize2sf* command resizes the file system exactly to the size of the logical volume.

### Manage LVM with a GUI program

*Gparted* offers the possibility to manage already created *Logical Volumes*. The program is executed as root.

### More info

+ [Logical Volume Manager - Wikipedia](https://de.wikipedia.org/wiki/Logical_Volume_Manager) (German)

+ [Working with logical volumes #1](https://thelinuxexperiment.com/working-with-logical-volumes-part-1/) (English)

+ [Working with logical volumes #2](https://thelinuxexperiment.com/working-with-logical-volumes-part-2/) (English)

+ [Working with logical volumes #3](https://thelinuxexperiment.com/working-with-logical-volumes-part-3/) (English)

+ [Resizing Linux partitions - part 2 (IBM)](https://developer.ibm.com/tutorials/l-resizing-partitions-2/) (English)

<div id="rev">Last edited: 2021-14-08</div>
