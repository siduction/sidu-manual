% Boot Options (Cheatcodes)

## Boot options and cheat codes

**Info**

This manual page contains tables of

1. [siduction specific parameters (Live DVD only)](0204-cheatcodes_en.md#siduction-specific-parameters)
2. [boot options for the graphics server X](0204-cheatcodes_en.md#boot-options-for-the-graphics-server-x)
3. [general parameters of the Linux kernel](0204-cheatcodes_en.md#general-parameters-of-the-linux-kernel)
4. [values for the general parameter **vga**](0204-cheatcodes_en.md#vga-codes)

If the *"value"* field is non-empty, one of the possible values must be appended to the corresponding boot option with a `=` character. For example, if "1280x1024" is the desired value for the boot option `screen`, enter `screen=1280x1024` into the Grub command line. For language selection (here German), type `lang=de`. The Grub command line can be accessed by pressing the **`e`** key as soon as the Grub menu appears. After that, you are in edit mode. Now you can navigate to the kernel line with the arrow keys and insert the desired cheatcode(s) at the end. The space character serves as separator. The boot process can be continued with the key combination **`Ctrl`**+**`X`** or **`F10`**.

[Detailed reference list for kernel boot codes from kernel.org](http://files.kroah.com/lkn/lkn_pdf/ch09.pdf) 

### siduction specific parameters

These boot options apply only to the live DVD.

| boot option | value | description | 
| ---- | ---- | --------- |
| blacklist | module_name | temporary deactivation of modules before udev becomes active | 
| desktop | kde, gnome, fluxbox | select desktop environment | 
| fromiso | [Please read "booting 'fromiso'"](0302-hd-ins-fromiso_en.md#boot-from-iso-file). | 
| hostname | myhostname | changes the network name (hostname) of the live CD system | 
| lang | be, bg, cz, da, de, de_CH, el, en, en_AU, en_GB, en_IE, es, fr, fr_BE, ga, hr, hu, it, ja, nl, nl_BE, pl, pt (pt_BR), pt_PT, ro, ru, zh | sets the language preference, the basic localization settings (locales), the keyboard layout (in the console and in X), the timezone, and the Debian mirror. In the long form `lang=ll_cc` or `lang=ll-cc`, *"ll"* refers to the language selection and *"cc"* to the keyboard layout, mirror server, and time zone selection (e.g. `lang=fr-be` ). The default setting for English is en_US with UTC as the time zone and for German de with Europe/Berlin as the time zone. Example for a self-selected setting: `lang=pt_PT tz=Pacific/Auckland` | 
| md5sum | | tests the checksum of the CD/DVD (to check if CD/DVD is OK) | 
| noaptlang | | prevents the installation of localization packages of the selected language | 
| nocpufreq | | does not enable speedstep/powernow | 
| nodhcp | | no DHCP (DHCP automatically tries to establish Ethernet connections) | 
| noeject | | does not remove CD/DVD from drive | 
| nofstab | | prevents writing a new fstab | 
| nointro | | skips the output of `index.html` when starting the live DVD/CD | 
| nomodeset | radeon.modeset=0 | together with `xmodule=vesa` allows a clean boot to X for Radeon cards in live mode | 
| nonetwork | | prevents automatic configuration of network interfaces at boot time | 
| noswap | | no activation of the swap partition | 
| persist | [Please read "fromiso and persist"](0302-hd-ins-fromiso_en.md#boot-from-iso-file). | 
| smouse | | searches for serial mouse input devices using hwinfo | 
| tz | tz=Europe/Dublin | sets the time zone. If the bios or hardware clock is set to UTC, `utc=yes` is specified. A list of all supported time zones can be viewed by copying & pasting `file:///usr/share/zoneinfo/` into the browser. | 
| toram | copies the DVD/CD into RAM and boots from the RAM copy | 

### Boot options for the graphics server X

Either the `xandr` or `xmodule` boot option should also be used when applying boot options for the X graphics server for Radeon, Intel, or MGA graphics cards.

| boot option | value | description | 
| --- | ---- | ---------- |
| dpi | auto *or* DPI count | sets the desired pixels per inch for the monitor. The DPI is obtained by dividing the number of pixels of the monitor width by the diagonal (in inch) and multiplying the result by one of the following values: 1.25 for a 4:3 screen, 1.18 for a 16:10 screen, or 1.147 for a 16:9 screen. For a 24" screen with 1920x1080 resolution this results in 1.147x1920/24 dpi=92, or for a 15" screen with 1600x1200 resolution this results in 1.25x1600/15 dpi=133. | 
| hsync | 80 | sets the horizontal frequency of the monitor (in kilohertz) | 
| noml | | prevents the X.org configuration from containing a list of modelines, thus causing the correct mode to be detected automatically | 
| noxrandr | | prevents the new X.org drivers from using the extensions of RandR 1.2 and uses the old techniques to query monitor properties | 
| screen | 1280x1024 | sets custom resolution for X (1280x1024 or other screen resolutions) | 
| vsync | (e.g.) 60 | sets the vertical frequency of the monitor (in hertz) | 
| xdepth | values: 8 15 16 24 | set the color depth used by X.org (not all drivers support `1` and `4`) | 
| keytable | (e.g.) us, de, gb | keyboard layout used by X.org | 
| xkbmodel | (e.g.) pc105 | keyboard type used by X.org (the number indicates the number of keys) | 
| xkboptions | (e.g.) grp:alt_shift_toggle | assignment variant of the keyboard used by X.org | 
| xkbvariant | (e.g.) nodeadkeys | set a layout variant of the keyboard | 
| xmode | 800x600 | set the screen resolution according to the given value (`1024x768`, `1600x1200` etc.) | 
| xmodule or xdriver | ati, fbdev, i810, intel, mga, nouveau, radeon, savage, vesa | uses the selected X module | 
| xrandr | | forces X.org configuration using the new RandR 1.2 extensions of the X.org drivers | 
| xrate | XX | forces a preferred retry frequency for drivers supported by RandR 1.2. This option must be used in conjunction with the `xmode` boot option. Detailed documentation can be found [here](http://wiki.debian.org/XStrikeForce/HowToRandR12). | 
| xhrefresh | (e.g.) 75 | sets the horizontal frequency of the monitor for X (in kilohertz) | 
| xvrefresh | (e.g.) 60 | sets the vertical frequency of the monitor for X (in hertz) | 

### General parameters of the Linux kernel

| boot option | value | description | 
| --- | ---- | ---------- |
| apm | off | disables Advanced Power Managment | 
| 1, 3, 5 | (e.g.) 3 | boot targets or runlevels which can be entered manually in the Grub boot line. See also the manual page [Runlevel - target unit](0702-sys-admin-gen_en.md#systemd-target-formerly-runlevel). | 
| irqpoll | | uses IRQ polling | 
| mem | (e.g.) 128M, 1G | uses the specified memory size | 
| noagp | | no AGP support (Accelerated Graphics Port) | 
| noapic | | no APIC query (Advanced Programmable Interrupt Controller) | 
| nodma | | no support for DMA (Direct Memory Access) | 
| noisapnpbios | | does not perform an ISA "Plug and Play" query at startup | 
| nomce | | disables the kernel option "Machine Check Exception" | 
| nosmp | | does not use Symmetric Multi-Processor (multiple CPUs or CPUs with Hyper-Threading) | 
| pci | noacpi | no ACPI for PCI devices | 
| quiet | | no output on screen | 
| vga | normal | more about vga codes in the next paragraph | 
| video | (e.g.) DVI-0:800x600 | for graphics cards with KMS enabled; applies to Intel and ATI graphics cards (the latter with Radeon driver); DVI-X/LVDS-X refers to video output shown by **`xrandr`** | 

### VGA codes

The following tables list the values that can be specified with the general parameter `vga`.  
An example of use is `vga=791` (VESA code, resolution 1024x768 with 64000 colors).

Problems with netbooks or other screen resolutions can be solved by entering `vga=0` in the grub line.

**Decimal**

| colors | 640x480 | 800x600 | 1024x768 | 1280x1024 | 
| :----: | :----: | :----: | :----: | :----: |
| 256 | 257 | 259 | 261 | 263 | 
| 32k | 272 | 275 | 278 | 281 | 
| 64k | 273 | 276 | 279 | 282 | 
| 16M | 274 | 277 | 280 | 

**hexadecimal**

| colors | 640x480 | 800x600 | 1024x768 | 1280x1024 | 
| :----: | :----: | :----: | :----: | :----: |
| 256 | 0x101 | 0x103 | 0x105 | 0x107 | 
| 32k | 0x110 | 0x113 | 0x116 | 0x119 | 
| 64k | 0x111 | 0x114 | 0x117 | 0x11A | 
| 16M | 0x112 | 0x115 | 0x118 | 

**VESA**

| colors | 640x480 | 800x600 | 1024x768 | 1280x1024 | 1600x1200 | 
| :----: | :----: | :----: | :----: | :----: | :----: 
| 256 | 769 | 771 | 773 | 775 | 796 | 
| 32k | 784 | 787 | 790 | 793 | 797 | 
| 64k | 785 | 788 | 791 | 794 | 798 | 
| 16M | 786 | 789 | 792 | 795 | 

<div id="rev">Last edited: 2022/03/30</div>
