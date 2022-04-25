% fromiso

## Boot from ISO file

### Overview

This cheat code boots from an ISO file located on the hard drive with an **ext4** file system. **For normal use, we recommend siduction's default file system, ext4**, which is well maintained.
 
Booting from a "fromiso" hard disk installation takes only a fraction of the time it takes to boot from a CD. In addition, the CD/DVD drive is available at the same time. Alternatively you can use VBox, KVM, or QEMU.

**Prerequisites**

* a working Grub installation (on floppy, a hard disk installation, or the live CD)
* a siduction image file, e.g. `siduction.iso` (name shortened) and a Linux filesystem like **ext4**

### fromiso with grub2

siduction provides a grub2 file named `60_fll-fromiso` to generate a fromiso entry in the grub2 menu. The configuration file for fromiso can be found in the package `grub2-fll-fromiso`, with the path `/etc/default/grub2-fll-fromiso`.

 First, open a terminal, become **root** and install `grub2-fll-fromiso`:

~~~sh
su
apt-get update
apt-get install grub2-fll-fromiso
~~~

Then, open the configuration file in an editor of your choice (`kwrite`, `mcedit`, `vim`, ...):

~~~sh
mcedit /etc/default/grub2-fll-fromiso
~~~

In the lines that should be active, remove the comment sign (**#**) and replace the default statements inside the double quotes (**"**) with your own parameters. 

Example: compare this modified `grub2-fll-fromiso` with the default settings:

~~~sh
# defaults for grub2-fll-fromiso update-grub helper
# sourced by grub2's update-grub
# installed at /etc/default/grub2-fll-fromiso
# by the maintainer scripts

#
# This is a POSIX shell fragment
#

# specify where to look for the ISO
# default: /srv/ISO
## Attention: This is the path to the directory where the
## ISO(s) are located, the path should not include the
## actual siduction.iso.
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

Save the changes, close the editor and execute the following command as **root** in a terminal:

~~~sh
update-grub
~~~

This will update the grub2 configuration file `grub.cfg` to recognize the ISOs placed in the specified directory. These will be available for selection at the next reboot.

### toram

Another useful alternative when booting from live media is `toram`. This is recommended if the computer has enough 
RAM available (4 GByte or more). `toram` copies the complete content of the live medium into the RAM. The advantage is that the system reacts very fast and you can remove the medium after boot. This is useful if the start was done from a USB stick and you want to use this USB port otherwise.

<div id="rev">Last edited: 2022/03/31</div>
