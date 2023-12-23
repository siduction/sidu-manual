% Partitioning of installation media

## Partitioning of installation media

The partitioning of the drives depends on many factors:

+ Selection of the siduction variant  
+ Size of the available drives and RAM  
+ Single-boot or dual-boot with an already installed system (Windows, Linux, MAC)  
+ Sharing of data for the installed systems

For Linux beginners, we recommend that you create only two partitions  
`/root` (incl. `/home` ) and `swap`, as this makes a first installation much easier. After the installation, additional data partitions can be created, or a separate `/home` if desired.  
However, we rather advise against creating a `/home` partition. The `/home` directory should be the place where the individual configurations are stored, and only these. For all other private data, a separate data partition should be created. The advantages for data stability, data backup and also in case of data recovery are almost immeasurable.  
Purchasing an external USB hard drive for regular data backup is also worth considering.

### Minimum requirements

The minimum requirements for the reasonable use of a siduction installation are:

| installed system | hard disk space |
| :--- | :--: |
| siduction NoX | 5GB |
| siduction Xorg | 10GB |
| siduction LXQt | 15GB |
| siduction LXDE | 15GB |
| siduction Xfce | 15GB |
| siduction Cinnamon | 15GB |
| siduction KDE Plasma | 15GB |

Otherwise, we recommend at least 20 GB of disk space when installing to the **Btrfs** file system and using `snapper`. 50 GB or more is useful if you want to use siduction on **Btrfs** for a longer period of time and many snapshots are kept.

> **Please note**  
> siduction does not support a separate boot partition when using the Btrfs file system. 

### Examples with different disk sizes

There are several good ways to divide your plates. These examples should give a first insight. They refer to partition tables of the type *"GPT "*. The first partition on the first disk is mandatory for the boot process.

**Laptop with 8 GB RAM, Linux only**  
**120 GB hard disk**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 MB | FAT32 | EFI-System (ESP) |
| 2 | 25 GB | ext4 | / |
| 3 | 85 GB | ext4 | data |
| 4 | 10 GB | Linux Swap | Linux Swap |

**Desktop, Linux only**  
**500 GB hard disk:**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system (ESP) |
| 2 | 30 GB | ext4 | / |
| 3 | 466 GB | ext4 | data |
| 4 | 4 GB | Linux Swap | Linux swap |

**Desktop, Linux only**  
**500 GB hard disk with Btrfs snapshot:**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system (ESP) |
| 2 | 496 GB | btrfs | / |
| 3 | 4 GB | Linux Swap | Linux swap |

**Desktop, Linux only**  
**160 GB hard disk**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system (ESP) |
| 2 | 26 GB | ext4 | / |
| 3 | 130 GB | ext4 | data |
| 4 | 4 GB | Linux Swap | Linux swap |

If a dual boot with MS Windows&#8482; is created, MS Windows must always be installed as the first system onto the hard disk. The first four partitions of our examples should be located directly after each other at the beginning of the hard disk. After that, the partitions for Linux and shared data follow.

See also [Microsoft: UEFI/GPT partitioning, Windows 11](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions?view=windows-11).

**Desktop, dual-boot (MS Windows and Linux)**  
**1 TB hard disk:**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 MB | FAT32 | EFI-system (ESP) |
| 2 | 16 MB | without | Windows MSR |
| 3 | 50 GB | NTFS | Windows system |
| 4 | 1 GB | NTFS | Windows RE |
| 5 | 415 GB | NTFS | data for Windows and Linux |
| 6 | 30 GB | ext4 | / (Linux root) |
| 7 | 500 GB | ext4 | data for Linux |
| 8 | 4 GB | Linux Swap | Linux Swap |

**Desktop, dual-boot (MS Windows and Linux)**  
**120 GB hard disk:**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system (ESP) |
| 2 | 16 MB | without | Windows MSR |
| 3 | 40 GB | NTFS | Windows system |
| 4 | 1 GB | NTFS | Windows RE |
| 5 | 47 GB | NTFS | data for Windows and Linux |
| 6 | 30 GB | ext4 | / (Linux root) |
| 7 | 2 GB | Linux swap | Linux swap  |

**Laptop with 32 GB RAM, dual boot (MS Windows and Linux)**  
**1 TB hard disk:**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system (ESP) |
| 2 | 16 MB | without | Windows MSR |
| 3 | 50 GB | NTFS | Windows system |
| 4 | 1 GB | NTFS | Windows RE |
| 5 | 499 GB | NTFS | data for Windows and Linux |
| 6 | 30 GB | ext4 | / (Linux root) |
| 7 | 380 GB | ext4 | data for Linux |
| 8 | 40 GB | Linux swap | Linux swap |

### File systems of the partitions

The type *"GPT "* should be selected as the partition table. In this way the advantages over *"MBR "* can be used. Only with old hardware *"MBR "* is still meaningful. The explanations for this can be found on our manual page [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk).

**Linux Swap**  
A `swap` partition corresponds in functionality to the swap file in Windows, but is far more effective than it. Its size depends on the installed system and the user's requirements. Some examples: 

+ For notebooks that are to be hibernated, we recommend a swap partition that is at least one GByte or 25% larger than the RAM.  
+ Current desktop PCs that are *not* to be hibernated and have enough RAM (16 GByte or more, depending on usage) do not need a swap partition.  
+ For desktop PCs with very limited RAM, the rule of thumb is still that the swap partition should be twice the size of the RAM used.

**ext4**  
The *ext4* file system is the default file system on siduction. This applies to all partitions when only Linux operating systems are used.

**Btrfs**  
*Btrfs* can be used instead of *ext4*. Together with the program *Snapper* it offers the possibility to create snapshots of the file system which are selectable in the boot manager Grub afterwards. You need a sufficiently large hard disk. See also [System administration Btrfs](0704-sys-admin-btrfs-snapper_en.md#btrfs).

**NTFS**  
For data exchange with a Windows installation the designated partition should be formatted with *NTFS*. Siduction can access the data read and write. For Windows it is the standard file system.

**HFS+**  
For a dual-boot installation with Macintosh, a separate data partition with the *HFS* or *HFS+* file system is useful. Linux and MAC can access it read and write.

### Partition editors

> **Caution**  
> When using any partitioning software, there is a risk of data loss. Always back up important data to another disk in advance.

+ **GParted**: an easy to use partition editor with a graphical interface  
  *Gparted* is available on all siduction installations and installation media equipped with a graphical user interface. It supports a number of different partition table types. The manual page [Partitioning the hard disk with GParted](0312-part-gparted_en.md#partitioning-with-gparted) provides more information about the program.

+ **KDE Partition Manager**: a Qt based, easy to use partition editor with a graphical user interface  
  The *KDE Partition Manager* is the standard partition editor for the KDE Destktop and as comprehensive as *Gparted*.

+ **gdisk / cgdisk**: a console program for partition tables of the type *GPT - UEFI*  
  *gdisk* is the classic text mode program, while *cgdisk* has a more user friendly ncurses interface. The manual page [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk) provides more information about the program.

+ **fdisk / cfdisk**: a console program for partition tables of the type *msdos - MBR*  
  Note: *fdisk* should only be used for old hardware that does not support *GPT - UEFI*.  
  *fdisk* is the classic text mode program, while *cfdisk* has a more user-friendly ncurses interface. The manual page [Partitioning with cfdisk](0314-part-cfdisk_en.md#partitioning-with-fdisk) provides more information about the program.

**Mounted partitions** (also swap) must be detached before editing.  
You can do this by entering to following command as **root**:

~~~
# umount /dev/sda1
~~~

To mount a swap partition, use this command: 

~~~
# swapoff -a
~~~

### Further information

[Here the comprehensive english documentation of GParted](https://gparted.org/index.php)

[Microsoft: UEFI/GPT partitioning, Windows 11](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions?view=windows-11)

For more partitioning options see:

+ Logical Volume Manager [LVM partitioning](0315-part-lvm_en.md#lvm-partitioning---logical-volume-manager)

+ partitioning with GPT to support UEFI [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk)

<div id="rev">Last edited: 2023-12-21</div>
