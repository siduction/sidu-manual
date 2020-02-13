<div id="main-page"></div>
<div class="divider" id="rootpw"></div>
## siduction-*.iso - Hasło administratora w trybie Live

<p class='highlight-2'>Uwaga: Gdy uruchamiasz coś z prawami roota, powinieneś wiedzieć, co robisz! Do przeglądania stron nie wymaga się uprawnień roota.</p>
### Domyślne hasło dla siduction-*.iso

siduction nie ma ustawionego hasła administratora w trybie live. Jeśli chcesz uruchomić program, który wymaga jego uprawnień, masz kilka możliwości:

Najprościej, wpisz w konsoli:

~~~  
sux  
~~~

###### Ustawienie (tymczasowego) hasła administratora

Otwórz konsolę:

~~~  
siduction@0[siduction]$ sudo passwd  
Enter new UNIX password:  
Retype new UNIX password:  
passwd: password updated successfully  
siduction@0[siduction]$  
~~~

teraz możesz używać tego hasła na resztę sesji w trybie Live.

`sudo nie jest wspierane w instalacjach na dysku, patrz`  [sudo](term-konsole-pl.htm#sudo)  oraz  [sux](term-konsole-pl.htm#sux) .

###### Wykonywanie programów w powłoce roota

Wpisanie `sux`  nada Ci uprawnienia Xapp.

Otwórz konsolę:

~~~  
siduction@0[siduction]$ sux  
root@0[siduction]# gparted  *(lub inny program...)*   
~~~

Niektóre aplikacje KDE wymagają wywołania `dbus-launch`  przed aplikacją:

~~~  
dbus-launch <Application>  
~~~

Inną opcją ogólną dla większości Menedżerów Pulpitu jest:

~~~  
Alt+F2 su-to-root -X -c <Application>  
~~~

Dla przykładu:

~~~  
Alt+F2 su-to-root -X -c gparted  
~~~

`Aby zakończyć tryb roota, wpisz w konsoli:`

~~~  
exit  
~~~

lub po prostu kliknij w górnym prawym rogu, aby zamknąć konsolę.

**`W przypadku wygasnięcia ekranu w siduction-*.iso potrzebujesz wykonać co następuje i podążać za podpowiedziami aby ustawić hasło:`** 

~~~  
alt+ctrl+F1  
sudo passwd  
~~~

Kiedy już hasło jest aktywne, wykonaj:

~~~  
alt+ctrl+F7  
~~~

<div class="divider" id="live-cd-installsoft"></div>
## Instalacja oprogramowania w trybie Live-CD

~~~  
apt-get update  
apt-get install wybrany-pakiet  
~~~

Uwaga: kiedy wyłączysz komputer, zmiany nie zostaną zachowane, chyba, że włączysz  [fromiso i persist](hd-install-opts-pl.htm#fromiso-persist) .

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
