<div id="main-page"></div>
<div class="divider" id="start-services"></div>
## Activarea serviciilor în siduction

### *insserv*  : Pentru start/stop servicii deja instalate:

**`Citiți cu atenție `/usr/share/doc/insserv/README.Debian` , notele versiunii curente și paginile de manual:`** 

~~~  
$ man insserv  
$ man invoke-rc.d  
$ man update-rc.d  
google LSB headers  
~~~

Pentru 'start':

~~~  
/etc/init.d/<nume_serviciu> start  
~~~

Pentru 'stop':

~~~  
/etc/init.d/<nume_serviciu> stop  
~~~

Pentru 'restart:

~~~  
/etc/init.d/<nume_serviciu> restart  
~~~

Pentru prevenirea rulării serviciilor la pornire:

~~~  
update-rc.d <nume_serviciu> remove  
[va șterge toate link-urile de startup]  
~~~

Pentru a fi siguri că un serviciu rulează la boot-are [nu-i necesar întotdeauna]:

~~~  
update-rc.d <nume_serviciu> defaults  
[crează link-uri de startup]  
~~~

Pentru a citi lista serviciilor care rulează:

~~~  
ls /etc/rc5.d  
~~~

`S`  înseamnă că service-ul va porni.  
`K`  înseamnă că service-ul nu va porni.

<div class="divider" id="bum"></div>
## Managerul Boot-Up (bum) - Unealtă Grafică de configurare a serviciilor

Dacă logica secvenței de boot-are a unui sistem debian nu-ți este foarte clară și familiară, n-ar trebui să te joci cu symlink-uri, permisiuni și altele. Înainte de ați strica sistemul  *'Boot-Up Manager'*  te va ajuta să-ți automatizezi configurarea.

 *Boot-Up Manager*  este un editor grafic de configurare a runlevel-elor care vă permite să configurați care  *init services*  sunt invocate când sistemul boot-ează sau reboot-ați. Afișează o listă cu toate serviciile care pot fi pornite la boot-are. Puteți seta individual fiecare serviciu pe  *'on'*  și  *'off'* .

~~~  
apt-get install bum  
~~~

Utilizarea  *Boot-Up Manager*  GUI:

~~~  
$ sux  
password:  
bum  
~~~

  [Documentația Detaliată a Boot-Up Manager (bum)](http://www.marzocca.net/linux/bumdocs.html) . 

<div class="divider" id="pkill"></div>
## Omorârea unui serviciu sau proces

`pkill`  este foarte util fiind prietenos și poate lucra în modul user și root într-un terminal sau tty

~~~  
pkill -n <nume_serviciu>  
~~~

Dacă nu sunteți sigur de ortografia corectă a procesului sau serviciului pe care vreți să-l omorâți `pkill <tab> <tab>`  vă va oferi o listă

 *htop*  este de asemenea o bună alternativă. ( *killall -9* este ultima voastră alternativă)

<div class="divider" id="init"></div>
## Nivelele de rulare în siduction - init

Aceasta este lista din sistemul de operare siduction pentru runlevels.Observaţi că acestea diferă de runlevels din debain stable :

| Runlevel | siduction | Debian | 
| ---- | ---- | ---- |
|  **init 0**  |  Oprește PC-ul. |  Oprește PC-ul. | 
|  **init 1**  | Single user (safety mode). Demoni ca apache și sshd sunt stopați. Nu intrați în acest nivel via acces de la distanță. | Single user (safety mode). Demoni ca apache și sshd sunt stopați. Nu intrați în acest nivel via acces de la distanță. | 
|  **init 2**  |  Multi-User mode cu rețeaua în funcțiune, fără rularea X-windows, și/sau pentru a opri sau a nu intra în X-windows | Runlevel-ul de bază Debian pentru modul Multi-User cu rularea network și a X-Window System. | 
|  **init 3**  |  Multi-User mode cu rețeaua în funcțiune, fără rularea the X-Window System, și/sau pentru a opri sau a nu intra în the X-Window System.  [În acet nivel va fi acționat  *dist-upgrade*](sys-admin-apt-ro.htm#apt-upgrade) . | La fel ca runlevel 2 / init 2. | 
|  **init 4**  |  Multi-User mode cu rețeaua în funcțiune, fără rularea X-Window System, și/sau pentru a opri sau a nu intra în X-Window System. | La fel ca runlevel 2 / init 2. | 
|  **init 5**  | Runlevel-ul de bază în siduction pentru modul Multi-User cu rețeaua în funcțiune, cu X-Window System și/sau pentru pornirea X-Window System. | La fel ca runlevel 2 / init 2. | 
|  **init 6**  |  Restartează/reboot-ează sistemul. |  Restartează/reboot-ează sistemul. | 
|  **init S**  |  Unde sunt executate serviciile în primele secvențe ale boot-ării într-o 'once only basis'. Nu puteți comuta la acest nivel după ce acesta a fost rulat. | Unde sunt executate serviciile în primele secvențe ale boot-ării într-o 'once only basis'. Nu puteți comuta la acest nivel după ce acesta a fost rulat. | 


---

Pentru a verifica în care  *runlevel*  (init) sunteți, tastați:

~~~  
who -r  
~~~

Administratorii de sisteme siduction și Debian trebuie să citească despre  *runlevels*  în:

~~~  
man init  
~~~

<div class="divider" id="pw-lost"></div>
## Parolele de root pierdute

Nu puteţi recupera o parolă pierdută dar puteţi seta una nouă.

Porniţi de pe Live-CD.

Ca utilizator  *root*  mount-aţi partiţia root (de exemplu /dev/sdb2)

~~~  
mount /dev/sdb2 /media/sdb2  
~~~

Acum  *'chroot'*  în vechea partiție root și setați o nouă parolă:

~~~  
chroot /media/sdb2 passwd  
~~~

<div class="divider" id="pw-new"></div>
## Setarea unor parole noi

Pentru schimbarea parolei voastre de utilizator executați ca `$ user` :

~~~  
$ passwd  
~~~

Pentru schimbarea parolei voastre de  *'root'*  executați ca `# root` :

~~~  
passwd  
~~~

Ca administrator puteți schimba parola altui utilizator executând ca `# root` :

~~~  
passwd <nume_utilizator>  
~~~

<div class="divider" id="fonts"></div>
## Fonturi în siduction

###### Setările dpi corecte - Filozofia de bază

Setările DPI sunt foarte greu de ghicit, dar sunt realizate perfect la ora actuală de către X.

###### Rezoluţiile şi Ratele de Refresh corecte

Orice monitor are o combinaţie perfectă a setărilor dar, din păcate, nu toate monitoarele raportează corect valorile DCC şi uneori este nevoie de intervenţia manuală pentru a le corecta.

<!--###### Driverele corecte ale adaptoarelor grafice

Unele plăci grafice mai noi de la ATI şi Nvidia pur şi simplu nu funcţionează corect cu driverele free Xorg şi singura soluţie rezonabilă în astfel de cazuri rămâne instalarea driverelor comerciale, closed source.Din motive legale siduction nu va face pre-instalarea acestor drivere,  [Soluţia poate fi găsită aici.](gpu-ro.htm) 

-->
##### Selectare font-urilor implicite, a renderizării şi mărimiilor 

siduction utilizează fonturi pre-selectate (Debian) care s-au dovedit a fi foarte echilibrate, selectarea unor fonturi proprii pot/ar putea deteriora calitatea imaginii. Dar în Debian există şi câteva opţiuni puternice (prin KDE>systemsettings) care să vă ajute să obţineţi o imagine corectă şi cu alte fonturi.Trebuie să reţineţi că fiecare font are doar câteva dimensiuni perfecte, alte dimensiuni e posibil să nu funcţioneze foarte bine.

Ajustarea mărimii dpi cu această comandă vă poate fi deasemeni de ajutor:

~~~  
fix-dpi-kdm  
~~~

Vă va arăta DPI potrivit mărimii ecranului dumneavoastră dar şi acestea pot fi modificate. Va trebui să intraţi în  *init 3*  şi apoi înapoi în  *init 5*  pentru a funcţiona sau să restartaţi computerul.

 După ce aţi schimbat tipul de font sau DPI (în X sau Firefox/Iceweasel), e posibil să aveţi nevoie de unele ajustări pentru a ajunge la rezultatul dorit şi în special după schimbarea din Bitmap Fonts în True Type Fonts sau altceva, prin:

~~~  
dpkg-reconfigure fontconfig-config  
~~~

Alegeţi  *native*  şi  *autohinter*  pe  *automatic* . Mai puteţi încerca şi altele.

Dacă acestea nu funcţionează va trebui să refaceţi  *font cache*  prin:

~~~  
apt-get install --reinstall --yes -o DPkg::Options::=--force-confmiss -o DPkg::Options::=--force-confnew fontconfig fontconfig-config  
~~~

##### Aplicaţii bazate pe GTK precum Firefox/Icewasel

Aplicaţiile bazate pe GTK sunt în general problematice cu setările KDE implicite. Aceasta se poate rezolva prin:

~~~  
apt-get install gtk2-engines system-config-gtk-kde gtk-qt-engine gtk2-engines-qtcurve  
~~~

În `System Settings ->Appearance`  veți avea în menu o nouă intrare numită `GTK Styles and Fonts` . Setați 'GTK Styles' să folosească 'Clearlooks' și având 'GTK Fonts' setat să folosească 'KDE fonts' `sau`  experimentați cu diverse opțiuni pentru a vă satisface preferințle.

Astfel S-AR PUTEA înlătura problemele legate de  *font rendering*  în aplicațiile gtk 

<div class="divider" id="cups"></div>
## CUPS

KDE deţine o întreagă secţiune în KDE help, totuşi, de multe ori  *dist-upgrade*  face ca  *cups*  să se manifeste ciudat, iată o soluţie cunoscută:

~~~  
modprobe lp  
echo lp >> /etc/modules  
apt-get remove --purge cupsys cups  
apt-get install cups  
SAU  
apt-get install cups cups-driver-gutenprint hplip  
~~~

Asiguraţi-vă că rulează CUPS:

~~~  
/etc/init.d/cups restart  
~~~

 Apoi într-un web browser: 

~~~  
http://localhost:631  
~~~

Un alt fapt se întâmplă când setaţi CUPS prin metoda GUI (grafică), vi se va afişa o fereastră de dialog cerând să introduceţi parola, această fereastră având deja scris numele dumneavoastră de utilizator iar dacă scrieţi parola de utilizator nu va funcţiona. Ceea ce trebuie să faceţi este să schimbaţi numele de utilizator în **`root`**  iar mai departe scrieţi **`parola de  *root*`** .

 [The OpenPrinting database](http://www.linuxfoundation.org/collaborate/workgroups/openprinting/database/databaseintro)  conține o bogată gamă de informații specifice pentru diverse imprimante, împreună cu amănunte despre drivere, driver-ele în sine, specificațiile de bază și diferite seturi cu unelte de configurare asociate lor. 

<div class="divider" id="sound"></div>
## Sunetul în siduction

`Sunetul în siduction este  *'muted'*  implicit.` 

Versiunea KDE folosește  *Kmix*  iar XFCE folosește  *Mixer* .

De fapt este doar o chestiune de dat click pe icon-ul sound icon în taskbar și debifați în căsuța  *'Mute'* .

###### Kmix

În  *Kmix*  veți avea nevoie să activați opțiunile preferate pentru  *channel options* , `Kmix ->Setting ->Configure Channels.`  Sau într-un terminal:

~~~  
$ kmix  
~~~

###### XFCE

În XFCE rulați aplicația mixer și adăugați unele controale via `Multimedia ->Mixer`  și click pe căsuța `Select Controls.`  Sau într-un terminal:

~~~  
$ xfce4-mixer  
~~~

### Alsamixer

Dacă preferați utilizarea  *Alsamixer* , acesta este în pachetul  *alsa-utils* :

~~~  
apt-get update  
apt-get install alsa-utils  
exit  
~~~

Faceți setările preferate ca **`$user`**  dintr-un terminal:

~~~  
$ alsamixer  
~~~

<!--p> [Vezi și pe wiki.](http://sidux.com/index.php?module=Wikula&amp;tag=SoundMaster) </p> -->
<div id="rev">Content last revised 20/04/2011 0830 UTC</div>
