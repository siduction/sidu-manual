<div id="main-page"></div>
<div class="divider" id="welcome-quick"></div>
## siduction Quick Start Guide

###### **`THIS IS VERY IMPORTANT:`** `siduction, as a Linux LIVE-ISO, is based on high compression technology, and because of that, special care is needed when burning the ISO image. Only use high quality CD-media [or DVD+RW] and burn in **`DAO-mode (disk-at-once)`**  and not faster than x8.` 

siduction aims to be 100% compatible with Debian sid, however siduction may provide temporary hot-fixes from time to time. The siduction apt-repository holds siduction specific packages which includes the siduction kernel, scripts, tools and documentation.

### Must read files

`There are several pages that a 'new to linux', or, a 'new to siduction' user should read. This file is one of them. The other pages are:` 

+  [The Terminal](term-konsole-en.htm#term-kon)  - Describes how to use a terminal and the use of suxterm command.  
+  [Partitioning](part-gparted-en.htm#partition)  - Describes how to partition your disk.   
+  [Installing siduction (HD)](hd-install-en.htm#install-prep)  - Describes how to install to a hard drive.  
+  [Installing siduction (USB)](hd-install-opts-en.htm#usb-hd)  - Describes how to install to a USB-stick/SD/flash-card.  
+  [Writing siduction to sticks](hd-ins-opts-oos-en.htm#usb-hd#raw-usb)  - Describes how to write siduction to a stick or SD/flash card instead of a CD/DVD.  
+  [Non free drivers and sources](nf-firm-en.htm#non-free-firmware)  - Describes how to adjust your sources and how to install non-free firmware.  
+  [Internet connecting](inet-ceni-en.htm#netcardconfig)  - Describes how get connected to the internet.  
+  [Apt and dist-upgrading](sys-admin-apt-en.htm#apt-cook)  - Describes how to install new software and how to action a dist-upgrade.  

##### Debian sid/unstable stability 

sid is a name tag for the unstable repositories of Debian. Debian sid is a frequently updated repository that is quick to stay in sync with latest and greatest upstream versions of software maintained. Because of the frequency of updates, less overall testing on packages is possible from the shortened period of time between upstream and distributed Debian packages.

#### siduction kernel 

The kernel is siduction optimised to help offset issues, add new functionality, or configured for faster performance and better stability and tweaked from latest kernel from  [http://www.kernel.org/.](http://www.kernel.org/) . 

The kernel is mirrored here:  [Upgrading the kernel](sys-admin-kern-upg-en.htm#kern-upgrade) 

#### Package Management 

siduction is compliant with Debian packaging and uses apt and dpkg for software package management with debian and other repositories identified by the files in `/etc/sources.list.d/*` 

Debian sid has over 30,000 packages, so you should be able to find the one you would like to use with  [Package searching with apt-cache](sys-admin-apt-en.htm#apt-cache)  or with  [Debian Package Search GUI application](sys-admin-apt-en.htm#gui-pacsea) .

To install the package `apt-get install <package name>`   [Installing a new package](sys-admin-apt-en.htm#apt-install) 

 Debian sid's repositories can be updated as much as four times a day so running `apt-get update`  is essential before installing any new packages or before running `apt-get dist-upgrade`  to keep up-to-date with the server's list of packages. 

###### Using other Debian based distributions' repositories, Source and RPMs

 Source installs are not recommeded. If you really need to compile your application, do it as user, and put it under your home directory without installing it to the system. Using checkinstall should be strictly restricted to private use and converting RPMs with alien, (and others like it), to make a deb, is not recommended.

Other well known, (and lesser known), Debian based distributions' which repackage Debians' packages for their own repositories, often use different file locations for various applications which differ from Debian and could cause system instability and some packages won't install due to unresolvable dependencies from different package naming schemes or odd version numbers. For instance a different version of glibc could cause the application to not even run. 

Use Debian repositories to install your required software packages, as other repositories will most likely not be able to be supported.

#### Upgrading the system - dist-upgrade

`apt-get dist-upgrade`  is the recommended way of upgrading siduction. Using any graphical front end to update siduction is not recommended. Please read carefully:  [Upgrade of an Installed System - dist-upgrade](sys-admin-apt-en.htm#apt-upgrade) 

A dist-upgrade is recommended only outside of X. Running init 3 from your window manager (KDE, XFCE, etc) or in a virtual terminal (ctrl+alt+f1, ctrl+alt+f2, etc) will stop X from running and allows you to upgrade safely.

#### Network Configuration 

`Ceni` is a network configuration tool to quickly configure your network or wireless card with little fuss. The wireless function can scan for networks, use wep and wpa for encryption, and use wireless-tools or wpa_supplicant for wireless configuration. Ethernet is straight forward if using dhcp (automatic ip address assigning) or you can manually set it from netmasks to nameservers. 

Ceni is run with the command`Ceni`  or `ceni` . If not installed, you can install it with the command apt-get install ceni. 

 [Getting Online - Ceni](inet-ceni-en.htm#netcardconfig) 

#### Runlevels - init

siduction run levels are different to debian see:  [siduction runlevels - init](sys-admin-gen-en.htm#init) 

##### Other Window Managers

KDE, XFCE, LXDE and fluxbox are the siduction defaults. Gnome is not supported by siduction to date. Some users in the siduction forums /wiki and IRC chat may have experience and be willing to help you, otherwise you are on your own. 

#### IRC and Forum help 

Don't be afraid to ask for help through IRC or the forum:

+  [Where to Get Help](help-en.htm#help-gen)    
+  [Web IRC](http://thegrebs.com/oftc/)  enter your nickname and join #siduction  

<div id="rev">Page last revised 17/01/2012 1800 UTC</div>
