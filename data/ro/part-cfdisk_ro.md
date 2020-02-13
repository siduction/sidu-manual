<div id="main-page"></div>
<div class="divider" id="disknames"></div>
## Numirea Discurilor

##### **`ATENŢIE !!: pentru numirea discurilor`**  [consultaţi UUID, Etichetarea Partiţiilor şi fstab, pentru că acum siduction folosește sistemul de notare UUID ca implicit.](part-uuid-ro.htm) 

#### Practicile curente de numire:

##### Pentru Discuri

De când a fost adoptat  *udev*  şi  *Universal Unique Identifier's (UUID)* , odată cu sosirea ultimelor kernel-uri, toate dispozitivele utilizează o schemă de denumire din trei litere bazată pe `sda`  pentru discuri şi pe `sdaX`  pentru partiţiile discurilor.

Indiferent de standardul utilizat, PATA (IDE), SATA (Serial ATA) sau SCSI, singura cale de a diferenţia un disc de altul într-un computer este acum cea de-a treia literă a dispozitivului `/dev/sda1, /dev/sdb1, /dev/sdc1, /dev/sdd1` , etc.

Vedeţi dispozitivul listat în acest fel în momentul când treceţi cu mouse-ul peste icon-ul său de pe ecran fie în siduction live-cd fie într-o instalare pe HD.

Este recomandat să construiţi un tabel, de mână ori prin uneltele oferite de computer, în care să vă treceţi toate detaliile despre dispozitivele-block disponibile în computer. Chiar dacă este plictisitoare, operaţiunea vă poate salva de o mulţime de probleme şi de la a pierde o grămadă de timp ulterior.

Fişierul `/etc/fstab`  din siduction live-cd sau instalat pe HD, ţine informaţiile despre `/dev/ sdaX`  între paranteze pătrate pentru fiecare dispozitiv. De exemplu  *(literele îngroşate sunt doar ca exemplu)* : 

~~~  
# added by siduction [ **/dev/sdd1 , no label]  
UUID=2ae950df-7d72-4d9b-a71a-bad1eb2d4f6a / ext4 defaults,errors=remount-ro,relatime 0 1  
~~~

##### Pentru partiţii

Cum a-ţi văzut mai sus, pentru partiţii, identificatorul `/dev/disk`  este completat de un număr. 

Există următoarele tipuri de partiţii: primară, extinsă şi logică, iar cele logice sunt conţinute în cele extinse. Sunt maximum 4 partiţii primare sau 3 primare şi 1 extinsă. Partiţia extinsă poate conţine până la 11 partiţii logice. 

Partiţiile primare sau extinse au numele de la sda1 la sda4. Partiţiile logice sunt întotdeauna continui şi fac parte dintr-o partiţie extinsă. Puteţi defini (cu  *libata* ) maximum 11 asemenea partiţii iar desemnarea lor începe cu numărul 5 (ex. sda5) şi se termină cu 15 (sda15)

##### Câteva exemple 

`/dev/sda5`  poate fi doar o partiţie logică (în acest caz, prima de pe discul său), probabil localizată pe primul disc SATA sau pe primul disc IDE din computer (depinde de cum este setat în BIOS).

`/dev/sdb3`  poate fi doar o partiţie primară sau una extinsă; litera de disc fiind diferită de cea din primul exemplu putem spune doar că această partiţie nu se află nici într-un caz pe acelaşi disc.

#### Fostele, dar acum nu mai sunt valabile, denumiri de dispozitive IDE

Pe sistemele linux mai vechi, dispozitivele de disc IDE (PATA) erau diferenţiate de cele folosite la ora actuală prin `hdaX`  în loc de `sdaX.` 

<div class="divider" id="partition"></div>
## Partiţionarea Hard Disk-ului folosind  *cfdisk* 

**`Pentru uzul zilnic recomandăm tipul de fişiere ext4, este tipul implicit în siduction şi este foarte bine întreţinut.`**

Deschideţi o consolă, deveniţi  *root*  şi porniţi  *cfdisk* :  
 *(dacă sunteţi pe un sistem instalat pe Hard Disc va trebui să introduceţi parola de root)* 

~~~  
su  
cfdisk /dev/sda  
~~~

##### Interfaţa de utilizare

În primul ecran  *cfdisk*  va lista tabela de partiţii curentă cu numele şi câteva date despre fiecare partiţie. La baza ecranului sunt câteva butoane de comenzi active. Pentru a trece de la o partiţie la alta folosiţi  **săgeţile sus/jos de la tastatură** . Pentru a muta între comenzi folosiţi  **săgeţile stânga/dreapta de la tastatură.** 

##### Ştergerea unei partiţii 

![Delete a partition](../images-ro/cfdisk-ro/cfdisk0-ro.png "Delete a partition") 

Pentru a şterge o partiţie alegeţi-o cu săgeţile sus/jos apoi selectaţi comanda 

~~~  
Delete  
~~~

cu săgeţile stânga/dreapta şi apăsaţi

~~~  
Enter  
~~~

##### Crearea unei noi partiţii

![Create a new partition](../images-ro/cfdisk-ro/cfdisk1-ro.png "Create a new partition") 

Pentru crearea unei noi partiţii folosiţi comanda:

~~~  
New  
~~~

(selectaţi-o cu săgetile stânga/dreapta), apoi apăsaţi  *Enter* . Va trebui să decideţi între a fi o partiţie  **primary**  sau  **logical** . Dacă doriţi o partiţie logică programul automat va crea o partiţie extinsă pentru dumneavoastră. Apoi va trebui să alegeţi mărimea partiţiei (în MB). Dacă nu puteţi introduce o valoare în MB, reîntoarceţi-vă în meniul principal cu tasta  *Esc*  şi selectaţi MB cu comanda:

~~~  
Units  
~~~

##### Tipul Partiţiei

![Type of a partition 1](../images-ro/cfdisk-ro/cfdisk2-ro.png "Type of a partition 1") 

Pentru a seta tipul partiţiei  **Linux swap**  sau  **Linux** , inseraţi poziţia actuală şi folosiţi comanda:

~~~  
Type  
~~~

Veţi vedea o listă cu diferite tipuri de partiţii. Apăsaţi tasta  *space*  şi vedeţi mai multe. Găsiţi tipul de care aveţi nevoie şi introduceţi numărul corespunzător. ( **Linux swap**  este tip  **82** ,  **Linux filesystems**  trebuie să fie tip  **83** )

![Type of a partition 2](../images-ro/cfdisk-ro/cfdisk3-ro.png "Type of a partition 2") 

##### Setarea unei partiţii ca partiţie de boot

Nu este nevoie, în Linux, să faceţi o partiţie ca partiţie de boot, dar pentru alte sisteme de operare este necesar. Alegeți partiţia şi selectaţi comanda:  *Notă: Când instalaţi pe un HD extern atunci o partiţie trebuie să fie boot-abilă* 

~~~  
Bootable  
~~~

##### Scrierea rezultatului pe disc

Când aţi terminat puteţi scrie schimbările făcute pe disc cu comanda  *Write* . Tabela de partiţii va fi scrisă pe disc, (dacă primiţi o eroare legată de  *dos* , ignoraţi-o) Cum aceasta va distruge toate datele de pe partiţiile şterse sau schimbate trebuie să fiţi foarte siguri asupra ceea ce doriţi să faceţi înainte de a apăsa tasta:

~~~  
Enter  
~~~

![Write the result to disk](../images-ro/cfdisk-ro/cfdisk4-ro.png "Write the result to disk") 

##### Ieşirea

Pentru a ieşi din program selectaţi comanda  *Quit* . După ieşirea din  *cfdisk*  şi înainte de pornirea formatării sau instalării trebuie să restartaţi computerul în siduction pentru ca acesta să recitească noua tabelă de partiţii.


---

<div class="divider" id="formating"></div>
## Formatarea partiţiilor (după partiţionarea cu cfdisk)

##### Informații de Bază

Orice partiţie trebuie să aibă un sistem de fişiere. Linux ştie să folosească diferite sisteme de fişiere. Există ReiserFs, Ext4 iar pentru utilizatorii experimentaţi XFS și JFS. Ext2 este foarte comod de folosit ca format de stocare atâta vreme cât există şi un sistem windows pentru schimbul de date. [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/) .

**`Pentru utilizarea curentă recomandăm folosirea tipului ext4. Este tipul implicit din siduction şi foarte bine întreţinut.`**

##### Formatarea

După închiderea programului  **cfdisk**  ne întoarcem în consolă. Pentru formatare trebuie să fiţi  *root* . Pentru formatarea partiţiei  *root*  - şi/sau  *home* , în acest exemplu  **hdb1** , introducem:  *(dacă rulaţi un sistem instalat pe Hard Disk va trebui să introduceti parola de  *root* )* 

~~~  
su  
mkfs -t ext4 /dev/hdb1  
~~~

Aici va exista o întrebare la care veţi răspunde  *yes*  dacă sunteţi siguri că aţi ales partiţia corectă.

După ce comanda este executată veţi primi mesajul  *"ext4 formatting was successfully written to disk"* . Dacă nu primiţi acest mesaj ceva nu a mers cum trebuie cu partiţionarea în  *cfdisk* , sau  *hdb1*  nu este o partiţie linux. În acest caz puteţi verifica cu:

~~~  
fdisk -l /dev/hdb  
~~~

dacă ceva este greşit verificaţi partiţia încă o dată.

Dacă formatarea s-a terminat cu succes urmaţi aceaşi paşi pentru o partiţie  */home* , dacă vreţi o partiţie separată.

Ultima va fi formatată partiţia  *swap* , în acest exemplu  *hdb3* :

~~~  
mkswap /dev/hdb3  
~~~

după aceasta:

~~~  
swapon /dev/hdb3  
~~~

Apoi vom verifica dacă partiţia  *swap*  este recunoscută introducând în consolă:

~~~  
swapon -s  
~~~

noua partiţie  *swap*  montată ar trebui să fie recunoscută acum, în cazul nostru, ca:

<table class="center">
| Filename | Type | Size | Used | Priority | 
| ---- | ---- | ---- | ---- | ---- |
| /dev/hdb3 | partition | 995988 | 248632 | -1 | 


---

Dacă partiţia  *swap*  este recunoscută corect introducem: 

~~~  
swapoff -a  
~~~

şi restartăm computerul.

Acum sunteţi gata de instalare.

<div id="rev">Content last revised 30/11/2012 0100 UTC</div>
