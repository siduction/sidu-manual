% siduction ISO burn

## Burn ISO

Before burning the ISO image file to a DVD, you should always check it using the md5sum or sha256sum provided by siduction. This may save a lot of time troubleshooting a changed or corrupted file.  
Detailed instructions can be found in the manual chapter [ISO Download, Integrity Check](0206-iso-dl_en.md#integrity-check).

> **IMPORTANT INFORMATION:**  
> siduction, as a Linux LIVE DVD, is very heavily compressed. For this reason, special attention must be paid to the burning method of the image. Please use high quality media, burning in DAO mode (disk-at-once), and not faster than eight times (8x).

We recommend, however, if the hardware supports booting from USB, to put the image on a USB stick or SD memory card. Instructions for this can be found on the manual page [ISO to USB stick / memory card](0207-iso-to-usb-sd_en.md#iso-to-usb-stick---memory-card).

### Burn DVD with Linux

If you already have Linux on your computer, you can create the DVD with any installed burning program. Depending on the desktop environment, these are the programs  
+ **`K3b`** for KDE  
+ **`Brasero`** for Gnome  
+ **`Xfburn`** for XFCE, LXQt, and Gnome

The burning programs are largely self-explanatory in their operation.  
In K3b you select `More actions...` -\> `Write image...`.  
In Xfburn and Brasero you should click `Burn image`.  
Then select the ISO file to be burned (e.g. siduction-21.3.0-wintersky-kde-amd64-202112231751.iso) and set the burning mode `DAO` (Disk At Once) or `Automatic` and start the burning process.

Occasional problems when burning the live DVD are mostly caused by the graphical frontend applications. This can be worked around by using the very easy to use script `burniso` on the console. The manual page [Burn DVD without GUI](0209-no-gui-burn_en.md#burn-live-dvd-without-gui) explains the use of burniso briefly and exactly, as well as other commands to detect available hardware, compile data, and burn CD/DVDs.

### Burn DVD with Windows

Of course, you can also burn the DVD on Windows. The downloaded file must be burned to a DVD as an ISO image and not from Windows Explorer as a file.  
There are several good programs that extend the built-in CD and DVD burning feature introduced with Windows Vista to burn ISO files. Here are just two examples.

+ The current version of the open source software [cdrtfe](https://cdrtfe.sourceforge.io/cdrtfe/index_de.html) is compatible with Windows Vista, 7, 8, 10, and 11. The program can be used to burn ISO images-en, create data discs (CD, DVD, BD), and audio as well as video CD/DVDs. You can install it on Windows or download the zip archive and run `cdrtfe` after unpacking it without any further installation.  
+ The closed-source software `CDBurnerXP` is a free program that can create data and audio CD/DVDs in addition to burning ISO images-en, and erases rewritable media if necessary. Available from [CDBurnerXP](https://cdburnerxp.de.uptodown.com/windows).

<div id="rev">Last edited: 2023/11/10</div>
