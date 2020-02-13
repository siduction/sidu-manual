<div id="main-page"></div>
<div class="divider" id="download-siduction"></div>
## Downloading the siduction ISO

###### **`THIS IS VERY IMPORTANT:`** `siduction, as a Linux LIVE-CD, is based on high compression technology, and because of that, special care is needed when burning the ISO image. Only use high quality CD-media [or DVD+RW] and burn in **`DAO-mode (disk-at-once)`**  and not faster than x8.` 


---

###### Please use your closest mirror. Mirrors with codeboxes underneath them get updated as soon as changes are uploaded (refer to /etc/apt/sources.list.d/siduction.list). We also recommend using our torrent files, if you have no mirror in your country.

#### Europe

+  **Free University Berlin/ spline (Student Project LInux NEtwork), Germany:**   
    [http://ftp.spline.de/pub/siduction/iso](http://ftp.spline.de/pub/siduction/iso)   
    [ftp://ftp.spline.de/pub/siduction/iso](ftp://ftp.spline.de/pub/siduction/iso)   
   rsync://ftp.spline.de/siduction/iso  

~~~  
deb ftp://ftp.spline.de/pub/siduction/base unstable main  
deb ftp://ftp.spline.de/pub/siduction/fixes unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/base unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/fixes unstable main  
~~~

#### North America

+  **`University of Delaware`**   
    [http://mirror.lug.udel.edu/pub/siduction/iso](http://mirror.lug.udel.edu/pub/siduction/iso)   
    [ftp://ftp.lug.udel.edu/pub/siduction/iso](ftp://ftp.lug.udel.edu/pub/siduction/iso) rsync://rsync.lug.udel.edu/siduction/iso  

~~~  
deb ftp://ftp.lug.udel.edu/pub/siduction/base unstable main  
deb-src ftp://ftp.lug.udel.edu/pub/siduction/base unstable main  
deb ftp://ftp.lug.udel.edu/pub/siduction/fixes unstable main  
deb-src ftp://ftp.lug.udel.edu/pub/siduction/fixes unstable main  
~~~

+  **`Georgia Tech`**   
    [http://www.gtlib.gatech.edu/pub/siduction/iso](http://www.gtlib.gatech.edu/pub/siduction/iso)   
    [ftp://ftp.gtlib.gatech.edu/pub/siduction/iso](ftp://ftp.gtlib.gatech.edu/pub/siduction/iso)  rsync://rsync.gtlib.gatech.edu/siduction/iso  

#### South America

+  **`Universidade Estadual de Campinas (unicamp), São Paulo, Brasilien`**   
    [http://www.las.ic.unicamp.br/pub/siduction/iso/](http://www.las.ic.unicamp.br/pub/siduction/iso/)   
    [ftp://www.las.ic.unicamp.br/pub/siduction/iso/](ftp://www.las.ic.unicamp.br/pub/siduction/iso/)   

~~~  
deb ftp://www.las.ic.unicamp.br/pub/siduction/base unstable main  
deb-src ftp://www.las.ic.unicamp.br/pub/siduction/base unstable main  
deb ftp://www.las.ic.unicamp.br/pub/siduction/fixes unstable main  
deb-src ftp://www.las.ic.unicamp.br/pub/siduction/fixes unstable main  
~~~

#### Asia

+   

#### Africa

+   

#### Australia

+   

<div class="divider" id="siduction-def"></div>
### Definitions of files on each mirror

Each siduction mirror has following files:

~~~  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
SOURCES  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.arch.manifest  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.iso  
~~~

The `.manifest`  file lists all the packages contained in the specific iso. 

The `.iso`  is the image to download. 

The `MD5SUM and SHA256SUM`  files are to check the integrity of the iso.

The `.gpg`  files are signature files, so you can verify that the checksums have not been changed and that they can be used to verify the integrity of the iso.

The sources tar is only for those who require a static copy of the source code for redistribution purposes to comply with the licensing requirements. Read the SOURCES file for more information.

If anybody has a fast FTP-Server with sufficient traffic at their command, please inform the siduction team on the  [siduction Forums](http://siduction.org/)  or on our IRC-Channel irc.oftc.net:6667 #siduction.

Download-Links and Mirrors are also found on  [siduction.org](http://siduction.org) 

<div class="divider" id="md5"></div>
## md5sum and Validation

###### **`THIS IS VERY IMPORTANT:`** `siduction, as a Linux LIVE-CD, is based on high compression technology, and because of that, special care is needed when burning the ISO image. Only use high quality CD-media [or DVD+RW] and burn in **`DAO-mode (disk-at-once)`**  and not faster than x8.` 


---

This is a checksum for a file and is used to check the integrity of files. The current md5sum of the file is compared with a known checksum. This way you can validate if a file has been changed or damaged; this is advisable for files downloaded from the internet.

If the md5sum of the downloaded file corresponds to the one in the md5-file, you can be sure that the file was downloaded correctly. Under Linux you get the checksum with: (it takes a moment to calculate)

~~~  
$ md5sum file_to_check  
~~~

The sum will be written in the console.  
With md5sum (486 kb) the md5sum can also be validated in Windows.

The ISO-Images of siduction are always offered with a md5sum file and should always be validated before burning. This guarantees that if problems occur, they are not to be sought in the downloaded files, and this keeps the forum free of problems that can't be pinned down because the ISO-file was damaged in the first place. You should do this in a konsole. Change to the directory with the Iso-File and the MD5-Sum and issue the command to have the md5-sum checked. 

Download the following files from the mirror:

~~~  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
~~~

In a terminal:

~~~  
$ md5sum siduction.iso  
~~~

If they don't match, you will get an error:

~~~  
"siduction.iso: Error  
md5sum: Warning: calculated checksum does not match!"  
~~~

If the downloaded file is correct, the program ends without a message.

<div class="divider" id="burn-nero"></div>
## How Do I Burn The CD With Windows?

###### **`THIS IS VERY IMPORTANT:`** `siduction, as a Linux LIVE-CD, is based on high compression technology, and because of that, special care is needed when burning the ISO image. Only use high quality CD-media [or DVD+RW] and burn in **`DAO-mode (disk-at-once)`**  and not faster than x8.` 


---

Naturally, you can burn the CD with Windows, too. The downloaded file must be burned as an ISO-file. If Winrar (or any other archiving tool) is linked with an .ISO-file, it may irritate because one would take it for an archive. From the ISO-file you must burn a CD. 

You have several good options to burn in Windows.

##### Open Source burners for Windows

 [cdrtfe](http://cdrtfe.sourceforge.net/)  :compatible for Windows 9x/ME/2000/XP, vista, / and 8 (tested with Win95, Win98SE, Win2000, and WinXP) only for Win9x/ME: working ASPI Layer (e.g. Adaptec ASPI 4.60)

 [LinuxLive USB Creator](http://www.linuxliveusb.com) , an open source project, offers a GUI for MS Windows&#8482;, which enables an install of an siduction-i386.iso (32 bit) to a USB stick. `You need to use **`fromhd`**  bootline/cheatcode on the boot line` .

###### Closed Source and Proprietary burners for Windows

+  Nero&#8482; (not Nero express!).  
+ Another good freeware tool is  [CD/DVD Burner XP pro](http://www.cdburnerxp.se/) .  
+ BurnCDCC from is another excellent tool from  [terabyteunlimited](http://www.terabyteunlimited.com/utilities.html)  as it can only burn ISOs.  

If you already run Linux on your machine you should burn the CD either by using the shell or with any of your installed burning programs.

With siduction and other Linux distributions K3b comes as default cd-burning tool. Open it, select "Tools" -> "burn CD-Image..." and select the ISO-File to burn (e.g. siduction.iso).

K3B initially calculates the MD5-sum for the ISO-file (this takes a moment). When the checksum is equal to the checksum in the MD5-file (for example siduction.iso.md5) your download was successful and you can burn the file by hitting "Start".

As the importance of media like CD or DVD for installing Linux distribtions decreases vastly, please also look at the possibility to put the ISO on a USB Pendrive or a SD-Card and install from there. This simple process is covered in the  [Install Options](hd-ins-opts-oos-de.htm#raw-lin)  chapter of our manual.

`Problems with burning mostly happen with a frontend. You can burn directly from the shell with  [burniso](cd-no-gui-burn-en.htm) .` 

###### Also see  [Writing siduction to a USB/SSD stick with any Linux, MS Windows or Mac OS X system (32 and 64 bit)](hd-ins-opts-oos-en.htm#raw-usb) .

<div id="rev">Content last revised 30/11/2013 1800 UTC</div>
