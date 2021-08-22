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
% fromiso

## Boot from ISO file

### Overview

This cheat code boots from an ISO file on the hard drive with the ext4 file system. **For normal use, we recommend siduction's default file system, ext4, which is well maintained by maintainers.
 
Booting from a "fromiso" hard disk installation takes only a fraction of the time it takes to boot from a CD. 
In addition, the CD/DVD drive is available at the same time. Alternatively you can use VBox, KVM or QEMU.

**Prerequisites**

* a working Grub installation (on floppy, a hard disk installation or the live CD)  
* a siduction image file, e.g. siduction.iso (name shortened) and a Linux filesystem like ext4  

### fromiso with grub2

siduction provides a grub2 file named 60_fll-fromiso to generate a fromiso entry in the grub2 menu. The configuration file for fromiso is in the package `grub2-fll-fromiso` , with the path `/etc/default/grub2-fll-fromiso` .

 First, open a terminal and become root with:

~~~sh
su
apt-get update
apt-get install grub2-fll-fromiso
~~~

Then open an editor of your choice (kwrite, mcedit, vim ...):

~~~sh
mcedit /etc/default/grub2-fll-fromiso
~~~

In the lines that should be active, remove the comment sign (**#**) and replace the default statements inside the double quotes (**"**) with your own parameters. 

Example: compare this modified grub2-fll-fromiso with the default settings:

~~~sh
# defaults for grub2-fll-fromiso update-grub helper
# sourced by grub2's update-grub
# installed at /etc/default/grub2-fll-fromiso by the maintainer scripts

#
# This is a POSIX shell fragment
#

# specify where to look for the ISO
# default: /srv/ISO
## Attention: This is the path to the directory where the ISO(s) are located,  
## the path should not include the actual siduction.iso.
FLL_GRUB2_ISO_LOCATION="/media/disk1part4"

# array for defining ISO prefices --> siduction-*.iso
# default: "siduction- fullstory-"
FLL_GRUB2_ISO_PREFIX="siduction-"

# set default language
# default: en_US
FLL_GRUB2_LANG="de_DE"

# override the default timezone.
# default: UTC
FLL_GRUB2_TZ="Europe/Berlin" 

# kernel framebuffer resolution, see
# http://manual.siduction.org/de/cheatcodes-vga-de.htm#vga
# default: 791
#FLL_GRUB2_VGA="791"

# additional cheatcodes
# default: noeject
FLL_GRUB2_CHEATCODE="noeject nointro" 
~~~

Save the changes, close the editor and execute the following command as root in a terminal:

~~~sh
update-grub
~~~

This will update the Grub2 configuration file grub.cfg to recognize the ISOs placed in the specified directory. These will be available for selection at the next reboot.

### toram

Another useful option when booting from live media is `toram`. This is recommended if the computer has enough memory (4Gi).  
memory (4GiB or more). This copies the complete content of the live medium into the ram. This has the advantage that the   
system reacts then very fast and one can remove the medium then also. This is useful if the start was done from a USB stick,  
and one wants to use this USB port otherwise.

<div id="rev">Last edited: 2021-14-08</div>
