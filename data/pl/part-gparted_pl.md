<div id="main-page"></div>
<div class="divider" id="partition"></div>
## Partycjonowanie twojego dysku HD z uzyciem Gparted/KDE Partition Manager

##### **`UWAGA: w sprawie nazewnictwa dysków`**  [sprawdź UUID, nazewnictwo partycji i fstab, ponieważ teraz siduction domyślnie używa UUID](part-uuid-pl.htm) 

##### Narzędzia partycjonujące mogą żądać hasła superużytkownika (root), wpisz `sux`  następnie swoje hasło. Przy pracy na Live-ISO, gdzie hasło nie jest ustawione `sux` , a następnie nacisnij 'enter' . Zobacz też:  [Tryb Live](live-mode-pl.htm) 


---


::: warning  
**Achtung**  
Zmiana wielkości partycji NTFS wymaga ponownego startu systemu! NIE WYKONUJ innych operacji na tej partycji przed ponownym uruchomieniem systemu, w przeciwnym razie pojawią się komunikaty o błędach. [Proszę przeczytaj to.](part-gparted-pl.htm#ntfs)   
:::

**`Zawsze twórz kopie zapasowe swoich danych!`**

### Podstawy

Partycja musi mieć system plików. Linux może korzystać z wielu systemów plików. Do wyboru mamy ReiserFs, Ext4, a dla doświadczonych użytkowników XFS i JFS. Ext2 jest przydatny jako format składowania danych, ponieważ istnieje sterownik dla MS Windows&#8482; umożliwiający wymianę danych między systemami.  [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/) .

**`Dla zwykłego użytku zalecamy system plików ext4, jest to domyślny system plików dla siduction.org i posiada dobre wsparcie techniczne.`**

## Użycie KDE Partition Manager &amp; Gparted

Tworzenie i zarządzanie partycjami nie jest czymś co wykonujemy na co dzień. Dlatego dobrym pomysłem jest przeczytanie tej instrukcji, aby czuć się komfortowo ze stosowanymi pojęciami i kilkoma panelami, które będą wyświetlane.

### KDE Partition Manager - uruchomienie w terminalu:

~~~  
sux  
partitionmanager  
~~~

### Gparted - uruchomienie w terminalu:

~~~  
sux  
gparted  
~~~

+ Kiedy GParted lub KDE Partition Manager jest uruchamiany, otwierane jest okno, a napędy są skanowane.
  
   W Menadżerze partycji KDE napędy są uwidocznione na liście z lewej strony.
  
   ![KDE Partition Manager partition information](../images-common/images-kpart/kpart-02.png "KDE Partition Manager partition information") 
  
   W Gparted, jesli klikniesz na menu (u góry z lewej), pojawia się rozwijana lista. Możesz wybrać odświeżenie listy napędów będących w Twoim systemie .
  
   ![gparted](../images-common/images-gparted/gparted02-en.png "Gparted Devices View") 
  

###### **`Powyższe ujęcie pokazuje Gparted. KDE Partition Manager zachowuje się w podobny sposób.`** 

+ ### Edycja
  
   W menu Edycja znajdują się trzy funkcje, które mogą okazać się istotne podczas przeprowadzania zmian:  
`Cofnij ostatnie działanie`   
`Wyczyść listę działań`   
`Zastosuj wszystkie działania` .
  
+ ### Widok
  
   <ul>  
   <li>  
   #### Device Information (Informacje o urządzeniu)
  
   Panel  **Harddisk Information**  pokazuje szczegóły informacji o twardym dysku, takie jak model, wielkość itp. jest on najbardziej użyteczny w przypadku systemu z wieloma dyskami, gdzie informacje są potrzebne do potwierdzenia, że badany dysk jest tym właściwym.
  
   ![operation view](../images-common/images-gparted/gparted03-en.png "Gparted Harddisk Information") 
  
+ #### Zaplanowane działania
  
   W dolnym oknie znajduje się lista operacji do przeprowadzania. Informacje są przydatne, ponieważ pokazują liczbę operacji w toku.
  

</li>
<li>
### Urządzenie

Device pozwala na ustawienie etykiety dysku.

</li>
<li>
### Partycja

To jest najważniejsze menu. Pozwala na wykonanie wielu operacji, część z nich jest niebezpieczna.

 **Usuń**  należy wybrać, gdy chcesz usunąć partycję. Aby wykonać operację, najpierw należy wybrać partycję.

 **Zmień rozmiar/Przenieś**  służy do zmiany wielkości lub przesunięcia partycji.

</li>
<li>
### Tworzenie nowej partycji

W pasku narzędzi, przycisk  **Nowa**  pozwala na stworzenie nowej partycji, jeśli wybrałeś nieprzydzielony obszar. Pojawi się nowe okno, które pozwoli ci wybrać wielkość partycji, typ (podstawowa, rozszerzona, dysk logiczny) i system plików.

![file system](../images-common/images-gparted/gparted07-en.png "Gparted New Partition") 

</li>
<li>
### Jeśli popełnisz błąd

Jeśli popełnisz błąd, możesz skorzystać z przycisku Delete, aby usunąć wybraną partycję, lub jeśli nie zatwierdziłeś swojej decyzji, możesz skorzystać z przycisku Undo.

![delete](../images-common/images-gparted/gparted04-en.png "Gparted Delete") 

</li>
<li>
### Zmiana wielkości/przenoszenie

Jeśli chcesz zmienić wielkość partycji, kliknij przycisk  **Resize/Move** , pojawi się wtedy nowe okno. Skorzystaj z myszy, by zmniejszyć (lub zwiększyć) partycję, wykorzystaj do tego celu strzałki.

![resize / move](../images-common/images-gparted/gparted05-en.png "Gparted Resize") 

Po poleceniu Zmień Rozmiar kliknij Zastosuj, ponieważ żadne operacje nie zostaną przeprowadzone, dopóki ich nie zatwierdzisz.

![operation view](../images-common/images-gparted/gparted09-en.png "Gparted Apply") 

Czas trwania operacji zależy od wielkości nowej partycji.

 **Po zmianach w tablicy partycji, wyloguj się z siduction.org i uruchom ponownie system, aby odczytać nową tablicę partycji.** 

</li>
</ul>
<div class="divider" id="ntfs"></div>
## Zmiana wielkości partycji NTFS


::: warning  
**Achtung**  
Zmiana wielkości partycji NTFS wymaga ponownego startu systemu! NIE WYKONUJ innych operacji na tej partycji przed ponownym uruchomieniem systemu, w przeciwnym razie pojawią się komunikaty o błędach.  
:::

+ Po uruchomieniu MS Windows&#8482;, system pokaże specjalny ekran i komunikat o spójności dysku: Sprawdzanie systemu plików na c :  
+ Pozwól AUTOCHK działać: NT potrzebuje sprawdzić swój system plików po operacji zmiany rozmiaru.  
+ Po zakończeniu procesu, komputer automatycznie się zrestartuje po raz drugi. Dzięki temu mamy pewność, że wszystko będzie działało doskonale  
+ Po ponownym uruchomieniu, Windows XP będzie działał prawidłowo, ale musisz pozwolić zakończyć start i poczekać na okno logowania!  

 **Pełna dokumentacja GParted** : Aby przeczytać pełną dokumentację zawierającą instrukcję kopiowania partycji, przejdź na stronę  [GParted](http://gparted.sourceforge.net) 

<div class="divider" id="hd-ntfs3g"></div>
## Jak zapisywać na partycji NTFS przy pomocy ntfs-3g

**` **Ostrzeżenie** : Mimo, że ntfs-3g osiągnął status 'stabilny', nie używaj go nigdy bez zewnętrznej kopii bezpieczeństwa i oczywiście nie na systemach produkcyjnych! Używasz go na własne ryzyko!`**

Otwórz konsolę i wpisz następujące polecenia: Patrz  [Partycjonowanie twardego dysku - nazewnictwo](part-cfdisk-pl.htm) 

~~~  
sux  
apt-get update && apt-get install ntfs-3g  
umount /media/xdxx  
mount -t ntfs-3g /dev/disk/by-uuid/xxyyzz[etc] /media/xdxx  
aby wyjść z konsoli wpisz: exit  
~~~

Teraz twoja partycja NTFS powinna być zamontowana w trybie  **rw**  i powinieneś móc zapisywać na niej dane. Ale pamiętaj, ostrzegamy! `Używaj ntfs-3g w nagłych wypadkach, nie jest rekomendowane codzienne wykorzystywanie tego oprogramowania.` 

<div id="rev">Strona ostatnio modyfikowana 14/08/2010 0100 UTC</div>
