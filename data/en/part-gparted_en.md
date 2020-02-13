<div id="main-page"></div>
<div class="divider" id="partition"></div>
## Partitioning your HD using Gparted/KDE Partition Manager

##### **`WARNING: for disk naming`**  [Please refer to UUID, Partition Labelling and fstab, as by default siduction uses UUID](part-uuid-en.htm#uuid) 

##### Partitioning tools may request a root password, type `suxterm`  then your password. On a Live-ISO none is set `suxterm`  then press 'enter' . See:  [Live Mode](live-mode-en.htm#rootpw) 


---


::: warning  
**Achtung**  
Resizing the NTFS partition requires you to reboot the system immediately! DON'T DO any other operations on this partition before the reboot, otherwise you will get errors. [Please read this.](part-gparted-en.htm#ntfs)   
:::

**`Always back-up your data!`**

### Basics

A partition must have a filesystem. Linux knows different filesystems to use. Ext4 is the recommended format for siduction. ext2 is handy as a storage format as an MS Windows&#8482; driver is available for data-swapping.  [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/) .

**`For normal use we recommend the ext4 file system, it is the default file system for siduction .`**

## Using KDE Partition Manager &amp; Gparted

Creating and managing partitions is not something that is typically done every day. Therefore, a good idea is to read this guide once, to get comfortable with the concepts and some of the panels that will appear.

### KDE Partition Manager - run in a terminal:

~~~  
suxterm  
partitionmanager  
~~~

### Gparted - run in a terminal:

~~~  
suxterm  
gparted  
~~~

+ When GParted or KDE Partition Manager runs , a window is opened, and drives are scanned.
  
   In KDE Partition Manager the drives are shown in a list on the left.
  
   ![KDE Partition Manager partition information](../images-common/images-kpart/kpart-02.png "KDE Partition Manager partition information") 
  
   In Gparted, if you click the menu (at the top left), a pop down is presented. You can select to refresh the display of the drives on your system.
  
   ![gparted](../images-en/gparted-en/gparted02-en.png "Gparted Devices View") 
  

###### **`The following screenshots are of Gparted. KDE Partition Manager behaves in much the same manner.`** 

+ ### Edit
  
   The Edit menu has three greyed out functions which may be crucial for you:  
`Undo last operations`   
`Apply`   
`Clear all operations` .
  
+ ### View
  
   #### Device Information
  
   The `Harddisk Information`  panel displays details about the hard disk, such as Model, Size etc. This panel is most useful in a multi harddisk system, where the information is used to confirm that the hard disk being examined is the one that is wanted.
  
   ![operation view](../images-en/gparted-en/gparted03-en.png "Gparted Harddisk Information") 
  
   #### Pending Operations
  
   At the footing window is a list of pending operations. The information is useful as it provides an indication of a number of pending operations.
  
+ ### Device
  
   Device allows you to Set a Disk label if the current disk label is inappropriate, you may change it using this option.
  
+ ### Partition Menu
  
   The menu is of utmost importance. It allows you to do multiple operations, some of which are dangerous.
  
   `Delete`  is selected if you want to delete a partition. To perform the delete, you must first select the partition.
  
   `Resize/Move`  allows you to rezize partitions.
  
+ ### Creating a new partition
  
   On the graphical toolbar, the `New`  button allows you to create a new partition, if you have already selected an unallocated area. A new window appears and lets you chose the size you want, whether it be a Primary, Extended or Logical partition and the file system.
  
   ![file system](../images-en/gparted-en/gparted07-en.png "Gparted New Partition") 
  
+ ### If you make a mistake
  
   If you have made a mistake you can use the Delete button to delete the chosen partition or if you haven't applied your decision to go ahead you can use the undo button.
  
   ![delete](../images-en/gparted-en/gparted04-en.png "Gparted Delete") 
  
+ ### Resizing/Move
  
   When you want to resize a partition you have selected, click `Resize/Move`  button: a new window pops up. Use the mouse to reduce (or grow) the partition or if you prefer, use the arrows.
  
   ![resize / move](../images-en/gparted-en/gparted05-en.png "Gparted Resize") 
  
   After the Resize command has been given, click on Apply as no operations are given to the hard disk until you click Apply
  
   ![operation view](../images-en/gparted-en/gparted09-en.png "Gparted Apply") 
  
   The duration of the operations depends on the new size of the Partition.
  
   **`After manipulating the partition table please log out and reboot your system to allow siduction to reread the new partition table.`** 
  

<div class="divider" id="ntfs"></div>
## NTFS partition Resizing


::: warning  
**Achtung**  
Resizing the NTFS partition requires you to reboot the system immediately! DON'T DO any other operations on this partition before the reboot, otherwise you will get errors.  
:::

+ After the boot-up on MS Windows&#8482; the system will show a special screen, and a message asking about drive consistency : Checking file system on c :  
+ Let the AUTOCHK run: NT needs to check its file system after the resize operation.  
+ At the end of the process, the computer will automatically restart for the second time. This ensures that things run perfectly.  
+ After restart, Windows XP will be okay, but you must let the system finish the boot and wait for the login screen!  

 **Full GParted documentation:** To read the full documentation including, How-To copy partitions please go to  [GParted](http://gparted.sourceforge.net) 

<div class="divider" id="hd-ntfs3g"></div>
## Writing to NTFS partitions with ntfs-3g

**` **Be warned** : Whilst the ntfs-3g is stated to be 'stable', never use it without external backup, and of course not on production systems! If you do, it's your fault if your data gets lost, so use at your own risk!`**

Open a shell and enter the following commands:See  [Partitioning your HD - Disk Naming](part-cfdisk-en.htm#disknames) 

~~~  
suxterm  
apt-get update && apt-get install ntfs-3g  
umount /media/xdxx  
mount -t ntfs-3g /dev/disk/by-uuid/xxyyzz[etc] /media/xdxx  
To get out of the konsole type: exit  
~~~

Now your NTFS Volume should be mounted  **rw**  and you should be able to store data on it. But again, be warned! `Use it in emergency situations, it is not recommended for use on a daily basis.` 

<div id="rev">Content last revised 26/11/2014 2000 UTC</div>
