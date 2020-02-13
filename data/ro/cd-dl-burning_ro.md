<div id="main-page"></div>
<div class="divider" id="download-siduction"></div>
## Descărcarea ISO - ului  *siduction* 

###### **`FOARTE IMPORTANT:`** ` *siduction* , ca LIVE-CD, este bazat pe o tehnologie de înaltă compresie şi din această cauză este nevoie de o grijă deosebită când se scrie o imagine ISO. Folosiţi doar CD-uri sau DVD-uri de bună calitate pe care să le scrieţi doar în **`DAO-mode (disk-at-once)`**  şi nu cu viteză mai mare de 8X.` 


---

**`ÎNTOTDEAUNA SALVAŢI-VĂ DATELE!`**

### Locaţii de Download 

###### Vă rugăm utilizaţi cea mai apropiată locaţie. Locațiile urmate de  *codeboxes*  sunt actualizate imediat ce schimbările sunt făcute (uitați-vă la  */etc/apt/sources.list.d/siduction.list* ).

#### Europe

+  **Free University Berlin/ spline (Student Project LInux NEtwork), Germany:**   
    [http://ftp.spline.de/pub/siduction/iso](http://ftp.spline.de/pub/siduction/iso)   
    [ftp://ftp.spline.de/pub/siduction/iso](ftp://ftp.spline.de/pub/siduction/iso)   
   rsync://ftp.spline.de/siduction/iso  

~~~  
deb ftp://ftp.spline.de/pub/siduction/base unstable main  
deb ftp://ftp.spline.de/pub/siduction/fixes unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/base unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/fixes unstable main  
~~~

#### North America

+  **`University of Delaware`**   
    [http://mirror.lug.udel.edu/pub/siduction/iso](http://mirror.lug.udel.edu/pub/siduction/iso)   
    [ftp://ftp.lug.udel.edu/pub/siduction/iso](ftp://ftp.lug.udel.edu/pub/siduction/iso) rsync://rsync.lug.udel.edu/siduction/iso  

~~~  
deb ftp://ftp.lug.udel.edu/pub/siduction/base unstable main  
deb-src ftp://ftp.lug.udel.edu/pub/siduction/base unstable main  
deb ftp://ftp.lug.udel.edu/pub/siduction/fixes unstable main  
deb-src ftp://ftp.lug.udel.edu/pub/siduction/fixes unstable main  
~~~

+  **`Georgia Tech`**   
    [http://www.gtlib.gatech.edu/pub/siduction/iso](http://www.gtlib.gatech.edu/pub/siduction/iso)   
    [ftp://ftp.gtlib.gatech.edu/pub/siduction/iso](ftp://ftp.gtlib.gatech.edu/pub/siduction/iso)  rsync://rsync.gtlib.gatech.edu/siduction/iso  

#### South America

+  **`Universidade Estadual de Campinas (unicamp), São Paulo, Brasilien`**   
    [http://www.las.ic.unicamp.br/pub/siduction/iso/](http://www.las.ic.unicamp.br/pub/siduction/iso/)   
    [ftp://www.las.ic.unicamp.br/pub/siduction/iso/](ftp://www.las.ic.unicamp.br/pub/siduction/iso/)   

~~~  
deb ftp://www.las.ic.unicamp.br/pub/siduction/base unstable main  
deb-src ftp://www.las.ic.unicamp.br/pub/siduction/base unstable main  
deb ftp://www.las.ic.unicamp.br/pub/siduction/fixes unstable main  
deb-src ftp://www.las.ic.unicamp.br/pub/siduction/fixes unstable main  
~~~

#### Asia

+   

#### Africa

+   

#### Australia

+   

<div class="divider" id="siduction-def"></div>
#### Numele fișierelor în fiecare locație

Fiecare locație  *siduction*  are următoarele fișiere:

~~~  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
SOURCES  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.arch.manifest  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.iso  
~~~

Fișierul `.manifest`  conține lista tuturor pachetelor din ISO-ul specificat. 

 Fișierul `.iso`  este imaginea de descărcat (download). 

 Fișierele `.md5 și .sha256`  sunt pentru a verifica integritatea imaginii iso.

Fișierul `.gpg`  conține semnături cu care puteți verifica dacă  *checksums*  (.md5 .sha256) nu au fost modificate și deci pot fi folosite la verificarea integrității imaginii iso.

Fișierul cu surse  *.tar*  este destinat doar celor care doresc numai codul sursă în scopuri de redistribuire cu respectarea cerințelor de licență. Citiți fișierul SOURCES pentru mai multe informații.

Dacă cineva are un server FTP rapid şi cu suficient trafic la dispoziţia sa, vă rugăm să ne informaţi la  [siduction Forums](http://siduction.org/) . Adresa alternativă  [siduction Forums](http://siduction.org/)  sau IRC-Channel la irc.oftc.net:6667 #siduction.

Link-uri către locaţiile de descărcare sunt şi aici:  [siduction.org](http://siduction.org) 

<div class="divider" id="md5"></div>
## Verificarea sumei de control cu  *md5sum*  şi validarea

###### **`FOARTE IMPORTANT:`** ` *siduction* , ca LIVE-CD, este bazat pe o tehnologie de înaltă compresie şi din această cauză este nevoie de o grijă deosebită când se scrie o imagine ISO. Folosiţi doar CD-uri sau DVD-uri de bună calitate pe care să le scrieţi doar în **`DAO-mode (disk-at-once)`**  şi nu cu viteză mai mare de 8X.` 


---

Aceasta este o sumă de control a fişierelor şi este folosită pentru a verifica integritatea lor după descărcare. Suma de control curentă este comparată cu o sumă deja ştiută. În acest fel se verifică dacă fişierul a fost schimbat sau deteriorat; procedeul este folosit în special pentru fişierele descărcate de pe internet.

Dacă suma de control a fişierului descărcat corespunde cu cea din fişierul  *md5sum*  puteţi fi siguri că fişierul a fost descărcat corect. În Linux obţineţi suma de control cu comanda (va dura puţin până este calculată): 

~~~  
$ md5sum  fișierul_de_verificat   
~~~

Rezultatul va fi scris în consolă.  
Cu programul  *md5summer*  (486 kb) suma de control  *md5sum*  poate fi verificată şi în Windows.

Imaginile tip ISO ale  *siduction*  au întotdeauna ataşat un fisier  *md5sum*  cu ajutorul căruia puteţi verifica integritatea imaginii înainte de a o scrie pe disc. Se garantează astfel, în cazul în care apar probleme, că ele nu se datorează descărcării defectuoase a fişierelor şi astfel forumul se ţine liber de probleme care nu pot fi rezolvate din cauză că fişierele ISO au fost deteriorate la descărcare. Verificarea se face în consolă. Schimbaţi în directorul unde se află fişierul ISO şi MD5 apoi procedați la verificare astfel:

Descărcați următoarele fișiere de la locația aleasă (mirror):

~~~  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
~~~

Într-un terminal tastați:

~~~  
$ md5sum siduction.iso  
~~~

Dacă suma de control şi fişierul  *md5sum*  nu au aceaşi valoare veţi primi mesajul:

~~~  
"siduction.iso: Error  
md5sum: Warning: calculated checksum does not match!"  
~~~

Dacă fişierul descărcat este corect programul se va termina fără nici un mesaj.

<div class="divider" id="burn-nero"></div>
## Scrierea CD-ului în Windows

###### **`FOARTE IMPORTANT:`** ` *siduction* , ca LIVE-CD, este bazat pe o tehnologie de înaltă compresie şi din această cauză este nevoie de o grijă deosebită când se scrie o imagine ISO. Folosiţi doar CD-uri sau DVD-uri de bună calitate pe care să le scrieţi doar în **`DAO-mode (disk-at-once)`**  şi nu cu viteză mai mare de 8X.` 


---

Bineînţeles CD-ul poate fi scris şi în Windows. Fisierul descărcat trebuie scris ca un fişier ISO. Dacă Winrar (sau un alt program de arhivare) este asociat cu fişierele .ISO el va fi arătat ca o arhivă. Din acest fişier ISO trebuie scris CD-ul.

Există câteva opţiuni pentru a scrie discul în Windows.

##### Programe Open Source pentru Windows

 [cdrtfe](http://cdrtfe.sourceforge.net/) : compatibil cu Windows 9x/ME/2000/XP (testat în Win95, Win98SE, Win2000, WinXP) doar în Win9x/ME: lucrează ASPI Layer (ex. Adaptec ASPI 4.60)

 [LinuxLive USB Creator](http://www.linuxliveusb.com) , un proiect open source, oferă un GUI (interfață grafică) pentru MS Windows&#8482;, cu care puteți face o instalare a siduction-i386.iso (32 bit) pe un USB stick. `Trebuie să folosiți bootline/cheatcode **`fromhd`**  în linia de comandă din ecranul de boot` .

###### Programe de scriere cu licentă în Windows

+  Nero (însă NU nero express!)  
+ O altă unealtă bună care este freeware  [CD/DVD Burner XP pro](http://www.cdburnerxp.se/)   
+  *Burncdcc*  de la  [terabyteunlimited](http://www.terabyteunlimited.com/utilities.html) care scrie doar fişiere ISO.  

<div class="divider" id="burn-linux"></div>
## Scrierea CD-ului în Linux 

###### **`FOARTE IMPORTANT:`** ` *siduction* , ca LIVE-CD, este bazat pe o tehnologie de înaltă compresie şi din această cauză este nevoie de o grijă deosebită când se scrie o imagine ISO. Folosiţi doar CD-uri sau DVD-uri de bună calitate pe care să le scrieţi doar în **`DAO-mode (disk-at-once)`**  şi nu cu viteză mai mare de 8X.` 


---

Dacă deja folosiţi linux pe computer puteţi scrie CD-ul fie folosind consola, fie un program de scriere deja instalat.

În  *siduction*  sau alte distribuţii de Linux, `K3b` este unealta implicită de scriere CD-uri. Deschideţi-l, apoi selectaţi  *Tools ->burn CD-Image...*  şi alegeţi fişierul ISO de scris (de exemplu siduction.iso).

 *K3B* , iniţial, calculează suma de control MD5 pentru fişierul ISO (va dura un moment). Dacă suma găsită este similară cu suma din fişierul MD5 (de exemplu siduction.iso.md5), descărcarea a fost terminată cu succes şi puteţi scrie fişierul apăsând "Start".

`Probleme la ardere se întâmplă mai ales la alplicațiile cu interfață grafică. Puteți arde direct din consolă cu  [burniso](cd-no-gui-burn-ro.htm) .` 

###### Vedeți de asemenea  [Scrierea  *siduction*  pe un USB/SSD stick cu orice sistem Linux, MS Windows sau Mac OS X (32 și 64 bit)](hd-ins-opts-oos-ro.htm#raw-usb) .

<div id="rev">Content last revised 30/11/2012 0235 UTC</div>
