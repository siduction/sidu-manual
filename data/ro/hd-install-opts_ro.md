<div id="main-page"></div>
<div class="divider" id="fromiso"></div>
## Pornirea "fromiso" - Sumar

**`Pentru utilizarea zilnică recomandăm tipul de fișiere ext4. Este sistemul de fişiere implicit în siduction şi este foarte bine întreţinut.`**

Cu acest cod puteţi porni sistemul de pe o imagine ISO care se află pe Hard-Disk (tip ext2/3/4) ceea ce este mult mai rapid decât pornirea de pe CD (instalarea pe Hard-Disk "fromiso" durează foarte puţin).

`fromiso` înseamnă mult mai rapid decât de pe CD/DVD şi lasă şi unitatea optică disponibilă. Ca o alternativă se poate folosi deasemeni și VMware.

###### Cerinţe :

* un grub funcţional (de pe o dischetă, un sistem instalat pe Hard-Disk sau de pe Live-CD)  
* o imagine ISO de siduction - ex.: siduction.iso - şi o partiţie linux de tipul ext2/3/4  


<div class="divider" id="grub2-fromiso"></div>
## fromiso cu Grub2

siduction are un fișier grub2 numit  *60_fll-fromiso*  pentru a genera o intrare 'fromiso' în meniul grub2. Singurul fișier pentru a configura 'fromiso' se numește `grub2-fll-fromiso`  și se găsește în `/etc/default/grub2-fll-fromiso.` .

Mai întâi deschideți un terminal și logați-vă ca administrator (root) cu:

~~~  
sux  
apt-get update  
apt-get install grub2-fll-fromiso  
~~~

Apoi deschideți un editor de texte care poate fi kwrite, mcedit, vim sau altul preferat de voi:

~~~  
mcedit /etc/default/grub2-fll-fromiso  
~~~

Apoi de-comentați (ștergeți semnul**`#`** de la început) liniile de care aveți nevoie să fie operative și înlocuiți instrucțiunile de bază scrise între ghilimele `"quote marks"`  cu preferințele voastre.

De examplu, comparați acest fișier 'grub2-fll-fromiso' modificat cu cel care este de bază, (liniile `colorate`  sunt cele modificate în scopul exemplificării):

~~~  
# Defaults for grub2-fll-fromiso update-grub helper  
# sourced by grub2's update-grub  
# installed at /etc/default/grub2-fll-fromiso by the maintainer scripts  
#  
# This is a POSIX shell fragment  
#  
# specify where to look for the ISO  
# default: /srv/ISO `### Notă: Aceasta este calea către directorul care conține imaginea ISO, nu este pentru a include actualul fișier siduction-*.iso.###`   
FLL_GRUB2_ISO_LOCATION="/media/disk1part4/siduction-iso"`   
# array for defining ISO prefices --> siduction-*.iso  
# default: "siduction- fullstory-"  
FLL_GRUB2_ISO_PREFIX="siduction-"`   
# set default language  
# default: en_US  
FLL_GRUB2_LANG="en_AU"`   
# override the default timezone.  
# default: UTC  
FLL_GRUB2_TZ="Australia/Melbourne"`   
# kernel framebuffer resolution, see  
# http://manual.siduction.org/de/cheatcodes-vga-de.htm#vga  
# default: 791  
#FLL_GRUB2_VGA="791"  
# additional cheatcodes  
# default: noeject  
FLL_GRUB2_CHEATCODE="noeject nointro"`   
~~~

Salvați și închideți editorul, apoi executați în terminal:

~~~  
update-grub  
~~~

Fișierul  *grub.cfg*  al lui grub2 va fi actualizat cu intrări pentru diferitele imagini ISO ce le aveți stocate în directorul specificat și vor fi disponibile la următoarea pornire a PC-ului.

<div class="divider" id="fromiso-persist"></div>
## Informaţii generale despre persist

<!--</div>
<div class="divider" id="persist-firm-1">--></div>
### Firmware

`Aceasta se aplică tuturor instalărilor persist, exceptând instalările RAW device.`  Pentru instalările RAW device vedeţi  [Scrierea siduction pe un USB/SSD stick cu orice sistem Linux, MS Windows sau Mac OS X.](hd-ins-opts-oos-ro.htm#raw-usb) 

Pentru firmware, puneţi simplu datele de adăugat pentru modul live `/lib/firmware`  în un director numit `/siduction/firmware`  pe stick-ul dumneavoastră. Firmware-ul poate fi activat la pornire selectând `Da`  din meniul grafic.`Driver`  sau adaugând manual `firmware`  în linia de comandă a kernel-ului. `firmware=/lib/firmware`  va incărca firmware-ul instalat. Dacă doriţi sa îl activaţi implicit puteţi să editaţi fişierul de configurare de boot, ca de exemplu fişierul `/boot/isolinux/syslinux.cfg` .

Persist şi firmware pot folosi fişiere din locaţii diferite ale disk-ului, ca de exemplu dacă fişierele de persistenţă se află in directorul rădacina al stick-ului şi sunt numite, `persist.img`  atunci puteţi folosi `persist=/persist.img`  şi atunci când firmware-ul este conţinut intr-un fişier numit fw puteţi folosi `firmware=/fw` .

### fromiso şi persist pe un HD

Puteţi avea un sistem live persistent pe un disk cu acces citire/scriere combinînd parametrii de boot fromiso cu persist. 

 Pentru a folosi persist este neesar un fişier mare şi parametrul de boot va arăta ca:

~~~  
persist=/siduction/siduction-rw  
~~~

siduction foloseste dmsetup pentru a activa aşa numita "copiere la scriere" peste ISO-ul tău, aceasta permiţîndu-ţi să scrieţi noile fişiere şi foldere precum şi să le actualizeze pe cele existente, păstrînd noile fişiere în memorie. Parametrul de boot `persist`  va stoca noile dvs. fişiere pe aceeaşi partiţie pe hard disk partition pe care se află imaginea ISO.

`fromiso`  vă oferă un sistem live care are toate toate caractersiticile ISO-ului siduction. Aceasta permite lucruri precum configurarea automată hardware dar înseamnă că la repornire va recrea automat aceleaşi fişiere dacă nu veţi folosi alţi parametrii de boot.

Folosind `persist`  împreuna cu alti parametrii de boot specifici siduction ca noxorgconf, nonetwork, înseamnă că nu vor fi create aceleaşi fişiere de fiecare dată când bootaţi. Vezi  [Parametrii de boot](http://manual.siduction.org/en/cheatcodes-en.htm#cheatcodes) 

Exceptând actualizarea kernelului cu sistemul fromiso, folosind persist înseamnă că puteţi instala pachete cu apt şi veţi avea la următoarea repornire toate aplicaţiile instalate şi toate datele salvate de dumneavoastră. Unele pachete necesită ca sources.list să includă contrib and non-free, vezi  [Adăugarea non-free în Sources List](nf-firm-en.htm#non-free-firmware)  

<div class="divider" id="persist-post"></div>
## fromiso și persist pe un mediu boot-abil - USB-sticks/SD/flash-cards

Probabil utilizarea ideală a modului persistent este în combinație cu instrumentul 'install-usb-gui' pentru crearea propriul mediu boot-abil cu fișierele și programele necesare. Fișierele voastre vor fi stocate într-un subfolder pe disc.

`persist`  pe un sistem de fișiere FAT, utilizat de regulă de dos/Windows 9x și găsit de obicei pe dispozitivele flash, cere crearea unui singur fișier mare pentru a fi folosit și care trebuie formatat.

`Pe USB-sticks/SD/flash-cards, ext2 și vfat sunt formatele recomandate ca sisteme de fișiere mai ales pentru a avea o compatibilitate bună 'cross platform' utilă mai ales la salvarea datelor, existând drivere disponibile și sub MS Windows(tm); pentru schimburi de date. Citirea/scrierea pe flash drives este posibil în acord cu specificațiile stick-ului USB.` 

###### Sistemul de fișiere ext2

Cu ext2 întreaga partiție va fi folosită ca 'root' și un director /fll este creat pentru a fi folosit de 'persist' permițând utilizarea întregului spațiu liber pentru sistemul 'persist'.

###### Sistemul de fișiere vfat

Când este utilizat 'vfat', persistența este realizată într-un fișier care poate fi de maxim 2GB dar nu mai mic de 100MB (altfe nu poate fi folosit). Fisierul trebuie să se numească `siduction-rw` .

#### Examplu de creare 'persist' după o instalare initială

Dacă nu sunteți siguri care este punctul de mount-are, cuplați stick-ul și rulați `ls -lh /media`  pentru a obține o listă a tuturor punctelor de mount-are din sistem. Ar trebui să arate cam așa `drwxr-xr-x 6 username root 4.0K Jan 1 1970 disk` . Dacă rezultatul vostru diferă atunci înlocuiți `"/media/disk"`  conform cu nevoile voastre, (de examplu "/media/disk-1").

~~~  
disk="/media/disk"  
-->  
~~~

Continuând examplul, comanda `df -h`  va clarifica informația,:

~~~  
/dev/sdc2 3.4G 4.0K 3.4G 1% /media/disk  
/dev/sdc1 4.1G 1.1G 2.8G 28% /media/disk-1  
~~~

Deci:

~~~  
disk="/media/disk-1"  
~~~

Stabiliți mărimea partiției 'persist':

~~~  
size=1024  
~~~

Faceți un director pe stick:

~~~  
mkdir $disk/siduction  
~~~

Rulați programul de creare a partiției 'persist':

~~~  
dd if=/dev/zero of=$disk-1/siduction/siduction-rw bs=1M count=$size && echo 'y' | LANG=C /sbin/mkfs.ext2 $disk-1/siduction/siduction-rw && tune2fs -c 0 "$disk-1/siduction/siduction-rw"  
~~~

**`partițiile NTFS, utilizate de regulă pentru Windows NT/2000/XP (TM), NU POT fi utilizate pentru persistență.`**

<div class="divider" id="usb-hd"></div>
## Instalarea siduction pe dispozitive USB/SD/flash

Intalarea siduction pe un USB-stick/SD/flash-card este la fel de ușoară ca și cea pe un HD normal. Trebuie doar să urmați instrucțiunile.

##### Cerințe:

Orice PC care are protocolul USB 2.0 și suportă boot-area de pe USB/SD/flash.

O imagine siduction.iso.

##### Moduri de instalare pe USB/SD/flash

+ 1)  [fromiso](hd-install-opts-ro.htm#usb-from1) ; specifică lui siduction: siduction-on-a-stick  
+ 2)  [full](hd-install-opts-ro.htm#usb-hdd)  (instalarea completă pe un USB/SD/flash se realizează ca o instalare normală pe HD folosind programul de instalare normal).  
+ 3)  [RAW device](hd-ins-opts-oos-ro.htm#raw-usb)  write. Acesta este ideal de folosit cu orice sistem de operare Linux, MS Windows sau Mac OS X și doriți să realizați o instalare 'siduction-on-a-stick', (cu 'caveats').  

<div class="divider" id="usb-from1"></div>
### Instalarea pe USB/SD/flash cu 'fromiso', siduction-on-a-stick

 `Pre-formatați dispozitivul usb în ext2 sau fat32 înainte de a proceda la instalare (cel puțin o capacitate de 2G). Dispozitivul trebuie să aibă doar 1 singură partiție și pentru că unele BIOS-uri sunt temperamentale, aceasta trebuie să fie marcată ca fiind boot-abilă.` 

Dacă folosiți o aplicație grafică (GUI) pentru fomatare cum ar fi 'gparted', vă rog să ștergeți mai întâi orice partiție existentă și apoi s-o recreați înainte de a formata stick-ul.

##### USB fromiso de pe un sistem siduction instalat pe HD:

Instalarea `fromiso USB`  se face prin `Menu>System>install-siduction-to-usb` . 

##### USB fromiso de pe un siduction-*.iso:

Pe un LIVE-CD puteți da click pe `icon-ul siduction Installer`  și alegeți `Install to USB` .

###### Opțiuni:

Vi se oferă oportunitatea de a seta limba, fusul orar și alte opțiuni de bootcode-uri precum și activarea sau nu a opțiunii persist via checkbox.

Aveți acum un USB/SD/flash bootabil. Dacă nu ați activat 'persist' îl puteți activa adăugând `persist`  în linia de boot-are a lui grub din ecranul grub. (Dacă este 'vfat', este probabil cel mai bine s-o luați de la început).

###### Terminal example:

~~~  
fll-iso2usb -D /dev/sdX --iso /home/siduction/siduction.iso -p -- lang=fr_CA tz=America/Vancouver  
~~~

This installs the iso image to the prepared USB device `sdX`  with persist, French Canadian language localisation and America/Vancouver (CAN) time on the grub default line.

Configurările de X (placa video, tastatură, mouse) sau fișierele pentru interfețele de rețea nu au fost stocate, ceea ce-l face ideal de utilizat pe alte computere.

Pentru mai multă documentație inclusiv opțiuni de personalizare vedeți și:

~~~  
$ man fll-iso2usb  
~~~

### Instalarea completă pe un USB/SD/flash (la fel ca o instalare pe un HD normal)

Capacitatea minimă recomandată a USB-stick/SD/flash-card este:  
siduction "LITE" are nevoie de 2.5 gig PLUS spațiu pentru datele voastre,  
siduction "FULL" are nevoie de 4 gig PLUS spațiu pentru datele voastre

 `Pre formatați dispozitivul cu`  **`ext2`** `și partiționați USB-stick/SD/flash-card ca și pentru un PC standard.` 

Porniți instalarea de pe Live-ISO și alegeți partiția de pe dispozitivul USB/SD/flash, unde se va instala siduction, de examplu `sdbX` apoi urmați indicațiile programului de instalare. Citiți și  [Instalarea pe HD](hd-install-ro.htm#Installation) 

`Pentru a boot-a de pe USB/SD/flash 'Boot from USB' trebuie să fie activată în BIOS.` 

`Alte sfaturi importante sunt:` 

+ O instalare pe USB-stick/SD/flash-card, va fi de regulă limitată la configurația PC-ului cu care s-a făcut instalarea originală. Daca aveti intentia de a utiliza stick-ul USB/SD/flash pe alte PC-uri, ar trebui să nu aveți pre-configurate drivere grafice non-free și cheatcode-uri, cu exceptia cănd aveți probabil cheatcode-uri 'vesa' în fișierul grub.cfg, (tot ce trebuie avut grijă după o instalare corectă).  
+ După boot-area de pe USB-stick/SD/flash-card a unui alt PC, va trebui să modificați fișierul 'fstab' pentru a avea acces la HD-urile PC-ului.  
+ "fromiso" cu "persist" este probabil o variantă mai bună pentru asemenea intenții.  

<div class="divider" id="usb-hdd"></div>
### Instalarea completă pe un dispozitiv USB Hard Disk ca și instalarea pe o partiție

Folosirea unui Hard-Disk extern pe USB este una dintre opțiunile bune, (în particular pentru utilizatorii nou veniți de pe MS sau alte distribuții), pe care puteți instala siduction, îl cuplați la PC și nu mai aveți nevoie de configurarea PC-ului pentru dual boot (repartiționare, modificarea lui grub etc).

Porniți instalarea de pe Live-ISO, (sau de pe un USB-stick/SD/flash-card), `ca o instalare standard, nu un 'USB install'`  și alegeți partiția de pe dispozitivul USB, unde se va instala siduction, de examplu `sdbX` și urmați pașii ceruți de programul de instalare siduction. Grub trebuie scris pe partiția de pe USB HDD.

Citiți și  [Instalarea pe HD](hd-install-ro.htm#Installation) 

`Alte sfaturi importante sunt:` 

+ O instalare pe USB HDD, va fi de regulă limitată la configurația PC-ului cu care s-a făcut instalarea originală. Dacă aveți intenția de a utiliza USB HDD pe alte PC-uri, ar trebui să nu aveți pre-configurate drivere grafice non-free și cheatcode-uri, cu excepția cănd aveți probabil cheatcode-uri 'vesa' în fișierul grub.cfg, (tot ce trebuie avut grijă după o instalare corectă).  
+ Dacă vreți să folosiți instalarea pe o altă mașină aveți grijă că trebuie să faceți unele modificari. Va trebui să modificați fișierul 'fstab' pentru a accesa HD-ul noului PC, probabil și fișierele 'xorg.conf' și cele de configurare a rețelei (network).  

<div class="divider" id="usb-gpt-1"></div>
## Instalarea completă pe un dispozitiv portabil și boot-abil GPT (la fel ca instalarea normală pe un HD)

 Citiți la  [Partiționarea cu  *gdisk*  pentru disk-uri GPT](part-gdisk-ro.htm#gdisk-1)  apoi urmați instrucțiunile pentru  [Opțiuni de instalare - HD, USB, VM și Cryptroot](hd-install-ro.htm) .

<div class="divider" id="usb-efi-1"></div>
## Dispozitive boot-abile (U)EFI portabile

<span class='highlight-1'>Aplicabil începând cu versiunea siduction-11.1-OneStepBeyond.</span>

Dacă doriți să folosiți la boot-are EFI fără a arde un mediu optic, atunci aveți nevoie de o partiție  *vfat*  care să conțină un încărcător de boot EFI portabil `/efi/boot/bootx64.efi` . Imaginile iso siduction amd64 includ asemenea fișier și o configurare grub care o poate încărca. Pentru a pregăti un stick să boot-eze așa, copiați conținutul siduction iso la baza partiției formatate `vfat`  de pe stick-ul usb. De asemenea va trebui s-o marcați ca boot-abilă folosind un program de partiționare.

Desigur că simpla copiere a fișierelor pe partiția vfat a stick-ului usb nu vă va permite boot-area în modul tradițional al sistemului BIOS dar este relativ ușor să rezolvați asta folosind  *syslinux*  și  *install-mbr* . Tot ce aveți nevoie este să rulați următoarele comenzi (fără ca stick-ul să fie mount-at): 

~~~  
syslinux -i -d /boot/isolinux /dev/sdXN  
install-mbr /dev/sdX  
~~~

Un stick pregătit astfel, va boot-a atât prin EFI din meniul grub2 cât și din meniul tradițional grafic  *gfxboot* .

Unul dintre avantajele de a avea un stick de felul acesta, comparativ cu un stick creat prin  *isohybrid* , ar fi acela că puteți edita fișierele de boot de pe stick pentru a adăuga automat opțiunile preferate.

Pentru sistemele BIOS tradiționale puteți edita fișierul `/boot/isolinux/syslinux.cfg`  și/sau fișierul `/boot/isolinux/gfxboot.cfg` . Pentru sistemele EFI puteți edita fișierul `/boot/grub/x86_64-efi/grub.cfg` .

#### Persistență și firmware

Vedeți  [Informații generale despre  *persist*](hd-install-opts-ro.htm#persist-post) 

<div id="rev">Page last revised 30/11/2012 1052 UTC </div>
