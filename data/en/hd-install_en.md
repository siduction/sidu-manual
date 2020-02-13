<div id="main-page"></div>
<div class="divider" id="Inst-prep"></div>
## HD Install Preparation

**`For normal desktop usecases we recommend ext4; it is the default file system for siduction and is well maintained.`**

`Before installation please remove all usb-sticks, cameras, etc` .  [Installation to USB Devices requires additional steps.](hd-install-opts-en.htm#usb-hd)  You can edit the installer file: `~/.sidconf` , and thereby use a different filesystem or spread your installation over different partitions. For example a separate /home.

`It is highly recommended that you have a separate data partition. The benefits in terms of disaster recovery, stability of your data are unmeasurable.`

Therefore your $HOME becomes a place where basic application configurations are kept. or to put it another way, a container for applications to store their settings.

###### Re-installing applications to rebuild or duplicate to another computer

To make a list of your installed applications so you can duplicate the installed base on another machine, or perhaps you are for some reason, reinstalling on your current PC, in a konsole

~~~  
dpkg -l|awk '/^ii/{ print $2 }'|grep -v -e ^lib -e -dev -e $(uname -r) >/home/username/installed.txt  
~~~

Then copy the text file to a usb key or any other removable media of your choice.

On the new machine copy the text file to $HOME and use the list as a reference to install your required applications. The full list can be installed with

~~~  
apt-get install $(<installed.txt)  
~~~

</p>
##### RAM and Swap

On PC's with less than 512 MB RAM you must have a swap-partition. The size should not be less than 128 mb (cfdisk-output should not be trusted either as it calculates with a 10-base), more than 1 GB swap is seldom reasonable, except if you are copying large data files, like copying CD/DVD data on-the-fly, and/or you need suspend-to-disk/hibernate and server systems. If this is your case, allocate 2 GIG swap, as a minimum.

`Please see:  [Partitioning your HD](part-gparted-en.htm#partition) `

**`ALWAYS BACK-UP YOUR DATA including your bookmarks and emails!`**  See  [Back-Up with rdiff](sys-admin-rdiff-en.htm#rdiff)  and  [Back-Up with rsync](sys-admin-rsync-en.htm#rsync) . Another option is sbackup (needs installing).

Installation to the hard drive is much more comfortable and lots faster than running a system off a live-CD.

First, you need to set your boot order in the BIOS to CD-ROM. With most computers you can get to the Bios-setup by pressing [del] key while booting (with some BIOS-Versions you can simply choose the boot device while booting, with AMI-BIOS, e.g., with F11 or F8).

siduction should boot up now in most cases. If that's not the case, you can use boot-options, (called cheatcodes) which can be issued in the boot manager. Using boot parameters (e.g. for screen resolution or language selection) can save a lot of time with the post-install configuration.  [Also see Cheatcodes](cheatcodes-en.htm#cheatcodes-siduction)  and  [VGA Resolutions](cheatcodes-vga-en.htm#vga) 

<!-- hiding crap for the moment
<div class="divider" id="efi"></div>
## (U)EFI booting

The bootloader will be an EFI program installed to `/efi/siduction`  within your `EFI system partition`  and mounted below `/boot/efi/`  on your installed system, provided the following conditions are met:

+ The BIOS needs to be EFI capable, and turned on, and selected to be bootable.  
+ x86-64/ EM64T system (amd64) machines.  
+ A current siduction-amd64.iso</li><li>Booted using UEFI and this is apparent from the plain white/blue grub2 menu, instead of the usual graphical boot menu provided by isolinux for BIOS booting, on the live medium.  
+ A vfat formatted EFI system partition on a GPT disk (type EF00) exists on the target system.  
+ The install target is not a USB disk.  

For partitioning GPT disks consult  [Partitioning with gdisk for GPT disks.](part-gdisk-en.htm#gdisk-1) 

-->
<!-- hiding crap for the moment <div class="divider" id="lang"></div>
## Choosing the language for your installation

###### `Language Installs with KDE` 

Select your main language from the **`grub menu (F4)`**  in the `kde-full release` , to install the localisations for the desktop and many applications while booting. 

This ensures they are also present after installing siduction, while only installing the required languages for the given system. The amount of memory required for this feature depends on the language and siduction may refuse to install the given language packs automatically with insufficient RAM and the boot sequence will be continued in English language but with the desired locales settings (currency, date and time format, keyboard charsets). 1 GB memory or more should be safe for all supported languages, which are:

  
Default - Deutsch (German)  
Default - English (English-US)  
*Čeština (Czech)  
*Dansk (Danish)  
*Español (Spanish)  
*English (GB)  
*Français (French)  
*Italiano (Italian)  
*Nihongo (Japanese)  
*Nederlands (Dutch)  
*Polski (Polish)  
*Português (Portuguese BR and PT)  
*Română (Romanian)  
*Русский (Russian)  


The language selection depends on the availability of siduction-manual translations, get involved to add your language.

-->
###### `Other Language installs with KDE-lite` 

1. Select your main language from the **`gfxboot menu (F4)`** . (See also  [siduction specific Live-CD Cheatcodes](cheatcodes-en.htm#cheatcodes) ). The Language files themselves are not on the Live-CD so the system will fall back to default English. However, this will make the correct language configuration needed for your preferred language and therefore no need to make any changes into the system, aside from the installation of the missing language files.  
2.  Start the installation.  
3. Install to HD and reboot.  
4. After HD install, install the language of your choice and applications via apt-get.  

###### First Time boot up to the HD

`After booting up for the first time you will discover that siduction has forgotten its network configuration` . The network can be comfortably set up from  [Kmenu > Internet > Ceni](inet-ceni-en.htm#netcardconfig) . For additional WIFI/WLAN roaming [please read this.](inet-wpagui-en.htm) 

<div class="divider" id="Installation"></div>
## The siduction-Installer

 **1.**  The Installer is started from the `Desktop icon, the KMenu> System>siduction-installer` .

![siduction-Installer1](../images-en/installer-en/installer1-en.png "Welcome tab - siduction Installer") 


---

 **2.**  After reading (and understanding) the warning text we move on to preparing the hard disk. 

![siduction-Installer2](../images-en/installer-en/installer2-en.png "Partitioning tab - siduction Installer") 

`Have you backed up your data?`

If you haven't partitioned your hard drive yet, click on the `Execute`  button in the `Start Part.-manager`  panel, also have a look at  [Partitioning your HD using Gparted](part-gparted-en.htm#partition)  or, if you want to use the shell, read  [Partitioning your HD](part-cfdisk-en.htm#disknames) 


---

 **3.**  Now choose where the installation is supposed to go to and we establish the mount points. Partitions which you do not establish mount points for, will be auto mounted (the swap partition will always be automatically mounted, when the system starts). 

**`NOTE: Your root partition ('/") will be formatted with your preferred file system.`** 

![grub-to-mbr](../images-en/installer-en/installer3-en.png "Grub/Timesone tab - siduction Installer") 


---

 **4.**  In this part you can choose if you would like to create other mount points than /. We do recommend a separate /home/. However, `it is at this moment you can also choose to create a data partition.`  `Just add your choices for each partition` .

All other partitions will be placed as a `/media/`  partition.

![choosing-pw](../images-en/installer-en/installer4-en.png "User/Password tab - siduction Installer") 


---

 **5.**  As a boot manager siduction uses GRUB, therefore install  **Grub to MBR** ! If you make a different choice here, you should know what you are doing. You would have to edit other bootmanagers manually, if you want to keep them.

Grub recognizes other installed OS's (e.g. Windows) and adds them to the boot menu. 

Moreover you are able to change the timezone in this window.

![hostname](../images-en/installer-en/installer5-en.png "Network tab - siduction Installer") 


---

 **6.**  On we go with user, his/her password and the root-password (remember those!). Please don't choose too easily-guessed passwords. To add additional users, do so after installation via the terminal with  [](hd-install-en.htm#adduser)  adduser.  
This query is the last chance to check the adjustments you made. Read through it again carefully, then click `Next` .

![installation-config](../images-en/installer-en/installer6-en.png "Installation tab - siduction Installer") 

 **7.**  Now choose the name of the Installation (you can name it anything you wish, provided that the 'Hostname: The hostname should consist of letters (and numbers) only and it must not begin with a number'.

![installation-config](../images-en/installer-en/installer7-en.png "Installation tab - siduction Installer") 

After that you can choose whether ssh shall start automatically or not.

At this point it is possible to change/edit the config file and then start the install procedure with the changed configuration. The installer does not make any checks and you `must not click the 'back' on the installer otherwise the changes entered manually will be lost.`  

![Begin Installtion](../images-en/installer-en/installer8-en.png "Begin Installation - siduction Installer") 

To commence the installation click on `Begin Installation`  The whole process takes, depending on your system, between 5 - 15 minutes, on older PCs it may take as long as 60 minutes..

If the progress bar hangs in one place for a while, don't abort, just give it some time.

Finished! Take the CD out of the tray. Now reboot to your new HD Install.

<div class="divider" id="first-hd-boot"></div>
## First Bootup

`After booting up for the first time you will discover that siduction has forgotten its network-configuration. So you have to reconfigure your network (Wlan, Modem, ISDN,...).`

Whomever previously had their network address automatically (DHCP) detected by using a DSL-Router must reactivate it with:

~~~  
ceni  
~~~

The appropriate tools are still to be found in the  *Kmenu >Internet> ceni* . Also refer to:  [Internet and Networking](inet-ceni-en.htm#netcardconfig) 

To add an existing siduction $home partition to new installation fstab needs to be altered, refer to  [Moving /home](home-en.htm#home-move) .

 **`Do not use or share an existing $home from another distribution as the $home configuration files in a home directory will conflict if you share the same username between differing distributions.`** 

<div class="divider" id="adduser"></div>
## To add users to your installation

To add a `new user`  with automatic group permissions granted, as root: 

~~~  
adduser <newuser>  
~~~

 Just press enter, it should take care of the complexities. You will get asked to type in the password twice.

siduction specific icons (like the manual and IRC icons) need adding manually.

To delete a user

~~~  
deluser <user>  
~~~

Read

~~~  
man adduser  
man deluser  
~~~

`kuser`  can create new user as well, however you will need to manually adjust the group permissions for that user.

<div class="divider" id="suxterm"></div>
## About suxterm

Numerous commands need to be run with root privileges. To achieve this you type:

~~~  
suxterm  
~~~

While the common command for becoming root is 'su' using `suxterm`  instead will allow you run GUI / X11 applications from the command line and allow root to start graphical applications, as `suxterm`  is a wrapper around the standard su command which will transfer your X credentials to the target user.

Some KDE applications require `dbus-launch`  in front of the application:

~~~  
dbus-launch <Application>  
~~~

An example of running an X11 app via suxterm is to use a text editor to edit a root file like kwrite or kate, to do partitioning with gparted or an Xapp file manager like konqueror. You can also alter root files by right clicking the file and choosing 'edit-as-root', and entering your root password, this will call kdesu in the background.

Unlike 'sudo', it means that someone can't just come along and type 'sudo' and make potentially damaging changes to your system.

**`WARNING: While you are logged in as root, the system will not stop you from doing potentially dangerous things like deleting important files etc., you have to be absolutely sure about what you are doing, because it's very possible to seriously harm your system. `**

**`Under no circumstances should you be as root in the console/terminal to run applications that a standard user uses to go about being productive on a day to day basis, like sending emails, creating spreadsheets or surfing the internet and so forth. `**

<div id="rev">Content last revised 26/11/2014 1800 UTC</div>
