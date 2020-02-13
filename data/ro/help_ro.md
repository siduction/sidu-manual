<div id="main-page"></div>
<div class="divider" id="help-gen"></div>
## De unde primiţi Ajutor

Să primeşti ajutor la timp este diferenţa dintre a sfârşi în lacrimi şi a continua cu ceea ce este important pentru voi.Vă oferim câteva direcții despre unde şi cum veţi primi ajutorul pe care siduction îl oferă ca distribuţie:

+  [Forum-urile şi Wiki](help-ro.htm#for-wiki)   
+  [IRC](help-ro.htm#irc)   
+  [Unelte de folosit în 'text mode' (tty) și 'init 3'](help-ro.htm#init3-tools)    
+  [Utilizarea IRC în 'text mode' și/sau 'init 3'](help-ro.htm#irc-init3)    
+  [Web browsing în 'text mode' și/sau 'init 3'](help-ro.htm#init3-web)    
+  [inxi](help-ro.htm#inxi)   

<div class="divider" id="for-wiki"></div>
## Forum-uri siduction

Forum-urile siduction oferă un loc pentru plasarea de întrebări şi primirea de răspunsuri la ele dar vă rugăm mai întâi căutaţi în forum dacă nu există deja răspuns la probleme similare.  [Forum-ul](http://siduction.org)  este în limba engleză.

#### Wiki 

siduction Wiki este liber de folosit şi editat de către toţi utilizatorii. Noi sperăm că documentaţia siduction va crește în timp şi se va perfecţiona odată cu proiectul.

Sperăm deasemeni în ajutorul utilizatorilor de Linux mai experimentaţi deoarece wiki are ca scop ajutorul utilizatorilor de toate nivelele. Câteva minute petrecute în wiki poate salva alţi utilizatori (şi poate pe tine însuți) care au nevoie de soluţii, de ore întregi de necazuri şi căutări.  [Wiki](http://wiki.siduction.org) .

<div class="divider" id="irc"></div>
## Ajutor în direct cu IRC 

### Protocoale IRC 

**`Niciodată nu intraţi pe IRC ca 'root' .. sunteţi binevenit ca utilizator dar niciodată ca root: dacă aveţi necazuri spuneţi imediat. `**

### Conectarea la canalul #siduction 

Sunt 2 metode de a primi ajutor în direct:  
1) Daţi clic pe `icoana siduction-irc`  de pe ecran sau folosiţi un alt client de chat  
2) Daţi clic pe `Meet the Team`  în meniul din  [pagina siduction](http://siduction.org) 

#### Konversation

Cea mai uşoară cale este să daţi clic pe `iconul siduction-irc`  de pe desktop sau să folosiţi Kmenu cu konversation preconfigurat.

Dacă preferaţi un alt client de chat setaţi serverul să se conecteze la:

~~~  
irc.oftc.net  
port 6667  
~~~

<div class="divider" id="paste"></div>
## Comanda !paste

### Camanda siduction-paste

Camanda siduction-paste permite să 'paste' output-ul unui fișier dintr-un terminal sau o consolă tty, deci foarte utilă în situații dificile în faza de 'init 3'. siduction-paste folosește ca link adresa http://rafb.net, cu o durată de 24 de ore.

 siduction-paste poate fi lansată ca root sau utilizator dar trebuie notat că anumite output-ri necesită lansarea ca root.

~~~  
siduction-paste <fișier>  
 sau   
siduction-paste -c "command1 --options parameters ; command2"  
~~~

###### Example de siduction-paste &lt;fișiere&gt;

~~~  
siduction-paste /etc/fstab  
Fișierul paste se gasește aici : http://rafb.net/p/n8miQp85.html  
~~~

Acest link `http://rafb.net/p/n8miQp85.html`  trebuie apoi prezentat pe canalul IRC #siduction

###### Exemple de siduction-paste 

~~~  
fdisk -l | siduction-paste  
Fișierul paste se gasește aici http://rafb.net/p/ZrhlVc59.html  
~~~

Acest link `http://rafb.net/p/ZrhlVc59.html`  trebuie apoi prezentat pe canalul IRC #siduction 

Puteţi deasemenea să faceţi capturi de ecran şi să le daţi paste.

~~~  
siduction-paste -s  
~~~

Aveţi puţine secunde pentru a muta cursorul la obiectul pe care doriţi sa il capturaţi. Nu uitaţi, pentru ca aceasta să funcţioneze trebuie sa fie instalat programul scrot.

<div class="divider" id="init3-tools"></div>
## Unelte de folosit în 'text mode' (tty) și 'init 3' 

De obicei sunteţi în 'text mode'/'init 3' din cauză că faceţi 'dist-upgrade' (sau ceva nu a mers bine deloc în sistemul dumneavoastră). 

#### gpm

O unealtă foarte necesară în 'text mode' este `gpm` . Aceasta vă va permite să folosiţi mouse-ul pentru a face `copy` şi `paste` între console.

Pentru a activa `gpm:`  

~~~  
gpm -t imps2 -m /dev/input/mice  
~~~

Asiguraţi-vă că fişierul /etc/gpm.conf este prezent

~~~  
/etc/init.d/gpm restart  
~~~

Acum veţi avea un cursor de mouse în 'text mode' (tty).

#### Navigarea în fișiere și editarea textelor

Midnight Commander este o aplicație în 'text-mode' (tty) administrator de fișiere în full-screen și editor de text ce vine instalat cu distribuția și nu este greu de folosit.

În afară de comenzile normale de la tastatură răspunde de asemenea la click-urile de mouse pentru navigare datorită lui gpm.

Cu `mc`  puteți naviga prin sistem iar cu `mcedit`  apare o foaie goală sau puteți merge direct într-o foaie.

Examplu de a edita direct o filă:

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

Astfel puteți edita, modifica și salva modificările pentru a avea efect imediat.

Pentru mai multe informații citiți:

~~~  
man mc  
~~~

<div class="divider" id="irc-init3"></div>
### Accesarea irc #siduction în 'text mode' şi/sau 'init 3'

**`Niciodată nu intraţi pe IRC ca 'root', sunteţi binevenit ca utilizator dar niciodată ca root: dacă aveţi necazuri spuneţi imediat. `**

#### irc în 'text mode' şi/sau 'init 3'

Programul se numește irssi.

 Aflat în init 3, se poate schimba consola prin:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <numele_utilizatorului> <parola> (ca utilizator, nu ca root)    
apoi scrieți comanda    
$ siduction-irc (va demara irssi)    
~~~
  
 sau dacă e nevoie instalați un alt client ca de exemplu weechat:

~~~  
# apt-get install weechat-curses  
~~~

Când sunteţi în init 3, puteţi trece în altă consolă cu:

~~~  
# CTRL-ALT-F2  
$ siductionbox login : <numele_utilizatorului> <parola> (ca utilizator, nu ca root)    
apoi scrieți comanda    
$ weechat-curses    
~~~
  
Acum conectaţi-vă la irc.oftc.net pe portul 6667. Odată conectat schimbaţi nickname prin comanda:

~~~  
/nick alegeți_un_nume_de_utilizator  
~~~

Pentru a vă alătura canalului siduction:

~~~  
/join #siduction  
~~~

Dacă doriţi să vă conectaţi la alt server:

~~~  
/server server.name  
~~~

În bara de jos veţi vedea numere dacă există activitate pe canale, pentru a schimba canalele, ALT-1 ALT-2 ALT-3 ALT-4 etc....

Ca să iesiţi,

~~~  
/exit  
~~~

Dacă faceţi dist-upgrade, de exemplu, pentru a verifica progresul

~~~  
iar de exemplu pentru a reveni la d-u  
$ CTRL-ALT-F1  
iar pentru a reveni la irc  
# CTRL-ALT-F2  
~~~

 [Documentația WeeChat](http://www.weechat.org/) 

<div class="divider" id="init3-web"></div>
#### Navigarea pe net în 'text mode' şi/sau 'init 3'

wm3 oferă posibilitatea să navigaţi dintr-un consolă/terminal sau text mode şi/sau init 3

Verificaţi dacă w3m este instalat, dacă nu executaţi:

~~~  
apt-get update  
apt-get install w3m  
~~~

Deschideţi un terminal/consolă:

~~~  
$ w3m URL  
 sau   
w3m ?  
 sau   
w3m siduction.org  
~~~

Odată ce aveţi un ecran negru cu instrucţiuni la bază, `nu vă panicaţi ,`  folosiţi combinaţia de taste 

~~~  
SHIFT+U  
~~~

Veţi vedea atunci că se va deschide către discul local, ceva gen Goto URL: file:///home/username/$, daţi backspace până la GOTO URL şi tastaţi: 

~~~  
http://siduction.org  
~~~

Puteţi acum naviga la  [siduction.org](http://siduction.org)  sau orice altă pagină la alegere. 

Sau când sunteţi în init 3:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <numele_utilizatorului> <parola> (ca utilizator, nu ca root)    
apoi scrieți comanda    
$ w3m siduction.org    
Pentru trecerea la consolă cu d-u de exemplu folosim    
$ CTRL-ALT-F1    
~~~
  
Pentru a merge direct la manual:

~~~  
$w3m manual.siduction.org  
~~~

 [w3m home page](http://w3m.sourceforge.net/) 

###### `Este recomandabil să vă familiarizați singuri cu utilizarea elinks/w3m, irssi/weechat și midnight commander înaite să se întâmple o urgență, dacă va apre vre-o una. Această pagină ar fi bine s-o aveți printată ca un reper pentru cum să primim ajutor online în asemenea urgențe` 

<div class="divider" id="inxi"></div>
## Inxi

inxi este un script cu care obținem informaţii despre sistem, independent de un anumit client IRC (Internet Relay Chat) . Scriptul poate afişa tot felul de informaţii despre hardware şi software-ul deţinut necesare oamenilor din canalul de conversație, ei putând astfel să vă ajute în diagnosticarea și rezolvarea problemelor , ... sau pur şi simplu să vă admire specificaţiile de sistem şi de kernel cât timp sunteţi activ prin intermediul consolei . 

Pentru a utiliza `inxi`  în Konversation scrieți în căsuța de chat:

~~~  
/cmd inxi -v1  
~~~

Pentru a utiliza `inxi`  cu alți clienți de IRC scrieți în căsuța de chat:

~~~  
/exec -o inxi -v1  
 sau   
/inxi -v1  
/shell -o inxi -v1 (weechat)  
~~~

În consolă tastaţi:

~~~  
inxi -v1  
~~~

Citiţi tutorialul complet inxi

~~~  
inxi --help  
~~~

<div class="divider" id="links"></div>
## Linkuri Utile

###### Documentaţie Generală Linux

 [debian.org/doc/user-manuals](http://www.debian.org/doc/user-manuals#apt-howto) 

 [Debian Reference Card - to print on a single page](http://www.debian.org/doc/user-manuals#refcard) 

 [debian.org/doc/#howtos](http://www.debian.org/doc/#howtos) 

 [Debian basics, installation and system administration](http://qref.sourceforge.net/index.en.php)  document disponibil în HTML, text, PDF sau PS în limbi diferite

 KDE Help Centre în siduction are un Help intern pentru Printing/CUPS, altfel vedeţi  [Common Unix Printing System CUPS](http://www.cups.org/) 

 [LibreOffice](http://ro.libreoffice.org/) 

<div id="rev">Page last revised 30/11/2012 1050 UTC </div>
