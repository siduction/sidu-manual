<div id="main-page"></div>
<div class="divider" id="ssh"></div>
## SSH

În lucrul cu computere, Secure Shell sau SSH este un set de protocoale de internet standard şi asociate care permite stabilirea unui canal de comunicare sigur între un computer local şi unul controlat de la distanţa (remote). Este folosită criptorea public-key pentru a autentifica computerul controlat şi (opţional) să permită computerului controlat să autentifice utilizatorul. SSH asigură confidenţialitatea şi integritatea datelor schimbate între cele două computere prin folosirea criptării şi a codurilor de autentificare a mesajelor (MACs). SSH este de obicei folosit pentru conectarea de la distanţă şi executarea de comenzi pe acel computer, dar suportă de asemeni tunneling, trimiterea către porturi TCP arbitrare şi conexiuni X11; poate face transfer de fişiere folosind protocoalele asociate SFTP sau SCP. Un server SSH, implicit, ascultă pe portul standard TCP 22.  [Informaţii suplimentare în wikipedia](http://en.wikipedia.org/wiki/Secure_Shell) 

<div class="divider" id="ssh-s"></div>
## Activarea celor mai potrivite protocoale de securitate pentru SSH

Permiterea logării ca root, via ssh, nu este sigură. Noi nu dorim să vă logaţi ca root deloc, aproape niciodată, debian trebuie să fie sigur nicidecum nesigur ca sistem şi nici nu dorim să acordăm 10 minute utilizatorilor pentru a încerca atacarea parolelor de logare prin ssh, dar lăsăm la latitudinea dumneavoastră să limitaţi timpul şi numărul de încercări pentru o parolă!

Pentru a va ajuta să faceţi ssh mai sigur luaţi editorul dumneavoastră favorit, porniţi-l cu privilegii root şi deschideţi acest fişier:

~~~  
/etc/ssh/sshd_config  
~~~

Apoi vom localiza intrările nesigure şi le vom schimba.

###### Intrările nesigure care trebuiesc localizate sunt:

`Port <desired port>:`  Acesta trebuie setat către portul corect cu care se iese din router. Portul de ieşire deasemeni trebuie setat şi în router. Dacă nu ştiţi cum să faceţi aceste operaţii, poate ar fi mai bine dacă n-aţi utiliza control de la distanţă. Debian setează portul implicit port 22, oricum este recomandat să folosiţi un port în afara ariei de scanare standard. Să spunem că vom folosi portul 5874, deci aceasta devine:

~~~  
Port 5874  
~~~

`ListenAddress <ip of machine or network interface>:`  Acum, bineînteles, dacă a-ţi deschis un port din router trebuie să aveţi o adresa IP statică în reţea, în afară de cazul în care utilizaţi un server dns local dar dacă faceţi ceva atât de complicat şi aveţi nevoie de aceste indicaţii probabil că faceţi o greşeală enormă. Deci, să presupunem că este aşa: 

~~~  
ListenAddress 192.168.2.134  
~~~

Mai departe, Protocol 2 este deja implicit în debian dar verificaţi ca să fiţi siguri:

`LoginGraceTime <seconds to allow for login>:`  Aceasta are o valoare implicită absurdă de 600 secunde. Nu veţi avea nevoie niciodată de 10 minute pentru a va tipări numele şi parola deci haideţi să fie:

~~~  
LoginGraceTime 45  
~~~

Acum veţi avea doar 45 secunde pentru a va loga dar hackerii nu vor mai avea 600 secunde pentru a încerca să vă spargă parola...

`PermitRootLogin <yes>:`  De ce debian a făcut PermitRootLogin 'yes', este de neînţeles, aşa că noi am schimbat asta în 'no':

~~~  
PermitRootLogin no  
~~~

~~~  
StrictModes yes  
~~~

`MaxAuthTries <xxx>:`  Numărul încercărilor la logare, poţi să o faci 3 sau 4 dar niciodată mai mult de atât.

~~~  
MaxAuthTries 2  
~~~

Va trebui să adăugați fiecare din aceste intrări dacă ele nu există:

~~~  
AllowUsers <sunt permise și nume de utilizatori care conțin spații pentru acces via ssh>  
~~~

`AllowUsers <xxx>:`  doar utilizatorii înregistraţi pot deschide ssh şi doar cu drepturi de utilizator, folosiţi  *adduser*  pentru a adăuga utilizatorul şi apoi specificaţi-i numele aici aşa:

~~~  
AllowUsers  nume_utilizator   
~~~

`PermitEmptyPasswords <xxx>:`  daţi acestui utilizator o parolă foarte lungă ce va fi imposibil de ghicit chiar şi într-un milion de ani, acesta fiind singurul căruia i se va permite să se logheze ssh. Odată logat puteţi deveni root cu  *'su'* .

~~~  
PermitEmptyPasswords no  
~~~

`PasswordAuthentication <xxx>:`  bineînţeles pentru password login, nu şi pentru key login, va trebui ca parola să fie întreagă iar aceasta opţiune să fie "yes"

~~~  
PasswordAuthentication yes [unless using keys]  
~~~

La sfârşit:

~~~  
/etc/init.d/ssh restart  
~~~

Acum veţi avea o sesiune ssh mai sigură, nu perfectă dar măcar mai bună, inclusiv prin crearea unui cont de utilizator doar pentru ssh cu  *'adduser'* .

`Notă:`  Dacă primiți un mesaj de eroare și ssh refuză să vă conecteze, mergeți în directorul $HOME, căutați un dosar ascuns numit `.ssh`  și ștergeți fișierul cu numele`known_hosts`  apoi încercați din nou. Această eroare apare mai ales când aveți un IP dinamic obtinut prin (DCHP)

<div class="divider" id="ssh-x"></div>
## Rularea Aplicaţiilor X Window Via Network prin SSH

ssh -X vă permite log-area pe un alt computer și să utilizați interfața grafică a acestuia afișată pe monitorul vostru. Ca $user (nu uitați că litera X trebie să fie mare [X nu x]) tastați:

~~~  
$ ssh -X username@xxx.xxx.xxx.xxx (or IP)  
~~~

Introduceți parola de user de pe celălalt computer și rulați o aplicație:

~~~  
$ iceweasel  SAU  oocalc  SAU  oowriter  SAU  kspread  
~~~

Unele conexiuni lente de la PC-ul vostru pot fi îmbunătățite folosind un nivel de compresie pentru a mări viteza de transfer, prin adăugarea unei extra opțiuni dar care în rețelele rapide are efect invers:

~~~  
$ ssh -C -X username@xxx.xxx.xxx.xxx (or IP)  
~~~

Citiți:

~~~  
$man ssh  
~~~

`Notă:`  Dacă primiți un mesaj de eroare și ssh refuză să vă conecteze, mergeți în directorul $HOME, căutați un dosar ascuns numit `.ssh`  și ștergeți fișierul cu numele`known_hosts`  apoi încercați din nou. Această eroare apare mai ales când aveți un IP dinamic obtinut prin (DCHP)

<div class="divider" id="ssh-scp"></div>
## Copierea fișierelor și directoarelor de la distanță via  *ssh*  cu  *scp* 

 *scp*  folosește linia de comandă, (terminal/cli), pentru a copia fișiere între calculatoare dintr-o rețea. Folosește sistemul de autentificare și securitate al  *ssh*  pentru transferul de date și deci  *scp*  vă va întreba de parole sau passphrases așa cum sunt necesare autentificării.

Presupunând că aveți drepturi  *ssh*  asupra unui alt PC sau a unui server,  *scp*  vă va ajuta să copiați partiții, directoare sau fișiere, pe sau de pe acel PC, într-o locație sau destinație specificată la alegerea dumneavoastră unde aveți de asemenea permisiunea  *ssh* . De exemplu, aceasta poate fi un PC sau un server, la care aveți permisiune de acces, aflat în rețeaua dumneavoastră LAN, (sau oriunde în lume), pentru a putea tranfera date pe un hard USB conectat la PC-ul dumneavoastră.

Puteți copia recursiv partiții întregi și directoare cu tot conținutul utilizând opțiunea `scp -r` .  *Notă* : acest  *'scp -r'*  urmărește legăturile simbolice întâlnite în explorarea arborelui de directoare și fișiere.

### Exemple:

`Exemplul 1:`  Copierea unei partiții:

~~~  
scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/ /media/diskXpartX/  
~~~

`Exemplul 2:`  Copierea unui director pe o partiție, în cazul acesta a directorului numit "photos" din $HOME:

~~~  
scp -r <user>@xxx.xxx.x.xxx:~/photos/ /media/diskXpartX/xx  
~~~

`Exemplul 3:`  Copiarea unui fișier dintr-un director pe o partiție, în acest caz a unui fișier aflat în $HOME:

~~~  
scp <user>@xxx.xxx.x.xxx:~/filename.txt /media/diskXpartX/xx  
~~~

`Exemplul 4:`  Copiarea unui fișier pe o partiție:

~~~  
scp <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt /media/diskXpartX/xx  
~~~

`Exemplul 5:`  Dacă vă aflați deja în directorul/discul de pe care doriți să copiați toate directoarele și fișierele, folosiți un '**` **.** `** ' (dot) :

~~~  
scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt.** `**   
~~~

`Exemplul 6:`  Pentru a copia fișiere de pe PC/server-ul dumneavoastră pe un altul, (folosiți `scp -r`  dacă copiați partiție sau un director):

~~~  
scp /media/disk1part6/filename.txt <user>@xxx.xxx.x.xxx:/media/diskXpartX/xx  
~~~

Citiți:

~~~  
man scp  
~~~

<div class="divider" id="ssh-w"></div>
## Acces Remote ssh cu X-Forwarding de la un Windows-PC:

* Descărcaţi şi scrieţi pe un CD  [Cygwin XLiveCD](http://xlivecd.indiana.edu/)   
* Introduceţi CD-ul în unitate CD-ROM a computerului windows şi aşteptaţi autolansarea.  
Apăsaţi "continue" până la apariţia unei console şi introduceţi:

~~~  
ssh -X username@xxx.xxx.xxx.xxx  
~~~

 *Notă* : xxx.xxx.xxx.xxx este IP-ul computerului linux comandat sau URL-ul sau (de exemplu un cont dyndns.org) iar username este bineînţeles un nume de utilizator ce există pe computerul comandat. După ce v-aţi logat cu succes, porniţi "kmail" de exemplu şi verificaţi-vă mesajele!

 *Important* : fiţi siguri că hosts.allow are o intrare pentru accesul de la computerele din alte reţele. Dacă sunteţi în spatele unui NAT-Firewall sau a unui router asiguraţi-vă că portul 22 este deschis către computerul linux.

<div class="divider" id="ssh-f"></div>
## SSH cu Konqueror

 Atât Konqueror cât şi Krusader sunt capabile să acceseze date remote, folosind `sftp://`  și amândouă utilizează protocolul ssh.

Cum funcţionează :  
1) Deschideți o fereastră Konqueror  
2) Introduceți în bara de adrese: `sftp://username@ssh-server.com` 

Exemplul 1 : 

~~~  
sftp://siduction1@remote_hostname_or_ip  
( Notă* : Va apare un popup care va cere parola de ssh, introduceți-o și click OK)  
~~~

Exemplul 2 : 

~~~  
sftp://username:password@remote_hostname_or_ip  
(În această formă NU  vă mai cere parola și veți fi conectați direct.)  
~~~

Pentru conectarea în LAN 

~~~  
sftp://username@10.x.x.x or 198.x.x.x.x  
( Notă* : Va apare un popup care va cere parola de ssh, introduceți-o și click OK)  
~~~

Conexiunea Konqueror SSH este acum iniţializată. În această fereastră Konqueror puteţi lucra cu fişierele (copy/view) care sunt pe serverul SSH ca şi cum ar fi într-un folder din computerul local.

` *NOTĂ* : Dacă ai stabilit port-ul ssh ca fiind altul decât cel implicit (22), trebuie să specifici port-ul pe care sftp trebuie să-l folosească:`

~~~  
sftp://user@ip:port  
~~~

'user@ip:port' este sintaxa standard pentru multe programe ca sftp și smb.

<div class="divider" id="ssh-fs"></div>
## SSHFS - Mount-area de la distanță

SSFS este o metodă uşoară, rapidă şi sigură care utilizează FUSE pentru a monta un sistem de fişiere de la distanţă. Singura cerinţă ce trebuie îndeplinită de server este rularea unui daemon ssh.

Pe partea de client va trebui probabil să instalați 'sshfs': `instalarea 'fuse' și 'groups' nu este necesară sub siduction ele fiind instalate implicit:` 

Pe computerul client probabil va trebui să instalaţi sshfs: 

~~~  
apt-get update && apt-get install sshfs  
~~~

`Acum va trebui să vă re-logaţi.`

Mont-area unui sistem de fişiere remote este simplă:

~~~  
sshfs username@remote_hostname:directory local_mount_point  
~~~

unde `username`  este numele de utilizator de pe computerul comandat:

Dacă nici un director nu este specificat, directorul home al utilizatorului din computerul remote va fi montat.`Atenţie: Semnul **` **:** `**  este esenţial chiar dacă nici un director nu este specificat!` 

După montarea de la distanţă directorul se va comporta ca orice alt director local, puteţi răsfoi fişierele, edita sau chiar rula scripturi pe el.

Dacă doriţi să-l de-montaţi folosiţi următoarea comandă:

~~~  
fusermount -u local_mount_point  
~~~

Dacă utilizaţi sshfs frecvent ar fi o decizie bună să adăugaţi o intrare în fstab:

~~~  
sshfs#username@remote_hostname://remote_directory /local_mount_point fuse user,allow_other,uid=1000,gid=1000,noauto,fsname=sshfs#username@remote_hostname://remote_directory 0 0  
~~~

Apoi de-comentați `user_allow_other`  în `/etc/fuse.conf` :

~~~  
# Allow non-root users to specify the 'allow_other' or 'allow_root'  
# mount options.  
#  
user_allow_other  
~~~

Asta va permite oricărui utilizator ce face parte din grupul fuse să monteze sistemul de fişiere folosind binecunoscuta comandă mount:

~~~  
mount /path/to/mount/point  
~~~

Având aceasta linie în fstab veţi putea deasemeni folosi şi comanda umount:

~~~  
umount /path/to/mount/point  
~~~

Pentru a verifica dacă faceţi parte sau nu din acest grup lansaţi comanda:

~~~  
cat /etc/group | grep fuse  
~~~

Ar trebui să vedeţi ceva de genul:

~~~  
fuse:x:117: <username>  
~~~

` *Notă* : Parametrul "id" nu va fi listat în grupul "fuse" până când nu veţi ieşi şi vă veţi loga înapoi.`

Dacă numele dumneavoastră de utilizator nu este listat folosiţi comanda adduser ca root:

~~~  
adduser <username> fuse  
~~~

Acum numele de utilizator ar trebui să fie listat şi dumneavoastră ar trebui să puteţi rula:

~~~  
mount local_mount_point  
~~~

 şi 

~~~  
umount local_mount_point  
~~~

<div id="rev">Content last revised 01/11/2011 0650 UTC</div>
