<div id="main-page"></div>
<div class="divider" id="part-lvm"></div>
## Partiționarea cu LVM -  *Logical Volume Manager* 

**`Acesta este doar un ghid de bază cu care să puteți începe. Rămâne în responsabilitatea voastră să învățați mai multe despre LVM. Câteva surse de documentare ce vă pot fi de folos găsiți la sfârșitul acestei pagini dar ele pot fi mult mai multe.`** 

Ghidul este aplicabil pentru siduction-2011.1-onestepbeyond.iso sau mai nou.

Spre deosebire de metodele tradiționale de partiționare a hard-disk-urilor, volumele logice pot cuprinde mai multe disk-uri și sunt scalabile. 

Oricum, fie că folosiți metoda tradițională sau cea LVM, partiționarea nu este o activitate ce o faceți foarte des, implică multă gândire împreună cu încercări, eșecuri și erori, până veți fi mulțumiți de rezultate.

Sunt 3 termeni de bază pe care trebuie să-i cunoașteți:

+ `Volumele fizice ( *Physical Volumes* ):`  Acestea sunt disk-urile voastre fizice sau partițiile de pe ele, cum ar fi /dev/sda sau /dev/sdb1. Astea le folosiți de regulă când le mount-ați/unmount-ați. Folosind LVM putem combina mai multe volume fizice în grupări de volume ( *volume groups* ).   
+ `Grupări de volume ( *Volume Groups* ):`  O grupare de volume conține mai multe volume fizice reale și este folosită pentru a realiza volume logice pe care le puteți crea/ redimensiona/ șterge și utiliza. Puteți considera o grupare de volume ca pe un "disk virtual" ansamblat din mai multe disk-uri reale. Îl puteți împărți în "partiții virtuale" care sunt volume logice.  
+ `Volume Logice ( *Logical Volumes* ):`  Volumele logice sunt cele pe care le veți mount-a în sistemul vostru de operare. Acestea pot fi adăugate, șterse sau redimensionate direct. Fiind într-o grupare de volume ele pot fi chiar mai mari decât oricare dintre disk-urile fizice pe care le aveți.<br/>( *exemplu:*  4 disk-uri de câte 250GB pot fi combinate într-o grupare de volume de 1TB, iar apoi împărțite în 2 volume logice de câte 500GB fiecare.)  

### Sunt necesari 6 pași de bază

`Următorul exemplu presupune că veți folosi niște hard-disk-uri noi, nepartiționate sau care necesită o nouă schemă de partiționare, ceea ce va duce la ștergerea completă a datelor de pe disk-urile ce le veți converti în LVM.` 

Este necesară utilizarea  *cfdisk*  sau  *fdisk*  deoarece  *Gparted*  și  *KDE Partition Manager* , ( *partitionmanager* ), nu pot crea partiții LVM.

`Pasul 1:`  Crearea tabelei de partiții:

~~~  
cfdisk /dev/sda  
n to create a new partition on the disk  
p to make this the primary partition  
1 to give the partition the number 1 as an identifier  
`### size allocation  ### Set first and last cylinders to the default values (press enter) to span the entire drive  
t toggle the type of partition to create  
8e is the hex code for a Linux LVM  
W to write your changes to the disk. ##This will write the partition table. If you have realised that you made a mistake at this point, you could restore the old partition layout and your data will be fine.##  
~~~

Dacă doriți ca volumul să cuprindă 2 sau mai multe disk-uri, repetați procesul pentru fiecare disk.

`Pasul 2:`  Setați partiția ca Volum Fizic (Physical Volume). Această operațiune va șterge toate datele:

~~~  
pvcreate /dev/sda1  
~~~

Repetați procesul pentru toate partițiile necesare.

`Pasul 3:`  Creați gruparea de volume:

~~~  
vgcreate vulcan /dev/sda1  
~~~

Dacă doriți, de exeplu, să folsiți 3 disk-uri, includeți și alte disk-uri în comanda  *vgcreate* :

~~~  
vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1  
~~~

Dacă ați făcut totul corect veți puteva vedea rezultatul cu comanda:

~~~  
vgscan  
~~~

 *vgdisplay*  vă va arăta `dimensiunea`  :

~~~  
vgdisplay vulcan  
~~~

`Pasul 4:`  Crearea Volumelor Logice (Logical Volume). Acum este momentul să decideți cât de mari să fie inițial volumele logice. Un avantaj al LVM este că puteți modifica mărimea volumelor fără să mai reboot-ați.

Să presupunem că vreți inițial un volum de 300GB numit  *spock*  în cadrul lvm numit  *vulcan* :

~~~  
lvcreate -n spock --size 300g vulcan  
~~~

`Pasul 5:`  Format-ați volumul și aveți răbdare pe timpul format-ării; s-ar putea să dureze ceva vreme:

~~~  
mkfs.ext4 /dev/vulcan/spock  
~~~

`Pasul 6:` 

~~~  
mkdir /media/spock/  
~~~

Modificați  *fstab*  cu editorul preferat pentru a mount-a volumul în timpul procesului de boot-are. 

~~~  
mcedit /etc/fstab  
~~~

Folosirea `/dev/vulcan/spock`  este mai ușoară decât codurile UUID când avem LVM, putând asfel să clonăm sistemul de fișiere fără grija că vom produce o coliziune UUID, mai ales cu LVM, sfârșind prin a avea mai multe sisteme de fișiere cu același număr UUID (acesta fiind doar un prim exemplu).

~~~  
/dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2  
~~~

`Opțional:`  Schimbați proprietarul volumului astfel ca și alți utilizatori să poată citi/scrie în LVM:

~~~  
chown root:users /media/spock  
~~~

~~~  
chmod 775 /media/spock  
~~~

Aveți acum un LVM cu setările de bază.

### Redimensionarea volumelor

`Dacă folosiți un live ISO este foarte recomandat să modificați dimensiunea partițiilor. În timp ce mărirea partițiilor 'on the fly' poate fi fără erori, nu se poate spune același lucru atunci când sunt micșorate volumele, anomalii ce pot duce la pierderea de date, în particular dacă partițiile **`/ (root)`**  sau **`/home`**  sunt implicate.` 

##### Pentru redimensionarea volumului de la 300GB la 500GB, așa cum este folosit în acest exemplu:

~~~  
umount /media/spock/  
~~~

~~~  
lvextend -L+200g /dev/vulcan/spock  
~~~

Apoi executați comanda următoare pentru redimensionarea sistemului de fișiere:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### Pentru redimensionarea (micșorarea) volumului de la 500GB la 280GB, așa cum este folosit în acest exemplu:

~~~  
umount /media/spock/  
~~~

Apoi executați comanda următoare pentru redimensionarea sistemului de fișiere:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock 280g  
~~~

Apoi redimensionați volumul:

~~~  
lvreduce -L-20g /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### O interfață grafică (GUI) pentru LVM 

Programul `system-config-lvm`  oferă o interfață grafică ce vă poate ajuta în administrarea LVM-urilor; pornește din linia de comandă ca  *root* :

~~~  
apt-get install system-config-lvm  
man system-config-lvm `# trebuie citit   
~~~

##### Surse și resuse suplimentare:

+  [Debian Administration - A simple introduction to working with LVM](http://www.debian-administration.org/articles/410)   
+  [IBM - Logical volume management](http://www.ibm.com/developerworks/linux/library/l-lvm2/)   
+  [IBM - Resizing Linux partitions, Part 2: Advanced resizing](http://www.ibm.com/developerworks/linux/library/l-resizing-partitions-2/index.html)   
+   [Red Hat - LVM Administrator's Guide](http://docs.google.com/viewer?a=v&amp;q=cache:1RMpacheCBcJ:www.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/5.4/pdf/Logical_Volume_Manager_Administration.pdf+%22Logical+Volume+Manager+Administration+%22&amp;hl=en&amp;pid=bl&amp;srcid=ADGEEShRiptIjzsnPNsCs4RgyUFNWkYcrDc3SkBSD6cTq39D6wye5JM3tP_ehcn37I5VWs84I_HI45rvG-n6YG4R2fE8hqDByq-KPhNEkha4zwphrR7QIUVnUz6omwY85e-ZEXX723Js&amp;sig=AHIEtbSJyxEst6Wue7_1_TeDYwB480azEw)   
+   [Logical Volume Manager (Linux)](http://en.wikipedia.org/wiki/Logical_Volume_Manager_%28Linux%29)   
+   [Setting up an LVM for Storage](http://thelinuxexperiment.com/guinea-pigs/jon-f/setting-up-an-lvm-for-storage/)   
+   [Creating a LVM in Linux](http://linuxhelp.blogspot.com/2005/04/creating-lvm-in-linux.html)   
+   [Linux lvm - Logical Volume Manager](http://www.linuxconfig.org/Linux_lvm_-_Logical_Volume_Manager)   

<div id="rev">Page last revised 04/12/2012 2325 UTC</div>
