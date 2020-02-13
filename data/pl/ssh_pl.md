<div id="main-page"></div>
<div class="divider" id="ssh"></div>
## SSH

W informatyce Secure Shell lub SSH jest zestawem standardów i protokołem sieciowym, który pozwala ustanowić bezpieczny kanał między lokalnym, a zdalnym komputerem. Używa do tego celu kryptografii klucza publicznego, aby poświadczyć tożsamość zdalnego komputera i (opcjonalnie) pozwolić zdalnemu komputerowi potwierdzić tożsamość użytkownika. SSH umożliwia poufność i integralność danych wymienianych pomiędzy dwoma komputerami przy użyciu kodowania i message authentication codes (MACs). SSH jest zwykle używane do logowania na zdalnej maszynie i wykonywania poleceń, ale wspiera także tunelowanie, przekazywanie określonych portów TCP i połączeń X11; może także przekazywać pliki przy użyciu protokołów SFTP lub SCP. Serwer SSH, domyślnie, nasłuchuje na standardowym porcie TCP - 22.  [Informacja z Wikipedii](http://en.wikipedia.org/wiki/Secure_Shell) 

<div class="divider" id="ssh-s"></div>
## Aktywacja bezpiecznych protokołów dla SSH

Pozwolenie na logowanie roota via ssh nie jest bezpieczne. Nie chcemy pozwolić logować się administratorom, debian powinien zostać bezpieczny. Nie powinniśmy też dać użytkownikowi 10 minut na szybki atak słownikowy na hasło, od ciebie zależy ustawienie limitu czasu i ilości prób logowania!

Aby pomóc twojemu ssh stać się bardziej bezpiecznym, po prostu weź swój ulubiony edytor tekstowy i otwórz go z uprawnieniami roota, a następnie otwórz ten plik:

~~~  
/etc/ssh/sshd_config  
~~~

Teraz znajdujemy naruszające bezpieczeństwo wpisy i zmieniamy je.

###### Powinieneś zmienić następujące wpisy:

`Port <żądany port>:`  Musi być ustawiony na poprawny port, który został przekazany z twojego routera. Przekazanie portów musi być także ustawione w twoim routerze. Jeśli nie wiesz, jak to zrobić, może nie powinieneś używać zdalnie ssh. Debian ustawia domyślny port na 22, aczkolwiek zaleca się użycie portu, który jest poza standardowym zakresem skanowania. Powiedzmy, że użyjemy portu 5874:

~~~  
Port 5874  
~~~

`ListenAddress <ip komputera lub interfejs sieciowy>:`  Teraz oczywiście, kiedy przekazałeś port ze swojego routera, musisz nadać statyczny adres ip w sieci, chyba że używasz lokalnie serwera dns, ale jeśli robisz coś, co komplikuje sytuację i potrzebujesz tych wskazówek, prawdopodobnie popełniasz wielki błąd. Powiedzmy zatem, że ustawiłeś: 

~~~  
ListenAddress 192.168.2.134  
~~~

Następnie Protocol 2 jest domyślnym ustawieniem debiana, ale sprawdź, aby być pewnym:

`LoginGraceTime <czas w sekundach na logowanie>:`  Domyślne ustawienie ma absurdalne 600 sekund. Chyba nie zajmuje ci 10 minut wpisanie loginu i hasła, zatem ustawmy to sensownie:

~~~  
LoginGraceTime 45  
~~~

Teraz masz 45 sekund, aby zalogować się i hackerzy nie mają 600 sekund za każdym razem, aby złamać twoje hasło.

`PermitRootLogin <yes>:`  Dlaczego debian ustawia PermitRootLogin 'yes', jest niezrozumiałe, więc naprawiamy to poprzez zmianę na 'no'

~~~  
PermitRootLogin no  
~~~

~~~  
StrictModes yes  
~~~

`MaxAuthTries <xxx>:`  Ilość prób logowania, możesz ustawić na 3 lub 4 próby, ale nie więcej

~~~  
MaxAuthTries 2  
~~~

Możesz dodać jakiekolwiek z poniższych wpisów, jeśli jeszcze ich nie ma:

~~~  
AllowUsers <użytkownicy, którzy mogą się logować via ssh>  
~~~

`AllowUsers <xxx>:`  stwórz użytkownika tylko dla ssh bez innych uprawnień, użyj adduser, aby dodać użytkownika, następnie dodaj jego nazwę tutaj, np.:

~~~  
AllowUsers uzytkownik_ssh  
~~~

`PermitEmptyPasswords <xxx>:`  nadaj użytkownikowi długie hasło, które jest niemożliwe do zgadnięcia przez milion lat. Kiedy zalogujesz się, możesz wykorzystać su, aby zostać rootem:

~~~  
PermitEmptyPasswords no  
~~~

`PasswordAuthentication <xxx>:`  oczywiście dla hasła logowania, nie klucza logowania; potrzebusz haseł, aby się zalogować, chyba że użyjesz kluczy. Musisz to ustawić na yes

~~~  
PasswordAuthentication yes [chyba że użyjesz kluczy]  
~~~

Na koniec:

~~~  
/etc/init.d/ssh restart  
~~~

Teraz masz nieco bezpieczniejsze ssh, nie w pełni bezpieczne, ale lepsze, włączając w to stworzenie użytkownika tylko dla ssh.

`Note:` span> If you get an error message and ssh refuses to connect you, go to your $HOME and look for a hidden folder called `.ssh` span> and delete the file called`known_hosts` span> and try again. This error mainly occurs when you have dynamically set IP addresses (DCHP)

<div class="divider" id="ssh-x"></div>
## Używanie aplikacji X Window poprzez sieć via SSH

ssh -X allows you to log into a remote computer and have its graphical user interface X displayed on your local machine. As $user (and note the X is to be a capital):

~~~  
$ ssh -X username@xxx.xxx.xxx.xxx (or IP)  
~~~

Enter the password for the username on the remote computer and run the X-application in the shell:

~~~  
$ iceweasel OR oocalc OR oowriter OR kspread  
~~~

Some really slow network connections from your PC may benefit from having a level of compression to help speed transfers, therefore add an extra option, on fast networks it has the opposite effect:

~~~  
$ ssh -C -X username@xxx.xxx.xxx.xxx (or IP)  
~~~

Read:

~~~  
$man ssh  
~~~

`Note:` span> If you get an error message and ssh refuses to connect you, go to your $HOME and look for a hidden folder called `.ssh` span> and delete the file called`known_hosts` span> and try again. This error mainly occurs when you have dynamically set IP addresses (DCHP)

<div class="divider" id="ssh-scp"></div>
## Copying files and directories remotely via ssh with scp

scp uses the command line, (terminal/cli), to copy files between hosts on a network. It uses ssh authentication and security for data transfer, therefore, scp will ask for passwords or passphrases as required for authentication.

Assuming you have ssh rights to a remote PC or a server, scp allows you to copy partitions, directories or file, to and from that PC, to a specified location or destination of your choosing where you also have permissions. For example, this could include a PC or server you have the permission to access on your LAN, (or anywhere else in the world), to enable a transfer of data to a USB hard Drive connected to your PC.

You can recursively copy entire partitions and directories with the `scp -r`  option. Note that scp -r follows symbolic links encountered in the tree traversal.

### Examples:

`Example 1:`  Copy a partition:

~~~  
scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/ /media/diskXpartX/  
~~~

`Example 2:`  Copy a directory on a partition, in this case a directory called photos in $HOME:

~~~  
scp -r <user>@xxx.xxx.x.xxx:~/photos/ /media/diskXpartX/xx  
~~~

`Example 3:`  Copy a file from a directory on a partition, in this case a file in $HOME:

~~~  
scp <user>@xxx.xxx.x.xxx:~/filename.txt /media/diskXpartX/xx  
~~~

`Example 4:`  Copy a file on a partition:

~~~  
scp <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt /media/diskXpartX/xx  
~~~

`Example 5:`  If you are already in the drive/directory that you wish to copy any directory or files to, use a '**` **.** `** ' (dot) :

~~~  
scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt.** `**   
~~~

`Example 6:`  To copy files from your PC/server to a another, (use `scp -r`  if copying a partition or a directory):

~~~  
scp /media/disk1part6/filename.txt <user>@xxx.xxx.x.xxx:/media/diskXpartX/xx  
~~~

Read:

~~~  
man scp  
~~~

<div class="divider" id="ssh-w"></div>
## Remote access ssh with X-Forwarding from a Windows-PC:

* Download and burn the  [Cygwin XLiveCD](http://xlivecd.indiana.edu/)   
* Put the CD into the CD-ROM tray of the Windows-PC and wait for the autorun.  
Click "continue" until a shell window pops up and enter:

~~~  
ssh -X username@xxx.xxx.xxx.xxx  
~~~

Note: xxx.xxx.xxx.xxx is the IP of the linux remote computer or its URL (for example a dyndns.org account) and the username is of course one user account that exists on the remote machine. After successfull login, start "kmail" for example and check your mails!

Important: make sure hosts.allow has an entry to allow access from PCs from other networks. If you are behind a NAT-Firewall or a router make sure port 22 is forwarded to your linux machine

<div class="divider" id="ssh-f"></div>
## SSH z Konquerorem

Konqueror i Krusader mogą korzystać ze zdalnych danych przy `sftp://`  and uses the ssh protocol.

Jak to działa:  
1) Otwórz nowe okno Konquerora  
2) Wpisz w pasek adresu: `sftp://username@ssh-server.com` 

~~~  
sftp://siduction1@remote_hostname_or_ip  
(Uwaga: pojawi się okno, które poprosi o twoje hasło ssh, wpisz je i kliknij OK)  
~~~

Przykład 2: 

~~~  
sftp://username:password@remote_hostname_or_ip  
(W tej formie NIE  dostaniesz okienka proszącego o hasło, ale zostaniesz bezpośrednio połączony.)  
~~~

Dla środowiska LAN

~~~  
sftp://username@10.x.x.x or 198.x.x.x.x  
(Uwaga: pojawi się okienko proszące cię o hasło ssh, wpisz je i kliknij OK)  
~~~

Połączenie SSH przez Konquerora jest zainicjowane. Przy pomocy tego okna Konquerora możesz pracować z plikami (kopiowanie/przeglądanie), które są na serwerze SSH, tak jakby były one w katalogu na twojej lokalnej maszynie.

`UWAGA: Jeśli ustawiłeś ssh, aby korzystało z innego portu niż domyślny 22, musisz określić, z jakiego portu ma korzystać sftp:`

~~~  
sftp://user@ip:port  
~~~

'user@ip:port' to standardowa składnia dla wielu programów takich jak sftp and smb.

<div class="divider" id="ssh-fs"></div>
## SSHFS - Zdalne montowanie

SSHFS jest łatwym, szybkim i bezpiecznym sposobem używającym FUSE do montowania zdalnych systemów plików. Jedynym wymaganiem po stronie serwera jest działający demon ssh.

On client side you propably have to install sshfs: `installing fuse and groups is not necessary on siduction eros forward as it is installed by default:` 

Po stronie klienta prawdopodobnie musisz zainstalować sshfs: 

~~~  
apt-get update && apt-get install sshfs  
~~~

`Teraz musisz się wylogować i zalogować ponownie`

Montowanie zdalnego systemu plików jest bardzo łatwe:

~~~  
sshfs username@zdalny_host:katalog lokalny_punkt_montowania  
~~~

gdzie `username`  to nazwa konta na zdalnym hoście:

Jeśli nie podamy katalogu, zostanie zamontowany katalog domowy zdalnego użytkownika.`Uwaga: dwukropek **` **:**`**  jest niezbędny nawet jeśli nie podaje się katalogu!` 

Po zamontowaniu zdalnego katalogu zachowuje się on jak każdy inny lokalny system plików, możesz przeglądać pliki, edytować je i uruchamiać skrypty na nich, zupełnie tak, jak na lokalnym systemie plików.

Jeśli chcesz odmontować zdalny host, użyj następującego polecenia:

~~~  
fusermount -u lokalny_punkt_montowania  
~~~

Jeśli używasz często sshfs, dobrym wyborem będzie dodanie wpisu w fstab:

~~~  
sshfs#username@remote_hostname://remote_directory /local_mount_point fuse user,allow_other,uid=1000,gid=1000,noauto,fsname=sshfs#username@remote_hostname://remote_directory 0 0  
~~~

Next uncomment `user_allow_other`  in `/etc/fuse.conf` :

~~~  
# Allow non-root users to specify the 'allow_other' or 'allow_root'  
# mount options.  
#  
user_allow_other  
~~~

Pozwoli to każdemu użytkownikowi, który jest częścią grupy fuse montować system plików przy użyciu dobrze znanego polecenia mount:

~~~  
mount /sciezka/do/punktu/montowania  
~~~

Z tą linią w fstab możesz oczywiście korzystać również z polecenia umount:

~~~  
umount /sciezka/do/punktu/montowania  
~~~

Aby sprawdzić, czy jesteś w tej grupie, użyj polecenia:

~~~  
cat /etc/group | grep fuse  
~~~

Powinieneś zobaczyć coś takiego:

~~~  
fuse:x:117: <username>  
~~~

Jeśli twoja nazwa użytkownika nie jest wylistowana, użyj polecenia adduser jako root:

~~~  
adduser <username> fuse  
~~~

Teraz twoja nazwa powinna pojawić się na liście i będziesz mógł wykonać polecenie:

`Uwaga: id" nie pojawi się na liście grupy "fuse", dopóki nie wylogujesz się i nie zalogujesz ponownie.`

~~~  
mount lokalny_punkt_montowania  
~~~

i

~~~  
umount lokalny_punkt_montowania  
~~~

<div id="rev">Content last revised 01/11/2011 0650 UTC</div>
