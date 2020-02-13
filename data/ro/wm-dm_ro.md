<div id="main-page"></div>
<div class="divider" id="install-add"></div>
## Unele aplicații KDE bune care nu sunt pre-instalate pe siduction KDE Lite

 `Trebuie să aveți activate sursele non-free în /etc/apt/sources.list.d/debian.list` 

###### konq-plugins - plugin-uri pentru Konqueror. 

Acest pachet conține o varietate de plugin-uri utile pentru Konqueror. Acesta este un manager de fișiere, web browser și cititor de documente pentru KDE. Multe dintre aceste plugin-uri vor apare în menu-ul Tools al lui Konqueror.

~~~  
apt-get install konq-plugins  
~~~

Îmbunătățirile pentru web browsing includ: traducerea paginilor web, arhivarea paginilor web, auto-reîmprospătare, analiza structurală HTML și css, o bară de unelte pentru căutare, o bară laterală care vă anunță noutățile, acced rapid la opțiunile comune, semne de carte (bookmarklets), o monitorizare a crash-urilor, un indicator de microformat, o bară laterală de bookmarks 'del.icio.us' și integrarea cu 'aKregator RSS feed reader'.

Îmbunătățirile pentru directory browsing includ: filtre pentru directoare, crearea de galerii cu imagini, arhivare compresare și extragere, un rapid copy/move, o bară laterală media player, o metabar/sidebar cu informații despre fișiere, un ajutor pentru directoare media, o reprezentare grafică a utilizării disk-urilor și un convertor/transformator de imagini. 

###### Căutare cu KDE Deskop Search - (Nepomuk și Strigi) 

În siduction-kde.iso  *KDE's Nepomuk semantic desktop search*  este deja activat.

Așteptați-vă ca prima operațiune de indexare să dureze mult timp.  [Mai multe informații despre Nepomuk aici](http://nepomuk.kde.org/) . 

<div class="divider" id="kde-login"></div>
## Probleme la logarea în sistem sub KDE

Conţinutul directorului /tmp este în mod normal golit la fiecare secvenţă de boot deci şi unele directoare sau specificaţii necesare serverului de ecran sunt deasemeni şterse.

În mod automat, la pornire, scriptul x11-common din X-Org recrează aceste setări.

Este posibil totuşi să nu fie recreate la pornire şi de aceea pentru a le rechema executaţi: 

~~~  
# X-ORG: # dpkg-reconfigure x11-common  
~~~

KDE are nevoie de 5% din partiția unde rezidă directorul /tmp și sunt create fișierele temporare după login. Dacă partiția voastră este ocupată 95% cu diverse fișiere nu veți putea să vă log-ați în KDE și veți fi redirecționați într-un tty.

La fel se întâmplă și cu kdm care nu vă lasă să vă log-ați. O soluție este să vă log-ați într-un tty de unde puteți șterge și/sau curăța aplicații sau fișiere de care nu mai aveți nevoie.

O altă alternativă ar fi să folosiți un alt manager de ferestre X care are nevoie de mai puțin spațiu pentru rulare (de exemplu 'fluxbox' este deja prezent într-o instalare siduction) sau utilizând 'chroot' de pe un siduction live-CD/DVD pentru a curăța partiția și de a putea apoi boota în KDE.

85% ocupare este maximum recomandat la o partiție accesată de KDE pentru fișierele sale /tmp. (15% spațiu liber).

<div class="divider" id="ch-th"></div>
## Instalarea 'siduction KDE Art' și 'Themes'

Pentru a instala ultimele 'siduction-art' pe o instalare existentă:

~~~  
apt-get install siduction-art-kde-xxxx siduction-art-wallpaper-xxxx  
(Unde xxxx este numele versiunii de examplu siduction-art-kde-onestepbeyond)  
~~~

Aceasta va instala 'siduction wallpaper' și 'themes'

#### Pentru a schimba Wallpaper-ul:

`Click-dreapta` pe desktop și alegeți `Desktop Settings` . Sub titlul `Wallpaper`  este un subtitlu numit `Picture`  care oferă o listă 'dropdown' de unde puteți alege care wallpaper să fie afișat. Puteți de asemenea să dați click pe butonul Browse de lângă Picture pentru utilizarea unei imagini ce o aveți undeva pe computerul vostru.

#### Pentru a schimba ecranul de Login:

Pentru a schimba ecranul de login, trebuie să deschideți `systemsettings`  cu drepturi de root/administrator:

~~~  
Alt + F2 (pentru a lansa krunner)  
~~~

~~~  
kdesu systemsettings  
~~~

Apoi click pe `Advanced tab`  apoi click pe `Login Manager` , mergeți la `Theme tab`  și alegeți thema preferată. `Pentru activarea noului ecran de Login trebuie să reboot-ați computerul` .

 [Mai multe informaţii despre KDE şi link-uri](http://kde.org)  

<div class="divider" id="xfce-notes"></div>
## Extrase utile Xfce

<div class="divider" id="xfce-notes-1"></div>
### Instalarea 'siduction Xfce Art' și 'Themes'

Pentru instalarea ultimelor 'siduction-art' pe o instalare existentă:

~~~  
apt-get install siduction-art-xfce-xxxx siduction-art-wallpaper-xxxx  
(Unde xxxx este numele versiunii de examplu siduction-art-xfce-onestepbeyond)  
~~~

Aceasta va instala 'siduction wallpaper and themes', apoi schimbați setările din meniul Settings al lui Xfce.

<!--This will install the siduction wallpaper and themes, then actualise your defaults in the Settings entry point of the xfce menu.

-->
 [Xfce Documentation](http://www.xfce.org/documentation) 

 [Xfce wiki](http://wiki.xfce.org) 

<div class="divider" id="dm"></div>
## Managere de ferestre - dm 

###### Instalarea altor medii desktop pe lângă cel preinstalat:

Când instalați un alt mediu desktop împreună cu cel deja instalat, (de examplu, aveți instalat KDE de pe siduction-kde.iso și vreți acum să instalați și Xfce sau LXDE), un display manager (dm) va fi de asemenea instalat cu noul mediu sau va trebui să-l instalați singuri, (gdm, slim sau alte asemenea pachete).

Problema este că vă veți trezi în nivelul de configurare de bază al Debian cu consecința că va trebui să opriți manual serverul X (video) în runlevel 3 înainte de a proceda la o  *dist-upgrade* .

Soluția este:

~~~  
apt-get update  
apt-get install --reinstall distro-defaults  
update-rc.d <dm> remove  
update-rc.d <dm> defaults  
~~~

Example pentru `update-rc.d <dm> defaults`  și nu uități punctul **`.`**  :

~~~  
update-rc.d kdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d gdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d slim start 01 5 . stop 01 0 1 2 3 4 6 .  
~~~

<div class="divider" id="desk-freeze"></div>
## Desktop-ul se blochează

Într-o asemenea situaţie nu întotdeauna e nevoie de butonul de reset (F13 :)). Acesta poate deteriora sistemul de fişiere sau duce la pierderea de date. Nicicum sistemul de fişiere nu va fi în regulă după un reset hard (filesystem not clean)

Mai întâi încercaţi să combinația de taste `alt-ctl-F1`  sau să restartaţi serverul X `alt-ctl-backspace` , (dacă nici una din aceste două opţiuni nu funcţionează încă mai există speranţă):

Tasta SYSRQ (tasta "print", în partea dreaptă superioară a tastaturii ) vă ajută să reporniţi curat un sistem care nu răspunde.

Următoarele combinaţii de taste sunt posibile:  
*`alt+sysrq+r`  (redă controlul tastaturii )  
*`alt+sysrq+s`  (emite un sync)  
*`alt+sysrq+e`  (trimite term tuturor proceselor în afară de init)  
*`alt+sysrq+i`  (trimite kill tuturor proceselor în afară de init)  
*`alt+sysrq+u`  (fişierele sunt montate read-only, previne fsck la reboot)  
*`alt+sysrq+b`  (restartează sistemul fără paşii anteriori echivalent cu un hard reset).

cel mai bine e să acordaţi câteva secunde fiecărui pas pentru a se executa; finalizarea tuturor proceselor, de exemplu, poate lua ceva timp. Tastele necesare pot fi uşor amintite cu:  
 **"**`R`** eboot **`S`** ystem **`E`** ven **`I`** f **`U`** tterly **`B`** roken"** 

Alt mod de a le ține minte este:  
 **"**`R`** aising **`S`** kinny **`E`** lephants **`I`** s **`U`** tterly **`B`** oring"** 

<div id="rev"> Page last revised 30/11/2012 1420 UTC </div>
