<div id="main-page"></div>
<div class="divider" id="mon-res"></div>
## Cambiare la risoluzione dello schermo

#### xrandr

##### Driver delle schede supportate

+ xserver-xorg-video-intel (dalla versione 2.0)  
+ xserver-xorg-video-nouveau ([Fate riferimento alla Tabella di Stato qui riportata](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (dalla 6.7.192)  

Il primo passo consiste nel digitare xrandr per verificare se è supportato: se non lo è, verificate la versione di xorg e i driver utilizzati.

Cambiate la risoluzione dello schermo primario, presumendo che sia supportata dalla scheda; per esempio:

~~~  
xrandr --output VGA --mode 1440x900  
~~~

<div class="divider" id="xrandr"></div>
## Doppio monitor e xrandr

 <span class="highlight-2">xorg.conf non è necessario se usate i driver liberi.</span> Se avete un'istanza di xorg.conf in <span class= "highlight-3">/etc/X11/xorg.conf.d</span> in quanto facevate uso di driver proprietari per la scheda grafica, dovreste salvarla prima di procedere.

xorg.conf, comunque, se presente, è adesso modulare: ogni modulo contiene tutto ciò che fa riferimento a un dispositivo, ad esempio il display o il mouse.

Con xrandr potete configurare lo schermo primario e secondario senza riavviare X (il cosiddetto "hotplug", cioè "collegamento a caldo"). xrandr rimpiazza xinerama e mergedFB. Con xrandr 1.2 abilitato, il "vecchio modo di configurare" xorg.conf (xinerama e mergedFB) non funziona più.

##### Driver delle schede supportate

+  xserver-xorg-video-intel (dalla versione 2.0)  
+ xserver-xorg-video-nouveau ([Fate riferimento alla Tabella di Stato qui riportata](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (dalla 6.7.192)  

### Preparazione per configurazioni con xrandr di un PC con scheda DualHead

**`NOTA:`**  Idealmente, se utilizzate costantemente 2 monitor con un PC, il file `xorg.conf`  dovrebbe essere modificato sì che rifletta quel modo permanentemente.

Un computer portatile ha bisogno di essere configurato dinamicamente (al contrario di un PC con 2 monitor) e quando lo riavviate dovrete rifarlo, a meno che non impostiate il dual-head con tutti i parametri che si usano in xrandr e ne facciate copia/incolla in uno script da mettere in `~/.kde/Autostart/` .

#### Acquisire confidenza con xrandr

Il primo passo consiste semplicemente nel digitare "xrandr" in una console come utente normale e familiarizzarsi con ciò che viene visualizzato:

~~~  
xrandr  
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768  
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm  
1024x768 60.0+ 75.1 70.1 60.0 59.9  
832x624 74.6  
800x600 72.2 75.0 60.3 56.2  
640x480 75.0 72.8 66.7 60.0  
720x400 70.1  
~~~

Qui potete vedere una sola VGA per il PC (si veda  [l'Appendice A](hw-dev-mon-it.htm#aa)  per la spiegazione dei termini presenti nell'output). Vedrete le risoluzioni supportate da quello schermo e, cosa importante per la configurazione del doppio monitor, la massima risoluzione dello schermo (in questo caso 2048x768).

Ora connettete lo schermo esterno e lanciate di nuovo il comando xrandr:

~~~  
$ xrandr  
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768  
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm  
1024x768 60.0+ 75.1 70.1 60.0 59.9  
832x624 74.6  
800x600 72.2 75.0 60.3 56.2  
640x480 75.0 72.8 66.7 60.0  
720x400 70.1  
DVI-0 connected 1024x768+1024+0 (normal left inverted right x axis y axis) 310mm x 230mm  
1024x768_85.00 85.0+  
1024x768 85.0 + 84.9 74.9 75.1 70.1 60.0 43.5  
832x624 74.6  
800x600 84.9 72.2 75.0 60.3 56.2  
640x480 84.6 75.0 72.8 66.7 60.0  
720x400 87.8 70.1  
S-video disconnected (normal left inverted right x axis y axis)  
~~~

Qui potete vedere che è ora connesso anche uno schermo DVI che supporta risoluzioni da 720x400 a 1024x768 con determinati livelli di refresh.

###### Scenari di configurazione

Sintassi di base:

~~~  
xrandr --output <output> --rate <rate> --mode <mode> --left-of|--right-of|--above|--below|--same-as <output>  
~~~

Dove:

+ &lt;output&gt; è il nome dell'output (si veda  [l'Appendice A](hw-dev-mon-it.htm#aa))  
+ &lt;rate&gt; è il valore di refresh dato dall'output di xrandr (opzionale)  
+ &lt;mode&gt; è la risoluzione data dall'output di xrandr (opzionale)  

##### Cambiare la risoluzione dello schermo primario

~~~  
xrandr --output VGA --mode 1024x768  
~~~

###### Clonazione

Siccome molti schermi esterni e videoproiettori non funzionano con risoluzione 1280x800, ma ad esempio con 1024x768, prendete come riferimento:

~~~  
xrandr --output VGA --mode 1024x768 --output LVDS --mode 1024x768  
~~~

Per interrompere il segnale sullo schermo secondario e tornare alla normale risoluzione sullo schermo primario, lanciate il comando:

~~~  
xrandr --output VGA --off --output LVDS --mode 1280x800  
~~~

##### Desktop a monitor multiplo

Poiché Intel GMA &lt;=945GM/GMS perde il supporto al 3D con uno schermo virtuale &gt;2048x2048, non potete usare entrambi gli schermi l'uno accanto all'altro in alta risoluzione, ma entrambi lavorano bene a 1024x768:

~~~  
xrandr --output LVDS --mode 1024x768 --output VGA --mode 1024x768 --left-of LVDS  
~~~

Per disabilitare il multischermo, disabilitate lo schermo secondario e riportate la risoluzione dello schermo primario al suo valore (se necessario) con:

~~~  
xrandr --output VGA --off (--output LVDS --mode 1280x800)  
~~~

Un'altra opzione consiste nel porre lo schermo secondario sopra/sotto quello primario:

~~~  
xrandr --output LVDS --mode 1280x800 --output VGA --mode 1280x1024 --above LVDS  
~~~

Ne risulta una risoluzione dello schermo virtuale pari a 1280x1824, cioè al di sotto di 2048x2048. Altra soluzione potrebbe essere ruotare lo schermo:

~~~  
xrandr --verbose --output LVDS --mode 1280x800 --output VGA --mode 1024x768 --rotate left --left-of LVDS  
~~~

NOTA: Questo accorgimento funziona solo se potete ruotare anche lo schermo vero e proprio.

###### Esempio di un PC configurato stabilmente con due monitor con xrandr, con parte del codice in `/etc/X11/xorg.conf.d/30-screen.conf` :

~~~  
#30-screen.conf  
Section "Monitor"  
Identifier "DVI-0"  
Option "Primary" "true"  
EndSection  
Section "Monitor"  
Identifier "DVI-1"  
Option "RightOf" "DVI-0"  
EndSection  
Section "Device"  
Identifier "ATI Radeon HD 2600"  
Option "Monitor-DVI-0" "DVI-0"  
Option "Monitor-DVI-1" "DVI-1"  
EndSection  
~~~

NOTA:

+ Lo schermo virtuale è limitato a 2048x2048 per le schede Intel. Sebbene sia possibile impostare una risoluzione virtuale più alta, ciò comporterà la perdita del supporto DRI. Non sembrano esserci limiti per le schede nVidia/ATI.  
+ Il TV Out non funziona con ATI  
+ Se il DDC non funziona correttamente con ATI (Xorg.0.log: (WW) RADEON(0): DDC2/I2C is not properly initialised), potreste non riuscire a modificare i valori con modelines.  
+ Quando cercate di impostare un grande monitor (dual-head) e xrandr avverte che la risoluzione che richiedete è più grande di quella che può supportare, dovreste usare "Virtual" e la risoluzione voluta (Guardate la sezione Screen nell'Appendice A).  
+ Per tutte le schede video, eccetto Intel, la risoluzione virtuale dovrebbe essere grande abbastanza per entrambe le risoluzioni dei monitor. Ad esempio: con monitor1=1024x768 e monitor2=1280x1024, lo schermo virtuale dovrebbe essere (1024+1280)x(1024>768) -> 2304x1024.  

<div class="divider" id="aa"></div>
###### Appendice A

###### Intel

~~~  
Output names (Termini dell'output):  
* LVDS: internal laptop panel (schermo interno del portatile)  
* TMDS-1: external DVI port (porta DVI esterna)  
* VGA: external VGA port (porta VGA esterna)  
* TV: external TV output (porta TV esterna)  
~~~

###### ATi

~~~  
Output names (Termini dell'output):  
* LVDS: internal laptop panel (schermo interno del portatile)  
* DVI-0: first external DVI port (prima porta DVI esterna)  
* DVI-1: second external DVI port (seconda porta DVI esterna) - (se presente)  
* VGA-0: first external VGA port (prima porta VGA esterna)  
* VGA-1: second external VGA port (seconda porta VGA esterna) - (se presente)  
* S-video  
~~~

###### nVidia

~~~  
il driver nv supporta RandR1.2 nelle schede G80  
Output names (Termini dell'output):  
* LVDS: internal laptop panel (schermo interno del portatile)  
* DVI0: first external DVI port (prima porta DVI esterna)  
* DVI1: second external DVI port (seconda porta DVI esterna) - (se presente)  
~~~

###### Collegamenti

 [http://wiki.debian.org/XStrikeForce/HowToRandR12](http://wiki.debian.org/XStrikeForce/HowToRandR12) 

 [http://bgoglin.livejournal.com/9846.html](http://bgoglin.livejournal.com/9846.html) 

 [http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419) 

 [http://www.thinkwiki.org/wiki/Xorg_RandR_1.2](http://www.thinkwiki.org/wiki/Xorg_RandR_1.2) 

<div class="divider" id="mon-binary"></div>
## Configurazione con Doppio Monitor (usando i driver binari)

 `Per i driver proprietari leggete la documentazione del produttore della scheda video.` 

### nVidia

Usate il configuratore xorg di nVidia  [http://www.sorgonet.com/linux/nv-online/](http://www.sorgonet.com/linux/nv-online/)  e modificate il file xorg conformemente.

### Driver nativi ATI - radeon

NOTA: vi serviranno le informazioni di configurazione del secondo monitor. Per ottenerle staccate un monitor e avviate il PC con il liveCD per generare xorg.conf; copiatelo; poi ripetete la procedura con il secondo monitor.

Per informazioni dettagliate sulla configurazione guardate  [http://ftp.x.org/pub/X11R6.9.0/doc/html/radeon.4.html](http://ftp.x.org/pub/X11R6.9.0/doc/html/radeon.4.html) .

<div id="rev">Page last revised 19/02/2012 1839 UTC</div>
