<div id="main-page"></div>
<div class="divider" id="configure"></div>
## Konfiguracja siduction.org do użycia SAMBA - współdzielenie plików ze zdalnymi komputerami z Windows

Wykonuj wszystkie polecenia jako  **root**  (w terminalu lub konsoli) Wpisz URL w Konquerorze (uruchom Konquerora jako zwykły użytkownik.

`server = nazwa serwera lub IP komputera z windowsem  
`share = nazwa udziału` `

W KDE - Konqueror wpisz URL `smb://server`  lub pełne URL `smb://server/share` 

W konsoli możesz zobaczyć udziały umieszczone na serwerze poprzez wywołanie polecenia:

~~~  
smbclient -L server  
~~~

Aby zamontować udział w katalogu (z pełnym dostępem dla WSZYSTKICH użytkowników) zapamiętaj to:miejsce montowania musi istnieć. Jeśli go nie ma, najpierw musisz stworzyć katalog (nazwa jest dowolna):

~~~  
mkdir -p /mnt/server_share  
~~~

Następnie zamontuj udział - zdalny system plików VFAT:

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777 //server/share /mnt/server_share  
~~~

lub zdalny system plików NTFS:

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777,lfs //server/share /mnt/server_share  
~~~

Aby zakończyć połączenie, użyj polecenia:

~~~  
umount /mnt/server_share  
~~~

Jeśli chcesz umieścić wpis w  */etc/fstab* , aby uczynić montowanie łatwiejszym, wpisz następującą linię w tym pliku:

~~~  
//server/share /mnt/server_share cifs defaults,username=your_username,password=**********,file_mode=0777,dir_mode=0777 0 0  
~~~

<div class="divider" id="setup"></div>
## Jak skonfigurować siduction.org jako Samba-Server

Ponieważ samba nie znajduje się na live-cd siduction.org. musisz wykonać następujące polecenia, aby mieć dostęp do samba

~~~  
sux  
apt-get update  
apt-get install samba samba-tools smbclient smbfs samba-common-bin  
~~~

#### W przypadku instalacji na HD:

##### Example 1:

W przypadku sytemu zainstalowanego na twardym dysku, konieczne jest skonfigurowanie samba. Oto prosty przykład. Jeśli chcesz dowiedzieć się więcej o użyciu samba i konfiguracji linuksowego serwera samba  [zalecamy przeczytanie dokumentacji samba.](http://us5.samba.org/samba/) .

Aby skonfigurować Sambę postępuj jak poniżej:

otwórz plik `/etc/samba/smb.conf`  w edytorze (np. kedit or kwrite) i wpisz:

~~~  
# Zmiany globalne - wszystko tak proste jak to jest  
#możliwe - brak haseł, działa jak Windows 9x  
[global]  
security = share  
workgroup = WORKGROUP  
# udział bez prawa zapisu -ważne gdy system plików NTFS ma być współdzielony!  
[WINDOWS]  
comment = Windows Partition  
browseable = yes  
writable = no  
path = /media/sda1 # <-- ustaw dla swojej partycji  
public = yes  
# Współdzielenie partycji z prawami zapisu- partycja musi być montowana  
# z prawem zapisu - ma sens w przypadku np. FAT32.  
[DATA]  
comment = Partycja z danymi (pierwszy dysk logiczny)  
browseable = yes  
writable = yes  
path = /media/sda5  
public = yes  
~~~

Restart the samba server

~~~  
/etc/init.d/samba restart  
~~~

#### Example 2:

~~~  
groupadd smbuser  
useradd -g smbuser <the-user-you-want>  
smbpasswd -a <the-user-you-want>  
smbpasswd -e <the-user-you-want>  
~~~

Next edit `/etc/samba/smb.conf`  to give it share permissions, (be careful with what folders you enable), for example:

~~~  
[homes]  
comment = Home Directories  
browseable = yes.  
writeable = yes  
[media, be careful!]  
path = /media  
browseable = yes  
read only = no  
#read only = yes  
guest ok = no  
writeable = yes  
[video]  
path = /var/lib/video  
browseable = yes  
#read only = no  
read only = yes  
guest ok = no  
#any other folder you want to share with windows/linux/mac  
#path = path = /media/xxxx/xxxx  
#browseable = yes  
#read only = no  
#read only = yes  
#guest ok = no  
~~~

Restart the samba server

~~~  
/etc/init.d/samba restart  
~~~

## Sprawdzanie udziałów w sambie

Aby ustawić udziały w sambie bez względu na bezpieczeństwo, wykonaj następujące polecenia (np. dla konfiguracji LAN):

Ustaw uprawnienia katalogu i jego zawartości na przynajmniej -rwxr-xr-x:

~~~  
ls -la sciezkaDo/nazwaUdzialu/*  
~~~

Jeśli nie, wykonaj:

~~~  
chmod -R 755 sciezkaDo/nazwaUdzialu  
~~~

Jeśli chcesz, aby była możliwość zapisu:

~~~  
chmod -R 777 dirShareName  
~~~

Sposób, by sprawdzić, że udział jest dostępny: (nie zapomnij uruchomić serwer):

~~~  
smbclient -L localhost  
~~~

Powinieneś zobaczyć coś takiego:

~~~  
smbclient -L localhost  
Password:  
Domain=[HOME] OS=[Unix] Server=[Samba 3.0.26a]  
Sharename Type Comment  
--------- ---- -------  
IPC$ IPC IPC Service (3.0.26a)  
MaShare Disk comment  
print$ Disk Printer Drivers  
Domain=[MSHOME] OS=[Unix] Server=[Samba 3.0.26a]  
~~~

Jeśli nie ustawiłeś hasła, po prostu wciśnij ENTER

Nie zapomnij zapisać zmiany. Teraz możesz uruchomić/zatrzymać sambę:

~~~  
/etc/init.d/samba start  
~~~

i

~~~  
/etc/init.d/samba stop  
~~~

Możesz również uruchomić/zatrzymać sambę automatycznie w czasie startu systemu:

~~~  
update-rc.d samba defaults  
~~~

Teraz samba wystartuje, kiedy system zostanie uruchomiony i zostanie zatrzymany przy wyłączeniu komputera.

 [Więcej informacji o sambie.](http://wiki.linuxquestions.org/wiki/Samba) .

<div id="rev">Strona ostatnio modyfikowana 05/03/2011 0540 UTC</div>
