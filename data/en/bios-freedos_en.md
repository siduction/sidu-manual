<div id="main-page"></div>
<div class="divider" id="bois-prep"></div>
## Upgrading the BIOS with FreeDOS

You may want, or have a need, to update the BIOS of your PC, when the manufacturer of the motherboard announces some improvement of BIOS software. The installer program usually offered is an application to run MS-DOS.

This is a way to update BIOS from a USB-Device in linux. This will work with USB keys, USB-Sticks and with micro/mini/SD cards (with a suitable adapter).

Firstly, your BIOS needs to allow booting from USB - and be compatible with USB harddisks. Some BIOSes accept USB Floppies, CD-ROMs or ZIP drives, although these might be usable, it may be more difficult to implement the upgrade, however you may have no other choice, (netbooks in particular).

### You need three things:

1. A USB-Stick, preferably &lt;2 GByte (FAT16 doesn't allow more than 2 GByte), and the base FreeDOS (fdbasecd.iso) install only uses 5.8 MByte. `FAT16 is the recommended format as FAT32 is not detected as bootable by every BIOS` .  
2. A FreeDOS install medium  [fdbasecd.iso (8MByte)](http://www.freedos.org/freedos/files/) .  
3. qemu (apt-get install qemu), qemu is needed for the installer, basically the emulated qemu BIOS makes your USB-Stick appear to FreeDOS as an ordinary harddisk, so you can install as usual (and avoids burning the FreeDOS CD).  

##### **`This is absolutly critical: at no stage is the USB-Stick to be mounted. Be very careful to select the correct device node, otherwise all data on the wrong disk will be erased without any redress, i.e. your main hard drive.`** 


---

Plug in your USB-Stick, **`remember, don't mount it`** . Check dmesg (the last messages,if you just plugged it in), which device node got assigned to your USB-Stick lets assumes `/dev/sdb`  .

Clear your USB-Stick,`all data will be lost` , you could also clear all of it, instead of just the first 16 MByte. 

~~~  
$ suxterm  
Password:  
dd if=/dev/zero of=/dev/sdb bs=1M count=16  
16+0 records in  
16+0 records out  
16777216 bytes (17 MByte) copied, 2.35751 s, 7.1 MByte/s  
~~~

### Partitioning the USB-Stick

Partitioning and formatting your USB-Stick correctly is probably the hardest part.

Set the partition label to FAT16, on &lt;2 GByte sticks (it offers better compatibility overall).

Next fdisk to partition:

~~~  
# fdisk /dev/sdb  
fdisk /dev/sdb  
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel  
Building a new DOS disklabel with disk identifier 0xa8993739.  
Changes will remain in memory only, until you decide to write them.  
After that, of course, the previous content won't be recoverable.  
Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)  
~~~

Now create a partition:

~~~  
Command (m for help): n   
Command action  
e extended  
p primary partition (1-4)  
p   
Partition number (1-4): 1   
First cylinder (1-1018, default 1):  
Using default value 1  
Last cylinder or +size or +sizeM or +sizeK (1-1018, default 1018):  
Using default value 1018  
~~~

Confirm the creation of the partition by printing the partition table:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MByte, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 1 1018 1956595+ 83 Linux  
~~~

Set the correct partition label, '6' for FAT16:

~~~  
Command (m for help): t   
Selected partition 1  
Hex code (type L to list codes): l   
0 Empty 1e Hidden W95 FAT1 80 Old Minix be Solaris boot  
1 FAT12 24 NEC DOS 81 Minix / old Lin bf Solaris  
2 XENIX root 39 Plan 9 82 Linux swap / So c1 DRDOS/sec (FAT-  
3 XENIX usr 3c PartitionMagic 83 Linux c4 DRDOS/sec (FAT-  
4 FAT16 <32M 40 Venix 80286 84 OS/2 hidden C: c6 DRDOS/sec (FAT-  
5 Extended 41 PPC PReP Boot 85 Linux extended c7 Syrinx  
6 FAT16 42 SFS 86 NTFS volume set da Non-FS data  
7 HPFS/NTFS 4d QNX4.x 87 NTFS volume set db CP/M / CTOS / .  
8 AIX 4e QNX4.x 2nd part 88 Linux plaintext de Dell Utility  
9 AIX bootable 4f QNX4.x 3rd part 8e Linux LVM df BootIt  
a OS/2 Boot Manag 50 OnTrack DM 93 Amoeba e1 DOS access  
b W95 FAT32 51 OnTrack DM6 Aux 94 Amoeba BBT e3 DOS R/O  
c W95 FAT32 (LBA) 52 CP/M 9f BSD/OS e4 SpeedStor  
e W95 FAT16 (LBA) 53 OnTrack DM6 Aux a0 IBM Thinkpad hi eb BeOS fs  
f W95 Ext'd (LBA) 54 OnTrackDM6 a5 FreeBSD ee EFI GPT  
10 OPUS 55 EZ-Drive a6 OpenBSD ef EFI (FAT-12/16/  
11 Hidden FAT12 56 Golden Bow a7 NeXTSTEP f0 Linux/PA-RISC b  
12 Compaq diagnost 5c Priam Edisk a8 Darwin UFS f1 SpeedStor  
14 Hidden FAT16 <3 61 SpeedStor a9 NetBSD f4 SpeedStor  
16 Hidden FAT16 63 GNU HURD or Sys ab Darwin boot f2 DOS secondary  
17 Hidden HPFS/NTF 64 Novell Netware b7 BSDI fs fd Linux raid auto  
18 AST SmartSleep 65 Novell Netware b8 BSDI swap fe LANstep  
1b Hidden W95 FAT3 70 DiskSecure Mult bb Boot Wizard hid ff BBT  
1c Hidden W95 FAT3 75 PC/IX  
Hex code (type L to list codes): 6   
Changed system type of partition 1 to 6 (FAT16)  
~~~

Activate the new and only partition:

~~~  
Command (m for help): a   
Partition number (1-4): 1   
~~~

Print out the new partition table again, reconfirm that the partition indeed got activated:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MByte, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 * 1 1018 1956595+ 6 FAT16  
~~~

Write the new partition table to your USB-Stick and exit fdisk:

~~~  
Command (m for help): w   
The partition table has been altered!  
Calling ioctl() to re-read partition table.  
WARNING: If you have created or modified any DOS 6.x  
partitions, please see the fdisk manual page for additional  
information.  
Syncing disks.  
# exit  
~~~

Format your newly created USB-Stick:

~~~  
mkfs -t vfat -n FreeDOS /dev/sdb1  
exit  
~~~

The preparatory phase is now complete.You have now partitioned and formatted the USB-Stick, there's nothing else left to do and you can directly go to the install process.

### Booting up FreeDOS with qemu

As DOS has no idea of USB-Stick, you need to find a way to coax the FreeDOS installer into recognizing the USB as ordinary "harddisk", on live boot, the system's BIOS does that for us - but here the need to get inventive with qemu:

~~~  
as user$:  
qemu -hda /dev/sdb -cdrom /path/to/fdbasecd.iso -boot d  
~~~

`ctrl-alt`  will toggle mouse and keyboard grab and allow you to switch desktops to reread any instructions at each step.

![QEMU FreeDOS](../images-common/images-qemu-freedos/qemu-boot01.jpg "QEMU FreeDOS") 

This boots the FreeDOS CD and maps the USB-Stick raw device as primary master HD (here qemu's BIOS emulation abililty makes the USB-Stick appear to DOS as an ordinary hard disk). Select the installer from the start menu of the virtualised FreeDOS boot:

~~~  
1) Continue to boot FreeDOS from CD-ROM  
1   
enter  
~~~


---

Keep choosing the default of `1`  and/or choosing `Yes`  when asked.


---

![freedos-inst1](../images-common/images-qemu-freedos/qemu-boot02.jpg "Freedos Installation - 1") 


---

![freedos-inst2](../images-common/images-qemu-freedos/qemu-boot04.jpg "Freedos Installation - 2") 


---


---

![freedos-inst3](../images-common/images-qemu-freedos/qemu-boot09.jpg "Freedos Installation - 3") 


---

The install asks you to reboot - `don't do that yet, as there is a need to fix up two errors in the FreeDOS installer for the mbr and bootmenu` . Type the letter `**n**` .


---

![freedos-do not reboot type n](../images-common/images-qemu-freedos/qemu-boot18.jpg "Freedos Installation - do not reboot type n") 


---

### Writing a bootsector to your USB-Stick

The first error to fix is the mbr with:

~~~  
fdisk /mbr 1  
~~~

The second error that needs fixing is the bootmenu in your new fdconfig.sys, run:

~~~  
cd \  
edit fdconfig.sys  
~~~

and change the line starting command.com to:

~~~  
1234?SHELLHIGH=C:\FDOS\command.com C:\FDOS /D /P=C:\fdauto.bat /K set  
(don't actually change this command, just add "1234?" to the begin of the line (before SHELLHIGH=C:\FDOS\command.com .....  
NOTE it is to read : 1234?`   
~~~

![fdconfig.sys](../images-common/images-qemu-freedos/qemu-boot23.jpg "Edit fdconfig.sys ") 


---

**`Do not change anything else, as the line depends on your install setup.`** 

Save it and exit "edit":

~~~  
[alt]+[f]  
~~~

Once you're back to the command prompt, you can leave qemu.

Test to check if qemu will boot the USB-Stick.

~~~  
qemu -hda /dev/sdb -boot c  
~~~

Your USB-Stick is now bootable and contains a full FreeDOS install of 5.4 MByte, for flashing. You really should boot without any drivers `(menu option 4), loading the himem.sys and emm386 files may otherwise interfere with your flashing programs!` :

### Updating the BIOS

Assuming your PC is up and running, plug in the FreeDOS USB-Stick, mount it and download the BIOS files needed, as recommended by the manufacturer of your motherboard/BIOS, to the FreeDOS USB-Stick, then umount the stick.

 Power off your PC, plug in the FreeDOS USB-Stick, power up, so that you boot to the FreeDOS USB-Stick and follow the procedures of the manufacturer of your motherboard/BIOS.

<div id="rev">Content last revised 08/01/2012 1800 UTC</div>
