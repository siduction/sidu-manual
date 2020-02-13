<div id="main-page"></div>
<div class="divider" id="Inst-prep"></div>
## Pregătirea pentru instalarea pe Hard-Disk

**`Pentru uzul curent recomandăm tipul de fişiere  *ext4* . Este sistemul implicit în  *siduction*  şi este foarte bine întreţinut.`**

`Înaintea instalării vă rugăm să deconectaţi toate memoriile USB, camerele, etc.`  Instalarea pe  [dispozitive USB necesită paşi suplimentari.](hd-install-opts-ro.htm)  Prin editarea fişierului de instalare: `~/.sidconf`  se pot schimba opțiunile de instalare inplicite cum ar fi folosirea unui sistem de fişiere diferit și/sau instalarea sistemului pe mai multe partiţii. De exemplu creerea unei partiţii separate pentru directorul  */home* .

`Este foarte recomandat să aveţi o partiţie separată pentru date. În termeni de stabilitate și de recuperare a datelor, ca urmare a unui dezastru, beneficiile sunt incomesurabile.`

De aceea directorul $HOME devine locul unde configurările aplicaţiilor de bază sunt ţinute sau, să spunem altfel, este un container unde aplicaţiile păstrează configurările/setările personale și este locul unde sunt păstrate toate datele personale.

###### Reinstalarea de aplicații utilizabile pe un alt calculator

 Pentru a crea o listă cu aplicaţiile deja instalate, în scopul de a le 'pune' pe o alta mașină sau în anumite cazuri, chiar pe propria mașină, rulați comanda următoare într-un terminal (consolă): 

~~~  
dpkg -l|awk '/^ii/{ print $2 }'|grep -v -e ^lib -e -dev -e $(uname -r) >/home/username/installed.txt  
~~~

 Apoi copiați fișierul text rezultat pe un dispozitiv usb sau pe orice alt periferic mobil (cdrom).

 Copiați acest fișier în directorul $HOME pe a doua mașină și folosiți această listă ca referință pentru instalarea aplicaţiilor necesare. Instalarea se face cu:

~~~  
apt-get install $(<installed.txt)  
~~~

##### RAM și Swap

Pe calculatoarele cu mai puţin de 512 Mb RAM trebuie să aveţi o partiţie swap. Mărimea acesteia nu trebuie să fie mai mică de 128 Mb (informaţiile date de  *cfdisk*  NU ar trebui crezute atâta vreme cât el calculează în baza 10) dar nici o partiţie swap mai mare de 1G nu are rost.

`Vă rugăm consultați:  [Partiţionarea Hard-Disk-ului](part-gparted-ro.htm) `

**`ÎNTOTDEAUNA FACEŢI SALVĂRI DE SIGURANŢĂ A DATELOR! inclusiv semnele de carte (bookmarks) și email-urile!`** Vedeți și [Back-Up cu  *rdiff*](sys-admin-rdiff-ro.htm#rdiff)  și  [Back-Up cu  *rsync*](sys-admin-rsync-ro.htm#rsync) . O altă variantă este cu  *'sbackup'*  (trebuie instalat).

Instalarea pe Hard-Disk este mai confortabilă iar sistemul rulează mai rapid decât atunci când rulează de pe CD.

Setați (în BIOS) CD-ROM-ul ca prim dispozitiv de boot. La majoritatea computerelor puteţi intra în BIOS apăsând tasta  *[del]*  în timpul procesului de boot-are.În unele versiuni de BIOS se poate pur şi simplu să alegeți dispozitivul de pe care să se încarce sistemul la pornire, de exemplu la un BIOS tip AMI, folosim tasta F11 sau F8.

În cele mai multe cazuri  *siduction*  trebuie să pornească. În caz contrar puteţi folosi opțiunile de boot, (numite cheatcodes sau parametri de boot) care pot fi scrise direct în linia de comandă a managerului de boot. Folosirea parametrilor de boot (ex. pentru rezoluţia ecranului sau limba selectată) poate salva un timp prețios în faza de configurare de după instalare. A se vedea  [Cheatcodes](cheatcodes-ro.htm)  sau  [Rezoluții VGA](cheatcodes-vga-ro.htm) 

<!-- hiding crap for the moment <div class="divider" id="lang"></div>
## Alegerea limbii în care veți folosi instalarea###### `Instalarea limbii cu KDE-full` 

Selectați limba de baza din **`menu-ul grub (F4)`**  în `versiunea lui kde-full`  ca să instalați localizarea pentru desktop și multe alte aplicații în timp ce efectuați boot-area. 

Aceasta asigură că ele vor fi prezente după instalarea limbilor necesare pentru sistemul dat. Capacitatea de memorie necesară pentru această acțiune depinde de limbă și  *siduction*  ar putea refuza instalarea automată a unor limbi dacă realizează că RAM-ul este insuficient pentru aplicație și va boot-a secvența cerută continuând în limba engleză dar cu setările locale dorite (monedă, dată, timp, tastatură). O memorie de minim (mai bine dacă este mai mare de) 1 GB este necesară și va fi sigură pentru limbile susținute și anume:

  
Default - Germană(German)  
Default - Engleză (English-US)  
*Cehă (Czech)  
*Daneză (Danish)  
*Spaniolă (Spanish)  
*Engleză (GB)  
*Franceză (French)  
*Italiană (Italian)  
*Japoneză (Japanese)  
*Olandeză (Dutch)  
*Poloneză (Polish)  
*Portugheză (Portuguese BR and PT)  
*Română (Romanian)  
*Rusă (Russian)  
*Українська (Ukrainian)  


Selectarea limbii depinde de disponibilitatea traducerii ei în manualul siduction: implicați-vă în traducere ca să adăugați limba dvs.

 -->
###### `Alte instalări de limbă cu KDE-lite` 

1. Selectați limba dorită din **`menu-ul gfxboot (F4)`** . (Vezi de asemeni [Cheatcodes Live-CD specifice în siduction](cheatcodes-ro.htm#cheatcodes) ). Dosarele de limbă nu se află pe Live-CD, astfel încât sistemul va fi activat în limba engleză automat. Cu toate acestea sistemul va face configurarea necesară pentru limba preferată și deci nu trebuie să faceți nici o schimbare în sistem în afară de instalarea dosarelor de limbă.  
2.  Porniți instalarea.  
3. Instalați pe HD și reboot-ați.  
4. După instalarea pe HD, instalați limba aleasă și aplicațiile ei via  *apt-get* .  

###### Prima boot-are de pe HD

`După ce boot-ați petru prima dată veți descoperi că  *siduction*  a uitat propria configuratie de rețea` . Rețeaua poate fi setată cu usurință de la  [Kmenu > Internet > Ceni](inet-ceni-ro.htm) . Pentru  *roamimg*  adițional WIFI/WLAN  [vă rugăm să citiți aici.](inet-wpagui-ro.htm) 

<div class="divider" id="Installation"></div>
## Programul de instalare  *siduction* 

 **1.**  Programul de instalare este pornit din `icon-ul Desktop, KMenu> System>siduction-installer` 

![siduction-Installer1](../images-en/installer-en/installer1-en.png "Welcome tab - siduction Installer") 


---

 **2.**  După ce aţi citit (şi înţeles) mesajul de avertizare, trecem la alegerea partiţiei. 

![siduction-Installer2](../images-en/installer-en/installer2-en.png "Partitioning tab - siduction Installer") 

`V-ați salvat (backed up) datele?`

Dacă nu ați partiționat încă HD-ul faceți-o cu `Start Part.-manager`  și uitați-vă la  [Partiționarea HD-ul folosind Gparted](part-gparted-ro.htm)  sau, dacă doriți să folosiți "shell-ul", citiți  [Partiționarea HD-ul](part-cfdisk-ro.htm) 


---

 **3.**  Acum alegeţi partiţia destinaţie şi punctele de montare pentru instalare. Partiţiile pentru care nu aţi stabilit puncte de montare vor fi montate automat la pornire inclusiv partiţia de swap. 

**`NOTĂ: Partiţia dumneavoastră de root ('/") va fi formatată cu sistemul de fişiere ales.`** 

![grub-to-mbr](../images-en/installer-en/installer3-en.png "Grub/Timesone tab - siduction Installer") 


---

 **4.**  În această parte puteţi alege dacă doriţi alte puncte de montare în afară de /. Vă recomandăm o partiţie separată /home/. Totuşi, `poate este momentul să creati şi o partiţie separată de date.`  `Pentru fiecare partiţie adăugaţi alegerea dumneavoastră.` .

Toate celelalte partiţii vor fi montate în `/media/numele partiţiei` .

![choosing-pw](../images-en/installer-en/installer4-en.png "User/Password tab - siduction Installer") 


---

 **5.**   *siduction*  folosește Grub ca manager de boot deci vom instala  **Grub în MBR** ! Dacă aici veţi alege altceva trebuie să ştiţi foarte bine ce faceţi.

Grub recunoaşte şi alte sisteme de operare (ex. Windows) şi le adaugă la meniul de boot. 

Mai mult veţi putea modifica şi zona de timp în această fereastră.

![grub-to-mbr](../images-en/installer-en/installer5-en.png "Grub/Timesone tab - siduction Installer") 


---

 **6.**  Apoi vom alege numele utilizatorului, parola de utilizator şi parola de root ( **vă rugăm să le ţineţi minte!** ). Adăugarea altor utilizatori se face după instalare, via terminal cu comanda  [*adduser*](hd-install-ro.htm#adduser) .

![choosing-pw](../images-en/installer-en/installer6-en.png "User/Password tab - siduction Installer") 


---

 **7.** Acum alegeţi numele pe care să-l aibă calculatorul după instalare (puteţi să-l numiţi cum vreţi -  *Hostname* : acesta poate conţine doar litere şi cifre dar nu trebuie să înceapă cu un număr.

![hostname](../images-en/installer-en/installer7-en.png "Network tab - siduction Installer") 

După aceea puteți alege, dacă doriți, ca  *ssh*  să pornească automat sau nu.

 În această etapă a instalării se poate schimba/edita fișierul de configurare după care instalarea poate folosi acest (nou) fișier. Programul de instalare nu face nici o verificare deci orice clic pe  *back*  în acesta duce la pierderea fișierul de configurare, așa că `nu dați clik pe  *back*  în programul de instalare dacă nu doriți să pierdeți fișierul de configurare editat manual.`  

![Begin Installtion](../images-en/installer-en/installer8-en.png "Begin Installation - siduction Installer") 

 Pentru a începe instalarea dați clik pe `*Begin Installation*` . Întregul proces de instalare pe mașini noi este între 5-15 minute iar pe mașini vechi de 60 minute.

 Dacă procesul de instalare 'pare' oprit nu disperați, lăsați ceva timp suplimentar să se scurgă ... 

 Sfărșit !<br/> Reboot-ați, scoateți cdrom-ul și boot-ați în noul sistem instalat pe Hard-Disk. 

<div class="divider" id="first-hd-boot"></div>
## Prima pornire

`La prima pornire a sistemului veţi descoperi că  *siduction*  a pierdut configurarea reţelei. Va trebui să faceţi o nouă configurare (Wlan, Modem, ISDN,...)`

Dacă prima dată reţeaua a fost detectată automat (DHCP) chiar folosind un DSL-Router, acum va trebui să o reactivaţi prin comanda: 

~~~  
ceni  
~~~

Uneltele de configurare pot fi găsite şi în: `Kmenu>siduction>Internet>ceni` . Deasemeni vedeţi:  [Internet şi rețele](inet-ceni-ro.htm) 

Pentru a adăuga o partiție existentă de  *siduction*  $home la noua instalare trebuie să modificați fișierul 'fstab', așa cum este explicat aici  [Mutarea partiției /home](home-ro.htm#home-move) .

 **`Nu utilizați sau share-uiți o partiție $home existentă a altei distribuții pentru că fișierele de configurare din directorul $home vor intra în conflict dacă aveți același nume de utilizator pe distribuții diferite.`** 

<div class="divider" id="adduser"></div>
## Adăugați noi utilizatori (users) la instalarea dvs.

Pentru a adăuga un`nou "user"`  cu permisiune de grup oferită automat, logați-vă ca  *root*  și tastați: 

~~~  
adduser <newuser>  
~~~

Apasă doar pe "enter" și va avea grijă de toate complexitățile. Veți fi rugați să tipăriți parola de două ori.

icon-uri specifice lui  *siduction*  (ca manualul și icon-ul IRC) necesită să fie adăugate manual. 

Să ștergeți un "user", tastați ca  *root* :

~~~  
deluser <user>  
~~~

Citiți de asemenea:

~~~  
man adduser  
man deluser  
~~~

`kuser`  poate crea de asemeni un nou "user", totuși va trebui să ajustați permisiunea de grup pentru acel "user" manual.

<div class="divider" id="sux"></div>
## Despre  *sux* 

 Multe comenzi trebuie executate ca administrator adică  *'root'* . Comanda care face această trecere este: 

~~~  
sux  
~~~

 Cu toate că  *'su'*  este comanda obișnuită pentru a deveni administrator, folosirea comenzi `sux`  vă va permite să rulați aplicații de tip GUI/X11 din linia de comadă și permite administratorului să pornească aplicații grafice în numele utilizatorului care o lansează, întru-cât `sux`  este un  *wrapper*  al comenzii standard  *su* , care permite transferul credențialelor X către utilizatorul care o lansează.

Unele aplicații KDE necesită `dbus-launch`  înaintea numelui aplicației:

~~~  
dbus-launch <nume_aplicatie>  
~~~

 Exemple de utilizare de aplicații X11, prin  *'sux'* , sunt lansarea de editoare precum  *kwrite*  sau  *kate* , partiționarea cu  *gparted*  sau utilizarea unui manager de fișiere ca  *konqueror* . Se poate deasemenea folosi pentru modificarea de fișiere, cu un clik-dreapta, alegerea 'edit-as-root' cu promt de parolă de root care, în background, apelează transparent la comanda  *'kdesu'* .

 Toate acestea spre deosebire de  *'sudo'* , care permite oricui are acces la tastatură să scrie  *'sudo'*  și să facă schimbări în sistem foarte probabil nedorite sau nefaste.

**` ATENȚIE: O dată logat ca utilizator  *root* , sistemul nu vă va înpiedica să faceți lucruri care pot periclita sistemul ca de exemplu ștergerea de fișiere importante, etc ..., deci trebuie să fiți absolut siguri de ceeea ce vreți să faceți, întru-cât riscul de a vă ruina sistemul este maxim.`**

**` În nici un caz, nu trebuie să executați ca  *root*  în consolă/terminal aplicații tipice pentru un utilizator normal, ca de exemplu trimiterea de email-uri, crearea de spreadsheets sau navigarea pe net și așa mai departe.`**

<div id="rev"> Content last revised 30/11/2012 0230 UTC</div>
