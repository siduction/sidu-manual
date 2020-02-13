<div id="main-page"></div>
<div class="divider" id="net-set1"></div>
## Impostare il Roaming WiFi con wpa

`Probabilmente avrete bisogno di firmware non-free da installare sul sistema operativo, memorizzato su una chiavetta USB. Fate riferimento a  [non-free firmware .deb su una chiavetta](nf-firm-it.htm#non-free-firmware) .` 

### Panoramica

wpa-roaming è un metodo con il quale potrete trovare reti wireless e connettervi `con o senza ambiente grafico` .

Il risultato della configurazione di seguito proposta è che se un cavo ethernet non è collegato, wlan0 prende la precedenza e connette il PC alla rete wireless preferita, o ad una rete wireless aperta e disponibile, o ancora a una rete wireless predeterminata. Se si connette il cavo di rete, la rete cablata spegne immediatamente l'accesso WiFi ed eth0 vi connette alla rete cablata. Scollegando il cavo di rete, la connessione wireless verrà immediatamente resa nuovamente disponibile.

### Impostare la configurazione di rete

Come `root`  adattate il file `/etc/network/interfaces`  in modo che sia simile a questo (il nome dell'interfaccia può cambiare):

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

A questo punto wpa_supplicant necessita di un file .conf, wpa-roam.conf

~~~  
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf /etc/wpa_supplicant/wpa-roam.conf  
~~~

Utilizzare un editor di testo per aprire il file

~~~  
<editor> /etc/wpa_supplicant/wpa-roam.conf  
~~~

Togliere il commento alla linea 30 (rimuovere il **`#`** ). E poi, per evitare che le configurazioni non vengano salvate nel file:

~~~  
update_config=1  
~~~

Per impostare un laptop oppure un desktop che necessita soltanto di avere l'accesso immediato a una rete sicura, decommentate le linee (rimuovete, cioè, i **`#`** ), da WEP o WPA-WPA2PSK a seconda di quanto richiesto:

Esempio WPA:

~~~  
network={  
ssid="siduction_Worldwide" #Example WPA Network  
psk="mysecretpassphrase"  
}  
~~~

Il passo successivo mette wpa-roam.conf al sicuro da accessi non desiderati. Ciò è necessario poiché le chiavi delle reti private vengono salvate in questo file:

~~~  
chmod 600 /etc/wpa_supplicant/wpa-roam.conf  
~~~

Attivare la connessione wireless

~~~  
ifup wlan0  
~~~

Quindi controllare se si è connessi a una rete:

~~~  
wpa_cli status  
~~~

L'output dovrebbe essere simile a:

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

Se non vedete numeri accanto a ip_address=, non siete connessi; ricontrollate quindi le configurazioni fermando prima wlan0:

~~~  
wpa_action wlan0 stop  
~~~

In caso necessitiate di configurazioni di rete specializzate guardate  [qui](#net-set3) 

<div class="divider" id="net-set2"></div>
## Per abilitare il passaggio dalla rete cablata a quella wireless

Per prima cosa guardate  [Passare dalla connessione mediante cavo a quella wireless](inet-ifplug-it.htm) , in quanto se il passaggio non è impostato correttamente la connessione alla rete non avverrà.

Dopo aver impostato ifplugd la configurazione finale dovrebbe essere simile a:

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
## Utilizzare wpa-roam.conf con configurazioni di rete specificate manualmente

Con l'aiuto di `IDString`  e `Priority`  avrete indicazione della rete alla quale il PC è connesso all'avvio. La priorità più alta è `1000` , la più bassa `0` . Dovrete anche aggiungere `id_str`  a `/etc/network/interfaces` .

###### La sintassi per /etc/network/interfaces

La prima è per la connessione a server DHCP, la seconda per gli indirizzi a IP fisso. Per modificare le impostazioni:

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

###### Esempi pratici

Se volete essere connessi automaticamente alla rete wireless locale quando siete a casa, assegnare a IDString "home" e priorità "15". Se siete in viaggio e volete che il portatile si connetta ad ogni rete wireless libera e senza password disponibile, assegnate a IDString "stalk" e priorità "1" (molto bassa). Controllate, naturalmente, se la connessione è legale e disconnettetevi se è chiaramente non impostata per essere gratuita.

Parti di esempio in /etc/network/interfaces:

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

Esempio di /etc/wpa_supplicant/wpa-roam.conf (SSID e password sono cambiate o soltanto spiegate:

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

Con "disabled=1" non sarete connessi automaticamente a un blocco di rete già definito (open WLAN), ma dovrete inizializzare il roaming attraverso wpa_gui oppure wpa_cli. Per il roaming automatico non utilizzate l'opzione oppure commentate la linea con l'opzione "disabled" utilizzando un #.

### Note

###### 1. Facile da riutilizzare

Una volta impostata, potete facilmente riutilizzare la configurazione su altri laptop o desktop con schede WLAN: copiate semplicemente /etc/network/interfaces (modificando il nome dell'interfaccia se necessario) e /etc/wpa_supplicant/wpa-roam.conf nel nuovo PC. Non c'è bisogno di "installare" niente dopo questo passaggio.

###### 2. Backup

È buona idea fare il backup di /etc/network/interfaces ed /etc/wpa_supplicant/wpa-roam.conf, ma `criptatelo in quanto contiene informazioni sensibili` .

Un buon metodo per fare un backup sicuro e criptare i file di configurazione è quello di utilizzare tar e gpg. Come root:

~~~  
tar -cf- /etc/network/interfaces /etc/wpa_supplicant/wpa-roam.conf | gpg -c > backup_name.tar.gpg  
~~~

Un file è stato ora creato in $HOME:  
backup_name.tar.gpg

Per visualizzare i contenuti del file backup_name.tar.gpg:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vtf -  
~~~

To extract and decrypt the contents of the archive backup_name.tar.gpg file:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vxf -  
~~~

Per estrarre e decriptare i contenuti del file d'archivio backup_name.tar.gpg:

~~~  
gpg -d -o - backup_name.tar.gpg | tar vxf -  
~~~

###### 3. SSID nascosti

Gli SSID nascosti sono rilevati quando `scan_ssid=1`  è definito nel blocco rete.

<div class="divider" id="rousec-wifi"></div>
## Sicurezza di base per modem/router wireless

Nel caso dobbiate controllare un modem/router wireless, vi sono poche regole di base da implementare per proteggere la rete interna da incursioni.

###### Scelte di base del protocollo

+ WPA2-PSK è la migliore opzione.  
+ Come protocollo di codifica scegliere AES.  
+ La passphrase dovrebbe essere veramente difficile.  

###### Passphrase/password

Per una passphrase/password difficile da indovinare e impossibile da memorizzare utilizzate pwgen in un terminale (leggete anche: man pwgen):

~~~  
$ pwgen -s 63 1  
VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

+ -s = sicuro (non memorizzabile)  
+ 63 = numero di caratteri  
+ 1 = genera soltanto una password casuale  

Senza il -s si ottengono password di tipo verbale, ma è improbabile che vogliate ottenere questo:

~~~  
$ pwgen 8 3  
Sooxae2s Niew9ugh Hi7eeloo  
~~~

Una volta generata la passphrase/password memorizzatela in un file di testo in un dispositivo USB e applicatela ad altri computer che utilizzano la stessa rete wireless. Non archiviate la passphrase/password nel computer.

###### Esempio di una configurazione finale di router:

~~~  
Version: WPA2-PSK  
Encryption: AES  
PSK Password: VltnfGmGKXovVv2rmrCFFXBZ55Mij5bA6WytVJnVoKUqRn6dfjldG6MBrRo0Cdi  
~~~

<div id="rev">Content last revised 23/02/2012 2000 UTC</div>
