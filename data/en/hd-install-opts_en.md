<div id="main-page"></div>
<div class="divider" id="fromiso"></div>
## Booting with "fromiso" - Overview

**`For normal desktop use we recommend the ext4 file system. It is the default file system for siduction.`**

With this boot code you can start from an iso out of a partition ,(ext2/3/4), which is much faster then from a CD (HD installations with "fromiso" only takes a fraction of time).

'fromiso' also keeps the CD- /DVD-drive available. As an alternative you could use virtualbox, kvm or QEMU.

##### Requirements:

* a functioning grub (on a floppy, a HD-Installation or the Live-iso)  
* a siduction ISO Image e.g.renamed to (for ease of use): siduction.iso and a Linux file system like ext2/3/4.

<div class="divider" id="grub2-fromiso"></div>
## fromiso with Grub2

siduction provides a grub2 file package named 60_fll-fromiso,integrated in grub2), to generate a fromiso entry to the grub2 menu. The only file to configure fromiso is called `grub2-fll-fromiso`  and is found in `/etc/default/grub2-fll-fromiso.` .

First open a terminal and become root with:

~~~  
sux  
apt-get update  
apt-get install grub2-fll-fromiso  
~~~

Then open an editor, which may be kwrite, mcedit, vim or another that you prefer:

~~~  
mcedit /etc/default/grub2-fll-fromiso  
~~~

Next uncomment (remove the**`#`** ) the lines you need to be operative and replace the default instructions within the `"quote marks"`  with your preferences.

For example, compare this altered grub2-fll-fromiso with the default, (the `highlighted`  `lines`  are the changed lines for instructional purposes):

~~~  
# Defaults for grub2-fll-fromiso update-grub helper  
# sourced by grub2's update-grub  
# installed at /etc/default/grub2-fll-fromiso by the maintainer scripts  
#  
# This is a POSIX shell fragment  
#  
# specify where to look for the ISO  
# default: /srv/ISO `### Note: This is the path to the directory that contains the ISO, it is not to include the actual siduction-*.iso file.###`   
FLL_GRUB2_ISO_LOCATION="/media/disk1part4"`   
# array for defining ISO prefices --> siduction-*.iso  
# default: "siduction- fullstory-"  
FLL_GRUB2_ISO_PREFIX="siduction-"`   
# set default language  
# default: en_US  
FLL_GRUB2_LANG="en_AU"`   
# override the default timezone.  
# default: UTC  
FLL_GRUB2_TZ="Australia/Melbourne"`   
# kernel framebuffer resolution, see  
# http://manual.siduction.org/de/cheatcodes-vga-de.htm#vga  
# default: 791  
#FLL_GRUB2_VGA="791"  
# additional cheatcodes  
# default: noeject  
FLL_GRUB2_CHEATCODE="noeject nointro"`   
~~~

Save and close the editor, then run in the terminal

~~~  
update-grub  
~~~

Your grub2 grub.cfg will be updated to see the different ISOs you have placed in the directory you specified and will be available on your next boot up.

<div class="divider" id="fromiso-persist"></div>
## General information on persist

<!--</div>
<div class="divider" id="persist-firm-1">--></div>
### Firmware

`This applies to all persist requirements, except from RAW device installations.`  For RAW devices see  [Writing siduction to a USB/SSD stick with any Linux, MS Windows or Mac OS X system](hd-ins-opts-oos-en.htm#raw-usb) 

For firmware, you simply place the data you want to add to the live systems `/lib/firmware`  in a directory called `/siduction/firmware`  on your stick. You can enable this at boot time by selecting `Yes`  from the graphical `Driver menu`  or manually by adding `firmware`  to the kernel command line. `firmware=/lib/firmware`  would load the firmware from the first install it finds on a machine. If you want to enable it by default you can edit your boot configuration files, for example the `/boot/isolinux/syslinux.cfg`  file.

Both persist and firmware can use files placed in different locations on the disk, for example if the file for persistence is in the root of the stick and called `persist.img`  you can simply use `persist=/persist.img`  and likewise for firmware in a directory named fw you could use `firmware=/fw` .

### fromiso and persist on a HD

You can have a persistent live system on a writeable disk by combining a fromiso set-up with the persist boot code. 

To use persist a big file is needed and the boot code will look like:

~~~  
persist=/siduction/siduction-rw  
~~~

siduction uses dmsetup to enable what is known as "copy on write" over your ISO to allow you to write new files and folders and update existing ones by keeping the new files in memory. The `persist`  boot code will store your new files on the same hard drive partition as you use to store your ISO image.

`fromiso`  will give you a live system which performs all the automatic features of the siduction live ISO. This has the benefit of doing things like automatically configuring the hardware but it also means that it will recreate the same files each time you boot up unless you use additional codes.

Using `persist`  along with other siduction specific boot codes such as noxorgconf, nonetwork, means that it will not recreate the same files each time you boot up. Refer to  [Boot codes](http://manual.siduction.org/en/cheatcodes-en.htm#cheatcodes) 

Except for updating the kernel within the fromiso framework, using persist also means that you can install packages from apt and have the application and any data you have saved available for you to access at next boot up. Some packages require your sources.list to include contrib and non-free, see  [Adding non-free to Sources List](nf-firm-en.htm#non-free-firmware)  

<div class="divider" id="persist-post"></div>
## fromiso and persist on bootable USB-sticks/SD/flash-cards

Perhaps the ideal use of persistence is in conjunction with the install-usb-gui tool to create your own bootable flash drive with your files and the software you need. Your files will be stored in a subfolder on the drive.

`persist`  on a FAT file system, as commonly used for DOS installations and usually found by default on flash devices, requires you to create a single large file to use as a loop device, therefore you then format this file.

`On USB-sticks/SD/flash-cards, ext2 and vfat are the recommended file systems and most likely to give better cross platform ability for data rescue when needed most, as an MS Windows(tm); driver is available for data-swapping. Read/write speeds to flash type drives are contingent on the specifications of your USB stick.` 

###### ext2 + vfat file systems

When ext2 or vfat is used, persistence is made through a file that can be maximum 2GB but not less than 100MB (as it would be of no use). This file should be named `siduction-rw` .

### Example of adding persist after initial installation

If you are not sure of the mount point, mount the stick and run `ls -lh /media`  to provide a list of all your system mount points. Look for something like `drwxr-xr-x 6 username root 4.0K Jan 1 1970 disk` . If your output states differently then replace `"/media/disk"`  in line with your requirement, (for example "/media/disk-1").

Continuing the example, the command `df -h`  will clarify the information, :

~~~  
/dev/sdc2 3.4G 4.0K 3.4G 1% /media/disk  
/dev/sdc1 4.1G 1.1G 2.8G 28% /media/disk-1  
~~~

Therefore:

~~~  
disk="/media/disk-1"  
~~~

Set the size of the persist partition:

~~~  
size=1024  
~~~

Make a directory on the stick:

~~~  
mkdir $disk-1/siduction  
~~~

Run the code to make the persist file:

~~~  
dd if=/dev/zero of=$disk-1/siduction/siduction-rw bs=1M count=$size && echo 'y' | LANG=C /sbin/mkfs.ext2 $disk-1/siduction/siduction-rw && tune2fs -c 0 "$disk-1/siduction/siduction-rw"  
~~~

**`NTFS partitions, commonly used for MS Windows™ operating systems, CANNOT be used at all for persistence.`**

<div class="divider" id="usb-hd"></div>
## Installation of siduction on USB/SD/flash devices

To do an installation of siduction on a USB-stick/SD/flash-card is as easy as a normal HD-Install. Just follow this simple guideline.

##### Requirements:

Any PC that has a USB 2.0 / USB 3.0 protocol and supports booting from USB/SD/flash.

A siduction.iso image.

##### 3 kinds of installation to USB/SD/flash

+ 1)  [fromiso](hd-install-opts-en.htm#usb-from1) ; siduction specific: siduction-on-a-stick  
+ 2)  [Full](hd-install-opts-en.htm#usb-hdd)  (the full installation to a USB/SD/flash behaves as normal HD installation and is done through the normal installer).  
+ 3)  [RAW device](hd-ins-opts-oos-en.htm#raw-usb)  write. This is ideal when using any Linux, MS Windows or Mac OS X operating system and wish to install siduction-on-a-stick, (with caveats).  

<div class="divider" id="usb-from1"></div>
### USB/SD/flash fromiso Installation, siduction-on-a-stick

 `Pre format your usb device with ext2 or fat32 before proceeding (at least a 2 GByte capacity) . The device should have 1 partition only and as some BIOSes are temperamental this must be marked bootable.` 

If using a GUI formatting application like gparted, please ensure that you first delete the existing partition, then recreate the partition before formatting.

##### USB fromiso from a HD siduction installed system:

The `fromiso USB`  installation is done through `Menu>System>install-siduction-to-usb` . 

##### USB fromiso from an siduction-*.iso:

On a LIVE-ISO click on `siduction Installer Icon`  and choose `Install to USB` .

###### Options:

You are given the opportunity to make language, timezone and other boot codes choices and whether or not to activate persist via a checkbox.

You now have a bootable USB/SD/flash. If you did not activate persist you are able to turn it on by adding `persist`  on the grubline of the grub screen. (If vfat, it is probably best to start again though).

###### Terminal example:

~~~  
fll-iso2usb -D /dev/sdb -f none --iso /home/siduction/siduction.iso -p -- lang=no tz=Pacific/Auckland  
~~~

This installs the iso image to the USB device `sdb`  with persist, Norwegian language localisation and Pacific/Auckland (NZL) time on the grub default line.

Your X (video card, keyboard, mouse) configuration or your network interfaces file have not been stored, which makes it ideal to use on other computers.

For more documentation including customisation options see:

~~~  
$ man fll-iso2usb  
~~~

### Full installation to a USB/SD/flash (behaves as normal HD installation)

The recommended minimum size of a USB-stick/SD/flash-card is:  
siduction needs 2 - 4 (2 is LXDE, 4 is KDE)GByte PLUS you need data space

 `Pre format your device with`  **`ext2`** `and partition the USB-stick/SD/flash-card as you would a standard PC.` 

Start the installation from the Live-ISO and choose the partition on the USB/SD/flash-device, where siduction is to be installed, for example `sdbX` and follow the siduction installer prompts. Read  [Installing to your HD](hd-install-en.htm#Installation) 

`To boot from your USB/SD/flash 'Boot from USB' must be enabled in your BIOS.` 

`Other note worthy points are:` 

+ A USB-stick/SD/flash-card install will be usually be bound to the PC that initiated the original installation. If it is your intention to be able to use the USB/SD/flash stick on other PCs, it should not have non-free graphics drivers and cheatcodes pre configured, with the exception to probably have the vesa boot code hard coded into the grub.cfg, (all to be attended to after a successful installation).  
+ After booting the USB-stick/SD/flash-card to another PC, you will need to alter fstab to access the PCs hard drives.  
+ "fromiso" with "persist" is a better option should portability be the intention.  

<div class="divider" id="usb-hdd"></div>
### Full installation to a USB Hard Disk Drive like an installation to a partition

A USB Hard Disk Drive has one quite good and appealing application, (particularly to new users coming from MS or another distro), and that is you can install siduction to a USB HDD, plug it in without needing to configure a PC for dual boot (repartitioning, grub alterations etcetera).

Start the installation from the Live-ISO, (or from a USB-stick/SD/flash-card), `as a standard install, not a USB install`  and choose the partition on the device, where siduction is to be installed, for example `sdbX` and follow the siduction installer prompts. Grub must be written to the USB HDD partition.

Read  [Installing to your HD](hd-install-en.htm#Installation) 

`Other note worthy points are:` 

+ A USB HDD install will be usually be bound to the PC that initiated the original installation. If it is your intention to be able to use the USB HDD on other PCs, the USB HDD should not have non-free graphics drivers and cheatcodes pre configured, with the exception to probably have the vesa boot code hard coded into the grub.cfg (all to be attended to after a successful installation).  
+ If you want to use the installation on another machine be aware that you must make some adjustments. You will need to alter fstab to access the PCs hard drives, maybe xorg.conf and probably the network configuration.  

<div class="divider" id="usb-gpt-1"></div>
## Full installation to bootable GPT removable devices (behaves as a normal HD installation)

 Refer to  [Partitioning with gdisk for GPT disks](part-gdisk-en.htm#gdisk-1)  and then follow the instructions for  [Installation options - HD, USB, VM and Cryptroot](hd-install-en.htm) .

<div class="divider" id="usb-efi-1"></div>
## Bootable (U)EFI removable devices

<span class='highlight-1'>Applicable from the siduction-11.1-OneStepBeyond release.</span>

If you want to boot using EFI without burning optical media, then you need a vfat partition containing a portable EFI bootloader `/efi/boot/bootx64.efi` . The siduction amd64 isos include such a file and a grub configuration which it can load. To prepare a stick to boot this way, simply copy the contents of the siduction iso to the root of a `vfat`  formatted usb stick. You should also mark the partition as bootable using a disk partitioning tool.

Of course simply copying the files onto a vfat usb stick will not let you boot it on a traditional bios system, however it is quite easy to enable this using syslinux and install-mbr. All you need to do is run (without the stick being mounted): 

~~~  
syslinux -i -d /boot/isolinux /dev/sdXN  
install-mbr /dev/sdX  
~~~

A stick prepared this way, will boot both by EFI to the plain grub2 menu and by traditional bios to the graphical gfxboot menu.

One of the advantages of having a stick created this way, as opposed to a raw stick created due to using isohybrid, is that you can edit the boot files on the stick to add your preferred options automatically. 

For traditional BIOS systems you can edit the `/boot/isolinux/syslinux.cfg`  file and/or the `/boot/isolinux/gfxboot.cfg`  file. For EFI systems you can edit the `/boot/grub/x86_64-efi/grub.cfg`  file.

#### Persistence and firmware

See  [General information on persist](hd-install-opts-en.htm#fromiso-persist) 

<div id="rev">Page last revised 08/01/2012 1800 UTC</div>
