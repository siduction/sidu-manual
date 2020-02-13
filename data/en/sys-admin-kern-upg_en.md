<div id="main-page"></div>
<div class="divider" id="kern-upgrade"></div>
## Installing new kernels

##### `The siduction kernels are in the siduction repo as a .deb and automatically included in a dist-upgrade.` 


---

The kernels are available in the following forms:

+  **siduction-686**  siduction-686 - kernel for the i686 Processor Family with single/dual core or more CPUs  
+  **siduction-amd64**  kernel for 64 bit siduction  

##### Steps to do it manually without dist-upgrading are:

 **1.**  In a konsole switch to root:

~~~  
apt-get update  
~~~

 **2.**  To install the latest version kernel:

~~~  
apt-get install linux-image-siduction-686 linux-headers-siduction-686  
~~~

Reboot to use the new kernel

`Should the new kernel give you problems, you can reboot and choose an older kernel.` 

##### Modules

To find which modules you need, the following command gives you the list of current available modules, copy this line to your console/terminal:

~~~  
apt-cache search 3.*-*.towo.*-siduction| awk '/modules/{print $1}'  
~~~

To get a full description of each module, copy this line to your console/terminal:

~~~  
apt-cache search 3.*-*.towo.*-siduction  
~~~

To install the required modules (for instance virtualbox-ose, and qc-usb):

~~~  
apt-get install virtualbox-ose-modules-3.1-4.towo.2-siduction-686 (EXAMPLE)  
apt-get install qc-usb-modules-3.1-4.towo.2-siduction-686 (EXAMPLE)  
~~~

To check the modules loaded into the kernel:

~~~  
ls /sys/module/  
or  
cat /proc/modules  
~~~

The name of the module-assistant compatible package then needs to be added to `/etc/default/dmakms` , so that the process of preparing and installing the same module(s) for each new Linux kernel can be automated.

#### Example: Installing `speakup module`  with module-assistant

Ensure that your sources list has `contrib non-free`  added in your sources line in: `/etc/apt/sources.list.d/debian.list`  

~~~  
apt-cache search speakup-s  
speakup-source - Source of the speakup kernel modules  
~~~

Then prepare the module:

~~~  
m-a prepare  
m-a a-i speakup-source  
~~~

#### Module load failure

Should the module fail to load, for whatever reason [new xorg component, a fs problem or if X doesnt start after reboot] :

~~~  
modprobe <module>  
~~~

Then reboot the computer.

Should the module still fail to load:

~~~  
m-a a-i -f module-source  
~~~

This rebuilds the module `then reboot.` 

<div class="divider" id="kern-remove"></div>
## Removing old kernels, kernel remover

After successful installation of the new kernel, the old kernels can be deleted, however its recommended that you keep them for a few days in case you strike problems and therefore boot to an older kernel as listed in the grub screen

Old kernels can be removed from the system. To do so, install `kernel-remover` :

~~~  
apt-get update  
apt-get install kernel-remover  
~~~

<div id="rev">Content last revised 15/01/2012 1400 UTC</div>
