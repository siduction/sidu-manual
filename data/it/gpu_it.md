<div id="main-page"></div>
<div class="divider" id="foss-xorg"></div>
## Driver Opensource Xorg per ATI/AMD, Intel &amp; nVidia

I driver opensource Xorg per nVidia (nouveau), ATI/AMD (Radeon), Intel e altri sono preinstallati in siduction.

`Nota: xorg.conf in linea di massima non è più necessario per i driver opensource. Possibili eccezioni si hanno in caso di uso del doppio schermo` .

Se state utilizzando driver proprietari e volete tornare ai driver opensource cancellate `/etc/X11/xorg.conf.d/xx-xxxx.conf` .

Se volete tornare a **`nouveau`**  dal driver proprietario Nvidia fate riferimento a  [http://siduction.com/index.php?module=wikula&amp;tag=GoNvidia](http://siduction.com/index.php?module=wikula&amp;tag=GoNvidia) .

Maggiori informazioni riguardo  [ATI/AMD](http://www.x.org/wiki/radeon)   [Intel](http://www.x.org/wiki/IntelGraphicsDriver)  &nbsp;  [nouveau](http://nouveau.freedesktop.org/wiki/FeatureMatrix)  &nbsp;  [X.Org](http://xorg.freedesktop.org) 

<div class="divider" id="x2d"></div>
## Video driver 2D

I driver per il server X X.Org (si veda, per un'ulteriore descrizione, xserver-xorg) forniscono il supporto in 2D per le schede NVIDIA Riva, TNT, GeForce e Quadro e per quelle ATI Mach, Rage, Radeon e FireGL cards insieme a atimisc, r128, r6xx/r7xx e i radeon sub-driver. I driver Radeon e Intel supportano l'accelerazione 2d (textured xv) per la riproduzione dei video.

<div class="divider" id="ati-3d"></div>
## Driver 3D ATI/AMD

Alcune schede ATI supportano il 3D (e le animazioni KDE), con `xserver-xorg-video-radeon` . Al momento attuale sono supportati i chipset fino a r700. Informazioni sullo stato di sviluppo del driver radeon possono sempre essere reperite nel  [Radeon-Wiki](http://wiki.x.org/wiki/RadeonFeature) 

Per acquisire automaticamente i nuovi firmware non-free pacchettizzati per le schede video 2D e 3D quando vengono aggiornati, eseguite:

~~~  
apt-get install firmware-linux-nonfree  
~~~

Poi riavviate il computer.

<div class="divider" id="intel"></div>
## Driver Intel 2D e 3D

I driver Intel dovrebbero funzionare perfettamente per l'accelerazione video 2D e 3D in quanto inclusi nella serie libera di Intel.

<div class="divider" id="nvidia"></div>
## Driver binari closedsource per: nVidia con dmakms &amp; xorg.conf.d

`Dovrete aggiungere <contrib non-free> a debian.list; fate riferimento a  [Aggiungere non-free alle sorgenti del software](nf-firm-it.htm#non-free-firmware)` 

Per una lista più completa ed accurata delle GPU nvidia supportate si veda la Supported Products List disponibile alla pagina  [NVIDIA Linux Graphics Driver download page](http://www.nvidia.com/object/unix.html) .

Per altre opzioni si può fare riferimento a  [nvnews](http://www.nvnews.net/vbulletin/showthread.php?t=122606) .

Nelle nuove e vecchie installazioni assicuratevi che il file della configurazione di sistema `/etc/X11/xorg.conf.d`  esista e aggiungete alla directory il file `20-nvidia.conf`  :

~~~  
mkdir /etc/X11/xorg.conf.d  
touch /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

Con l'editor di testo preferito (ad es., kwrite, kate, mousepad, mcedit, vi, vim) aprite il file:

~~~  
<editor> /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

e aggiungete le linee seguenti a 20-nvidia.conf:

~~~  
#  
Section "Device"  
Identifier "Device 0"  
Driver "nvidia"  
EndSection  
# This is a trailing line, it is needed so that End Section is not the last line  
~~~

Se possedete più di una scheda grafica verificate qual è il suo indirizzo PCI e includetelo nel file 20-nvidia.conf:

~~~  
lspci | grep -i vga  
~~~

Si dovrebbe ottenere un risultato simile a questo:

~~~  
01:00.0 VGA compatible controller:  
~~~

Aggiungete il busid 01:00.0 come linea supplementare sotto la linea "Driver"; notate, comunque, che la sintassi è `PCI:x:y:z:`  senza alcuni degli zeri e con l'aggiunta dei due punti, quindi:

~~~  
BusID "PCI:1:0:0"  
~~~

#### Installare i driver nvidia

`NOTA: Usate apt-cache search nvidia e apt-cache show <nome-pacchetto> per accertarvi di quale sia il driver corretto. Fondamentalmente vi sono 2 tipi di driver nvidia: i driver attuali 3D di Debian Sid e quelli legacy che si trovano sempre in Debian Sid.` 

##### Per i driver correnti 3d di nvidia &ge; GeForce 6xxx:

Preparare il modulo:

~~~  
apt-get install nvidia-kernel-source nvidia-kernel-common dmakms  
~~~

~~~  
apt-get install nvidia-glx  
~~~

Riavviate il sistema perché abbia effetto l'installazione del modulo.

Quando xorg si aggiorna si deve solo reinstallare nvidia-glx:

~~~  
apt-get install --reinstall nvidia-glx  
~~~

Quando nvidia-kernel-source è aggiornato:

~~~  
apt-get install --reinstall nvidia-glx  
~~~

Riavviate il sistema perchè abbia effetto l'installazione del modulo.

#### Schema dei nomi per i driver nvidia legacy in Debian

+ nvidia-kernel-legacy-71xx è per GeForce 2  
+ nvidia-kernel-legacy-96xx è per GeForce 4  
+ nvidia-kernel-legacy-173xx è per GeForce 5  

##### Esempio per i driver legacy 3d nvidia utilizzando &le; GeForce 5xxx:

Per altri driver legacy sostituire il numero 173xx con quello del driver scelto.

~~~  
m-a a-i nvidia-kernel-legacy-173xx-source && apt-get install nvidia-glx-legacy-173xx nvidia-kernel-legacy-173xx-dkms  
~~~

Quando aggiornate xorg dovrete solamente reinstallare nvidia-glx-legacy:

~~~  
apt-get install --reinstall nvidia-glx-legacy-173xx  
~~~

#### Errore nel caricamento del modulo

Se, per un qualsiasi motivo, il driver nvidia non si dovesse caricare, eseguite:

~~~  
modprobe nvidia  
~~~

Quindi riavviate il sistema.

<div id="rev">Page last revised 21/01/2012 2015 UTC </div>
