<div id="main-page"></div>
<!--[if lt IE 10]><div class="center warning-box data">Atenţie :: Versiunea dumneavoastră de Internet Explorer&#8482; nu este recunoscută , vă rugăm instalaţi  [Firefox de la Mozilla Corp&#8482;](http://mozilla.com/)  pentru Windows&#8482;. Distorsiunile din meniu sunt rezultatul utilizării unui browser ca MSIE 5 or 6.</div><![endif]-->
<div class="divider" id="welcome-gen"></div>
## Bine aţi venit!Manualul Sistemului de Operare  *siduction* 

Numele  *siduction*  reprezintă un joc de cuvinte, între cuvântul `sid`  și `seducţie` , primul cuvânt fiind `sid`   
și înseamnă  *numele de cod al secțiunii instabile al distribuției Debian.* 

 *siduction*  este un sistem de operare bazat pe  [kernel-ul Linux](http://www.kernel.org/)  și pe  [Proiectul GNU](http://www.gnu.org/) , cu aplicații/programe ale  [Debian](http://www.debian.org/)  *instabile/sid*  care respectă principiile de bază ale  [contractului social](http://www.debian.org/social_contract)  al lui Debian.

Nu mai aveți nevoie să așteptați apariția unei noi versiuni  *siduction*  pentru a avea în permanență ultimele noutăți ale oricărui program, inclusiv kernel-urile. Odată ce ai instalat  *siduction* , urmat de toate programele/aplicațiile preferate, trebuie doar să folosiți  [dist-upgrade](sys-admin-apt-ro.htm#apt-upgrade) , care va aduce la zi întregul sistem cu pachetele de la debian și pachetele specializate de la  *siduction* .

Asta înseamnă că nu mai este necesară reinstalarea sistemului odată cu fiecare nouă versiune de  *siduction*  la fiecare 3~6 luni, câtă vreme zilnic, săptămânal sau lunar programul  [dist-upgrade](sys-admin-apt-ro.htm#apt-upgrade)  aduce totul la zi.

Este de remarcat că, așa cum  *siduction*  folosește secțiunea instabilă a pachetelor Debian (normal pentru 'Sid'), va trebui să vă împăcăți cu gândul că veți folosi și  [Terminalul/cli](term-konsole-ro.htm)  (linia de comandă).

Urmând 'calea  *siduction* ', veți fi în permanență la zi cu tot ce este mai bun din ce poate oferi  *siduction*  împreună cu Debian 'sid'.

<div class="divider" id="how-to"></div>
## Cum să folosiţi acest manual

`Acest manual este o referință pentru învățarea inițială și de asemeni pentru a reîmprospăta cunoștiințele despre sistemul de operare  *siduction* , nu numai la elementele de bază, ci și pentru a îmbrățișa multitudinea de subiecte complexe și vă va ajuta la administrarea sistemului  *siduction* .` 

<div class="divider" id="man-gen"></div>
##### General

Acest manual este împărţit în secţiuni, de exemplu, un subiect ce are legătură cu partiţionarea va fi găsit în Partiţionare Hard Discului, iar subiecte legate de Internet/WIFI sunt grupate în Internet şi Networking. Sunt şi subiecte care nu pot fi corelate unei categorii sau au un statut de sine stătător. 

Pentru asistență a unui program specific sau a unei aplicații (denumit(a) `pachet` ) care a venit pre-instalat sau pe care l-ați instalat dvs.,consultați forumul website-ului privitor la pachete de asistență, FAQ-uri și manualele "on line" și/sau meniul de asistență din cadrul acelui pachet, ca să vă ghideze către orice program/aplicație dată.

Majoritatea programelor/aplicațiilor bune au și un ghid de utilizare accesibil în terminal via <span class="highlight-3">man</span> . De asemeni verificați dacă documentația este în `/usr/share/doc/<pachet>` .

 [Vă rugăm , dacă aveți ceva timp liber la dispoziție, să citiți Ghidul de pornire rapidă (Quick Start Guide)](wel-quickstart-ro.htm#welcome-quick) 

 Ca în orice documentaţie nou apărută este posibil să existe erori/greşeli/greşeli de tipărire fapt pentru care vă rugăm să ne iertaţi ( în ce priveşte greşelile de tipărire putem să trecem mai uşor peste ).

Pe măsură ce volumul de muncă va creşte , mai multă documentaţie va fi adăugată iar noi, cei de la  *siduction*  , suntem siguri că aceasta se va dovedi a fi o sursă de informaţie valoroasă pentru dumneavoastră şi vă mulţumim că sunteţi alături de  *siduction* . 

##### Printarea paginilor ce vă interesează din manual

Scoatere la imprimantă a paginilor ca 'portrait' nu permite ca o căsuţă de cod ce depăşeste marginile fizice ale ecranului să fie tipărită , (pagina web a manulalului nu are această problemă din cauză că poate face scroll lateral). 

În timp ce aceasta nu este o problemă pentru o pagina web obişnuită , de exemplu , o pagină web media , reprezintă o problemă critică pentru orice distribuţie de linux unde o singură linie de cod poate avea până la 120 caractere , ceea ce este mult mai mare decât poate cuprinde o pagină obişnuită A4 portrait la 12 pt.

De aceea ajustaţi preferinţele printării ca `landscape .` .

##### Copyright

Întreg conţinutul este © 2006-2012 şi distribuit sub licenţa liberă  [GNU Free Documentation License](http://www.gnu.org/licenses/fdl.txt) . Aveţi permisiunea să copiaţi , distribuiţi , şi/sau să modificaţi acest document atâta vreme cât respectaţi versiunea 1.2 sau oricare versiune ulterioară a GNU Free Documentation License, publicată de Free Software Foundation; fără Invariant Sections , fără Front-Cover Texts , şi fără Back-Cover Texts.

E&amp;OE

## Notificare legală

Acest software este experimental. Folosiţi-l pe propriul risc. Proiectul  *siduction* , dezvoltatorii săi şi membrii echipei nu pot fi făcuţi vinovaţi în nici o circumstanţă pentru deteriorarea de hardware sau software, pierderea datelor sau orice altă distrugere directă sau indirectă cauzată de utilizarea acestui soft. Dacă nu sunteţi de acord cu aceşti termeni şi condiţii, nu vă este permis să utilizaţi sau să redistribuiţi acest software.

<div class="divider" id="table-contents"><!-- MenuIndex starts here ro lang maintainer Dorin--></div>
## Index

Dacă bara de navigare şi/ sau submeniurile nu apar în totalitate corect vă rugăm asiguraţi-vă că dimensiunea fontului nu este setată mai mare de 12 în firefox, ideal ar fi 10. `Utilizatorii de netbook ar putea avea nevoie să facă Zoom Out (Ctrl+-) odată sau de două ori pentru a vedea meniul de bază, sau folosiţi acest Index sau instalați  *siduction-manual-reader*` .

######  [Manualul SO  *siduction*](welcome-ro.htm#welcome-gen) 

+  [Manualul SO  *siduction*](welcome-ro.htm#welcome-gen)   
+  [Folosirea acestui manual](welcome-ro.htm#how-to)   
+  [Index](welcome-ro.htm#table-contents)   
+  [De unde primiţi ajutor](help-ro.htm#help-gen)   
+  [IRC !paste (lipire în IRC)](help-ro.htm#paste)   
+  [Credite](credits-ro.htm#cred-team)   
+  [Ghidul de pornire rapidă a lui  *siduction*](wel-quickstart-ro.htm#welcome-quick)   

######  [ISO Releases, Download Mirrors și Inscripțioane](cd-dl-burning-ro.htm#download-siduction) 

+  [Conținut ISO și Cerințe de Sistem](cd-content-ro.htm#cd-content)   
+  [Notificări de lansări](sys-admin-release-ro.htm#rolling)   
+  [*siduction*  Locaţii de Download, Descărcarea şi scrierea ISO-ului](cd-dl-burning-ro.htm#download-siduction)   
+  [Verificarea cu suma de control md5](cd-dl-burning-ro.htm#md5)   
+  [Scrierea în Windows](cd-dl-burning-ro.htm#burn-nero)   
+  [Scrierea în Linux](cd-dl-burning-ro.htm#burn-linux)   
+  [Scriptul 'burniso'](cd-no-gui-burn-ro.htm#burning-no-gui)   
+  [Scrierea ISO-ului fără GUI (fără interfaţă grafică)](cd-no-gui-burn-ro.htm#burn-no-gui-gen)   

######  [Modul Live](live-mode-ro.htm#rootpw) 

+  [Parola de root pe siduction-Live ISO](live-mode-ro.htm#rootpw)   
+  [Instalarea de software în timpul lucrului de pe Live- ISO](live-mode-ro.htm#live-cd-installsoft)   
+  [Scrierea pe partiţii NTFS cu ntfs-3g](live-mode-ro.htm#ntfs-3g)   

######  [Terminalul /Konsola](term-konsole-ro.htm#sux) 

+  [sux / sudo](term-konsole-ro.htm#sux)   
+  [Terminalul/Konsola](term-konsole-ro.htm#term-kon)   
+  [Ajutor în Linia de Comandă](term-konsole-ro.htm#cli-help)   
+  [Unelte de folosit în 'text mode' (tty) și 'init 3'](help-ro.htm#init3-tools)   
+  [Lista Comenzilor în Terminalul Linux](term-konsole-ro.htm#term-cmds)   
+  [Instalarea Scripts.sh](term-konsole-ro.htm#shell-scripts)   

######  [CheatCodes](cheatcodes-ro.htm#cheatcodes) 

+  [cheatcode-uri specifice lui  *siduction*  (numai în Live- ISO)](cheatcodes-ro.htm#cheatcodes)   
+  [Cheatcodes generice în Linux](cheatcodes-ro.htm#cheatcodes-linux)   
+  [Coduri VGA](cheatcodes-vga-ro.htm#vga)   

######  [Partiţionarea Hard Discului](part-gparted-ro.htm#partition) 

+  [Partiţionarea Hard Discului folosind GParted/KDE Partition Manager](part-gparted-ro.htm#partition)   
+  [Redimensionarea partiţiilor NTFS folosind GParted/KDE Partition Manager](part-gparted-ro.htm#ntfs)   
+  [UUID, Etichetarea Partiţiilor şi fstab](part-uuid-ro.htm#uuid)   
+  [Formatarea după partiționare cu  *gdisk*](part-gdisk-ro.htm#gdisk-6)   
+  [GPT - Partiționarea cu  *gdisk*](part-gdisk-ro.htm#gdisk-1)   
+  [Numirea Discurilor pe scurt](part-cfdisk-ro.htm#disknames)   
+  [Partiţionarea Hard Discului folosind cfdisk](part-cfdisk-ro.htm#partition)   
+  [Formatarea după partiţionarea cu cfdisk](part-cfdisk-ro.htm#formating)   
+  [Exemple de dimensiuni ale partiţiilor](part-size-examp-ro.htm#part-example)   

######  [Opţiuni de Instalare](hd-install-ro.htm#Inst-prep) 

+  [Pregătirea Instalării](hd-install-ro.htm#Inst-prep)   
+  [Instalarea pe Hard Disc](hd-install-ro.htm#Installation)   
+  [Prima Pornire](hd-install-ro.htm#first-hd-boot)   
+  [Pornirea de la imagine .iso ('fromiso') - Informații sumare](hd-install-opts-ro.htm#fromiso)   
+  [Bootarea (pornirea) 'fromiso' cu Grub 1(grub-legacy)](hd-install-opts-ro.htm#fromiso-grub-leg)   
+  [Bootarea 'fromiso' cu Grub 2](hd-install-opts-ro.htm#grub2-fromiso)   
+  ['fromiso' şi 'persist'](hd-install-opts-ro.htm#fromiso-persist)   
+  [Instalarea pe un USB-Hard Disc -  *siduction* -on-stick](hd-install-opts-ro.htm#usb-hd)   
+  [Scrierea  *siduction*  pe un USB/SSD stick cu orice sistem Linux, MS Windows sau Mac OS X](hd-ins-opts-oos-ro.htm#raw-usb)   
+  [Boot-area  *siduction*  în rețea](nbdboot-ro.htm#nbd1)   
+  [Opțiuni de instalare Virtual Machine](hd-install-vmopts-ro.htm#vm)   

######  [Plăci Grafice , Dispozitive Hardware şi Drivere &amp; xorg.conf](gpu-ro.htm#foss-xorg) 

+  [Scrierea pe partiţii NTFS cu ntfs-3g](part-gparted-ro.htm#hd-ntfs3g)   
+  [Schimbarea rezoluţiei şi Monitoare](hw-dev-mon-ro.htm#mon-res)   
+  [Monitoare Duale şi 'xrandr'](hw-dev-mon-ro.htm#xrandr)   
+  [Monitoare duale (folosind binare)](hw-dev-mon-ro.htm#mon-binary)   
+  [AMD/ATI 3D drivers](gpu-ro.htm#ati-3d)   
+  [Intel 2D and 3D drivers](gpu-ro.htm#intel)   
+  [Nvidia 3D drivers](gpu-ro.htm#nvidia)   
+  [Open Source Xorg drivers](gpu-ro.htm#foss-xorg)   
+  [Firmware detection - non-free](nf-firm-ro.htm#fw-detect)   
+  [Adding non-free to Sources List](nf-firm-ro.htm#non-free-firmware)   

######  [Managere de ferestre în mod grafic - KDE](wm-dm-ro.htm#desk-freeze) 

+  [Xfce - aplicații utile](wm-dm-ro.htm#xfce-notes)   
+  [KDE - aplicații utile](wm-dm-ro.htm#install-add)   
+  [Desktop-ul se blochează](wm-dm-ro.htm#desk-freeze)   
+  [Dacă nu te poţi loga în KDE](wm-dm-ro.htm#kde-login)   
+  [Schimbarea Temelor](wm-dm-ro.htm#ch-th)   
+  [Display Managere - dm](wm-dm-ro.htm#dm)   

######  [Setul LAMP din  *siduction*](lamp-apache-ro.htm#serv-apache) 

+  [Setul LAMP din  *siduction*](lamp-apache-ro.htm#serv-apache)   
+  [Clienţi FTP](lamp-apache-ro.htm#serv-ftp)   
+  [Protocoale de Securitate](lamp-apache-ro.htm#serv-sec)   
+  [SSL](lamp-apache-ro.htm#serv-ssl)   
+  [Setarea MySQL](lamp-sql-ro.htm#serv-mysql)   
+  [PHP în Apache](lamp-ppp-ro.htm#serv-php)   
+  [Setarea Timeserver-ului](ntp-server-ro.htm#ntp-server)   

######  [Internet şi Networking](inet-ceni-ro.htm#netcardconfig) 

+  [Tor](tor-privoxy-ro.htm#tor)   
+  [Privoxy](tor-privoxy-ro.htm#privoxy)   
+  [Firewalls](inet-ceni-ro.htm#firewalls)   
+  [Configurarea SAMBA (Windows)](samba-ro.htm#configure)   
+  [Setarea Serverului Samba](samba-ro.htm#setup)   
+  [Montarea de la distanţă SSH](ssh-ro.htm#ssh-fs)   
+  [Aplicaţii X Window via SSH](ssh-ro.htm#ssh-x)   
+  [SSH cu Konqueror](ssh-ro.htm#ssh-f)   
+  [SSH X-Forwarding de la un Windows-PC](ssh-ro.htm#ssh-w)   
+  [SSH şi Securitatea](ssh-ro.htm#ssh)   
+  [Modemuri 56k](inet-ceni-ro.htm#dial-mod)   
+  [WiFi - WPA_GUI](inet-wpagui-ro.htm#wpa-roaming-gui)   
+  [WiFi - Setarea WiFi Roaming](inet-setup-ro.htm#net-set1)   
+  [WiFi - wpasupplicant](inet-wpa-ro.htm#wpa)   
+  [Comutarea rețelei între WiFi și Cablu](inet-ifplug-ro.htm#hotswitch)   
+  [Conectarea online - Ceni](inet-ceni-ro.htm#netcardconfig)   

######  ['dist-upgrade' și administrarea pachetelor](sys-admin-apt-ro.htm#apt-cook) 

+  [Ghid APT şi lista surselor](sys-admin-apt-ro.htm#apt-cook)   
+  [Instalarea unui pachet (program) nou](sys-admin-apt-ro.htm#apt-install)   
+  [Ştergerea unui pachet](sys-admin-apt-ro.htm#apt-delete)   
+  [Downgrading sau Hold de pachet(e)](sys-admin-apt-ro.htm#apt-downgrade)   
+  [Căutarea unui pachet cu 'apt-cache'](sys-admin-apt-ro.htm#apt-cache)   
+  [Căutarea unui pachet cu Package searching](sys-admin-apt-ro.htm#gui-pacsea)   
+  [Actualizarea folosind Live - ISO](sys-admin-upgrade-ro.htm#live-cd-upgrade)   
+  ['dist-upgrade' a mai multor PC-uri într-o reţea (LAN)](sys-admin-apt-locarmirr-ro.htm#approx)   
+  [Actualizarea kernel-ului](sys-admin-kern-upg-ro.htm#kern-upgrade)   
+  [Instalarea dinamică a modulelor de kernel modules cu 'dmakms'](sys-admin-kern-upg-ro.htm#dmakms)   
+  [Actualizarea sistemului instalat - dist-upgrade - Informații sumare](sys-admin-apt-ro.htm#apt-upgrade)   
+  [Actualizarea sistemului instalat - dist-upgrade - Ordinea operațiunilor](sys-admin-apt-ro.htm#du-st)   

######  [Administrarea Sistemului](sys-admin-gen-ro.htm#start-services) 

+  [Adăugarea unui nou client (user)](hd-install-ro.htm#adduser)   
+  [Mutarea directorului /home](home-ro.htm#home-bu)   
+  [Backup cu rdiff](sys-admin-rdiff-ro.htm#rdiff)   
+  [Backup cu rsync](sys-admin-rsync-ro.htm#rsync)   
+  [Antivirus şi Rootkit](vir-rkits-ro.htm#virus-rkits)   
+  [Serviciile enable/disable](sys-admin-gen-ro.htm#start-services)   
+  [Parolele de root pierdute](sys-admin-gen-ro.htm#pw-lost)   
+  [Fonturi](sys-admin-gen-ro.htm#fonts)   
+  [CUPS - Sistem de printare](sys-admin-gen-ro.htm#cups)   
+  [Mixere Audio](sys-admin-gen-ro.htm#sound)   
+  [*siduction*  -nivele de execuție (runlevels) - init](sys-admin-gen-ro.htm#init)   
+  [Actualizarea BIOS cu FreeDOS](bios-freedos-ro.htm#bois-prep)   
+  [Grub2 - MBR Suprascris](sys-admin-grub2-ro.htm#chroot)   
+  [Grub2 - Dual și Multibooting](sys-admin-grub2-ro.htm#multi-os)   
+  [Grub2 -Upgradarea de la Grub1 la Grub2](sys-admin-grub2-ro.htm#grub1-grub2)   
+  [Grub2 - Informații sumare](sys-admin-grub2-ro.htm#grub2)   

<div id="rev">Page last revised 03/12/2012 1818 UTC</div>
