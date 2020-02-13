<div id="main-page"></div>
<div class="divider" id="apt-cook"></div>
## Mały przewodnik po APT

### Co oznacza APT?

APT to skrót z Advanced Packaging Tool (Zaawansowane Narzędzie Pakietów) i jest zbiorem programów i skryptów, które pomagają w instalacji i zarządzaniu plikami deb, oraz pozwalają sprawdzić, co zostało zainstalowane.

<div class="divider" id="sources-list"></div>
## Lista źródeł (Sources List)

 System "APT" wymaga pliku konfiguracyjnego, który zawiera informacje o lokacjach pakietów do zainstalowania/zaktualizowania - zwykle jest to `sources.list` .

 Źródła znajdują się w kartotece lub katalogu nazwanym:  
`/etc/apt/sources.list.d/` 

W katalogu znajdują się 2 pliki:  
`/etc/apt/sources.list.d/debian.list`  and  
`/etc/apt/sources.list.d/siduction.list` 

Dzięki temu jest łatwiej (automatycznie) zmienić serwer lustrzany i bezpieczniej zmieniać listy.

Możesz też dodać swoje własne pliki `/etc/apt/sources.list.d/*.list` 

### Wszystkie ISO siductiona używają następujących źródeł:

~~~  
#siduction  
# Free University Berlin/ spline (Student Project LInux NEtwork), Germany  
deb ftp://ftp.spline.de/pub/siduction/debian/ sid main fix.main  
#deb-src ftp://ftp.spline.de/pub/siduction/debian/ sid main fix.main  
~~~

Dalsze wpisy, jeśli potrzebujesz oprogramowania o zamkniętych źródłach, znajdują się w naszym, zawsze aktualnym,  [siduction.list](http://siduction.org/files/misc/sources.list.d/siduction.list)  and  [debian.list](http://siduction.org/files/misc/sources.list.d/debian.list) :

~~~  
#Debian  
# Unstable  
deb http://ftp.us.debian.org/debian/ unstable main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ unstable main contrib non-free  
# Testing  
#deb http://ftp.us.debian.org/debian/ testing main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ testing main contrib non-free  
# Experimental  
#deb http://ftp.us.debian.org/debian/ experimental main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ experimental main contrib non-free  
~~~

UWAGA: W tym przypadku ftp.us wskazuje na to, że użyte są niemieckie repozytoria. Możesz edytować ten plik jako root, aby użyć repozytoriów najbliższych twojej lokalizacji, poprzez zmianę kraju, np. zmieniając ftp.us to ftp.pl, lub ftp.uk. Większość krajów ma swoje lokalne mirrory. Pasmo jest oszczędzane, prędkość ulega poprawie.

 [List of Debian Servers and mirrors current status](http://www.debian.org/mirrors/) .

Aby uzyskać zaktualizowaną informację o pakietach, APT używa bazy danych. Baza ta zawiera pakiety, ale również informacje o innych pakietach potrzebnych do zainstalowania określonego pakietu (nazywa się to zależnościami). Program apt-get używa tej bazy danych, kiedy instaluje wybrane przez ciebie pakiety, aby rozwiązać wszystkie zależności i przez to zagwarantować, że wybrane pakiety będą działać. Aktualizacja bazy jest wykonywana przez polecenie apt-get update.

~~~  
# apt-get update  
(which returns)  
Get:1 http://siduction.org sid Release.gpg [189B]  
Get:2 http://siduction.org sid Release.gpg [189B]  
Get:3 http://siduction.org sid Release.gpg [189B]  
Get:4 http://ftp.de.debian.org unstable Release.gpg [189B]  
Get:5 http://siduction.org sid Release [34.1kB]  
Get:6 http://ftp.de.debian.org unstable Release [79.6kB]  
~~~

<div class="divider" id="apt-install"></div>
## Instalacja nowego pakietu

**`Aktualizacja pakietów i instalacja nowych pakietów bez zatrzymywania X (środowiska graficznego) może powodować problemy. Każda metoda instalowania pakietów przy działających X-ach może spowodować problemy.`** 

**`Tak długo, jak dowolny pakiet, który chcesz zainstalować nie powoduje aktualizacji dodatkowych pakietów, bezpiecznym jest jego instalowanie bez zatrzymywania X-ów. Jednak w przypadku, gdy instalacja pakietu spowoduje aktualizację innych pakietów, ekstremalna ostrożność jest zalecana i jeśli nie masz pewności, że pakiety, które będą aktualizowane nie są obecnie w użyciu, należy zatrzymac środowisko graficzne (X) przed instalacją.`** 

**`Jeśli maszjakiekolwiek wątpliwości opuść X-y zgodnie z instrukcją aktualizacji dystrybucji przed zainstalowaniem jakichkolwiek pakietów.  [Upgrade an Installed System - dist-upgrade - The Steps](sys-admin-apt-pl.htm#du-st)`**  .

Zakładając, że baza danych APT jest aktualna i znana jest nazwa pakietu, następujące polecenie zainstaluje pakiet qemu i wszystkie jego zależności: (dalej dowiesz się jak szukać pakietów.)

~~~  
# apt-get install qemu  
Reading package lists... Done  
Building dependency tree... Done  
The following extra packages will be installed:  
bochsbios openhackware proll vgabios  
Recommended packages:  
debootstrap vde  
The following NEW packages will be installed:  
bochsbios openhackware proll qemu vgabios  
0 upgraded, 5 newly installed, 0 to remove and 20 not upgraded.  
Need to get 4152kB of archives.  
After unpacking 11.9MB of additional disk space will be used.  
Do you want to continue [Y/n]? n  
~~~

<div class="divider" id="apt-delete"></div>
## Usuwanie pakietu

Podobnie nie powinno dziwić, że następujące działanie odinstaluje pakiet, jednak nie usunie zależności: 

~~~  
apt-get remove gaim  
~~~

~~~  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim gaim-irchelper  
0 upgraded, 0 newly installed, 2 to remove and 310 not upgraded.  
Need to get 0B of archives.  
After unpacking 4743kB disk space will be freed.  
Do you want to continue [Y/n]?  
(Reading database ... 174409 files and directories currently installed.)  
Removing gaim-irchelper ...  
Removing gaim ...  
~~~

W tym przypadku pliki konfiguracyjne pakietu 'gaim' nie zostały usunięte z systemu. Mógłbyś je wykorzystać, kiedy zainstalujesz ten sam pakiet ponownie i będzie wtedy działał z zachowanymi ustawieniami.

Jeśli chcesz usunąć także pliki konfiguracyjne, wykonaj polecenie:

~~~  
apt-get --purge remove gaim  
~~~

~~~  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim  
0 upgraded, 0 newly installed, 1 to remove and 309 not upgraded.  
Need to get 0B of archives.  
After unpacking 4678kB disk space will be freed.  
Do you want to continue [Y/n]? Y  
(Reading database ... 174405 files and directories currently installed.)  
Removing gaim ...  
Purging configuration files for gaim ...  
~~~

Zauważ `*`  po nazwie pakietu w komunikacie wyjściowym apta. Gwiazdka w komunikacie wyjściowym apta wskazuje, że pliki konfiguracyjne będą także usunięte.

<div class="divider" id="apt-downgrade"></div>
## Instalacja starszej wersji pakietu

Czasem może być konieczne przywrócenie wcześniejszej wersji pakietu, ze względu na poważny błąd w ostatniej wersji, którą zainstalowałeś. 

### Wstrzymanie instalacji/aktualizacji pakietu (Hold)

~~~  
echo package hold|dpkg --set-selections  
~~~

Aby wyłączyć pakiet ze wstrzymania

~~~  
echo package install|dpkg --set-selections  
~~~

Listowanie pakietów zatrzymanych:

~~~  
dpkg --get-selections | grep hold  
~~~

### Cofnięcie do starszej wersji (Downgrading)

 **`Debian nie wspiera pakietów cofniętych do starszych wersji. Choć mogą one działać w niektórych przypadkach, mogą jednak być całkowicie błędne dla innych pakietów . Zobacz także`**  [Cofanie pakietów do starszych wersji w stanach zagrożenia](http://www.debian.org/doc/manuals/reference/ch02.en.html#_emergency_downgrading) .

Pomijając fakt, że to nie jest wspierane, cofanie pakietów do starszych wersji działa dla prostych pakietów. Oto kroki dla cofania pakietów do starszych wersji za pomocą `kmahjongg`  podane jako przykład:

1. zakomentuj źródła z gałęzi niestabilnej w `/etc/apt/sources.list.d/debian.list`  za pomocą `#`   
2. Dodaj zródła z gałęzi testowej w `/etc/apt/sources.list.d/debian.list` , przykładowo:  
   ~~~    
   deb http://ftp.nl.debian.org/debian/ testing main contrib non-free    
   ~~~
  
3. ~~~    
   apt-get update    
   ~~~
  
4. ~~~    
   apt-get install kmahjongg/testing    
   ~~~
  
5. Uczyń nowo zainstalowany pakiet wstrzymanym za pomocą:  
   ~~~    
   echo kmahjongg hold|dpkg --set-selections    
   ~~~
  
6. Zakomentuj za pomocą &lt;#&gt; źródła gałęzi testowej w /etc/apt/sources.list.d/debian.list i odkomentuj źródła niestabilne, co pozwoli wrócić do ich używania, a potem:  
7. ~~~    
   apt-get update    
   ~~~
  

Kiedy będziesz chciał zainstalować najnowszą wersję pakietu, wykonaj polecenie:

~~~  
echo kmahjongg install|dpkg --set-selections  
apt-get update  
apt-get install kmahjongg  
~~~

<div class="divider" id="apt-mark"></div>
## apt-mark

apt-mark is a useful tool that shows you which packages are automatically or manually installed and offers the system administrator the opportunity to mark and hold packages that are not to be removed automatically. Read:

~~~  
man apt-mark  
~~~

<div class="divider" id="apt-upgrade"></div>
## Aktualizacja zainstalowanego systemu - dist-upgrade - Przegląd

Aktualizację całego systemu osiągamy przez `dist-upgrade` . Trzeba koniecznie sprawdzić Bieżące Ostrzeżenia (Current Warnings) na stronie głównej  [siductiona](http://siduction.org) , i sprawdzić ostrzeżenia dotyczące pakietów, które system chce aktualizować. Jeśli zechcesz wstrzymać (`hold` ) pakiet zajrzyj pod  [Wstrzymywanie i Downgrade pakietów (cofanie do starszych wersji)](sys-admin-apt-pl.htm#apt-downgrade) 

W "debianie sid" wykonanie tylko "upgrade'u" nie jest zalecane.

##### Częstość wykonywania dist-upgrade

Wykonuj dist-upgrade rutynowo, tak jak możesz, najlepiej raz na tydzień lub dwa, a dla bezpieczeństwa co najmniej jeden raz na miesiąc. Wykonywanie dist-upgrade tylko co 2 lub 3 miesiące powinno być uważane jako wykonywane poza bezpieczną granicą. W przypadku niestandardowych pakietów, lub skompilowanych samodzielnie, musisz być bardziej ostrożny przy aktualizacji, gdyż mogą one zepsuć system w dowolnym momencie z powodu niezgodności.

Po aktualizacji bazy danych, można sprawdzić, które pakiety mają nowszą wersję: (najpierw zainstaluj apt-show-versions)

~~~  
apt-show-versions -u  
libpam-runtime/unstable upgradeable from 0.79-1 to 0.79-3  
passwd/unstable upgradeable from 1:4.0.12-5 to 1:4.0.12-6  
teclasat/unstable upgradeable from 0.7m02-1 to 0.7n01-1  
libpam-modules/unstable upgradeable from 0.79-1 to 0.79-3.........  
~~~

Aktualizacja pojedynczego pakietu łącznie z jego zależnościami może być wykonana przy pomocy: (na przykładzie gcc-4.0)

~~~  
apt-get install gcc-4.0  
Reading package lists... Done  
Building dependency tree... Done  
gcc-4.0 is already the newest version.  
0 upgraded, 0 newly installed, 0 to remove and xxx not upgraded  
~~~

#### Wykonywanie tylko ściągania pakietów

`Mniej znana i wspaniałą opcją dla sprawdzenia, które pakiety podlegają dist-upgrade jast flaga -d:`

~~~  
apt-get update && apt-get dist-upgrade -d  
~~~

-d pozwala na pobranie aktualizacji bez konieczności instalowania go, gdy jesteśmy w środowisku graficznym (X) w konsoli i pozwala na wykonywanie dist-upgrade w init 3 w terminie późniejszym. To również pozwala, na sprawdzenie listy ostrzeżeń, daje też możliwość, aby kontynuować lub anulować proces

~~~  
apt-get dist-upgrade -d  
Reading package lists... Done  
Building dependency tree  
Reading state information... Done  
Calculating upgrade... Done  
The following NEW packages will be installed:  
elinks-data  
The following packages have been kept back:  
git-core git-gui git-svn gitk icedove libmpich1.0ldbl  
The following packages will be upgraded:  
alsa-base bsdutils ceni configure-ndiswrapper debhelper  
discover1-data elinks file fuse-utils gnucash.........  
35 upgraded, 1 newly installed, 0 to remove and 6 not upgraded.  
Need to get 23.4MB of archives.  
After this operation, 594kB of additional disk space will be used.  
Do you want to continue [Y/n]?Y   
~~~

`Y`  pobierze nowsze wersje pakietów bez ich instalowania.

Po wykonaniu 'dist-upgrade -d', gdy chcesz dokończyć dist-upgrade, natychmiast lub w późniejszym terminie, postępuj według tych instrukcji:

<div class="divider" id="du-st"></div>
### dist-upgrade - Kolejne kroki

<div class="box block">
**NIGDY nie wykonuj dist-upgrade lub upgrade podczas sesji X<div class="highlight-4"> Zawsze sprawdzaj bieżące ostrzeżenia na głównej stronie  [siduction.org](http://siduction.org) . Ostrzeżenia te są ze względu na niestabilną naturę dystrybucji i są aktualizowane codziennie.**

~~~  
Wyloguj się z KDE.  
Przejdź do trybu tekstowego poprzez Ctrl+Alt+F1  
zaloguj się jako root, a następnie wpisz init 3  
apt-get update  
apt-get dist-upgrade  
apt-get clean  
init 5 && exit  
~~~

**NIGDY nie wykonuj DIST-UPGRADE [lub UPGRADE] przy pomocy adept, synaptic lub aptitude  [PATRZ Aktualizacja zainstalowanego systemu](sys-admin-apt-pl.htm#apt-upgrade) :**


---

**`Jeśli nie przechodzisz do trybu init 3, możesz spowodować duże problemy!`**

<div class="divider" id="whyno"></div>
#### Powody, dla których powinieneś używać tylko apt-get do dist-upgrade

Menadżery pakietów takie jak adept, aptitude, synaptic i kpackage nie zawsze są w stanie wziąć pod uwagę wielkiej ilości zmian, która ma miejsce w Sidzie (zmiany zależności, zmiany nazw, zmiany skryptów, ...). 

Nie jest to jednak wina twórców tych narzędzi, piszą oni wspaniałe programy, które świetnie działają w stabilnej gałęzi debiana, nie są one po prostu odpowiednie dla specjalnych potrzeb Debiana Sid.

Używaj, czego chcesz, do wyszukiwania pakietów, ale pozostań przy apt-get do właściwego instalowania/usuwania/aktualizacji.

Menadżery pakietów takie jak adept, aptitude, synaptic i kpackage nie są przewidywalne (w przypadu kompleksowego wyboru pakietów). Połącz to z szybko poruszającym się celem, jakim jest sid, i nawet gorszymi zewnętrznymi repozytoriami o kwestionowanej jakości (nie używamy ich, ani nie polecamy, ale są rzeczywistością na systemach użytkowników), a będziesz zabiegał o katastrofę. 

<!--Inną kwestią jest to, że wszystkie te graficzne menadżery pakietów muszą działać w X, a wykonywanie dist-upgrade w X (lub nawet 'upgrade' co jest niezalecane) może zakończyć się uszkodzeniem twojego systemu bez możliwości naprawy, może nie dziś lub jutro, ale w dalszej przyszłości.

-->
The other item to note is that all of these types of GUI package managers need to run in in X, and in doing a dist-upgrade in X, (or even an 'upgrade' which is not recommended), you will end up damaging up your system beyond repair, maybe not today or tomorrow, however in time you will.

Z drugiej strony apt-get robi dokładnie to, o co jest proszony, jeśli następuje awaria możesz ją zlokalizować i znaleźć komunikaty o błędach/naprawić je, jeśli apt-get chce usunąć połowę systemu (z powodu zmian w bibliotekach) jest czas na reakcję administratora (czyli ciebie).

To jest powód, dla którego deweloperzy debiana używają apt-get, a nie inne menadżery pakietów.

<div class="divider" id="apt-cache"></div>
## Szukanie pakietu przy pomocy apt-cache

Innym bardzo użytecznym poleceniem systemu APT jest apt-cache; wyszukuje w bazie APT i pokazuje informacje o pakietach; np. listę wszystkich pakietów, które zawierają słowo "siduction" i "manual" otrzymuje się przez:

~~~  
$ apt-cache search siduction manual  
.......  
siduction-manual-common - the official siduction manual - common files  
siduction-manual-es - the official Spanish siduction manual  
siduction-manual-de - the official German siduction manual  
siduction-manual-el - the official Greek siduction manual  
siduction-manual - the official siduction manual - all languages  
siduction-manual-pt-br - the official Brazilian Portuguese siduction manual  
siduction-manual-en - the official English siduction manual  
siduction-manual-reader - siduction manual reader  
~~~

Jeśli chcesz więcej informacji o określonym pakiecie, możesz użyć:

~~~  
$ apt-cache show siduction-manual-en  
Package: siduction-manual-en  
Priority: optional  
Section: doc  
Installed-Size: 1088  
Maintainer: Kel Modderman <kel@otaku42.de>  
Architecture: all  
Source: siduction-manual  
Version: 01.12.2007.06.03-1  
Depends: siduction-manual-common  
Filename: pool/main/s/siduction-manual/siduction-manual-en_01.12.2007.06.03-1_all.deb  
Size: 391222  
MD5sum: 60f2175c3c5709745a4b4256ccc3c49d  
SHA1: e275a0b27628b6aa210a4ced48d3646b438e78b8  
SHA256: 2792580c7a091521301064180a1d0d8901f0a4af407b90432b9f8d8b6b3603ca  
Description: the official en siduction manual  
This manual is divided into common sections, for example, .......  
~~~

Wszystkie wersje pakietu, które można zainstalować (zależą do twojego sources.list) można wyświetlić poprzez wpisanie:

~~~  
$ apt-cache policy siduction-manual-en  
siduction-manual-en:  
Installed: (none)  
Candidate:01.12.2007.06.03-1  
Version table:  
01.12.2007.06.03-1 0  
500 http://siduction.org sid/main Packages  
~~~

 [Pełny opis systemu APT można znaleźć w APT-HOWTO](http://www.debian.org/doc/user-manuals#apt-howto)  

<div class="divider" id="gui-pacsea"></div>
## Aplikacja graficzna do wyszukiwania pakietów - Debian Package Search GUI

~~~  
apt-get update  
apt-get install packagesearch  
~~~

Kiedy po raz pierwszy uruchamiasz Debian Package Search potrzebujesz ustawić Packagesearch>Ustawienia do użycia `apt-get` .

**`Nie używaj Packagesearch do instalacji pakietów, używaj jej tylko jako graficznej nakładki do silnika wyszukiwania. Aktualizacja i instalacja nowych pakietów bez zatrzymania X-ów powoduje problemy. Czytaj  [Instalacja nowych pakietów](sys-admin-apt-pl.htm#apt-install) .`** 

Na wstępie używania możesz być zachęcony do instalacji deborphan. Postępuj w uwagą.

Szukanie może być wykonywane według

+ wzorca  
+ tagów (na bazie systemu debtagów, nowego sposobu kategoryzacji pakietów Debiana)  
+ plików  
+ statusu zainstalowania  
+ pakietów osieroconych  

Dodatkowo, wyświetlane są informacje na temat pakietów, w tym pliki należące do nich. Proszę przeczytać Pomoc>Zawartość dla pełnego wyjaśnienia, w jaki sposób korzystać z graficznej (GUI) aplikacji do szukania pakietów Debiana. W tej chwili GUI jest tylko w języku angielskim.

 [Kompletny opis systemu APT można znaleźć w APT-HOWTO](http://www.debian.org/doc/manuals/apt-howto/)  

<div id="rev">Strona ostatnio modyfikowana 18/12/2011 1055 UTC</div>
