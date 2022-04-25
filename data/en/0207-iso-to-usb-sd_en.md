% ISO to USB stick / memory card

## ISO to USB stick - memory card

Below we describe methods to write a siduction ISO image file as live media to a USB stick, SD card, or SHDC card.  
If *"persist "* is needed, we recommend the manual page [Boot from ISO file](0302-hd-ins-fromiso_en.md#fromiso).

**Prerequisites**

+ The PC's BIOS must allow booting from a USB stick or SD card. Normally this is the case if the BIOS offers this boot option.
+ A USB stick or SD card with a recommended capacity of at least 4 GB.
+ Back up all your data on the devices you want to use for making the siduction live media in advance as well as the currently used operating system and your private data. A small typo or a hasty click can destroy all your data!

> Important information  
> The following methods will overwrite existing partition tables on the target media, causing all data to be lost. Take extreme care when selecting the target media and its drive label.

### GUI application

**For Linux&#8482;, RasPi&#8482;, MS Windows&#8482;, or Mac OS X&#8482;**

The small tool [USBImager](https://bztsrc.gitlab.io/usbimager/) is available for all the above operating systems and is used to backup data and create the live medium. The program is open source and licensed under the MIT license. Download the necessary file for your operating system and install the program according to the instructions on the download page.

The handling is very simple thanks to the no-frills interface.

Write the image file to the device:
1. Select an image by clicking on `...` in the first line.
2. Select a device by clicking on the 3rd line.
3. Click on the `Write` button in the 2nd line.

Detailed information can be found in the [Readme](https://gitlab.com/bztsrc/usbimager/-/blob/master/README.md) of the project page.

### Linux command line

We recommend using the command line. There is no need to install additional programs, since all the tools you need are already available. A single, easy-to-understand command line is sufficient to transfer the siduction ISO image file to the storage medium.

Before we write the siduction ISO image file to the storage medium, we need to determine its drive label. The easiest way is to use journald. The command **`journalctl -f`** executed in a terminal shows continuously the messages of systemd. Now we plug in the storage medium and watch the messages in the terminal. Lines of the following type contain the information we are looking for.

~~~
kernel: usb 2-3.3: new high-speed USB device number 7 ...
[...]
kernel: scsi 1:0:0:0: Direct-Access Intenso Alu Line ...
kernel: sd 1:0:0:0: Attached scsi generic sg1 type 0
kernel: sd 1:0:0:0: [sdb] 7866368 512-byte logical blocks: (4.03 GB/3.75 GiB)
[...]
kernel: sd 1:0:0:0: [sdb] Write cache: disabled, read ...
~~~

This is an Intenso USB flash drive with 4 GB storage capacity and a sector size of 512 bytes. The drive name is `sdb`. It follows that `/dev/sdb` is the path to use for the target medium.  
Assuming the siduction ISO image file is stored in the `/home` directory of user **tux**, we can use the `dd` or `cat` commands to write to the target medium. The commands require root privileges. Therefore, depending on the system, either prepend **`sudo`** or **`doas`**, or use a terminal and become **root** with **`su`**.

~~~
dd if=/home/tux/siduction-21.3.0-wintersky-kde-amd64-202112231751.iso of=/dev/sdb
    (or)
cat /home/tux/siduction-21.3.0-wintersky-kde-amd64-202112231751.iso > /dev/sdb
~~~

The copying process may take 15 minutes or longer for an ISO image file of about 3 GB. Please wait relaxed until the prompt returns.

#### Additional data partition

Usually the storage medium is much larger than the ISO image file. The methods shown so far all use the entire storage medium, although the ISO image file only occupies 2.9 GiB. This cannot be changed afterwards. It is a good idea to take advantage of the command line and set up two partitions in advance. The first partition will later contain the live system and the second one the otherwise unused space. This allows us to take data on the media to the live session and store it there during the live session.

We use as root the command `cgdisk /dev/sdb` to create a new GUID partition table (see the manual page [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk)) and use the following data:

1st partition:  
   Start sector: 64 (default)  
   Size: 3G (3 GB, slightly larger than the ISO image file)  
   Type hex code: 0700 (Microsoft basic data)  
   Name: siduction  
2nd partition:  
   Start sector: xxxxxxxx (default, 1st sector after the previous partition).  
   Size: xxxxxx (default, the maximum possible size)  
   type hex code: 8300 (Linux)  
   Name: data

We write the partition table to the medium and exit `cfdisk`, but still stay in the root console, because the second partition still needs a file system and a meaningful label to make it easier to find in the file manager during the life session after mounting. The commands are:

~~~
mkfs.ext4 -L LifeData /dev/sdb2
~~~

With the storage medium prepared in this way, we write the ISO image file to the **1st partition**. 

~~~
dd if=/home/tux/siduction-21.3.0-wintersky-kde-amd64-202112231751.iso of=/dev/sdb1
~~~

Please pay attention to `/dev/sdb1`. If only `/dev/sdb` is used, the dd command will mercilessly overwrite our newly created partition table.

### Mac OS X command line

The copy process is very similar to the procedure for a Linux operating system. Connect your USB device, Mac OS X should mount it automatically. In the Terminal (under `Applications` \> `Utilities`), run this command:

~~~
diskutil list
~~~

Determine the name of the USB device and unmount the partitions. In our example the name is `/dev/disk1`:

~~~
diskutil unmountDisk /dev/disk1
~~~

Assuming the siduction ISO image file is stored in the `/home` directory of user **steve**, and the USB device is named `disk1`, execute the following command:

~~~
dd if=/Users/steve/siduction-21.3.0-wintersky-kde-amd64-202112231751.iso of=/dev/disk1
~~~

<div id="rev">Last edited: 2022/04/11</div>
