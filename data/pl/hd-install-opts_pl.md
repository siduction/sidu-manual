<div id="main-page"></div>
<div class="divider" id="fromiso"></div>
## Uruchamianie z opcją "fromiso" - Overview

**`Dla zwykłego użytku zalecamy stosowanie systemu plików ext4. Jest to domyślny system plików i posiada bardzo dobre wsparcie techniczne.`**

Przy pomocy tej opcji startowej możesz uruchomić system z obrazu iso na partycji, co jest znacznie szybsze niż z CD (instalacje na twardym dysku z "fromiso" zajmują ułamek czasu instalacji z CD).

'fromiso' jest oczywiście znacznie szybszy niż start z napędu CD/DVD i pozostawia dostępny napęd. Jako alternatywę możesz również wykorzystać QEMU.

###### Wymagania:

* działający grub (na dyskietce, twardym dysku lub Live-CD)  
* obraz ISO siduksa np.: siduction.iso i system plików linuksa taki jak ext2/3/4  
* jeśli zmienisz nazwę obrazu na siduction.ISO, będziesz musiał zmienić odpowiednio polecenia, ponieważ system nazw uniksa uwzględnia wielkość liter.

<div class="divider" id="grub2-fromiso"></div>
## fromiso z Grub2

siduction ma przygotowany plik do programu grub2 o nazwie 60_fll-fromiso, aby wygenerować wpis w menu gruba2.  
Jedyny plik do konfiguracji fromiso nazywa się  
`grub2-fll-fromiso`  i można go znaleźć w `/etc/default/grub2-fll-fromiso.` .

 Wpierw otwórz okno teminala i jako root wykonaj:

~~~  
sux  
apt-get update  
apt-get install grub2-fll-fromiso  
~~~

Teraz wywołaj edytor, np. kwrite, mcedit, vim lub taki, który preferujesz:

~~~  
mcedit /etc/default/grub2-fll-fromiso  
~~~

Nastepnie odkomentuj (usuń znak**`#`** ) linie, które potrzebujesz aby funkcjonowały i zamień domyślne instrukcje w `"cudzysłowach"`  zgodnie z twoimi preferencjami.

Dla przykładu, porównaj zmieniony grub2-fll-fromiso z domyślnym, (the `wyróżnione linie`  są zmienionym liniami w celach instruktażowych):

~~~  
# Defaults for grub2-fll-fromiso update-grub helper  
# sourced by grub2's update-grub  
# installed at /etc/default/grub2-fll-fromiso by the maintainer scripts  
#  
# This is a POSIX shell fragment  
#  
# specify where to look for the ISO  
# default: /srv/ISO `### Note: This is the path to the directory that contains the ISO, it is not to include the actual siduction-*.iso file.###`   
FLL_GRUB2_ISO_LOCATION="/media/disk1part4/siduction-iso"`   
# array for defining ISO prefices --> siduction-*.iso  
# default: "siduction- fullstory-"  
FLL_GRUB2_ISO_PREFIX="siduction-"`   
# set default language  
# default: en_US  
FLL_GRUB2_LANG="en_AU"`   
# override the default timezone.  
# default: UTC  
FLL_GRUB2_TZ="Australia/Melbourne"`   
# kernel framebuffer resolution, see  
# http://manual.siduction.org/de/cheatcodes-vga-de.htm#vga  
# default: 791  
#FLL_GRUB2_VGA="791"  
# additional cheatcodes  
# default: noeject  
FLL_GRUB2_CHEATCODE="noeject nointro"`   
~~~

Wykonaj zapis i zamknij edytor, a następnie uruchom w terminalu:

~~~  
update-grub  
~~~

Plik grub.cfg twojego gruba2 zostanie zaktualizowany by widział różne obrazy ISO, które umieściłeś w wyspecyfikowanej kartotece i będą one dostepne przy następnym uruchomieniu komputera.

<div class="divider" id="fromiso-persist"></div>
## Ogólna informacja dla fromiso z opcją persist

### fromiso i persist na HD

Możesz mieć stały system typu "live" na zapisywalnym dysku poprzez kombinację ustawienia fromiso z opcją persist. Kiedy fromiso używa domyślnego systemu plików ext2/ext3/ext4 kod jest prosty:

~~~  
persist  
~~~

Kiedy fromiso używa systemu plików vfat, musisz uzyć pliku zawierającego system plików linuksa a kod będzie wygladał tak:

~~~  
persist=//siduction/base-rw  
~~~

siduction używa aufs, aby umożliwić "copy on write" ponad twoim ISO w celu umożliwienia zapisu nowych plików, kartotek i uaktualnianie istniejących przez zachowanie zmian w pamięci. Użycie kodu `persist` , umożliwi zapisywanie twoich nowych plików na tej samej partycji dysku twardego, którego użyłeś do przechowania za pomocą opcji fromiso obrazu ISO.

`fromiso`  daje ci system typu "live" wykazujący wszystkie automatyczne cechy siductiona uruchamianego z płytki "live". To daje korzyści takie jak wykonywanie automatycznej konfiguracji sprzętu jak również oznacza, że zostają ponowne utworzone te same pliki za każdym razem kiedy startujesz system, póki nie zastosujesz dodatkowych kodów.

Użycie `persist`  z innymi specyficznymi dla siductiona kodami startowymi takimi jak noxorgconf, nonetwork oznacza, że nie będą ponownie tworzone te same pliki konfiguracyjne za każdym razem kiedy startujesz system. 

Użycie persist oznacza także, że możesz instalować paczki przez apta i mieć aplikacje i zapisane dane dostępne przy kolejnym starcie systemu.

<div class="divider" id="persist-post"></div>
## fromiso i persist na uruchamialnych (bootowalnych) pendrivach USB/SD/kartach flash

Byc może idelnym użyciem kodu persist jest użycie go w połączeniu z narzędziem install-usb-gui aby stworzyć włąsny uruchamialny (bootable) nosnik flash z twoimi plikami i programami, których potrzebujesz. Twoje pliki będą zapisane w podkartotece na nośniku.

`persist`  na systemie plików FAT, jako używanym wspólnie przez dosowe/Windowsowe 9x instalacje i zwykle będące domyślnymi na nośnikach typu flash, wymagają abyś utworzył pojedynczy wielki plik użyty jako urządzenie typu loop, który następnie sformatujesz.

`Na nośnikach USB/SD/kartach flash rekomendowane są systemy plików typu ext2 i vfat, które najprawdopodobniej dają lepszą zdolność międzyplatformową do odzysku danych kiedy to jest konieczne, bardziej niż sterownik MS Windows(tm); dostępny dla wymiany danych. Odczyt/zapis na nośnik typu flash jest kontyngentem w specyfikacji twojego nośnika flash.` 

###### system plików ext2

Przy ext2 zostanie użyta cała partycja i kartoteka nadrzędna (root). Zostaje utworzona kartoteka /fll, która zostanie użyta przy opcji persist umożliwiająca użycie całego wolnego miejsca na urządzeniu systemowi typu persist.

###### system plików vfat file

Kiedy uzyjemy systemu plików vfat, persistance jest tworzony poprzez plik, który może mieć maksymalną wielkość 2GB lecz nie mniej niż 100MB (jeśli ma zachować użyteczność). Ten zbiór powinien zostać nazwany `siduction-rw` .

#### Przykład tworzenia systemu typu persist po wstępnej instalacji

Jeśli nie jesteś pewien punktu mocowania, zamontuj nośnik i uruchom `ls -lh /media`  by uzyskać listę punktów mocowania całego systemu. Szukaj czegoś na podobieństwo `drwxr-xr-x 6 username root 4.0K Jan 1 1970 disk` . Jeśli rezultat określa inaczej, zamień `"/media/disk"`  w linii zgodnie z potrzebą, (dla przykładu "/media/disk-1").

~~~  
disk="/media/disk"  
-->  
~~~

Kontynuując przykład, komenda `df -h`  rozjaśni informację, :

~~~  
/dev/sdc2 3.4G 4.0K 3.4G 1% /media/disk  
/dev/sdc1 4.1G 1.1G 2.8G 28% /media/disk-1  
~~~

Zatem:

~~~  
disk="/media/disk-1"  
~~~

Ustal rozmiar partycji typu persist:

~~~  
size=1024  
~~~

Utwórz kartoteke na nośniku:

~~~  
mkdir $disk/siduction  
~~~

Wykonaj kod by utworzyć partycję persist:

~~~  
dd if=/dev/zero of=$disk-1//siduction/base-rw bs=1M count=$size && echo 'y' | LANG=C /sbin/mkfs.ext2 $disk-1//siduction/base-rw && tune2fs -c 0 "$disk-1//siduction/base-rw"  
~~~

**`Partycje NTFS, powszechnie używane w instalacjach NT/2000/XP (TM), NIE MOGĄ być w ogóle użyte dla systemu typu persist.`**

<div class="divider" id="usb-hd"></div>
## Instalacja siductiona na nośnikach USB/SD/flash

Wykonanie instalacji siductiona na nośniku USB/SD/karcie flash jest tak łatwe jak normalna instalacja na dysku HD. Podążaj za tymi prostymi wytycznymi.

##### Wymagania:

Dowolny komputer PC obsługujący protokół USB 2.0 i umożliwiający inicjację systemu z nośnika USB/SD/flash.

Plik obrazu siduction.iso.

##### 3 rodzaje instalacji na nośniku USB/SD/flash

+ 1)  [fromiso](hd-install-opts-pl.htm#usb-from1) ; specyficzny dla siductiona: siduction-on-a-stick  
+ 2)  [Pełna](hd-install-opts-pl.htm#usb-hdd)  (pełna instalacja na nośnik USB/SD/flash zachowuje się jak normalna instalacja na dysku HD i jest przeprowadzana przez normalny instalator).  
+ 3)  [Zapis typu RAW device](hd-ins-opts-oos-pl.htm#raw-usb)  Jest idealna, kiedy używamy dowolnego systemu operacyjnego Linux, MS Windows lub Mac OS X i chcemy zainstalować siduction-on-a-stick, (z ostrzeżeniami).  

<div class="divider" id="usb-from1"></div>
### Instalacja na nośniku USB/SD/flash fromiso, siduction-on-a-stick

 `Dokonaj preformatowania nośnika usb systemem plików ext2 lub fat32 przed właściwą procedurą (co najmniej 2 gigabajty pojemności). Urządzenie powinno mieć tylko jedną partycję a jako, że niektóre BIOSy są na to czułe, zaznaczoną jako uruchomieniową (bootable).` 

Jesli używasz programu partycjonującego z gragicznym interfejsem (GUI) jak gparted, upewnij się, że wyczyścisz najpierw istniejącą partycję, a następnie odtworzysz ją przed formatowaniemthen.

##### Instalacja USB fromiso z siductiona zainstalowanego na HD:

Instalacja `fromiso USB`  jest wykonywana przez `Menu>System>install-siduction-to-usb` . 

##### Instalacja USB fromiso z obrazu siduction-*.iso:

Po uruchomieniu LIVE-CD kliknij na `ikonę siduction Installer`  i wybierz `Zainstaluj na USB` .

###### Opcje:

Stworzono możliwość by dokonac wyboru języka, strefy czasowej i ustawić inne kody startowe i aktywować lub nie funkcję persist poprzez checkbox.

Teraz masz USB/SD/flash z możliwością uruchomienia. Jeśli nie aktywowałeś funkcji persist możesz włączyć ją poprzez dodanie `persist`  w linii gruba na jego ekranie. (Jeśli używasz vfat, przypuszczalnie najlepiej jest wystartować LIVE-CD ponownie).

###### Przykład w terminalu:

~~~  
fll-iso2usb -D /dev/sdb -f none --iso /home//siduction/base.iso -p -- lang=no tz=Pacific/Auckland  
~~~

To instaluje obraz iso na urządzenie USB `sdb`  z funkcją persist, Norweskim językiem i strefą czasową Pacific/Auckland (NZL) w domyślnej linii gruba.

Konfiguracja Twoich X-ów (karta video, klawiatura, mysz) także pliki twoich interfejsów sieciowych nie zostaną zapisane, co doskonale pozwala na użycie na innych komputerach.

Aby uzyskać więcej informacji włącznie z ustawieniami użytkownika patrz:

~~~  
$ man fll-iso2usb  
~~~

### Pełna instalacja na nośniku USB/SD/flash (zachowująca się jak normalna instalacja na dysk HD)

Zalecaną minimalną wielkością nośnika USB/SD/karty flash jest:  
siduction "LITE" potrzebuje 2.5 giga PLUS potrzebna tobie przestrzeń na dane,  
siduction "FULL" poptrzebuje 4 giga PLUS potrzebna tobie przestrzeń na dane

 `Dokonaj preformatowania urządzenia systemem plików`  **`ext2`** `i partycjonuj nośnik USB/SD/kartę flash tak jak normalny dysk na PC.` 

Rozpocznij instalację z Live-ISO i wybierz partycję na nośniku USB/SD/flash, gdzie ma być zainstalowany, dla przykładu `sdbX` i postępuj zgdonie z podpowiedziami instalatora siductiona. Przeczytaj  [Instalacja na dysku HD](hd-install-pl.htm#Installation) 

`Aby wystartować z twojego USB/SD/flash, w BIOSie musi być włączona opcja 'Boot from USB'.` 

`Inne uwagi warte podkreślenia:` 

+ Instalacja na nośniku USB/SD/karcie flash będzie zwykle związana z PC, na którym dokonano instalacji. Jeśli twoją intencją jest możliwość użycia nośnika USB/SD/flash na innym PC, instalacja nie powinna mieć nie wolnych (non-free) sterowników grafiki i kodów startowych zadeklarowanych, za wyjątkiem prawdopodobieństwa zakodowania kodu startowego vesa w grub.cfg, (tym zająć się po pomyślnej instalacji).  
+ Po inicjacji systemu z nośnika USB-stick/SD/karty flash w innym PC, będzie potrzebował zmodyfikowac fstab by uzyskać dostęp do dysków komputera.  
+ "fromiso" z "persist" jest lepszym wyborem kiedy intencją jest przenośność.  

<div class="divider" id="usb-hdd"></div>
### Pełna instalacja na dysk twardy USB jak instalacja na partycji

Dysk twardy USB ma jedno całkiem dobre i pociągające zastosowanie, (szczególnie dla nowych użytkowników przesiadających się z MS lub innej dystrybucji), jest nią możliwość instalacji siductiona na USB HDD, i podłączenia go bez potrzeby konfigurowania PC dla podwójnego startu [dual boot] (konieczności partycjonowania, modyfikacji gruba, itp.).

Rozpocznij instalację z Live-ISO, (lub nośnika USB/SD/karty flash), `jako normalną instalację, a nie instalację na nośniku USB`  i wybierz partycję na urządzeniu, gdzie system ma być zainstalowany, dla przykładu `sdbX` i postępuj za podpowiedziami instalatora siductiona. Grub musi być zapisany na partycji dysku USB HDD.

Przeczytaj  [Instalacja na dysku HD](hd-install-pl.htm#Installation) 

`Inne uwagi warte podkreślenia:` 

+ Instalacja na dysku USB będzie zwykle związana z PC, na którym dokonano instalacji. Jeśli twoją intencją jest możliwość użycia dysku USB na innym PC, instalacja nie powinna mieć nie wolnych (non-free) sterowników grafiki i kodów startowych zadeklarowanych, za wyjątkiem prawdopodobieństwa zakodowania kodu startowego vesa w grub.cfg, (tym zająć się po pomyślnej instalacji).  
+ Jeśli chcesz używać instalacji na innym komputerze miej świadomość konieczności dokonania kilku nastaw. Będziesz potrzebował zmodyfikować fstab aby uzyskać dostęp do dysków tego komputera PC, być może także xorg.conf i prawdopodobnie konfiguracji sieci.  

<div class="divider" id="usb-gpt-1"></div>
## Full installation to bootable GPT removable devices (behaves as a normal HD installation)

 Refer to  [Partitioning with gdisk for GPT disks](part-gdisk-pl.htm#gdisk-1)  and then follow the instructions for  [Installation options - HD, USB, VM and Cryptroot](hd-install-pl.htm) .

<div class="divider" id="usb-efi-1"></div>
## Bootable (U)EFI removable devices

<span class='highlight-1'>Applicable from the siduction 2011-02 release.</span>

If you want to boot using EFI without burning optical media, then you need a vfat partition containing a portable EFI bootloader `/efi/boot/bootx64.efi` . The siduction amd64 isos include such a file and a grub configuration which it can load. To prepare a stick to boot this way, simply copy the contents of the siduction iso to the root of a `vfat`  formatted usb stick. You should also mark the partition as bootable using a disk partitioning tool.

Of course simply copying the files onto a vfat usb stick will not let you boot it on a traditional bios system, however it is quite easy to enable this using syslinux and install-mbr. All you need to do is run (without the stick being mounted): 

~~~  
syslinux -i -d /boot/isolinux /dev/sdXN  
install-mbr /dev/sdX  
~~~

A stick prepared this way, will boot both by EFI to the plain grub2 menu and by traditional bios to the graphical gfxboot menu.

One of the advantages of having a stick created this way, as opposed to a raw stick created due to using isohybrid, is that you can edit the boot files on the stick to add your preferred options automatically. 

For traditional BIOS systems you can edit the `/boot/isolinux/syslinux.cfg`  file and/or the `/boot/isolinux/gfxboot.cfg`  file. For EFI systems you can edit the `/boot/grub/x86_64-efi/grub.cfg`  file.

#### Persistence and firmware

See  [General information on persist](hd-install-opts-pl.htm#fromiso-persist) 

<div id="rev">Page last revised 30/09/2011 1440 UTC</div>
