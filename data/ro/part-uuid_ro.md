<div id="main-page"></div>
<div class="divider" id="uuid"></div>
## Re-crearea  *fstab*  și crearea punctelor de mount-are

`La instalare, siduction folosește notarea UUID în fișierul  *fstab* .`

Pentru că o partiţie nou creată (să spunem sda6 sau sdb7), nu apare în  *fstab*  şi doriţi să o mount-aţi, tipăriţi într-o consolă, ca user ($), următoarea comandă:

~~~  
ls -l /dev/disk/by-uuid  
~~~

Rezultatul va fi cam aşa (şirul în bold este doar un exemplu):

~~~  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 348ea9e6-7879-4332-8d7a-915507574a80 -> ../../sda4  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 610aaaeb-a65e-4269-9714-b26a1388a106 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 857c5e63-c9be-4080-b4c2-72d606435051 -> ../../sda5  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 a83b8ede-a9df-4df6-bfc7-02b8b7a5f1f2 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42  ad662d33-6934-459c-a128-bdf0393e0f44  -> ../../sda6  
~~~

În acest exemplu :  **ad662d33-6934-459c-a128-bdf0393e0f44**  este intrarea lipsă. Următorul pas este să introducem UUID-ul partiţiei în /etc/fstab. Pentru a adăuga aceasta în fişierul  *fstab*  folosiţi un editor de text (vi, kate sau kwrite) cu privilegii root:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=ad662d33-6934-459c-a128-bdf0393e0f44  /media/disk1part6 ext4 auto,users,exec 0 2    
~~~
  
Un alt exemplu :

~~~  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 30ebb8eb-8f22-460c-b8dd-59140274829d -> ../../sdb8  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 387d6d4b-4508-4b8e-8ed2-76998f41dae4 -> ../../sdb1  
rwxrwxrwx 1 root root 10 2007-05-28 13:18 7014f66f-6cdf-4fe1-83da-9cab7b6fab1a -> ../../sdb5  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 8f042ead-259f-4df0-98ec-3343080396c5 -> ../../sdb6  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 94B0AE63B0AE4B94 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 A61820AA18207B85 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f28725d6-b7b5-4207-8476-36efe1a903ce -> ../../sdb9  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f855c263-2521-48d3-8ec9-d2d2b69b6635 -> ../../sda3  
rwxrwxrwx 1 root root 10 2007-05-28 13:18  f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  -> ../../sdb7  
~~~

În acest caz  **f9aa4027-ecdd-4a86-84e2-df2ef73fe14e**  este intrarea lipsă şi este adăugată în /etc/fstab:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  /media/disk2part7 ext4 auto,users,exec 0 2    
~~~
  
### Crearea unor noi puncte de mount-are
  
 `NOTĂ:`  Numele unui punct de mount-are, așa cum este notat în  *fstab* , trebuie să corespundă cu numele unui director deja existent. siduction crează aceste directoare pe timpul procesului de instalare sub directorul `/media`  și sunt numite `diskXpartX` .

Dacă ați modificat tabela de partiții după instalarea inițială și ați modificat deja  *fstab* , (de exemplu, au fost create 2 partiții noi), directoarele pentru fiecare punct de mount-are nu vor exista și trebuie create manual.

##### Exemplu:

Mai întâi, ca root, verificați existența punctelor de mount-are:

~~~  
cd /media  
ls  
~~~

Ar trebui să vă listeze punctele de mount-are existente, de exemplu:

~~~  
disk1part1 disk1part3 disk2part1  
~~~

Rămânând în /media, creați punctele de mount-are a noilor partiții:

~~~  
mkdir disk1part6  
mkdir disk2part7  
~~~

Pentru testare sau pentru a utiliza partițiile imediat:

~~~  
mount /dev/sda6 /media/disk1part6  
mount /dev/sda6 /media/disk2part7  
~~~

După reboot-area computerului sistemul de fișiere va fi mount-at automat. Citiți:

~~~  
man mount  
~~~

<div class="divider" id="uuid-fstab"></div>
## Introducere: UUID, Etichetarea Partiţiilor şi  *fstab* 

Numirea permanentă a dispozitivelor block a devenit posibilă prin introducerea udev şi are câteva avantaje faţă de numirea bus-based.

Pe măsură ce distribuţiile Linux şi udev au evoluat şi detecţia de hardware a devenit mai bună, dar au apărut noi probleme şi schimbări:  
 **1)** Dacă există mai mult de un controler de disc sata/scsi sau ide ordinea în care sunt adăugate e aleatorie. Aceasta face ca numele dispozitivelor, ex. hdX şi hdY să se schimbe între ele la fiecare boot-are. La fel se întâmplă şi cu sdX şi sdY. Numirea Permanentă face ca acest lucru să nu se mai întâmple.  
 **2)**  Odată cu introducerea noului libata pata suport, toate dispozitivele ide hdX vor deveni sdX la un moment dat în viitor. Încă odată, cu numirea permanentă acest lucru nici nu va fi observat.  
 **3)** Computerele care au atât discuri ide cât şi sata sunt obişnuite în ziua de azi. Cu schimbările libata menţionate mai sus, prima problemă va deveni chiar mai întâlnită căci atât discurile sata cât şi ide vor fi numite ambele sdX.

`Implicit siduction va folosi uuid în fstab la instalare.`

Mai există şi alte motive dar acestea sunt dintre cele mai importante la ora actuală şi în viitorul apropiat. De aceea siduction va încurajează să schimbaţi setarea implicită cu o schemă de numire permanentă a discurilor.

## Cele patru scheme diferite pentru numirea permanentă:

#### 1. Numirea Permanentă după UUID

UUID înseamnă Universally Unique Identifier şi este un mecanism prin care se atribuie fiecărui sistem de fişiere un identificator unic. Este proiectat în aşa fel încât coliziunile sunt puţin probabile. Toate sistemele de fişiere din Linux (inclusiv swap) suportă UUID. Partiţiile FAT şi NTFS nu suportă UUID dar vor fi şi ele listate cu un identificator unic:

~~~  
$ /bin/ls -lF /dev/disk/by-uuid/  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 2d781b26-0285-421a-b9d0-d4a0d3b55680 -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 31f8eb0d-612b-4805-835e-0e6d8b8c5591 -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 3FC2-3DDB -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 5090093f-e023-4a93-b2b6-8a9568dd23dc -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 912c7844-5430-4eea-b55c-e23f8959a8ee -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 B0DC1977DC193954 -> ../../sdb1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 bae98338-ec29-4beb-aacf-107e44599b2e -> ../../sdb2  
~~~

Așa cum puteți vedea, partițiile fat și ntfs au nume scurte (sda6 și sdb1) dar sunt listate după uuid.

#### 2. Numirea Permanentă după ETICHETĂ (LABEL)

Aproape orice tip de fişiere poate avea o etichetă (label). Toate partiţiile care posedă aceasta sunt listate în directorul /dev/disk/by-label:

~~~  
$ ls -lF /dev/disk/by-label  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data2 -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 fat -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1  
~~~

Deoarece etichetele pot fi nume ușor de citit, trebuie să aveți mare grijă să evitați conflictul de nume.

 Poţi schimba etichetele partiţiilor folosind aceste comenzi:

~~~  
* swap: Crează o noua partiţie swap în felul acesta : mkswap -L <label> /dev/XXX  
* ext2/ext3/ext4: e2label /dev/XXX <label>  
* jfs: jfs_tune -L <label> /dev/XXX  
* xfs: xfs_admin -L <label> /dev/XXX  
* fat/vfat: Nu este nici o unealtă de schinbare a etichetei folosind Linux,  
dar, când creați sistemul de fisiere, folosiți mkdosfs -n <label> <alte opțiuni>.  
Puteți de asemenea să schibați etichetele unui sistem de fișiere existent folosind Windows.  
* ntfs: ntfslabel /dev/XXX <label> sau schimbați-o folosind Windows.  
~~~

`Aveţi grijă: Etichetele trebuie să fie unice pentru ca aceasta să "meargă", este valabil în mod egal atât dispozitivelor USB/firewire cât şi hard discurilor. Sintaxa LABEL=/ UUID= este de preferat celei /dev/disk/by-*/ pentru partiţiile UN*X `

#### 3. Numirea Permanentă după id 

by-id crează un nume unic în functie de numărul serial al dispozitivului.

#### 4. Numirea Permanentă după path (cale)

by-path crează un nume unic în funcţie de calea fizică cea mai scurtă (specificată în sysfs). Ambele conţin şiruri care indică cărui subsistem aparţin şi de aceea nu sunt potrivite pentru rezolvarea problemelor menţionate la începutul acestui articol. Nu vor mai fi discutate de aici înainte.

#### Activarea Numirii Permanente

După ce am ales ce metodă de numire vom folosi, vom activa numirea permanentă în sistem:

#### În fstab

Activarea numirii permanente în /etc/fstab se face uşor, doar înlocuiţi numele dispozitivului din prima coloană cu noul nume permanent. În exemplul nostru vom înlocui /dev/sda7 cu unul din următoarele:

~~~  
/dev/disk/by-label/home or  
/dev/disk/by-uuid/31f8eb0d-612b-4805-835e-0e6d8b8c5591  
~~~

Faceţi la fel pentru toate partiţiile din fişierul fstab.

În loc să daţi dispozitivul explicit puteţi indica partiţia ce va fi montată după UUID sau eticheta de volum, scriind LABEL=&lt;label&gt; sau UUID=&lt;uuid&gt;, de exemplu:

~~~  
LABEL=Boot  
~~~

sau

~~~  
UUID=3e6be9de-8139-11d1-9106-a43f08d823a6  
~~~

(Sursa: [wiki.archlinux.org](http://wiki.archlinux.org/index.php/Persistent_block_device_naming)  şi  [marc.theaimsgroup.com](http://marc.theaimsgroup.com/?l=linux-hotplug-devel&amp;m=114795097514527&amp;w=2)  Conţinutul din wiki.archlinux.org a fost declarat disponibil sub GNU Free Documentation License 1.2) şi a fost reeditat pentru manualul siduction.

 [Mai multe despre etichetarea partițiilor găsiți la  *www.lissot.net*](http://www.lissot.net/partition/ext2fs/labels.html)  

<div id="rev">Content last revised 26/04/2011 1355 UTC/div>
