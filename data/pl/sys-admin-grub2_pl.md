<div id="main-page"></div>
<div class="divider" id="grub2"></div>
## GRUB 2

###### Podsumowanie istotnych różnic między GRUB 1 (teraz grub-legacy) i GRUB 2:

+ `Plik menu.lst już nie istnieje.`   
+ Plik `grub.cfg`  teraz kontroluje ekran Grub.  
+ grub.cfg automatycznie stworzony poprzez skrypty w `/etc/grub.d` .  
+ Nazwa partycji również się zmienia. Numeracja zaczyna się od 1 partycji, a nie 0 (numeracja napędów (drives) się nadal zaczyna od 0):  
   ~~~    
   Linux grub1 grub2    
   /dev/sda1 (hd0,0) (hd0,1)    
   /dev/sda2 (hd0,1) (hd0,2)    
   /dev/sda3 (hd0,2) (hd0,3)    
   /dev/sdb1 (hd1,0) (hd1,1)    
   /dev/sdb2 (hd1,1) (hd1,2)    
   /dev/sdb3 (hd1,2) (hd1,3)    
   ~~~
  
+ Strofy (stanzas) w grub.cfg mają inną składnie niż w menu.lst i nie można je bezpośrednio kopiować z menu.lst (Grub 1) do grub.cfg (Grub 2). **`Plik grub.cfg nigdy nie ma być zmieniany ręcznie.`**   

<div class="divider" id="grub2-files"></div>
#### Plik konfiguracyjny dla Grub2

Plik `/etc/default/grub`  zawiera zmienne ustawieniathe dla Grub2, np. limit czasu w menu (timeout), podstawowe ustawienia w menu, parametry jądra, interfejs graficzny Grub i inne.

#### Skrypty dla Grub2

`/etc/grub.d`  sterowuje plik docelowy `grub.cfg` , który się znajduje w katalogu `/boot/grub/` .

**`Plik grub.cfg nigdy nie ma być zmieniany ręcznie.`**  Wszystkie zmiany muszą być wykonywane w plikach skryptowych w `/etc/grub.d` . os-prober powinien rozwiązać poprawnie w 90% z przypadków :

~~~  
00_header:  
05_debian_theme: ustawia tło, kolory tekstu, motyw graficzny  
10_hurd: lokalizuje jądra hurd  
10_linux: lokalizuje jądro Linuksa oparte na wynikach polecenia lsb_release.  
20_memtest86+: jeżeli /boot/memtest86+.bin istnieje, to bedzie integrowany w startowym menu  
30_os-prober: wyszukiwa w każdej partycji systemów operacyjnych (Linux i inne) i integruje je w startowym menu  
40_custom: szablon do tworzenia niestandardowych elementów w menu dla innych systemów operacyjnych  
60_fll-fromiso: szablon do tworzenia niestandardowych elementów w menu dla fromiso na USB flash/karte SSD.  
<span class="highlight-2">60_fll-fromiso nie ma być zmieniany ręcznie. Używa /etc/default/grub2-fll-fromiso.  
Więcej informacji pod  [fromiso z Grub2](hd-install-opts-pl.htm#grub2-fromiso) </span>  
~~~

Gdy zmiany są dokonane, grub.cfg musi o tym wiedzieć. Po aktualizacji jądra siduction, aktualizacja grub automatycznie będzie wykonywane. Zmiany, które zostały wykonane ręcznie, wymagają tego polecenia: 

~~~  
update-grub  
~~~

`Pakiet Grub2 w Debianie jest zaprojektowany tak, że zmiana ręczna rzadko jest konieczna.` 

<div class="divider" id="grub1-grub2"></div>
## Aktualizacja Grub Legacy na Grub 2

**`Zalecamy czystej aktualizacji na Grub 2 i do całkowitego usunięcia Grub 1.`**  Trzeba mieć świadomość, że można wszystko zepsuć więc bąć bardzo ostrożny. 

###### Krok 1: 

Upewnij się, że system jest pełny aktualizowany `(dist-upgrade w init 3)` .

~~~  
apt-get update  
Ctrl+alt+F1  
init 3  
apt-get dist-upgrade  
init 5 && exit  
~~~

###### Krok 2:

Usuń Grub 1, całkowicie: 

~~~  
rm -rf /boot/grub  
apt-get purge grub-gfxboot  
~~~

Efektem będzie, że: `fll-iso2usb* grub-gfxboot* install-usb-gui*`  będą usuwane. Kliknij `Y`  aby potwierdzić.

###### Krok 3:

~~~  
apt-get install grub2 os-prober  
~~~

![Grub2](../images-common/images-grub2/grub2-2.png "Grub2") 

Użyj klawisz TAB, aby wybrać OK. 

![Grub2](../images-common/images-grub2/grub2-3.png "Grub2") 

Użyj klawisz TAB, aby wybrać OK. 

![Grub2-conversion 1](../images-common/images-grub2/grub2-convert-1.png "Grub2-conversion 1") 

Użyj strzałek i space na klawiaturze, aby umieścić `* (gwiazdka)`  i wybrać dysk na którym w MBR grub2 będzie zapisany.  *(Ten przykład to instalacja na dysku USB)* .

###### Krok 4:

~~~  
update-grub  
~~~

###### Krok 5:

~~~  
apt-get install install-usb-gui fll-iso2usb  
~~~

###### Krok 6:

 Uruchom ponownie komputer i menu.cfg wyświetli jądra oraz system operacyjny i taką liste:

![Grub2-OS list](../images-common/images-grub2/grub2-os-list.jpg "Grub2-OS list") 

Jeśli coś poszło nie tak i grub2 jest uszkodzony, przeczytaj  [Korzystanie z chroot, aby przywrócić nadpisane lub uszkodzone Grub w MBR](sys-admin-grub2-pl.htm#chroot)  

### Edycja opcji startowych w grub2 poprzez ekran edycji 

![Grub2-Edit](../images-common/images-grub2/grub2-e-1.JPG "Grub2-Edit") 

Jeśli z jakiegoś powodu, musisz dokonać tymczasowych zmian w opcji bootowania jądra w grub2, naciśnij **`e`** . Do edycji opcji jądra przejdź za pomocą strzałek klawiatury do wiersza, którego chcesz edytować. Na ekranie edycji użyj kombinacji `Ctrl+x`  do ponownego startowania komputera z edytowanymi opcjami. 

Na przykład, aby przejść bezpośrednio do uruchomienia run level 3, dodaj `3`  na końcu linii `linux /boot/vmlinuz` .

Zmiany wprowadzone przez ekranu edycji i nie są trwałe. Aby osiągać trwałe zmiany, musisz edytować odpowiednie pliki. Czytaj to  [Plik konfiguracyjny dla Grub2](sys-admin-grub2-pl.htm#grub2-files) .

<div class="divider" id="multi-os"></div>
## Dualne i multi butowanie z Grub 2 

GRUB 2 ma modularną konfiguracje, co pozwala na proste polecenie, aby znaleźć zainstalowane nowe systemy operacyjne i zintegrować je automatycznie w pliku menu.cfg. To proste polecenie jest:

~~~  
update-grub  
~~~

Jeżeli niestandardowe polecenie pożądane jest w menu.cfg lub jeżeli 30_os-prober nie przeprowadza wymagane wpisy chainload w grub.cfg użyj edytora tekstu do zmiany`/etc/grub.d/40_custom` .

Przykłady dostosowywania pliku 40_custom:

~~~  
menuentry "second mbr"{  
set root=(hd1)  
chainloader +1  
}  
~~~

~~~  
menuentry "second partition"{  
set root=(hd0,2)  
chainloader +1  
}  
~~~

Po dokonaniu zmiany uruchom: 

~~~  
update-grub  
~~~

Gdy otrzymać informacji, że nie można znaleźć grub na dysku, oznacza to, że devicemap musi być regenerowany. 

`Upewnij się, że instalacja innego systemu operacyjnego nie zapisuje Grub w MBR, ale na partycji nowego systemu:` 

~~~  
grub-mkdevicemap --no-floppy  
update-grub  
~~~

Ostrzeżenia mogą być zignorowane. 

Jeśli się pomylisz, aktualizacja prawdopodobnie nadpisze MBR i trzeba to naprawić z  [Przywrócenie Grub 2](sys-admin-grub2-pl.htm#mbr-over-grub2) .

<div class="divider" id="mbr-over-grub2"></div>
## Tylko grub2 na nowo przepisać z dysku w MBR

~~~  
/usr/sbin/grub-install --recheck --no-floppy /dev/sda  
~~~

Być może, że to polecenie zostanie wykonane kilka razy, zanim system jest przekonany, że rzeczywiście powinno być wykonywane. 

## MBR nadpisany przez Windows - uszkodzony MBR - przywrócenie Grub 2 

**`NOTATKA: aby przywrócić grub2 potrzeba siduction.iso lub późniejczy.`**   [Alternatywnie, używaj chroot z dowolnym live.iso](sys-admin-grub2-pl.htm#chroot) .

Aby zapisywać lub przywrócić grub2 w MBR trzeba będzie uruchomić `siduction.iso` :

1. Aby identyfikować i potwierdzić partycji ([h,s]d[a..]X) musisz być root (#):  
   ~~~    
   $ sux    
   ~~~
  
2. Jako root wpisz:  
   ~~~    
   fdisk -l    
   cat /etc/fstab    
   ~~~
  
   To jest, aby uzyskać prawidłowe nazwy.  
3. Jeżeli prawidłowa nazwa partycji jest wyświetlana, trzeba utworzyć punkt montowania:  
   ~~~    
   mkdir -p /media/[hdxx,sdxx,diskx]    
   ~~~
  
4. Następnie, partycja będzie montowana:  
   ~~~    
   mount /dev/xdxx /media/xdxx    
   ~~~
  
5. Teraz można zapisywać Grub w MBR pierwszego dysku twardego:  
   ~~~    
   /usr/sbin/grub-install --recheck --no-floppy --root-directory=/media/xdxx /dev/sda    
   ~~~
  

<div class="divider" id="chroot"></div>
## Korzystanie z chroot, aby przywrócić nadpisane lub uszkodzone Grub w MBR

Aby przywrócić Grub (jeżeli został nadpisany lub uszkodzony w MBR) trzeba startować `chroot` -system. `Można używać każdą dowolną live.iso ponieważ system-chroot pokrywa się z instalacją na twardym dysku, i dlatego można przywrócić Grub1 (grub-legacy) lub Grub 2.` 

Wystartuj live siduction.iso, który jest odpowiedni do twojego systemu (32 lub 64 bit CD, DVD, USB flash lub karta SSD) i otwórz terminal. Wpisz `sux`  i naciśnij enter w celu uzyskania uprawnień roota. 

Z `fdisk -l`  lub `blkid`  można się upewnić, która partycja jest partycją bootowalną, i otrzymać poprawną nazwe (jeśli interfejs graficzny jest wymagany, użyj `Gparted)` :

~~~  
blkid  
~~~

Teraz możesz sprawdzić, czy wpisy w pliku fstab się równą z wynikiem z blkid:

~~~  
cat /etc/fstab  
~~~

Załóżmy, że główny system plików (root) jest na `/dev/sda2` 

~~~  
mkdir /mnt/siduction-chroot  
mount /dev/sda2 /mnt/siduction-chroot  
~~~

Następnie należy zamontować /proc, /run, /dev i /sys w następujący sposób: 

~~~  
mount --bind /proc /mnt/siduction-chroot/proc  
mount --bind /run /mnt/siduction-chroot/run  
mount --bind /sys /mnt/siduction-chroot/sys  
mount --bind /dev /mnt/siduction-chroot/dev  
mount --bind /dev/pts /mnt/siduction-chroot/dev/pts  
~~~

If you boot using an EFI system partition you will also need to mount it. Assuming this is /dev/sda1:

~~~  
mount /dev/sda1 /mnt/siduction-chroot/boot/efi  
~~~

Twój system chroot teraz jest skonfigurowany, aby móc się dostac:

~~~  
chroot /mnt/siduction-chroot /bin/bash  
~~~

Teraz jesteś w stanie użyć apt's local cache lub podręcznie zmienić i naprawić plików. Zachowanie jest takie, jakbyś pracował w systemie którego chcesz administrować. W poniższym przykładzie Grub zostanie przepisany w MBR. 

`Przywracanie Grub 2` 

~~~  
apt-get install --reinstall grub-pc  
~~~

To ensure that grub was installed to the correct disk or partition, run:

~~~  
dpkg-reconfigure grub-pc  
~~~

`To restore Grub 2 EFI` 

~~~  
apt-get install reinstall grub-efi-amd64  
~~~

`Przywracanie Grub 1 (grub-legacy)` 

~~~  
apt-get install --reinstall grub-legacy  
~~~

Postępuj instrukcji instalatora. 

Aby zwolnić chroot: 

~~~  
Ctrl+d  
~~~

Uruchom ponownie komputer. 

<div id="rev">Page last revised 21/10/2011 0330 UTC</div>
