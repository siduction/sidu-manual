<div id="main-page"></div>
<div class="divider" id="cheatcodes"></div>
## Cheatcode-uri

 Toate valorile posibile ce sunt listate în câmpul "Valoare" din tabel trebuiesc adăugate la "cheatcode" după semnul **`=`**  (egal).De examplu, dacă 1280x1024 este valoarea dorită pentru rezoluţia ecranului, atunci va trebui să tipăriţi `screen=1280x1024`  la linia de boot a lui grub sau pentru limbă `lang=pt` .

 [Lista completă a codurilor de boot-are a kernel-ului o găsiți aici](http://www.kernel.org/pub/linux/kernel/people/gregkh/lkn/lkn_pdf/ch09.pdf) 

<div class="divider" id="cheatcodes-siduction"></div>
## Cheatcode-uri specifice lui siduction (numai în Live-cd)

| Cheatcode | Valoare | Descriere | 
| ---- | ---- | ---- |
|  **blacklist**  | nume modul | pentru a dezactiva temporar unele module înainte de  *'udev'*  | 
|  **desktop**  | kde | alege managerul de ferestre | 
|  | fluxbox |  | 
|  **fromiso**  |  |  [Vă rugăm vedeţi pornirea  *'fromiso'*](hd-install-opts-ro.htm)  | 
|  **hostname**  | numele_computerului_meu | numele computerului.schimbă numele computerului de pe CD-ul live. | 
|  **lang**  |  be, bg, cz, da, de, de_CH, el, en, en_AU, en_GB, en_IE, es, fr, fr_BE, ga, hr, hu, it, ja, nl, nl_BE, pl, pt (pt_BR), pt_PT, ro, ru, zh | setează limba utilizată.setează de asemenea  *'locale'* , tipul de tastatură (keyboard layout) (consola și X), fusul orar (timezone) și o locație debian. Când este folostă forma extinsă `lang=ll_cc`  sau `lang=ll-cc`  , `ll`  va fi folosit pentru selectarea limbii și `cc`  pentru setarea tastaturii, locațiilor și a fusului orar (exemplu `lang=fr-be` ). Setarea de bază pentru Engleză este  **en_US**  cu  **UTC**  ca fus orar iar pentru Germană,  **de**  cu  **Europe/Berlin** ca fus orar.Exemplu: `lang=pt_PT tz=Pacific/Auckland`  | 
|  **md5sum**  |  | testează integritatea CD-ului | 
|  **noaptlang**  |  | dezactivează instalarea pachetelor de localizare bazându-se pe limba selectată | 
|  **nodhcp**  |  | dezactivează folosirea automată a  **D** ynamic  **H** ost  **C** onfiguration  **P** rotocol (dhcp) -încercarea de a realiza automat conexiunea la internet. | 
|  **noeject**  |  | nu mai afișează mesajul de eject-are a cd-ului la oprire sau reboot-are | 
|  **nofstab**  |  | nu mai scrie un nou fișier "fstab" | 
|  **nointro**  |  | dezactivează afişarea paginii index.html la pornirea Live CD-ului | 
|  **nocpufreq**  |  | dezactivează Speedstep/Powernow | 
|  **nonetwork**  |  | dezactivează configurarea automată a plăcii de rețea pe timpul boot-ării | 
|  **noswap**  |  | nu activează partiția swap | 
|  **persist**  |  |  [Vă rugăm să citiți la "fromiso și persist"](hd-install-opts-ro.htm#fromiso-persist)  | 
|  **smouse**  |  | verifică mouse-ul serial cu  *'hwinfo'*  | 
|  **toram**  |  | copie CD-ul în RAM şi porneşte de acolo | 
|  **tz**  |  *exemple:* tz=Europe/Dublin *sau* tz=Europe/Bucharest | setează fusul orar. Dacă ceasul din BIOS/hardware este setat pe  **UTC** , folosiți `utc=yes` . O listă cu toate fusele orare suportate o puteți găsi copiind și lipind în browser: `file:///usr/share/zoneinfo/`  . | 


---

###### Cheatcode-uri refritoare la mediul X

Ambele cheatcode-uri pentru  *'xrandr'*  sau  *'xmodule'*  pot fi folosite cu alte cheatcode-uri pentru plăci grafice radeon, intel sau mga.

| Cheatcode | Valoare | Descriere | 
| ---- | ---- | ---- |
|  **dpi**  | auto  *sau*  XX | setează valoarea dorită  *'Dots Per Inch'*  pentru monitorul dvs.Puteți determina valoarea  *'dpi'*  a monitorului vostru în pixeli împărțind lătimea în pixeli la diagonala în inch înmulțită cu 1.25 pentru monitoarele 4:3 , 1.18 pentru monitoarele 16:10 sau cu 1.147 pentru monitoarele 16:9. Pentru monitoare de 24" 1920x1080 poate fi 1.147*1920/24 rezultând dpi=92 sau la 15" 1600x1200 va fi 1.25*1600/15 rezultând dpi=133. | 
|  **hsync**  |  *exemplu:*   **80**   | rata de reîmprospătare orizontală a monitorului (kHz) | 
|  **noml**  |  | previne configurarea  *X.org*  de a conține  *Modelines*  și cauzează audodetecția corectă de  *Mode*  | 
|  **noxrandr**  |  | dezactivează folosirea extensiilor  *RandR 1.2*  cu un nou driver  *X.org*  și folosește tehnici de sondare ale monitorului moștenit | 
|  **screen**  | 800x600 | setează rezoluţia ecranului, 1024x768, 1600x1200 etc | 
|  **vsync**  | 60 | rata de împrospătare verticală (Hz) | 
|  **xdepth**  |  *valori:*  8 15 16 24 | profunzimea culorii în absență să fie folosită de  *X.org*  (nu toate driver-ale suportă  **1**  și  **4** ) | 
|  **keytable**  |  *exemple:*  us, de, gb | așezarea tastaturii ce va fi folosită de  *X.org*  | 
|  **xkbmodel**  |  *exemplu:*  pc105  | modelul de tastatură ce va fi folosit de  *X.org*  | 
|  **xkboptions**  |  *exemplu:*  grp:alt_shift_toggle | varianta de tastatură ce va fi folosită de  *X.org*  | 
|  **xkbvariant**  |  *exemplu:*  nodeadkeys  | pentru a seta o variantă de tastatură | 
|  **xmode**  |  *exemplu:*  800x600 | fixează rezoluția ecranului la 1024x768, 1600x1200 etc | 
|  **xmodule**   *sau*  **xdriver**  | ati, fbdev, i810, intel, mga, nv, radeon, savage, vesa | folosiți modulul X oferit | 
|  **xrandr**  |  | configurează  *X.org*  ca să folosească  *RandR 1.2*  la extensiile noilor driver-e  *X.org*   | 
|  **xrate**  | XX | rata de împrospătare forțată preferabilă la  *RandR 1.2*  suportată de driver-e  *X.org* ,trebuie folosită în legatură cu  *'xmode cheatcode'*  [Documentație detaliată se afla aici (EN)](http://wiki.debian.org/XStrikeForce/HowToRandR12)  | 
|  **xhrefresh**  | 80 | rata de împrospătare orizontală (kHz) | 
|  **xvrefresh**  | 60 | rata de împrospătare verticală  | 


---

<div class="divider" id="cheatcodes-linux"></div>
## Parametri normali de cheatcode-uri pentru kernel-ul Linux

| Cheatcode | Valoare | Descriere | 
| ---- | ---- | ---- |
|  **apm**  | off | Power-off | 
|  **1, 2, 3, 4, 5**  |   *exemplu:*  3  |  **init runlevel**  numere ce pot fi plasate manual în linia de boot a lui Grub  [Vedeți nivelele de rulare în siduction (runlevels) - 'init'](sys-admin-gen-ro.htm#init)  | 
|  **console**  | For example: console=ttyS0,9600n8 | If you enable a serial console with console=ttyS*,* the /etc/inittab file will be automatically updated to allow you to login on this serial port. | 
|  **irqpoll**  |  | foloseşte  *IRQ poll*  | 
|  **mem**  | 128MB (zB) | cantitatea de RAM care să fie folosită | 
|  **noagp**  |  | dezactivează portul  *agp*  | 
|  **noapic**  |  | dezactivează  *apic*  ( **A** dvanced  **P** rogrammable  **I** nterrupt  **C** ontroller) | 
|  **nodma**  |  | dezactivează  *dma*  ( **D** irect  **M** emory  **A** ccess) pentru unitaţile de disc | 
|  **noisapnpbios**  |  | dezactivează  *ISA Plug'n Play*  | 
|  **nomce**  |  | dezactivează exceptia de verificare a mașinii | 
|  **nosmp**  |  | dezactivează suportul  *smp* i> ( **S** ymetric  **M** ulti  **P** rocessor) | 
|  **pci**  | noacpi | nu folosește  *ACPI*  pentru gestionarea întreruperilor  *PCI*   | 
|  **quiet**  |  | nu listează totul pe consolă | 
|  **vga**  | normal | Aici găseşti coduri VGA:  [VGA Cheatcodes](cheatcodes-vga-ro.htm)  | 
|  **video**  |  *exemple:*  DVI-0:800x600  *sau* 800x600 | pentru plăcile video active tip 'KMS'.Aplicabil plăcilor 'intel' și 'ati' (driver-ul 'radeon'), unde DVI-X/LVDS-X este video output-ul așa cum este cunoscut de către  *'xrandr'* . | 

<div id="rev">Content last revised 30/11/2012 1115 UTC</div>
