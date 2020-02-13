<div id="main-page"></div>
<div class="divider" id="raw-usb"></div>
## Instalacja siduction-ISO na piórze USB, karcie SSD, urządzeniu SDHC przy użyciu dystrybucji Linux, MS Windows(tm); lub Mac OS X(tm);

 Poniżej opisana metoda umożliwia, niezależnie od systemu operacyjnego, zainstalowanie siduction-ISO na piórze USB, karcie SSD, urządzeniu SDHC (Secure Digital High Capacity card).

 siduction-ISO zostanie zapisane na urządzeniu i nawet gdy opcja persist nie jest możliwa, pozwoli ci mieć siduction-na-nośniku. 

 Jeśli opcja persist jest wymagana, zalecaną metodą jest instalacja z dostępnego istniejącego systemu siduction za pomocą install-usb-gui, ponieważ nie posiada żadnych ograniczeń. Patrz też  [Instalacja na nośniku USB/SD/flash fromiso, siduction-on-a-stick](hd-install-opts-pl.htm#usb-from1) .

### Warunki

+ `Upewnij się, że BIOS komputera, na którym chcesz rozpocząć siduction-on-a-stick/card, pozwala na uruchamianie z pióra USB lub karty SSD. Zwykle, w przypadku gdy komputer wykorzystuje protokół USB 2.0 obsługuje także ładowanie systemu z USB/SSD.`   
+ Urządzenie USB/SSD powinno zostać rozpoznane automatycznie i powinna być dostępna opcja menu `F4`  wskazujaca `Hard Disk` , w innym przypadku wywołaj `F4 >Hard Drive`  lub dodaj `fromhd`  w linii uruchamiania boot menu.  
+ **`Ważne jest, aby pamiętać, że następujące metody nadpiszą i zniszczą każdą istniejącą tablicę partycji na docelowym nośniku. Utrata danych zależy od wielkości siduction-*.iso. Linux nie ogranicza dostępna pamięci i może być możliwe odzyskanie wszystkich danych, które ISO nie nadpisało. Wydaje się że MS Windows dopuszcza tylko jedną partycję. Więc proszę bądź ostrożny i nie rób tego na twardym dysku 100GB i wiekszym! Zawsze rób kopie zapasowe danych!`**   

 [Linux](#raw-lin)  &nbsp; [MS Windows](#raw-ms)  &nbsp; &nbsp; [Mac OS X](#raw-mac)  

<div class="divider" id="raw-lin"></div>
### Systemy operacyjne Linux

 Podłącz pióro USB lub czytnik z kartą, na którą chcesz dokonać zapisu. Wykonaj kod:

~~~  
cat /path/to/siduction-*.iso > /dev/USB_raw_device_node  
~~~

lub

~~~  
dd if=/path/to/siduction-*.iso of=/dev/sdf  
~~~

###### Przykład:

 Podłącz urządzenie, uruchom `dmesg`  i spójrz na wynik:

~~~  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sdf: sdf1 sdf2  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Attached SCSI removable disk  
~~~

Zakładając, że ISO `siduction-release.iso`  został pobrany, (można zmienić tą nazwę na `siduction-release.iso` ), wykonaj kod:

~~~  
cat /home/username/siduction-release.iso > /dev/sdf  
~~~

lub

~~~  
dd if=/home/username/siduction-release.iso of=/dev/sdf  
~~~

Urządzenie USB/SSD powinno zostać rozpoznane automatycznie i powinna być dostępna opcja menu `F4`  wskazujaca `Hard Disk` , w innym przypadku wywołaj `F4 >Hard Drive`  lub dodaj `fromhd`  w linii uruchamiania boot menu.

<div class="divider" id="raw-ms"></div>
### Systemy MS Windows(tm);

Metoda szybka i prosta. Zainstaluj program o nazwie  [flashnul](http://shounen.ru/soft/flashnul/) , ([strona pobrania programu](http://shounen.ru/soft/flashnul/#download)).

Zanotuj dokładną nazwę programu 'flashnul', ponieważ po rozpakowaniu pliku pokaże się jako folder o nazwie flashnul-xx, (na przykład 'flashnul-1rc1.zip' pobrany, rozpakowany i zainstalowany w 'Program Files' ma folder o nazwie flashnul-1rc1, który zawiera folder o nazwie flashnul-1rc1, który z kolei zawiera program flashnul i związane z nim pliki oraz foldery, które tym samym będą używane w całym tym przykładzie.)

Podłącz pióro/kartę

Jeśli rozpakowałeś i zainstalowałeś flashnul do folderu Program Files i nie masz pewności, gdzie nośnik USB został zamontowany w systemie, uruchom kod 'flashnul -p' klikając `run`  z menu, a następnie wpisz kod `cmd`  aby otworzyć terminal. Przejdź do folderu programu flashnul, zawierającego wszystkie szczególne pliki, w tym przypadku:

~~~  
cd C:\Program Files\flashnul-1rc1\flashnul-1rc1\  
flashnul -p  
~~~

Wynik powinien pokazać coś takiego: 

~~~  
Available physical drives:  
0 size = 60022480896 (55 Gb))  
1 size = 2003828736 (1911 Mb)  
~~~

Zakładając, że ISO `siduction-release.iso`  został pobrany, (można zmienić tą nazwę na `siduction-release.iso` ), wytnij i wklej (lub skopiuj) do folderu flashnul-1rc1, zawierającego wszystkie szczególne pliki i foldery programu. 

Jeśli przykładowo wynik 'flashnul-p' pokazał urządzenie USB zamontowane na **`1`** . Wpisz następujący kod i naciśnij klawisz Enter (uprawnienia administratora mogą być wymagane):

~~~  
flashnul 1 -L siduction-release.iso  
~~~

MS Win7 może potrzebować określonej litery dysku, na przykład D: lub c:\ :

~~~  
flashnul D: -L c:\flash\siduction-2010-01-kde-lite.iso  
~~~

Urządzenie USB/SSD powinno zostać rozpoznane automatycznie i powinna być dostępna opcja menu `F4`  wskazujaca `Hard Disk` , w innym przypadku wywołaj `F4 >Hard Drive`  lub dodaj `fromhd`  w linii uruchamiania boot menu.

<div class="divider" id="raw-mac"></div>
### System Mac OS X(tm); 

Podłącz urządzenie USB. Mac OS X powinien automatycznie je zamontować. W terminalu (znajdź go w folderze Aplikacje &gt; Narzędzia), wykonaj:

~~~  
diskutil list  
~~~

Ustal jak zostało nazwane urządzenia USB, a następnie odmontuj partycje na urządzeniu (załóżmy /dev/disk1): 

~~~  
diskutil unmountDisk /dev/disk1  
~~~

Zakładając, że ISO `siduction-release.iso`  został pobrany do `/Users/username/Downloads/` , (można zmienić tą nazwę na `siduction-release.iso` ) oraz gdy urządzenie USB jest oznaczony jako `disk1` , wykonaj:

~~~  
dd if=/Users/username/Downloads/siduction-release.iso of=/dev/disk1  
~~~

Urządzenie USB/SSD powinno zostać rozpoznane automatycznie i powinna być dostępna opcja menu `F4`  wskazujaca `Hard Disk` , w innym przypadku wywołaj `F4 >Hard Drive`  lub dodaj `fromhd`  w linii uruchamiania boot menu.

<div id="rev">Page last revised 04/05/2011 1540 UTC</div>
