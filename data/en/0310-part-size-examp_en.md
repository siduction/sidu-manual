% Partitioning of installation media

## Partitioning of installation media

For Linux beginners, we recommend to create only two partitions (root/home and swap) because this makes a first installation much easier. After the installation, additional data partitions or, if desired, a separate /home can be created.

However, we do not recommend to create a /home partition.  
The directory **/home** should be the place where the individual configurations are stored, and only them. A separate data partition should be created for all other private data. The advantages for data stability, data backup and also in case of data recovery are immeasurable.

A swap partition has a similar function as the Windows swap file, but the former is far more effective. As a rule of thumb, the swap partition should be twice as large as the RAM used. This applies mainly to notebooks that are to be hibernated via *hibernate* or desktop computers with very little RAM (1 GByte or less). Devices with sufficient RAM no longer need a swap partition.

For data exchange with a Windows installation, the designated partition should be formatted with **ntfs**. Siduction can read from and write to such a partition with the automatically installed *ntfs-3g*.

There are many good ways to partition your disks. These examples should give a first insight into the possibilities. 

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

### Examples with different disk sizes

If a dual boot with MS Windows&#8482; is created, MS Windows must always be installed as the first system onto the hard disk.

"*GPT*" should be selected as partition table type. Thus, you can use the advantages over "*MBR*". Only with old hardware, "*MBR*" is still useful. The explanations for this can be found on our manual page [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk).

The examples refer to partition tables of the type "*GPT*". It needs the first two, very small partitions in order to function.

**Dual-boot with MS Windows and Linux**

**1 TB hard disk:**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 50 GB | NTFS | MS Windows system |
| 4 | 300 GB | NTFS | data for MS Windows |
| 5 | 200 GB | NTFS | data for MS Windows and Linux |
| 6 | 30 GB | ext4 | / (Linux root) |
| 7 | 416 GB | ext4 | data for Linux |
| 8 | 4 GB | Linux swap | Linux swap |

**120 GB hard disk:**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 40 GB | NTFS | MS Windows System |
| 4 | 48 GB | NTFS | data for MS Windows and Linux |
| 5 | 30 GB | ext4 | / (Linux root) |
| 6 | 2 GB | Linux swap | Linux swap  |

**80 GB hard disk**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 40 GB | NTFS | MS Windows system |
| 4 | 10 GB | NTFS | data for MS Windows and Linux |
| 5 | 28 GB | ext4 | / (Linux root) |
| 6 | 2 GB | Linux Swap | Linux swap |

**Linux alone**

**500 GB hard disk:**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 30 GB | ext4 | / |
| 4 | 250 GB | ext4 | Data_1 |
| 5 | 216 GB | ext4 | Data_2 |
| 6 | 4 GB | Linux Swap | Linux swap |

**160 GB hard disk**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 1 | 26 GB | ext4 | / |
| 3 | 130 GB | ext4 | data |
| 4 | 4 GB | Linux Swap | Linux swap |

**60 GB hard disk**

| Partition | Size | File system | Use |
| :----: | ----: | :----: | :----: |
| 1 | 100 KB | FAT16 | EFI system |
| 2 | 1 MB | without | BIOS-boot |
| 3 | 25 GB | ext4 | / |
| 4 | 33 GB | ext4 | data |
| 5 | 2 GB | Linux Swap | Linux swap |

### Partition editors

+ **GParted**: An easy to use partition editor with a graphical interface.  
  *Gparted* is available on all siduction installations and installation media equipped with a graphical user interface. It supports a number of different partition table types. The manual page [Partitioning the hard disk with GParted](0312-part-gparted_en.md#partitioning-with-gparted) provides more information about the program.

+ **KDE Partition Manager**: A Qt based, easy to use partition editor with a graphical user interface.  
  The *KDE Partition Manager* is the standard partition editor for the KDE Destktop and as comprehensive as *Gparted*.

+ **gdisk / cgdisk**: A console program for partition tables of the type *GPT - UEFI*.  
  *gdisk* is the classic text mode program, while *cgdisk* has a more user friendly ncurses interface. The manual page [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk) provides more information about the program.

+ **fdisk / cfdisk** A console program for partition tables of the type *msdos - MBR*.  
  Note: *fdisk* should only be used for old hardware that does not support *GPT - UEFI*.  
  *fdisk* is the classic text mode program, while *cfdisk* has a more user-friendly ncurses interface. The manual page [Partitioning with Cfdisk](0314-part-cfdisk_en.md#partitioning-with-fdisk) provides more information about the program.

> **Caution**  
> When using any partitioning software, there is a risk of data loss. Always back up still needed data to another disk in advance.

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

For more partitioning options see:

+ Logical Volume Manager [LVM partitioning](0315-part-lvm_en.md#lvm-partitioning---logical-volume-manager)

+ Partitioning with GPT to support UEFI [Partitioning with gdisk](0313-part-gdisk_en.md#partitioning-with-gdisk)

<div id="rev">Last edited: 2022/01/15</div>
