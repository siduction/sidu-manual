<div id="main-page"></div>
<div class="divider" id="foss-xorg"></div>
## Drivere Open Source Xorg pentru ATI/AMD, Intel &amp; nVidia

Drivere open-source Xorg pentru nVidia, ATI/AMD, Radeon, Intel sunt preinstalate cu siduction.

`NOTĂ:  *xorg.conf*  nu este în general necesar pentru driverele open-source.` 

Dacă ați folosit drivere proprietare și doriți să reveniți la drivere open-source editați `/etc/X11/xorg.conf.d/xx-xxxx.conf`  într-un editor de texte cu permisiuni de  *root* . Găsiți secțiunea SECTION DEVICE și schimbați numele driverului video în **`radeon`**  SAU **`intel`**  (am numit doar câteva).

Pentru a reveni la **`nouveau`**  de la driverele proprietare ale Nvidia citiți  [http://siduction.org/index.php?module=wikula&amp;tag=GoNvidia](http://siduction.org/index.php?module=wikula&amp;tag=GoNvidia) .

**`Editarea  *xorg.conf*  o faceți în totalitate pe riscul dumneavoastră.`**

Mai multe informaţii despre  [Intel](http://www.x.org/wiki/IntelGraphicsDriver)   [ATI/AMD](http://www.x.org/wiki/radeon)  &nbsp;  [ATI/AMD Feature Matrix](http://www.x.org/wiki/RadeonFeature)  &nbsp;  [nouveau](http://nouveau.freedesktop.org/wiki/FeatureMatrix)  &nbsp;  [X.Org](http://xorg.freedesktop.org) 

<div class="divider" id="x2d"></div>
## Drivere 2D

Driverele X.Org pentru serverele X (vedeţi  *xserver-xorg*  pentru descriere) oferă suport 2d pentru placile NVIDIA Riva, TNT, GeForce şi Quadro, pentru plăcile ATI Mach, Rage, Radeon şi FireGL plus pentru sub-driverele atimis, r128 şi radeon. Ambele, Radeon și Intel, suportă accelerare 2d (textured xv) pentru redare video.

<div class="divider" id="ati-3d"></div>
## ATI/AMD Drivere 3D

Unele plăci ATI suportă 3D, până la chipset-urile din seria r5xx.

Pentru actualizarea automată cu pachetele nou apărute (non-free firmware) pentru plăcile video 2D și 3D:

~~~  
apt-get install firmware-linux-nonfree  
~~~

Apoi reboot-ați computerul.

<div class="divider" id="intel"></div>
## Intel 2D and 3D

Driverele Intel trebuie să lucreze perfect pentru acceleratoare video 2D și 3D așa cum sunt incluse în seria free de la Intel.

<div class="divider" id="nvidia"></div>
## Drivere closed-sourse, binare pentru nVidia cu dmakms &amp; xorg.conf.d

`Trebuie să adăugați <contrib non-free> la debian.list; cosultați  [Adăugarea non-free la surse](nf-firm-ro.htm#non-free-firmware)` 

Pentru o listă mai completă și precisă cu procesoarele grafice (GPU) suportate vă rog să vedeți  [NVIDIA Linux Graphics Driver download page](http://www.nvidia.com/object/unix.html) .

Puteți citi de asemenea:  [nvnews](http://www.nvnews.net/vbulletin/showthread.php?t=122606)  pentru alte opțiuni.

Pe sistemele nou instalate și pe cele mai vechi trebuie să verificați existența dosarului `/etc/X11/xorg.conf.d`  și să adăugați în el un fișier numit `20-nvidia.conf` : 

~~~  
mkdir /etc/X11/xorg.conf.d  
touch /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

Cu editorul de texte preferat deschideți fișierul, (de exemplu: kwrite, kate, mcedit, vi, vim):

~~~  
<editor> /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

și adăugați în întregime următoarele linii la  *20-nvidia.conf* :

~~~  
#  
Section "Device"  
Identifier "Device0"  
Driver "nvidia"  
EndSection  
# Acesta este doar un fragment necesar din fișier și deci linia "End Section" nu este ultima  
~~~

Dacă aveți mai mult de o placă grafică va trebui să descoperiți portul PCI și s-o includeți în  *20-nvidia.conf* :

~~~  
lspci | grep -i vga  
~~~

Aceasta ar trebui să întoarcă un răspuns similar ca formă cu acesta:

~~~  
01:00.0 VGA compatible controller:  
~~~

Adăugând "01:00.0" 'BusID' ca o altă linie sub linia 'Driver', rețineți că sintaxa este `PCI:x:y:z:`  cu zero-uri separate prin semnul " **:** " (două puncte), ca mai jos:

~~~  
BusID "PCI:1:0:0"  
~~~

#### Instalarea drivere-lor nvidia 

`NOTĂ: Utilizați  *'apt-cache search nvidia'*  și  *'apt-cache show <nume_pachet>'*  pentru a stabili driver-ul corect.Sunt practic 2 tipuri de drivere nvidia: drivere-le Debian Sid 3D curente și drivere-le Debian Sid 3D legacy.` 

##### Pentru driverele 3D nvidia &ge; GeForce 6xxx:

Pregătiți modulul:

~~~  
apt-get install nvidia-driver  
~~~

Reboot-ați PC-ul pentru ca instalarea modulului să fie efectuată.

La actualizarea  *'xorg'*  trebuie doar să reinstalați  *'nvidia-driver'* :

~~~  
apt-get install --reinstall nvidia-driver  
~~~

#### Formatul numelor pentru driverele legacy nvidia în Debian

+ nvidia-kernel-legacy-96xx este pentru GeForce 4  
+ nvidia-kernel-legacy-173xx este pentru GeForce 5  
+ nvidia-kernel-legacy-304xx este pentru GeForce 6  

##### Examplu de utilizare pentru drivere legacy 3d nvidia folosind &le; GeForce 5xxx :

Pentru alte drivere legacy înlocuți doar numărul 173xx cu numărul driver-ului vostru.

~~~  
apt-get install nvidia-legacy-173xx-driver  
~~~

Când actualizați  *xorg*  trebuie doar să reinstalați  *nvidia-legacy* :

~~~  
apt-get install --reinstall nvidia-legacy-1733xx-driver (sau versiunea potrivita)  
~~~

#### Eșercul încărcării Modulului

Din diferite motive  *'nvidia'*  poate eșua la încărcare:

~~~  
modprobe nvidia  
~~~

Apoi reboot-ați PC-ul.

<div id="rev">Content last revised 16/01/2014 16:33 UTC </div>
