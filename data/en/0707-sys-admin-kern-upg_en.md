BEGINNING   INFO AREA FOR THE AUTHORS
This area is to be removed when the status RC3 is reached. The first line of the file must contain the title (% my-title) !!!  
**Status: RC2**

Necessary work:

+ check spelling  

Work done

+ check intern links (there was'nt any)  
+ check extern links  
+ check layout  

END   INFO AREA FOR THE AUTHORS  
% Install new kernel

## Kernel Upgrade

Siduction provides the following kernels:

+ **linux-image-siduction-amd64 + linux-headers-siduction-amd64** - Linux kernel for 64-bit PCs with AMD64 or Intel 64 CPU.
+ 32 bit kernel we do not provide anymore, here you can use the Debian kernel, or alternatively the Liquorix kernel (https://liquorix.net/).

The kernels from siduction are in the siduction repository as .deb and are automatically included in a system update, provided that the metapackages for image and headers are installed.


### Kernel Update without System Update

1. updating the package database:

  ~~~
  apt update
  ~~~

2. installation of the current kernel:

  ~~~
  apt install linux-image-siduction-amd64 linux-headers-siduction-amd64
  ~~~

3. reboot the computer to load the new kernel.

  If you encounter problems with the new kernel, you can choose an older kernel after rebooting.


### Modules

The kernel usually comes with all the required kernel modules. For 3rd party modules, dkms is recommended in siduction.
For this it is necessary to install the package **build-essential**. Since 3rd party modules are often non-free modules, it is necessary to make sure
that contrib and non-free are enabled in the sources.

### Removing old kernels

After successfully installing a new kernel, old kernels can be removed. However, it is recommended to keep old kernels for a few days. If problems occur with the new kernel, you can boot into one of the old kernels listed in the grub startup screen.

To remove old kernels the script "kernel-remover" is installed:

~~~
kernel-remover
~~~

<div id="rev">page last updated 2021-22-08</div>
