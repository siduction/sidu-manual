<div id="main-page"></div>
<div class="divider" id="disknames"></div>
## Nazewnictwo dysków

##### **`UWAGA: w sprawie nazywania partycji patrz`**  [UUID, Nazywanie partycji i fstab](part-uuid-pl.htm) , ponieważ teraz siduction domyślnie używa UUID

#### Metody nadawania nazw

##### Dla dysków

Od czasu wprowadzenie udev, Universal Unique Identifier (UUID) i pojawienia się ostatnich kerneli linuksa, wszystkie urządzenia blokowe używają trzyliterowego oznaczenia i cyfrowego wyróżnika: `sda`  dla urządzeń dyskowych i `sdaX`  dla partycji twardych dysków.

Niezależnie, jaki standard jest użyty, PATA (IDE), SATA (Serial ATA), lub SCSI, jedynym sposobem odróżnienia jednego dysku od drugiego jest trzecia litera urządzenia `/dev/sda1, /dev/sdb1, /dev/sdc1, /dev/sdd1`  itp.

Możesz zobaczyć swoje urządzenia nazwane w ten sposób, gdy nakierujesz wskaźnik myszy na ikonę napędu na pulpicie siduction.org w trybie live lub instalacji na dysku.

Zalecamy stworzenie tabeli, na której znajdą się szczegóły dotyczące wszystkich urządzeń blokowych dostępnych w twoim komputerze. Chociaż jest to czynność nudna, może zaoszczędzić wiele czasu i problemów w przyszłości.

Plik siduction.org`/etc/fstab`  przechowuje nazwy `/dev/ sdaX`  ujęte w nawias kwadratowy w liniach komentarza ponad każdą informacją o montowanej partycji. Na przykład (pogrubienie tylko dla celów przykładu). 

~~~  
# added by siduction [ **/dev/sdd1 , no label]  
UUID=2ae950df-7d72-4d9b-a71a-bad1eb2d4f6a / ext4 defaults,errors=remount-ro,relatime 0 1  
~~~

##### Dla partycji

Jak widać powyżej, dla partycji `/dev/disk`  identyfikator jest uzupełniony przez liczbę. 

Istnieją następujące typy partycji: podstawowa, rozszerzona i logiczna (dysk logiczny); te ostatnie znajdują się na partycji rozszerzonej. Maksymalnie mogą istnieć 4 partycje podstawowe lub 3 podstawowe i 1 rozszerzona. Partycja rozszerzona może zawierać do 11 dysków logicznych. 

Partycje podstawowe lub rozszerzone mogą mieć nazwę pomiędzy sda1 i sda4. Partycje logiczne zawsze sąsiadują ze sobą i są częścią partycji rozszerzonej. Możesz zdefiniować (przy pomocy libata) maximum 11 takich partycji, a ich oznaczenia zaczynają się od liczby 5 (np. sda5) i kończą się 15 (sda15)

##### Kilka przykładów dla aplikacji

`/dev/sda5`  : może być tylko partycją logiczną (w tym przypadku pierwszą na swoim urządzeniu), prawdopodobnie umieszczoną na pierwszym dysku SATA lub IDE w twoim komputerze (zależy to od ustawień BIOS).

`/dev/sdb3`  może być tylko partycją podstawową lub rozszerzoną; oznaczenie literowe jest iine niż w pierszym przypadku, możemy tylko stwierdzić, że ta partycja na pewno nie znajduje się na tym samym urządzeniu.

#### Wcześniejsze i teraz przestarzałe oznaczenia dla urządzeń IDE

Na starszych systemach linuksowych, urządzenia dyskowe IDE (PATA) odróżniały się od tych, które stosują obecny standard przez nazwę `hdaX`  zamiast sdaX.

<div class="divider" id="partition"></div>
## Partycjonowanie dysku twardego przy pomocy cfdisk

**`Dla zwykłego użytku zalecamy system plików ext4, jest to domyślny system plików dla siduction.org i posiada dobre wsparcie techniczne.`**

Otwórz konsolę/xterm, zostań rootem i uruchom cfdisk:  *(jeśli pracujesz na systemie zainstalowanym na twardym dysku, musisz podać hasło roota)* 

~~~  
su  
cfdisk /dev/sda  
~~~

##### Interfejs użytkownika

Na pierwszym ekranie cfdisk wyświetla bieżącą tablicę partycji z nazwami i kilkoma informacjami o każdej partycji. Na ekranie poniżej znajdują się przyciski z poleceniami. Aby przechodzić między partycjami, użyj  **klawiszy nawigacyjnych: strzałka w górę i w dół** . Aby przejść między poleceniami, użyj  **klawiszy: lewej i prawej strzałki** 

##### Usuwanie partycji

![Delete a partition](../images-pl/cfdisk-pl/cfdisk0-pl.png "Delete a partition") 

Aby usunąć partycję, podświetl ją przy pomocy strzałek w górę i dół, wybierz polecenie

~~~  
Delete  
~~~

przy pomocy strzałek w lewo i prawo i wciśnij

~~~  
Enter  
~~~

##### Tworzenie nowej partycji

![Create a new partition](../images-pl/cfdisk-pl/cfdisk1-pl.png "Create a new partition") 

Aby stworzyć nową partycję, użyj polecenia:

~~~  
New  
~~~

(wybierz je przy pomocy strzałek w lewo i prawo), i wciśnij enter. Musisz zdecydować między partycją  **primary**  i  **logical** . Jeśli chcesz partycji logicznej, program stworzy ją automatycznie. Następnie musisz wybrać wielkość partycji (w MB). Jeśli nie możesz wpisać wartości w MB, wróć do głównego ekranu przy pomocy klawisza Esc, i wybierz MB przy pomocy polecenia 

~~~  
Units  
~~~

##### Typ partycji

![Type of a partition 1](../images-pl/cfdisk-pl/cfdisk2-pl.png "Type of a partition 1") 

Aby ustawić typ partycji dla  **Linux swap**  lub  **Linux** , podświetl partycję i użyj polecenia:

~~~  
Type  
~~~

Otrzymasz listę różnych typów. Naciśnij spację i otrzymasz dalszą część listy. Odnajdź typ partycji, który potrzebujesz i wpisz jego numer. ( **Linux swap**  to typ  **82** ,systemy plików  **Linux**  to  **83** )

![Type of a partition 2](../images-pl/cfdisk-pl/cfdisk3-pl.png "Type of a partition 2") 

##### Nadawanie partycji flagi "boot"

Nie ma potrzeby czynienia partycji bootowalnej dla linuksa, ale niektóre inne systemy tego potrzebują. Podświetl partycję i wybierz polecenie. Note: When installing on a external HD then one partition must be bootable:

~~~  
Bootable  
~~~

##### Zapisanie wyniku na dysk

Kiedy zakończysz, możesz zapisać dokonane zmiany przy użyciu polecenia Write. Tablica partycji zostanie zapisana na dysk. (jeśli pojawi się błąd dotyczący dos, możesz go zignorować). Ponieważ proces zniszczy wszystkie dane na partycjach, które usuwasz lub zmieniasz, powinieneś być pewny, że chcesz tego, zanim wciśniesz klawisz

~~~  
Return  
~~~

![Write the result to disk](../images-pl/cfdisk-pl/cfdisk4-pl.png "Write the result to disk") 

##### Wyjście

Aby zakończyć pracę z programem, wybierz polecenie Quit. Po opuszczeniu cfdiska, a przed rozpoczęciem formatowania czy instalowania, powinieneś uruchomić ponownie swój komputer, aby siduction mógł ponownie odczytać nową tablicę partycji.


---

<div class="divider" id="formating"></div>
## Formatowanie partycji (po partycjonowaniu przy pomocy cfdiska)

##### Podstawy

Partycja musi mieć system plików. Linux może korzystać z wielu systemów plików. Do wyboru mamy ReiserFs, Ext4, a dla doświadczonych użytkowników XFS i JFS. Ext2 jest przydatny jako format składowania danych, ponieważ istnieje sterownik dla windows umożliwiający wymianę danych między systemami. [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/) .

**`Dla zwykłego użytku zalecamy system plików ext4, jest to domyślny system plików dla siduction.org i posiada dobre wsparcie techniczne.`**

##### Formatowanie

Po zamknięciu  **cfdiska**  wracamy do konsoli. Aby formatować, musisz być rootem. Aby formatować partycję główną i/lub domową, w tym przykładzie  **hdb1** , wpisujemy:  *(jeśli pracujesz na systemie zainstalowanym na twardym dysku, musisz wpisać tu hasło roota)* 

~~~  
su  
mkfs -t ext4 /dev/hdb1  
~~~

Pojawi się pytanie, na które odpowiedz yes, jeśli jesteś pewny, że wybrałeś właściwą partycję.

Kiedy polecenie zakończy swoje działanie, otrzymasz informację, że przeniesienie formatu plików ext4 na twardy dysk zakończyło się sukcesem. Jeśli nie pojawi się ten komunikat, prawdopodobnie coś poszło źle z partycjonowaniem w cfdisku, lub hdb1 nie jest partycją linuksową. W tym przypadku możesz to sprawdzić przy pomocy:

~~~  
fdisk -l /dev/hdb  
~~~

Jeśli coś poszło źle, możesz spróbować partycjonowania drugi raz.

Jeśli formatowanie zakończyło się sukcesem, wykonaj tę samą procedurę dla partycji home, jeśli chcesz mieć oddzielną.

Na koniec formatujemy partycję swap, w tym przykładzie hdb3:

~~~  
mkswap /dev/hdb3  
~~~

a następnie:

~~~  
swapon /dev/hdb3  
~~~

Następnie sprawdzamy, swap jest rozpoznawany, poprzez wpisanie w konsolę:

~~~  
swapon -s  
~~~

nowo zamontowany swap powinien być teraz rozpoznawany, w naszym przypadku jako:

<table class="center">
| Filename | Type | Size | Used | Priority | 
| ---- | ---- | ---- | ---- | ---- |
| /dev/hdb3 | partition | 995988 | 248632 | -1 | 


---

Jeśli swap jest rozpoznawany poprawnie, wpisujemy

~~~  
swapoff -a  
~~~

i uruchamiamy ponownie komputer.

Teraz jesteśmy gotowi do rozpoczęcia instalacji.

<div id="rev">Strona ostatnio modyfikowana 14/08/2010 0100 UTC</div>
