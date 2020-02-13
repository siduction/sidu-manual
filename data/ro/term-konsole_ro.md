<div id="main-page"></div>
<div class="divider" id="term-kon"></div>
## Definiţia unui terminal/konsolă

Un terminal, altfel numit consolă iar în KDE konsole, este un program care face posibilă interacţiunea directă cu sistemul de operare Linux prin lansarea către acesta de diferite comenzi ce sunt executate imediat. De multe ori numită şi `shell`  sau `command line` , terminalul este o unealtă foarte puternică şi merită efortul de a învăţa câteva lucruri de bază despre modul său de folosire.

În  *siduction*  găsiţi terminalul/konsola aproape de butonul K-menu simbolizată prin imaginea unui monitor de PC. În funcţie de tema pe care o folosiţi, imaginea poate conţine sau nu şi imagnea unei console. Veţi găsi acelaşi icon în meniul K -> System -> Konsole.

Când deschideţi fereastra unui terminal vi se va arata un prompter de forma:

~~~  
username@hostname:~$  
~~~

Veţi recunoaşte  *username* , ca numele sub care v-aţi logat. Semnul `~ (tilda)`  arată că sunteţi în directorul dumneavoastră  *home* , iar semnul `$`  arată că sunteţi logat cu privilegii de utilizator ( *user* ). La finalul prompter-ului aveţi cursorul. Aceasta este linia de comandă în care puteţi introduce comenzile pe care vreţi să le executaţi.

Multe comenzi trebuie executate cu privilegii de administrator ( *root* ). Pentru a dobândi asta tastaţi `sux`  la prompter şi apăsaţi enter. Vi se va cere parola de  *root* . Tastaţi parola şi apăsaţi enter din nou (observaţi că, în timp ce tastaţi parola, nu apare nimic pe ecran din motive de securitate).

Dacă parola este corectă prompter-ul se va schimba în:

~~~  
root@hostname:/home/username#  
~~~

**`ATENŢIE: Câtă vreme sunteţi logat ca  *root* , sistemul nu vă va opri de la a face lucruri potenţial periculoase precum ştergerea de fişiere importante etc.; va trebui să fiţi absolut siguri în legătură cu ceea ce faceţi, pentru că este foarte posibil să aduceţi daune serioase sistemului.`**

Observaţi că semnul `$`  s-a schimbat în `#`  (diez). Într-un terminal/konsolă semnul `#`  întotdeauna arată că sunteţi logat cu privilegii  *root* . `În notarea din acest manual vom omite tot ce există în faţa caracterelor`  $ `sau`  # `.`  Deci o comandă ca:</span>

~~~  
# apt-get install  nume_program   
~~~

înseamnă: deschideţi un terminal, deveniţi  *root*  (cu  *sux* ) şi introduceţi comanda după semnul #. `(Nu tastaţi şi semnul`  #`)` 

Uneori consola/ terminalul poate deveni coruptă, tastaţi:

~~~  
reset  
~~~

şi daţi enter.

În cazul în care informaţiile afişate de o consolă apar distorsionate: cel mai des puteţi corecta această problemă apăsând `ctrl+l,`  prin care se va rescrie fereastra terminalului. Aceste distorsiuni apar cel mai des când lucraţi cu programe ce folosesc interfaţa  *ncurses* , cum ar fi  *irssi* 

Ocazional konsola/ terminalul pot da impresia că sunt blocate. Nu este adevărat. Tot ce veţi tasta va fi procesat. Aceasta se poate întâmpla dacă aţi apăsat din greşeală `ctrl+s` . În acest caz încercaţi `ctrl+q`  pentru a debloca terminalul.

<div class="divider" id="colours"></div>
### `Prompt-uri`colorate`  în terminal`  `user:~` `$`  și **`*root* :`** `#`  `:` 

Prompt-urile colorate din terminal vă pot feri de greșeli rușinoase și posibil catastrofice logat ca **`root #`**  când defapt vreți să fiți `user~$` , sau să folosiți prompt-urile colorate ca indicator pentru ultimele 100 de linii executate.

De regulă, amândouă promt-urile  *user~$*  și  *root#*  au aceeași culoare; este destul de simplu să le schimbăm pe ambele.

Codurile de bază ale culorilor sunt:

~~~  
(sintaxa este 00;XX)  
[00;30] Negru  *(Black)*   
[00;31] Roșu  *(Red)*   
[00;32] Verde  *(Green)*   
[00;33] Galben  *(Yellow)*   
[00;34] Albastru  *(Blue)*   
[00;35] Purpuriu  *(Magenta)*   
[00;36] Turcoaz  *(Cyan)*   
[00;37] Alb  *(White)*   
[Înlocuiți [00;XX] cu [01;XX] pentru a obține variante de culoare].  
~~~

###### Schimbarea culorii promt-ului  *nume_utilizator ~$* :

Ca utilizator $, cu un editor de text preferat deschideți fișierul:

~~~  
$ <editor> ~/.bashrc  
~~~

Mergeți la linia 39 și de-comentați-o astfel:

~~~  
force_color_prompt=yes  
~~~

Mergeți la linia 53 unde veți găsi 01;32m, (de exemplu), și schimbați-l cu codul culorii dorite.

De exemplu, pentru un promt colorat de  *user~:$*  în `turcoaz  *(cyan)* ` , [01;36m\], trebuie să schimbați codul [01;XXm\] în 3 locuri cu sintaxa:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[01;36m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '  
~~~

Noul aspect va avea efect la o nouă pornire a konsole-i.

###### Schimbarea culorii promt-ului  *root #* :

~~~  
sux  
<editor> /root/.bashrc  
~~~

Mergeți la linia 39 și de-comentați-o astfel:

~~~  
force_color_prompt=yes  
~~~

Mergeți la linia 53 unde veți găsi 01;32m, (de exemplu), și schimbați-l cu codul culorii dorite.

De exemplu, pentru un promt colorat de  *root #*  în **`roșu  *(red)* `** , [01;31m\], trebuie să schimbați codul [01;XXm\] în 3 locuri cu sintaxa:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[01;31m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '  
~~~

Noul aspect va avea efect la o nouă pornire a konsole-i.

###### Culorile de fundal al terminal-ului

Schimbarea culorii fundalului și a font-ului uitați-vă în opțiunile din menu-ul terminalului. 

![Terminal colours](../images-common/images-terminal/terminal-colour-0.1.png "Terminal colours") 

Veți găsi multe opțiuni disponibile dar vă recomandăm să le mențineți simple.

<div class="divider" id="sux"></div>
## Despre sux

 Multe comenzi trebuie executate ca administrator sau  *root* . Comanda care face această trecere este: 

~~~  
sux  
~~~

 Cu toate că  *su*  este comanda obișnuită pentru a deveni  *root* , folosirea comenzi `sux`  vă va permite să porniți aplicații grafice (de tip GUI/ X11) din linia de comadă în numele utilizatorului care o lansează, întru-cât `sux`  este o îmbunătățire a comenzii standard `su` , care permite transferul credențialelor X către utilizatorul care o lansează. (Vedeți și  [*sudo*](#sudo) ).

Exemple de utilizare de aplicații X11, prin  *sux* , sunt lansarea de editoare precum  *kwrite*  sau  *kate* , partiționarea cu  *gparted*  sau utilizarea unui manager de fișiere ca  *dolphin*  sau  *thunar* .

###### KDE - combinații de taste

Pentru a porni  *krunner*  în KDE:

~~~  
Alt+F2  
~~~

sau click-dreapta pe desktop și alegeți:

~~~  
Run Command  
~~~

apoi:

~~~  
kdesu <Application>  
~~~

###### Xfce - combinații de taste

Pentru a porni  *Run Command*  în Xfce:

~~~  
Alt+F2  
~~~

sau click-dreapta pe desktop și alegeți:

~~~  
Run Command  
~~~

apoi:

~~~  
gksu <Application>  
~~~

###### Alte Managere de Ferestre - combinații de taste

O combinație de taste generică, comună toturor "Desktop Managers" principale, este:

~~~  
Alt+F2  
~~~

apoi:

~~~  
su-to-root -X -c <Application>  
~~~

`Toate comenzile precedente pot fi rulate într-un terminal.` 

<div class="divider" id="sudo"></div>
## Comanda  *sudo*  nu este suportată

 *sudo*  nu este implicit activată într-o instalare pe hard disk. Este disponibilă pentru utilizare pe live-ISO de vreme ce nici parola de  *root*  nu e setată. Motivarea acestei decizii este aceasta: dacă un 'atacator' obține parola de  *user*  sau are acces la tastatură în lipsa voastră, să nu poată obține imediat și drepturi complete de  *root*  putând face schimbări periculoase sistemului vostru.

O altă problemă cu  *sudo*  este că permite să ruleze o aplicație  *root*  cu o configurație de  *user* , care poate să suprascrie sau să schimbe permisiunile. În unele cazuri, poate face ca o aplicație să devină inutilizabilă pentru  *user* . Folosiți `[sux](#sux) ,  *kdesu* ,  *gksu*  sau  *su-to-root -X -c*`  așa cum v-am recomandat!

## Fiind administrator  *root* 

**` ATENȚIE: O dată logat ca utilizator  *root* , sistemul NU vă va înpiedica să faceți lucruri care-l pot periclita, ca de exemplu ștergerea de fișiere importante, etc ..., deci trebuie să fiți absolut sigur de ceea ce vreți să faceți, întru-cât riscul de a vă ruina sistemul este maxim.`**

**` În nici un caz, nu trebuie să executați ca  *root*  în consolă/terminal aplicații tipice pentru un utilizator normal, ca de exemplu trimeterea de email-uri, crearea de  *spreadsheet* -uri sau navigarea pe net și așa mai departe.`**

<div class="divider" id="cli-help"></div>
## Ajutor în Linia de Comandă

Da există. Majoritatea comenzilor/ programelor în Linux au propriul manual, numit  *man page*  sau  *manual page*  ce poate fi accesat din linia de comandă. Sintaxa este:

~~~  
$ man  nume_comandă*   
~~~

sau

~~~  
$ man -k <cuvânt-cheie>  
~~~

Aceasta va arăta pagina din manual pentru comanda respectivă. Navigaţi sus şi jos cu tastele cursor. Ca exemplu încercaţi:

~~~  
$ man apt-get  
~~~

Pentru a ieşi din  *man pages*  tastaţi `q` 

O altă utilitate folositoare este comanda  *apropos* .  *Apropos*  oferă posibilitatea de a căuta pagina din manual a unei comenzi pentru care, de exemplu, nu vă amintiţi sintaxa completă. Ca un exemplu puteţi încerca:

~~~  
$ apropos apt-  
~~~

Aceasta va lista toate comenzile aparţinând managerului de pachete  *apt* . Utilitatea  *apropos*  este o unealtă puternică dar descrierea ei în detaliu este mai mult decât scopul acestui manual. Pentru mai multe detalii despre cum se utilizează vedeţi  *man page* .

<div class="divider" id="term-cmds"></div>
## Lista Comenzilor în Terminalul Linux

Aici este o excelentă introducere în BASH  [de la linuxcommand.org](http://linuxcommand.org/) 

`O listă detaliată de 687 comenzi în ordine alfabetică  [Linux in a Nutshell, 5th Edition: O'Reilly Publications](http://www.linuxdevcenter.com/linux/cmd/#a)  poate fi găsită aici şi este un 'must bookmark'`

Există un mare număr de tutoriale pe Internet. Unul foarte bun special pentru începători este:  [A Beginner's Bash](http://linux.org.mt/article/terminal) 

Sau puteţi folosi motorul de căutare preferat pentru a afla mai multe.

<div class="divider" id="shell-scripts"></div>
## Ce este un script şi modul său de utilizare

Un  *script shell*  este un mod convenabil de a grupa mai multe comenzi împreună într-un fișier executabil. Apelând numele script-ului fiecare comandă va fi executată la rând.  *siduction*  vine cu câteva script-uri utile în scopul de a face viața mai ușoară utilizatorilor. 

Dacă script-ul shell se află în directorul curent atunci:

~~~  
./nume_shell-script  
~~~

`Unele script-uri cer drepturi de  *root*  deci accesați-le prin  *sux*  într-un terminal, iar altele nu. Aceasta depinde în întregime de scopul sript-ului.`

##### Instalarea Script-urilor și procedura de executare

Folosiți  *wget*  pentru a descărca fișierul-script, plasați-l acolo unde este recomandat să fie `(de examplu în /usr/local/bin)` . Puteți folosi mouse-ul pentru 'copy' și 'paste' numele fișierului direct în fereastra konsole-i, după ce v-ați log-at cu `sux` 

###### Examplu de utilizare a lui  *wget*  când este cerut `root access (sux)` 

~~~  
sux  
cd /usr/local/bin  
wget nume-script  
~~~

Trebuie apoi să faceți fișierul executabil

~~~  
chmod +x nume-script  
~~~

Puteți folosi de asemeni un browser pentru a descărca un fișier script apoi mutați-l acolo unde este recomandat. Oricum tot trebuie apoi să-l faceți executabil.

<div id="rev">Page last revised 30/11/2012 0200 UTC</div>
