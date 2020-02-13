<div id="main-page"></div>
<div class="divider" id="mon-res"></div>
## Rozdzielczość ekranu i monitory

#### xrandr

##### Obsługiwane sterowniki kart

+  xserver-xorg-video-intel (od 2.0)  
+ xserver-xorg-video-nouveau ([Refer to the nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (od 6.7.192)  

Pierwszy krokiem jest użycie komendy xrandr aby sprawdzić, czy jest ona obsługiwana, jeśli xrandr nie jest obsługiwana należy sprawdzić wersję xorg i użytego sterownika.

Aby zmienić rozdzielczość głównego ekranu sprawdzając czy karta ją obsługuje, wykonaj przykładowo:

~~~  
xrandr --output VGA --mode 1440x900  
~~~

<div class="divider" id="xrandr"></div>
## Dwa monitory i xrandr

 <span class="highlight-2">xorg.conf is deprecated, if you use free drivers.</span> If you have an xorg.conf stanza under <span class= "highlight-3">/etc/X11/xorg.conf.d</span>, because you use proprietary drivers for your graphics card, you should save it now before proceeding.

xorg.conf, if present at all, is now modular, for example, each module contains everything referring a "device" for instance, the display or a mouse.

With xrandr you can configure your primary and secondary screen without restarting X, (hotplug). Xrandr zastępuje xineramę i mergedFB. Z włączoną xrandr, "stary sposób konfiguracji" w xorg.conf (xinerama i mergedFB) może już nie działać.

<!-- mergedFB doesn't work anymore in a dist-upgraded siduction install -->
##### Wspierane sterowniki kart

+  xserver-xorg-video-intel (od 2.0)  
+ xserver-xorg-video-nouveau ([Refer to the nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (od 6.7.192)  

### Przygotowanie do konfiguracji xrandr komputera PC z DualHead

**`Uwaga:`**  Najlepiej, jeśli używasz dwóch monitorów cały czas, aby twój `xorg.conf`  został zmieniony na stałe w celu odzwierciedlenia tego trybu.

Laptop/notebook potrzebuje dynamicznej konfiguracji (w przeciwieństwie do PC z dwoma monitorami) i po restarcie trzeba będzie zacząć od początku, chyba, że ustawisz dual-head z każdym parametrów użytych w xrandr, a potem skopiujesz / wkleisz je, do skryptu `~/.kde/Autostart/` .

#### Zapoznanie się z xrandr

W pierwszym kroku wpisz po prostu xrandr w powłoce jako użytkownik aby zapoznać się z komunikatem wyjściowym:

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

Widzisz tutaj tylko tryby vga, dla PC (patrz  [Dodatek A](hw-dev-mon-pl.htm#aa)  dla wyjaśnienia nazw użytych w komunikacie wyjściowym). Widzisz rozdzielczości, które są obsługiwane przez ten ekran i (co jest ważne dla trybu dual head) maksymalny rozmiar ekranu (tutaj 2048x768).

Teraz podłącz twój inny zewnętrzny ekran i uruchom xrandr powtórnie:

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

Jak widać, podłączony jest ekran DVI, widać również, że obsługuje rozdzielczości od 720x400 do 1024x768 przy danej częstotliwości odświeżania.

###### Scenariusze konfiguracji

Składnia podstawowa

~~~  
xrandr --output <output> --rate <rate> --mode <mode> --left-of|--right-of|--above|--below|--same-as <output>  
~~~

Gdzie:

+ &lt;output&gt; jest nazwą wyjścia (patrz  [Dodatek A](hw-dev-mon-pl.htm#aa))  
+ &lt;rate&gt; jest częstotliwością odświeżania podaną przez xrandr na wyjściu (opcjonalnie)  
+ &lt;mode&gt; jest rozdzielczością podaną przez xrandr na wyjściu (opcjonalnie)  

##### Zmiana rozdzielczości głównego ekranu

~~~  
xrandr --output VGA --mode 1024x768  
~~~

###### Clone

Jako że wiele zewnętrznych ekranów/projektorów wideo nie pracuje z rozdzielczością 280x800 lecz przykładowo 1024x768, wybierz taką jako przykład:

~~~  
xrandr --output VGA --mode 1024x768 --output LVDS --mode 1024x768  
~~~

Aby wyłączyć drugi ekran i powrócić do normalnej rozdzielczości na głównym ekranie wykonaj:

~~~  
xrandr --output VGA --off --output LVDS --mode 1280x800  
~~~

##### Wieloekranowy pulpit

Ponieważ intel GMA &lt;=945GM/GMS traci obsługę 3d przy wirtualnym ekranie &gt;2048x2048, nie możesz zestawić obu ekranów obok siebie w dużej rozdzielczości, przy 1024x768 pracuja dobrze:

~~~  
xrandr --output LVDS --mode 1024x768 --output VGA --mode 1024x768 --left-of LVDS  
~~~

Aby wyłączyć tryb wieloekranowy multi po prostu wyłącz drugi ekran i zmień rozdzielczość głównego na powrót (jeśli to konieczne):

~~~  
xrandr --output VGA --off (--output LVDS --mode 1280x800)  
~~~

Inną możliwością jest ustawić drugi ekran ponad/poniżej głównego:

~~~  
xrandr --output LVDS --mode 1280x800 --output VGA --mode 1280x1024 --above LVDS  
~~~

Rezultatem jest wirtualny ekran o rozdzielczości 1280x1824 co jest poniżej 2048x2048. Jeszcz innym rozwiązaniem może być obrót ekranu:

~~~  
xrandr --verbose --output LVDS --mode 1280x800 --output VGA --mode 1024x768 --rotate left --left-of LVDS  
~~~

UWAGA: To działą tylko wtedy, gdy możesz fizycznie obrócić ekran

###### Example of a permanently configured PC with dual monitors with xrandr with code snippet in `/etc/X11/xorg.conf.d/30-screen.conf` :

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

Uwaga

+ Wirtualny ekran jest ograniczony do 2048x2048 dla intela, chociaż istnieje możliwość ustawienia wyższej rozdzielczości dzieje się to kosztem utraty obsługi DRI. Nie wygląda na to by ograniczeniem dla nvidia/ati.   
+ TV Out nie działa w ATI  
+  Jeśli sondowanie DDC nie działą właściwie z ATI (Xorg.0.log: (WW) RADEON(0): DDC2/I2C nie jest właściwie zainicjalizowane), możesz nie mieć możliwości by nadpisać wartości za pomocą modeline  
+ Przy próbie ustawienia dużego pulpitu dual-head) i xrandr podpowiada, że rozdzielczość pożądana jest większa niż taka, którą xrandr może obsłuzyć, powinieneś użyć trybu "Virtual" i potrzebnej rozdzielczości. (Patrz do sekcji Ekran w Dodatku A)  
+ Dla każdej karty wideo oprócz intela, wirtualna rozdzielczość powinna być wystarczająco duża dla rozdzielczości obydwu monitorów. Przykład: monitor1= 1024x768 i monitor2=1280x1024, tak więc wirtualny ekran powinien mieć (1024+1280)x(1024>768) -> 2304x1024  

<div class="divider" id="aa"></div>
###### Dodatek A

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

###### Odnośniki

 [http://wiki.debian.org/XStrikeForce/HowToRandR12](http://wiki.debian.org/XStrikeForce/HowToRandR12) 

 [http://bgoglin.livejournal.com/9846.html](http://bgoglin.livejournal.com/9846.html) 

 [http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419) 

 [http://www.thinkwiki.org/wiki/Xorg_RandR_1.2](http://www.thinkwiki.org/wiki/Xorg_RandR_1.2) 

<div class="divider" id="mon-binary"></div>
## Dwa monitory (z użyciem sterowników binarnych)

 `Dla firmowych sterowników prtzeczytaj dokumentację wytwórcy karty garficznej.` 

### nvidia

Use the nvidia xorg configurator  [http://www.sorgonet.com/linux/nv-online/](http://www.sorgonet.com/linux/nv-online/)  i zmień odpowiednio swoje pliki konfiguracyjne xorg.

##### Natywny ATI - radeon

<!-- [Na forum](http://siduction.org/index.php?name=PNphpBB2&amp;file=viewtopic&amp;p=19794#19794)  znajdziesz kilka działających xorg.conf z wolnym sterownikiem radeon.

-->
UWAGA: Musisz zdobyć informację o konfiguracji drugiego monitora. Aby to zrobić, musisz odłączyć jeden monitor i uruchomić komputer z liveCD, aby wygenerować xorg.conf, skopiować go, następnie zrobić to samo z drugim monitorem.

<div id="rev">Page last revised 06/03/2011 2305 UTC</div>
