% Graphics driver nVidea, Intel, ATA/AMD

# Hardware

## Graphics drivers

**for nVidia, Intel, ATI/AMD**

We only cover the most common graphics cards here in the manual. Exotic or relatively old graphics hardware, as well as server graphics are not discussed.  

### Open source Xorg driver

It is relatively easy to find out which graphics hardware is installed:

~~~sh
inxi -G
lspci | egrep -i "vga|3d|display"
~~~

This information is also very important if you have problems with the graphics and are looking for help in the forum or IRC.

**The graphics system under Linux consists of 4 basic parts:**

+ kernel driver 
    - radeon/amdgpu (ATI/AMD graphics)
    - i915 (Intel graphics)
    - nouveau (nVidia graphics)

+ Direct Rendering Manager  
    - libdrm-foo 

+ DDX driver 
    - xserver-xorg-video-radeon/amdgpu
    - xserver-xorg-video-intel
    - xserver-xorg-video-nouveau
    
  _Xorg can also use modesetting-ddx, which is now part of the Xserver itself. This is automatically used for Intel graphics and is also used if no special xserver-xorgvideo-foo package is installed._

+ dri/mesa 
    - libgl1-mesa-glx
    - libgl1-mesa-dri
    - libgl1-mesa-drivers
  _This part of Xorg is the free OpenGL interface for Xorg._

Open source Xorg drivers for nVidia (modesetting/nouveau), ATI/AMD (modesetting/radeon/amdgpu), Intel (modesetting/intel), and others are pre-installed with siduction.

Note: xorg.conf is usually no longer needed for open source drivers. Exceptions are e.g. multi-screen operation.

### Proprietary drivers

Proprietary drivers are actually only available for nVidia graphics cards. AMD also has a proprietary driver called amdgpu-pro, but this only officially supports Ubuntu in certain versions and is not packaged in Debian. Also, this driver is designed for professional cards rather than desktop cards.

Here you can get more information about the drivers of  
[Intel](http://www.x.org/wiki/IntelGraphicsDriver)  
[ATI/AMD](http://www.x.org/wiki/radeon)  
[nouveau](http://nouveau.freedesktop.org/wiki/FeatureMatrix)  
[X.Org](http://xorg.freedesktop.org/).

### Video driver 2D

Pretty much any video card that uses a [KMS](https://wiki.debian.org/KernelModesetting) driver kernel-side is suitable for 2D operation under all surfaces. In general (with a few exceptions of exotic or old hardware), 3D acceleration is also available.

### Video driver 3D

3D acceleration is available under Linux for Intel, AMD, and nVidia graphics cards. How well the free drivers have 3D implemented depends somewhat on the graphics card itself. In general, it should be noted that almost all graphics cards require non-free firmware to run smoothly. This firmware is only available in the non-free repository in Debian because it is not DFSG compliant. If the correct firmware is installed, 3D support is available with Intel or AMD graphics cards without any further action. With nVidia graphics the story is a bit different. Older cards, which are classified as legacy cards by nVidia, work relatively well, although problems are always to be expected since the desktop used also plays a role. The free nouveau driver is developed without support from nVidia via [reverse engineering](https://en.wikipedia.org/wiki/Reverse_Engineering).

Since the non-free firmware is usually required for correct operation (AMD, Intel from Skylake on, and Nvidia from Fermi on), an entry similar to

~~~sh
deb http://deb.debian.org/debian/ unstable main contrib non-free 
~~~

should be set. To prevent subsequent problems with WiFi, network, Bluetooth, or similar, a 

~~~sh
apt update && apt install firmware-linux-nonfree
~~~

makes sense. This will install more firmwares than you might need, but that should not be a disadvantage.

### nVidia closed source driver

**Selection, installation with dkms support and integration in Xorg**.

nVidia divides its graphics card drivers into 7 generations:

1. Riva TNT, TNT2, GeForce, and some GeForce 2000 GPUs.
2. GeForce 2000 to GeForce 4000 series GPUs
3. GeForce 5000 series GPUs
4. GeForce 6000 and 7000 series GPUs
5. GeForce 8000 and 9000 series GPUs
6. GeForce 400 and 500 series GPUs (Fermi GF1xx)
7. Geforce 600, 700, 800 (Kepler GK1xx GK2xx, Maxwell GM1xx GM2xx, );  
   Geforce 10xx (Pascal GP1xx), Geforce 16xx/20xx (Turing TU1xx); Geforce 30xx (Ampere GA1xx)

Cards of the generations 1 - 5 are no longer supported by nVidia, only old driver versions are available, which neither work with current kernels nor with current versions of the Xorg server. For a complete and up-to-date list of supported graphics chips, please consult the "Supported Products List" on the [NVIDIA Linux graphics driver download page](http://www.nvidia.com/object/unix.html).  

Debian provides the following versions of the binary drivers:

    - nvidia-legacy-304xx-driver (for 4.)
    - nvidia-legacy-340xx-driver (for 5.)
    - nvidia-legacy-390xx-driver (for 6.)
    - nvidia-driver (for 7.)

Since these are proprietary drivers, contrib and non-free must be activated in the sources (like for the firmware for free drivers). You have to make sure in advance that the kernel headers are installed to match the running kernel. This is the case once linux-image-siduction-amd64 and linux-headers-siduction-amd64 are installed. In addition, the packages *gcc*, *make* and *dkms* are necessary. With *dkms* additionally installed (nVidia) kernel modules are automatically updated during a kernel update. After you have found out which nVidia card or which nVidia chip you have, you can install the driver as follows:  

**GeForce 8000 and 9000 series**

~~~sh
apt update && apt install nvidia-legacy-340xx-driver  
~~~

**GeForce GF1xx Chipset, Fermi Cards**

~~~sh
apt update && apt install nvidia-legacy-390xx-driver
~~~

**Kepler, Maxwell, Pascal, and newer (GKxxx, GMxxx, GPxxx, TU1xx)**

~~~sh
apt update && apt install nvidia-driver
~~~

If this runs without errors, enter

~~~sh
mkdir -p /etc/X11/xorg.conf.d; echo -e 'Section "Device"\n\tIdentifier "My GPU"\n\tDriver "nvidia"\nEndSection' > /etc/X11/xorg.conf.d/20-nvidia.conf
~~~

to tell Xorg to use this installed driver. After a reboot the system should hopefully boot up to the desktop. If problems occur, i.e. the desktop does not start, you should consult **`/var/log/Xorg.0.log`**.

Since the legacy drivers 304.xx and 340.xx are no longer supported by nVidia, it is likely that they will not work with a new kernel or new Xorg.

Notebooks with hybrid graphics Intel/nVidia, so-called Optimus hardware, are problematic. In the past, [Bumblebee](https://wiki.debian.org/Bumblebee) was recommended, but this solution is anything but optimal. nVidia itself recommends configuring these setups with [PRIME](https://devtalk.nvidia.com/default/topic/957814/linux/prime-and-prime-synchronization/). Our recommendation is to avoid such hardware if possible. We cannot provide setup tips for Optimus hardware here.

<div id="rev">Last edited: 2022/02/16</div>
