<div id="main-page"></div>
<div class="divider" id="net-set1"></div>
## Konfigurowanie WiFi Roaming z wpa 

`Prawdopodobnie musisz zainstalować non-free firmware z USB flash. Więcej informacji pod  [Wskazówki dla sprzętu wymagającego niewolnego oprogramowania](nf-firm-pl.htm#non-free-firmware) .` 

### Przegląd

 Wpa-roaming jest metodą, z którą można przeglądać i łączyć się z sieciami bezprzewodowymi `z i / lub bez środowiskiem graficznym` .

 Następująca konfiguracja prowadzi przy nie podłączonym kablu ethernet do nawiązania połączenia 'wlan0' z predefiniowaną preferowaną siecą bezprzewodowej lub do otwartej sieci bezprzewodowej. Po podłączeniu kabla ethernet do sieci kablowej natychmiast wstrzymuje się dostęp do sieci WiFi oraz 'eth0' łączy się do sieci LAN. Po odłączeniu kabla sieciowego ponownie połącza się WiFi.

### Ustawianie konfiguracji sieci 

Jako `root`  dostosowuj plik `/etc/network/interfaces`  tak, aby wygląda to tak. (Nazwy interfejsu mogą się odróżniać):

~~~  
# The loopback network interface  
auto lo  
iface lo inet loopback  
#Added by user  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
#this line must always be here  
iface default inet dhcp  
~~~

Następnie tworzymy potrzebny procesowi 'wpa_supplicant' plik konfiguracyjny 'wpa-roam.conf'

~~~  
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf /etc/wpa_supplicant/wpa-roam.conf  
~~~

Za pomocą edytora otwórz plik.

~~~  
<editor> /etc/wpa_supplicant/wpa-roam.conf  
~~~

Odkomentuj linie 30 (usuń znak **`#`** ). Należy to zrobić, inaczej konfiguracje nie zostaną zapisane do pliku: :

~~~  
update_config=1  
~~~

Aby dokonać konfiguracji laptopa lub komputera stacjonarnego tak, aby otrzymywał dostęp tylko do zabezpieczonej sieci, natychmiast odkomentuj linię, (usuń znak **`#`** ), dla WEP lub WPA-WPA2PSK: 

Przykład WEP:

~~~  
network={  
ssid="debian" #Example WEP Network  
key_mgmt=NONE  
wep_key0=6162636465  
wep_tx_keyidx=0  
}  
~~~

Przykład WPA:

~~~  
network={  
ssid="siduction_Worldwide" #Example WPA Network  
psk="mysecretpassphrase"  
}  
~~~

Kolejny krok zabezpiecza 'wpa-roam.conf' przed niedozwolonym dostępem. Jest to konieczne, ponieważ klucze prywatnej sieci są zapisane w tym pliku: 

~~~  
chmod 600 /etc/wpa_supplicant/wpa-roam.conf  
~~~

Doprowadz do połączenia WiFi: 

~~~  
ifup wlan0  
~~~

Sprawdź teraz, czy komputer jest podłączony do sieci:

~~~  
wpa_cli status  
~~~

Wynik powinien wyglądać mniej więcej tak:

~~~  
Selected interface 'wlan0'  
bssid=94:0c:6d:aa:f4:42  
ssid=siduction_Melbourne  
id=3  
pairwise_cipher=CCMP  
group_cipher=CCMP  
key_mgmt=WPA2-PSK  
wpa_state=COMPLETED  
ip_address=192.168.1.102  
~~~

Jeśli nie widać ip_address=n.u.m.e.r komputer nie jest podłączony. W tym wypadku sprawdź konfigurację po zatrzymaniu wlan0: 

~~~  
wpa_action wlan0 stop  
~~~

Bardziej skomplikowane ustawienia konfiguracji można znaleźć  [tutaj](#net-set3) 

<div class="divider" id="net-set2"></div>
## Przełączanie pomiędzy sieciami przewodowymi i bezprzewodowymi 

Najpierw sprawdź  [Przełączanie pomiędzy sieciami przewodowymi i bezprzewodowymi](inet-ifplug-pl.htm)  bo jeśli 'ifplugd' nie poprawnie ustawiona przełączanie i podłączenie do sieci nie nastąpi. 

Po skonfigurowaniu ifplugd końcowa konfiguracja /etc/network/interfaces powina wyglądać tak: 

~~~  
auto lo  
iface lo inet loopback  
# governed by ifplugd ... do not use allow-hotplug or auto options  
iface eth0 inet dhcp  
#Added by user  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
#this line must always be here  
iface default inet dhcp  
~~~

<div class="divider" id="net-set3"></div>
## Korzystanie wpa-roam.conf z ręcznie określoną konfiguracją sieci 

Z pomocą `IDString`  oraz `Priority`  można kierować do jakiej sieci podłączony jest komputer przy starcie systemu. Najwyższy priorytet wynosi `1000` , najniższy priorytet wynosi `0` . Trzeba również dodać `id_str`  do `/etc/network/interfaces`  .

###### Składnia /etc/network/interfaces.

Pierwszy przykład jest przeznaczony do podłączenia do serwera DHCP, drugi na utworzenie związku ze stałym adresem IP:

~~~  
# id_str="home_dhcp"  
iface home_dhcp inet dhcp  
#this line must always be here  
iface default inet dhcp  
# id_str="home_static"  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
~~~

###### Praktyczne przykłady 

Jeśli chcesz zostać automatycznie podłączony do sieci WLAN gdy jesteś w domu, dodaj IDString "home" i priorytet "15". Jeśli podróżujesz i chcesz laptopa do dowolnej i dostępnej sieci WiFi bez hasla podłączyć, dodaj IDString "stalk" i priorytet "1" (bardzo niski). Ale proszę zawsze sprawdź, czy połączenie jest zgodne z prawem i odłącz, jeśli jest to oczywiste, że nie jest publiczne.

Przykładowe strofy w /etc/network/interfaces:

~~~  
# /etc/network/interfaces -- configuration file for ifup(8), ifdown(8)  
# The loopback interface  
# automatically added when upgrading  
auto lo  
iface lo inet loopback  
allow-hotplug eth0  
iface eth0 inet dhcp  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-roam /etc/wpa_supplicant/wpa-roam.conf  
#this line must always be here  
iface default inet dhcp  
iface home inet dhcp  
iface stalk inet dhcp  
~~~

Przykładowy plik /etc/wpa_supplicant/wpa-roam.conf (SSID i hasła są zmieniane lub po prostu wytłumaczone):

~~~  
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev  
update_config=1  
network={  
ssid="my_ssid"  
scan_ssid=1  
psk=123ABC ##here comes the passphrase in hexadecimal code!!  
# psk="password_in_ascii" ##you dont need to  
key_mgmt=WPA-PSK  
pairwise=TKIP  
group=TKIP  
auth_alg=OPEN  
priority=15  
id_str="home"  
}  
network={  
ssid=""  
scan_ssid=1  
key_mgmt=NONE  
auth_alg=OPEN  
priority=1  
disabled=1 ## no automatic connection, one needs wpa_cli or wpa_gui  
id_str="stalk"  
}  
~~~

Z "disabled = 1" komputer nie będzie się łączyć automatycznie z otwartymi siecami (open WLANs), trzeba rozpocząć roaming poprzez wpa_gui lub wpa_cli. Do automatycznego roamingu nie korzystaj z opcji w całości lub stawiaj # przed linią z opcją "disabled = 1".

##### Szyfrowanie WEP

Jeśli chcesz dodać sieci szyfrowanych WEP do wpa-roam.conf na stałe, składnia jest taka:

~~~  
network={  
ssid="example wep network"  
key_mgmt=NONE  
wep_key0="abcde"  
wep_key1=0102030405  
wep_tx_keyidx=0  
}  
~~~

### Komentarze

###### 1. Łatwe ponowne użycie 

Po skonfigurowaniu, można łatwo użyć ustawień na innych komputerach przenośnych lub stacjonarnych z kartą WLAN. Wystarczy skopiować /etc/network/interfaces (dostosowuj nazwę interfejsu, w razie potrzeby) oraz /etc/wpa_supplicant/wpa-roam.conf na nowy komputer. Nie ma potrzeby jakejkolwiek "instalacji" po tym.

###### 2. Backup

Jest dobrym pomysłem tworzyć kopię zapasową z /etc/network/interfaces oraz /etc/wpa_supplicant/wpa-roam.conf, ale `szyfruj kopii zapasowych, ponieważ zawierają informacje poufne` .

Dobrą metodą na bezpieczne tworzenie kopii zapasowych i szyfrowanie plików konfiguracyjnych to kombinacja gpg i tar. Jako root:

~~~  
tar -cf- /etc/network/interfaces /etc/wpa_supplicant/wpa-roam.conf | gpg -c > backup_name.tar.gpg  
~~~

W $ HOME został utworzony plik:  
backup_name.tar.gpg

Aby wyświetlić zawartość pliku backup_name.tar.gpg:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vtf -  
~~~

Aby wydobyć i odszyfrować zawartość pliku archive backup_name.tar.gpg:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vxf -  
~~~

###### 3. Ukryte SSIDs

Ukryte SSID są wykrywane podczas `scan_ssid=1`  jest zdefiniowany w bloku sieci.

<div class="divider" id="rousec-wifi"></div>
## Podstawowe środki bezpieczeństwa dla bezprzewodowych modemów i routerów 

Niektóre podstawowe środki ostrożności, mogą pomóc w ochronie sieci przed intruzami. 

###### Wybór protokołu zabezpieczeń 

+ WPA2-PSK jest lepszym rozwiązaniem.  
+ Wybierz protokół szyfrowania AES.  
+ Hasło powinno być naprawdę silne.  

###### Hasło (passphrase/password)

Aby wygenerować silnego hasła lub silnego hasła, którego nie można łatwo zapamiętać, użyj 'pwgen' w terminalu (patrz: man pwgen): 

~~~  
$ pwgen -s 63 1  
VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

+ -s = bezpieczne (bez mnemoników - przypominaczy)  
+ 63 = liczba znaków   
+ 1 = generuje tylko jedno losowe hasło   

Bez opcji -s zostanie wygenerowane hasło możliwe do wymówienia. Jest jednak mało prawdopodobne, że takie będziesz chciał: 

~~~  
$ pwgen 8 3  
Sooxae2s Niew9ugh Hi7eeloo  
~~~

Po wygenerowaniu hasła przechowywuj je w pliku tekstowym na pen-ie USB i za jego pomocą stosuj na innych komputerach, które używają sieci bezprzewodowej. Nie przechowuj hasła na swoim komputerze. 

###### Przykład finalnych ustawień routera:

~~~  
Version: WPA2-PSK  
Encryption: AES  
PSK Password: VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

<div id="rev">Content last revised 21/08/2012 1620 UTC</div>
