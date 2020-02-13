<div id="main-page"></div>
<div class="divider" id="mon-res"></div>
## Rezoluţiile Ecranului şi Monitoare

#### xrandr

##### Driverele pentru plăcile suportate

+  xserver-xorg-video-intel (de la 2.0)  
+ xserver-xorg-video-nouveau ([Despre nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (de la 6.7.192)  

Prima dată verificați dacă  *xrandr*  este suportat. Dacă  *xrandr*  nu este suportat verificați versiunea de  *xorg*  și de  *driver*  folosită.

 Iată un exemplu de schimbare a rezoluției pe primul monitor, în caz că placa permite acest lucru, 

prin  *'xrandr'* : 

~~~  
xrandr --output VGA --mode 1440x900  
~~~

<div class="divider" id="xrandr"></div>
## Două monitoare și  *xrand* r

 <span class="highlight-2">Dacă folosiți driver-e free nu vă mai trebuie <i>xorg.conf</i>.</span> Dacă aveți un <i>xorg.conf</i> în directorul <span class= "highlight-3">/etc/X11/xorg.conf.d</span>, pentru că folosiți driver-e proprietare pentru placa video, trebuie să-l salvați acum înainte de a continua.

Fișierul  *xorg.conf* , dacă este prezent, acum are o organizare modulară, de exemplu: fiecare modul conține tot ce trebuie unui dispozitiv "device", ecranul sau un mouse.

Cu  *xrandr* . puteți configura ecranul principal sau secundar fără să mai restartați mediul X, (hotplug).  *xrandr*  înlocuiește  *xinerama*  și *mergedFB* . De la versiunea  *xrandr 1.2*  vechiul stil de configurare din  *xorg (xinerama și mergedFB)*  pare să nu mai funcționeze.

<!-- mergedFB doesn't work anymore in a dist-upgraded siduction install -->
##### Driverele pentru plăcile suportate

+  xserver-xorg-video-intel (de la 2.0)  
+ xserver-xorg-video-nouveau ([Despre nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (de la 6.7.192)  

### Pregătirea unui PC, pentru o configurare prin  *xrandr*  cu dublu-monitor

 **`Notă:`**  În mod ideal, în cazul utilizării a două monitoare în mod permanent, este bine să fie utilizată o configurație statică pentru `xorg.conf` , configurație care să reflecte acest mod de utilizare. 

 Un laptop/notebook poare fi configurat dinamic (contrar unui PC cu două monitoare), dar după reboot configurația este pierdută, cu excepția cazului în care ați utilizat anumiți parametrii în  *xrandr* , care au fost  *copy/paste*  într-un script plasat în `~/.kde/Autostart/` .

#### Să ne obișnuim cu  *xrandr* 

 Să începem prin a scrie, ca utilizator, într-un xterminal/shell  *xrandr*  și să evaluăm output-ul:

~~~  
$xrandr  
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768  
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm  
1024x768 60.0+ 75.1 70.1 60.0 59.9  
832x624 74.6  
800x600 72.2 75.0 60.3 56.2  
640x480 75.0 72.8 66.7 60.0  
720x400 70.1  
~~~

 Aici apare doar monitorul vga atașat la PC (pentru explicații detaliate asupra termenilor folosiți citiți  [Appendix A](hw-dev-mon-ro.htm#aa)). Se pot remarca rezoluțiile suportate de către acest monitor și valoarea maximă pentu acest monitor, în acest exemplu 2048x768, valoare importantă în cazul unui dublu-monitor.

 Acum puteți conecta un alt monitor extern și rula din nou  *xrandr* :

~~~  
xrandr  
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

 Pe poate observa că monitorul DVI este bine conectat și că el suportă rezoluții între 720x400 și 1024x768, la o valoare dată a ratei de refresh.

###### Câteva scenarii de configurare

 Sintaxa de bază

~~~  
xrandr --output <output> --rate <rate> --mode <mode> --left-of|--right-of|--above|--below|--same-as <output>  
~~~

unde:

+ &lt;output&gt; este numele output-ului (vedeți  [Appendix A](hw-dev-mon-ro.htm#aa))  
+ &lt;rate&gt; este rata de refresh dată de output-ul xrandr (opțional)  
+ &lt;mode&gt; este rezoluția dată de output-ul xrandr (opțional)  

##### Schimbarea rezoluției pentru monitorul principal 

~~~  
xrandr --output VGA --mode 1024x768  
~~~

###### Clonare

 Cum multe monitoare externe (sau video-proiectoare) nu pot lucra cu (sau în) modul 1280x800, ci doar cu 1024x768, folosiți această comandă ca un (bun) exemplu:

~~~  
xrandr --output VGA --mode 1024x768 --output LVDS --mode 1024x768  
~~~

 Pentru a opri al doilea monitor și a reveni la rezoluția normală pe monitorul principal, se poate rula comanda:

~~~  
xrandr --output VGA --off --output LVDS --mode 1280x800  
~~~

##### Desktop cu mai multe monitoare

 Deoarece intel GMA &lt;=945GM/GMS nu mai susține ecranele virtuale 3D cu rezoluții &gt;2048x2048, nu este posibil să folosim ambele monitoare cu rezoluție înaltă, dar în schimb la rezoluția 1024x768 ambele pot lucra fără probleme:

~~~  
xrandr --output LVDS --mode 1024x768 --output VGA --mode 1024x768 --left-of LVDS  
~~~

 Pentru a dezactiva multiple monitoare și pentru a reveni la rezoluția inițială pe monitorul principal (dacă este nevoie) se rulează comanda:

~~~  
xrandr --output VGA --off (--output LVDS --mode 1280x800)  
~~~

 Altă opțiune este să punem al doilea monitor sub sau peste primul monitor:

~~~  
xrandr --output LVDS --mode 1280x800 --output VGA --mode 1280x1024 --above LVDS  
~~~

 Monitorul virtual rezultat va avea o resoluție de 1280x1824 care și în acest caz este inferioară lui 2048x2048. O altă soluție este pivotarea de monitoare:

~~~  
xrandr --verbose --output LVDS --mode 1280x800 --output VGA --mode 1024x768 --rotate left --left-of LVDS  
~~~

NOTĂ: Opțiune interesantă doar în cazul că monitoarele pot fi inter-schimbate fizic.

###### Exemplu de PC cu două monitoare configurat permanent cu  *xrandr*  având următoarea secvență de cod în fișierul `/etc/X11/xorg.conf.d/30-screen.conf` :

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

Notă:

+  Monitorul virtual est limitat la 2048x2048 pentru intel. Se poate obține o rezoluție mai mare, însă cu pierderea suportului DRI. Se pare că această limitare nu se aplică și la nvidia/ati.   
+ Ieșirea TV nu funționează cu ATI  
+  Dacă DDC nu funționează corect cu ATI (Xorg.0.log: (WW) RADEON(0): DDC2/I2C nu este inițiat corespunzător) se poate că nu vor putea fi utilizate liniile  *modes*  în  *xorg.conf*    
+  În cazul configurării unui PC mare (cu dublu head/cap video) și că  *xrandr*  zice că rezoluția cerută depășește rezoluția suportată de  *xrandr* , se poate folosi parametrul  *"Virtual"*  împreună cu rezoluția cerută. (Vezi secțiunea  *Screen*  în Apendix A)   
+  Pentru orice placă video, cu excepția lui intel, rezoluția virtuală poate fi suficient de mare pentru rezoluția ambelor monitoare. De exemplu: monitor1= 1024x768 și monitor2=1280x1024, deci ecranul virtual poat fi de (1024+1280)x(1024>768) -> 2304x1024  

<div class="divider" id="aa"></div>
###### Appendix A

###### Intel

~~~  
Output names:  
* LVDS: internal laptop panel  
* TMDS-1: external DVI port  
* VGA: external VGA port  
* TV: external TV output  
~~~

###### ATI

~~~  
Output names:  
* LVDS: internal laptop panel  
* DVI-0: first external DVI port  
* DVI-1: second external DVI port (if present)  
* VGA-0: first external VGA port  
* VGA-1: second external VGA port (if present)  
* S-video  
~~~

###### Nvidia

~~~  
nv driver supports RandR1.2 on G80 boards  
Output names:  
* LVDS: internal laptop panel  
* DVI0: first external DVI port  
* DVI1: second external DVI port (if present)  
~~~

###### Legături utile

 [http://wiki.debian.org/XStrikeForce/HowToRandR12](http://wiki.debian.org/XStrikeForce/HowToRandR12) 

 [http://bgoglin.livejournal.com/9846.html](http://bgoglin.livejournal.com/9846.html) 

 [http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419) 

 [http://www.thinkwiki.org/wiki/Xorg_RandR_1.2](http://www.thinkwiki.org/wiki/Xorg_RandR_1.2) 

<div class="divider" id="mon-binary"></div>
## Monitoare Duble (folosind executabile) 

 `Pentru drivere-le proprietare citiți documentația producătorului plăcii grafice.` 

### nvidia

Utilizaţi  *nvidia xorg configurator*   [http://www.sorgonet.com/linux/nv-online/](http://www.sorgonet.com/linux/nv-online/)  şi modificaţi fişierul  *xorg*  după necesităţi.

##### Native ATI-radeon

<!-- [http://siduction.org/index.php?name=PNphpBB2&amp;file=viewtopic&amp;p=19794#19794](http://siduction.org/index.php?name=PNphpBB2&amp;file=viewtopic&amp;p=19794#19794)  deţine câteva fişiere  *xorg.conf*  valide cu driverele free radeon.

-->
NOTĂ: Va trebui să obţineţi informaţiile de configurare pentru al doilea monitor. Pentru aceasta deconectaţi un monitor, să boot-aţi de pe Live CD pentru a genera  *xorg.conf* , să-l copiaţi, apoi faceţi la fel pentru cel de-al doilea monitor.

<div id="rev">Page last revised 30/11/2012 2305 UTC</div>
