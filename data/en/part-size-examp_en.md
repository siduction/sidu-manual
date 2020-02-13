<div id="main-page"></div>
<div class="divider" id="part-example"></div>
## Partition Sizing and Examples

**`For normal use we recommend ext4, it is the default file system for siduction.`**

With the Partition-Manager  [GParted](part-gparted-en.htm#partition)  hard drives are partitioned and/or formatted. The progRAM has a graphical interface and is self-explanatory.

Gparted can also shrink or move partitions and also manipulate NTFS partitions [with a special caveat that once you alter an NTFS partition you must reboot immediately before doing any other operations].  [See full documentation for gparted](http://gparted.sourceforge.net/) . Changes to ntfs-partitions can also be made with proprietary tools such as Partition Magic&#8482; and Acronis&#8482;.

**` ALWAYS BACK-UP YOUR DATA!`**

Should a partition show up as mounted, unmount the device, including swap with a right click on the partition icons in gparted or via a terminal, for example:

~~~  
umount /dev/sda1  
~~~

The swap partiton can be unmounted in a terminal with: 

~~~  
swapoff -a  
~~~

In principle, 5 GB is more than sufficient for a hd-install, but you won't have much fun with this. A reasonable minimum install should have 12 GB. For those new to linux, we suggest only 2 partitions for a start (root/home and swap), because this simplifies your first install quite a bit, then establish extra partitions for a separate /home and additional data partitions.

You really should have a swap partition (equivalent to the windows swapfile, but is much more effective), if your device is a notebook that you want to suspend, or a desktop with little RAM (1 GByte or less) For normal usage, `the swap partition should be twice your RAM` . Devices with 4 GByte or more RAM or do not necessarily need swap.

For data-exchange with a Windows installation you should use vfat (fat32) or ext2 as a MS Windows™ driver is available for data-swapping. [XFS is not supported].  [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/)  and also  [Writing on NTFS partitions with ntfs-3g](part-gparted-en.htm#hd-ntfs3g) .

It is wise to write down the names of the partitions for reference.

##### Here are some simple examples for different partition sizes:

##### 1 TB for dual boot MS Windows and Linux

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 50 GB | NTFS | MS Windows System | 
| sdb1 | 100 GB | ext4 | / (includes home) | 
| sda3 | 300 GB | FAT32/ext2 | Data for MS Windows System and Linux | 

<td>550 GB</td>
<td>ext4</td>
<td>Data for Linux</td>
</tr>
<tr>
<td>sda4</td>
<td>2 GB</td>
<td>Linux Swap</td>
<td>Linux Swap</td>
</tr>
</tbody>

---

##### 120 GB hard drive with MS Windows, dual boot with Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 30 GB | NTFS | MS Windows System | 
| sda2 | 20 GB | ext3 | / | 
| sda3 | 20 GB | ext3 | /home | 
| sdb1 | 48 GB | FAT32/ext2 | Data exchange MS Windows and Linux | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 60 GB for dual boot MS Windows and Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 24 GB | NTFS | MS Windows System | 
| sda2 | 10 GB | FAT32/ext2 | Data for MS Windows and Linux | 
| sda3 | 10 GB | FAT32/ext2 | Data for MS Windows and Linux | 
| sdb1 | 14 GB | ext4 | / (includes home) | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 200GB hard drive:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20 GB | ext4 | / | 
| sda2 | 20 GB | ext4 | /home | 
| sda3 | 158 GB | ext2/3/4 | data | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 160GB hard drive:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20GB | ext4 | / | 
| sda2 | 20GB | ext4 | /home | 
| sda3 | 59GB | ext4 | data | 
| sdb1 | 59GB | ext4 | data | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 

##### General

There are many ways to partition your hard drives. These examples should be enough for a start.

 It makes good sense to purchase a USB hard drive to make a regular data back-up, should any of your hard drives fail. `If dual booting with MS Windows(tm);, always put MS on the first hard disk/partition` .

For other partitioning options see  [Partitioning to use LVM - Logical Volume Manager](part-lvm-en.htm#part-lvm)  and  [Installing to encrypted partitions - cryptroot](hd-install-crypt-en.htm#install-crypt) .

<div id="rev">Content last revised 15/01/2012 1000 UTC</div>
