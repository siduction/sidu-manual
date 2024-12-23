%release notes

## release notes 2024.1.0  Shine on ...

The siduction team is pleased to introduce a new release. It has been some time since the last release. The reason for this delay is that we were waiting for KDE Plasma 6 in Debian Unstable. Although Plasma 6 was released at the end of February 2024, its release in Unstable was delayed by about four months due to the [t64 transition in Debian](https://wiki.debian.org/ReleaseGoals/64bit-time), which you probably remember. But now it’s here, and Plasma 6.2 has been available in Unstable for about two weeks.  
The username and password for the Live Session are siducer/live.

### What to expect in siduction 2024.1.0

First, a few words about the new artwork of siduction 2024.1.0 titled "Shine on…". The famous album by Pink Floyd inspired this design. And if you now have an earworm... you're welcome :)  
The wallpaper [Nexus](https://invent.kde.org/plasma/breeze/-/commit/aec3e3d93eb79042c6dbf14c9c1f6fffd2c3a86d) by Krystian Zajdel serves as the basis. We have adapted it for siduction, paying tribute to the KDE developers, who have again put tremendous work into the project this year, making it the best desktop environment for us. If you agree, please consider [donating or supporting KDE](https://kde.org/de/donate/).

### siduction Editions

The flavors we offer for siduction 2024.1.0 include KDE Plasma 6.2.4.1, LXQt 2.1.0-1, Xfce 4.20, Xorg, and noX. GNOME, MATE, and Cinnamon have not made it again, as there is no maintainer for them within siduction. If you're interested, please contact us. They may return one day or not. Of course, they are still installable from the repository.

The released images of siduction 2024.1.0 are a snapshot of Debian Unstable, also known as Sid, from December 23, 2024. They are enriched with useful packages and scripts, a Calamares-based installer, and a customized version of the Linux kernel 6.12.6, while systemd is at version 257.1-3.

**KDE Plasma 6**

Plasma 6 has now nearly fully arrived in Unstable and Testing and will be available for Debian 13 "Trixie." Although Wayland is the default session type in Plasma 6, we have opted for X11 as the default, as Calamares currently does not take the desired keyboard layout under Wayland. This could have severe consequences in encrypted installations. However, you can always switch to Wayland in SDDM.  
As existing users, you've likely already upgraded to Plasma 6, and now the current Plasma generation is also available for fresh installations.

Known bugs: Dolphin currently cannot connect via smb://. As a workaround, you can use sftp. The bug lies in the kio-extras package.

**Xfce 4.20**

The newly released [Xfce 4.20](https://linuxnews.de/xfce-4-20-wayland-unterstuetzung-und-noch-viel-mehr/) from December 15 barely made it into Unstable and therefore into our new release. The new Xfce release focuses, among other things, on the initial, still experimental support for Wayland. Also, the Thunar file manager received significant improvements.

Known bugs: Unfortunately, the Wayland implementation is currently so experimental that the session doesn't start. We have blocked Wayland for now. If this bug is fixed, we will re-enable it in a point release.

**LXQt 2.1**

LXQt is the lightweight sibling of KDE Plasma. The desktop, developed over ten years, offers a usable but still experimental Wayland session in [version 2.1.0](https://linuxnews.de/lxqt-2-1-0-unterstuetzt-sieben-wayland-compositoren/).

### siduction-btrfs improvements

When using the Btrfs filesystem with siduction, we allow you to manage your snapshots with the SUSE-developed tool [Snapper](https://documentation.suse.com/sles/12-SP5/html/SLES-all/cha-snapper.html), which has its own chapter in the [siduction manual](https://manual.siduction.org/index_en.html) under System Administration → Btrfs and Snapper.

siduction-btrfs be used on systems with MBR and GPT partition tables, with or without a separate /boot partition.  
Since version 0.3.0, siduction-btrfs uses the Snapper plugin directory.

*With the GRUB boot manager*  
After a rollback, the file */boot/grub/grub.cfg* is recreated in the rollback target using chroot and then GRUB is reinstalled from the rollback target. This allows the user to access the rollback target directly with a simple reboot. All other subvolumes, including the previously used one, can be accessed via the *siduction snapshots* submenu.  
If the file */boot/grub/grub.cfg* is updated during software installation or upgrade, the*grub-menu-title* script will add the flavor and subvolume to the menu line of the default boot entry.

*With the systemd-boot boot manager*  
After a rollback, the *rollback-sd-boot* script creates the boot entries. It takes into account all the kernels in the new snapshot. The default boot entry is set to the default subvolume.  
If a subvolume is deleted for which boot entries existed, those entries will be removed.

*Snapper Snapshot Description*  
After an APT action, the *snapshot-description* script changes the description displayed by Snapper (apt) to a more meaningful text.

**ChangeLog of changes:**

- siduction-btrfs (0.2.0) unstable; urgency=medium
  - Added support for systemd-boot.
  - Removed installation dependencies for grub-common and grub-btrfs.  
    Both enable the complete switch from GRUB to systemd-boot.
  - Improved description of snapshots in Snapper.

- siduction-btrfs (0.3.0-1) unstable; urgency=medium
  - Rewritten to use the Snapper plugin directory.
  - Added support for a boot partition when using GRUB.

### Non-free and Contrib

The following non-free and contrib packages are installed by default:

**Nonfree:**

- amd64-microcode – Processor microcode firmware for AMD CPUs
- firmware-amd-graphics – Binary firmware for AMD/ATI graphics chips
- firmware-atheros – Binary firmware for Atheros wireless cards
- firmware-bnx2 – Binary firmware for Broadcom NetXtremeII
- firmware-bnx2x – Binary firmware for Broadcom NetXtreme II 10Gb
- firmware-brcm80211 – Binary firmware for Broadcom 802.11 wireless card
- firmware-crystalhd – Crystal HD Video Decoder (firmware)
- firmware-intelwimax – Binary firmware for Intel WiMAX Connection
- firmware-iwlwifi – Binary firmware for Intel Wireless cards
- firmware-libertas – Binary firmware for Marvell Libertas 8xxx wireless car
- firmware-linux-nonfree – Binary firmware for various drivers in the Linux kernel
- firmware-misc-nonfree – Binary firmware for various drivers in the Linux kernel
- firmware-myricom – Binary firmware for Myri-10G Ethernet adapters
- firmware-netxen – Binary firmware for QLogic Intelligent Ethernet (3000)
- firmware-qlogic – Binary firmware for QLogic HBAs
- firmware-realtek – Binary firmware for Realtek wired/wifi/BT adapters
- firmware-ti-connectivity – Binary firmware for TI Connectivity wireless network
- firmware-zd1211 – binary firmware for the zd1211rw wireless driver
- intel-microcode – Processor microcode firmware for Intel CPUs

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

<div id="rev">Last edited: 2024-12-23</div>
