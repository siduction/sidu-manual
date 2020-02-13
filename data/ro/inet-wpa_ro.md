<div id="main-page"></div>
<div class="divider" id="wpa-basic"></div>
## Ghid de bază ca să pornești Wireless - WiFi

`Datorită complexității legale, siduction va furniza doar dfsg-free software,  [Vă rugăm să verificați acest link pentru informații suplimentare privind programele non-free pentru firmware](nf-firm-ro.htm#non-free-firmware) `

Ca să obtineți wlan WiFi și să-l faceți să functioneze aveți nevoie de o conexiune fixă pentru câteva minute, ca să descărcați firmware-ul necesar.

Dacă conectarea fixă nu este posibilă atunci veți fi obligați să puneți firmware-ul pe un dispozitiv mobil (pendrive e.g.) și să-l instalați ca root folosind:

~~~  
#dpkg -i <firmware.deb>  
~~~

Ca să gasiți firmware-ul adecvat fără să cunoașteți marca sau producătorul chip-ului dvs. wireless , puteți folosi comanda:

~~~  
#fw-detect  
~~~

Aceasta vă va oferi următoarea informație:

~~~  
#apt-get update  
#apt-get install <name of firmware>  
#modprobe -r <modulename>  
#modprobe <modulename>  
~~~

Foloseşte apt-get install care v-a fost recomandat de comanda fw-detect . După ce ați efectuat aceasta , este necesar să folosiți unele comenzi în consolă înainte de a configura instalarea .

Trebuie să încărcați modulul ca să puteți configura instalarea.

Ca root, în consolă, efectuați:

~~~  
modprobe -r <modulename>  
modprobe <modulename>  
~~~

Ca &lt;nume al modulului&gt; folosiți informația ce v-a fost data mai înainte de fw-detect. O funcție de ajutor a consolei poate fi folosită aici: bash completion:  
Dacă scrii doar primele litere ale &lt;nume modul&gt; apoi apeși tasta TAB , va completa numele modulului (e.g. modprobe ipw TAB key) Această procedură va preveni greșeli de pronunțare/scriere.

Ambele comenzi modprobe nu vor arăta nimic neobișnuit dacă au avut succes, deci dacă prompt-urile normare revin, modulul a fost încărcat cum trebuie.

Puteți verifica aceasta cu :

~~~  
#lsmod | grep <module>  
~~~

Acum porneste Ceni din K-Menu - Internet sau rulează-l din consolă ca root cu  [Getting Online - Ceni](inet-ceni-ro.htm#netcardconfig) . Dispozitivul dvs. portabil WiFi ar trebui să se vadă acum și să fie gata de a fi configurat.

Ca să instalezi un Wlan WiFi GUI vezi  [WiFi - roaming WPA-GUI](inet-wpagui-ro.htm) 

<div class="divider" id="wpa"></div>
## Moduri de Operare în wpasupplicant pentru Debian

`Datorită complexității legale, siduction va furniza doar dfsg-free software,  [Vă rugăm să verificați acest link pentru informații suplimentare privind programele non-free pentru firmware](nf-firm-ro.htm#non-free-firmware) `

Pachetul wpasupplicant din Debian oferă două (2) moduri de operare convenabile puternic integrate în miezul infrastructurii de networking ; ifupdown .

#### Subiectele Acoperite 

###### 2. Modul #1: Managed Mode

* Exemple  
* Tabel de Opţiuni  
* Explicaţii Importante despre Managed Mode  
* Modul de Lucru 

###### 3. Modul #2: Roaming Mode

* wpa_supplicant.conf  
* /etc/network/interfaces  
* Controlarea Demonului de Roaming cu wpa_action  
* Ajustarea Setării de Roaming  
* Fişierul Log  
* Folosirea Scriptului Extern de Mapping (ex. guessnet)  
* /etc/network/interfaces with external mapping

###### 4. Troubleshooting

* ssids ascunse

###### 5. Consideraţii de Securitate

* Configurarea Permisiunilor Fişierelor 

## 2. Modul #1: Managed Mode

Acest mod oferă posibilitatea să stabiliţi o conexiune via wpa_supplicant către o reţea cunoscută . Este similar cu modul în care lucrează pachetul wireless-tools . Fiecărui element cerut pentru stabilirea conexiunii via wpa_supplicant i se va atribui prefixul 'wpa-' şi va fi urmat de valoarea ce va fi folosită pentru acel element .

###### Exemplu de fişier wpa.conf pentru Mode #1 - Exemplul 1.

~~~  
Example of a Mode #1 wpa.conf file - Example 1.  
NOTE: the 'wpa-psk' value is only valid if:  
1. It is a plaintext (ascii) string between 8 and 63 characters in length  
2. It is a hexadecimal string of 64 characters  
# Connect to access point of ssid 'NETBEER' with an encryption type of  
# WPA-PSK/WPA2-PSK. It assumes the driver will use the 'wext' driver backend  
# of wpa_supplicant because no wpa-driver option has been specified.  
# The passphrase is given as a ASCII (plaintext) string. DHCP is used to  
# obtain a network address.  
#  
iface wlan0 inet dhcp  
wpa-ssid NETBEER  
# plaintext passphrase  
wpa-psk PlainTextSecret  
# Connect to access point of ssid 'homezone' with an encryption type of  
# WPA-PSK/WPA2-PSK, using the 'wext' driver backend of wpa_supplicant.  
# The psk is given as an encoded hexadecimal string. DHCP is used to obtain  
# a network address.  
#  
iface wlan0 inet dhcp  
wpa-driver wext  
wpa-ssid homezone  
# hexadecimal psk is encoded from a plaintext passphrase  
wpa-psk 000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f  
# Connect to access point of ssid 'HotSpot1' and bssid of '00:1a:2b:3c:4d:5e'  
# with an encryption type of WPA-PSK/WPA2-PSK, using the the 'madwifi' driver  
# backend of wpa_supplicant. The passphrase is given as a plaintext string.  
# A static network address assignment is used.  
#  
iface ath0 inet static  
wpa-driver madwifi  
wpa-ssid HotSpot1  
wpa-bssid 00:1a:2b:3c:4d:5e  
# plaintext passphrase  
wpa-psk madhotspot  
wpa-key-mgmt WPA-PSK  
wpa-pairwise TKIP CCMP  
wpa-group TKIP CCMP  
wpa-proto WPA RSN  
# static ip settings  
address 192.168.0.100  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
# User supplied wpa_supplicant.conf is used for eth1. All network information  
# is contained within the user supplied wpa_supplicant.conf. No wpa-driver type  
# is specified, so wext is used. DHCP is used to obtain a network address.  
#  
iface eth1 inet dhcp  
wpa-conf /path/to/wpa_supplicant.conf  
~~~

<div class="divider" id="wpa1"></div>
## Tabel de Opţiuni

O scurtă enumerare de opţiuni 'wpa-' ce pot fi folosite în liniile /etc/network/interfaces pentru un dispozitiv wireless . Vezi secţiunea 'Explicaţii Importante despre Managed Mode' pentru informaţii despre valori 'wpa-' valide şi invalide .

**`NOTĂ : TOATE valorile sunt CASE SeNsITiVe`**

~~~  
Element Example Value Description  
======= ============= ===========  
wpa-ssid plaintextstring sets the ssid of your network  
wpa-bssid 00:1a:2b:3c:4d:5e the bssid of your AP  
wpa-psk 0123456789...... your preshared wpa key. Use  
wpa_passphrase(8) to generate your psk  
from a passphrase and ssid pair  
wpa-key-mgmt NONE, WPA-PSK, WPA-EAP, list of accepted authenticated key  
IEEE8021X management protocols  
wpa-group CCMP, TKIP, WEP104, list of accepted group ciphers for WPA  
WEP40  
wpa-pairwise CCMP, TKIP, NONE list of accepted pairwise ciphers for  
WPA  
wpa-auth-alg OPEN, SHARED, LEAP list of allowed IEEE 802.11  
authentication algorithms  
wpa-proto WPA, RSN list of accepted protocols  
wpa-identity myplaintextname administrator provided username  
(EAP authentication)  
wpa-password myplaintextpassword your password (EAP authentication)  
wpa-scan-ssid 0 or 1 toggles scanning of ssid with specific  
Probe Request frames  
wpa-ap-scan 0 or 1 or 2 adjusts the scanning logic of  
wpa_supplicant  
~~~

Funcţionalitatea completă a wpa_cli(8) trebuie implementată . Orice lipseşte este considerat bug şi ar trebui raportat ca atare . Patch-urile sunt întotdeauna bine venite .

## Explicaţii Importante despre Managed Mode

Aproape toate opţiunile 'wpa-' cer ca cel puţin un ssid să fie specificat . Doar câteva opţiuni au efect global . Acestea sunt : 'wpa-ap-scan' și 'wpa-preauthenticate'.

Orice opţiune 'wpa-' dată pentru un dispozitiv în fişierul de interfeţe(5) este suficientă pentru a pune în acţiune demonul wpa_supplicant .

Scriptul wpasupplicant ifupdown face presupuneri despre 'type' (tipul) intrării care este validă pentru fiecare opţiune . De exemplu , presupune că anumite intrări sunt în plaintext şi aşează intrarea între ghilimele înainte de a o pasa către wpa_cli , care apoi adaugă intrarea blocului de reţea ce a fost creat via wpa_supplicant ctrl_interface socket.

Rulând manual ifup cu opţiunea '--verbose' va scoate la iveală toate comenzile folosite pentru a forma blocul de reţea via wpa_cli. Dacă volorile pe care le utilizaţi pentru orice opţiune wpa-* în /etc/network/interfaces sunt între ghilimele , atunci se va presupune că sunt intrări de tipul "plaintext" sau "ascii" .

Unele intrări se presupune că sunt în hexazecimal (ex. wpa-wep-key*). 'type' -tipul valorii din opţiunea wpa-psk , este determinată printr-o verificare simplă care este facută pentru mai mult decât un caracter non hexadecimal .

## Modul de Lucru

Cum am menţionat mai devreme , fiecare element specific wpa_supplicant are prefixul 'wpa-'. Fiecare element este corelat unei proprietăţi wpa_supplicant descrise în wpa_supplicant.conf(5) , wpa_supplicant(8) şi wpa_cli(8) manpages .

Oricum supplicant este lansat fără nici o configurare prealabilă , şi wpa_cli face configurarea reţelei din intrările oferite de liniile 'wpa-*' . Iniţial , wpa_supplicant/wpa_cli nu setează direct proprietaţile dispozitivului (precum setarea unui essid cu iwconfig , de exemplu) , ci mai degrabă informează dispozitivul despre punctele de acces potrivite asocierii . Odată ce dispozitivul a scanat zona şi a găsit toate punctele de acces potrivite şi disponibile spre utilizare va seta aceste proprietaţi .

Scriptul care face toată această treabă este localizat la :

~~~  
/etc/wpa_supplicant/ifupdown.sh  
/etc/wpa_supplicant/functions.sh  
~~~

ifupdown.sh este executat de run-parts , care în schimb este invocat de ifupdown în timpul fazelor 'pre-up', 'pre-down' şi 'post-down' .

În faza 'pre-up' , un demon wpa_supplicant este lansat urmat de o serie de comenzi wpa_cli care setează o configuraţie de reţea în funcţie de opţiunile 'wpa-' folosite în /etc/network/interfaces pentru dispozitivul fizic .

dacă este folosit wpa-roam , un demon wpa_cli este lansat în faza 'post-up' .

În faza 'pre-down' , demonul wpa_cli este terminat dacă există .

În faza 'post-down' , demonul wpa_supplicant este terminat .

## 3. Modul #2: Roaming Mode

Un mecanism de roaming simplistic dar suficient este oferit prin intermediul acestui pachet .Este de forma unui script activ wpa_cli , /sbin/wpa_action , ce preia controlul asupra ifupdown odată activat . Paginile manpage pentru wpa_action(8) descriu în amănunt detaliile sale tehnice .

Pentru a activa o interfaţă roaming adaptaţi liniile din următorul exemplu interfaces(5) :

~~~  
iface eth1 inet manual  
wpa-driver wext  
wpa-roam /path/to/wpa_supplicant.conf  
~~~

Doi daemoni sunt lansaţi în exemplul de mai sus : wpa_supplicant şi wpa_cli. este necesar să specificaţi un fişier wpa_supplicant.conf . Un punct de plecare bun este acest exemplu de fişier de configurare :

~~~  
# copy the template to /etc/wpa_supplicant/  
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf \  
/etc/wpa_supplicant/wpa_supplicant.conf  
# allow only root to read and write to file  
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf  
NOTE: it is critical that the used wpa_supplicant.conf defines the location of  
the 'ctrl_interface' so that a communication socket is created for the  
wpa_cli (wpa-roam daemon) to attach. The mentioned example configuration,  
/usr/share/doc/wpasupplicant/examples/wpa-roam.conf, has been set to a  
sane default.  
~~~

Va trebui să editaţi fişierul de configurare şi să adăugaţi toate blocurile de reţea pentru toate reţelele cunoscute . Dacă nu înţelegeţi despre ce e vorba aici începeţi să citiţi explicaţiile din manpages pentru wpa_supplicant.conf(5) .

Pentru fiecare reţea puteţi specifica o opţiune specială 'id_str' . Ea trebuie setată printr-un simplu şir text . Acest şir text formează baza profilului reţelei ; se corelează la o interfaţă logică definită în fişierul interfaces(5) . Dacă nici o optiune 'id_str' nu este dată pentru reţea , wpa_action va folosi interfaţa logică 'default' pentru întoarceri (fallback). Interfaţa fallback poate fi aleasă prin opţiunea 'wpa-default-iface' .

Ce înseamnă toate astea ? Să le ilustrăm printr-un exemplu luat din paginile manualului (manpage) wpa_action(8) .

###### exemplu de wpa_supplicant.conf 

~~~  
wpa_supplicant.conf example:  
network={  
ssid="foo"  
key_mgmt=NONE  
# this id_str will notify /sbin/wpa_action to 'ifup uni'  
id_str="uni"  
}  
network={  
ssid="bar"  
psk=123456789...  
# this id_str will notify /sbin/wpa_action to 'ifup home_static'  
id_str="home_static"  
}  
network={  
ssid=""  
key_mgmt=NONE  
# no 'id_str' parameter is given, /sbin/wpa_action will 'ifup default'  
}  
~~~

<div class="divider" id="wpa2"></div>
###### exemplu de /etc/network/interfaces 

~~~  
/etc/network/interfaces example:  
# the roaming interface MUST use the manual inet method  
# 'allow-hotplug' or 'auto' ensures the daemon starts automatically  
allow-hotplug eth1  
iface eth1 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
# no id_str, 'default' is used as the fallback mapping target  
iface default inet dhcp  
# id_str="uni"  
iface uni inet dhcp  
# id_str="home_static"  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
~~~

O interfaţă logică este pornită prin ifup , şi oprită prin ifdown , pentru că wpa_supplicant se asociază şi de-asociază cu reţeaua la care este conectată prin opţiunea 'id_str' folosită în fişierul de configurare wpa_supplicant.conf .

Un fişier log al acţiunilor /sbin/wpa_action's este creat la /var/log/wpa_action.log , vă rugăm să-l trimiteţi când raportaţi probleme .

## Combinații de wpa_supplicant cu wpa_cli și wpa_gui

Procesul wpa_supplicant poate interacționa cu memberii grupului "netdev" dacă examplul de configurare roaming a fost utilizat așa cum este (sau de oricare group sau gid specificat de parametrul GROUP= crtl_interface).

~~~  
# the default ctrl_interface option used in the example file  
# /usr/share/doc/wpasupplicant/examples/wpa-roam.conf  
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev  
To interact with the supplicant, the wpa_cli (command line) and wpa_gui (QT)  
have been provided. With these you may connect, disconnect, add/delete new  
network blocks, provide required interactive security information and so on.  
~~~

## Controlarea Daemonului de Roaming cu wpa_action

Odată daemonul de roaming pornit , acesta preia controlul ifupdown . Asta e ; wpa_cli iniţializează ifup când wpa_supplicant a fost asociat cu succes unui punct de acces , şi iniţializează ifdown când conexiunea este pierdută sau terminată . Atât timp cât daemonul de roaming este activ , ifupdown nu trebuie controlat prin comenzi introduse manual , mai degrabă să fie activat /sbin/wpa_action pentru a opri şi reâncărca daemonul de roaming . De exemplu pentru a opri daemonul de romaing pentru interfaţa 'eth1' :

~~~  
wpa_action eth1 stop  
~~~

Când este necesar să faceţi actualizări daemonului de roaming cu detalii despre o nouă reţea, acest lucru se poate face fără a-l opri . Editaţi fişierul wpa_supplicant.conf care este folosit de către daemon cu detaliile noii reţele , adăugaţi setările de reţea opţionale corespunzătoare noii reţele în /etc/network/interfaces (legate de 'id_str') şi apoi 'reload' daemonul aşa :

~~~  
wpa_action eth1 reload  
~~~

Pentru detaliile tehnice complete asupra ce poate face wpa_action citiţi paginile wpa_action(8) manpage .

<div class="divider" id="wpa3"></div>
## Ajustarea Setării de Roaming 

Veţi întâlni situaţii când mai multe puncte de acces cunoscute sunt foarte aproape unele de altele . Puteţi alege manual care este cel preferat cu wpa_cli sau wpa_gui , sau puteţi specifica prioritatea fiecărei reţele . Aceasta este specificată cu opţiunea 'priority' din fişierul wpa_supplicant.conf .

<div class="divider" id="wpa4"></div>
## Fişierul Log

Întreaga activitate a daemonului de roaming va fi consemnată în /var/log/wpa_action.log . Următoarele informaţii vor fi consemnate :

*time and date  
*interface name and action event  
*values of enviromental variables (WPA_ID, WPA_ID_STR, WPA_CTRL_DIR)  
*ifupdown command executed  
*wpa_cli status (based on WPA-PSK, network may display different info)  
*bssid  
*ssid  
*id  
*id_str  
*pairwise_cipher  
*group_cipher  
*key_mgmt  
*wpa_state  
*ip_address

<div class="divider" id="wpa5"></div>
## Utilizarea Scripturilor Externe de Mapping (ex. guessnet)

În plus faţă de mapping intern al interfeţei logice via 'id_str' , wpa_action poate lansa şi scripturi externe de mapping . Un script de mapping trebuie să întoarcă numele interfeţei logige ce va fi iniţializată . Orice script de mapping care lucrează prin mecanismul de mapping ifupdowns (vezi man interfaces) trebuie de asemeni să lucreze şi când este lansat prin wpa_action.

Pentru a lansa un script de mapping adăugaţi o linie 'wpa-mapping-script name-of-the-script' în secţiunea interfaces ale dispozitivului fizic de roaming . (Va trebui să specificaţi calea absolută către scriptul de mapping .)

Conţinutul liniilor care încep cu wpa-map este trecut mai departe către stdin din scriptul de mapping . Deoarece ifupdown permite doar o linie wpa-map puteţi adăuga orice numar la wpa-map pentru linii adiţionale . De exemplu :

~~~  
iface wlan0 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
wpa-mapping-script guessnet-ifupdown  
wpa-map0 home  
wpa-map1 work  
wpa-map2 school  
# ... additional wpa-mapX lines as required  
~~~

Implicit scriptul de mapping va fi folosit doar când nici o valoare a optiunii 'id_str' nu este disponibilă pentru reţeaua curentă . Dacă doriţi să dezactivaţi complet asocierile 'id_str' şi să utilizaţi doar un script de mapping extern folosiţi opţiunea 'wpa-mapping-script-priority 1' pentru a trece peste comportamentul implicit .

Dacă scriptul de mapping întoarce un şir gol , wpa_action va reveni la folosirea interfeţei 'default' , în afară de cazul în care este definită o alternativă cu opţiunea 'wpa-roam-default-iface' .

Mai jos este oferit un exemplu avansat în care guessnet-ifupdown este folosit ca script extern de mapping .

###### exemplu de /etc/network/interfaces cu mapping extern

~~~  
/etc/network/interfaces with external mapping example:  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
wpa-roam-default-iface default-wparoam  
wpa-mapping-script guessnet-ifupdown  
wpa-map default: default-guessnet  
wpa-map0 home_static  
wpa-map1 work_static  
# school can only be chosen via 'id_str' matching  
iface school inet dhcp  
# resolvconf  
dns-nameservers 11.22.33.44 55.66.77.88  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
test peer address 192.168.0.1 mac 00:01:02:03:04:05  
iface work_static inet static  
address 192.168.3.200  
netmask 255.255.255.0  
network 192.168.3.0  
broadcast 192.168.3.255  
gateway 192.168.3.1  
test peer address 192.168.3.1 mac 00:01:02:03:04:05  
iface default-guessnet inet dhcp  
iface default-wparoam inet dhcp  
~~~

În acest exemplu wpa_action va folosi guessnet pentru selectarea unei interfeţe logice corespunzătoare doar dacă nici o opţiune 'id_str' nu a fost furnizată în wpa_supplicant.conf pentru reţeaua curentă .

Liniile 'wpa-map' specifică pentru guessnet interfaţa logică ce trebuie testată precum şi interfaţa implicită ce va fi folosită în cazul în care toate testele eşuează . Liniile 'test' ale fiecărei interfeţe logige sunt folosite de guessnet pentru a determina dacă sunteţi conectaţi la reţea . De exemplu , guessnet va alege interfaţa logică 'home_static' dacă există un dispozitiv cu adresa IP 192.168.0.1 şi MAC 00:01:02:03:04:05 în reţeaua curentă . Dacă toate testele eşuează , interfaţa 'default-guessnet' va fi configurată .

Vă rugăm citiţi guessnet(8) manpage pentru mai multe informaţii .

## 4. Necazuri-Troubleshooting

Pentru a depana conexiunea , problemele de asociere şi autentificare , vă sugerăm să porniţi `wpa_cli -i &lt;interface&gt;` într-o consolă separată , înainte de a porni interfaţa . Folosiţi întâi comanda 'level 0' pentru a primi toate mesajele de depanare . Apoi utilizaţi `ifup --verbose &lt;interface&gt;` pentru a primi mesaje detaliate de la scriptul care porneşte wpasupplicant.

<div class="divider" id="wpa6"></div>
## ssids ascunse

Pentru relaţii vedeţi #358137. Pentru a putea face asocierea cu procesele ssids ascunse vă rugăm încercaţi să setaţi opţiunea 'ap_scan=1' în secţiunea globală şi 'scan_ssid=1' în secţiunea blocului de reţea din fişierul wpa_supplicant.conf . Dacă folosiţi managed mode , puteţi face acestea în liniile :

~~~  
iface eth1 inet dhcp  
wpa-conf managed  
wpa-ap-scan 1  
wpa-scan-ssid 1  
# ... additional options for your setup  
~~~

Potrivit cu #368770 , procesul poate dura foarte mult când e vorba de asocierea la reţele securizate WEP . În anumite cazuri , setând parametrul 'ap_scan=2' în fişierul de configurare , (sau folosind o linie 'wpa-ap-scan 2' , ceea ce este echivalent) poate ajuta foarte mult la realizarea mai rapidă a asocierii .

<div class="divider" id="wpa7"></div>
## 5. Consideraţii de Securitate 

##### Configurarea Permisiunilor Fişierelor

Este important să țineți PSK's şi alte informaţii delicate cu privire la setările reţelei dumneavoastră private , de aceea asigurați-vă că fişierele de configurare care conţin asemenea date pot fi citite doar de proprietar . De exemplu :

~~~  
chmod 0600 /etc/network/interfaces  
# substitute the path of your wpa_supplicant.conf file  
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf  
~~~

Implicit , fişierul /etc/network/interfaces poate fi citit de oricine , şi de aceea nu este potrivit pentru a conţine chei secrete şi parole .

<div id="rev"> Content last revised 30/11/2012 0100 UTC</div>
