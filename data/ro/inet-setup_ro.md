<div id="main-page"></div>
<div class="divider" id="net-set1"></div>
## Setarea unui 'WiFi Roaming' cu 'wpa'

`În general veți avea nevoie de drivere 'non-free firmware' disponibile pe un USB-stick pentru a putea fi instalate în sistemul de operare. Vă rog să citiți  [drivere 'non-free firmware debs' pe stick](nf-firm-ro.htm#non-free-firmware) .` 

### Introducere

'wpa-roaming' este o metodă cu care puteți naviga pe internet fiind conectați la rețele wireless `cu și/sau fără un mediu desktop grafic` .

Următoarele instrucțiuni vă vor ajuta în cazul când placa de rețea nu este conectată la un cablu, placa "wlan0" devine prima optiune de a vă conecta la rețeaua wireless dorită sau la o rețea wireless publică sau privată. Dacă veți conecta un cablu de rețea, atunci conexiunea WiFi va fi oprită iar placa "eth0" vă va face conexiunea prin cablu la rețea. La deconectarea cablului, conexiunea wireless va fi din nou disponibilă instantaneu.

### Configurarea legăturii la rețea

Ca `root`  modificați fișierul `/etc/network/interfaces`  astfel încât să arate cam așa (numele interfețelor ar putea să difere):

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

Apoi programul 'wpa_supplicant' are nevoie de un fișier .conf, "wpa-roam.conf"

~~~  
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf /etc/wpa_supplicant/wpa-roam.conf  
~~~

Folosiți un editor de texte pentru a deschide fișierul (vi, pico, kwrite, kate, etc.) 

~~~  
<editor> /etc/wpa_supplicant/wpa-roam.conf  
~~~

Decomentați linia 30 (ștergeți semnul **`#`** ). Trebuie făcut acest pas altfel cofigurările nu vor fi salvate:

~~~  
update_config=1  
~~~

Pentru a configura un laptop sau un desktop trebuie doar să accesați imediat o rețea securizată, decomentați liniile, (ștergeți semnul **`#`** ), pentru WEP sau WPA-WPA2PSK după caz: 

Exemplu WPA:

~~~  
network={  
ssid="siduction_Worldwide" #Example WPA Network  
psk="mysecretpassphrase"  
}  
~~~

Următorul pas protejează "wpa-roam.conf" de acces nedorit. Este necesar deoarece parolele de acces ale rețelelor private sunt salvate în acest fișier:

~~~  
chmod 600 /etc/wpa_supplicant/wpa-roam.conf  
~~~

Punerea în funcțiune a conexiunii wireless:

~~~  
ifup wlan0  
~~~

Verificați dacă sunteți conectat la rețea:

~~~  
wpa_cli status  
~~~

Răspunsul ar trebui să arate cam așa:

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

Dacă nu vedeți ip_address= numere înseamnă că nu sunteți conectat; opriți "wlan0" și reverificați configurările:

~~~  
wpa_action wlan0 stop  
~~~

Dacă doriți configurări speciale vedeți și  [aici](#net-set3) 

<div class="divider" id="net-set2"></div>
## Activarea posibilității de comutare între o rețea prin cablu și una wireless

Mai întâi vedeți  [Comutarea între cablu și wireless](inet-ifplug-ro.htm)  deoarece dacă aceasta nu-i setată corect atunci comutarea și conectarea la rețea nu se va întâmpla.

După setarea 'ifplugd' configurarea finală va arăta cam așa: 

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
## Utilizarea "wpa-roam.conf" cu configurări manuale specifice

Cu ajutorul `IDString`  și `Priority`  puteți stabili la care rețea să se conecteze computerul vostru în timpul boot-ării. Cea mai mare prioritate este `1000` , cea mai mică fiind `0` . Trebuie să adăugați deasemenea `id_str`  la `/etc/network/interfaces` .

###### Sintaxa pentru /etc/network/interfaces.

Prima este pentru conexiunea la serverele DHCP, a doua este pentru adresă IP fixă. Pentru modificarea setărilor:

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

###### Examplu practic

Dacă doriți să fiți conectat automat la WLAN-ul de acasă când sunteți acasă, dați lui IDString valoarea "home" și prioritate "15". Dacă călătoriți și doriți ca laptop-ul să se conecteze la orice rețea publică disponibilă care nu cere parole, dați lui IDString valoarea "stalk" și prioritate "1" (foarte mică). Vă rog mult, verificați întotdeauna dacă conectarea voastră este legală și deconectați-vă dacă rețeaua nu este destinată accesului liber.

Examplu de configurare în /etc/network/interfaces:

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

Examplu /etc/wpa_supplicant/wpa-roam.conf (SSID și parolele sunt schimbate sau doar explicate):

~~~  
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev  
update_config=1  
network={  
ssid="my_ssid"  
scan_ssid=1  
psk=123ABC ##aici este passphrase în cod hexazecimal !!  
# psk="password_in_ascii" ##nu aveți nevoie  
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
disabled=1 ## fără conectare automată, unu cere wpa_cli sau wpa_gui  
id_str="stalk"  
}  
~~~

Cu "disabled=1" nu veți fi conectat automat la o rețea definită (open WLANs), trebuind să inițiați "roaming" cu 'wpa_gui' saur 'wpa_cli'. Pentru a realiza "roaming" automat nu utilizați nici o opțiune sau comentați linia cu "disabled" folosind semnul **`#`** .

### Note:

###### 1. Ușor de reutilizat

Odată configurată, puteți ușor s-o refolosiți pe alte laptop-uri sau PC-uri cu plăci de rețea WLAN. Doar copiați fișierele "/etc/network/interfaces" (modificați numele interfeței dacă este cazul) și "/etc/wpa_supplicant/wpa-roam.conf" pe celălalt computer. Nu este nevoie de nici o altă instalare după asta.

###### 2. Backup

Ar fi bine să faceți o copie a fișierelor "/etc/network/interfaces" și "/etc/wpa_supplicant/wpa-roam.conf", dar `criptați-le deoarece conțin informații sensibile` .

O metodă bună de a salva și securiza fișierele de configurare ar fi folosind  *tar* . și  *gpg* . Ca  *root* :

~~~  
tar -cf- /etc/network/interfaces /etc/wpa_supplicant/wpa-roam.conf | gpg -c > backup_name.tar.gpg  
~~~

A file has now been created in $ HOME:  
backup_name.tar.gpg

To list the contents of the backup_name.tar.gpg file:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vtf -  
~~~

To extract and decrypt the contents of the archive backup_name.tar.gpg file:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vxf -  
~~~

###### 3. SSID-uri ascunse

SSID-urile ascunse sunt detectate când `scan_ssid=1`  este specificat în  *"network block"* .

<div class="divider" id="rousec-wifi"></div>
## Noțiuni sumare de securitate ale modem/router-elor wireless

Când administrați un router/modem wireless, sunt câteva politici de bază ce trebuie implementate pentru îmbunatățirea protecției rețelei față de intruși.

###### Opțiunile protocolului de bază

+ WPA2-PSK este cea mai bună opțiune.  
+ Pentru protocolul de criptare alegeți AES.  
+ Cuvîntul ales pentru "passphrase" trebuie să fie într-adevăr puternic (greu de ghicit).  

###### Passphrase / passwords

Pentru o passphrase/password cu adevărat puternică și greu de meorat, folosiți 'pwgen' într-un terminal (citiți de asemenea: man pwgen):

~~~  
$ pwgen -s 63 1  
VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

+ -s = sigur (fără mnemonice)  
+ 63 = număr de caractere  
+ 1 = generează aleatoriu doar o singură parolă  

Fără opțiunea "-s" obțineți o parolă "vorbită" (mai ușor de ținut minte). Oricum nu-i ceea ce ar trebui să folosiți:

~~~  
$ pwgen 8 3  
Sooxae2s Niew9ugh Hi7eeloo  
~~~

După generagrea passphrase/password scrieți-o într-un fișier text, salvați-l pe un USB-stick și folosiți această passphrase/password pe alte computere ce se conectează la rețeaua voastră wireless. **`Nu păstrați passphrase/password pe computerul vostru.`** 

###### Examplu de setare finală a unui router:

~~~  
Version: WPA2-PSK  
Encryption: AES  
PSK Password: VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

<div id="rev">Content last revised 30/11/2012 1850 UTC</div>
