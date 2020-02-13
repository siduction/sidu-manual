<div id="main-page"></div>
<div class="divider" id="raw-usb"></div>
## Instalare siduction ISO pe un dispozitiv USB stick, SSD card, shdc cu orice Sistem de Operare Linux, MS Windows(tm); sau Mac OS X(tm); 

N-are importanță ce SO folosești, cu următoarele metode veți putea instala un siduction ISO pe un dispozitiv USB stick, SSD card, shdc (Secure Digital High Capacity card).

Imaginea siduction ISO este scrisă pe dispozitiv dar, pentru că opțiunea  *'persist'*  nu este posibilă, veți avea doar un  *'siduction-on-a-stick'* . 

Dacă  *'persist'*  este necesară, atunci vă recomandăm să utilizați  *'install-usb-gui'*  (nu este subiectul acestui capitol) când este disponibil un sitem siduction.Pentru asta citiți  [Instalarea pe USB/SSD  *'fromiso'*  - siduction-on-a-stick](hd-install-opts-ro.htm#usb-from1) .

### Condiții necesare:

+ `Asigurați-vă că BIOS-ul PC-ului pe care vreți să-l boot-ați cu siduction-on-a-stick/card poate boot-a de pe USB stick-uri sau SSD card-uri. De obicei orice PC care are un USB 2.0 protocol poate boot-a de pe USB/SSD.`   
+ The USB/SSD should be recognised automatically and you should see the `F4`  opţiunea din meniu va spune `Hard Disk` , altfel apelaţi `F4 >Hard Drive`  sau adăugaţi`fromhd`  în linia de comandă de boot.  
+ **`Este important de ținut minte că, următoarele metode vor suprascrie și vor distruge orice tabelă de partiții de pe mediul de stocare ales. Datele pierdute vor depinde de mărimea siduction-*.iso. Nu sunt limitări în privința spațiului de stocare disponibil câtă vreme Linux-ul este implicat și vă veți putea recupera datele rămase pe care imaginea ISO nu le-a șters în timp ce se pare că MS Windows alocă și recunoaște doar o singură partiție. Așa că vă rugăm să nu faceți asta pe hard-ul vostru de 100+- gig!`**   

 [Linux](#raw-lin)  &nbsp; [MS Windows](#raw-ms)  &nbsp; &nbsp; [Mac OS X](#raw-mac)  

<div class="divider" id="raw-lin"></div>
### Linux 

Cuplați USB stick-ul sau card-reader-ul cu card-ul pe care vreți să scrieți și executați:

~~~  
cat /path/to/siduction-*.iso > /dev/USB_raw_device_node  
~~~

sau

~~~  
dd if=/path/to/siduction-*.iso of=/dev/sdf  
~~~

###### Examplu:

Cuplați dispozitivul, rulați `*'dmesg'*`  și uitați-vă la output:

~~~  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sdf: sdf1 sdf2  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Attached SCSI removable disk  
~~~

Presupunând că o imagine ISO numită `siduction-12.1.1-desperadoreloaded-kde-amd64-201206241901.iso`  a fost download-ată, puteți s-o redenumiți ca `siduction-desperadoreloaded-kde-amd64.iso` ), atunci comada de rulare va fi:

~~~  
cat /home/ nume_utilizator /siduction-desperadoreloaded-kde-amd64.iso > /dev/sdf  
~~~

sau

~~~  
dd if=/home/ nume_utilizator /siduction-desperadoreloaded-kde-amd64.iso of=/dev/sdf  
~~~

The USB/SSD should be recognised automatically and you should see the `F4`  menu option will say `Hard Disk` , otherwise invoke `F4 >Hard Drive`  or add `fromhd`  to the boot menu bootline.

<div class="divider" id="raw-ms"></div>
### MS Windows(tm); 

E rapid și simplu. Instalați un program numit  [*flashnul*](http://shounen.ru/soft/flashnul/) , ([de aici](http://shounen.ru/soft/flashnul/#download)).

Rețineți numele  *'flashnul'*  când îl extrageți și-l instalați deoarece poate arăta ca un dosar numit  *"flashnul-x.x"* , (de examplu,  *'flashnul-1rc1.zip'*  download-at, extras și instalat în Program Files are un dosar numit  *"flashnul-1rc1"* , care are înăuntru un alt dosar numit  *"flashnul-1rc1"* , care la rândul său conține programul  *'flashnul'*  și fișierele/dosarele asociate ce vor fi folosite în exemplul nostru.)

Cuplați stick/card-ul.

Dacă ați extras și instalat  *'flashnul'*  în Program Files dar nu sunteți sigur unde este mount-at USB stick-ul, analizați output-ul comenzii  *'flashnul -p'*  făcând click pe `run`  din menu, apoi tastând `cmd`  pentru a porni un terminal, apoi mutați-vă în directorul care conține toate fișierele individuale ale programului  *"flashnul"* , în cazul nostru:

~~~  
cd C:\Program Files\flashnul-1rc1\flashnul-1rc1\  
flashnul -p  
~~~

Output-ul ar trebui să arate cam așa:

~~~  
Available physical drives:  
0 size = 60022480896 (55 Gb))  
1 size = 2003828736 (1911 Mb)  
~~~

Presupunând o imagine ISO numită `siduction-12.1.1-desperadoreloaded-kde-amd64-201206241901.iso`  a fost download-ată, (o puteți redenumi în `siduction-desperadoreloaded-kde-amd64.iso` ), folosiți  *'cut'*  și  *'paste'* , (sau copiați-o), în dosarul  *"flashnul-1rc1"*  care conține toate fișierele/dosarele individuale ale programului.

Conform output-ului comenzii  *'flashnul -p'*  din examplul nostru, vedem că dispozitivul USB a fost mount-at în **`1`** , tipăriți următoarele apoi apăsați tasta 'enter', (s-ar putea să fie nevoie de drepturi de administrator):

~~~  
flashnul 1 -L siduction-desperadoreloaded-kde-amd64.iso  
~~~

Sub MS Win7 e nevoie să specificați actualele litere ale partițiilor (discurilor), de examplu discurile D: și c:\ :

~~~  
flashnul D: -L c:\flash\siduction-desperadoreloaded-kde-amd64.iso  
~~~

The USB/SSD should be recognised automatically and you should see the `F4`  menu option will say `Hard Disk` , otherwise invoke `F4 >Hard Drive`  or add `fromhd`  to the boot menu bootline.

<div class="divider" id="raw-mac"></div>
### Mac OS X(tm); 

Cuplați dispozitivul usb iar Mac OS X trebuie să-l mount-eze automat. În Terminal (îl găsiți în dosarul Applications &gt; Utilities), rulați:

~~~  
diskutil list  
~~~

Descoperiți cum se numește dispozitivul usb apoi  *'umount'*  partițiile de pe dispozitiv (să presupunem c-ar fi  */dev/disk1* ):

~~~  
diskutil unmountDisk /dev/disk1  
~~~

Presupunând că o imagine ISO numită `siduction-12.1.1-desperadoreloaded-kde-amd64-201206241901.iso`  a fost download-ată în `/Users/ *nume_utilizator* /Downloads/` , (puteți s-o redenumiți în `siduction-desperadoreloaded-kde-amd64.iso` ). Dacă dispozitivul USB este desemnat ca `disk1` , rulați:

~~~  
dd if=/Users/ nume_utilizator /Downloads/siduction-desperadoreloaded-kde-amd64.iso of=/dev/disk1  
~~~

The USB/SSD should be recognised automatically and you should see the `F4`  menu option will say `Hard Disk` , otherwise invoke `F4 >Hard Drive`  or add `fromhd`  to the boot menu bootline.

 <p>Device-urile USB/SSD sunt recunoscute automat şi apăsând <span
<div id="rev">Page last revised 04/12/2012 1540 UTC</div>
