<div id="main-page"></div>
<div class="divider" id="burning-no-gui"></div>
## Scrierea unui CD/DVD fără GUI (fără interfaţă grafică )

###### **`FOARTE IMPORTANT:`** `siduction , ca LIVE-CD, este bazat pe o tehnologie de înaltă compresie , şi din această cauză este nevoie de grijă deosebită când se scrie o imagine ISO . Folosiţi doar CD-uri sau DVD-uri de bună calitate pe care să le scrieţi doar în **`DAO-mode (disk-at-once)`**  şi nu cu viteză mai mare de 8X.` 


---

## burniso

Nu este nevoie de interfaţă grafică pentru a scrie un CD / DVD 

Probleme la scriere se întâmplă mai ales când se folosesc programe cu interfață grafică, fie și de ultimă generaţie (k3b), şi mai puţine cu programe mai vechi (growisofs, wodim ori cdrdao).

`siduction dispune de un script pentru arderea unei imagini ISO numit 'burniso'.` 

'burniso' arde imagini ISO pe medii ca CD/DVD, folosind metoda Disk-At-Once la o viteza de 8x, utilizând 'wodim'. Pentru aceasta:

~~~  
apt-get install siduction-scripts  
~~~

`Apoi ca utilizator $User:` 

~~~  
$ cd /dir/containing/your/ISO  
~~~

~~~  
$ burniso  
~~~

Toate imaginile ISO din directorul curent sunt listate și va începe arderea imediat după ce ați selectat una dintre ele, deci asigurați-vă că ați introdus un CD/DVD curat în CD/DVD writer.

<div class="divider" id="burn-no-gui-gen"></div>
## Aflu care unitate optică o voi folosi, ca $user:

în ce priveşte dispozitivele ATAPI putem afla cu :

wodim:

~~~  
$ wodim --devices  
wodim: Overview of accessible drives (2 found) :  
---------------------------------------------------------  
0 dev='/dev/scd0' rwrw-- : 'AOPEN' 'CD-RW CRW2440'  
1 dev='/dev/scd1' rwrw-- : '_NEC' 'DVD_RW ND-3540A'  
---------------------------------------------------------  
~~~

Altă variantă este:

~~~  
$ wodim dev=/dev/scd0 driveropts=help -checkdrive  
~~~

și

~~~  
$ wodim -prcap  
~~~

#### Iată câteva exemple folositoare :

##### Informaţii despre un blank CD/DVD:

~~~  
$ wodim dev=/dev/scd0 -atip  
~~~

sau

~~~  
$ cdrdao disk-info --device ATA:1,0,0  
~~~

sau , aşa cum s-a arătat mai sus:

~~~  
cdrdao disk-info --device ATA:1,0,0 )  
~~~

##### Ştergerea unui disc reinscriptibil :

~~~  
$ wodim -blank=fast -v dev=/dev/scd0  
~~~

sau

~~~  
$ cdrdao blank --device ATA:1,0,0 --blank-mode minimal  
~~~

##### Clonarea unui cd:

~~~  
$ cdrdao copy --fast-toc --device ATA:1,0,0 --buffers 256 -v2  
~~~

##### Clonarea unui cd `on the fly`:

~~~  
$ cdrdao copy --fast-toc --source-device ATA:1,1,0 --device ATA:1,0,0 --on-the-fly --buffers 256 --eject -v2  
~~~

##### Crearea unui CD audio din fişiere wav la viteza 12X :

~~~  
$ wodim -v -eject -pad -dao speed=12 dev=/dev/scd0 defpregap=0 -audio *.wav  
~~~

##### Scrierea unui CD din fişiere bin/cue :

~~~  
$ cdrdao write --speed 24 --device ATA:1,0,0 --eject filenam.cue  
~~~

##### Scrierea unei imagini ISO :

~~~  
$ wodim dev=/dev/scd0 driveropts=burnfree,noforcespeed fs=14M speed=10 -dao -eject -overburn -v something.iso  
~~~

Dacă primiți o eroare de genul `driveropts`  , este din cauză că opțiunea `burnfree`  este învechită pentru unele dispozitive, și se rezolvă astfel:

~~~  
$ wodim dev=/dev/scd0 driveropts=noforcespeed fs=14M speed=8 -dao -eject -overburn -v something.iso  
~~~

sau

~~~  
$ wodim dev=/dev/scd0 fs=14M speed=8 -dao -eject -overburn -v something.iso  
~~~

##### Crearea unei imagini ISO cu toate fişierele (şi subdirectoarele ) unui director .

Acesta poate fi scrisă cu comanda de mai sus (Scrierea unei imagini ISO):

~~~  
$ genisoimage -o myImage.iso -r -J -l directory  
~~~

Dacă există un inscriptor DVD , se poate deasemeni folosi `growisofs`  pentru scrierea pe DVD, ca şi scrierea unei imagini ISO pe DVD:

~~~  
$ growisofs -dvd-compat -Z /dev/dvd=image.iso  
~~~

##### Scrierea mai multor fişiere pe DVD:

~~~  
$ growisofs -Z /dev/dvd -R -J fișie1 fișie2 fișie3  
~~~

##### Dacă mai este spaţiu rămas pe DVD , se pot adăuga alte fişiere :

~~~  
$ growisofs -M /dev/dvd -R -J fișierX fișierY  
~~~

##### Pentru a încheia sesiunea se foloseşte :

~~~  
$ growisofs -M /dev/dvd=/dev/zero  
~~~

<div id="rev">Page last revised 30/11/2012 0144 UTC</div>
