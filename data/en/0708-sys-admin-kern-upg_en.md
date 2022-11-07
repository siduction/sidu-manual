% Install new kernel

## Kernel Upgrade

siduction provides the following kernels:

+ **linux-image-siduction-amd64 + linux-headers-siduction-amd64** - Linux kernel for 64-bit PCs with AMD64 or Intel 64 CPU
+ 32 bit kernel are not provided anymore. Here you can use the Debian kernel or, alternatively, the Liquorix kernel (https://liquorix.net/).

The siduction kernels are located in the siduction repository as .deb and are automatically included in a system update, provided that the metapackages for image and headers are installed.


### Kernel Update without System Update

1. updating the package database:

  ~~~
  apt update
  ~~~

2. installation of the current kernel:

  ~~~
  apt install linux-image-siduction-amd64 linux-headers-siduction-amd64
  ~~~

3. reboot of the computer to load the new kernel

  If you encounter problems with the new kernel, you can choose an older kernel after rebooting.


### Modules

The kernel usually comes with all the required kernel modules. For 3rd party modules, dkms is recommended in siduction.
For this it is necessary to install the package `build-essential`. Since 3rd party modules are often non-free modules, it is necessary to make sure
that contrib and non-free are enabled in the sources.

### Removing old kernels

After successfully installing a new kernel, old kernels can be removed. However, it is recommended to keep old kernels for a few days. If problems occur with the new kernel, you can boot into one of the old kernels listed in the grub startup screen.

To remove old kernels the script `kernel-remover` is installed:

~~~
kernel-remover
~~~

<div id="rev">Last edited: 2022/04/05</div>
