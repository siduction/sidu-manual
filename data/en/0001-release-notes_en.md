% release notes

## release notes 2026.1.0 Big Crime

The siduction team is pleased to finally present a new release to you. More time has passed since the last release than we had planned.

Traditionally, Big Crime was supposed to be released between Christmas and New Year's. Due to time constraints on the part of those involved, the release is only coming out now. The new image is available [for download]().

### What to expect in siduction 2026.1.0

First, a few words about the new artwork for siduction 2026.1.0, titled “Big Crime.” It is inspired by the song of the same name by Neil Young, in which he sharply criticizes the policies of the current U.S. administration. The wallpaper was generated using Gemini AI.

### siduction Editions

The editions we offer with siduction 2026.1.0 are KDE Plasma 6.7.4, Xfce 4.20, Xorg, and NOX. Unfortunately, GNOME, MATE, and Cinnamon did not make it into the selection because there are no maintainers for them within siduction. If you are interested or know someone who might be, please get in touch. Perhaps they will return one day. Of course, they can still be installed from the repository.

LXQt is currently not in a release-ready state. We will provide it later once it is ready for release.

The released siduction 2026.1.0 images are snapshots of Debian Unstable, also known as Sid, from October 12, 2026. They include several useful packages and scripts, a Calamares-based installer, a substantially revised CLI installer, and a customized version of Linux kernel 7.2.10, while systemd is at version 262-1.

+ **KDE Plasma 6.7.4**  
  We ultimately waited for Plasma 6.7 before releasing siduction 2026.1.0 “Big Crime”. This new major version marks a turning point, as it is the last major release of KDE Plasma to include an X11 session. Starting with Plasma 6.8, scheduled for release on October 14, Wayland will be the only supported display protocol.  
  Users who still encounter problems with individual applications under Wayland can switch to Xfce, which does not yet use Wayland by default.  
  A fork called [SonicDE](https://github.com/Sonic-DE) is currently being developed on GitHub. It can already be installed in Testing and Unstable, although we have not yet tested it extensively. If you have any experience with it, feel free to share your findings in our forum.

+ **Xfce 4.20**  
  Xfce remains true to its slow release cycle and, as with our previous release, is still at [Xfce 4.20](https://www.xfce.org/about/tour420/). It currently offers an experimental Wayland implementation, which has been further developed since its release. In addition, the Thunar file manager, among other components, has received significant improvements.

+ **Xorg**  
  As before, Xorg provides a way to build your own system based on a preinstalled X server. This currently still works with all the desktop environments we provide, but starting with Plasma 6.8, it will no longer work with KDE and LXQt.  
  Fluxbox serves as the window manager, offering an extremely fast and resource-efficient environment for the X Window System. This also makes Xorg a suitable starting point for users who cannot or do not yet want to use Wayland.

+ **NOX**  
  NOX differs from Xorg in that it does not include an X server. With the revised cli-installer (see below), installation on a modern UEFI/GPT system is now also possible.

### cli-installer

For siduction 2026.1.0, the cli-installer was completely modernized. It is included in all flavors.

A particular highlight is the integrated boot manager, systemd-boot, which is thus available for installation in all flavors. If you have a simple hardware setup, systemd-boot is a good choice.

With the inclusion of Calamares as the graphical installer, the underlying fll-installer became increasingly obsolete. As a result, both the cli-installer and the fll-installer have remained virtually unchanged since 2018. Since siduction intends to continue offering a NOX flavor, the cli- and fll-installers required a fundamental overhaul to incorporate the latest features.  
To clarify: While the *cli-installer* provides the user interface, the *fll-installer* is the actual tool running in the background that writes the data to the hard drive.  
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

**Excerpt from the documentation (info-md) for siduction-btrfs:**

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

### onoff

This small script serves as a replacement for the removed *init* command. **onoff** restores the functionality of `init 0` through `init 6`, which was removed by systemd 258~rc1-1, for users on a running system. To switch to a different system state, simply enter the command `onoff`, followed by the number corresponding to the desired system state, in the terminal with root privileges. Users can avoid the long systemd commands and use the familiar numbers instead.

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

If you opted to install non-free software but later change your mind, you can use the vrms (Virtual Richard Stallman) command to identify non-free packages installed on your system. You can remove unwanted packages manually or use the command `apt purge $(vrms -s)` to remove them all at once, including their configuration files. Our *remove-nonfree* script achieves the same result.

### Installation Notes and Known Issues

If you want to reuse an existing home partition (or another data partition), do so after the installation, not in the Calamares installer.  
On some Intel graphics processors on certain devices, the system may freeze shortly after booting into Live. To fix this, you need to set the kernel parameter `intel_iommu=igfx_off` before rebooting.

<div id="rev">Last edited: 2026-10-15</div>
