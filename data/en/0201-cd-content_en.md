BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC1**

Necessary work:

+ check intern links  
+ check extern links  
+ check layout  
+ check spelling  

Work done


END   INFO AREA FOR THE AUTHORS  
% Content of the live ISO

## Contents of the Live-ISO

### Note about the software on the Live-ISO

siduction provides DFSG-free software on the Live-ISO as well as non-free firmware. To uninstall proprietary software use the command **`apt purge $(vrms -s)`** or our script **`remove-nonfree`** after installation.

The ISO is based exclusively on the latest Debian Sid at the time of release, enriched and stabilized with custom packages and scripts from the siduction repositories. The kernel is the latest vanilla mainline kernel and is patched. ACPI and DMA are enabled.

A complete manifest file listing all installed programs for each release variant of siduction can be found on each download mirror.

### Variants of the ISO

siduction offers seven current images with different desktop environments (two also without) in 64-bit as live ISO to get started with Debian Sid. Typically, an installation takes between 1 and 10 minutes, depending on the hardware.  
The variants are:

1. **KDE 64 bit** , live-ISO with about 2.8 GByte:
    - Qt based Plasma Desktop and KDE frameworks. With a representative selection of KDE Applications.  
    - Installation of additional applications is possible without problems via apt.

2. **Cinnamon with 64 bit** , live ISO with about 2.3 GByte:
     - GTK-based desktop with a representative selection of useful software.  
     - Installing additional applications is possible without problems via apt.

3. **XFCE 64 Bit** , live-ISO with about 2.3 GByte:
    - Includes a GTK based desktop environment with all features (no minimal version!) and all applications to be productive right away.  
    - The resource requirements are lower than with KDE.  
    - The installation of additional applications is possible without problems via apt.

4. **LXQt with 64 bit** , live ISO with about 2.2 GByte:
     - Includes a desktop environment with a selection of Qt applications.  
     - The footprint is somewhat narrower than XFCE.
     - Installation of additional applications is possible without problems via apt.

5. **LXde with 64 bit** , live ISO with about 2.2 GByte:
     - Includes a desktop environment with a selection of GTK applications.  
     - The footprint is narrower than with XFCE
     - suitable for older hardware
     - Installation of additional applications is possible without problems via apt.

6. **Xorg with 64 bit** , live ISO with about 1.8 GByte:
      - An ISO image with an Xorg stack and the spartan window manager Fluxbox.  
      - For users who want to build their system according to their own ideas

7. **NoX with 64 bit** , live ISO with about 800 MByte: 
      - As the name implies, no pre-installed Xorg stack.

**32 bit ISO's** we no longer offer by default.  
If a 32bit IOS is desired, we will gladly create one on request in IRC. Unfortunately we cannot test such an ISO.

### Minimum system requirements

for: KDE-Plasma, Mate, XFCE, LXQt, Lxde, Cinnamon, Xorg and NoX

#### Processor requirements: 64Bit CPU

    AMD64  
    Intel Core2  
    Intel Atom 330  
    any x86-64/ EM64T capable CPU or newer  
    newer 64 bit capable AMD Sempron and Intel Pentium 4 CPUs  
    (look for the "lm" flag in /proc/cpuinfo or use inxi -v3).

#### Memory requirements

    KDE plasma: ≥ 4 GByte RAM
    Mate:       ≥ 4 GByte RAM
    Cinnamon: ≥ 4 GByte RAM
    XFCE: ≥ 4 GByte RAM
    LXQT: ≥ 512 MByte RAM
    Lxde ≥ 512 MByte RAM
    Xorg: ≥ 512 MByte RAM
    NoX: ≥ 256 MByte RAM

    ≥ 5 GByte hard disk space for NOX
    ≥10 GBytes of disk space for all others.

#### Other

    VGA graphics card with at least 640x480 pixel resolution.
    Optical drive or USB media.

### Applications and utilities

As an Internet browser, [Firefox](https://mozilla.org), or [Chromium](https://chromium.woolyss.com/download/de/#linux) are included (depending on the variant).

Libreoffice is pre-installed as office software. Dolphin, Thunar and PCManFM are available as file managers.

Connman or Network Manager is available for network and Internet configuration.

Xorg and nox are delivered with [IWD](0502-inet-iwd_en.md#iwd-statt-wpa_supplicant) as, this can be configured via [nmtui/nmcli](0501-inet-nm-cli_en.md#network-manager-kommandline-tool) or [iwctl](0502-inet-iwd_en.md#iwd-statt-wpa_supplicant). 

For partitioning disks, [cfdisk](./part-cfdisk_en.md#partition-with-fdisk), [gdisk and cgdisk](./part-gdisk_en.md#partition-with-gdisk) and [GParted](./part-gparted_en.md#partition-with-gparted) are supplied. Gparted also provides the ability to resize NTFS partitions.

System analysis tools such as [Memtest86+](http://www.memtest.org/) (a tool for comprehensive memory analysis) are also included.

Each ISO variant contains an extensive selection of applications for the command line. A complete manifest file with the installed programs for each release variant of siduction can be found on each download mirror.

### Disclaimer_Disclaimer

siduction is experimental software. Use at your own risk. The siduction project, its developers and team members cannot be held liable under any circumstances for damage to hardware or software, lost data or any other direct or indirect damage to the user by using this software. Anyone who does not agree to these terms may not use or distribute this software.

<div id="rev">Last edited: 2021-13-08</div>
