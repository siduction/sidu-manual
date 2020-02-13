<div id="main-page"></div>
<div class="divider" id="kern-upgrade"></div>
## Instalacja nowych jąder (kerneli)

##### `Jądra (Kerneli) siduction są w repozytorium siduction jako .deb i są automatycznie ustępowane podczas aktualizacji systemu.` 


---

Następującą jądra są dostępne: 

+  **siduction-686**  - jądra dla rodziny z i686-procesorów z Single/Dual/Multi Core procesorów  
+  **siduction-amd64**  - jądra dla 64 bit siduction  

##### Kroki aktualizacji jądra bez aktualizacji systemu (dist-upgrade): 

 **1.**  Zaktualizuj pakietów jako root: 

~~~  
apt-get update  
~~~

 **2.**  Instalacja najnowszego jądra: 

~~~  
apt-get install linux-image-siduction-686 linux-headers-siduction-686  
~~~

Uruchom ponownie komputer, aby załadować nowe jądro. 

`Jeśli z nowym jądrem masz problemy, możesz ponownie uruchomić starszym jądrem.` 

##### Moduły

Aby dowiedzieć się, które moduły są potrzebne - te polecenie daje aktualną listę dostępnych modułów - kopiuj tej linii do konsoli / terminala:

~~~  
apt-cache search 2.6.*.slh.*-siduction| awk '/modules/{print $1}'  
~~~

Aby uzyskać pełny opis każdego modułu, skopiuj tej linii do konsoli / terminala: 

~~~  
apt-cache search 2.6.*.slh.*-siduction  
~~~

Tak zainstalować potrzebne moduły (na przykład virtualbox-ose i qc-usb):

~~~  
apt-get install virtualbox-ose-modules-2.6.24-2.6.24.2.slh.7-siduction-686 (to przykład)  
apt-get install qc-usb-modules-2.6.24-2.6.24.2.slh.7-siduction-686 (to przykład)  
~~~

Tak się sprawdza, jakie moduły są załadowane do jądra (kernel): 

~~~  
ls /sys/module/  
lub  
cat /proc/modules  
~~~

<div class="divider" id="dmakms"></div>
## Instalacja modułów z Dynamic Module-Assistant Kernel Module Support (dmakms)

dmakms jest bardzo przydatne do instalowania modułów jądra, dla których nie istnieją skompilowane moduły. Ten program automatyzuje instalację modułów jądra z module-assistant `(m-a)`  przy aktualizacji jądra. 

~~~  
apt-get install dmakms module-assistant  
~~~

Przed uaktywnieniem 'Dynamic Kernel Module Support Assistant Module', trzeba wymagane moduły jądra za pomocą module-assistant dla aktualnie działającego jądra zainstalować. Więcej informacji można znaleźć na stronie informacji (man) od module-assistant: 

~~~  
man m-a  
~~~

Nazwa pakietu kompatybilny z module-assistant muszi być wpisywany do pliku konfiguracyjnym `/etc/default/dmakms` , aby przygotowanie i zainstalowanie modułów dla każdego nowego jądra linuksa jest zautomatyzowane. 

#### Przykład: Instalacja `modułu speakup`  z module-assistant

Zapewniaj, że `contrib non-free`  w liście źródeł `/etc/apt/sources.list.d/debian.list`  jest wpisywane. 

~~~  
apt-cache search speakup-s  
speakup-source - Source of the speakup kernel modules  
~~~

Przygotowanie modułu: 

~~~  
m-a prepare  
m-a a-i speakup-source  
~~~

Następnie należy aktywować Dynamic Kernel Module Support Module Assistant dla speakup, aby przy następnej aktualizacji jądra moduł speakup również będzie przygotowane - bez własnego wkraczania. Trzeba dodać `speakup-source`  do pliku konfiguracyjnego `/etc/default/dmakms` . 

~~~  
mcedit /etc/default/dmakms  
speakup-source  
~~~

Powtórz ten sam proces dla każdy inny moduł jądra, który jest zgodny z module-assistant.

Linux-headers muszą być zainstalowane odpowiednymi obrazami linux (Linux-Image), aby module-assistand mógł kompilować moduły jądra.

#### Jeśli moduł nie ładuje 

Jeśli moduł nie ładuje, z jakiejkolwiek przyczyny [nowy składnik-Xorg lub z innego powodu]:

~~~  
modprobe <module>  
~~~

Następnie zrestartuj komputer.

Jeśli po restarcie nadal nie załadowuje modułu:

~~~  
m-a a-i -f module-source  
~~~

To rekompiluje moduł - `ponownie zrestartuj komputer.` 

##### Jak to działa

Dynamic Module-Assistant Kernel Module Support składa się ze skryptu init (/etc/init.d/dmakms) który jest aktywowany przy starcie systemu lub ze skryptu przy instalacji nowego obrazu Linux (Linux-Image).

/etc/init.d/dmakms działa w czasie każdego uruchomienia, aby każdego modułu źródłowego w liście /etc/default/dmakms ocenić na aktualnoć i ewentualnie skompilować i zainstalować go.

Kiedy nowy obraz linuksa będzie zainstalowany, zostanie /etc/init.d/dmakms za pomocą 'postinst' z dwoma argumentami ('start' oraz 'version string' tego jądra linux) uruchomiony, aby przygotować nowych modułów jądra. Pakiety (moduły) z /etc/default/dmakms zostaną kompilowane przez module-assitant i zostaną przy następnego wyłączenia zainstalowane. `Powodem, dlaczego instalacja jest wykonywana podczas wyłączania, jest to, ponieważ w tym czasie apt/dpkg pewnością nie jest zajęte przez inne procesy` .

~~~  
$ /usr/share/doc/dmakms  
~~~

<!--</div>
<div class="divider" id="other-kern-inst"></div>
## Other kernel installation methods

##### siductioncc

You can also install kernels with the GUI control centre [siductioncc:](siductioncc-pl.htm) which is located in the KDE-Start-Menu>System>siduction Control Centre. siductioncc also offers several other system administration GUI applications

-->
<div class="divider" id="kern-remove"></div>
## Usuwanie starych jąder (kernel remover)

Po zainstalowaniu nowego jądra, starsze jądra mogą być usunięte. Jednak utrzymanie starych jąder na kilka dni jest zalecane. Jeśli powstaną problemy z nowym jądrem, można używać starego jądra do uruchomienia, który jest wyświetlane na ekranie GRUB.

Aby usunąć starych jąder, można zainstalować skrypt `kernel-remover` :

~~~  
apt-get update  
apt-get install kernel-remover  
~~~

<div id="rev">Content last revised 15/09/2010 1025 UTC</div>
