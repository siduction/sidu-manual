% Installation on USB stick / memory card

## Installation on USB stick - memory card

**Below we describe methods of installing a siduction-ISO on a USB stick, an SSD card, an SDHC device (Secure Digital High Capacity card), each using a different Linux distribution, MS Windows&#8482; or Mac OS X&#8482;.**

Here, the siduction ISO will be written to the device. Even if the persist option is not possible, you can have "siduction on a stick".

If persist is needed, install-usb-gui is the recommended method on an existing siduction system as it does not impose any restrictions. See also: [USB/SSD fromiso installation - siduction-on-a-stick](0302-hd-ins-fromiso_en.md#boot-from-iso-file) .

**Prerequisites**

+ The BIOS of the PC you want to run siduction-on-a-stick/card on must allow booting from a USB stick or SSD card. Normally, this is the case if the PCs BIOS offers this boot option.
+ USB/SSD should be detected automatically, and the menu option **F4** should output **Hard Disk**. Otherwise, **F4 > Hard Drive** should be called, or **fromhd** should be added to the boot menu line.
+ Back up the operating system and all your data on the devices to be used for creating the siduction USB media. A small typo can destroy all your data!

> Important information  
> The following methods will overwrite and destroy existing partition tables on the target media. The data loss depends on the size of the siduction-*.iso.  
> As far as Linux is concerned, the given disk space is not limited and it may be possible to recover data that was not destroyed by the ISO.  
> MS Windows, on the other hand, seems to allow only one partition. So don't take any risks of data loss and don't use this method on one of your 100+ GB hard disks. Back up your data!

### With Linux operating systems

Plug in your USB flash drive or card reader with the card you want to write to. Then, run the following command:

~~~sh
cat /home/username/siduction-18.3.0-patience-kde.iso > /dev/sdX
~~~

or

~~~sh
dd if=/path/to/siduction-*.iso of=/dev/sdX
~~~

To find out what the X in sdX is, please call *fdisk -l* or *dmesg* as **root**.

**Example:**  
Run the command **dmesg -w**, connect your device, and note the output:

~~~sh
sd 13:0:0:0: [sdc] Write Protect is off
sd 13:0:0:0: [sdc] Mode Sense: 23 00 00 00
sd 13:0:0:0: [sdc] Write cache: disabled, read cache: enabled
sd 13:0:0:0: [sdc] Attached SCSI removable disk
~~~

Here,the storage device is recognized with the drive identifier **sdc**.  
Then, *dmesg* can be terminated with the key combination `Ctrl`+`c`.  
Assuming the saved ISO "siduction-18.3.0-patience-kde-amd64-201805132121.iso" was renamed to "siduction-18.3.0-patience-kde.iso", the command to be executed is:

~~~sh
cat /home/username/siduction-18.3.0-patience-kde.iso > /dev/sdc
~~~

or

~~~sh
dd if=/home/username/siduction-18.3.0-patience-kde.iso of=/dev/sdc
~~~

### With MS Windows

The procedure is simple. Download the small tool [USBWriter](https://sourceforge.net/p/usbwriter/wiki/Documentation/). It does not need to be installed. After starting the tool, for example from the desktop, you only need to select the desired ISO image and the USB stick. Close attention is required here because the process deletes all data on the device. So if the wrong device is selected, the data on it will be lost as soon as the *WRITE* button is pressed. Withinn a few minutes, the tool writes the image to the now bootable device.

### With Mac OS X

After plugging in your USB device, Mac OS X should mount it automatically. In Terminal (under Applications &gt; Utilities), run this command:

~~~sh
diskutil list
~~~

Set the name of the USB device and unmount the partitions of the device. In our example, the name is /dev/disk1:

~~~sh
diskutil unmountDisk /dev/disk1
~~~

Assuming the saved ISO "siduction-18.3.0-patience-kde-amd64-201805132121.iso" has been renamed to "siduction-18.3.0-patience-kde.iso" and saved to "/Users/username/Downloads/" and the USB device is named "disk1", execute the following command:

~~~sh
dd if=/Users/username/Downloads/siduction-18.3.0-patience-kde.iso of=/dev/disk1
~~~

<div id="rev">Last edited: 2022/01/15</div>
