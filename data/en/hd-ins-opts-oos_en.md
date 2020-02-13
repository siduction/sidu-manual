<div id="main-page"></div>
<div class="divider" id="raw-usb"></div>
## Writing an siduction ISO to a USB stick, SSD card, SDHC device with any Linux, MS Windows(tm); or Mac OS X(tm); Operating System

No matter what operating system you use, the following methods will enable you to install a siduction ISO to a USB-Stick, SSD card, SDHC device, (Secure Digital High Capacity card).

The siduction ISO image is written to the device and while persist is not possible, it does allow you to have siduction-on-a-stick. 

If persist is a requirement, install-usb-gui is not subject to these limitations and therefore is the recommended option where an existing siduction system is available, refer to  [USB/SSD fromiso Installation - siduction-on-a-stick](hd-install-opts-en.htm#usb-from1) .

### Prerequisites

+ `Ensure that the BIOS on the PC that you wish to boot with siduction-on-a-stick/card can actually boot up USB-Sticks or SSD cards. This is usually any PC that has a USB 2.0 or 3.0 protocol and supports booting from USB/SSD.`   
+ The USB/SSD should be recognised automatically and you should see the `F4`  menu option will say `Hard Disk` , otherwise invoke `F4 >Hard Drive`  or add `fromhd`  to the boot menu bootline.  
+ **`It is important to note that the following methods will overwrite and destroy any existing partition table of the targeted media. Data loss will depend on size of the siduction-*.iso. It does not restrict the available storage as far as Linux is concerned and you may be able to regain any data left that the ISO has not wiped out, however MS Windows seems to only allow one partition. So please be safe and do not do this to your 100+- gig hardrive!`**   

 [Linux](#raw-lin)  &nbsp; [MS Windows](#raw-ms)  &nbsp; &nbsp; [Mac OS X](#raw-mac)  

<div class="divider" id="raw-lin"></div>
### Linux Operating Systems

Plug in your USB-Stick or card reader with the card you wish to write to and:

~~~  
cat /path/to/siduction-*.iso > /dev/USB_raw_device_node  
~~~

or

~~~  
dd if=/path/to/siduction-*.iso of=/dev/sdX  
~~~

To find out, what the X in sdX represents in your case, run the  *fdisk -l*  command.

###### Example:

Plug in your device run `dmesg`  and look at the output:

~~~  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sdf: sdf1 sdf2  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Attached SCSI removable disk  
~~~

Assuming an ISO called `siduction-11.1-OneStepBeyond--i386-2011xxxxx`  was downloaded, (you could rename it to `siduction-11.1-onestepbeyond.iso` ), then the command to run will be:

~~~  
cat /home/username/siduction-11.1-onestepbeyond.iso > /dev/sdf  
~~~

or

~~~  
dd if=/home/username/siduction-11.1-onestepbeyond.iso of=/dev/sdf  
~~~

The USB/SSD should be recognised automatically and you should see the `F4`  menu option will say `Hard Disk` , otherwise invoke `F4 >Hard Drive`  or add `fromhd`  to the boot menu bootline.

<div class="divider" id="raw-ms"></div>
### MS Windows(tm); Systems

This is fast and simple. Download the tool  [USBWriter](http://sourceforge.net/p/usbwriter/wiki/Documentation/) . It does not need to be installed, you can just start it from your desktop or your home. Select the image you want to write and the device to write it to (e.g. your usb pen) Be very careful when selecting the device, because the procedure deletes all data on the device. Selecting the wrong device or partition will lead to data loss! To start the process, just hit  *WRITE* -Button. In a few minutes your image will be written to the device, ready for you to boot it.

<div class="divider" id="raw-mac"></div>
### Mac OS X(tm); Systems

Insert your usb device, Mac OS X should automatically mount it. In the Terminal (found in Applications &gt; Utilities folders), run:

~~~  
diskutil list  
~~~

Ascertain what your usb device is called and then unmount the partitions on the device (let us assume /dev/disk1):

~~~  
diskutil unmountDisk /dev/disk1  
~~~

Assuming an ISO called `siduction-11.1-OneStepBeyond--i386-2011xxxxx`  was downloaded, to `/Users/username/Downloads/` , (you could rename it to `siduction-11.1-onestepbeyond.iso` ) and if the USB Device is designated as `disk1` , run:

~~~  
dd if=/Users/username/Downloads/siduction-11.1-onestepbeyond.iso of=/dev/disk1  
~~~

The USB/SSD should be recognised automatically and you should see the `F4`  menu option will say `Hard Disk` , otherwise invoke `F4 >Hard Drive`  or add `fromhd`  to the boot menu bootline.

<div id="rev">Page last revised 08/01/2012 1800 UTC</div>
