<div id="main-page"></div>
<div class="divider" id="live-cd-upgrade"></div>
## Actualizare cu live-cd

Posibilitatea de a face actualizare cu un live-cd unui sistem siduction instalat nu există. Înainte de a începe instalarea siduction **`SALVAŢI-VĂ DATELE! inclusiv bookmark-urile şi email-urile.`** 

`Este foarte recomandat să aveţi o partiţie separată pentru date. Beneficiile în termenii recuperării datelor după un dezastru precum şi pentru stabilitatea lor sunt incomensurabile.`

De aceea dosarul $HOME devine locul unde sunt ţinute configurările aplicaţiilor de bază sau altfel spus, un container unde aplicaţiile stochează setările proprii.

**`ÎNTOTDEAUNA SALVAŢI-VĂ DATELE inclusiv bookmark-urile şi email-urile!`**

<div class="divider" id="hd-upgrade"></div>
## Actualizarea (upgrade) unui Sistem instalat pe Hard Disk

Aţi făcut upgrade la sistemul ce-l aveaţi instalat cu ultimul Live-Cd şi doriţi să vă asiguraţi că aveţi ultimele versiuni ale pachetelor instalate precum şi ultimele update-uri de securitate.

În siduction aceasta se numeşte  *'dist-upgrade'*  şi se face de pe internet.

` **Singura metodă de  *dist-upgrade*  suportată este următoarea:** `

<div class="box block">
**ABSOLUT NICIODATĂ să nu faceţi <i>'dist-upgrade'</i> şi nici măcar <i>'upgrade'</i> în timp ce lucraţi în X<div class="highlight-4"> Întotdeauna verificaţi  *Current Warnings*  de pe pagina principală  [siduction](http://siduction.org) . Aceste avertismente există acolo cu un motiv bine întemeiat şi din cauza naturii  *unstable*  şi a update-ului zilnic.**

~~~  
## Log out din KDE.  
## Intrați în Textmode folosind combinația Ctrl+Alt+F1  
## logați-vă ca  root , apoi tipăriți:  
init 3  
apt-get update  
apt-get dist-upgrade  
apt-get clean  
init 5 && exit  
~~~

**NICIODATĂ NU FACEŢI DIST-UPGRADE [sau UPGRADE] cu  *adept* ,  *synaptic*  sau  *aptitude*   [VEDEŢI Upgrade-ul unui Sistem Instalat](sys-admin-apt-ro.htm#apt-upgrade)**

#### Motivele pentru care NU TREBUIE să folosiţi altceva în afară de  *apt-get*  pentru  *dist-upgrade* 

Managere de pachete ca  *adept* ,  *aptitude* ,  *synaptic*  şi  *kpackage*  nu sunt capabile întotdeauna să contorizeze enorm de multele schimbări care se întâmplă în SID (schimbări de dependenţe, de nume, schimbări de scripturi de întreţinere, ...). Nu este vina dezvoltatorilor şi nici a programelor pe care aceştia le fac, totuşi ei fac unelte excelente pentru ramura debian stable, acestea pur şi simplu nu se potrivesc perfect cu nevoile speciale din Debian SID.

Utilizaţi orice doriţi pentru a căuta pachete dar rămâneţi fermi în a folosi doar  *apt-get*  pentru procesele de instalare/ştergere/dist-upgrade

Managere de pachete ca  *adept* ,  *aptitude* ,  *synaptic*  şi  *kpackage*  sunt, până la urmă, incerte (pentru selecţie complexă de pachete), adăugaţi la aceasta o ţintă mereu în mişcare precum sid şi poate un şi mai rău repozitoriu extern de o calitate îndoielnică (noi nu recomandăm acestea dar ele sunt o realitate printre utilizatori) şi veţi fi condusi la dezastru. Un alt lucru care trebuie ţinut minte este că toate aceste tipuri de managere de pachete cu GUI trebuiesc rulate în  *init 5* , şi/sau în X, iar dacă faceţi un  *dist-upgrade*  în  *init 5*  şi/sau X, (unde nici măcar un  *'upgrade'*  nu este recomandat), veţi sfârşi prin a aduce daune ireparabile sistemului dumneavoastră, nu neaparat azi sau mâine, dar în timp sigur.

Pe de altă parte,  *'apt-get'*  face exact ce i se cere să facă. Dacă există vreo scăpare pe care aţi identificat-o puteți s-o depanaţi/reparaţi. Dacă  *'apt-get'*  vrea să îndepărteze jumătate din sistem (ca urmare a tranziţiilor librăriilor) este atenționat administratorul (adică a dumneavoastră) și ar trebui măcar să analizaţi cu atenţie înainte de a lua o decizie.

Acesta este motivul pentru care debian foloseşte  *apt-get*  şi nu alte managere de pachete.

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
