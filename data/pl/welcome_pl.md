<div id="main-page"></div>
<!--[if lt IE 10]><div class="center warning-box data">UWAGA :: Twoja przeglądarka Internet Explorer&#8482; jest przestarzała, zainstaluj  [Firefox od Mozilla Corp&#8482;](http://mozilla.com/)  dla Windows&#8482;. Zauważalne deformacje menu są wynikiem korzystania z przestarzałej przeglądarki, jakimi są MSIE 5 lub 6.</div><![endif]-->
<div class="divider" id="welcome-gen"></div>
## Witamy na stronach instrukcji obsługi systemu operacyjnego siduction(tm); GNU/Linux

##### `Uwaga! Strony podręcznika są tymczasowo opracowywane - gdy są pytania lub problemy prosimy o kontakt w  [IRC](help-pl.htm#irc)  lub poprzez mail do quidam77 małpa web kropka` 

siduction to gra słów z , jest ono nazwą kodową  *niestabilnej gałęzi dystrybucji Debian*  i `seduction`  w sencie  *uwodzenia.* 

siduction jest systemem operacyjnym bazującym na  [jądrze Linuxa](http://www.kernel.org/)  oraz  [projekcie GNU](http://www.gnu.org/) , z aplikacjami/programami z gałęzi  [Debian](http://www.debian.org/)  utrzymującą jej rdzenne wartości,  [umowę społeczną](http://www.debian.org/social_contract)  oraz  [DFSG](http://pl.wikipedia.org/wiki/Wytyczne_Debiana_dotycz%C4%85ce_Wolnego_Oprogramowania)  Debiana.

To oznacza - nie musisz czekać na wyjście wersji co sześź miesięcy. Raz zainstalowany siduction wraz z wybranymi aplikacjami wystarczy. Codzienna, cotygodniowa, comiesięczna aktualizacja systemu powoduje, że twój system i aplikacje są zawsze aktualne.

Warto zauważyć, że siduction używa niestabilnej gałęzi systemu Debian (sid) - i ze względu na jego charakter, musisz być przygotowany na używanie  [Terminalu](term-konsole-pl.htm) .

W ten sposób będziesz miał system zawsze na czasie i będziesz mógł korzystać z najlepszych narzędzi które są wynikiem współpracy siduction z Debian 'sid'.

<div class="divider" id="how-to"></div>
## Jak korzystać z tej instrukcji

`Podręcznik obsługi systemu operacyjnego siduction jest nawiązaniem do zapoczątkowania nauki lub przypomnienia sobie wiadomości o siduction nie tylko w stopniu podstawowym. Swym zasięgiem obejmuje nie tylko podstawowe wiadomości o systemie ale wyczerpuje także wiele kompleksowych zagadnień i pomoże ci w administracji systemu siduction.` 

<div class="divider" id="man-gen"></div>
##### Uwagi ogólne

Instrukcja jest podzielona na popularne działy, np. temat dotyczący partycjonowania znajduje się w dziale Partycjonowanie twardego dysku, a tematy dotyczące Internetu/WIFI są zgrupowane w dziale Internet i sieć.

Aby uzyskać pomoc dotyczącą konkretnych programów bądź aplikacji (nazywanych `pakietami` ) ktore są preinstalowane lub które sam zainstalowałeś, odwiedź na stronie internetowej forum pomocy, FAQ, instrukcje online i/lub wybierz help z menu programu.

Większość dobrych programów oferuje pomoc poprzez wywołanie funkcji `man`  w terminalu. Można również sprawdzić, czy w podanej ścieżce `/usr/share/doc/<nazwa pakietu>`  znajduje sie plik pomocy.

 [Jeśli masz chwilkę czasu to przeczytaj proszę "Szybki start z siduction"](wel-quickstart-pl.htm#welcome-quick) 

 Niektóre tematy nie mogły zostać zgrupowane lub wymagają osobnego omówienia. Jak w każdej nowej dokumentacji także i u nas pojawiają się błędy/pomyłki/literówki. ﻿Proszę nam wybaczyć. Mamy nadzieję, że nie będą to błędy merytoryczne.

W miarę, jak siduction będzie wzrastał, coraz więcej dokumentacji zostanie dodane do instrukcji i jesteśmy pewni że będzie wartościowym źródłem informacji.

Zdecydowaliśmy sie do wsyzstkich użytkownikow zwracać na „ty“ - jak zwykle w scenie linuxowej.

W tym miejscu „Serdecznie witamy!" - dziękujemy również za zainteresowanie siduction.

##### Drukowanie instrukcji

Drukowanie plików instrukcji w formie 'portretu' (orientacja pionowa) nie pozwala na umieszczenie tekstu z ramek z kodem poza granicami marginesów. 

Proszę brać pod uwagę że linuks może zawierać konsolowe komendy do 120 znaków, a zwykle więcej niż może zmieścić typowa strona A4 ustawiona w formie portretu, czcionka 12 pt.

Dlatego ustaw w ustawieniach drukowania orientację poziomą - `Landscape` .

##### Prawa autorskie

Cała zawartośc jest zastrzeżona prawami autorskimi © 2006-2012 i wydana na licencji  [GNU Free Documentation License](http://www.gnu.org/licenses/fdl.txt) . Pozwolenie na kopiowanie, dystrybuowanie i/lub modyfikowanie tego dokumentu jest udzielone na zasadach GNU Free Documentation License, wersja 1.2 lub każdej późniejszej opublikowanej przez Free Software Foundation; bez niezmiennych sekcji, bez tekstów okładek.

Prawa zastrzeżonych markek lub prawa autorskie ﻿są własnością ich właścicieli, niezależnie ﻿czy określone, czy nie.

E&amp;OE

## Oświadczenie o zrzeczeniu się odpowiedzialności:

To jest oprogramowanie eksperymentalne. Korzystasz z niego na własne ryzyko. Projekt siduction, jego twórcy i członkowie zespołu nie mogą być pociągnięci do odpowiedzialności w żadnych okolicznościach za zniszczenie sprzętu i oprogramowania, utratę danych lub inne bezpośrednie lub pośrednie szkody powstałe w wyniku użycia tego oprogramowania. Jeśli nie zgadzasz się z tymi warunkami, nie wolno ci używać tego oprogramowania, ani dalej go dystrybuować.

<div class="divider" id="table-contents"></div>
## Spis treści

Jeśli pasek nawigacyjny i / lub elementy menu nie pojawiają się poprawnie, upewnij się, że minimalna czcionka twojej przeglądarki jest ustawiona na wartość nie większą niż 12 lub idealnie 10. `Użytkownicy Netbooków muszą pomniejszyć obraz (Ctrl -) żeby zobaczyć menu, lub użyć tego spisu treści` .

#####  [Wstęp](welcome-pl.htm#welcome-gen) 

+  [Wstęp](welcome-pl.htm#welcome-gen)   
+  [Jak korzystać z tej instrukcji?](welcome-pl.htm#how-to)   
+  [Spis treści](welcome-pl.htm#table-contents)   
+  [Gdzie szukać pomocy?](help-pl.htm#help-gen)   
+  [IRC !paste](help-pl.htm#paste)   
+  [Autorzy](credits-pl.htm#cred-team)   
+  [Szybki start z siduction](wel-quickstart-pl.htm#welcome-quick)   

#####  [Pobieranie i wypalanie obrazów płyt](cd-dl-burning-pl.htm#download-siduction) 

+  [Obrazy systemu i wymagania systemowe](cd-content-pl.htm#cd-content)   
+  [Komentarze](sys-admin-release-pl.htm#rolling)   
+  [Serwery lustrzane, pobieranie i nagrywanie](cd-dl-burning-pl.htm#download-siduction)   
+  [Suma kontrolna md5](cd-dl-burning-pl.htm#md5)   
+  [Nagrywanie obrazu w Windows](cd-dl-burning-pl.htm#burn-nero)   
+  [Nagrywanie obrazu w Linux](cd-dl-burning-pl.htm#burn-linux)   
+  [burniso script](cd-no-gui-burn-pl.htm#burning-no-gui)   
+  [Nagrywanie bez interfejsu graficznego](cd-no-gui-burn-pl.htm#burn-no-gui-gen)   

#####  [Tryb Live](live-mode-pl.htm#rootpw) 

+  [Hasło administratora w trybie Live](live-mode-pl.htm#rootpw)   
+  [Instalacja oprogramowania w trakcie sesji Live](live-mode-pl.htm#live-cd-installsoft)   
+  [Zapis na partycji NTFS z ntfs-3g](live-mode-pl.htm#ntfs-3g)   

#####  [Terminal/Konsola](term-konsole-pl.htm#sux) 

+  [sux](term-konsole-pl.htm#sux)   
+  [Terminal / Konsola](term-konsole-pl.htm#konsole)   
+  [Pomoc linii poleceń](term-konsole-pl.htm#cli-help)   
+  [Narzędzia potrzebne w trybie tekstowym (tty) - init 3](help-pl.htm#init3-tools)   
+  [Lista poleceń](term-konsole-pl.htm#term-cmds)   
+  [Skrypty.sh](term-konsole-pl.htm#shell-scripts)   

#####  [Start systemu](cheatcodes-pl.htm#cheatcodes) 

+  [Opcje startowe siduction Live](cheatcodes-pl.htm#cheatcodes)   
+  [Standardowe opcje startowe](cheatcodes-pl.htm#cheatcodes-linux)   
+  [Opcje startowe VGA](cheatcodes-vga-pl.htm#vga)   

#####  [Partycjonowanie dysku twardego](part-gparted-pl.htm#partition) 

+  [Zapisywanie na partycji NTFS z ntfs-3g](part-gparted-pl.htm#hd-ntfs3g)   
+  [Partycjonowanie za pomocą GParted/KDE Partition Manager](part-gparted-pl.htm#partition)   
+  [Zmiana rozmiaru partycji NTFS za pomocą GParted/KDE Partition Manager](part-gparted-pl.htm#ntfs)   
+  [UUID, etykietowanie partycji i fstab](part-uuid-pl.htm#uuid)   
+  [Formatowanie po partycjonowaniu z użyciem gdisk](part-gdisk-pl.htm#gdisk-6)   
+  [Partycjonowanie GPT z użyciem gdisk](part-gdisk-pl.htm#gdisk-1)   
+  [Nazewnictwo dysków w brief](part-cfdisk-pl.htm#disknames)   
+  [Partycjonowanie za pomocą cfdisk](part-cfdisk-pl.htm#partition)   
+  [Formatowanie po partycjonowaniu za pomocą cfdisk](part-cfdisk-pl.htm#formating)   
+  [Przykłady podziału dysku twardego na partycje](part-size-examp-pl.htm#part-example)   

#####  [Instalacja systemu](hd-install-pl.htm#Inst-prep) 

+  [Przygotowanie do instalacji](hd-install-pl.htm#Inst-prep)   
+  [Instalacja na dysku twardym](hd-install-pl.htm#Installation)   
+  [Pierwsze uruchomienie systemu](hd-install-pl.htm#first-hd-boot)   
+  [Uruchamianie 'fromiso'](hd-install-opts-pl.htm#fromiso)   
+  [fromiso i persist](hd-install-opts-pl.htm#fromiso-persist)   
+  [Instalacja na nośniku USB - siduction-on-stick](hd-install-opts-pl.htm#usb-hd)   
+  [Zapis siductiona na pena USB/SSD z pomocą systemu Linux, MS Windows lub Mac OS X](hd-ins-opts-oos-pl.htm#raw-usb)   
+  [Uruchomienie siductiona poprzez sieć](nbdboot-pl.htm#nbd1)   
+  [Opcje instalacji na Maszynie Wirtualnej](hd-install-vmopts-pl.htm#vm)   

#####  [Karty graficzne, monitory i sterowniki &amp; xorg.conf](gpu-pl.htm#foss-xorg) 

+  [Rozdzielczość ekranu](hw-dev-mon-pl.htm#mon-res)   
+  [Dwa monitory - xrandr](hw-dev-mon-pl.htm#xrandr)   
+  [Dwa monitory - xorg.conf](hw-dev-mon-pl.htm#mon-binary)   
+  [AMD/ATI 3D drivers](gpu-pl.htm#ati-3d)   
+  [Intel 2D and 3D drivers](gpu-pl.htm#intel)   
+  [Nvidia 3D drivers](gpu-pl.htm#nvidia)   
+  [Open Source Xorg drivers](gpu-pl.htm#foss-xorg)   
+  [Firmware detection - non-free](nf-firm-pl.htm#fw-detect)   
+  [Adding non-free to Sources List](nf-firm-pl.htm#non-free-firmware)   

#####  [Menadżery okien](wm-dm-pl.htm#desk-freeze) 

+  [Poradnik Xfce](wm-dm-pl.htm#xfce-notes)   
+  [Przydatne aplikacje KDE](wm-dm-pl.htm#install-add)   
+  [Zawieszenia pulpitu](wm-dm-pl.htm#desk-freeze)   
+  [Problemy z logowaniem do KDE](wm-dm-pl.htm#kde-login)   
+  [Zmiana motywu](wm-dm-pl.htm#ch-th)   

#####  [Konfiguracja serwera](lamp-apache-pl.htm#serv-apache) 

+  [LAMP](lamp-apache-pl.htm#serv-apache)   
+  [Klient FTP](lamp-apache-pl.htm#serv-ftp)   
+  [Protokoły bezpieczeństwa](lamp-apache-pl.htm#serv-sec)   
+  [SSL](lamp-apache-pl.htm#serv-ssl)   
+  [Konfiguracja MySQL](lamp-sql-pl.htm#serv-mysql)   
+  [PHP w Apache](lamp-php-pl.htm#serv-php)   
+  [Konfiguracja serwera czasu](ntp-server-pl.htm#ntp-server)   

#####  [Internet i sieć](inet-ceni-pl.htm#netcardconfig) 

+  [Tor](tor-privoxy-pl.htm#tor)   
+  [Privoxy](tor-privoxy-pl.htm#privoxy)   
+  [Firewall](inet-ceni-pl.htm#firewalls)   
+  [SAMBA - konfiguracja klienta](samba-pl.htm#configure)   
+  [SAMBA - konfiguracja serwera](samba-pl.htm#setup)   
+  [SSH - montowanie zdalnych zasobów](ssh-pl.htm#ssh-fs)   
+  [SSH - aplikacje X Window](ssh-pl.htm#ssh-x)   
+  [SSH - Konqueror](ssh-pl.htm#ssh-f)   
+  [SSH - zdalny dostęp z Windows z przekazywaniem X](ssh-pl.htm#ssh-w)   
+  [SSH - bezpieczeństwo](ssh-pl.htm#ssh)   
+  [Połączenie modemowe](inet-ceni-pl.htm#dial-mod)   
+  [WiFi - WPA_GUI](inet-wpagui-pl.htm#wpa-roaming-gui)   
+  [WiFi - Setting up for WiFi Roaming](inet-setup-pl.htm#net-set1)   
+  [WiFi - wpasupplicant](inet-wpa-pl.htm#wpa)   
+  [Przełączanie sieci między WiFi a połączeniem kablowym](inet-ifplug-pl.htm#hotswitch)   
+  [Konfiguracja sieci przy pomocy Ceni](inet-ceni-pl.htm#netcardconfig)   

#####  [Aktualizacje i zarządzanie pakietami](sys-admin-apt-pl.htm#apt-cook) 

+  [Przewodnik po APT i sources.list](sys-admin-apt-pl.htm#apt-cook)   
+  [Instalowanie nowych pakietów](sys-admin-apt-pl.htm#apt-install)   
+  [Usuwanie pakietów](sys-admin-apt-pl.htm#apt-delete)   
+  [Instalacja starszej wersji pakietu, wstrzymanie aktualizacji pakietu](sys-admin-apt-pl.htm#apt-downgrade)   
+  [Wyszukiwanie pakietu za pomocą apt-cache](sys-admin-apt-pl.htm#apt-cache)   
+  [Wyszukiwanie pakietu za pomocą Package Search](sys-admin-apt-pl.htm#gui-pacsea)   
+  [Aktualizacja systemu przez siduction Live](sys-admin-upgrade-pl.htm#live-cd-upgrade)   
+  [dist-upgrade dla kilku komputerów w sieci LAN](sys-admin-apt-locarmirr-pl.htm#approx)   
+  [Aktualizacja jądra systemu](sys-admin-kern-upg-pl.htm#kern-upgrade)   
+  [Pełna aktualizacja systemu - Overview](sys-admin-apt-pl.htm#apt-upgrade)   
+  [Pełna aktualizacja systemu - dist-upgrade - The Steps](sys-admin-apt-pl.htm#du-st)   

#####  [Administracja systemem](sys-admin-gen-pl.htm#start-services) 

+  [Dodawanie nowego użytkownika](hd-install-pl.htm#adduser)   
+  [Przenoszenie folderów domowych](home-pl.htm#home-bu)   
+  [Tworzenie kopii zapasowej - rdiff](sys-admin-rdiff-pl.htm#rdiff)   
+  [Tworzenie kopii zapasowej - rsync](sys-admin-rsync-pl.htm#rsync)   
+  [Skanery wirusów i rootkitów](vir-rkits-pl.htm#virus-rkits)   
+  [Aktywacja i wyłączanie usług](sys-admin-gen-pl.htm#start-services)   
+  [Odzyskiwanie hasła administratora](sys-admin-gen-pl.htm#pw-lost)   
+  [Czcionki](sys-admin-gen-pl.htm#fonts)   
+  [System Drukowania CUPS](sys-admin-gen-pl.htm#cups)   
+  [Miksery Dźwiękowe](sys-admin-gen-pl.htm#sound)   
+  [Poziomy uruchamiania w siduction (runlevel)](sys-admin-gen-pl.htm#init)   
+  [Aktualizacja BIOS](bios-freedos-pl.htm#bois-prep)   
+  [Grub2 - Nadpisanie MBR'a](sys-admin-grub2-pl.htm#chroot)   
+  [Grub2 - Dual and Multibooting](sys-admin-grub2-pl.htm#multi-os)   
+  [Grub2 - aktualizacja z Grub wersja 1](sys-admin-grub2-pl.htm#grub1-grub2)   
+  [Grub2 - Przegląd](sys-admin-grub2-pl.htm#grub2)   

<div id="rev">Strona ostatnio modyfikowana 19/01/2012 2000 UTC</div>
