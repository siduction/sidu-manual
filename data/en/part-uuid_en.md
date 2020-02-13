<div id="main-page"></div>
<div class="divider" id="uuid"></div>
## Rebuilding fstab and creating mount points

`By default siduction uses uuid in your fstab when you install.`

To show a newly created partition (say sda6 or sdb7), that does not appear in fstab or want to be mounted, in a terminal, (konsole), as user ($), type the following command:

~~~  
ls -l /dev/disk/by-uuid  
~~~

It will output like this (bold is for example purposes only):

~~~  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 348ea9e6-7879-4332-8d7a-915507574a80 -> ../../sda4  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 610aaaeb-a65e-4269-9714-b26a1388a106 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 857c5e63-c9be-4080-b4c2-72d606435051 -> ../../sda5  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 a83b8ede-a9df-4df6-bfc7-02b8b7a5f1f2 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42  ad662d33-6934-459c-a128-bdf0393e0f44  -> ../../sda6  
~~~

In this example  **ad662d33-6934-459c-a128-bdf0393e0f44**  is the missing entry. The next step is to enter the UUID partition to /etc/fstab. To add it to your fstab file use a text editor (like kate or kwrite) with root privileges:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=ad662d33-6934-459c-a128-bdf0393e0f44  /media/disk1part6 ext4 auto,users,exec 0 2    
~~~
  
Another example:

~~~  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 30ebb8eb-8f22-460c-b8dd-59140274829d -> ../../sdb8  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 387d6d4b-4508-4b8e-8ed2-76998f41dae4 -> ../../sdb1  
rwxrwxrwx 1 root root 10 2007-05-28 13:18 7014f66f-6cdf-4fe1-83da-9cab7b6fab1a -> ../../sdb5  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 8f042ead-259f-4df0-98ec-3343080396c5 -> ../../sdb6  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 94B0AE63B0AE4B94 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 A61820AA18207B85 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f28725d6-b7b5-4207-8476-36efe1a903ce -> ../../sdb9  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f855c263-2521-48d3-8ec9-d2d2b69b6635 -> ../../sda3  
rwxrwxrwx 1 root root 10 2007-05-28 13:18  f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  -> ../../sdb7  
~~~

In this case  **f9aa4027-ecdd-4a86-84e2-df2ef73fe14e**  is the missing entry and is added to /etc/fstab:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  /media/disk2part7 ext4 auto,users,exec 0 2    
~~~
  
### Creating new mount points
  
 `Note:`  A mount point name, as noted in fstab, needs to have an existing directory. siduction creates these directories during the installation process under `/media`  and they are named `diskXpartX` .

If you have manipulated the partition table after the initial installation and assuming you have already altered fstab, (for example, 2 new partitions have been created), the directory for each mount point will not exist and it needs to be manually created.

##### Example:

First, as root, confirm the existing mount points:

~~~  
cd /media  
ls  
~~~

It should return the existing mount points, for example:

~~~  
disk1part1 disk1part3 disk2part1  
~~~

Staying in /media, create the mount points of the new partitions:

~~~  
mkdir disk1part6  
mkdir disk2part7  
~~~

To test or use partitions immediately:

~~~  
mount /dev/sda6 /media/disk1part6  
mount /dev/sda6 /media/disk2part7  
~~~

Upon a reboot of the computer the filesystems will be mounted automatically. Read:

Of course you do not have to stick to the naming scheme `diskXpartX` . You can name your mountpoints (and according fstab entries) with meaningfull names like 'data' or 'music'.</i>

~~~  
man mount  
~~~

<div class="divider" id="uuid-fstab"></div>
## Overview: UUID, Partition Labelling and fstab

Persistent block device naming has been made possible by the introduction of udev and has some advantages over bus-based naming.

While Linux distributions and udev are evolving and hardware detection is becoming more reliable, there are also a number of new problems and changes:  
 **1)**  If you have more than one sata/scsi or ide disk controller and the order in which they are added is random, then this may result in device names like hdX and hdY switching around randomly on each boot. The same goes for sdX and sdY. Persistent naming allows you not to worry about this at all.  
 **2)**  Since the introduction of the new libata pata support a while ago, all your ide hdX devices are named sdX. Again, with persistent naming, you won't even notice.  
 **3)**  Machines with both sata and ide controllers are quite common these days. With the libata changes mentioned above, the first problem became even more common, as sata and ide hard drives now both have sdX names.

`By default siduction will use uuid in your fstab when you install.`

## The four different schemes for persistent naming:

#### 1. Persistent Naming by UUID

UUID stands for Universally Unique Identifier and is a mechanism to give each filesystem a unique identifier. It is designed so that collisions are unlikely. All Linux filesystems (including swap) support UUID. FAT and NTFS filesystems don't support UUID, but are still listed in by-uuid with a unique identifier:

~~~  
$ /bin/ls -lF /dev/disk/by-uuid/  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 2d781b26-0285-421a-b9d0-d4a0d3b55680 -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 31f8eb0d-612b-4805-835e-0e6d8b8c5591 -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 3FC2-3DDB -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 5090093f-e023-4a93-b2b6-8a9568dd23dc -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 912c7844-5430-4eea-b55c-e23f8959a8ee -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 B0DC1977DC193954 -> ../../sdb1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 bae98338-ec29-4beb-aacf-107e44599b2e -> ../../sdb2  
~~~

As you can see, the fat and ntfs partitions have shorter names (sda6 and sdb1), but are still listed by uuid.

#### 2. Persistent Naming by LABEL

Almost every filesystem type can have a label. All your partitions that have one are listed in the /dev/disk/by-label directory:

~~~  
$ ls -lF /dev/disk/by-label  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data2 -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 fat -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1  
~~~

While labels may have recognisable names, you need to exercise extreme caution to negate name collisions.

You can change the labels of your filesystems using these commands:

~~~  
* swap: Create a new swapspace like this: mkswap -L <label> /dev/XXX  
* ext2/ext3/ext4: e2label /dev/XXX <label>  
* jfs: jfs_tune -L <label> /dev/XXX  
* xfs: xfs_admin -L <label> /dev/XXX  
* fat/vfat: There is no tool to change the label using Linux,  
but when you create the filesystem, use mkdosfs -n <label> <other options>.  
You may also change the label of an existing filesystem using Windows.  
* ntfs: ntfslabel /dev/XXX <label> or change it using Windows.  
~~~

`Be careful: The labels have to be unique to make this work", it applies equally to USB/firewire sticks and to harddisks. The LABEL=/ UUID= syntax is preferred over /dev/disk/by-*/ for UN*X partitions`

#### 3. Persistent Naming by id 

by-id creates a unique name depending on the hardware serial number.

#### 4. Persistent Naming by path

by-path creates a unique name depending on the shortest physical path (according to sysfs). Both contain strings to indicate which subsystem they belong to and thus are not suitable for solving the problems mentioned in the beginning of this article. They won't be discussed any further here.

#### Enabling persistent naming

Having chosen which naming method you'd like to use, let's now enable persistent naming for your system:

#### In fstab

Enabling persistent naming in /etc/fstab is easy; just replace the device name in the first column by the new persistent name. In my example I would replace /dev/sda7 by one of the following:

~~~  
/dev/disk/by-label/home or  
/dev/disk/by-uuid/31f8eb0d-612b-4805-835e-0e6d8b8c5591  
~~~

Do so for all the partitions in your fstab file.

Instead of giving the device explicitly, one may indicate the filesystem that is to be mounted by its UUID or volume label, writing LABEL=&lt;label&gt; or UUID=&lt;uuid&gt;, for example:

~~~  
LABEL=Boot  
 or

  
~~~

~~~  
UUID=3e6be9de-8139-11d1-9106-a43f08d823a6  
~~~

Source:  [wiki.archlinux.org](http://wiki.archlinux.org/index.php/Persistent_block_device_naming)  who used  [marc.theaimsgroup.com](http://marc.theaimsgroup.com/?l=linux-hotplug-devel&amp;m=114795097514527&amp;w=2)  Content from wiki.archlinux.org available under GNU Free Documentation License 1.2 and has been re-edited for siduction-manuals

 [There is more on labeling here at debian-ressources](http://debian-resources.org/node/9/)  

<div id="rev">Content last revised 15/01/2012 1100 UTC</div>
