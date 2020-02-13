<div id="main-page"></div>
<div class="divider" id="cd-content"></div>
## Zawartość ISO

`Na płycie siduction live-ISO znajduje się tylko otwarte oprogramowanie w sensie dfsg.  [Pod tym adresem można uzyskać dodatkowe informacje o nie-wolnych źródłach firmware.](nf-firm-pl.htm#non-free-firmware) `

ISO jest całkowicie oparte na Debianie Sid (aktualne wydanie na 2011-12-21) wzbogacone i ustabilizowane przy pomocy własnych pakietów i skryptów stworzonych specjalnie dla siduction. Jądro bazuje na najnowszym jądrze Vanilla Mainline Kernel. ACPI i DMA są włączone domyślnie.

`Kompletny plik manifestu każdej opublikowanej wersji siduction można znaleźć na każdym serwerze lustrzanym:`  [Serwery lustrzane, Pobieranie, i wypalanie siduction](cd-dl-burning-pl.htm#download-siduction) .

<div class="divider" id="release-vari"></div>
## Rodzaje, odmiany ISO 

Siduction oferuje 6 odmian aktualnych live-ISO, będących wstępem do Debian Sid. Instalacja nie zajmuje zazwyczaj 1 - 10 minut (zależnie od sprzętu komputerowego).

###### Te odmiany to :

1.  **KDE 32 bit** , live-ISO, około 1 GByte:  
   zawiera wybrany zestaw aplikacji do KDE4 desktop. Dodawanie aplikacji jest łatwe i realizowane poprzez apt.  
2.  **KDE 64 bit** , live-ISO, około 1 GByte:  
   zawiera wybrany zestaw aplikacji do KDE4 desktop. Dodawanie aplikacji jest łatwe i realizowane poprzez apt.  
3.  **XFCE 32 bit** , live-ISO, około 800MB:  
   zawiera pełnowartościowy środowisko graficzne (to nie jest wersja minimalna), i posiada wszystkie programy gotowe do produktywnego zastosowania. Potrzebuje mniej zasobów systemowych niż KDE4.  
4.  **XFCE 64 bit** , live-ISO, około 800MB:  
   zawiera pełnowartościowy środowisko graficzne (to nie jest wersja minimalna, i posiada wszystkie programy gotowe do produktywnego zastosowania. Potrzebuje mniej zasobów systemowych niż KDE4.  
5.  **LXDE 32 bit**  live-ISO, około 700MByte:  
   zawiera mały zestaw aplikacji GTK. Potrzebuje mniej zasobów systemowych niż XFCE  
6.  **LXDE 64 bit**  live-ISO, około 700MByte:  
   zawiera mały zestaw aplikacji GTK. Potrzebuje mniej zasobów systemowych niż XFCE  

 [Programy i narzędzia](cd-content-pl.htm#apps-tools) 

<div class="divider" id="system-requirements"></div>
## Minimalne wymagania systemowe dla KDE4, XFCE i LXDE

### AMD64

##### Procesor:

+ AMD64  
+ Intel Core2  
+ Intel Atom 330  
+ jakikolwiek x86-64/ EM64T lub nowszy  
+ nowsze 64 bitowe AMD Sempron oraz Intel Pentium 4 CPUs (zobacz znaczniki tzw. flagi "lm" w /proc/cpuinfo lub użyj inxi -v3).  

##### Wymagania RAM:

+  **KDE:** &ge;512MByte RAM (&ge;1 GByte RAM zalecane), &ge;1 GByte RAM dla liveapt.  
+  **XFCE:**  &ge;512 MByte RAM.  
+  **LXDE:**  &ge;512 MByte RAM.  
+  **KDE:**  &ge;512MByte RAM (&ge;1 GByte RAM zalecane), &ge; 1GByte RAM dla liveapt.  
+  **XFCE:**  &ge;512MByte RAM.  

+ Karta graficzna VGA o rozdzielczości co najmniej 640x480 pikseli.  
+ Napęd optyczny lub nośnik na USB.  
+ &ge;4 GByte HDD wolnego miejsca, &ge;10 GByte zalecane.  

### i686

##### Procesor:

+ Intel Pentium pro/ Pentium II  
+ AMD K7 Athlon (nie K5/K6)  
+ Intel Atom N-270/230  
+ VIA C3-2 (Nehemiah, nie C3 Samuel lub Ezra)/C7  
+ jakikolwiek x86-64/ EM64T lub nowszy  
+ wymagana pełna obsługa rozkazów i686.  

##### Wymagania RAM:

+  **KDE:** &ge;512MByte RAM (&ge;1 GByte RAM zalecane), &ge;1 GByte RAM dla liveapt.  
+  **XFCE:**  &ge;512 MByte RAM.  
+  **LXDE:**  &ge;512 MByte RAM.  

+ Karta graficzna VGA o rozdzielczości co najmniej 640x480 pikseli.  
+ Napęd optyczny lub nośnik na USB.  
+ &ge;3 GByte HDD wolnego miejsca, &ge;10 GByte zalecane.  

<div class="divider" id="apps-tools"></div>
## Aplikacje i narzędzia

Siduction-ISO zawiera wiele różnych programów i narzędzi, które pokrywają prawie każdą potrzebę użytkownika w codziennej pracy z komputerem.

Wybór z 2 dużych środowisk graficznych do uruchamiania programów:  
 [KDE4 (en + de),](http://www.kde.org/)  menedżer pulpitu z najwyższej półki  
 [Xfce4 (en + de),](http://www.xfce.org/)  obszerny menedżer pulpitu (średnie wymagania) 

 [LXDE (en + de)](http://www.lxde.org/)  lekki menedżer pulpitu (małe wymagania)
 [Fluxbox (en + de)](http://fluxbox.org/)  jest dodany do powyższych odmian jako opcjonalny menedżer pulpitu o niewielkich wymaganiach. 

Do przeglądania internetu, w zależności od wersji, można wybierać pomiędzy  [Konqueror](http://www.konqueror.org/)  i  [iceweasel](http://www.mozilla.com/)  lub  [midori](http://www.twotoasts.de/index.php?/pages/midori_summary.html/) .

Jako programy biurowe w XFCE / LXDE jest preinstalowane Abiword i Gnumeric - jako menedżery plików Dolphin, Thunar i PCManFM.

Do konfiguracji sieci i połączenia internetowgo istnieją do wyboru  [Ceni](inet-ceni-pl.htm#netcardconfig)  , do WIFI zobacz dokumentację  [WIFI Roaming](inet-wpagui-pl.htm) .

Informacje o zamkniętych sterownikach znajdziesz  [tutaj](nf-firm-pl.htm#non-free-firmware) .

Do partycjonowania twardego dysku wprowadziliśmy  [cfdisk](part-cfdisk-pl.htm#disknames)  i  [GParted](http://gparted.sourceforge.net/) , który ma możliwość zmiany wielkości partycji ntfs.

Narzędzie diagnostyczne  [Memtest86+](http://www.memtest.org/) , zaawansowane narzędzie diagnostyki pamięci, także jest dostarczone.

`Wszystkie warianty ISO zawierają pełny zestaw narzędzi uruchamianych z linii poleceń. Kompletny plik manifestu każdej opublikowanej wersji siduction można znaleźć na każdym serwerze lustrzanym`  [Serwery lustrzane, Pobieranie, i wypalanie siduction](cd-dl-burning-pl.htm#download-siduction) .

##### Oświadczenie o zrzeczeniu się odpowiedzialności:

To jest oprogramowanie eksperymentalne. Korzystasz z niego na własne ryzyko. Projekt siduction, jego twórcy i członkowie zespołu nie mogą być pociągnięci do odpowiedzialności w żadnych okolicznościach za zniszczenie sprzętu i oprogramowania, utratę danych lub inne bezpośrednie lub pośrednie szkody powstałe w wyniku użycia tego oprogramowania. Jeśli nie zgadzasz się z tymi warunkami, nie wolno ci używać tego oprogramowania, ani dalej go dystrybuować. 

<div id="rev">Strona ostatnio modyfikowana 24/01/2012 2000 UTC</div>
