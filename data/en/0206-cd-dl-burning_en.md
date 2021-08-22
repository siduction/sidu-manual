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
% siduction ISO download and burn

## ISO download and burn

### siduction ISO download

**Please use the closest mirror. Mirror servers listed below the link with details for the entry in /etc/apt/sources.list.d/siduction.list will be updated in a timely manner.  

**Europe**  

+ **Office Vienna, Vienna, Austria**  
https://siduction.office-vienna.at/

+ **Freie Universität Berlin/spline (Student Project LInux NEtwork), Germany**  
http://ftp.spline.de/pub/siduction/  
https://ftp.spline.de/pub/siduction/  
ftp://ftp.spline.de/pub/siduction/

+ **University of Stuttgart, Germany**  
http://ftp.uni-stuttgart.de/siduction/  
https://ftp.uni-stuttgart.de/siduction/  
ftp://ftp.uni-stuttgart.de/siduction/

+ **Academic Computer Club, Umeå University, Sweden**  
http://ftp.acc.umu.se/mirror/siduction.org/  
https://ftp.acc.umu.se/mirror/siduction.org/  
rsync://ftp.acc.umu.se/mirror/siduction.org/

+ **Dotsrc.org, Aalborg University, Denmark**  
http://mirrors.dotsrc.org/siduction/  
https://mirrors.dotsrc.org/siduction/  
ftp://mirrors.dotsrc.org/siduction/  
rsync://mirrors.dotsrc.org/siduction/

+ **Yandex, Moscow, Russia**  
https://mirror.yandex.ru/mirrors/siduction/  
http://mirror.yandex.ru/mirrors/siduction/  
ftp://mirror.yandex.ru/mirrors/siduction/  
rsync://mirror.yandex.ru/mirrors/siduction/

+ **GARR Consortium, Italy**  
http://siduction.mirror.garr.it/  
https://siduction.mirror.garr.it/

+ **Quantum Mirror, Hungary**  
http://quantum-mirror.hu/mirrors/pub/siduction/  
https://quantum-mirror.hu/mirrors/pub/siduction/  
rsync://quantum-mirror.hu/siduction/

+ **Belnet, Brussels, Belgium**  
http://ftp.belnet.be/mirror/siduction/  
https://ftp.belnet.be/mirror/siduction/  
ftp://ftp.belnet.be/mirror/siduction/  
rsync://ftp.belnet.be/siduction/

+ **Gesellschaft für wissenschaftliche Datenverarbeitung mbH Göttingen, Germany**  
http://ftp.gwdg.de/pub/linux/siduction/  
https://ftp.gwdg.de/pub/linux/siduction/  
ftp://ftp.gwdg.de/pub/linux/siduction/  
rsync://ftp.gwdg.de/pub/linux/siduction/

+ **RWTH Aachen, Germany**  
https://ftp.halifax.rwth-aachen.de/siduction/  
rsync://ftp.halifax.rwth-aachen.de/siduction/  
ftp://ftp.halifax.rwth-aachen.de/siduction/  
http://ftp.halifax.rwth-aachen.de/siduction/

+ **Studenten Net Twente, Netherlands**  
http://ftp.snt.utwente.nl/pub/linux/siduction/  
https://ftp.snt.utwente.nl/pub/linux/siduction/  
ftp://ftp.snt.utwente.nl/pub/linux/siduction/  
rsync://ftp.snt.utwente.nl/siduction/

**Asia**

+ **KoDDOS, Amarutu Technology, Hong Kong**  
https://mirror-hk.koddos.net/siduction/  
http://mirror-hk.koddos.net/siduction/  
rsync://mirror-hk.koddos.net/siduction/

**South America**

+ **Corporación Ecuatoriana para el Desarrollo de la Investigación y la Academia, Cuenca**  
https://mirror.cedia.org.ec/siduction/  
http://mirror.cedia.org.ec/siduction/  
rsync://mirror.cedia.org.ec/siduction/

**North America**

+ **Department of Mathematics, Princeton University, United States**  
http://mirror.math.princeton.edu/pub/siduction/  
https://mirror.math.princeton.edu/pub/siduction/

+ **Georgia Tech Software Library (GTlib), Atlanta, United States**  
http://www.gtlib.gatech.edu/pub/siduction/  
ftp://ftp.gtlib.gatech.edu/pub/siduction/  
rsync://rsync.gtlib.gatech.edu/siduction/

+ **Liquorix.net, United States**  
https://liquorix.net/siduction/

### siduction mirror files

Each mirror includes the following files:

siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.arch.manifest  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.iso  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
SOURCES  


The **.manifest** file lists all packages of the respective ISO.

**.iso** is the image file provided for download.

The **.md5** and **.sha256** files are used to verify the integrity of the ISO.

The **.gpg** files are the signature files used to check checksum files (.md5 .sha256) for changes. The latter are used to check the integrity of the ISO.

Download links and mirrors can be found at [siduction.org](https://forum.siduction.org/index.php?page=7).

The tar archive with the sources is interesting for those who want to redistribute siduction. Here the sources must be distributed to comply with the license. More information can be found in the tar archive.

If someone can provide a FTP server with appropriate traffic, we are always available in the [siduction forums](https://siduction.org) or in IRC irc.oftc.net:6667 #siduction-de. 

### md5sum and integrity checking

An md5sum is the checksum of a file. This checksum is used to check the integrity of the associated file. It compares the current md5sum of the file with a known previous sum. This way it can be determined if the file has been modified or damaged, which is always advisable for files downloaded from the net and saves a lot of time for debugging.

The file has been downloaded undamaged if the md5sum of the downloaded file matches the sum in the MD5 file. On Linux, you can get the md5sum of a file with:

    $ md5sum to_check_file

This takes some time and the sum is then printed in the console and can be compared manually with the sum as it is stored in the corresponding *.md5 file. The md5 file can be opened in a text editor for this purpose. With the md5summer (486 KB) the md5sum can also be checked in Windows.

Easier is the check under Linux with the following command, executed in the directory, in which both the ISO file and the ISO.MD5 file are:

    $ md5sum -c to_check_file.md5

Depending on whether the checksums match, you will get a message from the program:

    md5-sum: to_be_checked_file: ok

or

    siduction-name.iso: failure md5sum: warning: 1 of 1 calculated checksum do not match.

The ISO image files of siduction are always offered for download with the corresponding md5sum and should always be checked before burning.

These files are downloaded from the mirror

siductionname.iso
siductionname.iso.md5

Verification using SHA256SUM is a similar procedure. For more details see

    $ man sha256sum

### Burning a live DVD with Windows

> **IMPORTANT INFORMATION:**  
> siduction, as a Linux LIVE DVD/CD, is very heavily compressed. For this reason, special attention must be paid to the burning method of the image. Please use high quality media, burning in DAO mode (disk-at-once) and not faster than eight times (8x). However, we recommend, if the hardware supports booting from USB, to put the image on a USB stick or SD memory card. For this purpose we recommend the tool Edger or the command line tool dd. Instructions are provided in the manual under Installation Options.


Of course, the DVD can also be burned in Windows. The downloaded file must be burned as an ISO image file. If Winrar (or any other archiving program) is linked to an ISO file, this program could see the ISO file as an archive file. A DVD must be burned from the ISO file.

There are several good options to burn ISO files in Windows.  

**Open Source Software for Windows**

+ cdrtfe: compatible with Windows 9x/ME/2000/XP, Vista, 7 and 8. (tested with Win95, Win98SE, Win2000, WinXP). Only for Win9x/ME: working ASPI layer (e.g. Adaptec ASPI 4.60)
+ LinuxLive USB Creator, an open source project, provides a GUI application for MS Windows™ which allows to install a siduction-i386.iso (32 bit) on a USB stick.  

**Closed source and proprietary software for Windows**.

+ CD/DVD Burner XP pro
+ Burncdcc from [terabyteunlimited](https://www.terabyteunlimited.com/downloads-free-software.htm) can only burn ISO image files.

### Burn the DVD with Linux

> **IMPORTANT INFORMATION:**  
> siduction, as Linux LIVE DVD/CD, is very compressed. For this reason, special attention must be paid to the burning method of the ISO image. Please use high quality media, burning in DAO mode (disk-at-once) and not faster than eight times (8x). However, we recommend, if the hardware supports booting from USB, to put the image on a USB stick or SD memory card. For this purpose we recommend the tool Edger or the command line tool dd. Instructions for this can be found in the manual under installation options.


If you already have Linux on your computer, you can create the DVD with any installed burning program. For siduction, K3b is the default burning program. There you have to click the menu item "Extras" -> "Burn ISO image...", select the ISO file to burn (e.g. siduction-18.3.0-patience-kde-amd64-201805132121.iso) and set the burning mode DAO (Disk At Once).

K3b first calculates the MD5 sum of the ISO file (takes a moment). If the displayed checksum matches the given string of the MD5 file located in the same folder (e.g. siduction-Name.iso.md5), the download was successful and the file can be burned by clicking on "Start".

If you click on the calculated checksum, an icon appears next to it. If you click on it again and insert the checksum from the MD5 file into the field, the two checksums are compared.

The cause of problems with burning is mostly found in the frontend applications. For direct burning from the console you can use the script burniso.
See also Installing to USB stick/SSD from another system (Linux. MS Windows, Mac OS X).

<div id="rev">Last edited: 2021-13-08</div>
