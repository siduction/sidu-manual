<div id="main-page"></div>
<div class="divider" id="download-siduction"></div>
## Pobieranie ISO siduction

###### **`BARDZO WAŻNE:`** `siduction, jako dystrybucja Live, oparty jest o technologię wysokiej kompresji plików, i dlatego wymagane jest poświęcenie specjalnej uwagi wypalaniu obrazu ISO. Zaleca się wykorzystywanie jedynie wysokiej jakości nośników CD / DVD+R oraz wypalanie ich w **`trybie DAO (disk-at-once)`**  z prędkością nie większą niż x8.` 


---

###### Proszę wybierz najbliższy serwer lustrzany. Wyszczególnione serwery lustrzane posiadające poniżej ramkę z kodem są uaktualniane tak szybko jak tylko wprowadzone zostają zmiany (odniesienie: /etc/apt/sources.list.d/siduction.list).

#### Europa

+  **Free University Berlin / spline (Student Project LInux NEtwork)** , Niemcy  
    [ftp://ftp.spline.de/pub/siduction/iso](ftp://ftp.spline.de/pub/siduction/iso)   
   rsync://ftp.spline.de/siduction/iso  

~~~  
deb ftp://ftp.spline.de/pub/siduction/base unstable main  
deb ftp://ftp.spline.de/pub/siduction/fixes unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/base unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/fixes unstable main  
~~~

#### Ameryka Północna

+  **`University of Delaware`**   
    [http://mirror.lug.udel.edu/pub/siduction/iso](http://mirror.lug.udel.edu/pub/siduction/iso)   
    [ftp://ftp.lug.udel.edu/pub/siduction/iso](ftp://ftp.lug.udel.edu/pub/siduction/iso) rsync://rsync.lug.udel.edu/siduction/iso  

~~~  
deb ftp://ftp.lug.udel.edu/pub/siduction/base unstable main  
deb-src ftp://ftp.lug.udel.edu/pub/siduction/base unstable main  
deb ftp://ftp.lug.udel.edu/pub/siduction/fixes unstable main  
deb-src ftp://ftp.lug.udel.edu/pub/siduction/fixes unstable main  
~~~

+  **`Georgia Tech`**   
    [http://www.gtlib.gatech.edu/pub/siduction/iso](http://www.gtlib.gatech.edu/pub/siduction/iso)   
    [ftp://ftp.gtlib.gatech.edu/pub/siduction/iso](ftp://ftp.gtlib.gatech.edu/pub/siduction/iso) rsync://rsync.gtlib.gatech.edu/siduction/iso  

#### Ameryka Południowa

+  **`Universidade Estadual de Campinas (unicamp), São Paulo, Brazylia`**   
    [http://www.las.ic.unicamp.br/pub/siduction/iso/](http://www.las.ic.unicamp.br/pub/siduction/iso/)   
    [ftp://www.las.ic.unicamp.br/pub/siduction/iso/](ftp://www.las.ic.unicamp.br/pub/siduction/iso/)   

~~~  
deb ftp://www.las.ic.unicamp.br/pub/siduction/base unstable main  
deb-src ftp://www.las.ic.unicamp.br/pub/siduction/base unstable main  
deb ftp://www.las.ic.unicamp.br/pub/siduction/fixes unstable main  
deb-src ftp://www.las.ic.unicamp.br/pub/siduction/fixes unstable main  
~~~

#### Azja

#### Afryka

#### Australia

<div class="divider" id="siduction-def"></div>
### Definicje plików na serwerach lustrzanych

Każdy z serwerów lustrzanych siduction zawiera następujące pliki:

~~~  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
SOURCES  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.arch.manifest  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.iso  
~~~

Plik `.manifest`  zawiera listę wszystkich pakietów zawartych w iso. 

`.iso`  jest obrazem dysku do ściągnięcia. 

Pliki `.md5 i .sha256`  służą do sprawdzenia sum kontrolnych iso.

Pliki `.gpg`  są plikami sygnatur, umożliwiającymi weryfikację sum kontrolnych (.md5 .sha256) w celu sprawdzenia, czy nie były zmienione oraz do sprawdzenia integralności iso.

Linki i adresy serwerów lustrzanych można znaleźć na stronie domowej  [siduction.org](http://siduction.org/index.php?module=inhalt&amp;func=view&amp;pid=2) .

Jeśli ktoś posiada do dyspozycji szybki serwer FTP i chciałby użyczyć go dla potrzeb siduction.org, proszę o kontakt w  [siduction-Forum](http://siduction.org/)  lub w IRC-Channel irc.oftc.net:6667 #siduction.

<div class="divider" id="md5"></div>
## Suma kontrolna md5sum i sprawdzanie poprawności

###### **`BARDZO WAŻNE:`** `siduction, jako dystrybucja Live, oparty jest o technologię wysokiej kompresji plików, i dlatego wymagane jest poświęcenie specjalnej uwagi wypalaniu obrazu ISO. Zaleca się wykorzystywanie jedynie wysokiej jakości nośników CD / DVD oraz wypalanie ich w **`trybie DAO (disk-at-once)`**  z prędkością nie większą niż x8.` 


---

md5sum jest to suma kontrolna pliku stosowana, aby sprawdzić jego poprawność. md5sum pobranego pliku jest porównywana z ze znaną sumą kontrolną np. podaną przez twórcę pliku. W ten sposób można potwierdzić poprawność pliku, sprawdzić, że nie został uszkodzony lub zmieniony; zaleca się takie działanie dla wszystkich plików pobieranych z internetu.

Jeśli suma md5 pobranego pliku odpowiada tej w plik.md5, możesz być pewien, że plik został pobrany poprawnie. Pod linuksem otrzymasz sumę kontrolną przy pomocy tego polecenia (operacja może potrwać chwilę):

~~~  
$ md5sum plik_do_sprawdzenia  
~~~

Suma kontrolna będzie wyświetlona w konsoli. Można ją sprawdzić ręcznie z sumą z pliku *.md5 przy pomocy editora. Przy pomocy md5sum (486 kb) suma kontrolna md5 może być również sprawdzona w Windows.

Łatwiej sprawdzać z poleceniem (w katalogu z plikiem ISO i ISO.MD5):

~~~  
$ md5sum -c plik_do_sprawdzenia.md5  
~~~

Jeśli sumy będą takie same, otrzymasz:

~~~  
md5sum: plik_do_sprawdzenia: ok  
~~~

jeśli nie to:

~~~  
"siduction.iso: Error  
md5sum: Warning: calculated checksum does not match!"  
~~~

Obrazy ISO siduction zawsze udostępniane są z sumami kontrolnymi md5sum i zawsze powinny być sprawdzane przed wypaleniem. 

Zgraj następujące pliki z serwera lustrzanego:

~~~  
siductionname.iso  
siductionname.iso.md5  
~~~

Sprawdzanie przy użyciu SHA256SUM jest podobną metodą. Pocyztaj:

~~~  
man sha256sum  
~~~

<div class="divider" id="burn-nero"></div>
## Wypalanie CD w Windows

###### **`BARDZO WAŻNE:`** `siduction, jako dystrybucja Live, oparty jest o technologię wysokiej kompresji plików, i dlatego wymagane jest poświęcenie specjalnej uwagi wypalaniu obrazu ISO. Zaleca się wykorzystywanie jedynie wysokiej jakości nośników CD / DVD oraz wypalanie ich w **`trybie DAO (disk-at-once)`**  z prędkością nie większą niż x8.` 


---

Oczywiście, możesz również wypalić CD w Windows. Pobrany plik musi być wypalony jako obraz ISO. Jeśli Winrar (lub inne narzędzie archiwizacji) jest skojarzony z plikiem .ISO, może to irytować, ponieważ program ten weźmie plik ISO za archiwum. 

Masz kilka możliwości wypalenia obrazu w Windows.

##### Programy Open Source dla Windows

 [cdrtfe](http://cdrtfe.sourceforge.net/) : kompatybilny z Windows 9x/ME/2000/XP (testowany z Win95, Win98SE, Win2000, WinXP) tylko dla Win9x/ME: działający ASPI Layer (np. Adaptec ASPI 4.60)

 [LinuxLive USB Creator](http://www.linuxliveusb.com) , projekt open source, oferujący interfejs graficzny dla MS Windows&#8482;, który pozwala na instalację siduction-i386.iso (32 bit) na pena USB.

##### Closed Source i komercyjne programy dla Windows

+  Nero (nie Nero Express ! )  
+ Inne dobre narzędzie typu freeware to  [CD/DVD Burner XP Pro.](http://www.cdburnerxp.se/)   
+ Burncdcc od  [terabyteunlimited](http://www.terabyteunlimited.com/utilities.html)  może tylko wypalać pliki ISO.  

<div class="divider" id="burn-linux"></div>
## Wypalanie CD w linuksie

###### **`BARDZO WAŻNE:`** `siduction, jako dystrybucja Live, oparty jest o technologię wysokiej kompresji plików, i dlatego wymagane jest poświęcenie specjalnej uwagi wypalaniu obrazu ISO. Zaleca się wykorzystywanie jedynie wysokiej jakości nośników CD / DVD oraz wypalanie ich w **`trybie DAO (disk-at-once)`**  z prędkością nie większą niż x8.` 


---

Jeśli korzystasz z linuksa na swoim komputerze, powinieneś wypalić CD albo przy pomocy narzędzi działających w trybie tekstowym, albo jednego z zainstalowanych przez ciebie programów w trybie graficznym. W siduction K3b jest domyślnym narzędziem do wypalania CD. Otwórz je, wybierz "Tools" -> "burn CD-Image..." i wybierz plik ISO do wypalenia (np. siduction-2011.1.iso) i tryb wypalenia DAO (disk-at-once).

K3B oblicza sumę kontrolną MD5 dla pliku ISO (to może trwać chwilę). Jeśli obliczona suma jest taka jak w pliku MD5 (np. siductionname.iso.md5), pobranie pliku było udane i możesz wypalić plik poprzez kliknięcie na "Start".

Jeśli klikniesz na obliczoną sumę kontrolną, pojawia się ikona obok. Gdy ponownie klikniesz na ikonę i dodasz w polu sumę kontrolną z pliku MD5 możesz porównywać oba.

`Najczęstsze problemy podczas wypalania płyt dotyczą błędów interfejsu graficznego aplikacji. Z poziomu konsoli również można wypalać dzięki programowi  [burniso](cd-no-gui-burn-pl.htm) .` 

###### Zobacz także  [Zapis siduction na penie USB/SSD za pomocą jakiegokolwiek systemu operacyjnego (Linux, MS Windows lub Mac OS X)](hd-ins-opts-oos-pl.htm#raw-usb) .

<div id="rev">Content last revised 28/01/2012 1900 UTC</div>
