BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC2**

Necessary work:

+ check spelling  

Work done

+ check intern links  
+ check extern links  
+ check layout  

END   INFO AREA FOR THE AUTHORS  
% Quickstart

# Quickstart

## siduction Quick Start Guide

siduction strives to be 100% compatible with Debian Sid. Nevertheless, siduction may provide packages that temporarily replace buggy Debian packages. The siduction apt repository contains siduction specific packages like the siduction kernel, scripts, packages we would like to push to Debian, utilities and documentation.

### Essential chapters

> Some chapters of the manual are essential reading for users who are new to Linux or new to siduction. In addition to this brief introduction, these are:

+ [Terminal/Console](0701-term-konsole_en.md#terminal---command-line) - Describes how to use a terminal and the su command.

+ [Partitioning the hard disk](0312-part-gparted_en.md#partitioning-with-gparted) - Describes how to partition a hard disk. 

+ [Downloading siduction ISO and burning DVD](0206-cd-dl-burning_en.md#iso-download-and-burn) - Describes how to download, check, and burn a siduction ISO to DVD.

+ [Installation on a hard disk](0301-hd-install_en.md#installation-on-hdd) - Describes how to install siduction on a hard disk.

+ [Installation on USB stick/SD from another system](0303-hd-ins-opts-oos_en.md#installation-onusb-stick---memory-card) - Describes how to write siduction from another system to a USB stick or SD/flash card.

+ [Non-free drivers, firmware and sources](0600-gpu_en.md#graphics-driver) - Describes how software sources can be adapted and non-free firmwares can be installed.

+ [Internet connection](0500-network_en.md#network) - Describes how to connect to the Internet.

+ [Package Manager and System Update](0705-sys-admin-apt_en.md#apt-package-management) - Describes how to install new software and update the system.

### About the stability of Debian Sid

'Sid' is the name of Debian's unstable repository. Debian Sid is regularly updated with new software packages, which means that this Debian distribution contains the latest versions of the respective programs in a very timely manner. However, this also means that there is less time between a release in the upstream (by the software developers) and the distribution in Debian Sid to test the packages.

### The siduction kernel

The Linux kernel of siduction is optimized to achieve the following goals: problem solving, enhanced and updated features, performance optimization, higher stability. The basis is always the latest kernel from [http://www.kernel.org/](https://www.kernel.org/) . 

### The management of software packages

siduction follows Debian rules regarding package structure and uses apt and dpkg for software package management. The Debian and siduction repositories are located in `/etc/sources.list.d/*`. 

Debian siduction contains more than 20,000 program packages, so the chances of finding a program suitable for a task are very good. How to search for program packages is described here:  
[Program search with apt-cache or aptitude](0705-sys-admin-apt_en.md#searching-for-program-packages)  
or with  
[GUI package search with packagesearch](0705-sys-admin-apt_en.md#graphical-package-search) .

A program package is installed with this command:

~~~
apt install <package name>
~~~

See also: [Install new packages](0705-sys-admin-apt_en.md#install-packages) .

The Debian Sid repositories are usually populated with updated or new software packages four times a day. A local database is used to quickly manage the packages. The command

~~~
apt update
~~~

is necessary before each new installation of a software package to synchronize the local database with the repositories software supply.

**The use of other Debian based repositories, sources and RPMs**.  
Installations from source code are not supported. Recommended is compiling as user (not root) and placing the application in the home directory without installing it into the system. The use of *checkinstall* to generate DEB packages should be limited to purely private use. Conversion programs for RPM packages like *alien* are not recommended.

Other well-known (and lesser-known) distributions based on Debian create new packages structured differently from Debian and often use different directories in which to place programs, scripts, and files during installation than Debian does. This can lead to unstable systems. Some packages cannot be installed at all because of unresolvable dependencies, different naming conventions or different versioning. For example, a different version of glibc may result in no program being executable.

For this reason, Debian's repositories should be used to install the required software packages. Other software sources may be difficult or impossible to support by siduction. This includes packages and PPAs from Ubuntu.

### Updating the system - upgrade

An upgrade can only be performed when graphics server X is stopped. To stop the graphics server, enter as **root** the command

~~~
init 3
~~~

into a console. After that, system updates can be performed safely. First refresh the local package database with

~~~
apt update
~~~ 

then update the system with one of the two variants

~~~
apt upgrade
apt full-upgrade
~~~

Afterwards you start the graphical user interface again with the following command:

~~~
init 5
~~~

**apt full-upgrade** is the recommended procedure to upgrade a siduction installation to the latest version. It is described in more detail here:  
[Updating an installed system - full-upgrade](0705-sys-admin-apt_en.md#updating-the-system).

### Configuration of networks

The **Networkmanager** integrated in all graphical interfaces of siduction offers a quick configuration of network cards (Ethernet and wireless). It is mostly self-explanatory. In the terminal the script **nmcli** provides access to the netwokmanagers functionality. Wireless networks are scanned by the script, you can choose WEP and WPA encryption methods and use the **wireless-tools** or **wpasupplicant** backends to configure wireless networks. Ethernet configuration is automatic when using a DHCP server on the router (dynamic assignment of an IP address), but manual setup (from netmasks to nameservers) is also possible with this script.

The start command in the console is **nmcli** or **nmtui** . If the script is not available, install it with:

~~~
apt install network-manager
~~~

More information at [network - nmcli](0501-inet-nm-cli_en.md#network-manager-command-line-tool)

Intel's [iNet wireless daemon](https://iwd.wiki.kernel.org/) (**IWD**) is preparing to retire the WPA supplicant. Only one tenth as big and much faster, iwd is the successor. If you want to switch to iwd already, please refer to our manual page [IWD instead of wpa_supplicant](0502-inet-iwd_en.md#iwd-statt-wpa_supplicant) for the procedure.

### Runlevels - target unit

By default, siduction boots into the graphical user interface (except NoX).  
The configuration of the runlevels is described in the chapter [siduction runlevels - target unit](0714-systemd-target_en.md#systemd-target---target-unit).

### Other desktop environments

Plasma, Gnome, Xfce, LXQt, Cinnamon and Xorg are shipped from siduction.

### Help in IRC and in the forum

Help is always available in IRC or in the forum of siduction.

+ Read more in the chapter [Where to get help](0003-help_en.md#siduction-help) .

+ [With this link you can call the IRC immediately in your browser](https://webchat.oftc.net/) : enter a freely chosen nickname and enter the channel #siduction-en.

<div id="rev">Last edited: 2021/24/08</div>
