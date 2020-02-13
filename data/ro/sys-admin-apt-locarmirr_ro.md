<div id="main-page"></div>
<div class="divider" id="approx"></div>
## dist-upgrade pe PC-uri când lătimea de bandă / viteza e o problemă

Pentru cei ce au mai mult de 1 PC, și/sau restricții de bandă, sau cei care vor să aibă PC-ul actualizat dar au restricționată de viteza de către furnizorul de internet (ISP) și/sau combinat cu restricții de bandă, sunt soluții de a menține toate PC-urile în stadiul 'la zi' (up to date), chiar dacă acestea sunt într-o rețea (LAN) permanentă sau temporară.

Soluția este de a folosi o magazie locală de arhive (local archive mirror) pe unul dintre PC-uri pe care, celelalte PC-uri din LAN, s-o poată folosi pentru dist-upgrade, lăsând astfel utilizarea benzii pentru alte activități zilnie importante.

<!--There are various caching solutions to suit your needs: approx, apt-cacher, and squid to name just 3. siduction recommends approx.

-->
### Condiții necesare

Asigurațivă că aveți cel puțin 6 gig spațiu liber pentru arhive (cache).

## Utilizarea 'approx' ca magazie locală de arhive

Când PC-ul client va cere pachetele i se vor oferi cele descăcate deja pe PC-ul care găzdiuiește magazia `approx server` , alimentată în prealabil prin `apt-get update` , `dist-upgrade -d`  sau `dist-upgrade` .

#### Pasul 1: Configurare Server-ului pentru Clienți să ultilizeze 'approx'

~~~  
apt-get install approx  
~~~

~~~  
mcedit /etc/approx/approx.conf  
~~~

Modificați fișierul `approx.conf`  să folosească locațiile de download online (mirrors):

~~~  
# Here are some examples of remote repository mappings.  
# See http://www.debian.org/mirror/list for mirror sites.  
debian http://ftp.iinet.net.au/debian/ `<< change to your local debian mirror   
siduction http://siduction.net/debian/  
~~~

`Aplicați aceași sintaxă și altor repositories pe care le doriți să fie disponibile local.` 

Porniți server-ul approx cu:

~~~  
update-inetd --enable approx  
~~~

Dacă nu merge din prima, reboot-ați PC-ul care are instalat server-ul approx deoarece 'approx' este cunoscut ca încăpățânat la pornire.

După reboot-are rulați `apt-get update`  și `dist-upgrade`  sau `dist-upgrade -d` . Aceasta vă va asigura că 'approx' poate accesa ultimele pachete pentru PC-urile client cu exepția când sunt deja instalate unele pachete pe PC-urile client ce nu sunt pe PC-ul gazdă. În această situație 'approx' va merge să ia cel mai potrivit pachet.

Pachetele sunt adunate în `/var/cache/approx`  ce va fi populat după prima rulare de către clienți.

#### Pasul 2: Configurarea Clienților să folosească Server-ul approx

Modificați fișierele `/etc/apt/sources.list.d/*.list`  să folosească approx ca locațiile voastre de debian și siduction.

<!--###### This para is most likely complete and utter rubbish, but put here as a reminder maybe better adding an approx.list and renaming the debian and siduction .lists 

<p></p>-->
Cu 'mcedit', comentați link-urile URL curente (puneți un `#`  la începutul lor), adăugați următoarele linii și salvați modificările, de examplu:

###### Lista surselor Debian

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

~~~  
#deb your current debian mirror  
deb http://approx:9999/debian/ sid main contrib non-free  
~~~

###### Lista surselor siduction

~~~  
mcedit /etc/apt/sources.list.d/siduction.list  
~~~

~~~  
#deb your current siduction mirror  
deb http://approx:9999/siduction/ sid main fix.main  
~~~

###### Alte liste de surse

Aplicați aceleași reguli cum sunt cerute de fișierele sources.list.

###### Gazda Proxy

Apoi editați fișierul `/etc/hosts`  pentru a adăuga proxy-ul local care să acceseze adresa IP a serverului vostru:

~~~  
mcedit /etc/hosts  
~~~

~~~  
10.1.1.X approx  
~~~

Acum rulați `apt-get update`  și `dist-upgrade`  sau `dist-upgrade -d` . Prima rulare pe fiecare din PC-urile client poate fi înceată și ar putea chiar da o eroare 'time out', deci încercați din nou. Următoarele rulări vă vor oferi câștigurile pe termen lung pe care le-ați urmărit.

<div id="rev">Content last revised 30/11/2012 1145 UTC</div>
