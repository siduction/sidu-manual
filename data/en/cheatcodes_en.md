<div id="main-page"></div>
<div class="divider" id="cheatcodes"></div>
## Boot codes

 If the possible values are listed in the "Values" field of the table, they must be appended to the "cheatcode" with an **`=`**  sign. For example, if 1280x1024 was the desired value for the screen cheatcode, then you would type `screen=1280x1024`  into the grub boot prompt, or for language, `lang=pt` . The grub boot prompt can be edited by pressing `e`  as soon as grub shows on the screen. You are then in grub-editmode and can append the needed cheatcode(s) to the kernel-bootline (after `quiet` ). You can also combine 2 or more cheatcodes. To go on with the boot-process, please hit `Ctrl -X` .

 [Reference to an exhaustive list for kernel boot codes](http://files.kroah.com/lkn/lkn_pdf/ch09.pdf) 

<div class="divider" id="cheatcodes-siduction"></div>
## siduction specific boot codes (Live.iso only)

| Boot code | Value | Description | 
| ---- | ---- | ---- |
|  **blacklist**  | modulename | to temporarily disable modules before udev | 
|  **desktop**  | kde | Choose your desktop | 
|  | fluxbox |  | 
|  **fromiso**  |  |  [Please refer to booting "fromiso"](hd-install-opts-en.htm#fromiso)  | 
|  **hostname**  | myhostname | Hostname, changes hostname of live-cd system | 
|  **lang**  |  be, bg, cz, da, de, de_CH, el, en, en_AU, en_GB, en_IE, es, fr, fr_BE, ga, hr, hu, it, ja, nl, nl_BE, pl, pt (pt_BR), pt_PT, ro, ru, zh | Sets your language. It will also set locale, keyboard layout (console and X), timezone and a debian mirror. When the extended form `lang=ll_cc`  or `lang=ll-cc`  is given, `ll`  will be used for language selection and `cc`  for keyboard, mirror and timezone selection (e.g. `lang=fr-be` ). The defaults for English are en_US with UTC as the timezone and for German, de with Europe/Berlin as the timezone. Example: `lang=pt_PT tz=Pacific/Auckland`  | 
|  **md5sum**  |  | Test integrity of medium | 
|  **noaptlang**  |  | Disable installation of localisation packages based on the selected language | 
|  **nocpufreq**  |  | Do not activate Speedstep/Powernow | 
|  **nodhcp**  |  | Disable automatic use of Dynamic Host Configuration Protocol (attempts to automatically setup your ethernet connections). | 
|  **noeject**  |  | Do not prompt to eject the cd on shutdown | 
|  **nofstab**  |  | Do not write a new fstab | 
|  **nointro**  |  | Skips the display of index.html on live desktop startup | 
|  **nomodeset**  | radeon.modeset=0 | lets you, together with `xmodule=vesa` , boot cleanly into X with Radeon cards in Live-Mode | 
|  **nonetwork**  |  | Disables the automatic configuration of network devices at boot time | 
|  **noswap**  |  | Do not enable the swap partition | 
|  **persist**  |  |  [Please refer to "fromiso" and persist](hd-install-opts-en.htm#fromiso-persist)  | 
|  **smouse**  |  | Probe for serial mice with hwinfo | 
|  **toram**  |  | Copy CD to RAM and start from there | 
|  **tz**  | tz=Europe/Dublin | Sets your timezone. If your bios/hardware clock is set to UTC, use `utc=yes` . A list of all timezones supported can be found by copying and pasting into your browser: `file:///usr/share/zoneinfo/`  . | 


---

###### X related bootcodes

Either the xrandr or xmodule cheatcode should also be used if using other X related cheatcodes with a radeon, intel or mga graphics card.

| Boot code | Value | Description | 
| ---- | ---- | ---- |
|  **dpi**  | (e.g.) auto or XXX | Set desired Dots Per Inch for your display. You can work out your screen's dpi from the width in pixels divided by the diagonal size in inches and multiplying this by 1.25 for a 4:3 screen, 1.18 for a 16:10 screen or 1.147 for a 16:9 screen. For a 24" 1920x1080 screen it would be 1.147*1920/24 giving dpi=92 or a 15" 1600x1200 screen would be 1.25*1600/15 giving dpi=133. | 
|  **hsync**  |  (e.g.) 80 | Horizontal monitor refresh rate (kHz) | 
|  **noml**  |  | Prevents X.org configuration from containing a list of Modelines and causes audodetection of the correct Mode | 
|  **noxrandr**  |  | Disable use of RandR 1.2 extensions by new X.org drivers and use legacy monitor probing techniques | 
|  **screen**  | (e.g.) 800x600 | Sets your screen resolution, 1024x768, 1600x1200 etc | 
|  **vsync**  | (e.g.) 60 | Vertical monitor refresh rate (Hz) | 
|  **xdepth**  | values: 8, 15, 16, 24 | Default color depth to be used by X.org (not all drivers support 1 and 4) | 
|  **keytable**  | (e.g.) us, de, gb | Keyboard Layout to be used by X.org | 
|  **xkbmodel**  | (e.g.) pc105  | Keyboard model to be used by X.org | 
|  **xkboptions**  | (e.g.) grp:alt_shift_toggle | Keyboard variant to be used by X.org | 
|  **xkbvariant**  | (e.g.) nodeadkeys,  | to set a keyboard variant | 
|  **xmode**  | (e.g.) 800x600 | Sets your screen resolution, 1024x768, 1600x1200 etc | 
|  **xmodule**  or  **xdriver**  | (e.g.) ati, fbdev, i810, intel, mga, nv, radeon, savage, vesa | use given X-module | 
|  **xrandr**  |  | Force X.org to be configured to use RandR 1.2 extensions of new X.org drivers | 
|  **xrate**  | XX | Force preferred refresh rate of RandR 1.2 supported X.org drivers, must be used in conjunction with xmode cheatcode  [Comprehensive documentation is here](http://wiki.debian.org/XStrikeForce/HowToRandR12)  | 
|  **xhrefresh**  | (e.g.) 80  | Horizontal monitor refresh rate in X (kHz) | 
|  **xvrefresh**  |  (e.g.) 60 | Vertical monitor refresh rate in X (Hz) | 


---

<div class="divider" id="cheatcodes-linux"></div>
## Common Linux kernel parameter boot codes

| Boot code | Value | Description | 
| ---- | ---- | ---- |
|  **apm**  | off | Power-off | 
|  **1, 2, 3, 4, 5**  |  (e.g.) 3  |  **init runlevel**  numbers that can be manually placed on the Grub boot line  [See siduction runlevels - init](sys-admin-gen-en.htm#init)  | 
|  **irqpoll**  |  | Use IRQ poll | 
|  **mem**  | (e.g.) 128M, 1G | Ram size to be used | 
|  **noagp**  |  | Disable agp | 
|  **noapic**  |  | Disable apic (Advanced Programmable Interrupt Controller) | 
|  **nodma**  |  | Disable the use of Direct Memory Access for your drives | 
|  **noisapnpbios**  |  | Disable ISA Plug'n Play | 
|  **nomce**  |  | Disable Machine Check Exception | 
|  **nosmp**  |  | Disable Symetric Multi Processor support | 
|  **pci**  | noacpi | Do not use ACPI to route PCI interrupts | 
|  **quiet**  |  | Don't list everything to console | 
|  **vga**  | normal | Look here for vga codes:  [VGA boot codes](cheatcodes-vga-en.htm#vga)  | 
|  **video**  | (e.g.) DVI-0:800x600  or  800x600 | For KMS enabled cards. Applies to intel and ati cards (the radeon driver), where DVI-X/LVDS-X is the video output as shown by xrandr. | 

<div id="rev">Page last revised 28/01/2012 1800 UTC</div>
