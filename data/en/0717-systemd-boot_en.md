% systemd-boot

## systemd-boot


Although it was included in systemd more than ten years ago, the boot manager systemd-boot (sd-boot for short) is rarely found on desktop systems. If you decide to use sd-boot with a suitable setup and after thorough testing, the changeover is not a major challenge for a somewhat experienced user.

**Features**

The boot manager sd-boot was developed with the aim of making the boot process fast, simple and secure. The user receives a text-based boot menu. The display does not need any bells and whistles.  
In keeping with its name, it is deeply integrated into systemd and accesses the services available there. sd-boot creates a visually minimalist boot menu. Each menu entry is based on a single, separate text file. The configuration for the user interface is rudimentary compared to GRUB and the installation scope, with 32 files and a twentieth of the data volume, is very small.  
sd-boot is only available for UEFI hardware. For this, sd-boot requires an ESP (**E**fi **S**ystem **P**partition). An XBOOTLDR partition is also recommended.  
If only the ESP is present, it is mounted under `/boot`.  
For ESP and XBOOTLDR partitions, the ESP is mounted under `/efi` and the XBOOTLDR partition under `/boot`.  
File system drivers for the XBOOTLDR partition may have to be stored under `/efi`.  
sd-boot can only boot operating systems from partitions of the same medium. To boot operating systems from other media, use the ChainLoader method to GRUB or another boot loader.

siduction installs the boot manager GRUB automatically. It is not possible to select sd-boot during the installation. If you switch to sd-boot later, sd-boot creates customized initrd for each kernel present in the system. Only with these initrd will sd-boot boot.

**systemd-boot functions:**

- Boot from fully encrypted hard disk.  
- Support for the XBOOTLDR partition.  
- Loading of drop-in drivers.  
- Registering SecureBoot keys.  
- Create a menu entry when installing new kernels.  
- Boot counting  
  In connection with failed boot processes, the boot entry can be removed automatically.  
- Support for passing a random seed to the OS.  
  This serves to protect against the use of manipulated OS images.

It is also possible to pass commands to sd-boot before a reboot or during the boot process. Information on this can be found in `man systemd-boot`.

**Application scenarios**

Suitability with different system configurations and in comparison with GRUB.

| System configuration | sd-boot | GRUB | Remark |
| :------ | :-: | :-: | :--------------- |
| An immutable OS | ++ | o | Only a minimalist boot manager without a menu is required. GRUB is oversized for this purpose. |
| One OS on one HD | ++ | o | Boot menu only necessary with multiple kernels. |
| Several Linux OS on one HD | + | + | sd-boot necessary on all OS. GRUB requires external module *os-prober*. |
| Dual boot with WIN / MAC on one HD | + | + | As before. Both can be booted using ChainLoader. |
| Several Linux OS on several HD | - | + | sd-boot can only boot OS from one HD. Two instances in UEFI with selection via firmware necessary. |
| Dualboot with WIN / MAC on several HD | - | + | As before. |
| Several variants of a Linux OS on one HD | o | o | With sd-boot manual adjustment of the menu entries necessary. For GRUB, create or modify the file `/etc/default/grub.d/xxxx.cfg`. |
| Linux OS on Btrfs file system with support for snapper | - | o | sd-boot creates menu entries only once when installing the kernel, regardless of the subvolume. Other subvolumes do not receive an entry. GRUB relies on different additional software depending on the distribution. |
| A fully encrypted HD | ++ | + | sd-boot passes the tasks to the kernel and the user space and is therefore more efficient. GRUB requires additional software. |

sd-boot fully demonstrates its advantages with a simple hardware setup, but fails with operating systems on multiple media.  
Grub, on the other hand, can be used more universally, is therefore heavyweight and still requires external software. GRUB is oversized for simple hardware setups.

### Installing systemd-boot

> Attention  
> It is essential to make a data backup on an external medium.  
> Work on partitions is necessary to install sd-boot according to the recommendations.

The instructions are based on the standard installation of *siduction* with an ESP (**E**fi **S**ystem **P**partition), which is mounted under `/boot/efi`. This is also the standard for Debian and many Debian derivatives. 
To switch to sd-boot, only the two packages `systemd-boot` and `systemd-boot-efi` are required.  
But be careful, first some work on the system is necessary.

### System preparation

**Partitioning**

A significant change of sd-boot compared to the standard installation of siduction with GRUB is the relocation of the directory `/boot` into one or better two separate partitions. The recommendations of sd-boot are:

- **Both ESP and XBOOTLDR:**  
  *ESP  
  gdisk partition type “EF00”, Part-GUID code: C12A7328-F81F-11D2-BA4B-00A0C93EC93  
  File system: VFAT, mounted under /efi/  
  Size: 100 MB  
  *XBOOTLDR  
  gdisk Partition type “EA00”, Part-GUID code: BC13C2FF-59E6-4262-A352-B275FD6F7172  
  File system: Any file system that the UEFI implementation can read, mounted under /boot/  
  Size: at least 1 GB

- **Only ESP:**  
  (Conditionally recommended, see below.)  
  gdisk partition typ "EF00", Part-GUID code: C12A7328-F81F-11D2-BA4B-00A0C93EC93  
  File system: VFAT, mounted under /boot/  
  Size: at least 1 GB

- **Not recommended:**  
  ESP mounted under /boot/efi/

Quotes from the [boot_loader_specification](https://uapi-group.org/specifications/specs/boot_loader_specification/).

[Quote start]  
*Note: These partitions are shared among all OS installations on the same disk. Instead of maintaining one boot partition per installed OS (as /boot/ was traditionally handled), all installed OSes use the same place for boot loader menu entries.*  
[...]  
*Mounting the ESP to /boot/efi/, as was traditionally done, is not recommended. Such a nested setup complicates an implementation via direct autofs mounts — as implemented by systemd for example —, as establishing the inner autofs will trigger the outer one. Mounting the two partitions via autofs is recommended because the simple VFAT file system has weak data integrity properties and should remain unmounted whenever possible.*  
[...]  
*For systems where the firmware is able to read file systems directly, the ESP must — and the MBR boot and GPT XBOOTLDR partition should — be a file system readable by the firmware. For most systems this means VFAT (16 or 32 bit). Applications accessing both partitions should hence not assume that fancier file system features such as symlinks, hardlinks, access control or case sensitivity are supported.*  
[Quote end]  

**Minimum size**

If you follow the recommendations of sd-boot and use both the ESP and the XBOOTLDR partition, you can keep the small size of the ESP and use a more powerful file system for the XBOOTLDR partition. Necessary file system drivers for the XBOOTLDR partition are to be fetched from [akeo.ie](https://efi.akeo.ie) and copied to `/efi/EFI/systemd/drivers/`.  
The XBOOTLDR partition should be at least 1 GB, as sd-boot stores all kernels and initrd in it twice. As prescribed by the standard, once directly under `/boot/` and once again under `/boot/<entry-token-or-machine-id>/<version>/`. This results in 70 to 100 MB for a kernel with initrd. The reason for this is probably the use of VFAT, which does not support symlinks. With several OSes, each with several kernels, the size of 1 GB is borderline and the usual 200 to 300 MB of the ESP are completely unsuitable. This requires a change in partitioning.

We keep the ESP in its previous size and create the XBOOTLDR partition (gdisk type EA00) anywhere on the same medium. As already mentioned, at least 1 GB in size, preferably 2 GB. If the UUID of an existing partition changes, the `/etc/fstab` file must be adjusted. See: [Customize the fstab](0311-part-uuid_en.md#adjusting-the-fstab).

**Copy data and adapt files**

We open a terminal and become ROOT with `su`.  
If `gdisk` is not installed, we do this and read the *Partition GUID code* of the ESP and XBOOTLDR partition. The device file can of course also be '/dev/sda' and the number after the `-i` option names the partition on the medium.

~~~
# sgdisk -i1 /dev/nvme0n1
Partition GUID code: C12A7328-F81F-11D2-BA4B-00A0C93EC93B (EFI system partition)
[...]
# sgdisk -i4 /dev/nvme0n1
Partition GUID code: BC13C2FF-59E6-4262-A352-B275FD6F7172 (XBOOTLDR partition)
[...]
~~~

The first line of the output of `sgdisk` must look as shown. If not, use `gdisk` to change the partition type to *EF00* (ESP) and *EA00* (XBOOTLDR).

In the next step we create new directories and copy the directory `/boot`.

~~~
# cd /
# mkdir /efi
# mkdir /grub
# cp -a /boot/* /grub/
# umount /boot/efi/
# rm -r /boot/*
~~~

We also backed up the ESP data with the command sequence.  
Now we adapt the file `/etc/fstab`. (Create a backup copy beforehand.)

~~~
# cp /etc/fstab /etc/fstab_$(date +%F)
~~~

We create a copy of the line with the mount point `/boot/efi` and only remove the string “/boot” from the original line.  
In the copy we write the data for the XBOOTLDR partition with the mount to `/boot`.  
Finally, the changes should look like this.

~~~
[...]
UUID=FA62-156D          /efi    vfat   defaults 0 2
UUID=<uuid_of_xbootldr> /boot   ext4   defaults 0 2
[...]
~~~

Now we mount the partitions and copy the kernel with accessories to `/boot`. Then we create the directory for the file system drivers of the XBOOTLDR partition.

~~~
# systemctl daemon-reload
# mount /boot/
# mount /efi/
# cp -a /grub/vmlinuz-6.8.9-1-siduction-amd64 /boot/
# cp -a /grub/initrd.img-6.8.9-1-siduction-amd64 /boot/
# cp -a /grub/System.map-6.8.9-1-siduction-amd64 /boot/
# cp -a /grub/config-6.8.9-1-siduction-amd64 /boot/
   # or more simply: cp -a /grub/*-6.8.9-1-siduction-amd64 /boot/
# mkdir -p /efi/EFI/systemd/drivers/
~~~

Finally, we fetch the file system drivers from the website [akeo.ie](https://efi.akeo.ie) and save them in the directory created under `/efi/`. Pay attention to execution rights.

**Installation**

Once the preparations have been completed and the result has been checked, e.g. with the commands `ls -l /boot` `lsblk` or `sgdisk -i...`, a command line is sufficient to add the two required packages to our system.

~~~
# apt install systemd-boot-efi systemd-boot
[...]
Copied "/usr/lib/systemd/boot/efi/systemd-bootx64.efi" to "/efi/EFI/systemd/systemd-bootx64.efi".
Copied "/usr/lib/systemd/boot/efi/systemd-bootx64.efi" to "/efi/EFI/BOOT/BOOTX64.EFI".
Created "/boot/e5cc6ff820c1450c93a29d8723c78cd1".
! Mount point '/efi' which backs the random seed file is world accessible, which is a security hole!
! Random seed file '/efi/loader/random-seed' is world accessible, which is a security hole!
Random seed file /efi/loader/random-seed successfully installed (32 bytes).
Created EFI boot entry "Linux Boot Manager".
~~~

In the firmware UEFI menu, we now find the *Linux Boot Manager* in first place, which, as the output shows, has been written to the ESP. At the same time, sd-boot has created the boot entries for the *Linux Boot Manager* in the XBOOTLDR partition.  
For each additional OS on the medium, the 'System preparation' and the 'Installation' are necessary.


### Configuration

There are only two places where the configuration for sd-boot is located.  
For the *Linux Boot Manager* it is the file `/efi/loader/loader.conf` and for the *menu entries* it is the files with the extension `.conf` in the directory `/boot/loader/entries/`.

**Linux Boot Manager**

The configuration of the *Linux Boot Manager* only affects the following points  
- Display of the menu and timeout - no/yes/duration  
- Console mode - value  
- Editing the kernel line - yes/no  
- Set default boot entry - value

For only one system with one kernel, the configuration file has the following content:

~~~
#timeout 3
#console-mode keep
~~~

It boots directly into the operating system without displaying a menu, because 'timeout' is commented out. The reason: Only one menu item exists so far. After removing the comment character, the menu of a siduction XFCE installation appears.

~~~
                    siduction XFCE
            Reboot Into Firmware Interface
~~~

If there is more than one OS on the medium, the file `/efi/loader/loader.conf` contains an additional line `default <entry-token-or-machine-id>-*` to define the default entry.

~~~
timeout 3
#console-mode keep
default e5cc6ff820c1450c93a29d8723c78cd1-*
~~~

**Menu entries**

The configuration files are located in the directory `/boot/loader/entries/` and their name corresponds to the format `<entry-token-or-machine-id>-<kernelversion>.conf`.  
sd-boot automatically adds the entries to the menu when additional kernels are installed. With an additional kernel, the menu items also receive the kernel version.

~~~
           siduction XFCE (6.8.10-1-siduction-amd64)
           siduction XFCE (6.8.9-1-siduction-amd64)
                Reboot Into Firmware Interface
~~~

Of **several OS** on different partitions, only the one from which sd-boot was installed is automatically listed in the menu. The kernels available there appear in the selection. If you install sd-boot in every OS, these boot entries also find their way into the menu. Here, for example, is UBUNTU.

~~~
           siduction XFCE (6.8.10-1-siduction-amd64)
           siduction XFCE (6.8.9-1-siduction-amd64)
                       Ubuntu 24.04 LTS
                Reboot Into Firmware Interface
~~~

If, for whatever reason, a menu entry is missing, the generation of the entry can be restarted at any time. It must be ensured that the kernel, the vmlinuz and the config file of the corresponding version are located in the `/boot/` directory.  
From the corresponding OS, the command 

~~~
dpkg-reconfigure linux-image-6.8.9-1-siduction-amd64
~~~

also creates the desired menu entry.

### Remove GRUB

sd-boot cannot currently (08-2024) be selected as the default boot manager when installing siduction. If extensive tests with sd-boot were successful, we have to remove GRUB from our system to avoid errors during update and upgrade.

**Packages**

We open a terminal, become ROOT with `su` and use the command `apt purge` to remove the configuration files as well.

~~~
01|# apt purge grub*
02| Package lists are read...
03| Dependency tree is built...
04| Status information is read in...
05| The following packages are REMOVED:
06| grub-pc-bin* os-prober* grub-btrfs* siduction-btrfs* grub-efi-amd64-bin*
07| grub2-common* grub-common* grub-efi-ia32-bin* memtest86+* grub-pc*
08| 0 updated, 0 reinstalled, 10 to be removed.
09| After this operation 0 B disk space will be used additionally.
10| Do you want to continue? [Y/n] y
11| (Read database ... 249262 files and directories are currently installed).
12| Delete the configuration files of grub-btrfs (4.11-0~1siduction3) ...
13| /var/lib/dpkg/info/grub-btrfs.postrm: 23: update-grub: not found
14| dpkg: Error while removing the package grub-btrfs (--purge):
15| “installed post-removal script of grub-btrfs package” subprocess returned error value 127
16| An errors occurred while removing:
17|  grub-btrfs
~~~

The *grub-btrfs* package throws an error. In line 13 we read that the post-removal script can no longer find the command from line 23 (update-grub), which is of course correct, because *grub-pc-bin* has already been removed.  
Consequently, we comment out the line and try apt again.

~~~
# sed -i '23s!\(.*\)!#\1!' /var/lib/dpkg/info/grub-btrfs.postrm
# apt purge grub-btrfs
~~~

After this action, the backup copies we created and two GRUB directories remain. These are  
the directory `/grub/`,  
the backup file `/etc/fstab_*`,  
the directory `/usr/share/grub/`  
and the directory `/etc/default/grub.d/`.

Let's get rid of the leftovers with

~~~
# rm -r /grub/
# rm /etc/fstab_*
# rm -r /usr/share/grub/
# rm -r /etc/default/grub.d/
~~~

**Clean up UEFI**

The siduction boot entry from the installation with GRUB still exists in the firmware. We display the content in the terminal with ROOT rights. (Shortened version)

~~~
# efibootmgr
 BootCurrent: 0001
 Timeout: 0 seconds
 BootOrder: 0001,0000,0002,2001,2002
 Boot0000* siduction
 Boot0001* Linux Boot Manager
 Boot0002* EFI Hard Drive
 Boot2001* EFI USB Device
 Boot2002  EFI Network RC
~~~

The first command removes the GRUB entry.  
The second command then deletes the corresponding directory from `/efi/`.

~~~
# efibootmgr -b 0000 -B
# rm -r /efi/EFI/siduction/
~~~

### systemd-boot and Btrfs

The Btrfs file system, especially in conjunction with snapper, offers the possibility of restoring a defective system to a previous state. In this context, the relocation of the `/boot` directory to a separate partition required by sd-boot is a hindrance. The `/boot` directory is an essential part of the operating system and should not be moved to a partition or subvolume in connection with Btrfs. This is because it is not covered by snapshots of the root file system.  
With the *siduction-btrfs* package, siduction is able to create menu entries for all kernels contained in the rollback target during a *rollback*. Menu entries for other snapshots are not available. The user can therefore decide for himself whether he wants to use sd-boot when installing the system on Btrfs.

### Further information

`man systemd-boot`  
[boot_loader_specification](https://uapi-group.org/specifications/specs/boot_loader_specification/)  
[File system driver by akeo.ie](https://efi.akeo.ie)

<div id="rev">Last edited: 2024/09/21</div>
