<div id="main-page"></div>
<div class="divider" id="uuid"></div>
## Rebuilding fstab and creating mount points

`By default siduction uses uuid in your fstab when you install.`

Aby dodać nową partycję (np. sda6 lub sdb7) do fstab, w konsoli jako użytkownik ($), wpisz następujące polecenie:

~~~  
ls -l /dev/disk/by-uuid  
~~~

Wyświetli to taki komunikat (wytłuszczenie tylko dla celów przykładu):

~~~  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 348ea9e6-7879-4332-8d7a-915507574a80 -> ../../sda4  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 610aaaeb-a65e-4269-9714-b26a1388a106 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 857c5e63-c9be-4080-b4c2-72d606435051 -> ../../sda5  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 a83b8ede-a9df-4df6-bfc7-02b8b7a5f1f2 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42  ad662d33-6934-459c-a128-bdf0393e0f44  -> ../../sda6  
~~~

W tym przykładzie  **ad662d33-6934-459c-a128-bdf0393e0f44**  jest brakującym wpisem. Następnym krokiem jest wpisanie UUID partycji do /etc/fstab. Aby to zrobić, użyj edytora tekstowego (jak kate lub kwrite) z uprawnieniami roota:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=ad662d33-6934-459c-a128-bdf0393e0f44  /media/disk1part6 ext4 auto,users,exec 0 2    
~~~
  
Inny przykład:

~~~  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 30ebb8eb-8f22-460c-b8dd-59140274829d -> ../../sdb8  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 387d6d4b-4508-4b8e-8ed2-76998f41dae4 -> ../../sdb1  
rwxrwxrwx 1 root root 10 2007-05-28 13:18 7014f66f-6cdf-4fe1-83da-9cab7b6fab1a -> ../../sdb5  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 8f042ead-259f-4df0-98ec-3343080396c5 -> ../../sdb6  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 94B0AE63B0AE4B94 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 A61820AA18207B85 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f28725d6-b7b5-4207-8476-36efe1a903ce -> ../../sdb9  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f855c263-2521-48d3-8ec9-d2d2b69b6635 -> ../../sda3  
rwxrwxrwx 1 root root 10 2007-05-28 13:18  f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  -> ../../sdb7  
~~~

W tym przypadku  **f9aa4027-ecdd-4a86-84e2-df2ef73fe14e**  jest brakującym wpisem i zostanie dodany do /etc/fstab:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  /media/disk2part7 ext4 auto,users,exec 0 2    
~~~
  
### Creating new mount points
  
 `Note:`  A mount point name, as noted in fstab, needs to have an existing directory. siduction creates these directories during the installation process under `/media`  and they are named `diskXpartX` .

If you have manipulated the partition table after the initial installation and assuming you have already altered fstab, (for example, 2 new partitions have been created), the directory for each mount point will not exist and it needs to be manually created.

##### Example:

First, as root, confirm the existing mount points:

~~~  
cd /media  
ls  
~~~

It should return the existing mount points, for example:

~~~  
disk1part1 disk1part3 disk2part1  
~~~

Staying in /media, create the mount points of the new partitions:

~~~  
mkdir disk1part6  
mkdir disk2part7  
~~~

To test or use partitions immediately:

~~~  
mount /dev/sda6 /media/disk1part6  
mount /dev/sda6 /media/disk2part7  
~~~

Upon a reboot of the computer the filesystems will be mounted automatically. Read:

~~~  
man mount  
~~~

<div class="divider" id="uuid-fstab"></div>
## Konfiguracja fstab

## Przegląd: UUID, nazwy partycji i fstab

Trwałe nazwy urządzeń blokowych stały się możliwe przez pojawienie się udev i mają kilka zalet w stosunku do nazewnictwa opartego na szynie systemowej.

Podczas gdy dystrybucje linuksa i udev rozwijają się, a wykrywanie sprzętu staje się coraz bardziej niezawodne, pojawia się również kilka nowych problemów i zmian:  
 **1)**  jeśli posiadasz więcej niż jeden kontroler dysku sata/scsi lub ide, kolejność, w której są one dodawane, jest losowa. Może to powodować losowe zmiany nazw urządzeń jak hdX i hdY przy każdym starcie systemu. To samo dotyczy sdX i sdY. Trwałe nazwy rozwiązują ten problem.  
 **2)**  Wraz z wprowadzeniem wsparcia dla nowego libata pata, wszystkie urządzenia ide hdX staną się w przyszłości urządzeniami sdX. Ponownie, dzięki trwałym nazwom, nawet nie zauważysz zmiany.  
 **3)**  Komputery z kontrolerami sata i ide są obecnie dość powszechne. Wraz ze zmianami w libata wspomnianymi wyżej, pierwszy problem stanie się jeszcze bardziej powszechny, ponieważ dyski sata i ide będą miały nazwy typu sdX.

`siduction domyślnie będzie używać uuid w fstab`

Jest więcej powodów, ale wspomniane wyżej są najbardziej istotne. Dlatego siduction zachęca do zmiany konfiguracji na schemat trwałych nazw urządzeń blokowych.

## Cztery różne schematy trwałych nazw:

#### 1. Trwałe nazwy poprzez użycie UUID

UUID oznacza Universally Unique Identifier (Uniwersalny Unikatowy Identyfikator) i jest mechanizmem umożliwiającym przydzielenie każdemu systemowi plików unikatowego identyfikatora. Jest tak zaprojektowany, że kolizja nazw jest nieprawdopodobna. Wszystkie linuksowe systemy plików (włączając swap) wspierają UUID. Systemy plików FAT i NTFS nie wspierają UUID, ale także pojawiają się na liście by-uuid z unikatowym identyfikatorem:

~~~  
$ /bin/ls -lF /dev/disk/by-uuid/  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 2d781b26-0285-421a-b9d0-d4a0d3b55680 -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 31f8eb0d-612b-4805-835e-0e6d8b8c5591 -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 3FC2-3DDB -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 5090093f-e023-4a93-b2b6-8a9568dd23dc -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 912c7844-5430-4eea-b55c-e23f8959a8ee -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 B0DC1977DC193954 -> ../../sdb1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 bae98338-ec29-4beb-aacf-107e44599b2e -> ../../sdb2  
~~~

As you can see, the fat and ntfs partitions have shorter names (sda6 and sdb1), but are still listed by uuid.

#### 2. Trwałe nazwy poprzez użycie ETYKIET

Prawie każdy system plików może mieć etykietę. Wszystkie partycje, które je mają, są wylistowane w katalogu /dev/disk/by-label:

~~~  
$ ls -lF /dev/disk/by-label  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data2 -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 fat -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1  
~~~

While labels may have recognisable names, you need to exercise extreme caution to negate name collisions.

Możesz zmienić etykiety swoich systemów plików używając poleceń:

~~~  
* swap: Utwórz nową partycję wymiany: mkswap -L <etykieta> /dev/XXX  
* ext2/ext3ext4: e2label /dev/XXX <etykieta>  
* jfs: jfs_tune -L <etykieta> /dev/XXX  
* xfs: xfs_admin -L <etykieta> /dev/XXX  
* fat/vfat: Nie ma narzędzia do zmiany etykiety w linuksie,  
ale kiedy tworzysz system plików, użyj mkdosfs -n <etykieta> <inne opcje>.  
Możesz również zmienić etykietę istniejącego systemu plików używając Windows.  
* ntfs: ntfslabel /dev/XXX <etykieta> lub zmień używając Windows.  
~~~

`Bądź ostrożny: Etykiety muszą być unikatowe, aby mogły pełnić swoją rolę, dotyczy to napędów USB/firewire i twardych dysków. Składnia LABEL=/ UUID= jest bardziej zalecana niż /dev/disk/by-*/ dla partycji UN*X`

#### 3. Trwałe nazwy poprzez użycie id 

by-id tworzy unikatową nazwę zależną od numeru seryjnego urządzenia.

#### 4. Stałe nazwy poprzez użycie ścieżki

by-path tworzy unikatową nazwę zależną od najkrótszej fizycznej ścieżki (według sysfs). Obie zawierają łańcuchy znaków, aby wskazać, do którego subsystemu należą, a zatem nie są odpowiednie do rozwiązania problemów wspomnianych na początku artykułu. Nie będą więc dalej omawiane.

#### Aktywacja trwałych nazw

Po wybraniu metody, teraz uaktywnimy trwałe nazwy w systemie:

#### w fstab

Aktywacja trwałych nazw w /etc/fstab jest łatwa, po prostu zamień nazwy urządzeń w pierwszej kolumnie trwałą nazwą. W moim przykładzie zmieniłem /dev/sda7 przez następujące:

~~~  
/dev/disk/by-label/home lub  
/dev/disk/by-uuid/31f8eb0d-612b-4805-835e-0e6d8b8c5591  
~~~

Zrób tak dla wszystkich partycji w pliku fstab.

Zamiast podawać urządzenie bezpośrednio, można wskazać system plików, który ma zostać zamontowany przez jego UUID lub etykietę, pisząc LABEL=&lt;etykieta&gt; or UUID=&lt;uuid&gt;, na przykład:

~~~  
LABEL=Boot  
~~~

lub

~~~  
UUID=3e6be9de-8139-11d1-9106-a43f08d823a6  
~~~

Źródło: [wiki.archlinux.org](http://wiki.archlinux.org/index.php/Persistent_block_device_naming)  za  [marc.theaimsgroup.com](http://marc.theaimsgroup.com/?l=linux-hotplug-devel&amp;m=114795097514527&amp;w=2) . Zawartość z wiki.archlinux.org dostępna na licencji GNU Free Documentation License 1.2 i została dostosowana dla instrukcji siduction.org

 [Więcej o nazwach na lissot.net](http://www.lissot.net/partition/ext2fs/labels.html)  

<div id="rev">Content last revised 26/04/2011 1355 UTC</div>
