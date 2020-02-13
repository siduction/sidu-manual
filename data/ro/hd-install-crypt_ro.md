<div id="main-page"></div>
<div class="divider" id="install-crypt"></div>
## Instalarea pe partiții criptate -  *cryptroot* 

**`IMPORTANT: Există niște probleme în folosirea acestui ghid pentru partiții sau date criptate. Iată câteva:`**  

+ Aplicabil pentru siduction-2011.1-onestepbeyond.iso sau mai nou.  
+ Este doar un ghid care-și propune să vă ofere un început. Rămâne în sarcina voastră să învățați mai multe despre  *LUKS* ,  *cryptsetup*  și  *encryption* . Surse și resurse de informare ce vă pot fi de folos le găsiți la sfârșitul acestei pagini; oricum lista este totuși sumară.  
+  *cryptsetup*  nu poate cripta o partiție deja existentă, deci va trebui să crați o nouă partiție, să o setați cu  *cryptsetup*  și apoi să vă mutați datele pe ea.  
+ Puteți folosi fișiere-cheie (key files) și să aveți mai multe astfel de chei pentru date, (până la 8, inclusiv ștergerea cheilor) dar acest subiect este în afara scopului acestui ghid.  
+ `Să nu uitați parolele și frazele-cheie (passphrases) pentru că veți pierde accesul la toate datele voastre! Nici măcar  *chroot*  fără a ști frazele-cheie (passphrases) nu vă poate fi de nici un ajutor cu excepția fișierului /boot.`   
+ La începutul procesului de boot-are veți fi întrebați de fraza-cheie (passphrases) pentru device-ul criptat și apoi sistemul va boot-a așa cum trebuie.  

### Exemple de criptare:

+  [Utilizarea criptării în grupurile LVM](hd-install-crypt-ro.htm#lvm) .  
+  [Note pentru criptare cu metodele tradiționale de partiționare](hd-install-crypt-ro.htm#simple) .  

<div class="divider" id="lvm"></div>
## Criptarea în cadrul grupurilor LVM

<span class= "highlight-3">Acest exemplu folosește criptarea în interiorul volumelor LVM dându-vă posibilitatea de a împărți <i>home</i>-ul vostru din <span class= "highlight-2"> / </span> și de a avea o partiție  *swap*  fără nevoia mai mulor parole; este aplicabil începând cu  *siduction-2011.1-onestepbeyond.iso*  sau ulterior.</span>

Înaintea rulării programului de instalare trebuie să pregătiți sistemul de fișiere ce urmează a fi folosit pentru instalare. Un ghid sumar al partiționării LVM îl gasiți la  [Partiționarea LVM - Logical Volume Manager](part-lvm-ro.htm#part=lvm) . 

Veți avea nevoie să creați cel putin un sistem de fișiere necriptat <span class= "highlight-3">/boot </span> și un sistem de fișiere criptat <span class= "highlight-2"> / </span>. De asemenea creați și un sistem de fișiere criptat <span class= "highlight-3">/home și swap</span> . 

1. Dacă nu intenționați să folosiți un grup LVM existent atunci creați unul normal (lvm volume group). În acest exemplu considerăm că grupul se numește <span class= "highlight-3">vg</span> pentru a ține boot-area și datele criptate.  
2. Veți avea nevoie de un volum logic pentru /boot și datele criptate deci folosiți <span class= "highlight-3">lvcreate</span> pentru a crea volumele logice în grupul <span class= "highlight-3">vg</span> cu dimensiunile dorite de voi:  
   ~~~    
   lvcreate -n boot --size 250m vg    
   lvcreate -n crypt --size 300g vg    
   ~~~
  
   Aici ați numit volumele logice  *boot*  și  *crypt*  cu dimensiunile de 250Mb și respectiv 300Gb.  
3. Creați sistemul de fișiere <span class= "highlight-3">/boot</span> pentru a fi disponibil programului de instalare:  
   ~~~    
   mkfs.ext4 /dev/mapper/vg-boot    
   ~~~
  
4. Utilizați <span class= "highlight-3">cryptsetup</span> pentru criptarea <span class= "highlight-3">vg-crypt</span> folosind opțiunea cea mai rapidă  *xts*  cu cea mai puternică lungime a cheii de 512bit și apoi deschideți-l. Acesta vă va întreba de două ori parola pentru a o seta și a treia oară pentru al deschide. Deschideți-l aici în timpul opțiunii de boot-are criptată cu numele  *cryptroot* :  
   ~~~    
   cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/mapper/vg-crypt    
   ~~~
  
   ~~~    
   cryptsetup luksOpen /dev/mapper/vg-crypt cryptroot    
   ~~~
  
5. Acum folosiți lvm înăuntrul dispozitivului criptat pentru a crea un al doilea grup ce va fi folosit pentru dispozitivele <span class= "highlight-3">/swap</span> și <span class= "highlight-3">/home</span>. <span class= "highlight-3">pvcreate</span> <i>cryptroot</i> pentru al face volum fizic și al folosi cu <span class= "highlight-3">vgcreate</span> pentru a crea un alt grup numit <span class= "highlight-3">cryptvg</span>:  
   ~~~    
   pvcreate /dev/mapper/cryptroot    
   vgcreate cryptvg /dev/mapper/cryptroot    
   ~~~
  
6. Apoi utilizați <span class= "highlight-3">lvcreate</span> cu nou creatul grup criptat <span class= "highlight-3">cryptvg</span> pentru a crea volumele logice <span class= "highlight-2"> / </span>, <span class= "highlight-3">/swap</span> și <span class= "highlight-3">/home </span> cu dimensiunile dorite:  
   ~~~    
   lvcreate -n swap --size 2g cryptvg    
   lvcreate -n root --size 40g cryptvg    
   lvcreate -n home --size 80g cryptvg    
   ~~~
  
   Aici ați numit volumele logice  *swap* ,  *root*  și  *home*  cu dimensiunile de 2Gb, 40Gb și 80Gb.  
7. Creați sistemele de fișiere pentru  *cryptvg-swap* ,  *cryptvg-root*  și  *cryptvg-home*  pentru a fi disponibile programului de instalare:  
   ~~~    
   mkswap /dev/mapper/cryptvg-swap    
   mkfs.ext4 /dev/mapper/cryptvg-root    
   mkfs.ext4 /dev/mapper/cryptvg-home    
   ~~~
  
8.  **Acum sunteți pregătiți să rulați programul de instalare unde va trebui să folosiți:**   
   <span class= "highlight-3">vg-boot</span> pentru <span class= "highlight-3">/boot</span>,  
   <span class= "highlight-3">cryptvg-root</span> pentru <span class= "highlight-2"> /</span>,  
   <span class= "highlight-3">cryptvg-home</span> pentru <span class= "highlight-3">/home</span>, și  
   <span class= "highlight-3">cryptvg-swap</span> pentru <span class= "highlight-3">swap</span> ar trebui să fie recunoscută automat.  

Sistemul instalat ar trebui să se termine cu o linie de comandă a kernel-ului incluzând următoarele opțiuni:

~~~  
root=/dev/mapper/cryptvg-root cryptopts=source=/dev/mapper/vg-crypt,target=cryptroot,lvm=cryptvg-root  
~~~

Aveți acum  *crypt*  și  *boot*  sub grupul lvm  *vg*  iar  *root* ,  *home*  și  *swap*  sub grupul lvm  *vgcrypt*  care se află pe dispozitivul vostru criptat și protejat de parolă.

<span class= "highlight-3">Reţineţi:</span> Daca reinstalaţti pe un volum lvm criptat înainte, instaler-ul trebuie să fie informat de prezenţa acestui volum:

~~~  
cryptsetup luksOpen /dev/mapper/cryptvg-root cryptvg  
vgchange -a y  
~~~

<div class="divider" id="simple"></div>
## Indicații de criptare cu metodele tradiționale de partiționare

În primul rând trebuie să decideți cum vreți să arate disk-ul. Veți avea nevoie de minim 2 partiții, o partiție normală pentru `/boot`  și una pentru datele criptate. 

Presupunând că aveți nevoie de  *swap*  (care va fi și ea criptată) veți crea o a treia partiție pentru care va trebui să introduceți o parolă separată pe timpul boot-ării (deci vi se vor cere două parole). 

Este posibil să folosiți chei pentru  *swap* -ul din cadrul sistemului criptat partiționat tradițional dar nu veți putea utiliza opțiunea  *suspend to disk* . Din această cauză, pentru o utilizare pe termen lung, este mai bine să folosiți sistemul LVM cu criptare completă a partițiilor și a cheilor.

<!--It is possible to use keys for the swap from inside the encrypted system with traditional partitioning, however you will not be able to suspend to disk. Due to these issues, LVM volumes with fully encrypted partitions with keys is definitely the better option in the long term.

-->
###### Condiții esențiale:

+  Sunt doar 3 partiții pe acest disk:  
   `/boot` , de 250mb  
   `swap` , de 2 gig  
   **`/`**  și `/home`  combinate (de examplu, balanța).  
+ 2 fraze-cheie (passphrases) vor fi cerute, 1 pentru  *swap*  și cealaltă pentru **`/`**  și `/home`  combinate.  

Acum, având partiționarea făcută, acum trebuie să pregătiți partițiile criptate pentru a fi recunoscute de programul de instalare.

Dacă ați folosit pentru partitionare un program cu interfață grafică, închideți-l și deschideti un terminal, deoarece comenzile de criptare trebuie date dintr-o linie de comandă.

##### Partiția /boot

Formatați partiția `/boot`  în ext4, dacă nu ați făcut-o deja:

~~~  
/sbin/mkfs.ext4 /dev/sda1  
~~~

##### Criptați partiția swap

Pentru `swap-ul criptat`  trebuie mai întâi s-o formatați și s-o deschideți, `/dev/sda2` , ca un dispozitiv criptat, precum dispozitivul  *vg-crypt*  de mai sus dar sub numele de  *swap* .


cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda2  
</li>  
~~~

~~~  
cryptsetup luksOpen /dev/sda2 swap  
</li>  
~~~

~~~  
echo "swap UUID=$(blkid -o value -s UUID /dev/sda2) none luks" >> /etc/crypttab  
</li>  
~~~

</ol>
Formatați partiția `/dev/mapper/swap`  creată ca ea să fie recunoscută de installer:

~~~  
/sbin/mkswap /dev/mapper/swap  
~~~

##### Criptarea partiției / 

Pentru `/-ul criptat`  trebuie mai întâi s-o formatați și s-o deschideți, `/dev/sda3` , ca un dispozitiv criptat, precum dispozitivul  *vg-crypt*  de mai sus.

~~~  
cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda3  
~~~

~~~  
cryptsetup luksOpen /dev/sda3 cryptroot  
~~~

Formatați `/dev/mapper/cryptroot`  nou creat astfel apărând în programul de instalare:

~~~  
/sbin/mkfs.ext4 /dev/mapper/cryptroot  
~~~

### Deschideți programul de instalare

 **Acum sunteți pregătiți să rulați programul de instalare unde trebuie să folosiți:**   
<span class= "highlight-3">sda1</span> pentru <span class= "highlight-3">/boot</span>,  
<span class= "highlight-3">cryptroot</span> pentru <span class= "highlight-2"> / </span> și <span class= "highlight-3"> /home</span>  
<span class= "highlight-3">swap</span> trebuie să fie recunoscută automat.

Sistemul instalat ar trebui să se termine cu o linie de comandă a kernel-ului incluzând următoarele opțiuni (totuși va fi folosită notația voastră UUID):

~~~  
root=/dev/mapper/cryptroot cryptopts=source=UUID=12345678-1234-1234-1234-1234567890AB,target=cryptroot  
~~~

Acum aveți partiția normală  */boot* , o partiție criptată  *swap*  protejată prin parolă împreună cu partițiile criptate  *root*  și  */home* .

### Bibliografie suplimentară:

Trebuie să mai citiți:

~~~  
man cryptsetup  
~~~

 [LUKS](http://code.google.com/p/cryptsetup/) .

 [Redhat](http://www.redhat.com/)  și  [Fedora](http://www.redhat.com/Fedora/) .

 [Protect Your Stuff With Encrypted Linux Partitions](http://www.enterprisenetworkingplanet.com/netsecur/article.php/3683011) .

 [KVM how to use encrypted images](http://blog.bodhizazen.net/linux/kvm-how-to-use-encrypted-images/) .

 [siduction wiki](http://siduction.org/index.php?module=wikula&amp;tag=FullDiskEncryptionTheDebianWay) .

<div id="rev">Page last revised 04/12/2012 1300 UTC</div>
