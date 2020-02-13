<div id="main-page"></div>
<div class="divider" id="burning-no-gui"></div>
## Wypalanie CD/DVD bez GUI 

###### **`BARDZO WAŻNE:`** `siduction, jako linux LIVE-CD, jest oparty na technologii wysokiej kompresji plików, i dlatego wymagane jest poświęcenie specjalnej uwagi wypalaniu obrazu ISO. Zaleca się wykorzystywanie jedynie wysokiej jakości nośników CD / DVD+R oraz wypalanie ich w **`trybie DAO (disk-at-once)`** , nie prędkością nie większą niż x8.` 


---

## burniso

Nie potrzebujesz GUI (graficznego interfejsu użytkownika), aby wypalić CD / DVD. 

 Problemy z wypalaniem płyt zwykle dotyczą programów typu frontend (graficzne nakładki typu k3b), a nie backend (growisofs, wodim lub cdrdao). 

`siduction dostarcza gotowego skryptu "burniso" aby wypalać siduction ISO.` 

burniso wypala obrazów ISO używając wodim w trybie Disk-At-Once z nastawioną prędkością 8x. 

~~~  
apt-get install siduction-scripts  
~~~

`Jako $użytkownik:` 

~~~  
$ cd /twój/katalog/ISO  
~~~

~~~  
$ burniso  
~~~

Wszystkie obrazy ISO w katalogu będą wyświetlane. Wypalanie startuje bezpośrednio po wyboru ISO. Upewnij się przed wykonianiem skryptu że twoja CD / DVD włożona.

<div class="divider" id="burn-no-gui-gen"></div>
## Urządzenia do użycia (jako $użytkownik):

  
Dla urządzeń ATAPI możemy to sprawdzić przy pomocy polecenia:  


wodim:

~~~  
$ wodim --devices  
wodim: Overview of accessible drives (2 found) :  
---------------------------------------------------------  
0 dev='/dev/scd0' rwrw-- : 'AOPEN' 'CD-RW CRW2440'  
1 dev='/dev/scd1' rwrw-- : '_NEC' 'DVD_RW ND-3540A'  
---------------------------------------------------------  
~~~

Kilka alternatywnych metod:

~~~  
$ wodim dev=/dev/scd0 driveropts=help -checkdrive  
~~~

oraz

~~~  
$ wodim -prcap  
~~~

cdrdao - sprawdzenie sprzętu:

~~~  
$ cdrdao scanbus  
Cdrdao version 1.2.1 - (C) Andreas Mueller  
ATA:1,0,0 AOPEN , CD-RW CRW2440 , 2.02  
ATA:1,1,0 _NEC , DVD_RW ND-3540A , 1.01  
~~~

### Oto kilka przydatnych przykładów:

#### Informacja o czystym dysku CD/DVD:

~~~  
$ wodim dev=/dev/scd0 -atip  
~~~

lub

~~~  
$ cdrdao disk-info --device ATA:1,0,0  
~~~

#### Kasowanie dysku wielokrotnego zapisu:

~~~  
$ wodim -blank=fast -v dev=/dev/scd0  
~~~

lub

~~~  
$ cdrdao blank --device ATA:1,0,0 --blank-mode minimal  
~~~

#### Klonowanie cd:

~~~  
$ cdrdao copy --fast-toc --device ATA:1,0,0 --buffers 256 -v2  
~~~

#### Klonowanie cd "w locie":

~~~  
$ cdrdao copy --fast-toc --source-device ATA:1,1,0 --device ATA:1,0,0 --on-the-fly --buffers 256 --eject -v2  
~~~

#### Tworzenie audio-cd z plików wav z prędkością 12x:

~~~  
$ wodim -v -eject -pad -dao speed=12 dev=/dev/scd0 defpregap=0 -audio *.wav  
~~~

#### Wypalanie cd z plików bin/cue:

~~~  
$ cdrdao write --speed 24 --device ATA:1,0,0 --eject filenam.cue  
~~~

#### Wypalanie obrazu ISO:

~~~  
$ wodim dev=/dev/scd0 driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

Jeśli pojawi się błąd `driveropts` , to dlatego bo `burnfree`  nieobsługiwuje niektórych palników, wykonaj polecenie:

~~~  
$ wodim dev=/dev/scd0 driveropts=noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

lub

~~~  
$ wodim dev=/dev/scd0 fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

#### Tworzenie obrazu ISO ze wszystkich plików (i podkatalogów) katalogu.

~~~  
$ genisoimage -o siduction.iso -r -J -l katalog  
~~~

#### Możesz także użyć growisofs, aby wypalić DVD (n.p. obraz ISO):

~~~  
$ growisofs -dvd-compat -Z /dev/dvd=siduction.iso  
~~~

#### Wypalanie wielu plików na DVD:

~~~  
$ growisofs -Z /dev/dvd -R -J plik1 plik2 plik3 ...  
~~~

#### Jeśli pozostało miejsce na płycie, możesz dodać więcej plików:

~~~  
$ growisofs -M /dev/dvd -R -J kolejnyplik ikolejnyplik...  
~~~

#### Aby zakończyć sesję, użyj polecenia:

~~~  
$ growisofs -M /dev/dvd=/dev/zero $  
~~~

<div id="rev">Page last revised 29/01/2012 2000 UTC</div>
