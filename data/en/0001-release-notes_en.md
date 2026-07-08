% release notes

## release notes 2026.1.0 Big Crime

The siduction team is pleased to finally present a new release to you. More time has passed since the last release than we had planned.

Traditionally, Big Crime was supposed to be released between Christmas and New Year's. Due to time constraints on the part of those involved, the release is only coming out now. The new image is available [for download]().

### What to expect in siduction 2026.1.0

First, a few words about the new artwork for siduction 2026.1.0, titled “Big Crime.” It is inspired by the song of the same name by Neil Young, in which he sharply criticizes the policies of the current U.S. administration. The wallpaper was generated using Gemini AI.

### siduction Editions

The flavors we offer for siduction 2026.1.0 are KDE Plasma 6.7, LXQt 2.3.0, Xfce 4.20, Xorg, and NOX. GNOME, MATE, and Cinnamon didn’t make the cut again, as there is no maintainer for them within siduction. If you’re interested, please get in touch. Maybe they’ll make a comeback someday. Of course, they can still be installed from the repository.  
The released images of siduction 2026.1.0 are a snapshot of Debian Unstable—also known as Sid—from July xx, 2026. They include several useful packages and scripts, a Calamares-based installer, the revised cli-installer, and a customized version of the Linux kernel 7.x.x, while systemd is at version v261~rc3-1.

+ **KDE Plasma 6.7**  
  We ultimately decided to wait for Plasma 6.7 before releasing this version. This new major release marks a turning point in that it is the last major version of KDE Plasma to still offer an X11 session. With Plasma 6.8, scheduled for release in early 2027, Wayland will be the sole standard.  
  Users who are still experiencing issues with certain applications under Wayland can switch to Xfce, which does not yet use Wayland by default.  
  A fork called [SonicDE](https://github.com/Sonic-DE) is currently being developed on GitHub; it can already be installed in the Unstable branch, but we haven’t tested it yet. Feel free to share your experiences with it in the forum.

+ **Xfce 4.20**  
  Xfce remains true to its slow release cycle and, as with the last release, is still at [Xfce 4.20](https://linuxnews.de/xfce-4-20-wayland-unterstuetzung-und-noch-viel-mehr/). It still offers experimental support for Wayland, which has been further expanded since the release. In addition, the Thunar file manager, among other components, has received significant improvements.

+ **LXQt 2.3.0**  
  LXQt is the lightweight counterpart to KDE Plasma. The desktop, which has been in development for ten years, also offers a Wayland session in [Version 2.3.0](https://linuxnews.de/lxqt-2-3-0-mit-mehr-wayland-unterstuetzung/) that is still classified as experimental. Improvements to Wayland support have continued, particularly in the LXQt panel, whose desktop switcher is now enabled for the labwc and niri tiling compositors, and there is a new IPC (interprocess communication)-based backend for Wayfire.

+ **Xorg**  
  Insert text

+ **NOX**  
  With the updated cli-installer (see below), installation on a UEFI GPT system is possible. In addition, users can choose between the *systemd-boot* and *GRUB* boot managers.

### cli-installer

For siduction 2026.1.0, the cli-installer was completely modernized. It is included in all flavors.  
With the inclusion of Calamares as the graphical installer, the underlying fll-installer became increasingly obsolete. As a result, both the cli-installer and the fll-installer have remained virtually unchanged since 2018. Since siduction intends to continue offering a NOX flavor, the cli- and fll-installers required a fundamental overhaul to incorporate the latest features.

To clarify: While the *cli-installer* provides the user interface, the *fll-installer* is the actual tool running in the background that writes the data to the hard drive.

A particular highlight is the integrated boot manager, systemd-boot, which is thus available for installation in all flavors. If you have a simple hardware setup, systemd-boot is a good choice.  
The revised cli-installer guides the user through the configuration, suggests appropriate actions, checks dependencies and conditions, and provides information about the settings that have been made. You can cancel the program at any time.

**Key changes:**  
+ Updated outdated commands, prompts, and dialogs.  
+ Nonfree sources are now opt-in.  
+ Full support for UEFI GPT.  
+ Support for the Btrfs file system, including the creation of subvolumes as is standard in siduction.  
+ Choice of boot managers: systemd-boot and GRUB.  
+ Consistent user interface design across all dialogs.  
+ Certain components of the graphical user interface have been removed.

### Btrfs filesystem

When using the Btrfs file system with siduction, we allow you to manage your snapshots using [Snapper](https://documentation.suse.com/sles/12-SP5/html/SLES-all/cha-snapper.html), a tool developed by SUSE, which has its own chapter in the [siduction manual](https://manual. siduction.org/index_en.html) under *System Administration → Btrfs and Snapper*. A new addition is the *Btrfs Assistant* program, which is available to users in the graphical interfaces and replaces *snapper-gui*.

**Excerpt from the siduction-btrfs info-md:**

siduction-btrfs can be used on systems with MBR and GPT partition tables, with or without a separate /boot partition.

Since version 0.3.0, siduction-btrfs has been using the Snapper plugin directory.

*When using the GRUB boot manager*  
After a rollback, the file */boot/grub/grub.cfg* is recreated in the rollback target using chroot and then GRUB is reinstalled from the rollback target. This allows the user to access the rollback target directly with a simple reboot. All other subvolumes, including the previously used one, can be accessed via the *siduction snapshots* submenu.  
If the file */boot/grub/grub.cfg* is updated during software installation or upgrade, the*grub-menu-title* script will add the flavor and subvolume to the menu line of the default boot entry.

*When using the systemd-boot boot manager*  
After a rollback, the *rollback-sd-boot* script creates the boot entries. It takes into account all the kernels in the new snapshot. The default boot entry is set to the default subvolume.  
If a subvolume is deleted for which boot entries existed, those entries will be removed.

*Snapper Snapshot Description*  
After an APT action, the *snapshot-description* script changes the description displayed by Snapper (apt) to a more meaningful text.

**ChangeLog of changes:**

*siduction-btrfs (0.2.0) unstable; urgency=medium*  
+ Added support for systemd-boot.
+ Removed installation dependencies on grub-common and grub-btrfs.
    + Both allow for a complete switch from GRUB to systemd-boot.
+ Improved description of snapshots in Snapper.

*siduction-btrfs (0.3.0-1) unstable; urgency=medium*  
+ Rewritten to use the Snapper plugin directory.
+ Added support for a boot partition when using GRUB.

### Non-free and Contrib

The following non-free and contrib packages are installed by default:

**Nonfree:**

+ amd64-microcode – Processor microcode firmware for AMD CPUs
+ firmware-amd-graphics – Binary firmware for AMD/ATI graphics chips
+ firmware-atheros – Binary firmware for Atheros wireless cards
+ firmware-bnx2 – Binary firmware for Broadcom NetXtremeII
+ firmware-bnx2x – Binary firmware for Broadcom NetXtreme II 10Gb
+ firmware-brcm80211 – Binary firmware for Broadcom 802.11 wireless card
+ firmware-crystalhd – Crystal HD Video Decoder (firmware)
+ firmware-intelwimax – Binary firmware for Intel WiMAX Connection
+ firmware-iwlwifi – Binary firmware for Intel Wireless cards
+ firmware-libertas – Binary firmware for Marvell Libertas 8xxx wireless car
+ firmware-linux-nonfree – Binary firmware for various drivers in the Linux kernel
+ firmware-misc-nonfree – Binary firmware for various drivers in the Linux kernel
+ firmware-myricom – Binary firmware for Myri-10G Ethernet adapters
+ firmware-netxen – Binary firmware for QLogic Intelligent Ethernet (3000)
+ firmware-qlogic – Binary firmware for QLogic HBAs
+ firmware-realtek – Binary firmware for Realtek wired/wifi/BT adapters
+ firmware-ti-connectivity – Binary firmware for TI Connectivity wireless network
+ firmware-zd1211 – binary firmware for the zd1211rw wireless driver
+ firmware-sof-signed - Intel audio firmware
+ intel-microcode – Processor microcode firmware for Intel CPUs

**Contrib:**

- b43-fwcutter – utility for extracting Broadcom 43xx firmware
- firmware-b43-installer – firmware installer for the b43 driver
- firmware-b43legacy-installer – firmware installer for the b43legacy driver
- iucode-tool – Intel processor microcode

**Remove Non-Free Content**

Currently, the installer does not offer an option to deselect packages that do not comply with the DFSG, the Debian Free Software Guidelines. This means that non-free packages, such as proprietary firmware, are installed by default on the system. The command vrms will list these packages for you. You can manually uninstall unwanted packages or remove them all by entering `apt purge $(vrms -s)` before or after installation. Otherwise, our script `remove-nonfree` can do this for you later.

### Installation Notes and Known Issues

If you want to reuse an existing home partition (or another data partition), do so after the installation, not in the Calamares installer.  
On some Intel graphics processors on certain devices, the system may freeze shortly after booting into Live. To fix this, you need to set the kernel parameter `intel_iommu=igfx_off` before rebooting.

<div id="rev">Last edited: 2026-07-08</div>
