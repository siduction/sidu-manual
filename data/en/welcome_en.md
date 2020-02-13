<div id="main-page"></div>
<!--[if lt IE 10]><div class="center warning-box data">Please Note :: Your version of Internet Explorer&#8482; is obsolete, please install  [Firefox from Mozilla Corp&#8482;](http://mozilla.com/)  for Windows&#8482;. The menu distortions you see are the result of using a legacy browser like MSIE 5 or 6.</div><![endif]-->
<div class="divider" id="welcome-gen"></div>
## Welcome to the siduction Operating System Manual 

siduction is a wordplay  
between `sid`  and  *seduction* . <span  
class="highlight-3">sid</span> is <i>the codename of Debian's unstable  
branch.</i>

siduction is an operating system based on the  [Linux kernel](http://www.kernel.org/)  and the [GNU project](http://www.gnu.org/) , with applications/programs from  [Debian](http://www.debian.org/) unstable/sid and we hold fast to the core values and  [social contract](http://www.debian.org/social_contract)  and the  [DFSG](http://en.wikipedia.org/wiki/Debian_Free_Software_Guidelines)  of Debian.

You no longer need to wait for a new release to always have the latest of anything, including kernels. Once you have installed siduction, followed by all your favourite programs/applications, all it needs is a  [dist-upgrade](sys-admin-apt-en.htm#apt-upgrade) , which is a system-wide software update from debian and specialist packages from siduction.

This means that re-installing yet another release every 6+ months on your PC is unnecessary with siduction, as the daily, weekly or monthly dist-upgrade brings everything up-to-date.

It is worth noting, as siduction uses Debian's unstable branch and due to the very nature of 'Sid', you will need to be prepared to use the  [Terminal/cli](term-konsole-en.htm) .

With the 'way of siduction', you will be always up to date and have the very best that siduction together with Debian 'sid' can offer.

<div class="divider" id="how-to"></div>
## How to use this manual

`The siduction Operating System Manual is a reference for initial learning and refreshing your knowledge of a linux type of Operating System, not only with the basics, as it also encompasses many complex topics which will help you as the siduction system administrator.` 

<!--<div class="divider" id="man-read"></div>
Installing the `siduction-manual-reader`  to read the siduction Operating System Manual on PCs that have very small screens, such as netbooks, may be of benefit. It also provides a basic keyword search function to quickly search for files containing your search word.

-->
<div class="divider" id="man-gen"></div>
#### General

This manual is divided into common sections, for example, a subject pertaining to partitioning is found in Partitioning your Hard Drive, and topics regarding the Internet/WIFI are grouped in Internet and Networking. There are some topics that cannot be grouped or require stand-alone status. 

For help with a specific program or an application (called a `package` ) that came preinstalled or that you have installed yourself, look at the website of the package help forums, FAQs and online manuals and/or a help menu within that package, to help guide you for any given program/application.

Most good programs/applications also have a help guide via <span class="highlight-3">man</span> pages in the terminal. Also check to see if documentation is in `/usr/share/doc/<package>` .

Please, if you do nothing else, take a moment to read the  [Quick Start Guide](wel-quickstart-en.htm#welcome-quick) .

 As with any new documentation there will be errors/mistakes/typos, although we hope otherwise regarding errors and mistakes (typos we can live with ) please forgive us.

As the body of work grows, more documentation will be added and we at siduction are sure that this will prove to be a very valuable resource for you and we thank you for being a part of siduction. 

##### Printing key files of the manual

Hard copy printing of key files as 'portrait' does not allow an overflow code-box to print beyond the physical paper margins, (the manual website does not have this issue due to a code-box being able to scroll across). 

While this is not generally a problem for a website, that is for example, a mainstream media site, it is rather critical for any linux distribution where a single line of code input into a terminal maybe as long as 120 characters, and thus is usually wider than a typical A4 portrait page at 12 pt.

Therefore adjust your print preferences to `landscape,` .

##### Copyright

All content is © 2006-2012 and released under  [GNU Free Documentation License](http://www.gnu.org/licenses/fdl.txt) . Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.2 or any later version published by the Free Software Foundation; with no Invariant Sections, with no Front-Cover Texts, and with no Back-Cover Texts.

All trademarks and copyrights are the property of their owners whether specified or not.

E&amp;OE

## Disclaimer

This is experimental software. Use at your own risk. The siduction project, it's developers and team members cannot be held liable under any circumstances for damage to hardware or software, lost data, or other direct or indirect damage resulting from the use of this software. If you do not agree to these terms and conditions, you are not permitted to use or further distribute this software. 

<div class="divider" id="table-contents"></div>
## Table of Contents

If the navigation bar and / or sub menus do not appear to be entirely correct, please make sure your browser minimum font size is set to no larger than 12 in firefox, ideally 10. `Netbook users may need to Zoom Out (Ctrl+-) once or twice to see the main menu, use this Table of Contents` .

#####  [siduction OS Manual](welcome-en.htm#welcome-gen) 

+  [siduction OS Manual](welcome-en.htm#welcome-gen)   
+  [How to use this manual](welcome-en.htm#how-to)   
+  [Table of Contents](welcome-en.htm#table-contents)   
+  [Where to get Help](help-en.htm#help-gen)   
+  [IRC !paste](help-en.htm#paste)   
+  [Credits](credits-en.htm#cred-team)   
+  [siduction Quick Start Guide](wel-quickstart-en.htm#welcome-quick)   

#####  [Mirrors, CD Downloading and Burning](cd-dl-burning-en.htm#download-siduction) 

+  [ISO and system requirements](cd-content-en.htm#cd-content)   
+  [Release Notes](sys-admin-release-en.htm#rolling)   
+  [siduction Mirrors, Downloading and Burning](cd-dl-burning-en.htm#download-siduction)   
+  [md5 Checksum](cd-dl-burning-en.htm#md5)   
+  [Burning in Windows](cd-dl-burning-en.htm#burn-nero)   
+  [Burning in Linux](cd-dl-burning-en.htm#burn-linux)   
+  [burniso script](cd-no-gui-burn-en.htm#burning-no-gui)   
+  [Burning without a GUI](cd-no-gui-burn-en.htm#burn-no-gui-gen)   

#####  [Live Mode](live-mode-en.htm#rootpw) 

+  [Root-password on the siduction-Live ISO](live-mode-en.htm#rootpw)   
+  [Installing software whilst on a Live-ISO](live-mode-en.htm#live-cd-installsoft)   
+  [Writing on NTFS-partitions with ntfs-3g](live-mode-en.htm#ntfs-3g)   

#####  [The Terminal/Konsole](term-konsole-en.htm#term-kon) 

+  [suxterm](term-konsole-en.htm#sux)   
+  [Terminal/Konsole](term-konsole-en.htm#term-kon)   
+  [Command Line Help](term-konsole-en.htm#cli-help)   
+  [Tools to know in text mode (tty) - init 3](help-en.htm#init3-tools)   
+  [Linux Terminal Commands List](term-konsole-en.htm#term-cmds)   
+  [Installing Scripts.sh](term-konsole-en.htm#shell-scripts)   

#####  [Boot Codes](cheatcodes-en.htm#cheatcodes) 

+  [siduction specific Live-ISO boot codes](cheatcodes-en.htm#cheatcodes)   
+  [Linux generic boot codes](cheatcodes-en.htm#cheatcodes-linux)   
+  [VGA Codes](cheatcodes-vga-en.htm#vga)   

#####  [Partitioning Your Hard Drive](part-gparted-en.htm#partition) 

+  [Partitioning your HD using GParted/KDE Partition Manager](part-gparted-en.htm#partition)   
+  [NTFS partition Resizing using GParted/KDE Partition Manager](part-gparted-en.htm#ntfs)   
+  [Writing on NTFS partitions with ntfs-3g](part-gparted-en.htm#hd-ntfs3g)   
+  [UUID, Rebuilding fstab and creating new mount points](part-uuid-en.htm#uuid)   
+  [Formatting after partitioning with gdisk](part-gdisk-en.htm#gdisk-6)   
+  [GPT Partitioning with gdisk](part-gdisk-en.htm#gdisk-1)   
+  [Disk Naming in brief](part-cfdisk-en.htm#disknames)   
+  [Partitioning your HD using cfdisk](part-cfdisk-en.htm#partition)   
+  [Formatting after partitioning with cfdisk](part-cfdisk-en.htm#formating)   
+  [Partition Size Examples](part-size-examp-en.htm#part-example)   

#####  [Installation options](hd-install-en.htm#Inst-prep) 

+  [Install Preparation](hd-install-en.htm#Inst-prep)   
+  [Installing to your HD](hd-install-en.htm#Installation)   
+  [First Boot Up](hd-install-en.htm#first-hd-boot)   
+  [Booting 'fromiso'](hd-install-opts-en.htm#fromiso)   
+  [fromiso and persist](hd-install-opts-en.htm#fromiso-persist)   
+  [Installing on a USB-HD - siduction-on-stick](hd-install-opts-en.htm#usb-hd)   
+  [Writing siduction to a USB/SSD stick with any Linux, MS Windows or Mac OS X system](hd-ins-opts-oos-en.htm#raw-usb)   
+  [Booting siduction over a network](nbdboot-en.htm#nbd1)   
+  [Virtual Machine installation options](hd-install-vmopts-en.htm#vm)   

#####  [Graphic cards, monitors, Xorg, &amp; drivers](gpu-en.htm) 

+  [Screen Resolution and Monitors](hw-dev-mon-en.htm#mon-res)   
+  [Dual Monitors and xrandr](hw-dev-mon-en.htm#xrandr)   
+  [Dual Monitors (using binaries)](hw-dev-mon-en.htm#mon-binary)   
+  [AMD/ATI 3D drivers](gpu-en.htm#ati-3d)   
+  [Intel 2D and 3D drivers](gpu-en.htm#intel)   
+  [Nvidia 3D drivers](gpu-en.htm#nvidia)   
+  [Open Source Xorg drivers](gpu-en.htm#foss-xorg)   
+  [Firmware detection - non-free](nf-firm-en.htm#fw-detect)   
+  [Adding non-free to Sources List](nf-firm-en.htm#non-free-firmware)   

#####  [Window Managers](wm-dm-en.htm#install-add) 

+  [Useful Xfce extras](wm-dm-en.htm#xfce-notes)   
+  [Useful extra KDE Apps](wm-dm-en.htm#install-add)   
+  [Desktop Freezes](wm-dm-en.htm#desk-freeze)   
+  [Cant login in KDE](wm-dm-en.htm#kde-login)   
+  [Changing Themes](wm-dm-en.htm#ch-th)   

#####  [siduction LAMP Stack](lamp-apache-en.htm#serv-apache) 

+  [siduction LAMP Stack](lamp-apache-en.htm#serv-apache)   
+  [FTP Clients](lamp-apache-en.htm#serv-ftp)   
+  [Security Protocols](lamp-apache-en.htm#serv-sec)   
+  [SSL](lamp-apache-en.htm#serv-ssl)   
+  [MySQL Setup](lamp-sql-en.htm#serv-mysql)   
+  [PHP in Apache](lamp-php-en.htm#serv-php)   
+  [Timeserver Setup](ntp-server-en.htm#ntp-server)   

#####  [Internet and Networking](inet-ceni-en.htm#netcardconfig) 

+  [Tor](tor-privoxy-en.htm#tor)   
+  [Privoxy](tor-privoxy-en.htm#privoxy)   
+  [Firewalls](inet-ceni-en.htm#firewalls)   
+  [Configuring SAMBA (Windows)](samba-en.htm#configure)   
+  [Samba-Server Setup](samba-en.htm#setup)   
+  [SSH Remote Mounting](ssh-en.htm#ssh-fs)   
+  [X Window Apps via SSH](ssh-en.htm#ssh-x)   
+  [GUI SSH with Konqueror](ssh-en.htm#ssh-f)   
+  [SSH X-Forwarding from Windows-PC](ssh-en.htm#ssh-w)   
+  [SSH and Security](ssh-en.htm#ssh)   
+  [56k Modems](inet-ceni-en.htm#dial-mod)   
+  [WiFi - WPA_GUI](inet-wpagui-en.htm#wpa-roaming-gui)   
+  [WiFi - Setting up for WiFi Roaming](inet-setup-en.htm#net-set1)   
+  [WiFi - wpasupplicant](inet-wpa-en.htm#wpa)   
+  [Network switching between WiFi and Cable](inet-ifplug-en.htm#hotswitch)   
+  [Getting Online - Ceni](inet-ceni-en.htm#netcardconfig)   

#####  [dist-upgrade and Package Management](sys-admin-apt-en.htm#apt-cook) 

+  [APT-Guide Cookbook and Sources list](sys-admin-apt-en.htm#apt-cook)   
+  [Installing a new package](sys-admin-apt-en.htm#apt-install)   
+  [Deleting a package](sys-admin-apt-en.htm#apt-delete)   
+  [Package Hold and downgrading](sys-admin-apt-en.htm#apt-downgrade)   
+  [Package searching with apt-cache](sys-admin-apt-en.htm#apt-cache)   
+  [GUI Package searching](sys-admin-apt-en.htm#gui-pacsea)   
+  [Upgrading by Live-ISO](sys-admin-upgrade-en.htm#live-cd-upgrade)   
+  [dist-upgrade of multiple PCs on a LAN](sys-admin-apt-locarmirr-en.htm#approx)   
+  [Upgrading the kernel](sys-admin-kern-upg-en.htm#kern-upgrade)   
+  [Upgrade an Installed System - dist-upgrade - Overview](sys-admin-apt-en.htm#apt-upgrade)   
+  [Upgrade an Installed System - dist-upgrade - The Steps](sys-admin-apt-en.htm#du-st)   

#####  [System Administration](sys-admin-gen-en.htm#start-services) 

+  [Adding a new user](hd-install-en.htm#adduser)   
+  [Moving /home](home-en.htm#home-bu)   
+  [Back-Up with rdiff](sys-admin-rdiff-en.htm#rdiff)   
+  [Back-Up with rsync](sys-admin-rsync-en.htm#rsync)   
+  [Virus and Rootkit Scanners](vir-rkits-en.htm#virus-rkits)   
+  [Services enable/disable](sys-admin-gen-en.htm#start-services)   
+  [Lost root passwords](sys-admin-gen-en.htm#pw-lost)   
+  [Fonts](sys-admin-gen-en.htm#fonts)   
+  [CUPS - Printing System](sys-admin-gen-en.htm#cups)   
+  [Sound Mixers](sys-admin-gen-en.htm#sound)   
+  [siduction runlevels - init](sys-admin-gen-en.htm#init)   
+  [Upgrading the BIOS with FreeDOS](bios-freedos-en.htm#bois-prep)   
+  [Grub2 - MBR Overwritten](sys-admin-grub2-en.htm#chroot)   
+  [Grub2 - Dual and Multibooting](sys-admin-grub2-en.htm#multi-os)   
+  [Grub2 -Upgrading from Grub1](sys-admin-grub2-en.htm#grub1-grub2)   
+  [Grub2 - Overview](sys-admin-grub2-en.htm#grub2)   

<div id="rev">Page last revised 17/01/2012 1800 UTC</div>
