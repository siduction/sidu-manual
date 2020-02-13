<div id="main-page"></div>
<div class="divider" id="vmopts"></div>
## Virtual Machine options

+  [KVM for Intel VT or AMD-V](hd-install-vmopts-en.htm#kvm)   
+  [Virtualbox](hd-install-vmopts-en.htm#vbox)   
+  [QEMU](hd-install-vmopts-en.htm#qemu)   
+  [Installing other distributions to an image](hd-install-vmopts-en.htm#oos)   

`The following examples use siduction, simply substitute siduction with the distribution of your choice.` 

<div class="divider" id="oos"></div>
## Installing other distributions to a VM image

Note: If and when you wish to install to a virtual machine image, most Linux distributions will probably only need an allocation of 12G. However if you have a requirement to have MS Windows in a virtual machine, you will need to allocate about a 30G, or more, to the image. All image allocation sizes ultimately depend on your requirements. 

Generally, an image allocation size, will not take up additional hard drive space until data is installed. Even then, it will only take space dynamically on a hard drive, contingent to the actual amount of data that expands on the image. This is due to the compression ratios of qcow2.

<div class="divider" id="kvm"></div>
## Enabling a KVM Virtual Machine

KVM is a full virtualisation solution for Linux running on x86 CPU with virtualisation extensions (Intel VT or AMD-V).

### Prerequisites

To ascertain whether your hardware supports KVM, ensure that KVM is enabled in the BIOS, (in some cases on an Intel VT or AMD-V system it may not evident as to where the switch is, therefore assume that it is in a KVM state). The way to check is in a console run:

~~~  
cat /proc/cpuinfo | egrep --color=always 'vmx|svm'  
~~~

If you see `svm`  or `vmx`  in the cpu flags field, your system supports KVM. (Otherwise go back to the BIOS if you believe it is supported and check again, else search the internet as to where in the BIOS menus KVM 'enable' could be hiding).

Should your BIOS not support KVM refer to  [Virtualbox](hd-install-vmopts-en.htm#vbox)   
or  [QEMU](hd-install-vmopts-en.htm#qemu) 

To install and run KVM, firstly ensure that Virtualbox modules are not loaded, (--purge them is the best option), then depending on your chipset:

For `vmx` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-intel  
~~~

For `svm` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-amd  
~~~

When you start your system the qemu-kvm initscripts will take care of loading the modules.

#### Using KVM to boot an siduction-*.iso

**`As user:`** 

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom <siduction.iso>  
~~~

##### Installing siduction to a KVM image

First create a hard disk image, (this image will be minimal and only grow as required due to qcow2 compression ratios):

~~~  
$ qemu-img create -f qcow2 siduction-VM.img 12G  
~~~

Boot the siduction-*.iso with the following parameters to enable KVM to recognise that there is an QEMU hard disk image available:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom </path/to/siduction-*.iso> -boot d </path/to/siduction-VM.img>  
~~~

Once the cdrom has booted up click on the siduction installer icon to activate the installer, (or use the menu), click on the Partitioning tab and launch the partition application you prefer. For the partitioning you can follow the instructions from  [Partitioning the Hard Drive - Traditional, GPT and LVM](part-gparted-en.htm)  (do not forget to add a swap partition If you are short of memory). Please be aware that formatting will take time so be patient.

![gparted kvm hard disk naming](../images-common/images-vm/kvm-gparted02.png "gparted kvm hard disk naming") 


---

You now have a VM ready for use:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -drive if=virtio,boot=on,file=<path/to/siduction-VM.img>    
~~~
  
Some guests do not support virtio, therefore you need to use other options when launching KVM, for example:

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img> -cdrom your_other.iso -boot d  
~~~

or

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img>  
~~~

See also:  [KVM documentation](http://www.linux-kvm.org/page/Main_Page) .

##### Managing your KVM virtual machine installations

~~~  
apt-get install aqemu  
~~~

When using AQEMU ensure that you choose the KVM mode from the drop down box for 'Emulator Type' in the 'General' tab. (Documentation for AQEMU is basically non existent, therefore a few 'trials by error' will be required to figure out the easy to use GUI, however a good start is to use first use the 'VM' menu followed by the 'General' tab).

<div class="divider" id="vbox"></div>
## Booting and installing to a VirtualBox Virtual Machine

The Steps.

+ 1. create a harddiskimage for VirtualBox  
+ 2. boot the iso with VirtualBox  
+ 3. install on the image  

#### Requirements

`Recommended ram: 1 gig` : Ideally 512 MB for the guest and 512 MB for the host. (it can be run on less, but do not expect to have good performance).

`Hard disk space:`  While VirtualBox itself is very lean (a typical installation will only need about 30 MB of hard disk space), the virtual machines will require fairly huge files on disk to represent their own hard disk storage. So, to install MS Windows XP (TM), for example, you will need a file that will easily grow to several GB in size. To have siduction in VirtualBox you need to allocate a 5 gig image plus a swap allocation.

### Installation:

~~~  
apt-get update  
apt-get install virtualbox virtualbox-dkms  
~~~

or
~~~  
apt-get update  
apt-get install virtualbox-qt virtualbox-dkms  
~~~

for installations with KDE or Razor-Qt

### Installing siduction to the virtual machine

Use virtualbox's wizard to create a new virtual machine for siduction, then follow the instructions for a regular siduction-installation.

 [VirtualBox has a comprehesive PDF Help, that you can download](http://www.virtualbox.org/)  

<div class="divider" id="qemu"></div>
## Booting and installing a QEMU Virtual Machine

+ 1. create a harddiskimage for QEMU  
+ 2. boot the iso with QEMU  
+ 3. install on the image  

A QT GUI tool is available to help configure QEMU:

~~~  
apt-get install qtemu  
~~~

#### Creating the hard disk image

To run qemu you will probably need a hard disk image. This is a file which stores the contents of the emulated hard disk.

Use the command:

~~~  
qemu-img create -f qcow siduction-VM.img 3G  
~~~

To create the image file named "siduction-VM.img". The "3G" parameter specifies the size of the disk - in this case 3 GB. You can use suffix M for megabytes (for example "256M"). You shouldn't worry too much about the size of the disk - the qcow format compresses the image so that the empty space doesn't add up to the size of the file.

#### Installing the operating system

This is the first time you will need to start the emulator. `One thing to keep in mind: when you click inside qemu window, the mouse pointer is grabbed. To release it press :` 

~~~  
Ctrl+Alt  
~~~

If you want to use a bootable floppy, run Qemu with:

~~~  
qemu -floppy siduction.iso -net nic -net user -m 512 -boot d siduction-VM.img  
~~~

If your CD-ROM is bootable, run Qemu with:

~~~  
qemu -cdrom siduction.iso -net nic -net user -m 512 -boot d siduction-VM.img  
~~~

Now install siduction as if you were going to install it on a real HD

#### Running the system

To run the system simply type:

~~~  
qemu [hd_image]  
~~~

A good idea is to use overlay images. This way you can create hard disk image once and tell Qemu to store changes in external file. You get rid of all the instability, because it is so easy to revert to previous system state.

To create an overlay image, type:

~~~  
qemu-img create -b [[base''image]] -f qcow [[overlay''image]]  
~~~

Substitute the hard disk image for base_image (in our case siduction-VM.img). After that you can run qemu with:

~~~  
qemu [overlay_image]  
~~~

The original image will be left untouched. One hitch, the base image cannot be renamed or moved, the overlay remembers the base's full path.

#### Using any real partition as the single primary partition of a hard disk image

Sometimes, you may wish to use one of your system partition from within qemu (for instance, if you wish booting both your real machine or qemu using a given partition as root). You can do this using software RAID in linear mode (you need the linear.ko kernel driver) and a loopback device: the trick is to dynamically prepend a master boot record (MBR) to the real partition you wish to embed in a qemu raw disk image.

Suppose you have a plain, unmounted /dev/sdaN partition with some filesystem on it you wish to make part of a qemu disk image. First, you create some small file to hold the MBR:

~~~  
dd if=/dev/zero of=/path/to/mbr count=32  
~~~

Here, a 16 KB (32 * 512 bytes) file is created. It is important not to make it too small (even if the MBR only needs a single 512 bytes block), since the smaller it will be, the smaller the chunk size of the software RAID device will have to be, which could have an impact on performance. Then, you setup a loopback device to the MBR file:

~~~  
losetup -f /path/to/mbr  
~~~

Let's assume the resulting device is /dev/loop0, because we wouldn't already have been using other loopbacks. Next step is to create the "merged" MBR + /dev/sdaN disk image using software RAID:

~~~  
modprobe linear  
mdadm --build --verbose /dev/md0 --chunk=16 --level=linear --raid-devices=2 /dev/loop0 /dev/sdaN  
~~~

The resulting /dev/md0 is what you will use as a qemu raw disk image (don't forget to set the permissions so that the emulator can access it). The last (and somewhat tricky) step is to set the disk configuration (disk geometry and partitions table) so that the primary partition start point in the MBR matches the one of /dev/sdaN inside /dev/md0 (an offset of exactly 16 * 512 = 16384 bytes in this example). Do this using fdisk on the host machine, not in the emulator: the default raw disc detection routine from qemu often results in non kilobyte-roundable offsets (such as 31.5 KB, as in the previous section) that cannot be managed by the software RAID code. Hence, from the the host:

~~~  
fdisk /dev/md0  
~~~

There, create a single primary partition corresponding to /dev/sdaN, and play with the 's'ector command from the 'x'pert menu until the first cylinder (where the first partition starts), matches to the size of the MBR. Finally, 'w'rite the result to the file: you are done. You now have a partition you can mount directly from your host, as well as part of a qemu disk image:

~~~  
qemu -hdc /dev/md0 [...]  
~~~

You can of course safely set any bootloader on this disk image using qemu, provided the original /boot/sdaN partition contains the necessary tools.

<!-- #### Using the QEMU Accelerator Module -->

<!-- The developers of qemu have created an optional kernel module to accelerate qemu to sometimes near native levels. This should be loaded with the option

 -->
~~~  
<!--  -->  
<!-- major=0 -->  
<!--  -->  
~~~

<!-- to automate the creation of the required /dev/kqemu device. The following command

 -->
~~~  
<!--  -->  
<!-- echo "options kqemu major=0" >> /etc/modules -->  
<!--  -->  
~~~

<!-- This will amend modprobe.conf to ensure that the module option is added every time the module is loaded.

 -->
~~~  
<!--  -->  
<!-- qemu [...] -kernel-kqemu -->  
<!--  -->  
~~~

<!-- This enables full virtualization and thus improves speed considerably.

 -->
<!-- #### To activate qemu: -->

~~~  
<!--  -->  
<!-- qemu -cdrom /tmp/pkg/siduction-debug.iso -net nic -net user -m 512 -->  
<!--  -->  
~~~

 [The official documentation of the QEMU Project](http://www.nongnu.org/qemu/user-doc.html)  

 [Some content for QEMU for the siduction-manual was accessed off this site under GNU Free Documentation License 1.2 and modified for the siduction-manual](http://wiki.archlinux.org/index.php/Qemu)  

<div id="rev">Page last revised 08/01/2012 1800 UTC</div>
