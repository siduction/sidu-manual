<div id="main-page"></div>
<div class="divider" id="foss-xorg"></div>
## Sterowniki Open Source Xorg do nVidia, ATI, Radeon, Intel &amp; Xorg

Sterowniki Open Source Xorg dla kart nVidia, ATI, Radeon, Intel są pre-instalowane przy instalacji siduction.

`Notka: xorg.conf generalnie nie jest potrzebny gdy używasz otwarto źródłowych setrowników.` 

Jeśli używałeś zamkniętych sterowników ,i chcesz wrócic do otwarto źródłowych edytuj `/etc/X11/xorg.conf.d/xx-xxxx.conf`  edytorem z uprawnieniami roota.Znajdź sekcję DEVICE ,i zmień sterownik na **`radeon`**  lub **`intel`**  (aby wymienić kilka dla przykładu).

To revert to **`nouveau`**  from the Nvidia proprietary drivers refer to  [german siduction-wiki](http://wiki.siduction.de/index.php?title=Wie_entferne_ich_propriet%C3%A4re_nVidia-Treiber%3F)  (Sorry, at the moment we only have a german wiki, we need help to translate it. So if u want to help, please anounce it in the forum or IRC).

**`Edytując xorg.conf robisz to na własne ryzyko!!`**

Więcej informacji o  [Intel](http://www.x.org/wiki/IntelGraphicsDriver)   [ATI/AMD](http://www.x.org/wiki/radeon)  &nbsp;  [ATI/AMD Feature Matrix](http://www.x.org/wiki/RadeonFeature)  &nbsp;  [nouveau](http://nouveau.freedesktop.org/wiki/FeatureMatrix)  &nbsp;  [X.Org](http://xorg.freedesktop.org) 

<div class="divider" id="x2d"></div>
## 2D video drivers

Sterowniki dla X.Org X server (dalszy opis patrz xserver-xorg) zapewniają wsparcie dla kart 2D z NVIDIA Riva, TNT, GeForce, oraz Quadro a także ATI Mach, Rage, Radeon i FireGL wraz z atimisc, r128, r6xx/r7xx podwersjami radeon. Radeon jak i Intel suportują akcelerację 2d (textured xv) do odtwarzania wideo.

<div class="divider" id="ati-3d"></div>
## ATI/AMD 3D Drivers

Niektóre karty ATI również wspierają 3D (i animacje KDE), z `xserver-xorg-video-radeon` . Dotychczas chipsety do R700 są obsługiwane.

Do automatycznego instalowania nowych niewolnych sterowników, kiedy aktualizujemy pakiety sterowników 2D i 3D:

~~~  
apt-get install firmware-linux  
~~~

Potem zrestartuj komputer.

<div class="divider" id="intel"></div>
## Intel 2D and 3D

Sterowniki Intela powinny perfekcyjnie pasować do akceleratorów grafiki 2D i 3D. Dołączone sterowniki należą do serii wolnych sterowników Intela.

<div class="divider" id="nvidia"></div>
## Binary, closed source drivers for: nVidia with dmakms &amp; xorg.conf.d

`You will need to add <contrib non-free> to your debian.list, refer to  [Adding non-free to sources](nf-firm-pl.htm#non-free-firmware)` 

Dla kompletną i dokładną listę obsługiwanych procesorów graficznych NVIDIA zobacz na stronie  [NVIDIA Linux Graphics Driver](http://www.nvidia.com/object/unix.html) .

Więcej opcji można znaleźć w  [nvnews](http://www.nvnews.net/vbulletin/showthread.php?t=122606) .

Nowe i stare instalacje muszą zapewnić, że istnieje katalog konfiguracji dla całego systemu `/etc/X11/xorg.conf.d`  i do katalogu dodany jest plik o nazwie `20-nvidia.conf`  : 

~~~  
mkdir /etc/X11/xorg.conf.d  
touch /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

Otwórz plik w edytorze tekstu (np. kwrite, kate, mousepad, mcedit, vi, vim):

~~~  
<editor> /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

i cię dodaje następujące kody w całości do pliku 20-nvidia.conf:

~~~  
#  
Section "Device"  
Identifier "Device 0"  
Driver "nvidia"  
EndSection  
# This is a trailing line, it is needed so that End Section is not the last line  
~~~

Jeśli masz więcej niż jednej karty graficznej trzeba będzie ustalić PCI oraz dodać go w 20-nvidia.conf: 

~~~  
lspci | grep -i vga  
~~~

Powinno to zwrócić wynik podobny do tego: 

~~~  
01:00.0 VGA compatible controller:  
~~~

Dodaj BusID 01:00.0 w dodatkowej linii pod liną "Driver" (Sterownik), jednak zauważ, że składnia jest `PCI:x:y:z:`  - wiodących zer się nie pisze i tylko podwójne punkty są stosowane. Wpis jest więc:

~~~  
BusID "PCI:1:0:0"  
~~~

#### Instalacja sterownika Nvidia 

`UWAGA: Użyj "nvidia apt-cache search" i "apt-cache show <package>" aby określić prawidłowy sterownik do karty graficznej. Generalnie istnieją dwa rodzaje sterowników nvidia, najnowsze sterowniki 3D z Debiana Sid i sterowników 3D Legacy dla starszych kart graficznych.` 

##### Aktualne sterowniki 3D dla kart Nvidia &ge; GeForce 6xxx :

Przygotowanie modułu:

~~~  
apt-get install nvidia-kernel-source nvidia-kernel-common dmakms  
~~~

Następnie należy uaktywnić Dynamic Module-Assistant Kernel Module Support (dmakms) dla nvidia tak, aby następnym razem przy aktualizacji jądra linuksa moduł nvidii był także aktualizowany bez koniecznosci ręcznej ingerencji. Aby tego dokonać, dodaj `nvidia-kernel-source`  do pliku konfiguracyjnego `/etc/default/dmakms` :

~~~  
echo nvidia-kernel-source >> /etc/default/dmakms  
~~~

Następnie:

~~~  
m-a a-i nvidia-kernel-source  
~~~

W kolejności:

~~~  
apt-get install nvidia-glx  
~~~

Żeby zobaczyć efekt instalacji modulu należy zrestartować PC.

Po aktualizacji xorg należy tylko przeinstalować nvidia-glx:

~~~  
apt-get install --reinstall nvidia-glx  
~~~

Nowy sterownik nvidia do Debian sid staje się dostępny przez:

~~~  
m-a a-i nvidia-kernel-source  
apt-get install --reinstall nvidia-glx  
~~~

Zrestartuj PC aby instalacja modułów odniosła skutek.

#### Schemat nazewnictwa dla sterowników legacy nvidia w Debianie 

+ nvidia-kernel-legacy-71xx dla GeForce 2  
+ nvidia-kernel-legacy-96xx dla GeForce 4  
+ nvidia-kernel-legacy-173xx dla GeForce 5  

##### Przykład za pomocą starszych sterowników 3D nvidia legacy &le; GeForce 5xxx :

Dla innych sterowników wymien 173xx numer z numerem sterownika. 

~~~  
m-a a-i nvidia-kernel-legacy-173xx-source && apt-get install nvidia-glx-legacy-173xx dmakms  
~~~

Zmieniaj dmakms:

~~~  
echo nvidia-kernel-legacy-173xx-source >> /etc/default/dmakms  
~~~

Po aktualizacji xorg trzeba tylko zainstalować nvidia-glx-legacy:

~~~  
apt-get install --reinstall nvidia-glx-legacy-173xx  
~~~

#### Błąd załadowania Modułu

Jeżeli z jakiejkolwiek przyczyny nie uda się załadować modułu nvidii:

~~~  
modprobe nvidia  
~~~

Potem zrestartuj komputer.

Gdyby moduł się nadal nie ładował:

~~~  
m-a a-i -f nvidia-kernel-source  
~~~

lub

~~~  
m-a a-i -f nvidia-kernel-legacy-173xx-source  
~~~

To spowoduje odbudowanie modułu. `Zrestartuj komputer.` 

Czytaj:

~~~  
$ /usr/share/doc/dmakms  
~~~

<div id="rev">Strona ostatnio modyfikowana 21/11/2011 0815 UTC </div>
