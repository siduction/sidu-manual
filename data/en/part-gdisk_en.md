<div id="main-page"></div>
<div class="divider" id="gdisk-1"></div>
## GPT gdisk partitioning overview

GPT gdisk, Globally Unique Identifier (GUID) Partition Table (GPT), is a tool to partition hard drives of any size `and required for disks that are greater than 2 TB in size` . By default, gdisk will make sure your partitions are well aligned for SSDs, (or hard drives that do not actually have 512 byte sectors).

The crucial advantage of GPT is that GPT alleviates the need to rely on primary, extended or logical partitions that are inherent to MBR for partitioning. GPT can support almost an unlimited number of partitions and is only limited by the amount of space reserved for partition entries in the GPT disk. Note though that the `gdisk`  tool defaults 128 partitions.

However, using GPT on small USB/SSD sticks, (for example an 8GB stick), could be counter productive if you need to transfer data from one computer to another, or, from one OS to another OS.

<!--**`NOTE : USB booting is not supported with GPT.`** 

-->
### Important Notes

`The terms UEFI and EFI are interchangeable and mean the same concept.` 

##### GPT data disks

`Some operating systems can not support GPT data disks, please refer to the respective operating system documentation.` 

GPT data disks are applicable for 32 and 64 bit machines under Linux.

##### Booting GPT disks

Dual and triple booting GPT disks with Linux, BSD and Apple are supported using `EFI`  mode in 64 bit.

Dual booting GPT disks with both Linux and MS Windows is possible, provided that your MS Windows OS can boot GPT disks in `UEFI`  mode in 64 bit,.

##### GUI partitioning tools to use GPT

Aside from the terminal based gdisk, GUI tools like 'gparted' and 'partitionmanager' do provide a GUI interface supporting GPT disks. Having stated that, gdisk should be your preferred tool to help prevent unintentional GUI anomalies. However 'Gparted - gparted' along with 'KDE Partition Manager - partitionmanager', (amongst others), are great tools to give you a visual depiction of what you actioned in gdisk.

`Mandatory reading before proceeding any further:`

+ ~~~    
   man gdisk    
   ~~~
  
+  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/)   
+  [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table)   

<div class="divider" id="gdisk-2"></div>
## Partitioning your HD using gdisk for a Linux system

###### Understanding key gdisk commands such as **`m`**  to bring you back to the main menu, **`d`**  ,**`n`** , **`p`**  and **`t`** , amongst others, will in the main, become core commands regarding your gdisk partitioning requirements, and it is worthwhile to explore gdisk on a 'test' disk.

##### **`IMPORTANT NOTE about the n command:`** 

<!--###### After creating the first partition you need to press `< Enter > 2 times`  each time you use **`n`**  to bring up the last sector to set the size of the subsequent partitions.-->

When using the **`n`**  command, you press &lt;Enter&gt; to give the partition the next free number and you then you need to press &lt;Enter&gt; again to accept the default start sector for the next partition before setting the size you need for the last sector. For example:

~~~  
Command (? for help): n  
Partition number (2-128, default 2): 2  
First sector (34-15728606, default = 411648 ) or {+-}size{KMGTP}:  
Last sector (411648 -15728606, default = 15728606) or {+-}size{KMGTP}: +6144M  
~~~

### Example of partitioning a GPT disk

 *Scale to suit your requirements* :

1. Creating a bootloader partition, `(assuming the disk is not a pure data disk and it needs to be bootable)`   
2. Creating a swap partition, `(assuming the disk is not a pure data disk and it needs to be bootable)`   
3. Creating linux partitions   
4. Creating other data partitions   

**`NOTE: The following example uses a USB stick to demonstrate the steps required. and thus it is not exhaustive.`** 

### The Steps

If you are not sure of the name of the disk, use fdisk to acertain the name, (root privileges are required for all partitioning and formatting commands):

~~~  
fdisk -l  
~~~

fdisk will give you the path required and possibly include other partition names within the disk, however you need to look for the actual disk path, irrespective of partitions that may exist on the disk. For example, assume that it is `sdb`  and start gdisk with the path to disk:

~~~  
gdisk /dev/sdb  
~~~

`The initial output is a warning if the disk is not a new disk or a disk already using GPT:` 

~~~  
GPT fdisk (gdisk) version 0.7.2  
Partition table scan:  
MBR: MBR only  
BSD: not present  
APM: not present  
GPT: not present  
***************************************************************  
Found invalid GPT and valid MBR; converting MBR to GPT format.  
THIS OPERATION IS POTENTIALLY DESTRUCTIVE! Exit by typing 'q' if  
you don't want to convert your MBR partitions to GPT format!  
***************************************************************  
Command (? for help):  
~~~

When starting `gdisk`  on a disk with existing MBR partitions and no GPT, the program displays a message surrounded by asterisks about converting the existing partitions to GPT. `This is intended to scare you away if you launch gdisk on the wrong disk by accident or if you don't know what you're doing. You must explicitly respond to this warning before proceeding. This is a deliberate message to keep you from accidentally damaging your boot disks.` 

Type **`?`**  and you will see a list of available commands, (the `coloured`  commands are for documentation purposes):

~~~  
Command (? for help): **`?`**   
b back up GPT data to a file  
c change a partition's name  
d delete a partition  
i show detailed information on a partition  
l list known partition types  
n add a new partition  
o create a new empty GUID partition table (GPT)  
p print the partition table  
q quit without saving changes  
r recovery and transformation options (experts only)  
s sort partitions  
t change a partition's type code  
v verify disk  
w write table to disk and exit  
x extra functionality (experts only)  
? print this menu  
~~~

To verify that you're working on the disk you think you're working type **`p`** .

~~~  
Command (? for help): p   
Disk /dev/sdb: 16547840 sectors, 7.9 GiB This example is using an 8GB stck   
Logical sector size: 512 bytes  
Disk identifier (GUID): 0267952D-9B06-4B10-A648-B83684786910  
Partition table holds up to 128 entries  
First usable sector is 34, last usable sector is 16547806  
Partitions will be aligned on 2048-sector boundaries  
Total free space is 16547773 sectors (7.9 GiB)  
Number Start (sector) End (sector) Size Code Name  
~~~

The `Code`  column of the output shows the partition type code and the `Name`  column displays a free-form text string that you can modify.

### Deleting the partition table

You now need to delete the entire partition table on the disk to be able to set up GPT partitioning:

~~~  
command (? for help): d   
~~~

<!--If there are multiple partitions gdisk will ask you to type a number representing the partitions you wish to delete.

-->
<div class="divider" id="gdisk-3"></div>
## To GPT-EFI Boot or GPT-BIOS Boot

Should booting a GPT disk be a requirement, there are 2 options to format the boot sector of a GPT disk.

The options are:

+ `Your machine is (U)EFI aware via the BIOS and turned on, and selected to be bootable.`   
+ You wish to use EFI to boot a GPT disk formatted disk  

**`or`** 

+ Your machine is **`not`**  (U)EFI aware via the BIOS  
+ You wish to use the BIOS to boot a GPT formatted disk  

### EFI booting 

**`The BIOS needs to be EFI capable, and turned on, and selected to be bootable.`**  

If you are going to boot using EFI you must have a FAT formatted EFI System Partition (type `EF00` ) as the first partition. This partition will contain your bootloader(s). When you install it will ignore any "where to boot from" choices in install-gui and an siduction bootloader will be installed on the EFI System Partition under `/efi/siduction` . The EFI System partition will also be mounted as `/boot/efi`  as long as you leave the "mount other partitions" option selected, you do not need to tell the installer to mount this partition.

<!--**`NOTE: USB booting is not supported with GPT.`** 

-->
#### Creating the EFI bootloader partition

Type **`n`**  to add a new partition and `+200M`  to give the bootloader a size.

~~~  
Command (? for help): n   
Partition number (1-128, default 1): 1   
~~~

~~~  
First sector (34-16547806, default = 34) or {+-}size{KMGTP}:  
Information: Moved requested sector from 34 to 2048 in  
order to align on 2048-sector boundaries.  
Use 'l' on the experts' menu to adjust alignment  
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M   
Current type is 'Linux filesystem'  
~~~

 By typing **`L`**  a list of codes will be presented:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): L   
0700 Microsoft basic data 0c01 Microsoft reserved 2700 Windows RE  
4200 Windows LDM data 4201 Windows LDM metadata 7501 IBM GPFS  
7f00 ChromeOS kernel 7f01 ChromeOS root 7f02 ChromeOS reserved  
8200 Linux swap 8300 Linux filesystem 8301 Linux reserved  
8e00 Linux LVM a500 FreeBSD disklabel a501 FreeBSD boot  
a502 FreeBSD swap a503 FreeBSD UFS a504 FreeBSD ZFS  
a505 FreeBSD Vinum/RAID a800 Apple UFS a901 NetBSD swap  
a902 NetBSD FFS a903 NetBSD LFS a904 NetBSD concatenated  
a905 NetBSD encrypted a906 NetBSD RAID ab00 Apple boot  
af00 Apple HFS/HFS+ af01 Apple RAID af02 Apple RAID offline  
af03 Apple label af04 AppleTV recovery be00 Solaris boot  
bf00 Solaris root bf01 Solaris /usr & Mac Z bf02 Solaris swap  
bf03 Solaris backup bf04 Solaris /var bf05 Solaris /home  
bf06 Solaris alternate se bf07 Solaris Reserved 1 bf08 Solaris Reserved 2  
bf09 Solaris Reserved 3 bf0a Solaris Reserved 4 bf0b Solaris Reserved 5  
c001 HP-UX data c002 HP-UX service ef00 EFI System   
ef01 MBR partition scheme ef02 BIOS boot partition fd00 Linux RAID  
~~~

Enter `ef00`  to make it a UEFI partition:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): ef00   
Changed system type of partition to 'EFI System'  
~~~

### BIOS Boot partition

#### Creating a BIOS boot partition

If your system does not support UEFI, you can make a BIOS boot partition, as it replaces the sector of disk on a DOS partitioned drive that lives between the partition table and the first partition where grub is written directly.

Type **`n`**  to add a new partition and `+200M`  to give the bootloader a size. (The reason to make it +200M,compared with conventional thinking of +32M, is to have in place an EFI sized partition should you ever need to change the disk to EFI booting).

~~~  
Command (? for help): n   
Partition number (1-128, default 1): 1   
~~~

~~~  
First sector (34-16547806, default = 34) or {+-}size{KMGTP}:  
Information: Moved requested sector from 34 to 2048 in  
order to align on 2048-sector boundaries.  
Use 'l' on the experts' menu to adjust alignment  
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M   
Current type is 'Linux filesystem'  
~~~

Enter `ef02`  to make it a BIOS boot partition:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): ef02   
Changed system type of partition to 'BIOS boot'  
~~~

**`Important Note: The Boot BIOS partition is not to be formatted`** 

<div class="divider" id="gdisk-4"></div>
### Creating the swap partition

The allocation of a swap partition should never be underestimated, particularly for laptops and notebooks, as laptops and notebooks need to have the ability to suspend to disk, if required. It should at least equal your RAM.

Type **`n`**  to add a new partition and `+2G` , (or, `+2048M` ) to give the swap partition a size witha type code of `8200` . An example of this would look like this:

~~~  
Command (? for help): n   
Partition number (2-128, default 2): 2   
First sector (34-15728606, default = 411648) or {+-}size{KMGTP}:  
Last sector (411648-15728606, default = 15728606) or {+-}size{KMGTP}: **`+2048M   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 8200   
Changed type of partition to 'Linux swap  
~~~

<div class="divider" id="gdisk-5"></div>
### Creating the data partitions

Type **`n`**  to add a new partition and `XXXG`  to give the partition a size. In this example `+4G` :

~~~  
Partition number (3-128, default 3): 3   
First sector (34-15728606, default = 4605952) or {+-}size{KMGTP}:  
Last sector (4605952-15728606, default = 15728606) or {+-}size{KMGTP}: **`+4G   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 8300   
Changed type of partition to 'Linux filesystem  
~~~

`Repeat the same process for the other partitions according to your requirements.` 

As this example is a stick it may be wise to make an `Any OS Data`  partition, witha type code of `0700` , otherwise give it the code for a Linux filesystem (8300):

~~~  
Command (? for help): n   
Partition number (4-128, default 4): 4   
First sector (34-15728606, default = 12994560) or {+-}size{KMGTP}:  
Last sector (12994560-15728606, default = 15728606) or {+-}size{KMGTP}:**`+1300M   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 0700   
Changed type of partition to 'Microsoft basic data'  
~~~

To examine the partitions you have created:

~~~  
Command (? for help): p   
Disk /dev/sdx: 15728640 sectors, 7.5 GiB  
Logical sector size: 512 bytes  
Disk identifier (GUID): F409CFD3-6DDC-4551-BBC5-85DC218C1352  
Partition table holds up to 128 entries  
First usable sector is 34, last usable sector is 15728606  
Partitions will be aligned on 2048-sector boundaries  
Total free space is 73661 sectors (36.0 MiB)  
Number Start (sector) End (sector) Size Code Name  
1 2048 411647 200.0 MiB EF00 Boot  
2 411648 4605951 2.0 GiB 8200 Swap  
3 4605952 12994559 4.0 GiB 8300 Linux File System  
4 12994560 15656959 1.3 GiB 0700 Any OS Data  
~~~

To add a description of each partition use the **`c`**  command to describe each partitions purpose. For example:

~~~  
Command (? for help): c   
Partition number (1-4): 4   
Enter name: Descriptive name of your choosing   
~~~

The **`w`**  writes your changes to disk whilst **`q`**  command exits without saving your changes:

~~~  
Command (? for help): w   
Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING  
PARTITIONS!!  
Do you want to proceed? (Y/N): y   
OK; writing new GUID partition table (GPT).  
The operation has completed successfully.  
~~~

<div class="divider" id="gdisk-6"></div>
## Formatting the partitions

As gdisk creates partitions not filesystems, you will need to format each of your partions via the terminal. However you will need to know the names of the partitions so you can format each one correctly, therefore run:

~~~  
fdisk -l  
~~~

fdisk will give you the path required. Assuming that it is `sdb`  :

~~~  
gdisk /dev/sdb  
Command (? for help): p   
~~~

Now do **`q`**  to exit gdisk and be back at the **`#`**  root prompt, allowing you to enter the path for each partition number:

For the UEFI partition, **`(Do not format a BIOS Boot partition)`** :

~~~  
mkfs -t vfat /dev/sdb1  
~~~

For the Linux partition, `(The syntax for any other Linux partitions will of course change for each additiional Linux File System partitions, that is sdb4, sdb5, and counting` :

~~~  
mkfs -t ext4 /dev/sdb3  
~~~

For the 'Any OS Partition', `(possibly only required if a USB stick is required for cross platform interoperability)` :

~~~  
mkfs -t vfat /dev/sdb4  
~~~

Format the swap partition:

~~~  
mkswap /dev/sdb2  
~~~

Then:

~~~  
swapon /dev/sdb2  
~~~

Then check, if swap is recognized, by entering in console:

~~~  
swapon -s  
~~~

If swap is recognised correctly, enter

~~~  
swapoff -a  
~~~

These commands work just as they would on MBR partitions.

##### **`It is absolutely imperative to reboot so that the new partitioning and format scheme can be read by the kernel.`** 

After you have rebooted you are now ready to start installation to, or use, a GPT disk.

<div class="divider" id="gdisk-7"></div>
## Advanced gdisk commands

Before saving your changes, you may want to verify that there are no glaring problems with the GPT data structures. You can do this with the **`v`**  command:

~~~  
Command (? for help): v   
No problems found. 0 free sectors (0 bytes) available in 0  
segments, the largest of which is 0 sectors (0 bytes) in size  
~~~

In this case, every available byte on the disk is allocated to partitions and no problems were found. If free space were available for partition creation, you'd see how much was available. If gdisk found problems, such as overlapping partitions or mismatched main and backup partition tables, it would report them here. Of course, gdisk includes safeguards to ensure that you can't create such problems yourself. The v option's sanity checks are intended to help you spot problems that might result from data corruption.

If problems had been detected, you might be able to correct them using various options on the `recovery & transformation menu` , which is a second menu of options available by typing **`r`**  :

~~~  
Command (? for help): r   
recovery/transformation command (? for help): **`?`**   
b use backup GPT header (rebuilding main)  
c load backup partition table from disk (rebuilding main)  
d use main GPT header (rebuilding backup)  
e load main partition table from disk (rebuilding backup)  
f load MBR and build fresh GPT from it  
g convert GPT into MBR and exit  
h make hybrid MBR  
i show detailed information on a partition  
l load partition data from a backup file  
m return to main menu  
o print protective MBR data  
p print the partition table  
q quit without saving changes  
t transform BSD disklabel partition  
v verify disk  
w write table to disk and exit  
x extra functionality (experts only)  
? print this menu  
~~~

A third menu, the `experts menu` , can be accessed by typing **`x`**  in either the `main menu`  or the `recovery & transformation menu` .

~~~  
recovery/transformation command (? for help): x   
Expert command (? for help): **`?`**   
a set attributes  
c change partition GUID  
d display the sector alignment value  
e relocate backup data structures to the end of the disk  
g change disk GUID  
i show detailed information on a partition  
l set the sector alignment value  
m return to main menu  
n create a new protective MBR  
o print protective MBR data  
p print the partition table  
q quit without saving changes  
r recovery and transformation options (experts only)  
s resize partition table  
v verify disk  
w write table to disk and exit  
z zap (destroy) GPT data structures and exit  
? print this menu  
~~~

You can do some low-level editing, such as changing partition or disk GUIDs (**`c`**  and **`g`** , respectively). The **`z`**  option immediately destroys the GPT data structures, which you should do if you want to re-use a GPT disk using some other partitioning scheme. If these structures aren't erased, some partitioning tools can become confused by the apparent presence of two partitioning systems.

Generally speaking, the options on both the `recovery & transformation`  menu and the `experts`  menu should not be used by anything but GPT experts. Non-experts might be forced to use these menus if a disk is damaged, though. Before taking drastic actions, you should use the **`b`**  main-menu option to create a backup in a file, and store that file on a USB flash drive or some other place that's not on the disk you're modifying. That way, you'll be able to recover your orginal configuration if you damage your partitions.

###### Sources: 

  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/) 

  [Windows Hardware Developer Center](http://msdn.microsoft.com/en-us/windows/hardware/gg463525) 

<div class="divider" id="gdisk-8"></div>
## Dual booting with Linux and another OS - TBA

+ ~~~    
   man gdisk    
   ~~~
  
+  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/)   
+  [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table)   

<div id="rev">Content last revised 14/01/2012 1500 UTC</div>
