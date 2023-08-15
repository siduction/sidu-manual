%release notes

## release notes 2023.1.0

**"Standing on the Shoulders of Giants"**

The siduction team is very proud to present an unscheduled release for a special occasion. Debian GNU/Linux, whose unstable branch some of us have been following for over 20 years, celebrates its thirtieth birthday on 8/16/2023 and we think that is worthy of all honor.

Debian is the second oldest distribution after Slackware, and is solely supported by the people involved, without a company standing in the background or someone at the top deciding where things go. Debian is considered the "universal operating system" because of the many architectures supported to this day, and the stability of their releases is legendary.

### Changing history

The story began on August 16, 1993, when Ian Murdock introduced his self-designed system "Debian Linux Release". The [Debian Manifesto](https://www.debian.org/doc/manuals/project-history/manifesto.de.html) followed that same year. The first stable version, 1.1, was released in 1996, then compiled by under 100 developers. The release was codenamed "Buzz", a first reference to the characters from the movie franchise Toy Story, from which the codenames are still borrowed today.


So far, another 16 releases have been added, the current of which is codenamed "Bookworm" and was released on June 10, 2023. The motto is still: It will be released when it is ready.


In 1997 already about 400 developers agreed on the Debian social contract as an important document, which has been edited only twice since its existence and which states under clause 1: **Debian will remain 100% free**. At the same time, the "Debian Free Software Guidelines" (DFSG) were adopted as part of this contract.

### Self-managed

Debian administers itself in the form of a do-ocracy. Today, the approximately 1,000 developers determine their tasks independently and responsibly. That this is not always easy among a thousand creative people should be clear to everyone. This is reminded, among other things, of upheavals such as the introduction of systemd, which brought Debian to its breaking point. The inclusion of non-free firmware on the distribution's installation media was also hotly debated in 2022. The discussions about this dragged on for years.

To the outside world, Debian often appears to be at odds with one another, as upcoming decisions are often the subject of heated debate. In the end, however, the project seems to emerge stronger from such phases. This reliability may also be a reason why more derivatives are based on Debian than on any other distribution. Currently [122 active distributions](https://distrowatch.com/search.php?ostype=All&category=All&origin=All&basedon=Debian&notbasedon=None&desktop=All&architecture=All&package=All&rolling=All&isosize=All&netinstall=All&language=All&defaultinit=All&status=Active#simple) use Debian as a base. Among them are such pioneering distributions as Knoppix or Ubuntu. If you add distributions that are no longer active, the number rises to 414. Impressive!

**It all started with Knoppix**

Our own timeline starts with Knoppix and went from Kanotix to sidux and aptosid to siduction, which we have been shipping for 12 years now. Debian has never failed us, but the decision making process has sometimes been a bit too slow. For example, we introduced systemd before Debian, and we have been shipping firmware as an option for some time to support current hardware on the installation media.

But otherwise siduction is probably 98% Debian Unstable. We thank you for that and wish the Proj́ekt at least 30 more years. Standing on the Shoulders of Giants.

### What can you expect from siduction 2023.1.0

**User and password for the live session are siducer/live**.

First of all, a new wallpaper by artist [Angevere](https://www.artstation.com/angevere) (Ona Kristensen) awaits you, which we may use with kind permission.

### The Flavours

The flavours we offer for siduction 2023.1.0 are KDE Plasma 5.27.7.1, LXQt 1.3.0, Xfce 4.18, Xorg and noX. GNOME, MATE and Cinnamon did not make it again this time because there is no maintainer within siduction for them. If you are interested, please get in touch. They may or may not come back at some point. Of course they are still installable from the repository.

The released images of siduction 2023.1.0 are a snapshot of Debian Unstable, also named Sid, from Aug. 14, 2023, enriched with some useful packages and scripts, a Calamares-based installer and a customized version of the Linux kernel 6.4-10, while systemd is at 254.1-2.

### Non-free and Contrib

The following non-free and contrib packages are installed by default:

**Nonfree:**

- amd64-microcode - Processor microcode firmware for AMD CPUs  
- firmware-amd-graphics - Binary firmware for AMD/ATI graphics chips  
- firmware-atheros - Binary firmware for Atheros wireless cards  
- firmware-bnx2 - Binary firmware for Broadcom NetXtremeII  
- firmware-bnx2x - Binary firmware for Broadcom NetXtreme II 10Gb  
- firmware-brcm80211 - Binary firmware for Broadcom 802.11 wireless card  
- firmware-crystalhd - Crystal HD Video Decoder (firmware)  
- firmware-intelwimax - Binary firmware for Intel WiMAX Connection  
- firmware-iwlwifi - Binary firmware for Intel Wireless cards  
- firmware-libertas - Binary firmware for Marvell Libertas 8xxx wireless car  
- firmware-linux-nonfree - Binary firmware for various drivers in the Linux kernel  
- firmware-misc-nonfree - Binary firmware for various drivers in the Linux kernel  
- firmware-myricom - Binary firmware for Myri-10G Ethernet adapters  
- firmware-netxen - Binary firmware for QLogic Intelligent Ethernet (3000)  
- firmware-qlogic - Binary firmware for QLogic HBAs  
- firmware-realtek - Binary firmware for Realtek wired/wifi/BT adapters  
- firmware-ti-connectivity - Binary firmware for TI Connectivity wireless network  
- firmware-zd1211 - binary firmware for the zd1211rw wireless driver  
- intel-microcode - Processor microcode firmware for Intel CPUs  

**Contrib:**

- b43-fwcutter - utility for extracting Broadcom 43xx firmware  
- firmware-b43-installer - firmware installer for the b43 driver  
- firmware-b43legacy-installer - firmware installer for the b43legacy driver  
- iucode-tool - Intel processor microcode  

**Remove Non-Free Content**

Currently, the installer does not offer the possibility to deselect packages that do not comply with the DFSG, the Debian Free Software Guidelines. This means that packages such as non-free firmware are installed on the system by default. The vrms command will list these packages for you. You can manually uninstall unwanted packages or remove them all by typing apt purge $(vrms -s) before or after installation. Otherwise, our remove-nonfree script can do this for you later.

### Installation notes and known issues

If you want to reuse an existing home partition (or any other data partition), you should do this after installation and not in the Calamares installer. While it will work, it is more robust to add it afterwards.  
With some Intel graphics processors on some devices, the system may freeze shortly after booting into Live. To fix this, you must set the kernel parameter `intel_iommu=igfx_off` before rebooting.

## Credits

### Credits for siduction 2023.1.0

**Core Team:**

Torsten Wohlfarth (towo)  
Hendrik Lehmbruch (hendrikL)  
Ferdinand Thommes (devil)  
Vincent Vietzke (vinzv)  
Axel Konrad (akli)

**Past contributors:**

Alf Gaida (agaida) (eaten by the cat)  
Axel Beu 2021†

**Code, ideas and support:**

Markus Meyer (coruja)  
der_bud  
se7en  
davydych  
tuxnix

**Artwork:**

The artwork is by [Angevere](https://www.artstation.com/angevere) (Ona Kristensen). We use it with kind permission.

### Many thanks to all involved

We would like to thank you, all the testers and all the people who have supported us over the years. This release is also thanks to you. We would also like to thank the birthday boy Debian, as this means we stand on the shoulders of giants.  
And now have fun!

On behalf of the siduction team:

Ferdinand Thommes

<div id="rev">Last edited: 2023/08/15</div>
