<div id="main-page"></div>
<div class="divider" id="vmopts"></div>
## Mașini Virtuale - opțiuni

+  [KVM pentru Intel VT sau AMD-V](hd-install-vmopts-ro.htm#kvm)   
+  [Virtualbox](hd-install-vmopts-ro.htm#vbox)   
+  [QEMU](hd-install-vmopts-ro.htm#qemu)   
+  [Instalarea altor distributii într-o mașină virtuală](hd-install-vmopts-ro.htm#oos)   

`Următoarele exemple folosesc siduction, deci înlocuiți pur și simplu siduction cu numele distribuțieu dorite.` 

<div class="divider" id="oos"></div>
## Instalarea altor distribuții pe o imagine VM

Notă: Dacă și când doriți să instalați într-o mașină virtuală, majoritatea distribuțiilor vor avea nevoie doar de 12G spațiu alocat. Oricum dacă veți dori să instalați MS Windows, va trebui să alocați cam 30G sau mai mult. Spațiul alocat depinde totuși de cerințele voastre. 

În general, spațiul alocat unei imagini nu va utiliza și spațiu de pe HDD până nu vor fi instalate și datele. Chiar și atunci spațiul va vi ocupat dinamic pe măsură ce cantitatea de date crește pe imagine. Aceasta se realizează cu ratele de compresie ale  *qcow2* .

<div class="divider" id="kvm"></div>
## Activarea mașinii virtuale KVM

KVM este o soluție completă de virtualizare pentru Linux pe PC-uri x86 care au extensiile de virtualizare (Intel VT sau AMD-V).

### Precondiții

Pentru a descoperi dacă PC-ul vostru suportă KVM, asigurați-vă că acest KVM este  *enabled*  în BIOS (în unele cazuri, într-un sistem Intel VT sau AMD-V, s-ar putea să nu fie prea evident locul de unde se poate comuta, deci considerați că este activă extensia KVM).Modalitatea de verificare este prin executarea în consolă a comenzii:

~~~  
cat /proc/cpuinfo | egrep --color=always 'vmx|svm'  
~~~

Dacă vedeți `svm`  sau `vmx`  în câmpurile afișate despre procesor (cpu flags field), înseamnă că sistemul vostru suportă KVM. (Altfel, întoarceți-vă în BIOS, dacă voi credeți că este suportat și verificați din nou setările; puteți căuta și pe internet pentru a afla unde este ascunsă, în meniul BIOS-ului, opțiunea  *KVM 'enable'* ).

Dacă BIOS-ul vostru nu suportă KVM atunci apelați la  [Virtualbox](hd-install-vmopts-ro.htm#vbox)   
sau  [QEMU](hd-install-vmopts-ro.htm#qemu) 

Pentru a instala și rula KVM, asigurați-vă mai întâi că modulele Virtualbox nu sunt încărcate, (opțiunea  *--purge*  ar fi cea mai bună pentru dezintalarea lor), apoi, funcție de chipset-ul vostru:

Pentru `vmx` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-intel  
~~~

Pentru `svm` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-amd  
~~~

Când veți porni sistemul, script-urile qemu-kvm vor avea grijă să încarce modulele.

#### Utilizare KVM pentru a boot-a un siduction-*.iso

**`Ca utilizator:`** 

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom <siduction.iso>  
~~~

##### Instalarea unui siduction-*.iso într-o imagine KVM

Mai întâi creați o imagine de hard disk, (aceasta va avea o dimensiune minimală și va creste doar funcție de cerințe, datorită ratelor de compresie a lui  *qcow2* ):

~~~  
$ qemu-img create -f qcow2 siduction-VM.img 12G  
~~~

Boot-ați imaginea siduction-*.iso cu următorii parametrii pentru a permite lui KVM să recunoască că aceasta este o imagine QEMU de hard disk disponibilă:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom </path/to/siduction-*.iso> -boot d </path/to/siduction-VM.img>  
~~~

După ce ați boot-at de pe CD/DVD dați click pe icon-ul siduction installer pentru a porni installer-ul, (sau folosiți menniul), apoi click pe tab-ul Partitioning și lansați aplicația de partiționare preferată. Pentru partționare puteți urma instrucțiunile de la  [Partiționarea Hard Disk-ului - Tradițional, GPT și LVM](part-gparted-ro.htm)  (nu uitați să adăugați o partiție swap dacă dispuneți de memorie mică). Țineți cont că procesul durează deci aveți răbdare.

![gparted kvm hard disk naming](../images-common/images-vm/kvm-gparted02.png "gparted kvm hard disk naming") 


---

Aveți acum o VM gata de utilizare:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -drive if=virtio,boot=on,file=<path/to/siduction-VM.img>    
~~~
  
Unele sisteme nu suportă virtio, trebuinb deci să folosiți alte opțiuni la lansarea KVM, de exemplu:

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img> -cdrom your_other.iso -boot d  
~~~

sau

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img>  
~~~

Vedeți de asemenea și  [documentația KVM](http://www.linux-kvm.org/page/Main_Page) .

##### Administrarea mașinilor virtuale KVM instalate:

~~~  
apt-get install aqemu  
~~~

Când utilizați AQEMU asigurați-vă că ați ales modul KVM din menu-ul pentru  *'Emulator Type'*  din tab-ul  *'General'* . (Documentația pentru AQEMU este practic inexistentă, de aceea câteva  *"încercări prin eroare"*  vor fi necesare pentru a putea folosi GUI (interfața grafică); oricum, pentru început, alegeți menu-ul  *'VM'*  urmat de tab-ul  *'General'* .

<div class="divider" id="vbox"></div>
## Boot-area și instalarea în mașina virtuală VirtualBox

#### Etapele:

+ 1. creaţi o imagine de harddisk pentru VirtualBox  
+ 2. boot-aţi imaginea iso cu VirtualBox  
+ 3. instalaţi în imaginea de hard creată  

#### Cerinţe:

`RAM recomandat: 1 GB` Ideal 512 MB pentru client şi 512 MB pentru gazdă. Poate rula şi pe mai puţin, dar să nu aşteptaţi cine ştie ce performanţă !.

`Spaţiu pe Hard Disk:`  În timp ce VirtualBox este relativ mic (o instalare tipică va avea nevoie de aproximativ 30 MB spaţiu pe hard), maşina virtuală va necesita spaţiu uriaş pe disc pentru a reprezenta fişierele ce le va stoca. Aşa că, pentru instalarea MS Windows XP (TM), de exemplu, veţi avea nevoie de un fişier ce va creşte până la câţiva GB mărime. Pentru a avea siduction în VirtualBox va trebui să alocaţi 5 giga pentru imaginea de hard, plus spaţiu pentru swap.

### Instalarea VirtualBox:

~~~  
apt-get update  
apt-get install virtualbox virtualbox-dkms  
~~~

sau

~~~  
apt-get update  
apt-get install virtualbox-qt virtualbox-dkms  
~~~

pentru instalarea în KDE sau Razor-Qt 

### Instalarea siduction în maşina virtuală

Utilizaţi interfaţa de la virtualbox pentru a crea o maşină virtuală pentru siduction. Apoi urmaţi instrucţiunile unei instalări siduction obişnuite.

 [VirtualBox are un fişier Help PDF, pe care îl puteţi descărca de aici](http://www.virtualbox.org/)  

<div class="divider" id="qemu"></div>
## Boot-area și instalarea în mașina virtuală QEMU

+ 1. creaţi o imagine de Hard Disk pentru qemu  
+ 2. porniţi de pe imaginea ISO cu qemu  
+ 3. instalaţi în imaginea de Hard Disk  

O unealtă QT GUI este disponibilă pentru a vă ajuta să configurați QEMU:

~~~  
apt-get install qtemu  
~~~

#### Crearea imaginii de Hard Disk

Pentru a rula qemu aveţi nevoie de o imagine de Hard Disk. Acesta este un fişier unde este stocat conţinutul Hard Disk-ului emulat.

Folosiţi comanda:

~~~  
qemu-img create -f qcow siduction.qcow 3G  
~~~

pentru a crea fişierul imagine numit "siduction.qcow". Parametrul "3G" specifică mărimea fişierului de pe disc - în acest caz 3 GB. Se poate folosi sufixul M pentru megabytes (de exemplu "256M"). Nu trebuie să vă îngrijoraţi prea tare în legătură cu mărimea discului - formatul qcow compresează imaginea în aşa fel încât spaţiul gol nu se adaugă la mărimea fişierului.

#### Instalarea sistemului de operare

Acum este prima oară când va trebui să porniţi emulatorul. `Un lucru să tineţi minte: odată ce aţi dat un clic în fereastra de qemu săgeata mouse-ului va fi acaparată. Pentru a o elibera trebuie să apăsaţi:` 

~~~  
Ctrl+Alt.  
~~~

Dacă va trebui să folosiţi o dischetă de boot, rulaţi QEMU cu:

~~~  
qemu -floppy siduction.iso -net nic -net user -m 512 -boot d siduction.qcow  
~~~

Dacă CD-ROM-ul este bootabil, rulaţi Qemu cu:

~~~  
qemu -cdrom siduction.iso -net nic -net user -m 512 -boot d siduction.qcow  
~~~

Acum instalaţi siduction ca şi cum l-aţi instala pe un Hard Disk real.

#### Pornirea sistemului

Pentru a porni sistemul trebuie doar să tastaţi:

~~~  
qemu [hd_image]  
~~~

O idee bună este să folosiţi imagini suprapuse. În felul acesta veţi crea imaginea de Hard Disk o dată și veţi instrui QEMU să scrie schimbările într-un fişier extern. Veţi scăpa astfel de instabilitate, pentru că puteţi uşor reveni la o stare iniţială a sistemului.

Pentru a crea o imagine suprapusă tipăriţi:

~~~  
qemu-img create -b [[base''image]] -f qcow [[overlay''image]]  
~~~

Substituirea imaginii de bază de pe Hard Disk (în cazul nostru siduction.qcow). După aceasta puteţi rula qemu cu:

~~~  
qemu [overlay_image]  
~~~

Imaginea originală va fi lăsată intactă. Un pont: imaginea de bază nu poate fi redenumită sau mutată, imaginea suprapusă totdeauna îşi va aminti calea către imaginea de bază.

#### Folosirea oricărei partiţii reale ca unică partiţie primară a unei imagini de Hard Disk

Uneori, veţi dori să folosiţi una din partiţiile sistemului şi din interiorul qemu (de exemplu, dacă vei vrea să porneşti şi sistemul real şi qemu folosind o anumită partiţie ca  *root* ).Poţi face acest lucru folosind software RAID în linear mode (ai nevoie de driver-ul de kernel  *linear.ko* ) şi un dispozitiv virtual (loopback device): trucul este să ataşezi dinamic un master boot record (MBR) partiţiei reale pe care vrei să o incluzi în imaginea de disc qemu.

Să presupunem că aveţi o partiţie ne-mount-ată, cu ceva fişiere pe ea, /dev/sdaN, pe care vreţi să o faceţi parte a imaginii de disc qemu. Mai întâi trebuie să creaţi un mic fişier care să conţină MBR:

~~~  
dd if=/dev/zero of=/path/to/mbr count=32  
~~~

Aici este creat un fişier de 16 KB (32 * 512 bytes). Este important să nu fie făcut prea mic (chiar dacă MBR are nevoie doar de un singur block de 512 bytes), căci cu cât va fi mai mic cu atât mai mică va trebui să fie şi informaţia despre dispozitivul RAID ceea ce va avea impact asupra performanţei. Apoi, veţi seta un dispozitiv virtual în fişierul MBR:

~~~  
losetup -f /path/to/mbr  
~~~

Să presupunem că dispozitivul rezultat este /dev/loop0.Pentru că noi nu am folosit încă alte dispozitive virtuale, următorul pas este să creăm imaginea de disc comună MBR+/dev/sdaN folosind software RAID:

~~~  
modprobe linear  
mdadm --build --verbose /dev/md0 --chunk=16 --level=linear --raid-devices=2 /dev/loop0 /dev/sdaN  
~~~

Rezultatul, /dev/md0, este ceea ce vom folosi ca imagine de disc qemu (nu uitaţi să setaţi permisiunile în aşa fel încât să poată fi accesată de emulator). Ultimul pas (şi cumva înşelător) este să setați configuraţia discului (geometria discului şi tabela de partiţii) în aşa fel încât punctul de pornire din partiţia primară din MBR să se potrivească cu cel din /dev/sdaN din interiorul /dev/md0 (un offset de exact 16 * 512 = 16384 bytes în acest exemplu). Faceţi acest lucru folosind  *'fdisk'*  de pe computerul gazdă, nu în emulator, din cauză că rutina de detectie implicită din qemu de multe ori dă rezultate offset cu zecimale care nu se pot rotunji la Kilobytes (cum ar fi 31.5 KB ca în secțiunea precedentă) iar acestea nu pot fi interpretate de codul software RAID. De acolo, de pe computerul gazdă:

~~~  
fdisk /dev/md0  
~~~

Creaţi o singură partiţie primară corespunzătoare /dev/sdaN și jucaţi-vă cu comanda 's'ector din meniul 'x'pert până când primul cilindru (de unde începe prima partiţie), se potriveşte cu mărimea din MBR. La sfârşit folosiţi 'w'rite pentru a scrie rezultatul în fişier. Asta e tot!. Aveţi acum o partiţie pe care o puteţi mount-a şi de pe computerul gazdă şi care este parte a imaginii de disc qemu:

~~~  
qemu -hdc /dev/md0 [...]  
~~~

Puteţi, bineînţeles, seta orice bootloader pe imaginea de disc folosind qemu presupunând că partiţia originală /boot/sdaN conţine uneltele necesare.

<!--#### Folosirea Modulului Accelerator QEMU

Programatorii de qemu au creat un modul de kernel optional care accelerează qemu pană aproape a lucra în timp real. Acesta trebuie încărcat cu opţiunea:

~~~  
major=0  
~~~

pentru a crea automat dispozitivul /dev/kqemu cerut.Următoarea comandă

~~~  
echo "options kqemu major=0" >> /etc/modprobe.conf  
~~~

va schimba  *modprobe.conf*  pentru a se asigura că optiunea din modul va fi adăugată de fiecare dată când modulul este încărcat.

~~~  
qemu [...] -kernel-kqemu  
~~~

Aceasta va realiza virtualizarea completă care va îmbunătăţi considerabil viteza.

#### Pentru a activa qemu:

~~~  
qemu -cdrom /tmp/pkg/siduction-debug.iso -net nic -net user -m 512  
-->  
~~~

 [Documentaţia Oficială a Proiectului QEMU](http://www.nongnu.org/qemu/user-doc.html)  

 [Anumit conţinut din manualul siduction despre QEMU a fost transpus pe această pagină sub GNU Free Documentation License 1.2 şi modificat pentru manualul siduction](http://wiki.archlinux.org/index.php/Qemu)  

<div id="rev">Page last revised 30/11/2012 0200 UTC</div>
