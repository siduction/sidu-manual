<div id="main-page"></div>
<div class="divider" id="rdiff"></div>
## Salvările de Sistem cu  *rdiff* 

 *rdiff-backup*  este o unealtă folosită pentru a salva fişiere. (şi poate rula pe o varietate de porturi *nix).

**`Rulaţi comenzile în consolă ca  *root*  dacă nu este specificat altfel`**

*foarte bun pentru recuperarea de după  *dist-upgrade*  sau după actualizări de kernel nereuşite, etc (şi deasemeni pentru a restaura fişiere individuale).  
*salvează doar ceea ce este schimbat ca şi  *rsync*  (deci fiecare  *backup*  nu durează mult).  
*ţine un jurnal al schimbărilor (ceea ce înseamnă că puteţi restaura fişiere pe care le-aţi şters acu` trei săptămâni!).  
*face salvări în condiţii de securitate din reţea (folosind  *ssh* ).  
*face salvarea unei partiţii întregi în timp ce este mount-ată (este uşor să programaţi o salvare automată...fără să faceţi de-mount-are).  
*poate restaura totul în cazul în care discul devine inutilizabil şi trebuie să cumpăraţi altul.  
*se autoconfigurează pentru a salva o reţea întreagă (în linux este perfect, în windows un pic mai dificil) şi este folosit în afaceri.  
*este o aplicaţie controlată din linia de comandă, foarte potrivită pentru cei care preferă să facă  *backup*  automat (cum ar fi un script  *bash*  lansat prin intermediul  *cron* ).  
*memorează şi se descurcă foarte bine cu apartenenţa fişierelor şi permisiunile acestora precum şi cu link-urile simbolice (şi toate lucrurile de acest gen) deci când veţi face restaurarea toate vor fi exact cum au fost înainte.

###### Ce veţi avea nevoie

 *rdiff-backup*  ţine o copie completă (necompresată) a fişierelor pe care le salvaţi, deasemeni ţine un jurnal a ceea ce este salvat ( *incremental backups* ), asta înseamnă că spaţiul pe care se salvează va fi mai mare decât ceea ce este salvat. Dacă salvaţi 100 giga de spaţiu este posibil să aveţi nevoie de 120 giga pentru a salva (şi de preferat pe un hard separat !).

###### Setările care trebuiesc făcute

Să spunem că PC-ul dumneavoastră are următoarele:  
* un hard de 100 giga ce este folosit (sda), cu partiţia  *sda1*  ca partiţie  *root* , partiţia  *sda5*  pentru a stoca muzică şi alte fişiere şi partiţia  *sda6*  ca  *swap* .  
* un disc nefolosit de 200 giga ( *sdb* ) cu partiţia  *sdb1*  ... şi pe care o vom folosi pentru salvările noastre.  
* adresa IP 192.168.0.1

Primul lucru ce trebuie făcut este să instalăm  *rdiff-backup* :

~~~  
# apt-get install rdiff-backup  
~~~

Acum veţi putea să salvaţi orice director, dar aici presupunem că salvăm o întreagă partiţie...vom salva partiţiile  *sda1*  şi  *sda5*  (nu şi  *sda6* ) iar pentru aceasta vom crea nişte directoare în care vom stoca datele:

~~~  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/root  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

Trebuie ca adresa IP să fie specificată exact pentru că se poate salva şi o partiţie din alt calculator, iar la restaurare să ştie pe care calculator să o facă (vom vedea mai departe).

###### Salvarea

 *rdiff-backup*  foloseşte sintaxa `rdiff-backup source-dir dest-dir` . *Notă:*  întotdeauna specificaţi numele directorului, nu numele fişierelor.

Pentru a face salvarea partiţiei  *sda5* , rulaţi:

~~~  
# rdiff-backup /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

Iar pentru a salva partiţia  *root* , rulaţi:

~~~  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
~~~

Orice eroare de genul  **"AF_UNIX path too long"**  poate fi ignorată.Aceasta va dura ceva timp de vreme ce este prima oară când partiţia e salvată şi deci  *rdiff-backup*  va trebui să o scrie în întregime (nu numai diferenţele).Observaţi că nu salvăm  */tmp*  deoarece acesta mereu se schimbă, şi nici  */proc*  sau  */sys*  din cauză că acestea nu conţin fişiere reale, şi deasemeni nu vom salva punctele de mount-are. Dacă am face salvarea punctului de mount-are am salva de fapt  *sdb1*  şi am intra într-o buclă infinită!. O altă cale este să salvaţi punctele de mount-are separat.

Acum, motivul pentru care se foloseşte  *'/proc/*'*  în loc de  *'/proc'*  este că astfel ar fi salvat doar numele de director  */proc* , şi ar fi ignorat tot ceea ce este în interiorul acestuia. La fel este valabil şi pentru  */tmp* ,  */sys* , şi chiar pentru punctele de mount-are.

În acest fel, dacă vă veţi distruge partiţia  *root*  şi veţi apela la o restaurare completă numele directoarelor  */tmp* ,  */proc* ,  */sys*  şi numele punctelor de mount-are vor fi create (aşa cum ar trebui). Dacă  */tmp*  nu există când  *X*  porneşte vi se va semnaliza. (Găsiţi mai multe în manual pentru opțiunile  *--exclude*  şi  *--include* ).

###### Restaurarea directoarelor din salvările prealabile

 *rdiff-backup*  foloseşte sintaxa:

~~~  
rdiff-backup -r <from-when> <source-dir> <dest-dir>  
~~~

Dacă din greşeală aţi şters directorul  */media/sda5/photos* , îl puteţi restaura executând:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5/photos /media/sda5/photos  
~~~

Opţiunea  *"-r now"*  înseamnă restaurarea din ultima salvare făcută. Dacă aţi făcut salvări periodice (via  *crontab* , să spunem) şi nu v-aţi dat seama că acel director cu fotografii lipseste până acum câteva zile veţi avea nevoie de o restaurare dintr-o salvare făcută acum câteva zile (şi nu  *"now"* , pentru că în ultima salvare făcută probabil acel director nu există). Sau poate că vreţi pur şi simplu să ajungeţi înapoi la o anumită versiune a unui program, ceva.

Dacă doriţi să restauraţi la starea de acum trei zile folosiţi opţiunea  *"-r 3D"*  ... dar, aşa cum este menţionat şi în manual, reţineţi:

` *"3D"*  se referă la exact 72 ore înainte de momentul prezent iar dacă nu există nici o salvare făcută la acel moment,  *rdiff-backup*  va restaura starea salvată anterior acestui moment. Ca în cazul de mai sus, de exemplu, dacă  *"3D"*  este folosit şi există salvări făcute cu 2 şi cu 4 zile în urmă, acel director va fi restaurat aşa cum era el cu 4 zile în urmă (deci vă trebui să vă gândiţi bine înainte de a face restaurarea).`

Folosind următoarele comenzi veţi primi o listă cu data şi ora la care au fost făcute toate salvările pentru  *sda5* :

~~~  
# rdiff-backup -l /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

##### Restaurarea partiţiilor

Puteţi deasemeni restaura partiţii întregi (puncte de mount-are), până la urmă un punct de mount-are este tot un director.

**`ATENŢIE!!!: Nu încercaţi să restauraţi partiţia  *root*  atât timp cât lucraţi de pe ea! Cu o singură comandă puteţi pierde toate fişierele de pe toate partiţiile, inclusiv salvările de pe un disc separat!!  *rdiff-backup*  face exact ce-i spuneţi să facă ... dacă salvarea pentru partiţia  *root*  are puncte de mount-are goale, programul va şterge orice există în punctul de mount-are pentru a face să fie conform salvării existente.`**

Pentru a restaura  *sda5*  din ultima salvare vom executa:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5 /media/sda5  
~~~

##### Restaurarea partiţiei  *root* 

Pentru a restaura partiţia  *root*  nu este la fel de simplu. Nu restauraţi niciodată partiţia  *root*  atât timp cât este mount-ată (citiţi avertismentul de mai sus). Este foarte util să poţi restaura partiţia  *root* , mai ales după o încercare nereuşită de actualizare sau de instalare a unui nou kernel (etc); veţi fi liniștiți știind că puteţi întoarce lucrurile aşa cum au fost şi toate acestea în doar 20 minute.

O cale de a restaura partiţia  *root*  este să boot-aţi într-o partiţie linux neocupată, dacă aveţi una în computer. De acolo veţi putea restaura partiţia dorită, dacă nu este mount-ată ca  *root* . După ce restauraţi partiţia puteţi porni de pe ea şi veţi vedea că este exact ca înainte ...exact! Aceasta nu este nicidecum cea mai uşoară metodă.

O altă cale de a restaura partiţia  *root*  este să porniţi cu siduction live-cd şi să faceţi restaurarea de acolo.  *rdiff-backup*  este inclus în siduction.În cazul în care versiunea siduction live-cd pe care o aveţi nu include şi  *rdiff* , puteţi folosi în linia de comandă a lui  *grub*  (Bootoptions, (Cheatcodes)) codul "unionfs" iar asta va însemna că veţi putea instala programe noi cât timp rulaţi de pe live-cd. Doar porniţi şi lansaţi următoarele comenzi:

~~~  
$ sudo su  
# wget -O /etc/apt/sources.list http://siduction.org/files/misc/sources.list  
# apt-get update  
# apt-get install rdiff-backup  
~~~

###### Acum vom face restaurarea:

~~~  
# mount /dev/sda1 /media/sda1  
# mount /dev/sdb1 /media/sdb1  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

 *Notă :*  În cazul în care aveţi un Live-CD care suportă  *klik*  puteţi instala  *rdiff-backup*  folosind  *Klik*  şi rulând:

~~~  
$ sudo ~/.zAppRun ~/Desktop/rdiff-backup_0.13.4-5.cmg rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

Este recomandat ca toţi cei care fac salvarea partiţiei  *root*  (cu intenţia de a o restaura la nevoie) să facă un test al procesului de restaurare. Nimic nu este mai neplăcut decât să te gândeşti că totul va fi în regulă după restaurare şi aceasta să nu reuşească din cauza a ceva neaşteptat atunci când ai mai mare nevoie.

Dacă hard disk-ul a fost schimbat sau reformatat, re-verificați UUID-urile, (sau Etichetele 'Labels'), în `/boot/grub/menu.lst (grub-legacy) sau fișierele din /etc/grub.d (grub2)`  și `/etc/fstab` , apoi modificațile corespunzător. O metodă ușoară de a obține informațiile pentru a modifica fișierele  *menu.lst*  și  *fstab* , la nevoie, este să executați ca  *'root'* :

~~~  
blkid  
~~~

##### Salvarea partiţiilor din alte computere 

Puteţi să salvaţi partiţiile altor computere în computerul local atâta vreme cât vă puteţi conecta  *ssh*  la acele computere (şi aveţi destul spaţiu pe hard disc). Serverul  *ssh (sshd)*  trebuie să ruleze pe computerul comandat. Acesta nu trebuie să fie neapărat în rețeaua locală, poate fi oriunde în lume.

Să presupunem că PC-ul comandat are urmatoarele:  
1) un hard de 100 giga ( *sda* ) în uz, cu următoarele,  
2)  *sda1*  ca partiţie  *root* ,  
3)  *sda5*  unde sunt stocate nişte fişiere temporare şi pe care nu dorim să le salvăm,  
4) şi  *sda6*  ca partiţie  *swap*  şi adresa IP 192.168.0.2

 *Notă :*  două discuri de 100 giga de obicei nu pot fi salvate pe un disc de 200 giga folosind  *rdiff-backup*  (pentru că nu va mai fi loc şi pentru fişierele incrementale) dar, pentru că nu salvaţi şi partiţia  *sda5*  de pe computerul comandat (şi pentru că de obicei discurile nu sunt 100% pline, dar nu vă bazaţi pe asta) va trebui întotdeauna să calculaţi dacă aveţi destul spaţiu pentru  *backup* . De fiecare dată când  *rdiff-backup*  face o alta salvare, el va crea încă un fişier incremental şi acesta va ocupa din ce în ce mai mult spaţiu.

Puteţi specifica programului  *rdiff-backup*  să păstreze salvările doar din ultima lună (această comandă va fi detaliată mai târziu) şi aceasta va ocupa mai puţin spaţiu decât salvările unui an întreg. Bineînţeles, dacă veţi dori să păstraţi salvările de pe parcursul întregului an veţi avea nevoie de spațiu pe hard corespunzător mărimii fişierelor incrementale făcute de-a lungul întregului an.

Va trebui mai întâi să instalaţi  *rdiff-backup*  pe computerul comandat (oricare computer căruia doriţi să-i faceţi salvări, inclusiv  *server backup* , trebuie să aibă  *rdiff-backup*  instalat).

Pentru a salva datele din computerul comandat în calculatorul local rulaţi în computerul local (cu adresa, să zicem 192.168.0.1): `Fiţi atenţi la folosirea de două ori a semnului două puncte ::` 

~~~  
# mkdir /media/sdb1/rdiff-backups/192.168.0.2/root  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' 192.168.0.2::/ /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Acum, dacă doriţi să restauraţi un director în computerul comandat, puteţi iniţia restaurarea atât din computerul local cât şi din cel comandat.

În exemplul următor veţi restaura fişierul  */usr/local/games*  în computerul comandat, iniţializând restaurarea tot din computerul comandat:

~~~  
# rdiff-backup -r now 192.168.0.1::/media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games /usr/local/games  
~~~

În exemplul ce urmează veţi restaura directorul  */usr/local/games*  în computerul comandat, iniţializând restaurarea din computerul local:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games 192.168.0.2::/usr/local/games  
~~~

Folosiţi cam aceaşi sintaxă când restauraţi partiţia  *root*  de pe un live-cd (când computerul comandat a fost pornit de pe live-cd ...vedeţi mai sus).

##### Salvările automate :

Dacă vreţi să salvaţi partiţiile altor computere în computerul local primul lucru ce trebuie făcut este să activaţi log-area  *ssh*  fără parolă folosind  *ssh keys* . **`Reţineţi că acum vorbim despre log-area  *ssh*  ca  *root*  fără parolă. Acest lucru poate fi restricţionat în aşa fel încât numai comenzile  *rdiff-backup*  să fie executate dar prezentarea acestei secţiuni este în afara subiectului nostru deocamdată. Adresaţi-vă la  [Configurarea SSH](ssh-ro.htm#ssh-s) `** . Vom presupune că suntem în deplină siguranţă şi vom seta cel mai simplu mod de conectare  *ssh*  fără parolă.

De pe PC-ul local executaţi următoarele:

~~~  
# [ -f /root/.ssh/id_rsa ] || ssh-keygen -t rsa -f /root/.ssh/id_rsa  
~~~

Şi apăsaţi  *Enter*  de două ori pentru nicio parolă. Apoi faceţi:

~~~  
# cat /root/.ssh/id_rsa.pub | ssh 192.168.0.2 'mkdir -p /root/.ssh;\<!--dunno if this is right-->  
> cat - >>/root/.ssh/authorized_keys2'  
~~~

Vi se va cere parola de  *root* .

Acum vă puteţi loga prin  *ssh*  în computerul comandat fără să mai trebuiască să tastaţi parola şi se poate executa  *rdiff-backup*  în mod automat.

Mai departe creaţi un script  *bash*  care să conţină toate comenzile  *rdiff-backup* . Acest script va arăta cam aşa:

~~~  
#!/bin/bash  
RDIFF=/usr/bin/rdiff-backup  
echo  
echo "=======Backing up 192.168.0.1 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' /media/sdb1/rdiff-backups/192.168.0.1/root  
echo "(and purge increments older than 1 month)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/root  
echo  
echo "=======Backing up 192.168.0.1 mount sda5======="  
${RDIFF} --ssh-no-compression --exclude /media/sda5/myjunk /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo "(and purge increments older than 1 months)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo  
echo "=======Backing up 192.168.0.2 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' --exclude '/mnt/*/*' 192.168.0.2::/media/sdb1/rdiff-backups/192.168.0.2/root  
echo "(and purge increments older than 1 months)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Numiţi acest script  *"myrdiff-backups.bash"*  şi salvaţi-l în  */usr/local/bin*  din computerul local (serverul de backup) şi schimbaţi-l într-un executabil. Rulaţi scriptul şi asiguraţi-vă că funcţionează.

În final puteţi seta  *cron*  să lanseze scriptul în fiecare seară la 8pm. Următoarea linie în  *root's crontab*  va face totul, deschideţi

~~~  
# crontab -e  
şi introduceţi următoarea linie  
0 20 * * * /usr/local/bin/myrdiff-backups.bash  
~~~

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
