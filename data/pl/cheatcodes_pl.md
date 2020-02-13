<div id="main-page"></div>
<div class="divider" id="cheatcodes"></div>
## Opcje startowe (Cheatcodes)

 Jeśli możliwe wartości znajdują się w kolumnie "Wartość", muszą być dodane do "Opcji startowej" przy pomocy znaku **`=`** . Na przykład, jeśli 1280x1024 jest pożądaną wartością dla opcji startowej "screen", wtedy musisz napisać `screen=1280x1024`  w linii poleceń gruba, albo dla języka, `lang=pl` . Aby edytować linię poleceń Grub naciśnij `e`  gdy widać na ekranie program "Grub". Wystartuje tryp edycji. Teraz można w linji opcji jądra (za `quiet` ) wpisywać kilka opcji startowych. Naciśnij `Strg - X`  aby kontynuować bootowanie.

 [Odniesienie do pełnej listy kodów bootowania](http://files.kroah.com/lkn/lkn_pdf/ch09.pdf) 

<div class="divider" id="cheatcodes-siduction"></div>
## Opcje startowe specyficzne dla siduction Live

| Opcja startowa | Przykładowe wartości |  Opis | 
| ---- | ---- | ---- |
|  **blacklist**  | nazwa modułu | wstrzymuje ładowanie modułów do momentu uruchomienia udev | 
|  **desktop**  | kde | wybór środowiska graficznego | 
|  | fluxbox |  | 
|  **fromiso**  |  |  [Patrz: uruchamianie z opcją "fromiso"](hd-install-opts-pl.htm)  | 
|  **hostname**  | nazwa hosta | ustawia nazwę komputera | 
|  **lang**  |  be, bg, cz, da, de, de_CH, el, en, en_AU, en_GB, en_IE, es, fr, fr_BE, ga, hr, hu, it, ja, nl, nl_BE, pl, pt (pt_BR), pt_PT, ro, ru, zh | Ustawia język. Ustawi również locale, układ klawiatury (w konsoli i X), strefę czasową i serwery lustrzane Debiana . Kiedy w rozszerzonej formie są podane `lang=ll_cc`  lub `lang=ll-cc` , `ll`  zostanie wykorzystany do wyboru jezyka, `cc`  dla ukladu klawiatury, mirrorow i strefy czasowej (e.g. `lang=fr-be` ). Domyślne dla języka angielskiego jest en_US z UTC jako strefa czasowa lub dla niemieckiego, de z Europe/Berlin jako strefa czasowa.. Przykład: `lang=pt_PT tz=Pacific/Auckland`  | 
|  **md5sum**  |  | sprawdzi sumę kontrolną CD/DVD | 
|  **noaptlang**  |  | Wyłączenie instalacji pakietów lokalizacyjnych opartych na wybranym języku | 
|  **nocpufreq**  |  | nie aktywuj Speedstep/Powernow | 
|  **nodhcp**  |  | wyłącza DHCP (Dynamic Host Configuration Protocol) próbujące automatycznie ustawić parametry twojego połączenia sieciowego. | 
|  **noeject**  |  | nie wysuwaj tacki napędu przy zamykaniu systemu | 
|  **nofstab**  |  | nie zapisuj nowego fstab | 
|  **nointro**  |  | pomiń wyświetlenie index.html po starcie systemu w trybie live | 
|  **nomodeset**  | radeon.modeset=0 | umożliwi razem z `xmodule=vesa`  czyste bootowanie w X z kartą graficzną Radeon w trybie Live | 
|  **nonetwork**  |  | wyłącz automatyczną konfigurację urządzeń sieciowych przy starcie systemu | 
|  **noswap**  |  | nie włączaj partycji Swap | 
|  **persist**  |  |  [Patrz: "fromiso" i persist](hd-install-opts-pl.htm#fromiso-persist)  | 
|  **smouse**  |  | wykryj mysz szeregową przy pomocy hwinfo | 
|  **tz**  | tz=Europe/Dublin | Ustawia strefę czasową. Jeśli BIOS / zegar sprzętowy jest ustawiony na UTC, użyj `utc=yes` . Listę wszystkich obsługiwanych stref czasowych można znaleźć poprzez: `file:///usr/share/zoneinfo/`  (skopiuj i wklej do przeglądarki). | 
|  **toram**  |  | kopiuje zawartość CD do pamięci RAM i uruchamia system | 


---

###### Opcje startowe związane z serwerem graficznym X

Opcje startowe xrandr i xmodule, powinny być również użyte w przypadku korzystania z innych powiązanych opcji startowych dla X, dla kart graficznych radeon, Intel lub mga.

| Opcja startowa | Wartość |  Opis | 
| ---- | ---- | ---- |
|  **dpi**  | auto lub XX | Ustaw żądany Dots Per Inch dla monitora. Możesz uzyskać wartość dpi dla Twojego ekranu z szerokości w pikselach podzielonej przez długość przekątnej w calach i mnożąc to przez 1,25 dla ekranu 4:3, 1.18 dla ekranu 16:10 i 1.147 dla ekranu 16:9. Dla ekranu 24 " 1920x1080 bedzie 1,147 * 1920/24 co daje dpi = 92 lub dla ekranu 15 " 1600x1200 będzie 1,25 * 1600/15 = co daje dpi 133. | 
|  **hsync**  | 80 | ustawia odświeżanie poziome (kHz) | 
|  **noml**  |  | wyłącz korzystanie przez konfigurację X.Org z listy trybów (Modelines) i wymuś autodetekcję prawidłowego trybu | 
|  **noxrandr**  |  | wyłącz użycie rozrzerzeń RandR 1.2 przez nowe sterowniki X.or i użyj starszych technik wykrywania | 
|  **screen**  | 800x600 | ustawia rozdzielczość ekranu | 
|  **vsync**  | 60 | ustawia odświeżanie pionowe (Hz) | 
|  **xdepth**  | 8, 15, 16, 24 | ustawia domyślną głębię kolorów używaną przez X.Org (nie wszystkie sterowniki wspierają 8bit i 24bit) | 
|  **keytable**  | (eg, us, de, gb) | układ klawiatury użyty przez X.Org | 
|  **xkbmodel**  | (np:) pc105  | model klawiatury użyty przez X.Org | 
|  **xkboptions**  | (np:) grp:alt_shift_toggle | opcje wariantów klawiatury stosowane dla X.org | 
|  **xkbvariant**  | (np:) nodeadkeys,  | by ustawić wariant klawiatury | 
|  **xmode**  | 800x600 | ustawia rozdzielczosć ekranu 1024x768, 1600x1200 itp. | 
|  **xmodule**  or  **xdriver**  | ati, fbdev, i810, mga, nv, radeon, savage, vesa | użyj podanego modułu X.Org | 
|  **xrandr**  |  | wymuś, aby X.Org korzystał z rozszerzeń RandR 1.2 dla nowych sterowników X.org | 
|  **xrate**  | XX | Wymusza preferowaną częstotliwość odświeżania sterowników X.Org wspierających RandR 1.2, opcja musi być użyta wraz z xmode.  [Pełna dokumentacja znajduje się tutaj](http://wiki.debian.org/XStrikeForce/HowToRandR12)  | 
|  **xhrefresh**  | 80 | poziome odświeżanie monitora (kHz) | 
|  **xvrefresh**  | 60 | pionowe odświeżanie moniora  | 


---

<div class="divider" id="cheatcodes-linux"></div>
## Popularne opcje startowe dla jądra linuksa

| Opcja startowa | Wartość |  Opis | 
| ---- | ---- | ---- |
|  **apm**  | off | Wyłącza Advanced Power Managment | 
|  **1, 2, 3, 4, 5**  |  (np:) 3  |  **init runlevel** liczby, które mogą być ręcznie wprowadzane do linii uruchomieniowych GRUB.  [Patrz: siduction runlevels - init](sys-admin-gen-pl.htm#init)  | 
|  **irqpoll**  |  | użyj IRQ poll | 
|  **mem**  | np. 128MB | wielkość pamięci ram do użycia przez system | 
|  **noagp**  |  | wyłącza agp | 
|  **noapic**  |  | wyłącza apic (Advanced Programmable Interrupt Controller) | 
|  **nodma**  |  | wyłącza DMA (Direct Memory Access) dla dysków i napędów | 
|  **noisapnpbios**  |  | wyłącz ISA Plug'n'Play | 
|  **nomce**  |  | wyłącz MCE (Machine Check Exception) | 
|  **nosmp**  |  | wyłącz wsparcie dla SMP (Symetric Multi Processor) | 
|  **pci**  | noacpi | nie używaj ACPI do przydzielania przerwań PCI | 
|  **quiet**  |  | tryb cichy, podczas bootowania nie wyświetla wszystkich informacji | 
|  **vga**  | normal | przejdź tu, by poznać kody VGA:  [Opcje startowe VGA](cheatcodes-vga-pl.htm#vga)  | 
|  **video**  | (np:) DVI-0:800x600  or  800x600 | Dla kart graficznych z aktywnym KMS. Dotyczy Intel i ATI (sterownik radeon), gdzie DVI-X/LVDS-X jest wyjściem video jak wynika z xrandr. | 

<div id="rev">Strona ostatnio modyfikowana 18/03/2011 0715 UTC </div>
