% Quick installation

## Quick installation

### Five steps to the goal

1) Select the preferred flavor on the [siduction download page](https://siduction.org/installation-media/) and download the ISO file and the file with the associated checksum.  
  Then check the download as described [here](0206-iso-dl_en.md#integrity-check).

2) Transfer the ISO file to a bootable medium.  
  The instructions for [a USB stick or an SD card](0207-iso-to-usb-sd_en.md#iso-to-usb-stick---memory-card) or for [burning to a DVD](0208-iso-to-dvd_en.md#burn-iso) offer help.  

3) Boot the siduction Live medium created in this way.  
  **Important:**  
  During the boot process, call up the EFI menu (depending on the manufacturer, press one of the keys **`Del`**, **`F2`**, **`F11`**...).  
  In the EFI menu, deactivate both the *CSM (Compatibility Support Module)* mode and *Secure Boot*.  
  Also select the Live Medium for booting in the EFI menu.

4) Set the desired language in the boot menu of the live medium and boot siduction.  
  The user in the live medium is **siducer** and his password is **live**.  
  No password is set for the user **root** (system administrator) in the live medium. In the terminal, either execute **`sudo <command>`** or become root by entering **`su`**.

5) Double-click on the **`Install system`** icon to start the installation on the hard disk.  
  If partitioning manually, make sure that the first partition is the EFI system partition (esp) and that the *boot* and *esp* marks are set. It must be mounted under `/boot/efi/`.

<div id="rev">Last edited: 2023/11/15</div>
