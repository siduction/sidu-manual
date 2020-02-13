<div id="main-page"></div>
<div class="divider" id="apt-cook"></div>
## Mic ghid de utilizare  *APT* 

### Ce înseamnă  *APT* ?

 *APT*  este prescurtarea de la  **A** dvanced  **P** ackaging  **T** ool şi este o colecţie de programe şi scripturi care ajută atât administratorul de sistem (în cazul dumneavoastră  *root* ) la instalarea şi managementul de fişiere  *deb*  cât şi ca sistemul să ştie ce are instalat.

<div class="divider" id="sources-list"></div>
## Lista Surselor

Sistemul  *"APT"*  are nevoie de un fisier  *"config"*  care conține informații despre locațiile pachetelor ce pot fi instalate și actualizate și care se numește în mod obișnuit `sources.list` .

 Fișierele  *sourses.list*  sunt în directorul numit:  
`/etc/apt/sources.list.d/` 

În dosar sunt două fișiere numite:  
`/etc/apt/sources.list.d/debian.list`  și  
`/etc/apt/sources.list.d/siduction.list` 

Acesta are beneficiul unei schimbări de oglindire priorică (automată), ceea ce face posibilă o înlocuire a listelor, mult mai sigură.

Puteți de asemeni să adăugați fișiere `/etc/apt/sources.list.d/*.list` personale.

### Toate imaginile siduction ISO deja folosesc următorea sursă implicit:

~~~  
#siduction  
# Free University Berlin/ spline (Student Project LInux NEtwork), Germany  
deb ftp://ftp.spline.de/pub/siduction/debian/ sid main fix.main  
#deb-src ftp://ftp.spline.de/pub/siduction/debian/ sid main fix.main  
~~~

Viitoare intrări pentru driverele  *non-free*  pot fi găsite aici:  [siduction.list](http://siduction.org/files/misc/sources.list.d/siduction.list)  și  [debian.list](http://siduction.org/files/misc/sources.list.d/debian.list) :

~~~  
#Debian  
# Unstable  
deb http://ftp.us.debian.org/debian/ unstable main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ unstable main contrib non-free  
# Testing  
#deb http://ftp.us.debian.org/debian/ testing main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ testing main contrib non-free  
# Experimental  
#deb http://ftp.us.debian.org/debian/ experimental main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ experimental main contrib non-free  
~~~

NOTĂ: În acest exemplu  *ftp.us*  indică folosirea repositoriului german. Se poate edita acest fişier, ca  *root* , să folosească repositoriul cel mai apropiat de dumneavoastră schimbând ţara, ex.schimbaţi  *ftp.us*  în  *ftp.ro*  sau  *ftp.uk* . Majoritatea ţărilor au servere locale. În felul acesta lăţimea de bandă este conservată și viteza îmbunătăţită.

 [Statutul curent al Listelor cu Serverele Debian](http://www.debian.org/mirrors/) .

Pentru a obţine informaţii proaspete despre pachete,  *APT*  folosește o bază de date. Această bază de date conţine atât pachetele principale dar şi alte pachete necesare acestora să funcţioneze corect (numite dependenţe). Programul  *apt-get*  foloseşte această bază de date când instalează pachetele alese de dumneavoastră şi pentru a rezolva toate dependenţele şi prin aceasta se garantează că pachetele instalate vor lucra. Împrospătarea acestei baze de date se face cu comanda  *apt-get update* .

~~~  
# apt-get update  
(care va aduce )  
Get:1 http://siduction.org sid Release.gpg [189B]  
Get:2 http://siduction.org sid Release.gpg [189B]  
Get:3 http://siduction.org sid Release.gpg [189B]  
Get:4 http://ftp.de.debian.org unstable Release.gpg [189B]  
Get:5 http://siduction.org sid Release [34.1kB]  
Get:6 http://ftp.de.debian.org unstable Release [79.6kB]  
~~~

<div class="divider" id="apt-install"></div>
## Instalarea unui nou pachet 

Presupunând că baza de date  *APT*  este actualizată şi numele pachetului de instalat cunoscut, atunci comanda următoare va instala un pachet numit ca în exemplu împreună cu toate dependenţele sale: (mai departe vom vedea cum căutăm şi găsim pachete)

~~~  
# apt-get install qemu  
Reading package lists... Done  
Building dependency tree... Done  
The following extra packages will be installed:  
bochsbios openhackware proll vgabios  
Recommended packages:  
debootstrap vde  
The following NEW packages will be installed:  
bochsbios openhackware proll qemu vgabios  
0 upgraded, 5 newly installed, 0 to remove and 20 not upgraded.  
Need to get 4152kB of archives.  
After unpacking 11.9MB of additional disk space will be used.  
Do you want to continue [Y/n]? n  
~~~

<div class="divider" id="apt-delete"></div>
## Ştergerea unui pachet

Similar următoarea comandă va desinstala un pachet dar nu va desinstala și dependențele: 

~~~  
apt-get remove gaim  
~~~

~~~  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim gaim-irchelper  
0 upgraded, 0 newly installed, 2 to remove and 310 not upgraded.  
Need to get 0B of archives.  
After unpacking 4743kB disk space will be freed.  
Do you want to continue [Y/n]?  
(Reading database ... 174409 files and directories currently installed.)  
Removing gaim-irchelper ...  
Removing gaim ...  
~~~

În acest ultim caz fişierul de configurare al pachetului  *'gaim'*  (practic modul cum este setat) nu a fost şters din sistem. Îl puteţi folosi când instalaţi acelaşi pachet din nou şi va functiona cu aceste setări.

Dacă doriţi ca şi fişierul de configurare să fie şters lansaţi comanda:

~~~  
apt-get --purge remove gaim  
~~~

~~~  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim  
0 upgraded, 0 newly installed, 1 to remove and 309 not upgraded.  
Need to get 0B of archives.  
After unpacking 4678kB disk space will be freed.  
Do you want to continue [Y/n]? Y  
(Reading database ... 174405 files and directories currently installed.)  
Removing gaim ...  
Purging configuration files for gaim ...  
~~~

Remarcați semnul `*`  după numele pachetului în output-ul lui  *apt* . Asteriscul din output-ul lui  *apt*  indică faptul că și fișierele de configurare vor fi de asemenea șterse.

<div class="divider" id="apt-downgrade"></div>
## Menținerea ( *Hold* )/Întoarcerea la o versiune anterioară a unui pachet

Uneori e posibil să trebuiască să vă întoarceți la o versiune anterioară a unui pachet din cauza unor probleme apărute după instalarea ultimei versiuni a acestuia sau să păstrați în sistem actuala versiune.

### *Hold* 

~~~  
echo package hold|dpkg --set-selections  
~~~

Să înlocuiești un pachet pus anterior în  *Hold* 

~~~  
echo package install|dpkg --set-selections  
~~~

Să listezi pachete rezervate (marcate ca  *hold* ):

~~~  
dpkg --get-selections | grep hold  
~~~

### Întoarcerea la o versiune anterioară a unui pachet

 **`Debian nu susține întoarcerea la o versiune anterioară (downgrading) a pachetelor. În timp ce această operațiune poate funcționa în unele cazuri simple, poate eșua spectaculos în altele. Vă rog să citiți la`**  [Emergency downgrading](http://www.debian.org/doc/manuals/reference/ch02.en.html#_emergency_downgrading) .

În ciuda acestui fapt, revenirea la o versiune anterioară (downgrading) poate funcționa pentru pachete simple. Vom folosi ca exemplu pachetul `kmahjongg`  pentru a vă arăta pașii de urmat:

1. comentați sursele unstable în `/etc/apt/sources.list.d/debian.list`  cu un `#`   
2. Adăugați sursele testing în `/etc/apt/sources.list.d/debian.list` , de exemplu:  
   ~~~    
   deb http://ftp.nl.debian.org/debian/ testing main contrib non-free    
   ~~~
  
3. ~~~    
   apt-get update    
   ~~~
  
4. ~~~    
   apt-get install kmahjongg/testing    
   ~~~
  
5. Puneți pachetul nou instalat în așteptare (hold) cu:  
   ~~~    
   echo kmahjongg hold|dpkg --set-selections    
   ~~~
  
6. comentați cu &lt;#&gt;sursele testing în /etc/apt/sources.list.d/debian.list și decomentați sursele unstable pentru a reveni la utilizarea surselor unstable, apoi:  
7. ~~~    
   apt-get update    
   ~~~
  

Când vreți să luați ultima versiune a pachetului faceți următoarele:

~~~  
echo kmahjongg install|dpkg --set-selections  
apt-get update  
apt-get install kmahjongg  
~~~

<div class="divider" id="apt-upgrade"></div>
## Actualizarea unui Sistem Instalat -  *dist-upgrade*  - Sumar

Dacă întregul sistem trebuie să fie actualizat, această actiune este obținută prin `dist-upgrade` . Verifică întotdeauna anunțurile de alertă curente pe site-ul  [siduction](http://siduction.org)  și alertele pentru pachetele pe care sistemul vrea să le șteargă (remove) prin  *dist-upgrade* . Dacă ai nevoie să `reții (hold)`  un pachet, referă-te la  [Menținerea (*Hold*)/Întoarcerea la o versiune anterioară a unui pachet](sys-admin-apt-ro.htm#apt-downgrade) 

Un  *upgrade*  numai de  *'debian sid'*  nu este recomandat.

##### Frecventa de  *dist-upgrade* 

Efectuați  *dist-upgrade*  cât mai des posibil, ideal ar fi 1 dată pe săptămână sau 1 dată la două săptămâni, cel puțin o dată pe lună ca să fiți în siguranță. Un  *dist-upgrade*  inițiat doar o dată la 2 sau 3 luni trebuie considarat ca ultima limită de siguranță. Pentru pachete non-standard sau pachete autocompilate, trebuie să fiți mult mai atenți cu upgrading-ul, deoarece aceasta poate să-ți strice sistemul în orice moment datorită incompatibilităților.

După ce baza de date a fost actualizată, se poate afla care pachete au versiuni noi sau mai noi: (instalați mai întâi  *apt-show-versions* )

~~~  
apt-show-versions -u  
libpam-runtime/unstable upgradeable from 0.79-1 to 0.79-3  
passwd/unstable upgradeable from 1:4.0.12-5 to 1:4.0.12-6  
teclasat/unstable upgradeable from 0.7m02-1 to 0.7n01-1  
libpam-modules/unstable upgradeable from 0.79-1 to 0.79-3.........  
~~~

Update-ul unui singur pachet, inclusiv dependenţele sale poate fi făcut (de exemplu la  *gcc-4.0* ) cu:

~~~  
# apt-get install gcc-4.0  
apt-get install gcc-4.0  
Reading package lists... Done  
Building dependency tree... Done  
gcc-4.0 is already the newest version.  
0 upgraded, 0 newly installed, 0 to remove and xxx not upgraded  
~~~

#### Doar download-are

`O optiune putin cunoscută dar fantastică, de a verifica ce pachete sunt în  *dist-upgrade*  este  *-d* :`

~~~  
apt-get update && apt-get dist-upgrade -d  
~~~

Opțiunea ' *-d* ' vă permite să descărcați pachetele cu  *dist-upgrade*  fără să le instalați, în timp ce sunteți în mediul grafic  *X*  și vă permite să efectuați  *dist-upgrade* -ul în ' *init 3* ' mai târziu. De asemeni, aceasta vă dă șansa să verificați alertele împotriva listei, ceea ce vă oferă, cu înțelepciune, optiunea de a continua sau de a termina astfel.

~~~  
apt-get dist-upgrade -d  
Reading package lists... Done  
Building dependency tree  
Reading state information... Done  
Calculating upgrade... Done  
The following NEW packages will be installed:  
elinks-data  
The following packages have been kept back:  
git-core git-gui git-svn gitk icedove libmpich1.0ldbl  
The following packages will be upgraded:  
alsa-base bsdutils ceni configure-ndiswrapper debhelper  
discover1-data elinks file fuse-utils gnucash.........  
35 upgraded, 1 newly installed, 0 to remove and 6 not upgraded.  
Need to get 23.4MB of archives.  
After this operation, 594kB of additional disk space will be used.  
Do you want to continue [Y/n]?Y   
~~~

`Y`  veți descărca pachetele îmbunătățite fără a va atinge de sistemul instalat.

După ce ' *dist-upgrade -d* ' a făcut descărcarea şi doriţi să finalizaţi procesul de  *dist-upgrade* , imediat sau altă dată, vă rugăm urmaţi instrucţiunile:

<div class="divider" id="du-st"></div>
###  *dist-upgrade*  - Pașii de urmat

<div class="box block">
**ABSOLUT NICIODATĂ să nu faceţi dist-upgrade şi nici măcar upgrade în timp ce lucraţi în X<div class="highlight-4"> Întotdeauna verificaţi  *Current Warnings*  de pe pagina principală  [siduction](http://siduction.org) . Aceste avertismente există acolo cu un motiv bine întemeiat şi din cauza naturii  *unstable*  şi a  *update* -ului zilnic.**

~~~  
Log out of KDE.  
Go to Textmode by doing Ctrl+Alt+F1  
logon as root, and then in type init 3  
apt-get update  
apt-get dist-upgrade  
apt-get clean  
init 5 && exit  
~~~

**NICIODATĂ NU FACEŢI  *DIST-UPGRADE*  [sau  *UPGRADE* ] cu  *adept* ,  *synaptic*  sau  *aptitude* .**


---

**`Dacă nu intraţi în  *init 3* , ei bine, greu de voi ... aţi fost avertizaţi !`**

<div class="divider" id="whyno"></div>
#### Motivele pentru care NU TREBUIE să folosiţi altceva în afară de  *apt-get*  pentru  *dist-upgrade* 

Managere de pachete ca  *adept* ,  *aptitude* ,  *synaptic*  şi  *kpackage*  nu sunt capabile întotdeauna să contorizeze enorm de multele schimbări care se întâmplă în Sid (schimbări de dependenţe, de nume, schimbări de scripturi de întreţinere, ...). 

Nu este vina dezvoltatorilor şi nici a programelor pe care aceştia le fac, totuşi ei fac unelte excelente pentru ramura  *debian stable* , acestea pur şi simplu nu se potrivesc perfect cu nevoile speciale din  *Debian Sid* .

Utilizaţi orice doriţi pentru a căuta pachete dar rămâneţi fermi în a folosi doar  *apt-get*  pentru procesele de instalare/ştergere/dist-upgrade

Managere de Pachete ca  *adept* ,  *aptitude* ,  *synaptic*  şi  *kpackage*  sunt, până la urmă, incerte (pentru selecţie complexă de pachete), adăugaţi la aceasta o ţintă mereu în mişcare precum  *sid*  şi poate un şi mai rău repozitoriu extern de o calitate îndoielnică (noi nu recomandăm acestea dar ele sunt o realitate printre utilizatori) şi veţi fi conduși la dezastru.

Un alt lucru care trebuie ţinut minte este că toate aceste tipuri de managere de pachete cu GUI trebuiesc rulate în X, iar dacă faceţi un  *dist-upgrade*  în X, (nici măcar un ' *upgrade* ' nu este recomandat), veţi sfârşi prin a aduce daune ireparabile sistemului dumneavoastră, nu neaparat azi sau mâine, dar în timp sigur.

 *apt-get* , pe de altă parte, face exact ce i se cere să facă, dacă există vreo scăpare pe care aţi identificat-o şi încercaţi să o depanaţi/reparaţi şi  *apt-get*  vrea să îndepărteze jumătate din sistem (ca urmare a tranziţiilor librăriilor) este decizia administratorului (adică a dumneavoastră), măcar să analizaţi cu atenţie.

Acesta este motivul pentru care debian foloseşte  *apt-get*  şi nu alte managere de pachete.

<div class="divider" id="apt-cache"></div>
## Căutarea unui pachet cu  *apt-cache* 

O altă comandă foarte utilă în  *APT-system*  este  *apt-cache* ; aceasta caută în  *APT-Database*  şi arată informaţiile despre pachete; de ex. o listă a tuturor pachetelor care conţin termenii "siduction" şi "manual" se obţine prin:

~~~  
$ apt-cache search siduction manual  
.......  
siduction-manual-common - the official siduction manual - common files  
siduction-manual-es - the official Spanish siduction manual  
siduction-manual-de - the official German siduction manual  
siduction-manual-el - the official Greek siduction manual  
siduction-manual - the official siduction manual - all languages  
siduction-manual-pt-br - the official Brazilian Portuguese siduction manual  
siduction-manual-en - the official English siduction manual  
siduction-manual-reader - siduction manual reader  
~~~

Dacă doriţi informaţii mai în amănunt despre un anumit pachet puteţi folosi:

~~~  
$ apt-cache show siduction-manual-en  
Package: siduction-manual-en  
Priority: optional  
Section: doc  
Installed-Size: 1088  
Maintainer: Kel Modderman <kel@otaku42.de>  
Architecture: all  
Source: siduction-manual  
Version: 01.12.2007.06.03-1  
Depends: siduction-manual-common  
Filename: pool/main/s/siduction-manual/siduction-manual-en_01.12.2007.06.03-1_all.deb  
Size: 391222  
MD5sum: 60f2175c3c5709745a4b4256ccc3c49d  
SHA1: e275a0b27628b6aa210a4ced48d3646b438e78b8  
SHA256: 2792580c7a091521301064180a1d0d8901f0a4af407b90432b9f8d8b6b3603ca  
Description: the official en siduction manual  
This manual is divided into common sections, for example, .......  
~~~

Toate versiunile instalabile ale unui pachet (depind şi de  *sources.list* ) pot fi listate tipărind:

~~~  
$ apt-cache policy siduction-manual-en  
siduction-manual-en:  
Installed: (none)  
Candidate:01.12.2007.06.03-1  
Version table:  
01.12.2007.06.03-1 0  
500 http://siduction.org sid/main Packages  
~~~

<div class="divider" id="gui-pacsea"></div>
## Aplicaţia GUI Debian Package Search

~~~  
apt-get update  
apt-get install packagesearch  
~~~

Când aţi pornit pentru prima oară programul Debian Package Search trebuie să configuraţi în meniul Packagesearch>Preferences să folosească `apt-get` .

**`Vă rugăm nu folosiţi PackageSearch pentru a instala pachete, folosiţi-l numai ca un motor de căutare. Actualizarea şi instalarea de noi pachete packages fără a opri X poate produce probleme. Vă rugăm citiţi  [Instalarea unui pachet nou](sys-admin-apt-en.htm#apt-install) .`** 

La prima rulare poate veţi fi rugaţi să instalaţi deborphan. Folosiţi-l cu mare atenţie.

Criteriile de căutare pot fi după

+ şiruri de caractere  
+ tag-uri (bazându-se pe sistemul debtags, noul sistem Debian de a introduce un pachet în o categorie)  
+ fişiere  
+ statusul instalării  
+ pachete orfane  

Informaţii adiţionale sunt arătate, inclusiv fişierele care aparţin pachetului respectiv. Vă rugăm citţi Help>Contents pentru a învăţa să folosiţi Debian Package Search GUI. În acest moment interfaţa grafică GUI este doar în limba engleză.

 [O descriere completă despre Sistemul APT poate fi găsită la APT-HOWTO](http://www.debian.org/doc/manuals/apt-howto/)  

<div id="rev">Page last revised 30/11/2012 1330 UTC </div>
