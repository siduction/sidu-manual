% Content of the live ISO

## Contents of the Live-ISO

### Note about the software on the Live-ISO

siduction provides DFSG-free software on the Live-ISO as well as non-free firmware. To uninstall proprietary software, use the command **`apt purge $(vrms -s)`** or our script **`remove-nonfree`** after installation.

The ISO is based exclusively on the latest Debian Sid at the time of release, enriched and stabilized with custom packages and scripts from the siduction repositories. The kernel we use is a patched version of the latest vanilla mainline kernel. ACPI and DMA are enabled.

A complete manifest file with a list of all installed programs for each release variant of siduction can be found on each download mirror.

### Variants of the ISO

siduction offers seven current images-en in 64-bit as live ISO to get started with Debian Sid. Five of the images come with a preinstalled desktop environment. Typically, an installation takes between 1 and 10 minutes, depending on the hardware.  
The alternatives are:

1. **KDE Plasma 64-bit**, live-ISO with about 2.8 GByte:
   - Qt based Plasma Desktop and KDE frameworks; with a representative selection of KDE Applications
   - installation of additional applications easily possible via apt

2. **Xfce 64-bit**, live-ISO with about 2.3 GByte:
   - includes a GTK based desktop environment with all features (no minimal version!) and all productivity applications right away
   - resource requirements lower than for KDE
   - installation of additional applications easily possible via apt

3. **LXQt 64-bit**, live ISO with about 2.2 GByte:
   - includes desktop environment with a selection of Qt applications
   - footprint somewhat smaller than with Xfce
   - installation of additional applications easily possible via apt

4. **Xorg 64-bit**, live ISO with about 1.8 GByte:
   - ISO image with an Xorg stack and the spartan window manager Fluxbox
   - for users who want to build their system according to their own ideas

5. **NoX 64-bit**, live ISO with about 800 MByte: 
   - as the name implies, no pre-installed Xorg stack

**32-bit ISOs** are no longer offered by default.  
If a 32bit ISO is desired, we will gladly create one on request in IRC. Unfortunately, we cannot test such an ISO.

### Minimum system requirements

for: KDE-Plasma, Mate, Xfce, LXQt, LXDE, Cinnamon, Xorg, and NoX

**Processor requirements: 64Bit CPU**

AMD64  
Intel Core2  
Intel Atom 330  
any x86-64/ EM64T capable CPU or newer  
newer 64-bit capable AMD or Intel CPUs  
(look for the "lm" flag in /proc/cpuinfo or use inxi -v3)

**Memory requirements**

~~~
KDE Plasma at least   4 GByte RAM
Xfce       at least   4 GByte RAM
LXQt       at least 512 MByte RAM
Xorg       at least 512 MByte RAM
NoX        at least 256 MByte RAM
~~~

At least  5 GByte hard disk space for NoX  
At least 15 GByte of disk space for all the others.  
At least 50 GBytes of disk space when installing on a partition formatted with Btrfs.

**Other**

VGA graphics card with at least 640x480 pixel resolution and optical drive or USB media.

### Applications and utilities

As web browser, [Firefox](https://mozilla.org) or [Chromium](https://chromium.woolyss.com/download/de/#linux) is included (depending on the variant).

LibreOffice is pre-installed as office software. Dolphin, Thunar, and PCManFM are available as file managers.

Network Manager, Connman or iwd is available for network and internet configuration. The WLAN daemon used is `iwd`.

For disk partitioning, [cfdisk](0314-part-cfdisk_en.md#partitioning-with-fdisk), [gdisk and cgdisk](0313-part-gdisk_en.md#partitioning-with-gdisk), and [GParted](0312-part-gparted_en.md#partitioning-with-gparted) are supplied. Gparted also provides the ability to resize NTFS partitions.

System analysis tools such as [Memtest86+](http://www.memtest.org/) (a tool for comprehensive memory analysis) are included, too.

Each ISO variant contains an extensive selection of applications for the command line. A complete manifest file with the installed programs for each release variant of siduction can be found on each download mirror.

### Disclaimer

siduction is experimental software. Use at your own risk. The siduction project, its developers, and team members cannot be held liable under any circumstances for damage to hardware or software, lost data, or any other direct or indirect damage to the user by using this software. Anyone who does not agree to these terms may not use or distribute this software.

<div id="rev">Last edited: 2023-11-07</div>
