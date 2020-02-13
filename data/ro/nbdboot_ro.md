<div id="main-page"></div>
<div class="divider" id="nbd1"></div>
## Boot-area în rețea (network block device - nbd)

**`ATENȚIE !:  *dnsmasq*  include un server  *dhcp*  ce poate intra în conflict cu un server  *dhcp*  existent în rețeaua voastră (router-ul poate oferi unul).`**  `Cel mai sigur este să folosiți doar un singur server  *dhcp*  într-o rețea. Asta înseamnă că trebuie să dezactivați toate serverele 'dncp' dintr-o rețea. Opțiunea 'dnsmasq proxy', menționată mai sus, ar trebui să poată co-exista cu un alt server  *dhcp*  în aceeași rețea, dar oricum vă rog să nu încercați asta decât dacă sunteți administratorul rețelei și sunteți pregătit să faceți față unor consecințe nedorite ce pot apare.` 

#### Informații de bază

Pentru a putea boot-a din rețea trebuie să aveți un PC capabil să facă asta, care să poată fi conectat prin rețea la un PC programat să ofere servicii de boot-are în rețea. 

Nu faceți asta în rețeaua de la serviciu sau într-o rețea pe care nu o administrați dumneavoastră cu excepția cazului când o administrați sau aveți permisiunea și îndrumarea administratorului de rețea. Dacă sunteți co-operator într-o rețea mare cercetați toate opțiunile lui  *dnsmasq* , cum ar fi limitarea interfețelor ascultate sau a clienților ce vor răspunde, pentru a reduce impactul setărilor voastre asupra rețelei.

#### Condiții necesare

Un siduction iso 2009-04 (sau mai nou) boot-at să fie folosit ca serverul de boot din rețea (network boot server). În principiu, instrucțiunile ar trebui să fie aceleași pe oricare PC cu o versiune actualizată de siduction sau debian sid și ar trebui să vă ofere toate indiciile necesare a fi folosite pe alte sisteme. Linux este necesar pentru a servi dispozitivele 'nbd'.

Vom folosi  *dnsmasq*  pentru a furniza totul în faza de boot-are inițială iar cunoștiințele necesare nu vor fi greu de adaptat altui software.

###### Instalarea

~~~  
apt-get install nbd-server dnsmasq  
~~~

### Configurarea 'nbd-server'

 Presupunem că imaginea poate fi găsită la `/dev/scd0` , (aceasta ar putea fi dacă se boot-ează de pe cd, altfel înlocuiți cu calea corespunzătoare către dispozitiv sau fișier), apoi puteți configura fișierul nbd-server numit `nbd-siduction.conf`  cu o secțiune numită siduction-iso pentru a exporta cd-ul rulând următoarele:

~~~  
echo '[generic]' > nbd-siduction.conf  
nbd-server 0.0.0.0:10809 /dev/scd0 -o siduction-iso >> nbd-siduction.conf  
~~~

Titlul "generic" este totdeauna necesar. Dacă doriți să configurați 'nbd-server' să lucreze automat într-un sistem real va trebui probabil să configurați `/etc/nbd-server.conf`  în loc de `nbd-siduction.conf` . Există mult mai multe opțiuni ale nbd-server decât am arătat aici, așa că citiți `man nbd-server.` 

Pentru a porni server-ul ca utilizator normal, fără a vă chinui cu setările sau să tot copiați fișierul la `/etc/nbd-server.conf` , puteți rula comanda:

~~~  
nbd-server -C nbd-siduction.conf  
~~~

Ținta lui nbd-server nu trebuie să fie un iso sau un cd/dvd/usb stick; trebuie doar să conțină o imagine corespunzătoare a sistemului de fișiere.

#### dnsmasq

Următorul exemplu presupune că PC-ul vostru este într-o rețea simplă, cu o conexiune ethernet setată prin  *dhcp*  de la un alt PC pe care clienții de boot-are din rețea îl pot folosi pentru setarea interfețelor lor prin  *dhcp* .

Opțiunile cele mai relevante pentru  *dnsmasq*  ca siduction să boot-eze din rețea este de a configura o cale (path) pentru fișierele server-ului 'tftp' și un fișier pentru a boot-a de acolo. 

Creați un director `tftp`  pentru boot-are în `/home`  (puteți să-l creați oriunde vreți dacă preferați alt loc). Deci calea (path) devine `/home/tftp` .

Creați un fișier numit `pxe-siduction.conf`  și scrieți în el (copy/paste) următoarele:

~~~  
dhcp-range=0.0.0.0,proxy  
pxe-service=x86PC, &quot;boot linux&quot;, pxelinux  
enable-tftp  
tftp-root=/home/tftp  
tftp-secure  
~~~

Când utilizați proxy-ul  *dhcp*  trebuie să oferiți un menu 'pxe' cu 'pxelinux' ca singură opțiune ce va porni automat. Asta face linia cu "pxe-service" de mai sus.

Ca root, mutați nou creatul fișier `pxe-siduction.conf`  în `/etc/dnsmasq.d/` :

~~~  
sux  
mv pxe-siduction.conf /etc/dnsmasq.d/  
~~~

Notă: Pentru o rețea (e.g. 192.168.0.*) fără alt server  *dhcp*  puteți schimba primele două linii în:

~~~  
dhcp-range=192.168.0.100,192.168.0.199,1h  
dhcp-boot=pxelinux.0  
~~~

Pentru a oferi adrese IP începând cu 192.168.0.100 până la 192.168.0.199, cu un timp de reîmprospătare de o oră, și a da numele fișierului doar pentru a rula 'pxelinux.0' ca parte a cererii dhcp, de-comentați setarea "conf-dir" din josul fișierului `/etc/dnsmasq.conf`  apoi restartați  *dnsmasq* .

Pentru ca noua configurație să fie folosită trebuie să de-comentați linia `conf-dir=/etc/dnsmasq.d`  de la sfârșitul fișierului `/etc/dnsmasq.conf`  apoi restart-ați dnsmasq.

 *dnsmasq*  are multe opțiuni și poate funcționa ca server 'dns' la fel de bine ca și server  *dhcp* , 'pxe' și 'tftp'. Cele de mai sus sunt doar o simplă și minimală abordare a pieselor necesare utilizării 'pxelinux'.

#### tftp

'tftp' este echivalentul de rețea al directorului de boot. Utilizând în continuare directorul `/home/tftp`  din exemplul nostru, trebuie să-l populăm. Dacă cdrom-ul este mount-at în `/fll/scd0` :

~~~  
cp /fll/scd0/boot/isolinux/* /home/tftp  
mkdir /home/tftp/pxelinux.cfg  
mv /home/tftp/isolinux.cfg /home/tftp/pxelinux.cfg/default  
mkdir /home/tftp/boot  
cp /fll/scd0/boot/vmlin /fll/scd0/boot/initr /fll/scd0/boot/memtest /home/tftp/boot/  
cp /usr/lib/syslinux/pxelinux.0 /home/tftp/  
# required for the tftp-secure option to dnsmasq  
chown -R dnsmasq.dnsmasq /home/tftp/*  
~~~

Acum puteți edita opțiunile de boot-are după cum doriți în `/home/tftp`  în ambele fișiere `pxelinux.cfg/default`  și `gfxboot.cfg` .  
<p>În particular este recomandabil ca, în secțiunea `[install]` , să setați `install=` în `install=nbd` , `install.nbd.server`  pentru IP-urile serverelor din rețea și `install.nbd.port`  pentru numele secțiunii de export a nbd, de exemplu. siduction-iso (ca nume de export nbd fiind mai explicit decât folosirea simplă a numerelor porturilor).

Alternativ puteți dezactiva complet menu-ul F3 și editați linia de comandă a kernel-ului să folosească ceva de genul:

~~~  
fromhd=/dev/nbd0 root=/dev/nbd0 nbdroot=192.168.1.23,siduction-iso nonetwork  
~~~

###### codul de boot-are 'toram'

Dacă adăugați 'toram' la opțiunile de boot-are, PC-urile cu suficient RAM vor elibera serverul imediat după ce și-au copiat fișierele iar PC-urile fără suficient RAM vor boot-a normal. Cel puțin 1 gig de RAM, (ideal ar fi 2 gig sau mai mult), sunt necesari pentru 'toram'.

#### Boot-area din rețea

Asigurați-vă că BIOS-urile PC-urilor clienți sunt setate să folosească `Boot from Network` . 

Dacă BIOS-ul poate boot-a din rețea, PC-ul este conectat la o rețea cu server-ul vostru iar kernel-ul siduction și initrd.img suportă placa voastră de rețea, ar trebui să boot-ați siduction din rețea. 

Unele plăci de rețea pot cere non-free firmware ceea ce ar putea necesita reconstruirea imaginii 'initrd' pentru a include firmware-ul.

<div id="rev">Page last revised 30/11/2012 0200 UTC </div>
