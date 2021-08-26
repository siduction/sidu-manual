BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC2**

Necessary work:

+ check spelling  

Work done

+ check intern links  
+ check extern links  
+ check layout  

END   INFO AREA FOR THE AUTHORS  
% Partitioning of installation media

## Partitioning of installation media

For Linux beginners we recommend to create only two partitions (root/home and swap), because this makes a first installation much easier. After the installation, additional data partitions can be created, or a separate /home, if desired.

However, we do not recommend creating a /home partition.  
The directory **/home** should be the place where the individual configurations are stored, and only these. A separate data partition should be created for all other private data. The advantages for data stability, data backup and also in case of data recovery are almost immeasurable.

A swap partition is similar in functionality to the Windows swap file, but is far more effective than it. As a rule of thumb, the swap partition should be twice as large as the RAM used. This applies mainly to notebooks that are to be hibernated via *hibernate*, or desktops with very little RAM (1 GByte or less). Devices with sufficient RAM no longer need a swap partition.

For data exchange with a Windows installation, the designated partition should be formatted with **ntfs**. Siduction can access the data reading and writing with the automatically installed *ntfs-3g*.

There are many good ways to partition your disks. These examples should give a first insight into the possibilities. 

Purchasing an external USB hard drive for regular data backup is also worth considering.

### Minimum requirements

The minimum requirements for the sensible use of a siduction installation are:

| installation system | hard disk space |
| :--- | :--: |
| siduction NOX | 5GB |
| siduction Xorg | 10GB |
| siduction LXQt | 15GB |
| siduction LXde | 15GB |
| siduction XFCE | 15GB |
| siduction Cinnamon | 15GB |
| siduction KDE Plasma | 15GB |

### Examples with different disk sizes

If a dual boot with MS Windows&#8482; is created, MS Windows must always be installed as the first system on the hard disk.

The type "*GPT*" should be selected as partition table. So one can use the advantages opposite "*MBR*". Only with old hardware "*MBR*" is still meaningful. The explanations for this can be found on our manual page [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk).

The examples refer to partition tables of the type "*GPT*", for whose function the first two, very small partitions are necessary.

**Dual-Boot with MS Windows and Linux**

**1 TB hard disk:**

| Partition | Size | Filesystem | Usage |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 50 GB | NTFS | MS Windows System |
| 4 | 300 GB | NTFS | Data for MS Windows |
| 5 | 200 GB | NTFS | Data for MS Windows and Linux |
| 6 | 30 GB | ext4 | / (Linux root) |
| 7 | 416 GB | ext4 | Data for Linux |
| 8 | 4 GB | Linux swap | Linux swap |

**120 GB hard disk:**

| partition | size | formatting | usage |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 40 GB | NTFS | MS Windows System |
| 4 | 48 GB | NTFS | data for MS Windows and Linux |
| 5 | 30 GB | ext4 | / (Linux root) |
| 6 | 2 GB | Linux swap | Linux swap  |

**80 GB hard disk**

| partition | size | formatting | usage |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 40 GB | NTFS | MS Windows System |
| 4 | 10 GB | NTFS | data for MS Windows and Linux |
| 5 | 28 GB | ext4 | / (Linux root) |
| 6 | 2 GB | Linux Swap | Linux Swap |

**Linux alone**

**500 GB hard disk:**

| partition | size | formatting | usage |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 30 GB | ext4 | / |
| 4 | 250 GB | ext4 | Data_1 |
| 5 | 216 GB | ext4 | Data_2 |
| 6 | 4 GB | Linux Swap | Linux Swap |

**160 GB hard disk**

| partition | size | formatting | usage |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 1 | 26 GB | ext4 | / |
| 3 | 130 GB | ext4 | data |
| 4 | 4 GB | Linux Swap | Linux Swap |

**60 GB hard disk**

| partition | size | formatting | usage |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 25 GB | ext4 | / |
| 4 | 33 GB | ext4 | data |
| 5 | 2 GB | Linux Swap | Linux Swap |

### Partitioning programs

+ **GParted** An easy to use partitioning program with a graphical interface.  
  *Gparted* is available on all siduction installations and installation media equipped with a graphical user interface. *Gparted* supports a number of different types of partition tables. The manual page [Partitioning the hard disk with GParted](0312-part-gparted_en.md#partitioning-with-gparted) provides more information about the program.

+ **KDE Partition Manager** A Qt based, easy to use partitioning program with a graphical user interface.  
  The *KDE Partition Manager* is the standard partitioning program for the KDE Destktop, easy to use and as comprehensive as *Gparted*.

+ **gdisk / cgdisk** A console program for partition tables of the type *GPT - UEFI*.  
  *gdisk* is the classic text mode program. *cgdisk* has a more user friendly ncurses interface. The manual page [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk) provides more information about the program.

+ **fdisk / cfdisk** A console program for partition tables of the type *msdos - MBR*.  
  Note: *fdisk* should only be used for old hardware that does not support *GPT - UEFI*.  
  *fdisk* is the classic text mode program. *cfdisk* has a more user-friendly ncurses interface. The manual page [Partitioning with Cfdisk](0314-part-cfdisk_en.md#partitioning-with-fdisk) provides more information about the program.

> **Caution**  
> When using any partitioning software there is a risk of data loss. Always back up data that is still needed to another disk first.

**Mounted partitions** (also swap) must be detached before editing.  
In the terminal (as root) with the command:

~~~
# umount /dev/sda1
~~~

The mount of a swap partition is solved with this command: 

~~~
# swapoff -a
~~~

### Further information

[Here the comprehensive english documentation of GParted](https://gparted.org/index.php)

For more partitioning options see:

+ Logical Volume Manager [LVM partitioning](0315-part-lvm_en.md#lvm-partitioning---logical-volume-manager)

+ Partitioning with GPT to support UEFI [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk)

<div id="rev">Last edited: 2021/26/08</div>
