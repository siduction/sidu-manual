<div id="main-page"></div>
<div class="divider" id="gdisk-1"></div>
## Introducere în partiționarea cu GPT  *gdisk* 

GPT  *gdisk* , Globally Unique Identifier (GUID) Partition Table (GPT), este o unealtă de partiționare a discurilor de orice dimensiune `și este necesar mai ales pentru discurile mai mari de 2 TB` . În primul rând,  *gdisk*  se va asigura că partițiile sunt bine aliniate pentru SSDs, (sau harddisk-urile care nu au deja sectoare de 512 byte).

Avantajul principal al GPT este că elimină nevoia de a avea partiții primare, extinse sau logice obligatorii ca la partiționarea pentru MBR. GPT poate suporta un număr aproape nelimitat de partiții fiind limitat doar de spațiul rezervat pentru intrările partițiilor în disk-ul GPT. De reținut totuși că setarea de bază a programului `*gdisk*`  este 128 de partiții.

Oricum, folosirea GPT pe stick-uri USB/SSD mici, (de exemplu pe un stick de 8GB), poate fi neproductiv când veți avea nevoie să transferați date de pe un computer pe altul sau de pe un sistem de operare pe altul.

<!--**`NOTE : USB booting is not supported with GPT.`** 

-->
### Important de reținut

`Termenii UEFI și EFI sunt echivalenți și înseamnă același lucru.` 

##### Disk-urile GPT

`Unele sisteme de operare nu suportă disk-urile GPT; vă rugăm citiți documentația sistemului de operare respectiv.` 

Disk-urile GPT sunt aplicabile pentru computerele de 32 și 64 bit sub Linux.

##### Boot-area disk-urilor GPT

Boot-area duală și triplă a disk-urilor GPT cu Linux, BSD și Apple este pasibilă folosind modul `EFI`  în 64 bit.

Boot-area duală a disk-urilor GPT cu Linux și MS Windows este posibilă cu condiția ca MS Windows OS să poată boota disk-urile GPT în modul `UEFI`  în 64 bit,.

##### Unelte grafice (GUI) de partiționare care folosesc GPT

Ca și alte programe bazate pe terminal cum sunt  *gparted*  sau  *partitionmanager* ,  *gdisk*  oferă o interfață grafică care suportă disk-urile GPT. Începând de-acum,  *gdisk*  poate deveni unealta voastră preferată care să vă ajute în prevenirea sau evitarea unor anomalii neintenționate ce pot apare sub programele cu GUI. Oricum,  *Gparted*  -  *gparted*  împreună cu  *KDE Partition Manager*  -  *partitionmanager* , (ca și altele), sunt unelte bune pentru a vedea grafic acțiunile voastre efectuate cu  *gdisk* .

`Obligatoriu de citit înainte de a merge mai departe:`

+ ~~~    
   man gdisk    
   ~~~
  
+  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/)   
+  [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table)   

<div class="divider" id="gdisk-2"></div>
## Partiționarea HDD cu  *gdisk*  pentru un sistem Linux

###### Înțelegerea tastelor de comandă ale  *gdisk*  cum ar fi **`m`**  pentru a reveni la meniul principal, **`d`**  ,**`n`** , **`p`**  și **`t`** , ca și altele, sunt în principal comenzile de bază ce vă pot satisface majoritatea nevoilor în partiționarea cu  *gdisk*  și merită efortul de a explora  *gdisk*  pe un disk de test.

<h5><span class="highlight-2"> NOTIFICARE IMPORTANTĂ despre comanda  *n*  :</h5></span>
<!--###### After creating the first partition you need to press `< Enter > 2 times`  each time you use **`n`**  to bring up the last sector to set the size of the subsequent partitions.-->

Când folosiți comanda **`n`** , apăsați &lt;Enter&gt; pentru a da partiției următorul număr liber apoi trebuie să apăsați din nou &lt;Enter&gt; pentru a accepta sectorul de start al următoarei partiții înaite de a stabili mărimea necesară a ultimului sector. De exemplu:

~~~  
Command (? for help): n  
Partition number (2-128, default 2): 2  
First sector (34-15728606, default = 411648 ) or {+-}size{KMGTP}:  
Last sector (411648 -15728606, default = 15728606) or {+-}size{KMGTP}: +6144M  
~~~

### Exemplu de partitionare a unui disk GPT

 *Organizare ce ar putea îndeplini nevoile voastre* :

1. Crearea unei partiții de boot, `(presupunem că disk-ul nu este destinat doar pentru stocarea datelor și trebuie să fie boot-abil)`   
2. Crearea unei partiții de swap, `(presupunem că disk-ul nu este destinat doar pentru stocarea datelor și trebuie să fie boot-abil)`   
3. Crearea partițiilor linux   
4. Crearea altor partiții pentru stocarea datelor   

**`NOTĂ: Următorul exemplu folosește un stick USB pentru a demonstra pașii necesari și nu este foarte minuțios.`** 

### Pașii de urmat

Dacă nu sunteți sigur de numele disk-ului folosiți comanda  *fdisk*  pentru al afla, (drepturi de  *root*  sunt necesare pentru toate comenzile de partiționare și formatare):

~~~  
fdisk -l  
~~~

 *fdisk*  vă va da calea cerută și posibil să includă si alte nume de partiții aflate pe disk. Oricum va trebui să vă uitați după calea către disk-ul actual ignorând partițiile ce ar putea exista pe el. De exemplu, presupunând că acesta este `sdb`  pornim  *gdisk*  cu calea către acesta:

~~~  
gdisk /dev/sdb  
~~~

`Rezultatul inițial va fi o avertizare dacă disk-ul nu este nou sau este unul care folosește deja GPT:` 

~~~  
GPT fdisk (gdisk) version 0.7.2  
Partition table scan:  
MBR: MBR only  
BSD: not present  
APM: not present  
GPT: not present  
***************************************************************  
Found invalid GPT and valid MBR; converting MBR to GPT format.  
THIS OPERATION IS POTENTIALLY DESTRUCTIVE! Exit by typing 'q' if  
you don't want to convert your MBR partitions to GPT format!  
***************************************************************  
Command (? for help):  
~~~

Când pornim `*gdisk*`  pentru un disk pe care există partiții MBR și nu GPT, programul va afișa un mesaj înconjurat de asteriscuri despre convertirea partițiilor existente la formatul GPT. `Acesta are rolul de a vă speria dacă ați lansat accidental  *gdisk*  pe un disk greșit sau nu știți ce faceți. Trebuie să răspundeți explicit acestui avertisment înainte de a continua. Este un mesaj intenționat pentru a vă feri de probabilitatea stricării accidentale a disk-urlor voastre de boot.` 

Tipăriți **`?`**  și veți vedea o lista a comenzilor disponibile, (comenzile `colorate`  au scop de documentare):

~~~  
Command (? for help): **`?`**   
b back up GPT data to a file  
c change a partition's name  
d delete a partition  
i show detailed information on a partition  
l list known partition types  
n add a new partition  
o create a new empty GUID partition table (GPT)  
p print the partition table  
q quit without saving changes  
r recovery and transformation options (experts only)  
s sort partitions  
t change a partition's type code  
v verify disk  
w write table to disk and exit  
x extra functionality (experts only)  
? print this menu  
~~~

Pentru a verifica că lucrați pe disk-ul pe care credeți că vreți, tipăriți **`p`** .

~~~  
Command (? for help): p   
Disk /dev/sdb: 16547840 sectors, 7.9 GiB Acest exemplu folosește un stick de 8GB   
Logical sector size: 512 bytes  
Disk identifier (GUID): 0267952D-9B06-4B10-A648-B83684786910  
Partition table holds up to 128 entries  
First usable sector is 34, last usable sector is 16547806  
Partitions will be aligned on 2048-sector boundaries  
Total free space is 16547773 sectors (7.9 GiB)  
Number Start (sector) End (sector) Size Code Name  
~~~

Coloana `Code`  a rezultatelor vă arată codul tipului de partiție și coloana `Name`  vă arată un text cu numele ei pe care îl puteți modifica.

### Ștergerea tabelei de partiții

Trebuie să ștergeți toată tabela de partiții de pe disk pentru a putea seta patiționarea GPT:

~~~  
command (? for help): d   
~~~

<!--If there are multiple partitions  *gdisk*  will ask you to type a number representing the partitions you wish to delete.

-->
<div class="divider" id="gdisk-3"></div>
## Pentru boot-area GPT-EFI sau GPT-BIOS

Pentru ca disk-ul GPT să fie boot-abil, sunt 2 opțiuni de formatare a sectorului de boot a disk-ului GPT.

Ele sunt:

+ `Computerul vostru are un BIOS care cunoaște (U)EFI, este activată opțiunea și este selectată pentru boot-are.`   
+ Doriți să folosiți boot-area EFI de pe un disk formatat GPT  

**`sau`** 

+ Computerul vostru are un BIOS care **`nu cunoaște`**  (U)EFI  
+ Doriți să folosiți BIOS-ul pentru a boota de pe un disk formatat GPT  

### Boot-area EFI 

**`BIOS-ul trebuie să fie capabil EFI, să fie pornită opțiunea și selectată pentru boot-are.`**  

Dacă vreți să utilizați EFI pentru boot-are trebuie obligatoriu ca prima partiție să fie formatată FAT în sistemulde partiționare EFI (tipăriți `EF00` ). Această partiție va conține programul(ele) de boot-are. La instalare, veți ignora orice altă alegere de genul  *"where to boot from"*  din programul grafic de instalare iar un program de boot siduction va fi instalat în sistemul de partiții EFI sub `/efi/siduction` . Sistemul de partiții EFI va fi de asemenea mount-at ca `/boot/efi`  dacă ați lăsat selectată opțiunea  *"mount other partitions"* , ne fiind nevoie să-i mai spuneți programului de instalare s-o mount-eze.

<!--**`NOTE: USB booting is not supported with GPT.`** 

-->
#### Crearea partiției de boot EFI

Tastați **`n`**  pentru a adăuga o nouă partiție și `+200M`  pentru a-i aloca un spațiu.

~~~  
Command (? for help): n   
Partition number (1-128, default 1): 1   
~~~

~~~  
First sector (34-16547806, default = 34) or {+-}size{KMGTP}:  
Information: Moved requested sector from 34 to 2048 in  
order to align on 2048-sector boundaries.  
Use 'l' on the experts' menu to adjust alignment  
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M   
Current type is 'Linux filesystem'  
~~~

Tastând **`L`**  vi se va prezenta o listă cu coduri:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): L   
0700 Microsoft basic data 0c01 Microsoft reserved 2700 Windows RE  
4200 Windows LDM data 4201 Windows LDM metadata 7501 IBM GPFS  
7f00 ChromeOS kernel 7f01 ChromeOS root 7f02 ChromeOS reserved  
8200 Linux swap 8300 Linux filesystem 8301 Linux reserved  
8e00 Linux LVM a500 FreeBSD disklabel a501 FreeBSD boot  
a502 FreeBSD swap a503 FreeBSD UFS a504 FreeBSD ZFS  
a505 FreeBSD Vinum/RAID a800 Apple UFS a901 NetBSD swap  
a902 NetBSD FFS a903 NetBSD LFS a904 NetBSD concatenated  
a905 NetBSD encrypted a906 NetBSD RAID ab00 Apple boot  
af00 Apple HFS/HFS+ af01 Apple RAID af02 Apple RAID offline  
af03 Apple label af04 AppleTV recovery be00 Solaris boot  
bf00 Solaris root bf01 Solaris /usr & Mac Z bf02 Solaris swap  
bf03 Solaris backup bf04 Solaris /var bf05 Solaris /home  
bf06 Solaris alternate se bf07 Solaris Reserved 1 bf08 Solaris Reserved 2  
bf09 Solaris Reserved 3 bf0a Solaris Reserved 4 bf0b Solaris Reserved 5  
c001 HP-UX data c002 HP-UX service ef00 EFI System   
ef01 MBR partition scheme ef02 BIOS boot partition fd00 Linux RAID  
~~~

Introduceți `ef00`  pentru a crea o partiție UEFI:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): ef00   
Changed system type of partition to 'EFI System'  
~~~

### Partiția de boot BIOS

#### Crearea unei partiții de boot BOIS

Dacă computerul vostru nu suportă UEFI, puteți crea o partiție de boot BIOS ca înlocuitor al sectorului partiționat DOS aflat între tabela de partiții și prima partiție unde este scri direct  *grub* .

Tastați **`n`**  pentru a adăuga o nouă partiție și `+200M`  ca dimensiune a partiției de boot. (Motivul de a o face de +200M, comparativ cu convenționalul +32M, este de a avea loc pentru o eventuală viitoare înlocuire cu o partiție de boot EFI).

~~~  
Command (? for help): n   
Partition number (1-128, default 1): 1   
~~~

~~~  
First sector (34-16547806, default = 34) or {+-}size{KMGTP}:  
Information: Moved requested sector from 34 to 2048 in  
order to align on 2048-sector boundaries.  
Use 'l' on the experts' menu to adjust alignment  
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M   
Current type is 'Linux filesystem'  
~~~

Introduceți `ef02`  pentru a crea o partiție de boot BIOS:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): ef02   
Changed system type of partition to 'BIOS boot'  
~~~

**`NOTĂ Importantă: Partiția de boot BIOS nu va fi formatată`** 

<div class="divider" id="gdisk-4"></div>
### Crearea partiției swap

Dimensiunea unei partiții swap n-ar trebui subestimată niciodată, mai ales pentru laptop-uri și notebook-uri care au de regulă nevoia de  *suspend to disk* . Partiția trebuie să fie cel puțin egală cu capacitatea RAM-ului.

Tastați **`n`**  pentru a adăuga o nouă partiție și `+2G` , (sau, `+2048M` ) ca dimensiune a partiției swap iar codul este `8200` . Un exemplu ar arăta cam așa:

~~~  
Command (? for help): n   
Partition number (2-128, default 2): 2   
First sector (34-15728606, default = 411648) or {+-}size{KMGTP}:  
Last sector (411648-15728606, default = 15728606) or {+-}size{KMGTP}: **`+2048M   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 8200   
Changed type of partition to 'Linux swap  
~~~

<div class="divider" id="gdisk-5"></div>
### Crearea partițiilor pentru date

Tastați **`n`**  pentru a adăuga o nouă partiție și `XXXG`  ca dimensiune. În acest exemplu `+4G` :

~~~  
Partition number (3-128, default 3): 3   
First sector (34-15728606, default = 4605952) or {+-}size{KMGTP}:  
Last sector (4605952-15728606, default = 15728606) or {+-}size{KMGTP}: **`+4G   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 8300   
Changed type of partition to 'Linux filesystem  
~~~

`Repetați procedurile pentru alte partiții funție de nevoile voastre.` 

Deoarece în acest exeplu am folosit un stick, am putea face o partiție pentru orice sistem de operare `Any OS Data` , tastând codul `0700` , altfel dații cod pentru un sistem Linux (`8300` ):

~~~  
Command (? for help): n   
Partition number (4-128, default 4): 4   
First sector (34-15728606, default = 12994560) or {+-}size{KMGTP}:  
Last sector (12994560-15728606, default = 15728606) or {+-}size{KMGTP}:**`+1300M   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 0700   
Changed type of partition to 'Microsoft basic data'  
~~~

Pentru a examina partițiile create:

~~~  
Command (? for help): p   
Disk /dev/sdx: 15728640 sectors, 7.5 GiB  
Logical sector size: 512 bytes  
Disk identifier (GUID): F409CFD3-6DDC-4551-BBC5-85DC218C1352  
Partition table holds up to 128 entries  
First usable sector is 34, last usable sector is 15728606  
Partitions will be aligned on 2048-sector boundaries  
Total free space is 73661 sectors (36.0 MiB)  
Number Start (sector) End (sector) Size Code Name  
1 2048 411647 200.0 MiB EF00 Boot  
2 411648 4605951 2.0 GiB 8200 Swap  
3 4605952 12994559 4.0 GiB 8300 Linux File System  
4 12994560 15656959 1.3 GiB 0700 Any OS Data  
~~~

Pentru a adăuga o descriere a scopului fiecărei partiții folosiți comanda **`c`** . De exemplu:

~~~  
Command (? for help): c   
Partition number (1-4): 4   
Enter name: Nume la alegerea voastră`   
~~~

Comanda **`w`**  va scrie schimbările făcute în timp ce comanda **`q`**  va ieși fără a salva modificările:

~~~  
Command (? for help): w   
Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING  
PARTITIONS!!  
Do you want to proceed? (Y/N): y   
OK; writing new GUID partition table (GPT).  
The operation has completed successfully.  
~~~

<div class="divider" id="gdisk-6"></div>
## Formatarea partițiilor

Deoarece  *gdisk*  crează partiții nu sisteme de fișiere, va trebui să formatați fiecare partiție cu ajutorul terminalului. Pentru că trebuie să știți numele partițiilor pentru a le formata corect pe fiecare, rulați comanda:

~~~  
fdisk -l  
~~~

 *fdisk*  vă va arăta calea cerută. Presupunând că aceasta este `sdb`  :

~~~  
gdisk /dev/sdb  
Command (? for help): p   
~~~

Acum tastați **`q`**  pentru a părăsi  *gdisk*  și a avea din nou promptul **`#`**  al  *root* -ului, putând astfel tasta calea și numărul fiecărei partiții:

Pentru partiția UEFI, **`(Nu formatați partiția de boot BIOS)`** :

~~~  
mkfs -t vfat /dev/sdb1  
~~~

Pentru partiția Linux, `(Sintaxa pentru oricare alte partiții Linux se va schimba desigur funție de fiecare sistem de fișiere Linux aflat pe sdb4, sdb5, și în continuare` :

~~~  
mkfs -t ext4 /dev/sdb3  
~~~

Pentru partiția  *'Any OS Partition'* , `(probabil necesară dacă este folosit un stick USB pentru interoperabilitate între diverse sisteme de operare)` :

~~~  
mkfs -t vfat /dev/sdb4  
~~~

Formatarea partiției swap:

~~~  
mkswap /dev/sdb2  
~~~

Apoi:

~~~  
swapon /dev/sdb2  
~~~

Apoi verificați dacă swap este recunoscută tastând în consolă:

~~~  
swapon -s  
~~~

Dacă swap este recunoscută corect, introduceți:

~~~  
swapoff -a  
~~~

Aceste comenzi funcționeză dacă sunt pe partiții MBR.

##### **`Este absolut imperativ să reboot-ați pentru ca noua partiționare și formatul lor să fie citite de kernel.`** 

După reboot-are sunteți pregătit să porniți instalarea pe sau să utilizați disk-ul GPT.

<div class="divider" id="gdisk-7"></div>
## Comenzi  *gdisk*  pentru avansați

Înainte de a salva modificările, poate veți dori să verificați dacă nu sunt probleme grosolane în structura de date GPT. Puteți face asta cu comanda **`v`** :

~~~  
Command (? for help): v   
No problems found. 0 free sectors (0 bytes) available in 0  
segments, the largest of which is 0 sectors (0 bytes) in size  
~~~

În acest caz, tot spațiul disponibil pe disk este alocat partițiilor și nu au fost găsite probleme. Dacă rămâne spațiu liber pentru a crea partiții veți vedea cât de mult este disponibil. Dacă  *gdisk*  găsește probleme, cum ar fi suprapuneri de partiții sau nepotriviri între tabela de partiții curentă și cea de siguranță (backup), vă vor fi raportate aici. Desigur,  *gdisk*  are măsuri de siguranță ce nu văvor lăsa să comiteți asemenea probleme. Opțiunea de verificare **`v`**  are rolul de ajutor în a vedea problemele ce ar putea să apară ca rezultat al datelor corupte.

Dacă sunt descoperite probleme, puteți să le corectați folosind diverse opțiuni din meniul secundar `recovery and transformation options (experts only)` , tastând **`r`**  :

~~~  
Command (? for help): r   
recovery/transformation command (? for help): **`?`**   
b use backup GPT header (rebuilding main)  
c load backup partition table from disk (rebuilding main)  
d use main GPT header (rebuilding backup)  
e load main partition table from disk (rebuilding backup)  
f load MBR and build fresh GPT from it  
g convert GPT into MBR and exit  
h make hybrid MBR  
i show detailed information on a partition  
l load partition data from a backup file  
m return to main menu  
o print protective MBR data  
p print the partition table  
q quit without saving changes  
t transform BSD disklabel partition  
v verify disk  
w write table to disk and exit  
x extra functionality (experts only)  
? print this menu  
~~~

Un meniu terțiar, `extra functionality (experts only)` , poate fi accesat tastând **`x`**  atât din meniul principal `main menu`  cât și din meniul `recovery and transformation options (experts only)` .

~~~  
recovery/transformation command (? for help): x   
Expert command (? for help): **`?`**   
a set attributes  
c change partition GUID  
d display the sector alignment value  
e relocate backup data structures to the end of the disk  
g change disk GUID  
i show detailed information on a partition  
l set the sector alignment value  
m return to main menu  
n create a new protective MBR  
o print protective MBR data  
p print the partition table  
q quit without saving changes  
r recovery and transformation options (experts only)  
s resize partition table  
v verify disk  
w write table to disk and exit  
z zap (destroy) GPT data structures and exit  
? print this menu  
~~~

De aici puteți face unele editări cum ar fi schimbarea GUID-urilor partițiilor sau disk-urilor (**`c`**  și respectiv **`g`** ). Opțiunea **`z`**  distruge imediat structura de date GPT și poate fi utilizată dacă doriți reutilizarea disk-ului GPT cu o altă schemă de partiții. Dacă structura curentă nu este ștearsă unele programe de partiționare pot deveni confuze prin descoperirea aparentă a două sisteme de partiționare.

În general, ambele opțiuni `recovery & transformation`  și `experts`  n-ar trebui folosite de altcineva în afară de experții GPT. Non-experții ar putea fi nevoiți să le folosească dacă disk-ul li se strică. Înainte de a proceda la acțiuni drastice ar fi bine să apelați opțiunea **`b`**  din meniul principal pentru a crea o copie de rezervă (backup file) pe care s-o salvați undeva pe un stick USB sau în altă parte în afara disk-ului pe care tocmai vreți să-l modificați. Astfel veți putea recupera configurația originală dacă vă stricați partițiile.

###### Surse bibliografice: 

  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/) 

  [Windows Hardware Developer Center](http://msdn.microsoft.com/en-us/windows/hardware/gg463525) 

<!--<div class="divider" id="<gdisk-8"></div>
## Dual booting with Linux and another OS - TBA

+ ~~~    
   man gdisk    
   ~~~
  
+  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/ *gdisk* /)   
+  [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table)   

</div>-->
<div id="rev">Content last revised 15/08/2011 1155 UTC</div>
