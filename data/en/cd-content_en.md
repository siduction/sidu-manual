<div id="main-page"></div>
<div class="divider" id="cd-content"></div>
## Contents of the Live ISO

`siduction only provides Debian dfsg-free software on the live-ISO,  [please check this link for additional information on non-free sources for firmware](nf-firm-en.htm#non-free-firmware) .`

The ISO is completely based on Debian Sid, enriched and stabilised with packages and scripts from siduction. It comes with the latest enhanced siduction kernel, which is based on the most recent Vanilla Mainline Kernel with added patches. ACPI and DMA are enabled by default. 

`A complete manifest with all installed applications of each of the release variants is included on each download mirror:`  [siduction Mirrors, Downloading and Burning](cd-dl-burning-en.htm#download-siduction) .

<div class="divider" id="release-vari"></div>
## Release ISO variants

siduction offers 12 up-to-date live-ISO entry point release variants to Debian Sid and installing does usually take 1-10 minutes, depending on your hardware.

###### The variants are:

1.  **KDE 32 bit** , live-ISO approximately 1GByte:  
   contains a medium set of applications for the KDE4 desktop. Adding more applications to suit your long term requirements is easily done via apt.  
2.  **KDE 64 bit** , live-ISO approximately 1GByte:  
   contains a medium set of applications for the KDE4 desktop. Adding more applications to suit your long term requirements is easily done via apt.  
3.  **XFCE 32 bit** , live-ISO with ~ 720MByte:  
   contains a fully featured Desktop Environment (not minimal), and has all the applications you need to be productive immediately. It has a smaller footprint than KDE4.  
4.  **XFCE 64 bit** , live-ISO with ~ 720MByte: contains a fully featured Desktop Environment (not minimal), and has all the applications you need to be productive immediately. It has a smaller footprint than KDE4.  
5.  **LXDE 32 bit** , live-ISO with ~ 620MByte: contains a light Desktop Environment. It has an even smaller footprint than XFCE.  
6.  **LXDE 64 bit** , live-ISO with ~ 620MByte: contains a light Desktop Environment. It has an even smaller footprint than XFCE.  
7.  **Gnome3 32 bit**  live-ISO with ~ 1GByte:  
   Gnome-Desktop with Classic- and Flashback-Mode  
8.  **Gnome3 with 64 bit**  live-ISO with ~ 1GByte:  
   Gnome-Desktop with Classic- and Flashback-Mode  
9.  **RazorQt with 32 bit**  live-ISO with ~ 730MByte:  
   Qt-based lean desktop  
10.  **RazorQt with 64 bit**  live-ISO with ~ 730MByte:  
   Qt-based desktop  
11.  **NoX with 32 bit**  live-ISO with ~ 320MByte:  
   As the name suggests: no X  
12.  **NoX mit 64 bit**  live-ISO with ~ 320MByte:  
   As the name suggests: no X  

 [Applications and tools](cd-content-en.htm#apps-tools) 

<div class="divider" id="system-requirements"></div>
## Minimum System requirements for KDE4, Gnome3, XFCE RQT, LXDE, and NoX

### AMD64

+ ##### CPU requirements:
  
   <ul>  
   <li>AMD64  
+ Intel Core2  
+ Intel Atom 330  
+ any x86-64/ EM64T capable CPU or newer  
+ newer 64 bit capable AMD Sempron and Intel Pentium 4 CPUs (watch for the "lm" flag in /proc/cpuinfo or use inxi -v2).  

</li>
<li>
##### RAM requirements:

+  **KDE:** &ge;512 MByte RAM  
   <li> **Gnome:**  &ge;512 MByte RAM.  
+  **XFCE:**  &ge;256 MByte RAM.  
+  **LXDE:**  &ge;256 MByte RAM.  
+  **RQT:**  &ge;256 MByte RAM.  
+  **NoX:**  &ge;128MByte RAM.  

</li>
<li>VGA graphics card capable of at least 640x480 pixel resolution.</li>
<li>Optical disk drive or USB media.</li>
<li>&ge;3 GByte HDD space, &ge;10+ GByte recommended.</li>
</ul>
### i686

+ ##### CPU requirements:
  
   <ul>  
   <li>Intel Pentium pro/ Pentium II  
+ AMD K7 Athlon (not K5/ K6)  
+ Intel Atom N-270/ 230  
+ VIA C3-2 (Nehemiah, not C3 Samuel or Ezra)/ C7  
+ any x86-64/ EM64T capable CPU or newer  
+ the full i686 command set is required.  

</li>
<li>
##### RAM requirements:

+  **KDE:** &ge;512MByte RAM  
   <li> **Gnome:**  &ge;512MByte RAM.  
+  **XFCE:**  &ge;256MByte RAM.  
+  **LXDE:**  &ge;256MByte RAM.  
+  **RQT:**  &ge;256MByte RAM.  
+  **NoX:**  &ge;128MByte RAM.  

</li>
<li>VGA graphics card capable of at least 640x480 pixel resolution.</li>
<li>Optical disk drive or USB media.</li>
<li>&ge;4 GByte HDD space, &ge;10+ GByte recommended.</li>
</ul>
<div class="divider" id="apps-tools"></div>
## Applications and Tools

The siduction-ISO holds a variety of different programs and tools that cover almost any need of a desktop-user in everyday life.

Choice of 5 major cutting edge Desktop Managers to access programs/applications:  
 [KDE4 (en + de),](http://www.kde.org/)  a top of the range desktop manager  
 [Gnome3 (en + de),](http://www.gnome.org/)  a top of the range desktop manager  
 [Xfce4 (en + de),](http://www.xfce.org/)  a medium weight desktop manager.  
 [LXDE (en + de),](http://www.lxde.org/)  a lightweight GTK+-based desktop manager.

 [RazorQt (en),](http://wwwrazor-qt.org/)  a lightweight Qt-based desktop manager.</p>
For surfing the Internet, depending on the release variant, there is  [Konqueror](http://www.konqueror.org/)  and  [iceweasel](http://www.mozilla.com/)  or  [midori](http://www.twotoasts.de/index.php?/pages/midori_summary.html/) .

Office Productivity applications are Abiword and Gnumeric on the XFCE and LXDE variants, file managers are Dolphin and Thunar and PCmanFM.

To configure Networking and Internet connections there is  [Ceni](inet-ceni-en.htm#netcardconfig)  and for WIFI see our  [WIFI Roaming](inet-wpagui-en.htm) documentation.

Non-free driver information is  [here](nf-firm-en.htm#non-free-firmware) .

For partitioning a hard drive, we have provided  [cfdisk](part-cfdisk-en.htm#disknames)  and  [GParted](http://gparted.sourceforge.net/)  and gparted has an ntfs resize facility.

Diagnostic tools like  [Memtest86+](http://www.memtest.org/) , an Advanced Memory Diagnostic Tool, are provided.

`All ISO variations contain a full set of command line interface tools. A complete manifest of each of the release variants is included on each download mirror:`  [siduction Mirrors, Downloading and Burning](cd-dl-burning-en.htm#download-siduction) .

###### Disclaimer

This is experimental software. Use at your own risk. The siduction project, it's developers and team members cannot be held liable under any circumstances for damage to hardware or software, lost data, or other direct or indirect damage resulting from the use of this software. If you do not agree to these terms and conditions, you are not permitted to use or further distribute this software.

<div id="rev">Content last revised 26/11/2013 1800 UTC</div>
