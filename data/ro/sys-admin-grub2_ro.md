<div id="main-page"></div>
<div class="divider" id="grub2"></div>
## GRUB 2

###### Scurt sumar al diferențelor majore dintre GRUB 1 (cunoscut acum ca 'grub-legacy') și GRUB 2:

+ `Fișierul  *menu.lst*  nu mai există.`   
+ Un fișier numit `*grub.cfg*`  controlează acum Ecranul Grub.  
+  *grub.cfg*  este generat automat de script-uri în `*/etc/grub.d*` .  
+ Numerotarea partițiilor este de asemenea diferită. Ea începe acum de la  **1**  în loc de  **0**  (discurile sunt în continuare numărate începând cu  **0** ):  
   ~~~    
   Linux grub1 grub2    
   /dev/sda1 (hd0,0) (hd0,1)    
   /dev/sda2 (hd0,1) (hd0,2)    
   /dev/sda3 (hd0,2) (hd0,3)    
   /dev/sdb1 (hd1,0) (hd1,1)    
   /dev/sdb2 (hd1,1) (hd1,2)    
   /dev/sdb3 (hd1,2) (hd1,3)    
   ~~~
  
+ Structura fișierului  *grub.cfg*  este complet diferită de  *menu.lst*  și NU poate fi copiată direct din Grub 1  *menu.lst*  în Grub 2  *grub.cfg*  ca să rezulte fișierul  *grub.cfg* . **`Fișierul  *grub.cfg*  NU trebuie NICIODATĂ modificat manual !!.`**   

<div class="divider" id="grub2-files"></div>
#### Fișierul de configurare implicit al Grub 2

Fișierul `*/etc/default/grub*`  conține valorile variabilelor necesare lui grub2, cum sunt: timpul de afișare al meniului, intrările implicit active din meniu, parametrii de kernel, utilizarea elementelor grafice în grub și așa mai departe.

#### Script-urile lui Grub 2

Fișierele din `*/etc/grub.d*`  controlează și au ca rezultat fișierul numit `*grub.cfg*` , ce poate fi găsit în `*/boot/grub/*` .

**`Fișierul  *grub.cfg*  NU trebuie modificat NICIODATĂ manual.`** Toate modificările trebuie făcute cu unul sau cu toate script-urile aflate în `*/etc/grub.d*` .  *'os-prober'*  ar trebui să le rezolve în 90% din cazuri:

~~~  
00_header:  
05_debian_theme: Setează fundalul, culorile textului, temele  
10_hurd: Locația Hurd kernels  
10_linux: Locația Linux kernels bazată pe rezultatele oferite de comanda  *'lsb_release'* .  
20_memtest86+: Dacă fișierul  */boot/memtest86+.bin  există, este inclus în meniul de boot.  
30_os-prober: Caută Linux și alte SO-uri pe toate partițiile; le include în meniul de boot.  
40_custom: Un șablon pentru a adăuga intrări personale în meniu ale altor Sisteme de Operare.  
60_fll-fromiso: Un șablon pentru a adăuga intrări personale în meniu util la boot-area  fromiso  de pe un USB-stick/SSD-card.  
<span class="highlight-2"> 60_fll-fromiso  nu trebuie modificat; folosiți  */etc/default/grub2-fll-fromiso   
Citiți  [Boot-area  *'fromiso'*  cu Grub 2](hd-install-opts-ro.htm#grub2-fromiso) </span>  
~~~

După ce o modificare este făcută,  *grub*  trebuie să știe schimbările. În cazul unei actualizări a kernel-ului siduction, comanda de actualizare a lui  *grub*  este rulată automat. În cazul unei modificări făcută manual de voi, ca administrator de sistem, asupra oricărui fișier menționat mai sus, trebuie să rulați: 

~~~  
update-grub  
~~~

`Pachetul Debian Grub2 este astfel proiectat încât o modificare manuală de către voi să fie necesară foarte rar.` 

<div class="divider" id="grub1-grub2"></div>
## Trecerea de la Grub Legacy la Grub2

**`Vă recomandăm să faceți o trecere curată la Grub2 și să îndepărtați total Grub1.`**  Trebuie să vă avertizăm că puteți da totul peste cap deci fiți foarte atenți !.

###### Pasul 1: 

Asigurați-vă că sistemul vostru aste complet adus la zi prin `*dist-upgrade*  în  *init 3* .` 

~~~  
apt-get update  
Ctrl+alt+F1  
init 3  
apt-get dist-upgrade  
init 5 && exit  
~~~

###### Pasul 2:

Îndepărtați Grub1 total:

~~~  
rm -rf /boot/grub  
apt-get purge grub-gfxboot  
~~~

Rezultatul va fi: `fll-iso2usb* grub-gfxboot* install-usb-gui* will be removed`  Tipăriți `Y`  pentru confirmare.

###### Pasul 3:

~~~  
apt-get install grub2 os-prober  
~~~

![Grub2](../images-common/images-grub2/grub2-2.png "Grub2") 

Folosiți tasta 'Tab' pentru a selecta 'OK'

![Grub2](../images-common/images-grub2/grub2-3.png "Grub2") 

Folosiți tasta 'Tab' pentru a selecta 'OK'

![Grub2-conversion 1](../images-common/images-grub2/grub2-convert-1.png "Grub2-conversion 1") 

Folosiți săgețile de la tastatură și tasta de spațiu pentru a plasa un `* (asterisc)`  ca să selectați pe a cărui MBR de hard drive urmează să scrie Grub2.  *(Acest exemplu arată instalarea pe un USB drive)* .

###### Pasul 4:

~~~  
update-grub  
~~~

###### Pasul 5:

~~~  
apt-get install install-usb-gui  
~~~

###### Pasul 6:

 Reboot-ați PC-ul și  *menu.cfg*  va afișa lista cu kernel-urile și sistemele de operare așa:

![Grub2-OS list](../images-common/images-grub2/grub2-os-list.jpg "Grub2-OS list") 

Dacă ceva e în neregulă sau merge prost uitați-vă la  [Suprascrierea sau stricarea lui Grub2 în MBR](sys-admin-grub2-ro.htm#chroot)  

### Modificarea opțiunilor de boot în Grub2 folosind ecranul de editare

![Grub2-Edit](../images-common/images-grub2/grub2-e-1.JPG "Grub2-Edit") 

Dacă, din anumite motive, trebuie să faceți niște modificări temporare ale opțiunilor de boot ale kernel-ului selectat în ecranul de boot al Grub2, apăsați litera**`e`**  pentru a edita opțiunile kernel-ului apoi, folosind tastele săgeți, deplasați-vă la linia pe care vreți s-o editați. După ce ați editat folosiți combinația `Ctrl+x`  pentru a boot-a computerul cu noile voastre opțiuni.

De examplu, pentru a rula direct în nivelul 3, adăugați `3`  la sfârșitul liniei ce conține `linux /boot/vmlinuz` .

Aceste editări nu sunt pemanente. Pentru a face schimbări permanente trebuie să editați fișierele corespunzătoare. Vedeți  [Fișierele lui Grub2](sys-admin-grub2-ro.htm#grub2-files) .

<div class="divider" id="multi-os"></div>
## Boot-area Duală și multi-booting cu Grub 2

Având o configurație modulară, Grub2 oferă o comandă simplă de descoperire a oricărui sistem nou instalat iar dacă este găsit vre-o unul încearcă să implementeze schimbările prin actualizarea fișierului  *menu.cfg* . Comanda este:

~~~  
update-grub  
~~~

Dacă aveți nevoie să adăugați o intrare personală la  *menu.cfg*  sau dacă cele 30_os-prober nu reușesc să scrie în  *menu.cfg*  cu meniul  *chainloader* , folosiți editorul de texte favorit pentru a face amendamentele în fișierul `*/etc/grub.d/40_custom*` .

Exemple de personalizare a fișierului  *40_custom* :

~~~  
menuentry "second mbr"{  
set root=(hd1)  
chainloader +1  
}  
~~~

~~~  
menuentry "second partition"{  
set root=(hd0,2)  
chainloader +1  
}  
~~~

După ce ați făcut schimbările voastre rulați:

~~~  
update-grub  
~~~

Dacă programul se plânge că nu recunoaște dispozitivele grub ale unui disk, înseamnă că trebuie re-generată  *devicemap* .

`Asigurați-vă că ați ales partiția NU MBR când instalați un alt sistem de operare:` 

~~~  
grub-mkdevicemap --no-floppy  
update-grub  
~~~

Avertizările pot fi ignorate în siguranță.

Dacă ați făcut vre-o greșeală, suprascriind probabil MBR veți avea nevoie pentru a repara asta cu  [Suprascrierea sau stricarea lui Grub2 în MBR](sys-admin-grub2-ro.htm#mbr-over-grub2) .

<div class="divider" id="mbr-over-grub2"></div>
## Doar pentru a re-scrie grub2 în MBR de pe hard drive:

~~~  
/usr/sbin/grub-install --recheck --no-floppy /dev/sda  
~~~

Această linie s-ar putea să fie nevoie s-o rulați de mai multe ori, până convingeți programul că într-adevăr asta vreți să faceți.

## MBR Sectorul de boot suprascris de Windows, și /sau restaurarea lui Grub2

**`NOTĂ: pentru a restaura un Grub2 trebuie să aveți un  *iso siduction* mo.`**   [Ca alternativă puteți folosi  *chroot*  de pe oricare live.iso](sys-admin-grub2-ro.htm#chroot) .

 Pentru a rescrie grub2 în MBR și/sau să reparați grub2 în general, va trebui să porniți sistemul de pe un `siduction.iso` :

1. Pentru a indentifica și confirma partițiile voastre (e.g. [h,s]d[a..]X) toate acțiunile următoare cer drepturi de administrator  *(root)* , deci să devenim  *root*  (#):  
   ~~~    
   $ sux    
   ~~~
  
2. Fiind  *root*  tipăriți:  
   ~~~    
   fdisk -l    
   cat /etc/fstab    
   ~~~
  
   Aceasta vă va oferi numele corecte.  
3. Când aveți convingerea că știți partiția corectă, creați punctul de mount-are:  
   ~~~    
   mkdir -p /media/[hdxx,sdxx,diskx]    
   ~~~
  
4. Mount-ați-o:  
   ~~~    
   mount /dev/xdxx /media/xdxx    
   ~~~
  
5. Acum rescrieți Grub în MBR al primului hard disk (generic):  
   ~~~    
   /usr/sbin/grub-install --recheck --no-floppy --root-directory=/media/xdxx /dev/sda    
   ~~~
  

<div class="divider" id="chroot"></div>
## Suprascrierea sau stricarea lui Grub în MBR

Recuperarea lui Grub 2, dacă a fost suprascris sau stricat în MBR, folosiți următoarea metodă. `Oricare live.iso va fi suficient pentru a folosi  *chroot*  și a accesa sistemul instalat pe hard disk putând restaura versiunea grub corespunzătoare, grub1 (grub-legacy) sau grub2.` 

Boot-ați de pe un live siduction.iso care este cât mai apropiată de sistemul vostru (32 sau 64 bit CD, DVD, USB stick sau un SSD card) și deschideți o konsole. Tipăriți `sux`  și apăsați enter pentru a da parola și a primi permisiuni de administrator  *(root)* .

Folosind `fdisk -l`  sau `blkid` , aflați care este numele corect al partiției de boot. Dacă preferați GUI folosiți `Gparted` :

~~~  
blkid  
~~~

și verificați dacă intrările din  *fstab*  se potrivesc cu output-ul lui  *blkid* :

~~~  
cat /etc/fstab  
~~~

Să presupunem că sistemul de fișiere root este pe `/dev/sda2` 

~~~  
mkdir /mnt/siduction-chroot  
mount /dev/sda2 /mnt/siduction-chroot  
~~~

Apoi, trebuie să mount-ați `/proc` , `/run` , `/dev` și `/sys`  astfel:

~~~  
mount --bind /proc /mnt/siduction-chroot/proc  
mount --bind /run /mnt/siduction-chroot/run  
mount --bind /sys /mnt/siduction-chroot/sys  
mount --bind /dev /mnt/siduction-chroot/dev  
mount --bind /dev/pts /mnt/siduction-chroot/dev/pts  
~~~

Dacă boot-ați un sistem care folosește o partiționare EFI va trebui de asemeni să-l mount-ați. Presupunând că acesta este /dev/sda1:

~~~  
mount /dev/sda1 /mnt/siduction-chroot/boot/efi  
~~~

Mediul  *chroot*  fiind acum setat, accesați-l cu:

~~~  
chroot /mnt/siduction-chroot /bin/bash  
~~~

Acum puteți folosi arhivele locale din  */var/cache/apt*  sau să modificați/reparați fișierele de care aveți nevoie când veți boot-a normal în SO, în acest caz de a repara Grub în MBR.

`Repararea lui Grub2` 

~~~  
apt-get install --reinstall grub-pc  
~~~

Pentru a vă asigura că  *grub*  a fost instalat pe disk-ul sau partiția corectă, rulați:

~~~  
dpkg-reconfigure grub-pc  
~~~

`Repararea Grub 2 EFI` 

~~~  
apt-get install --reinstall grub-efi-amd64  
~~~

`Repararea lui Grub1 (grub-legacy)` 

~~~  
apt-get install --reinstall grub-legacy  
~~~

Urmați instrucțiunile programului de instalare.

Pentru a părăsi mediul  *chroot* :

~~~  
Ctrl+d  
~~~

Reboot-ați PC-ul.

<div id="rev">Page last revised 04/12/2012 1330 UTC</div>
