<div id="main-page"></div>
<div class="divider" id="part-lvm"></div>
## LVM partitioning - Logical Volume Manager

**`This is a basic guide to get you started. It is your responsibilty to learn more about LVM. Sources and Resources are linked at the bottom of this page which will be of help, however the list is definitely not exhaustive.`** 

Applicable for siduction-onestepbeyond.iso forward.

Logical volumes can span multiple disks and are scalable, unlike the traditional method of partitioning hard drives. 

However, whether it be the traditional method of partitioning or partitioning to use LVM, partitioning is not something you do very often, thus it requires deep thought, along with trial and error, before you will be happy with the outcome you desire.

There are 3 basic terms of of terminology you will need to know:

+ `Physical Volumes:`  These are your physical disks, or disk partitions, such as /dev/sda or /dev/sdb1. These are what you would be used to using when mounting/unmounting things. Using LVM we can combine multiple physical volumes into volume groups.   
+ `Volume Groups:`  A volume group is comprised of real physical volumes, and is the storage used to create logical volumes which you can create/resize/remove and use. You can consider a volume group like a "virtual disk" assembled from physical volumes. You can slice it up into "virtual partitions" which are logical volumes.  
+ `Logical Volumes:`  Logical volumes are the volumes that you will ultimately end up mounting upon your system. They can be added, removed, and resized on the fly. Since these are contained in the volume groups they can be bigger than any single physical volume you might have. (i.e. 4 x 250GB drives can be combined into one 1TB volume group, then split create 2 x 500GB logical volumes.)  

### There are 6 basic steps required

`The assumption for the following example is based upon new unpartitioned disks or where a new partitioning scheme is required, which will delete all existing data on the partitions you wish to convert to an LVM.` 

Using cfdisk or fdisk is required, as to date Gparted and KDE Partition Manager, (partitionmanager), do not support LVM partitioning.

`Step 1:`  Create the partition table:

~~~  
cfdisk /dev/sda  
n to create a new partition on the disk  
p to make this the primary partition  
1 to give the partition the number 1 as an identifier  
`### size allocation  ### Set first and last cylinders to the default values (press enter) to span the entire drive  
t toggle the type of partition to create  
8e is the hex code for a Linux LVM  
W to write your changes to the disk. ##This will write the partition table. If you have realised that you made a mistake at this point, you could restore the old partition layout and your data will be fine.##  
~~~

Should you want the volume to span 2 or more disks, repeat this process on each of the disks.

`Step 2:`  Setup the partition as a Physical Volume. This will delete any data:

~~~  
pvcreate /dev/sda1  
~~~

Repeat the process on any other partitions as required.

`Step 3:`  Create the Volume Group:

~~~  
vgcreate vulcan /dev/sda1  
~~~

Should you wish to span 3 disks, for example, you include the other disks in the vgcreate command:

~~~  
vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1  
~~~

If you have done this correctly you'll be able to see the result in the output of:

~~~  
vgscan  
~~~

vgdisplay will give you the `size`  properties:

~~~  
vgdisplay vulcan  
~~~

`Step 4:`  Creating the Logical Volume. Now it is time for you to decide how big you want the logical volume to be initially. One advantage of LVM is that you can adjust the size of the volume on at will without needing to reboot.

Lets assume that you initially want a 300GB volume called spock within the lvm called vulcan:

~~~  
lvcreate -n spock --size 300g vulcan  
~~~

`Step 5:`  Format the volume and be patient while it is formating , it could take a while:

~~~  
mkfs.ext4 /dev/vulcan/spock  
~~~

`Step 6:` 

~~~  
mkdir /media/spock/  
~~~

Edit fstab with your favorite editor to mount the volume during boot up. 

~~~  
mcedit /etc/fstab  
~~~

Using `/dev/vulcan/spock`  is better than using UUID numbers with LVM, as then you can clone the filesystem and not have to worry about potential UUID collisions, especially with LVM, as you can end up with multiple filesystems with the same UUID number (snapshots being a prime example).

~~~  
/dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2  
~~~

`Optional:`  Change the owner of the volume so that other users have read/write access to the LVM:

~~~  
chown root:users /media/spock  
~~~

~~~  
chmod 775 /media/spock  
~~~

Your basic LVM should now be set up.

### Resizing the volume

`It is highly recommended that you use a live ISO to change the partition sizes. Whilst growing the partition 'on the fly' may be error free, the same can not be said when reducing the volume, as anomalies will cause data loss, particularly if **`/ (root)`**  or **`/home`**  are involved.` 

##### To resize the volume from 300GB to 500GB, as used in this example:

~~~  
umount /media/spock/  
~~~

~~~  
lvextend -L+200g /dev/vulcan/spock  
~~~

Then run the command for the filesystem to be resized:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### To resize the volume from 300GB down to 280GB, as used in this example:

~~~  
umount /media/spock/  
~~~

Then run the command for the filesystem to be resized:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock 280g  
~~~

Then resize the volume

~~~  
lvreduce -L-220g /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### An LVM GUI

`system-config-lvm`  provides a GUI and is available to help you manage your LVMs which is started from the command line as root:

~~~  
apt-get install system-config-lvm  
~~~

~~~  
system-config-lvm2  
~~~

~~~  
man system-config-lvm `# required reading   
~~~

##### Sources and Resources:

+  [Debian Administration - A simple introduction to working with LVM](http://www.debian-administration.org/articles/410)   
+  [IBM - Logical volume management](http://www.ibm.com/developerworks/linux/library/l-lvm2/)   
+  [IBM - Resizing Linux partitions, Part 2: Advanced resizing](http://www.ibm.com/developerworks/linux/library/l-resizing-partitions-2/index.html)   
+   [Red Hat - LVM Administrator's Guide](http://docs.google.com/viewer?a=v&amp;q=cache:1RMpacheCBcJ:www.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/5.4/pdf/Logical_Volume_Manager_Administration.pdf+%22Logical+Volume+Manager+Administration+%22&amp;hl=en&amp;pid=bl&amp;srcid=ADGEEShRiptIjzsnPNsCs4RgyUFNWkYcrDc3SkBSD6cTq39D6wye5JM3tP_ehcn37I5VWs84I_HI45rvG-n6YG4R2fE8hqDByq-KPhNEkha4zwphrR7QIUVnUz6omwY85e-ZEXX723Js&amp;sig=AHIEtbSJyxEst6Wue7_1_TeDYwB480azEw)   
+   [Logical Volume Manager (Linux)](http://en.wikipedia.org/wiki/Logical_Volume_Manager_%28Linux%29)   
+   [Setting up an LVM for Storage](http://thelinuxexperiment.com/guinea-pigs/jon-f/setting-up-an-lvm-for-storage/)   
+   [Creating a LVM in Linux](http://linuxhelp.blogspot.com/2005/04/creating-lvm-in-linux.html)   
+   [Linux lvm - Logical Volume Manager](http://www.linuxconfig.org/Linux_lvm_-_Logical_Volume_Manager)   

<div id="rev">Page last revised 15/01/2012 0900 UTC</div>
