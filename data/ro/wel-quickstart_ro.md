<div id="main-page"></div>
<div class="divider" id="welcome-quick"></div>
## Ghid de pornire rapidă a SO  *siduction*  (Quick Start Guide)

###### **`FOARTE IMPORTANT:`** ` *siduction* , ca LIVE-CD, este bazat pe o tehnologie de înaltă compresie, şi din această cauză este nevoie de o grijă deosebită când se scrie o imagine ISO. Folosiţi doar CD-uri sau DVD-uri de bună calitate pe care să le scrieţi doar în **`DAO-mode (disk-at-once)`**  şi nu cu viteză mai mare de 8X.` 

 *siduction*  dorește să fie 100% compatibil cu Debian sid dar, uneori,  *siduction*  poate furniza reparații urgete (hot-fixes) cu caracter temporar. Locațiile  *siduction*  (apt-repository) dețin pachetele specifice distribuției inclusiv kernel-ul  *siduction* , script-uri, unelte și documentație.

### Documentație ce trebuie citită

`Sunt multe pagini de manual pe care un utilizator "nou în linux" sau "nou în siduction" ar trebui să le citească. Aceasta este una dintre ele. Alte pagini ar fi:` 

+  [Terminalul](term-konsole-ro.htm#term-kon)  - Descrie cum să folosiți un terminal și utilizarea comenzii  *'sux'* .  
+  [Partiționarea](part-gparted-ro.htm#partition)  - Descrie cum să vă partiționați disk-ul.   
+  [Instalarea siduction (HD)](hd-install-ro.htm#install-prep)  - Descrie cum să-l instalați pe un hard-disk.  
+  [Instalarea siduction (USB)](hd-install-opts-ro.htm#usb-hd)  - Descrie cum să-l instalați pe un USB-stick/SD/flash-card.  
+  [Scrierea siduction pe stick-uri](hd-ins-opts-oos-ro.htm#usb-hd#raw-usb)  - Descrie cum să-l scrieți pe un stick sau pe un SD/flash-card în loc de a-l scrie pe CD/DVD.  
+  [Drivere proprietare (non free) și liste-sursă](nf-firm-ro.htm)  - Descrie cum să vă configurați sursele și cum să instalați firmware non-free.  
+  [Conectarea la internet](inet-ceni-ro.htm#netcardconfig)  - Descrie cum să vă conectați la internet.  
+  [*Apt*  și  *dist-upgrad* -area](sys-admin-apt-ro.htm#apt-cook)  - Descrie cum să instalați programe noi și cum să procedați în cazul unei actualizări a distribuției (dist-upgrade).  

##### Debian sid/stabilitate instabilă

'sid' este un ecuson pentru depozitele instabile ale lui Debian. Debian sid este un depozit de pachete adus la zi în mod frecvent, care se sincronizează rapid cu versiunile de software cele mai recente şi cele mai bune. Datorită frecvenţei de actualizare, testările generale ale pachetelor sunt posibile mai rar, pentru o perioadă scurtă de timp, până la apariţia ultimelor noutăţi şi sunt distribuite ca pachete Debian. 

#### kernel-ul  *siduction* 

Kernel-ul  *siduction*  este optimizat ca să ajute la înlăturarea bug-urilor, adaugă functionalităţi noi, este configurat pentru o performanţă superioară şi o stabilitate sporită şi îmbunătăţită a ultimului kernel din [http://www.kernel.org/.](http://www.kernel.org/) . 

Kernel-ul este sincronizat de aici:  [Cum să aduci kernel-ul la zi](sys-admin-kern-upg-ro.htm#kern-upgrade) 

#### Administrarea pachetelor

 *siduction*  utilizează sistemul Debian de pachete și foloseste  *'apt'*  și  *'dpkg'*  pentru administrarea pachetelor software de la debian și alte repositorii identificate în fișierele din `*/etc/sources.list.d/**` 

Debian sid are peste 30.000 de pachete, deci puteţi să-l gasiţi pe acela pe care doriţi să-l folosiţi cu  [Cautarea de pachete cu  *apt-cache*](sys-admin-apt-ro.htm#apt-cache)  sau cu  [Debian Package Search GUI application](sys-admin-apt-ro.htm#gui-pacsea) .

Ca să instalaţi pachetul `*apt-get install <numele_pachetului >*`   [Instalarea unui pachet nou.](sys-admin-apt-ro.htm#apt-install) 

 Depozitele lui Debian sid sunt aduse la zi de patru ori pe zi ceea ce înseamnă că lista de pachete la dispoziţie şi versiunile lor se demodează foarte rapid.Executarea `*apt-get update*`  este esenţială înainte de instalarea unui pachet nou sau înainte de a rula *apt-get dist-upgrade*  ca să vă menţineţi la zi cu lista de pachete ale server-ului.

###### Utilizarea repositoriului altor distribuții bazate pe Debian, surse și RPM-uri

 ***`Nu oferim asistenţă la instalarea pachetelor din codul sursă.`***  Dacă chiar aveţi nevoie să compilaţi aplicaţia, efectuați-o ca user şi puneţi-o într-un dosar din  */home/nume_utilizator/*  fără s-o instalaţi în sistem. **`Nu oferim asistenţă la folosirea de  *checkinstall*`**  sau la **`convertirea pachetelor RPM cu  *'alien'* .`** 

Alte distribuții bazate pe Debian, mai mult sau mai puțin cunoscute, care re-împachetează programe Debian pentru uzul lor în propriile repositoriuri, folosesc adesea versiuni diferite ale locaţiilor dosarelor pentru aplicaţii, lucru ce ar putea cauza instabilitatea sistemului şi unele pachete nu se vor putea instala, datorită unor dependenţe de nerezolvat, a metodelor de denumire diferite ale pachetelor sau a versiunilor numerice diferite. De exemplu chiar doar o versiune diferită de  *'glibc'*  poate împiedica rularea aplicației.

Folosiți repositoriile Debian pentru a instala programele cerute deoarece, pentru alte repositoriuri nu vă oferim suport.

#### Actualizarea sistemului - dist-upgrade

`*apt-get dist-upgrade*`  este metoda recomandată de actualizare în  *siduction* . Nu este recomandată folosirea niciunui alt program grafic de actualizare în  *siduction* .  [Actualizarea unui sistem instalat - dist-upgrade](sys-admin-apt-ro.htm#apt-upgrade) 

Recomandăm folosirea  *'dist-upgrade'*  numai în afara mediului X. Lansarea  *'init 3'*  din managerul de ferestre (KDE, XFCE, etc) sau într-un terminal virtual (ctrl+alt+f1, ctrl+alt+f2, etc) va împiedica rularea mediului X şi nu va permite o actualizare în condiţii de siguranţă.

#### Configurația de Network 

`Ceni` este o unealtă de configurare rapidă a legăturii la rețea (network) chiar și cu cartela wireless fără prea mult efort. Functiunea wireless poate să scaneze alte retele, să folosească wep și wpa pentru încriptări și să folosească uneltele wireless sau wpa_supplicant pentru configurarea wireless. Ethernet este clar dacă folosiți dhcp (automatic ip address assigning) sau puteti seta manual de la netmasks la nameservers. 

Ceni este rulat cu comanda`*Ceni*`  sau `*ceni*` . Dacă nu este instalat, îl puteți instala cu comanda  *'apt-get install ceni'* . 

 [Conectarea online - Ceni](inet-ceni-ro.htm#netcardconfig) 

#### Nivele de rulare - init

nivelele de rulare  *siduction*  sunt diferite de Debian, vezi:  [siduction runlevels - init](sys-admin-gen-ro.htm#init) 

##### Alte managere de ferestre (Window Managers)

KDE, XFCE şi fluxbox sunt suportate de siduction. Gnome is not supported by siduction to date. Unii utilizatori din forumul siduction /wiki şi IRC chat s-ar putea să fi avut ceva experienţe şi ar putea să vă ajute. Altfel, vă descurcaţi singuri.

#### IRC și ajutor în Forum

Să nu vă fie frică să cereti ajutor prin IRC sau pe forum:

+  [Unde să găsești ajutor](help-ro.htm#help-gen)    
+  [Web IRC](http://thegrebs.com/oftc/)  scrieţi pseudonime şi aliniaţi-vă la forumul #siduction  

<div id="rev">Page last revised 05/12/2010 0725 UTC</div>
