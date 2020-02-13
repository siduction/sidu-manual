<div id="main-page"></div>
<div class="divider" id="vmopts"></div>
## Opcje maszyn wirtualnych

+  [KVM dla Intel VT lub AMD-V](hd-install-vmopts-pl.htm#kvm)   
+  [Virtualbox](hd-install-vmopts-pl.htm#vbox)   
+  [QEMU](hd-install-vmopts-pl.htm#qemu)   
+  [Instalacja innych dystrybucji jako obrazów w maszynie wirtualnej](hd-install-vmopts-pl.htm#oos)   

`Poniższe przykłady dotyczą siductiona, w prosty sposób można zastapić siductiona inną pożądaną dystrybucją.` 

<div class="divider" id="oos"></div>
## Instalacja innych dystybucji jako obrazów w maszynie wirtualnej

Uwaga: Jeśli zechcesz lub kiedy dokonujesz instalacji obrazu w maszynie wirtualnej, dla większości dystrybucji Linuxa przypuszczalnie wystarczającą będzie potrzeba alokacji 12G miejsca na dysku. Jeśli jednak masz potrzebę mieć MS Windows w maszynie wirtualnej, będziesz potrzebował miejsca ok 30G, lub więcej, na obraz. Wszystkie wielkości alokacji bezwzględnie zależą od twoich potrzeb. 

A nawet wtedy, miejsce na dysku twardym zostaje zajmowane dynamicznie, w przydziale do rzeczywistej ilości danych, które ekspandują na obrazie. Wynika to z współczynnika kompresji qcow2.

<div class="divider" id="kvm"></div>
## Włączanie Wirtualnej Maszyny KVM

KVM to rozwiązanie pełnej wirtualizacji dla systemu Linux na sprzęcie z procesorem x86 wyposażonym w rozszerzenia wirtualizacyjne (Intel VT lub AMD-V).

### Wstępne wymagania

Aby ustalić, czy sprzęt obsługuje KVM, należy upewnić się, czy obsługa KVM jest włączona w BIOS-ie (w niektórych przypadkach systemów Intel VT lub AMD-V może to nie być widoczne, gdzie jest opcja włączenia, w tych przypadkach przyjmuje się, że KVM jest aktywny). W konsoli można sprawdzić to za pomocą polecenia:

~~~  
cat /proc/cpuinfo | egrep --color=always 'vmx|svm'  
~~~

Jeśli widzisz `svm`  lub `vmx`  w polu flag procesora, to oznacza, że system obsługuje KVM. (W przeciwnym razie wróć do BIOSu, jeśli uważasz, że KVM jest wspierane sprawdź jeszcze raz, lub wyszukaj w internecie to, gdzie włączenie KVM może być w BIOS-ie ukryte).

Jeśli BIOS nie obsługuje KVM, można użyć  [Virtualbox](hd-install-vmopts-pl.htm#vbox)   
lub  [QEMU](hd-install-vmopts-pl.htm#qemu) 

Aby zainstalować i uruchomić KVM, najpierw należy upewnić się, że moduły Virtualboxa nie są załadowane, (--purge apta jest najlepszym rozwiązaniem), a następnie w zależności od chipsetu wykonać:

Dla `vmx` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-intel  
~~~

Dla `svm` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-amd  
~~~

Po uruchomieniu systemu skrypty startowe qemu-kvm zajmą się ładowaniem modułów.

#### Użycie KVM do uruchomienia siduction-*.iso

**`Jako user (użytkownik):`** 

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom <siduction.iso>  
~~~

##### Instalacja siductiona jako obrazu KVM

Najpierw trzeba stworzyć obraz dysku, (ten obraz będzie bardzo mały i będzie rósł tylko w miarę potrzeb według stopnia kompresji qcow2):

~~~  
<!-- $ qemu-img create -f qcow2 siduction-VM.img 12G -->  
$ qemu-img create -f qcow2 siduction-VM.img 12G  
~~~

Uruchom siduction-*.iso z następującymi parametrami, aby umożliwić KVM rozpoznanie, że jest dostępny obraz dysku twardego QEMU:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom </path/to/siduction-*.iso> -boot d </path/to/siduction-VM.img>  
~~~

Po starcie systemu z cdroma kliknij na ikonę instalatora siductiona aby aktywować skrypt instalacyjny, (lub użyj menu), kliknij na zakładkę Partycjonowanie, i uruchom preferowany menadżer partycjonowania. Możesz przy tym posłużyć się instrukcjami zawartymi w  [Partycjonowanie dysku twardego - Tradycyjne, GPT i LVM](part-gparted-pl.htm)  (nie zapomnij dodać partycji wymiany /swap partition/ jeśli masz mało pamięci). Należy pamiętać, że formatowanie zajmie trochę czasu i uzbroić się w cierpliwość.

![gparted kvm hard disk naming](../images-common/images-vm/kvm-gparted02.png "gparted kvm hard disk naming") 


---

Masz teraz Maszynę Wirtualną (VM) gotową do użycia:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -drive if=virtio,boot=on,file=<path/to/siduction-VM.img>    
~~~
  
Niektóre systemy goszczące nie obsługują wirtualizacji, trzeba więc skorzystać z innych opcji podczas uruchamiania KVM, na przykład:

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img> -cdrom your_other.iso -boot d  
~~~

lub

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img>  
~~~

Zobacz także:  [KVM documentation](http://www.linux-kvm.org/page/Main_Page) .

##### Zarządzanie instalacjami maszyn wirtualnych KVM

~~~  
apt-get install aqemu  
~~~

Podczas korzystania z AQEMU należy upewnić się, czy został wybrany tryb KVM z rozwijanej listy "Typ Emulatora" w zakładkę "Ogólne". (Dokumentacja AQEMU w zasadzie nie istnieje, więc na zasadzie "prób i błędów" należy wypracować łatwy w obsłudze GUI sposób, jednak dobrym początkiem jest użycie najpierw menu "VM", a następnie zakładki "Ogólne"). 

<div class="divider" id="vbox"></div>
## Uruchamianie i instalacja w maszynie wirtualnej VirtualBoxa

Kroki:.

+ 1. Utwórz obraz twardego dysku dla VirtualBox  
+ 2. Uruchom iso systemu przy pomocy VirtualBox  
+ 3. Zainstaluj na obrazie dysku  

#### Wymagania

`Wymagana pamięć ram: 1 GB` : Idealnie 512 MB dla systemu-gościa i 512 MB dla gospodarza. (może zostać uruchomiony na mniejszej ilości pamięci, ale nie spodziewaj się dobrych osiągów).

`Miejsce na twardym dysku:`  chociaż VirtualBox jes bardzo mały (typowa instalacja zmajmie około 30 MB twardego dysku), to wirtualne maszyny wymagają całkiem dużych plików na dysku, które reprezentują własne twarde dyski. Więć, aby zainstalować np. MS Windows XP (TM), będziesz potrzebować plik, który może mieć kilka GB. Aby mieć siductionaa w VirtualBox, potrzebujesz przydzielić 5 GB na obraz dysku plus powierzchnię na swap.

### Instalacja:

~~~  
apt-get update  
apt-get install virtualbox-ose-qt virtualbox-source dmakms module-assistant  
~~~

Spreparuj moduł:

~~~  
m-a prepare  
m-a a-i virtualbox-source  
~~~

Aktywuj moduł dynamiczny Module-Assistant wsparcia modułów jądra dla virtualboxa, aby następnym razem kiedy jądro Linuksa będzie aktualizowane moduł virtualboxa został przygotowany także, bez potrzeby ręcznej interwencji. Aby to wykonać, dodaj `virtualbox-source`  do pliku konfiguracyjnego `/etc/default/dmakms` . 

~~~  
mcedit /etc/default/dmakms  
virtualbox-source  
~~~

Następnie zrestartuj komputer.

 [This is essential reading on dmakms](sys-admin-kern-upg-pl.htm#dmakms) 

### Instalacja siductiona na wirtualnej maszynie

Użyj kreatora virtualboksa do stworzenia nowej maszyny wirtualnej dla siductiona. Następnie postępuj według instrukcji dla zwykłej instalacji siductiona.

 [VirtualBox posiada pełną pomoc w formie PDF, którą możesz pobrać.](http://www.virtualbox.org/)  

<div class="divider" id="qemu"></div>
## >Uruchamianie i instalacja wirtualnej maszyny QEMU

+ 1. Utworzenie obrazu twardego dysku dla qemu  
+ 2. Start iso przy pomocy qemu  
+ 3. Instalacja na obrazie  

Dostępne jest graficzne narzędzie z interfejsem QT GUI pomocne w konfiguracji QEMU:

~~~  
apt-get install qtemu  
~~~

#### Utworzenie obrazu twardego dysku

Aby qemu mógł działać, będziesz potrzebować obraz dysku twardego. Jest to plik, który symuluje dysk twardy.

Użyj polecenia:

~~~  
qemu-img create -f qcow siduction.qcow 3G  
~~~

aby stworzyć plik obrazu o nazwie "siduction.qcow". Parametr "3G" określa wielkość dysku - w tym przypadku 3 GB. Możesz użyć przyrostka M dla megabajtów (np. "256M"). Nie musisz się martwić utworzeniem zbyt dużego dysku - qcow format kompresuje obraz, więc pusta przestrzeń nie powoduje zwiększenia pliku.

#### Instalacja systemu operacyjnego

Teraz musisz po raz pierwszy uruchomić emulator. Pamiętaj o jednej rzeczy: kiedy klikniesz wewnątrz okna qemu, wskaźnik myszy zostanie przechwycony. Aby go "uwolnić", wciśnij Ctrl+Alt.

  
Jeśli chcesz skorzystać z bootowalnej dyskietki, uruchom Qemu w następujący sposób:  


~~~  
qemu -floppy siduction.iso -net nic -net user -m 512 -boot d siduction.qcow  
~~~

jeśli twój CD-ROM jest bootowalny, uruchom Qemu z tymi opcjami:

~~~  
qemu -cdrom siduction.iso -net nic -net user -m 512 -boot d siduction.qcow  
~~~

Teraz zainstaluj siductiona jakbyś to robił na prawdziwym dysku.

#### Uruchamianie systemu

Aby uruchomić system, wpisz:

~~~  
qemu [hd_image]  
~~~

  
Dobrym pomysłem jest stworzenie obrazu overlay. W ten sposób możesz stworzyć obraz twardego dysku raz i qemu będzie zapisywać zmiany w zewnętrznym pliku. Pozbywasz się w ten sposób problemów z niestabilnym działaniem, ponieważ łatwo jest wrócić do poprzedniego stanu systemu.  


Aby utworzyć obraz overlay, napisz:

~~~  
qemu-img create -b [[base''image]] -f qcow [[overlay''image]]  
~~~

Zastąp obraz twardego dysku dla base_image (w naszym przypadku siduction.qcow). Potem możesz uruchomić qemu:

~~~  
qemu [overlay_image]  
~~~

  
Oryginalny obraz pozostanie nietknięty. Należy pamiętać, że podstawowy obraz nie może być przeniesiony lub mieć zmienioną nazwę, overlay pamięta jego pełną ścieżkę.  


#### Użycie prawdziwej partycji jako jednej partycji podstawowej na obrazie twardego dysku

  
Czasami możesz chcieć użyć jednej z twoich partycji systemowych z qemu (na przykład, jeśli chcesz wystartować twój komputer i qemu z podanej partycji). Możesz to zrobić używając oprogramowania RAID w trybie liniowym (potrzebujesz sterownik linear.ko) i urządzenie loopback: sztuczka polega na dynamicznym dodaniu master boot rekordu (MBR) do rzeczywistej partycji, którą chcesz dodać do obrazu dysku qemu.  


Załóżmy, że masz niezamontowaną partycję /dev/sdaN z jakimś systemem plików i chcesz ją włączyć do obrazu dysku qemu. Najpierw stwórz mały plik, by przechować MBR:

~~~  
 dd if=/dev/zero of=/sciezka/do/mbr count=32   
~~~

Tu został stworzony 16 KB (32 * 512 bytes) plik. Ważne, aby plik nie był zbyt mały (nawet jeśli MBR potrzebuje tylko pojedynczy 512-bajtowy blok), ponieważ im mniejszy będzie, tym mniejszy będzie musiał być fragment oprogramowania urządzenia RAID, co może wpłynąć na wydajność. Następnie należy skonfigurować urządzenie loopback na pliku MBR:

~~~  
losetup -f /sciezka/do/mbr  
~~~

Załóżmy, że utworzone urządzenie to /dev/loop0, ponieważ nie korzystaliśmy do tej pory z innych urządzeń loopback. Następnym krokiem jest stworzenie "złączonego" MBR + /dev/sdaN obrazu dysku przy użyciu oprogramowania RAID:

~~~  
modprobe linear  
mdadm --build --verbose /dev/md0 --chunk=16 --level=linear --raid-devices=2 /dev/loop0 /dev/sdaN  
~~~

Powstały /dev/md0 jest tym, co będziemy używać jako obraz dysku dla qemu (nie zapomnij ustawić uprawnień, by emulator miał do niego niego dostęp). Ostatnim (i w pewnym stopniu skomplikowanym) krokiem jest ustawienie konfiguracji dysku (geometria dysku i tablica partycji), aby miejsce rozpoczynania się partycji podstawowej w MBR był zgodny z tym z /dev/sdaN wewnątrz /dev/md0 (offset dokładnie 16 * 512 = 16384 bajtów w tym przykładzie). Zrób to używając fdisk na rzeczywistym urządzeniu, nie na emulatorze: domyślny program wykrywania dysku z qemu często daje wynik nie zaokrąglony do kilobajtowego offsetu (jak 31.5 KB), który nie może być przyjęty przez oprogramowanie RAID. W związku z tym, na rzeczywistym sprzęcie:

~~~  
fdisk /dev/md0  
~~~

Następnie stwórz pojedynczą partycję podstawową odpowiadającą /dev/sdaN, i eksperymentuj z poleceniem 's'ector z 'x'pert menu, aż pierwszy cyliner (gdzie zaczyna się pierwsza partycja) będzie zgodny z wielkością MBR. Na koniec, 'w'rite (zapisz) wynik do pliku: zadanie zakończone. Masz teraz partycję, którą możesz zamontować bezpośrednio z rzeczywistego systemu, jak również jako część obrazu dysku qemu:

~~~  
qemu -hdc /dev/md0 [...]  
~~~

Możesz oczywiście ustawić menadżer uruchamiania na obrazie dysku używając qemu, oryginalna partycja /boot/sdaN partition zawiera niezbędne narzędzia.

<!--#### Używanie modułu QEMU Accelerator

 Programiści qemu stworzyli opcjonalny moduł kernela, aby przyspieszyć qemu czasami do poziomu systemu natywnego. Moduł powinien być ładowany z opcją

~~~  
major=0  
~~~

aby zautomatyzować tworzenie potrzebnego urządzenia /dev/kqemu. Następujące polecenie

~~~  
echo "options kqemu major=0" >> /etc/modprobe.conf  
~~~

Zmodyfikuje to plik modprobe.conf, aby upewnić się, że parametr modułu jest dodawany za każdym razem, gdy moduł jest ładowany.

~~~  
qemu [...] -kernel-kqemu  
~~~

Udostępnia to pełną wirtualizację i przez co wyraźnie zwiększa szybkość.

#### Aby aktywować qemu:

~~~  
qemu -cdrom /tmp/pkg/siduction-debug.iso -net nic -net user -m 512  
-->  
~~~

 [Oficjalna dokumentacja projektu QEMU](http://www.nongnu.org/qemu/user-doc.html)  

 [Część treści dot. QEMU dla instrukcji siductiona było pobrane z tej strony na licencji GNU Free Documentation License 1.2 i zmodyfikowane dla instrukcji siductiona](http://wiki.archlinux.org/index.php/Qemu)  

<div id="rev">Page last revised 18/09/2011 1010 UTC</div>
