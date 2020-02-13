<div id="main-page"></div>
<div class="divider" id="home-bu"></div>
## Salvarea - mutarea partițiilor personale ( */home* )

Înainte de a muta partiția`/home`  va trebui să faceți o copie de siguranță ( *back up* ) prin arhivare a tot ce este în directorul`/home`  (ca  *'root'* ) astfel: 

~~~  
tar cvzpf undeva/home.tar.gz /home  
~~~

Pentru a extrage arhiva:

~~~  
tar xvpf undeva/home.tar.gz  
~~~

 [O altă metodă de a efectua "backing up" ar fi să folositi  *'rdiff'* .](sys-admin-rdiff-ro.htm#rdiff) 

<!-- [Această metodă vă poate fi de folos dacă vreți să "actualizați home-ul vostru" din instalări mai vechi în noi instalări.](http://sidux.com/index.php?module=Wikula&amp;tag=SecureHomeEN) 

-->
<div class="divider" id="home-move"></div>
## Mutarea /home

**`Nu utilizați sau share-uiți o partiție $home existentă a altei distribuții pentru că fișierele de configurare din directorul home vor intra în conflict dacă aveți același nume de utilizator pe distribuții diferite.`** 

Mutarea sau utilizarea unei partiții existente siduction /home poate fi făcută în două feluri, una cu "live cd", alta în linie de comandă, ambele fiind ușoare.

Deoarece sistemul necesită  [informația UUID](part-uuid-ro.htm#uuid) , va trebui să obtineți "uuid" al noii partiționări, dacă nu le aveți deja notate.

Cea mai ușoară metodă este să adăugați această nouă informație, modificând fișierul `/etc/fstab` .

Reporniți PC-ul și în "grub box" al menu-ului grub tastați 1 și apoi apăsați tasta enter. Această acțiune vă va duce în "init 1" (runlevel), care este "single user" și partiția curentă "home" nu este folosită, Deci este în siguranță să lucrați cu ea.

La promptul  *tty* , logați-vă ca  *root*  și instalați-vă noua dvs. partiție  */home* , de exemplu:

~~~  
mount /dev/sdxX /media/new-home  
 *(sau oricare alta partitie noua dvs. "home" urmează să fie)*   
cp -pr /home /media/new-home  
~~~

Apoi editați fișierul `/etc/fstab`  pentru a reflecta noua locație a partiției  */home*  astfel: 

~~~  
mcedit /etc/fstab  
~~~

Acum `đecomentați (ștergeți semnul #)`  unde este noua partiție  */home*  și `comentați (adăugați #)`  în dreptul vechii partiții  */home* . Salvați cu F2, ieșiți cu F10 apoi dați comanda  *'reboot'* .

<div id="rev">Content last revised 30/11/2012 0830 UTC </div>
