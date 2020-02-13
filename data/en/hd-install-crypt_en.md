<div id="main-page"></div>
<div class="divider" id="install-crypt"></div>
## Installing to a cryptroot

**`Please note: There are some caveats using this guide for encrypting root or data partitions. These are:`**  

+ Applicable for siduction-2011.1-onestepbeyond.iso forward.  
+ This is a basic guide to get you started. It is your responsibilty to learn more about LUKS, cryptsetup and encryption. Sources and Resources are linked at the bottom of this page which will be of help, however the list is definitely not exhaustive.  
+ cryptsetup cannot encrypt an existing data partition, so you must create a new partition, set it up with cryptsetup and then move your data onto it.  
+ You can also use key files and have multiple keys for the data, (up to 8, including the removal of keys), which is outside the scope of this guide.  
+ `Do not forget the passphrases as you will lose access to everything! Even a chroot without knowing the passphrases will not of be of any help except for /boot.`   
+ Early in the boot process you will be asked for your passphrase for the crypt device and the system will boot up as expected.  

### Encryption examples:

+  [Using crypt within LVM groups](hd-install-crypt-en.htm#lvm) .  
+  [Notes for crypt with traditional partitioning methods](hd-install-crypt-en.htm#simple) .  

<div class="divider" id="lvm"></div>
## Encryption within LVM groups

<span class= "highlight-3">This example uses crypt inside the LVM volume to enable you let you split your home from <span class= "highlight-2"> / </span> and have a swap partition without needing multiple passwords and is applicable from siduction-2011.1-onestepbeyond.iso-onestepbeyond.iso and later.</span>

Before running the installer you must prepare the filesystems which will be used for the installation. For basic LVM partitioning guidelines, you need to refer to  [Logical Volume Manager - LVM partitioning](part-lvm-en.htm#part=lvm) . 

You will need at least an unencrypted <span class= "highlight-3">/boot </span>filesystem and an encrypted <span class= "highlight-2"> / </span>filesystem and also create encrypted <span class= "highlight-3">/home and swap</span> filesystems. 

1. If you are not planning to use an existing lvm volume group then create a normal lvm volume group. This example will assume that the volume group is called <span class= "highlight-3">vg</span> to hold your boot and encrypted data.  
2. You will need a logical volume for /boot and the encrypted data so use <span class= "highlight-3">lvcreate</span> to create the logical volumes in <span class= "highlight-3">vg</span> volume group with the sizes you want:  
   ~~~    
   lvcreate -n boot --size 250m vg    
   lvcreate -n crypt --size 300g vg    
   ~~~
  
   Here you have named the logical volumes boot and crypt and made them 250Mb and 300Gb respectively.  
3. Create the filesystem for <span class= "highlight-3">/boot</span> so it will be available in the installer:  
   ~~~    
   mkfs.ext4 /dev/mapper/vg-boot    
   ~~~
  
4. Use <span class= "highlight-3">cryptsetup</span> to encrypt <span class= "highlight-3">vg-crypt</span> using the faster xts option with the highest strength key length of 512bit and then open it. This will ask you for your password twice to set it and then a third time to open it. Open it here under the default boot time cryptopts target name of cryptroot:  
   ~~~    
   cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/mapper/vg-crypt    
   ~~~
  
   ~~~    
   cryptsetup luksOpen /dev/mapper/vg-crypt cryptroot    
   ~~~
  
5. Now use lvm inside the encrypted device to create a second volume group that will be used for the <span class= "highlight-3">/swap</span> and <span class= "highlight-3">/home</span> devices. <span class= "highlight-3">pvcreate</span> cryptroot to make it a physical volume and use it with <span class= "highlight-3">vgcreate</span> to create another volume group, we call it <span class= "highlight-3">cryptvg</span>:  
   ~~~    
   pvcreate /dev/mapper/cryptroot    
   vgcreate cryptvg /dev/mapper/cryptroot    
   ~~~
  
6. Next use <span class= "highlight-3">lvcreate</span> with the new encrypted <span class= "highlight-3">cryptvg</span> volume group to create the <span class= "highlight-2"> / </span>, <span class= "highlight-3">/swap</span> and <span class= "highlight-3">/home </span>logical volumes with the sizes you want:  
   ~~~    
   lvcreate -n swap --size 2g cryptvg    
   lvcreate -n root --size 40g cryptvg    
   lvcreate -n home --size 80g cryptvg    
   ~~~
  
   Here you have named the logical volumes swap, root and home and made them 2Gb, 40Gb and 80Gb respectively.  
7. Create the filesystems for cryptvg-swap, cryptvg-root and cryptvg-home so they are available in the installer:  
   ~~~    
   mkswap /dev/mapper/cryptvg-swap    
   mkfs.ext4 /dev/mapper/cryptvg-root    
   mkfs.ext4 /dev/mapper/cryptvg-home    
   ~~~
  
8.  **Now you are ready to run the installer where you should use:**   
   <span class= "highlight-3">vg-boot</span> for <span class= "highlight-3">/boot</span>,  
   <span class= "highlight-3">cryptvg-root</span> for <span class= "highlight-2"> /</span>,  
   <span class= "highlight-3">cryptvg-home</span> for <span class= "highlight-3">/home</span>,  
   and <span class= "highlight-3">cryptvg-swap</span> for <span class= "highlight-3">swap</span> should be automagically recognised.  

The installed system should end up with a kernel command line including the following options:

~~~  
root=/dev/mapper/cryptvg-root cryptopts=source=/dev/mapper/vg-crypt,target=cryptroot,lvm=cryptvg-root  
~~~

You now have the crypt and boot under the vg lvm volume group and the root, home and swap inside the vgcrypt lvm volume group which is inside your password protected encrypted device.

<span class= "highlight-3">Note:</span> If reinstalling to a previously encrypted lvm volume the installer needs to be made aware of the crypt:

~~~  
cryptsetup luksOpen /dev/mapper/cryptvg-root cryptvg  
vgchange -a y  
~~~

<div class="divider" id="simple"></div>
## Notes for crypt with traditional partitioning methods

The first thing to decide is how you want to layout your disk. You will need a minimum of 2 partitions, one normal partition for your `/boot`  and one for the encypted data. 

Assuming you require swap (which should also be encrypted) you will need a third partition and will have to enter the password for swap seperately during bootup (so you will have two password prompts). 

It is possible to use keys for the swap from inside the encrypted system with traditional partitioning, however you will not be able to suspend to disk. Due to these issues, the better option in the long term is to use LVM volumes with fully encrypted partitions and keys.

<!--It is possible to use keys for the swap from inside the encrypted system with traditional partitioning, however you will not be able to suspend to disk. Due to these issues, LVM volumes with fully encrypted partitions with keys is definitely the better option in the long term.

-->
###### Essential assumptions:

+  There are just 3 plain partitions on this disk:  
   `/boot` , of 250mb  
   `swap` , of 2 gig  
   **`/`**  and `/home`  combined (for example, the balance).  
+ 2 passphrases will be required, 1 for swap the other for the **`/`**  and `/home`  combined.  

Now that you have the partitioning done, you need to prepare the encrypted partitions so that they will be recognised by the installer.

If you have been using a GUI partitioning application, close it and open a terminal, as the encryption commands need to be done from the command line.

##### The /boot partition

Make the `/boot`  partition an ext4 partition, if you have not already done so:

~~~  
/sbin/mkfs.ext4 /dev/sda1  
~~~

##### Encrypted swap partition

For the `encrypted swap`  you first need to format and open the raw device, `/dev/sda2` , as an encrypted device, like the vg-crypt device above but opening it under a different name, swap.


cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda2  
</li>  
~~~

~~~  
cryptsetup luksOpen /dev/sda2 swap  
</li>  
~~~

~~~  
echo "swap UUID=$(blkid -o value -s UUID /dev/sda2) none luks" >> /etc/crypttab  
</li>  
~~~

</ol>
Format the created `/dev/mapper/swap`  so it will be recognised by the installer:

~~~  
/sbin/mkswap /dev/mapper/swap  
~~~

##### Encrypted / partition

For the `encrypted /`  you first need to format and open the raw device, `/dev/sda3` , as an encrypted device, like the vg-crypt device above.

~~~  
cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda3  
~~~

~~~  
cryptsetup luksOpen /dev/sda3 cryptroot  
~~~

Format the created `/dev/mapper/cryptroot`  so it will show up in the installer:

~~~  
/sbin/mkfs.ext4 /dev/mapper/cryptroot  
~~~

### Open the installer

 **Now you are ready to run the installer where you should use:**   
<span class= "highlight-3">sda1</span> for <span class= "highlight-3">/boot</span>,  
<span class= "highlight-3">cryptroot</span> for <span class= "highlight-2"> /</span> and <span class= "highlight-3"> /home</span>  
<span class= "highlight-3">swap</span> should be automagically recognised.

The installed system should end up with a kernel command line including the following options (though your UUID will be used):

~~~  
root=/dev/mapper/cryptroot cryptopts=source=UUID=12345678-1234-1234-1234-1234567890AB,target=cryptroot  
~~~

You now have /boot in a plain partition, an encrypted password protected swap along with an encrypted root and /home.

### Sources and Resources:

Required reading:

~~~  
man cryptsetup  
~~~

 [LUKS](http://code.google.com/p/cryptsetup/) .

 [Redhat](http://www.redhat.com/)  and  [Fedora](http://www.redhat.com/Fedora/) .

 [Protect Your Stuff With Encrypted Linux Partitions](http://www.enterprisenetworkingplanet.com/netsecur/article.php/3683011) .

 [KVM how to use encrypted images](http://blog.bodhizazen.net/linux/kvm-how-to-use-encrypted-images/) .

 [siduction wiki](http://wiki.siduction.de/index.php?title=Installation_auf_einer_verschl%C3%Bcsselten_Festplatte) .

<div id="rev">Page last revised 08/01/2012 1800 UTC</div>
