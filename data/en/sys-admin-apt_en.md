<div id="main-page"></div>
<div class="divider" id="apt-cook"></div>
## A small APT-Guide Cookbook

### What does APT mean?

APT is short for Advanced Packaging Tool and is a collection of programs and scripts that help both the sysadmin (in your case root) with the installation and management of deb-files but equally the system itself to know what is installed.

<div class="divider" id="sources-list"></div>
## Sources List

The "APT" -system needs a config-file that contains information about the locations of the installable and upgradeable packages and is commonly referred to as a `sources.list` .

 Sources are contained in a directory or folder named:  
`/etc/apt/sources.list.d/` 

Inside the folder are 2 files called:  
`/etc/apt/sources.list.d/debian.list`  and  
`/etc/apt/sources.list.d/siduction.list` 

This has the benefit of easier (automated) mirror switching, and makes it safer to replace lists.

You can also add your own `/etc/apt/sources.list.d/*.list` files

### All siduction ISOs use the following sources as default:

~~~  
#Freie Universität Berlin/ spline (Student Project LInux NEtwork), Deutschland  
ftp://ftp.spline.de/pub/siduction/iso  
rsync://ftp.spline.de/siduction/iso  
deb ftp://ftp.spline.de/pub/siduction/base unstable main  
deb ftp://ftp.spline.de/pub/siduction/fixes unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/base unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/fixes unstable main  
~~~

Further entries for optional siduction repositories are found at  [siduction repositories](http://packages.siduction.org) 

Adding several more Debian repositories could look like:

~~~  
#Debian  
# Unstable  
deb http://ftp.us.debian.org/debian/ unstable main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ unstable main contrib non-free  
# Testing  
#deb http://ftp.us.debian.org/debian/ testing main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ testing main contrib non-free  
# Experimental  
#deb http://ftp.us.debian.org/debian/ experimental main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ experimental main contrib non-free  
~~~

NOTE: In this example ftp.us indicates its using USA repositories.You may edit this file, as root, to use the mirror closest to you, simply by changing the country, that is, change ftp.us to ftp.nl, or ftp.uk. Most countries have local mirrors, thus bandwidth is conserved; speeds improved.

 [List of Debian Servers and mirrors current status](http://www.debian.org/mirrors/) .

To be able to obtain updated information on the packages APT uses a database. This database contains the packages but also which other packages are needed for that package to work (called dependencies). The program apt-get uses this database when installing your chosen packages to resolve all the dependencies and thereby to guarantee that the chosen packages will work. The updating of this database is done by the command apt-get update.

~~~  
# apt-get update  
(which returns )  
Get:1 http://siduction.org sid Release.gpg [189B]  
Get:2 http://siduction.org sid Release.gpg [189B]  
Get:3 http://siduction.org sid Release.gpg [189B]  
Get:4 http://ftp.de.debian.org unstable Release.gpg [189B]  
Get:5 http://siduction.org sid Release [34.1kB]  
Get:6 http://ftp.de.debian.org unstable Release [79.6kB]  
...  
Fetched 823 kb in 12 s (64 kb/s)  
Reading package lists... Done  
~~~

<div class="divider" id="apt-install"></div>
## Installing a new package

Presuming the Apt-database is updated and the name of the package is known, then the following command will install a package called qemu, for example, and all its dependencies: (further on you will see how to search and find packages.)

~~~  
# apt-get install qemu  
Reading package lists... Done  
Building dependency tree... Done  
The following extra packages will be installed:  
bochsbios openhackware proll vgabios  
Recommended packages:  
debootstrap vde  
The following NEW packages will be installed:  
bochsbios openhackware proll qemu vgabios  
0 upgraded, 5 newly installed, 0 to remove and 20 not upgraded.  
Need to get 4152kB of archives.  
After unpacking 11.9MB of additional disk space will be used.  
Do you want to continue [Y/n]? n  
~~~

<div class="divider" id="apt-delete"></div>
## Deleting a package

Similarly it should come as no surprise that the following will deinstall a package, however it will not remove the dependencies: 

~~~  
apt-get remove gaim  
~~~

~~~  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim gaim-irchelper  
0 upgraded, 0 newly installed, 2 to remove and 310 not upgraded.  
Need to get 0B of archives.  
After unpacking 4743kB disk space will be freed.  
Do you want to continue [Y/n]?  
(Reading database ... 174409 files and directories currently installed.)  
Removing gaim-irchelper ...  
Removing gaim ...  
~~~

In this last case the configuration files of the package 'gaim' (basically how its setup) were not deleted from the system. As you could use them when installing the same package again and it would work 

If you want the config files deleted also, issue this command:

~~~  
apt-get purge gaim  
~~~

~~~  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim  
0 upgraded, 0 newly installed, 1 to remove and 309 not upgraded.  
Need to get 0B of archives.  
After unpacking 4678kB disk space will be freed.  
Do you want to continue [Y/n]? Y  
(Reading database ... 174405 files and directories currently installed.)  
Removing gaim ...  
Purging configuration files for gaim ...  
~~~

Note the `*`  after the package name in the output of apt . The asterisk in the output of apt indicates that the configuration files will also be removed.

<div class="divider" id="apt-downgrade"></div>
## Hold and/or Downgrade a package

Sometimes it may be necessary to rollback to a previous version of a package or put it on hold, due to a major bug with the latest version you have just installed.

Please understand that putting packages on hold is an emergency action, that can and will fall back on you if you forget to lift the hold. This holds true even more so, if the package on hold has many dependencies. Those will go on being upgraded with the package on hold being frozen. The more important the package on hold is, the more it will hurt when it falls on your feet. So please, do yourself a favour and use hold only for short periods of time.

### Hold

~~~  
echo package hold|dpkg --set-selections  
~~~

To take a package off Hold

~~~  
echo package install|dpkg --set-selections  
~~~

To list packages on hold:

~~~  
dpkg --get-selections | grep hold  
~~~

### Downgrading

 **`Debian does not support downgrading packages. While it may work in simple cases, it could fail spectacularly for other packages. Please refer to`**  [Emergency downgrading](http://www.debian.org/doc/manuals/reference/ch02.en.html#_emergency_downgrading) .

Despite the fact that it is not supportable, downgrading has been known to work for simple packages. The steps for downgrading a simple package using `kmahjongg`  as an example are:

1. comment unstable sources in `/etc/apt/sources.list.d/debian.list`  with a `#`   
2. Add testing sources in `/etc/apt/sources.list.d/debian.list` , for example:  
   ~~~    
   deb http://ftp.nl.debian.org/debian/ testing main contrib non-free    
   ~~~
  
3. ~~~    
   apt-get update    
   ~~~
  
4. ~~~    
   apt-get install kmahjongg/testing    
   ~~~
  
5. Put the newly installed package on hold with:  
   ~~~    
   echo kmahjongg hold|dpkg --set-selections    
   ~~~
  
6. comment &lt;#&gt;the testing sources in /etc/apt/sources.list.d/debian.list with and uncomment the unstable sources so that you get back to using unstable sources, then:  
7. ~~~    
   apt-get update    
   ~~~
  

When you do want to get the latest version of the package just do this:

~~~  
echo kmahjongg install|dpkg --set-selections  
apt-get update  
apt-get install kmahjongg  
~~~

<div class="divider" id="apt-upgrade"></div>
## Upgrade of an Installed System - dist-upgrade - Overview

If the whole system is to be upgraded this is achieved through a `dist-upgrade` . You should always check Current Warnings on the  [siduction](http://siduction.org)  main web site, and check the warnings against the packages that your system wants to dist-upgrade. If you need to `hold`  a package refer to  [Downgrade and Hold a package](sys-admin-apt-en.htm#apt-downgrade) 

An 'upgrade' only of 'debian sid' is not recommended.

##### Frequency of a dist-upgrade

dist-upgrade as routinely as you can, ideally once every week or two, at least 1 time per month to be safe. A dist-upgrade initiated only every 2 to 3 months should be considered the safe outer limit. For non-standard packages, or self compiled packages, you need to be much more careful with upgrading, since those may break your system at any time due to incompatibilities.

After the database is updated with `apt-get update` , one can find out which packages have new/newer versions: (first install apt-show-versions)

~~~  
apt-show-versions -u  
libpam-runtime/unstable upgradeable from 0.79-1 to 0.79-3  
passwd/unstable upgradeable from 1:4.0.12-5 to 1:4.0.12-6  
teclasat/unstable upgradeable from 0.7m02-1 to 0.7n01-1  
libpam-modules/unstable upgradeable from 0.79-1 to 0.79-3.........  
~~~

The update of a single package including its dependencies can for example (for gcc-4.0) be done with:

~~~  
apt-get install gcc-4.0  
Reading package lists... Done  
Building dependency tree... Done  
gcc-4.0 is already the newest version.  
0 upgraded, 0 newly installed, 0 to remove and xxx not upgraded  
~~~

#### Just downloading

`A little known and great option to do a check for what packages are in a dist-upgrade is the -d flag:`

~~~  
apt-get update && apt-get dist-upgrade -d  
~~~

The -d allows you to download the dist-upgrade without installing it whilst in X from the konsole and allows you to do the dist-upgrade in init 3 at a later time. This also gives you the chance to check warnings against the list as it wisely gives you the option to proceed or abort like this:

~~~  
apt-get dist-upgrade -d  
Reading package lists... Done  
Building dependency tree  
Reading state information... Done  
Calculating upgrade... Done  
The following NEW packages will be installed:  
elinks-data  
The following packages have been kept back:  
git-core git-gui git-svn gitk icedove libmpich1.0ldbl  
The following packages will be upgraded:  
alsa-base bsdutils ceni configure-ndiswrapper debhelper  
discover1-data elinks file fuse-utils gnucash.........  
35 upgraded, 1 newly installed, 0 to remove and 6 not upgraded.  
Need to get 23.4MB of archives.  
After this operation, 594kB of additional disk space will be used.  
Do you want to continue [Y/n]?Y   
~~~

`Y`  will download the upgraded packages without touching the installed system.

After the 'dist-upgrade -d' has downloaded, and you wish to complete the dist-upgrade, immediately or at a later time, please follow these steps:

<div class="divider" id="du-st"></div>
### dist-upgrade - The Steps

<div class="box block">
**NEVER EVER do a dist-upgrade nor upgrade whilst in X<div class="highlight-4"> Always check Current Warnings on the  [siduction](http://siduction.org)  main web site. The warnings are there for a reason due to the very nature of unstable (Debian sid), which also updates 4 times per day.**

~~~  
Log out of KDE.  
Go to Textmode by doing Ctrl+Alt+F1  
logon as root,  
and then type:  
init 3  
apt-get update  
apt-get dist-upgrade  
apt-get clean  
init 5 && exit  
~~~

**NEVER DIST-UPGRADE [or UPGRADE] with adept or synaptic:**


---

**`If you do not go to init 3, well tough for you, you have been warned!`**

<div class="divider" id="whyno"></div>
### The Reasons NOT to use anything else but apt-get or aptitude for a dist-upgrade

Package managers like adept, synaptic and kpackage are not always able to account for the huge amount of changes which happen in Sid (depedency changes, name changes, maintainer script changes, ...).

This is not the fault of the developers of those tools though, they write excellent tools for the debian stable branch, they are simply just not suitable for the very special needs of Debian Sid.

Use whatever you like to search for packages, but stick with apt-get for actually installing/removing/dist-upgrading.

Package managers like adept, synaptic and kpackage are at the least, non-deterministic (for complex package selection), mix that with a quickly moving target like sid and even worse an external repository of questionable quality (we don't use or recommend those, but they're a reality on your user systems) and you will be courting disaster.

The other item to note is that all of these types of GUI package managers need to run in in X, and in doing a dist-upgrade in X, (or even an 'upgrade' which is not recommended), you will end up damaging up your system beyond repair, maybe not today or tomorrow, however in time you will.

apt-get on the other hand strictly does what it is asked to do, if there is any breakage you can pinpoint and debug/ fix the cause, if apt-get wants to remove half of the system (due to library transitions) it's the admin's call (that means you) to have at least a serious look.

This is the reason why debian builds use apt-get, not the other package manager tools.

<div class="divider" id="apt-cache"></div>
## Searching for a package with apt-cache

Another very useful command in the APT-system is apt-cache; it searches the APT-Database and shows information on packages; e.g. a list of all packages, that contain or address "siduction" and "manual" is obtained by:

~~~  
$ apt-cache search bluewater-manual  
.......  
bluewater-manual-common - the official siduction manual - common files  
bluewater-manual-es - the official Spanish siduction manual  
bluewater-manual-de - the official German siduction manual  
bluewater-manual-el - the official Greek siduction manual  
bluewater-manual - the official siduction manual - all languages  
bluewater-manual-pt-br - the official Brazilian Portuguese siduction manual  
bluewater-manual-en - the official English siduction manual  
bluewater-manual-reader - siduction manual reader  
~~~

If you want more information on a particular package, you can use:

~~~  
$ apt-cache show bluewater-manual-en  
Package: bluewater-manual-en  
Priority: optional  
Section: doc  
Installed-Size: 1088  
Maintainer: Kel Modderman <kel@otaku42.de>  
Architecture: all  
Source: bluewater-manual  
Version: 01.12.2007.06.03-1  
Depends: bluewater-manual-common  
Filename: pool/main/s/bluewater-manual/bluewater-manual-en_00.00.2010.08.14-1_all.deb  
Size: 391222  
MD5sum: 60f2175c3c5709745a4b4256ccc3c49d  
SHA1: e275a0b27628b6aa210a4ced48d3646b438e78b8  
SHA256: 2792580c7a091521301064180a1d0d8901f0a4af407b90432b9f8d8b6b3603ca  
Description: the official en siduction manual  
This manual is divided into common sections, for example, .......  
~~~

All installable versions of the package (they depend on your sources.list) can be listed by typing:

~~~  
$ apt-cache policy bluewater-manual-xx  
bluewater-manual-xx:  
Installed: (none)  
Candidate: (none)  
Version table:  
500 http://siduction.net sid/main Packages  
~~~

 [A complete description of the APT-System can be found at APT-HOWTO](http://www.debian.org/doc/user-manuals#apt-howto)  

<div class="divider" id="gui-pacsea"></div>
## Debian Package Search GUI application

~~~  
apt-get update  
apt-get install packagesearch  
~~~

When you first start Debian Package Search you need to adjust Packagesearch>Preferences to use `apt-get` .

**`Please do not use Packagesearch to install packages, use it only as a GUI search engine. Upgrading packages and installing new packages without stopping X can cause problems. Please read  [Installing a new package](sys-admin-apt-en.htm#apt-install) .`** 

On initial use you may be prompted to install deborphan. Please use with care.

Search can be done by

+ pattern  
+ tags (based on the debtags system, a new way of categorizing Debian packages)  
+ files  
+ installed status  
+ orphaned packages  

Additionally, information about the packages is displayed, including the files belonging to them. Please read the Help>Contents for a full explanation on how to use the Debian Package Search GUI application. At the moment the GUI is in English only.

 [A complete description of the APT-System can be found at APT-HOWTO](http://www.debian.org/doc/manuals/apt-howto/) 

<div id="rev">Page last revised 015/01/2012 1200 UTC</div>
