% Logical Volume partitioning

## LVM partitioning - Logical Volume Manager

**The following is a basic introduction.** It is up to the esteemed reader to delve deeper into the subject. Please refer to the respective man page. Further sources of information can be found at the end of this text - the list does not claim to be complete.

Working with *Logical Volumes* is much easier than most users think. The best feature of LVM is that changes take effect without having to reboot the system. *Logical Volumes* can span multiple disks and are scalable. This distinguishes them from other methods of disk partitioning.

You should be familiar with three basic terms:

+ **Physical Volume [PV]:** This includes the physical, real-world disks or partitions such as **/dev/sda** or **/dev/sdb1** which are used for mounting/mounting. LVM can be used to combine multiple physical volumes into volume groups.

+ **Volume Group [VG]:** A volume group consists of *physical volumes* and is the location of *logical volumes*. A Volume Group can be seen as a "virtual disk" composed of *physical volumes*. Here are some examples for better understanding:

  + Multiple storage devices (e.g. hard disks, SSDs, M2 disks, external USB drives, etc.) can be combined into a volume group (a virtual drive).

  + Multiple partitions of a storage device can be combined into one volume group (a virtual drive).

  + The two aforementioned options can be combined. For example, you could combine two complete SSDs with two partitions of a third SSD into a volume group.

+ **Logical Volume [LV]:** Logical volumes are created within a *volume group* and mounted to the system. You can also consider them "virtual" partitions. They are dynamically modifiable, can be resized, recreated, removed, and used. A logical volume can span multiple physical volumes within the volume group.

### Six steps to logical volumes

> **Caution**  
> We assume non-partitioned hard disks in our example. Note: If old partitions are deleted, all data will be irretrievably lost.

As partition editor, either cfdisk or gdisk must be used because currently neither GParted nor the KDE partition manager support the creation of *logical volumes*. See also the manual pages:  
[Partitioning with cfdisk (msdos-MBR)](0314-part-cfdisk_en.md#partitioning-with-fdisk)  
[Partitioning with gdisk (GPT-UEFI)](0313-part-gdisk_en.md#partitioning-with-gdisk)

All of the following commands and actions require **root** privileges.

1. Creating of a partition table

   ~~~
   cfdisk /dev/sda
   n  -> creates a new partition on the drive
   p  -> this partition becomes a primary partition
   1  -> the partition gets the number 1
         as identification "size allocation" sets the
         first and last cylinder to default values.
         Press ENTER to span the whole drive
   t  -> selects the partition type to create
   8e -> the hex code for a Linux LVM
   W  -> writes changes to the drive
   ~~~

   The command **`W`** writes the partitioning table. If a mistake was made up to this point, the existing partitioning layout can be restored. For this purpose, enter the command **`q`** for `cfdisk` to exit without writing, and everything remains as it has been before.

   If the volume group is to span more than one physical volume (disk), the above operation must be performed on each physical volume.

2. Creating a physical volume [PV]

   ~~~
   pvcreate /dev/sda1
   ~~~

   The command creates the PV on the first partition of the first hard disk.  
   This process is to be repeated on each partition as needed.

3. Creating a volume group [VG]

   Now we add three PV (/dev/sda1 /dev/sdb1 /dev/sdc1) to a VG named *vulcan*:

   ~~~
   vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1
   ~~~

   If this step has been performed correctly, the result can be seen in the output of the following command:

   ~~~
   vgscan
   ~~~

   `vgdisplay` displays the size with:

   ~~~
   vgdisplay vulcan
   ~~~

4. Creating a logical volume [LV]

   At this point you have to decide how big the LV should be at the beginning. One advantage of LVM is the ability to adjust the size without rebooting.

   In our example, we want a 300GB LV named *spock* inside the VG named *vulcan*:

   ~~~
   lvcreate -n spock --size 300g vulcan
   ~~~

5. Formatting the LV

   Please be patient, this process may take some time:

   ~~~
   mkfs.ext4 /dev/vulcan/spock
   ~~~

6. Mounting the LV

   Create the mount point with

   ~~~
   mkdir /media/spock/
   ~~~

   
   Using *"/dev/vulcan/spock"* is preferable to using UUID numbers with an LVM because it makes it easier to clone the file system (no UUID collisions). An LVM allows to create file systems with identical UUID numbers (classic example: snapshots).
   To mount the LV during the boot process, `fstab` must be customized with a text editor:  

   ~~~
   mcedit /etc/fstab
   ~~~

   Then insert the following line according to our example:

   ~~~
   /dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2
   ~~~

   Optional:  
   The owner of the LV can be changed so that other users have read/write access:
   ~~~
   chown root:users /media/spock
   chmod 775 /media/spock
   ~~~

We can now repeat steps 4 to 6 for the new LV *kirk* to be created.

A simple LVM should now be usable.

### Resizing a volume

> Caution  
> Always make a data backup first.

We recommend using a live ISO to resize a LV. Although increasing the LV size of the running system can be done without error, decreasing the size of a LV cannot. Anomalies can lead to data loss, especially if the `/` (root) or `/home` directories are affected.

**Example of an enlargement**

The LV *spock* is to be enlarged from 300GB to 500GB.  
We first check whether there is enough free memory.  
`vgdisplay` provides information.

~~~
vgdisplay vulcan
[...]
Free PE / Size      170890 / 667,50 GiB
[...]
~~~

There is enough free storage space for our project.  
We can start working.  
Unmounting the LV:

~~~
umount /media/spock/
~~~

> Caution  
> Never unmount your root file system during operation.

Extend the LV and its file system:

~~~
lvextend -L+200g --resizefs /dev/vulcan/spock
~~~

The `lvextend` command needs to be given the size **difference** as an option, not the total size desired.  
The file system is then first checked with the option *"--resizefs "* and then adapted to the new size of the LV.

Finally, we mount the LV again.

~~~
mount /media/spock
~~~

The enlargement of an LV, even for the `/` (root) file system, is also possible during operation. Only the two commands `unmount` and `mount` are omitted. However, no file system check is then carried out.

If you want to check the root file system, use the kernel command line parameter `fsck.mode=force` during the boot process.

**Example of a downsizing**

The LV *spock* is downsized from 500GB to 280GB:

~~~
umount /media/spock/
~~~

Reduce the size of the file system:

~~~
e2fsck -f /dev/vulcan/spock
resize2fs /dev/vulcan/spock 280g
~~~

After that, the LV is changed.

~~~
lvreduce -L-220g /dev/vulcan/spock
resize2fs /dev/vulcan/spock
mount /media/spock
~~~

Again, the `lvreduce` command must be given the size **difference** as an option.  
The `resize2sf` command resizes the file system exactly to the LV size.

### Manage LVM with a GUI program

*Gparted* offers the possibility to manage already created *logical volumes*. The program needs to be executed as **root**.

### More info

[Logical Volume Manager - Wikipedia](https://wikipedia.org/wiki/Logical_Volume_Manager)  
[Working with logical volumes #1](https://thelinuxexperiment.com/working-with-logical-volumes-part-1/)  
[Working with logical volumes #2](https://thelinuxexperiment.com/working-with-logical-volumes-part-2/)  
[Working with logical volumes #3](https://thelinuxexperiment.com/working-with-logical-volumes-part-3/)

<div id="rev">Last edited: 2023/12/12</div>
