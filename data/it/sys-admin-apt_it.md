<div id="main-page"></div>
<div class="divider" id="apt-cook"></div>
## Un piccolo ricettario-guida per APT

### Cosa significa APT?

APT è una abbreviazione per "Advanced Packaging Tool" (cioè, strumento avanzato di manipolazione di pacchetti) ed è una raccolta di programmi e script che aiutano l'amministratore del sistema (nel vostro caso: root) nell'installazione e la gestione dei file .deb, e nel contempo il sistema stesso a sapere cosa viene installato.

<div class="divider" id="sources-list"></div>
## Sorgenti Software

Il sistema "APT" necessita di un file di configurazione che contiene le informazioni sulle ubicazioni dei pacchetti installabili e aggiornabili, il quale è comunemente denominato `sources.list` .

Le sorgenti sono contenute nella directory o nella cartella:  
`/etc/apt/sources.list.d/` 

Nella directory ci sono due file:  
`/etc/apt/sources.list.d/debian.list`   
`/etc/apt/sources.list.d/siduction.list` 

Ciò offre il vantaggio di un facile (automatizzato) cambio dei mirror e rende più sicuro sostituire le liste.

Si può anche aggiungere un file personale `/etc/apt/sources.list.d/*.list` .

### Tutte le ISO di siduction usano in via predefinita le seguenti fonti software:

~~~  
# Free University Berlin/ spline (Student Project LInux NEtwork), Germany  
ftp://ftp.spline.de/pub/siduction/debian/ sid main fix.main  
rsync://ftp.spline.de/siduction/iso  
deb ftp://ftp.spline.de/pub/siduction/base unstable main  
deb ftp://ftp.spline.de/pub/siduction/fixes unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/base unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/fixes unstable main  
~~~

Ulteriori indirizzi di depositi opzionali si possono trovare in  [siduction repositories](http://packages.siduction.org) :

~~~  
#Debian  
# Unstable  
deb http://ftp.us.debian.org/debian/ unstable main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ unstable main contrib non-free  
# Testing  
#deb http://ftp.us.debian.org/debian/ testing main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ testing main contrib non-free  
# Experimental  
#deb http://ftp.us.debian.org/debian/ experimental main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ experimental main contrib non-free  
~~~

NOTA: In questo esempio ftp.us indica l'uso di depositi software USA. Si può modificare questo file, come root, per usare depositi fisicamente più vicini, semplicemente cambiando il paese, ad esempio ftp.us in ftp.it o ftp.uk. La maggior parte dei paesi hanno dei mirror locali, il che consente di preservare la banda e aumentare la velocità.

 [Lista dei server Debian e stato attuale dei mirror](http://www.debian.org/mirrors/) .

Per riuscire a gestire le informazioni aggiornate sui pacchetti, APT usa un database. Questo contiene i pacchetti e anche l'elenco degli altri pacchetti necessari per poterli far funzionare (detti: dipendenze). Quando installa i pacchetti da voi prescelti il programma apt-get usa questo database per risolvere le dipendenze e conseguentemente garantire che il singolo pacchetto possa poi funzionare correttamente. L'aggiornamento del database è eseguito con il comando apt-get update:

~~~  
# apt-get update  
(che dà come risultato)  
Get:1 http://siduction.com sid Release.gpg [189B]  
Get:2 http://siduction.com sid Release.gpg [189B]  
Get:3 http://siduction.com sid Release.gpg [189B]  
Get:4 http://ftp.de.debian.org unstable Release.gpg [189B]  
Get:5 http://siduction.com sid Release [34.1kB]  
Get:6 http://ftp.de.debian.org unstable Release [79.6kB]  
...  
Fetched 823 kb in 12 s (64 kb/s)  
Reading package lists... Done  
~~~

<div class="divider" id="apt-install"></div>
## Installare un nuovo pacchetto

Presumendo che il database di APT sia aggiornato e il nome del pacchetto sia conosciuto, il comando di seguito riportato installa un pacchetto chiamato qemu, per esempio, e tutte le sue dipendenze (più avanti vedrete come cercare e trovare pacchetti).

~~~  
# apt-get install qemu  
Reading package lists... Done  
Building dependency tree... Done  
The following extra packages will be installed:  
bochsbios openhackware proll vgabios  
Recommended packages:  
debootstrap vde  
The following NEW packages will be installed:  
bochsbios openhackware proll qemu vgabios  
0 upgraded, 5 newly installed, 0 to remove and 20 not upgraded.  
Need to get 4152kB of archives.  
After unpacking 11.9MB of additional disk space will be used.  
Do you want to continue [Y/n]? n  
~~~

<div class="divider" id="apt-delete"></div>
## Cancellare un pacchetto

Allo stesso modo non dovrebbe sorprendere che il comando seguente disinstalli un pacchetto, anche se non ne rimuoverà le dipendenze:

~~~  
apt-get remove gaim  
~~~

~~~  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim gaim-irchelper  
0 upgraded, 0 newly installed, 2 to remove and 310 not upgraded.  
Need to get 0B of archives.  
After unpacking 4743kB disk space will be freed.  
Do you want to continue [Y/n]?  
(Reading database ... 174409 files and directories currently installed.)  
Removing gaim-irchelper ...  
Removing gaim ...  
~~~

In quest'ultimo caso i file di configurazione del pacchetto "gaim" (fondamentalmente, il suo setup) non sono stati cancellati dal sistema. Potrete utilizzarli nel caso decideste di reinstallare lo stesso pacchetto e questo funzionerebbe come prima.

Se invece volete cancellare anche i file di configurazione, usate questo comando:

~~~  
# apt-get --purge remove gaim  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim  
0 upgraded, 0 newly installed, 1 to remove and 309 not upgraded.  
Need to get 0B of archives.  
After unpacking 4678kB disk space will be freed.  
Do you want to continue [Y/n]? Y  
(Reading database ... 174405 files and directories currently installed.)  
Removing gaim ...  
Purging configuration files for gaim ...  
~~~

Notate l' `*`  dopo il nome del pacchetto nella schermata di apt, il quale indica che verranno rimossi anche i file di configurazione.

<div class="divider" id="apt-downgrade"></div>
## Tornare alla versione precedente o mettere in sospeso un pacchetto

A volte è necessario ritornare a una versione precedente di un pacchetto oppure tenerlo in sospeso a causa di un difetto o di un problema insorto con l'ultima versione installata.

Deve esser chiaro che mettere in sospeso un pacchetto è un'intervento d'emergenza che può ripercuotersi su di voi se dimenticate di rimuovere la sospensione. Ciò è ancor più vero se il pacchetto in sospeso ha molte dipendenze, in quanto queste continueranno a essere aggiornate anche se il pacchetto in sospeso è bloccato. Più importante è il pacchetto, più male farà quando vi cadrà sui piedi. Quindi, attenzione: fatevi da soli un favore usando la sospensione solo per brevi periodi di tempo.

### Tenere in sospeso un pacchetto

~~~  
echo package hold|dpkg --set-selections  
~~~

Rimuovere la sospensione a un pacchetto:

~~~  
echo package install|dpkg --set-selections  
~~~

Elencare i pacchetti in sospeso:

~~~  
dpkg --get-selections | grep hold  
~~~

### Tornare a una versione precedente

 **`Debian non supporta il downgrading di un pacchetto (cioè il ritorno alla sua versione precedente). Anche se l'operazione può avere successo in casi semplici, potrebbe fallire miseramente per altri pacchetti. Fate riferimento a`**  [Emergency downgrading](http://www.debian.org/doc/manuals/reference/ch02.en.html#_emergency_downgrading) .

Ecco i passi necessari per il downgrading di un pacchetto semplice utilizzando `kmahjongg` :

1. commentate con un `#`  le sorgenti "unstable" in `/etc/apt/sources.list.d/debian.list`   
2. Aggiungete le sorgenti "testing" in `/etc/apt/sources.list.d/debian.list` , ad esempio:  
   ~~~    
   deb http://ftp.it.debian.org/debian/ testing main contrib non-free    
   ~~~
  
3. ~~~    
   apt-get update    
   ~~~
  
4. ~~~    
   apt-get install kmahjongg/testing    
   ~~~
  
5. Mettete in sospeso i nuovi pacchetti installati con:  
   ~~~    
   echo kmahjongg hold|dpkg --set-selections    
   ~~~
  
6. commentate &lt;#&gt; le sorgenti testing in /etc/apt/sources.list.d/debian.list e decommentate le sorgenti "unstable" sì da poterne ripristinare l'uso, poi:  
7. ~~~    
   apt-get update    
   ~~~
  

Quando volete avere l'ultima versione del pacchetto, fate semplicemente questo:

~~~  
echo kmahjongg install|dpkg --set-selections  
apt-get update  
apt-get install kmahjongg  
~~~

<div class="divider" id="apt-upgrade"></div>
## Aggiornare l'intero sistema installato - dist-upgrade - Panoramica

L'aggiornamento dell'intero sistema, quando necessario, viene eseguito mediante il comando `dist-upgrade` . Dovreste sempre controllare prima la voce contenente gli avvisi importanti, "Current Warning", sul sito principale di  [siduction](http://siduction.com)  e controllare i "segnali di pericolo" ivi esposti riguardo ai pacchetti che il sistema vuole aggiornare a una versione superiore. Se avete bisogno di `tenere in sospeso`  un pacchetto, fate riferimento a  [Tornare alla versione precedente o mettere in sospeso un pacchetto](sys-admin-apt-it.htm#apt-downgrade) 

Non è raccomandato limitarsi al semplice "upgrade" di debian sid.

##### Frequenza del dist-upgrade

Eseguite dist-upgrade quanto più abitualmente potete, idealmente ogni 1-2 settimane, comunque almeno una volta al mese, per essere al sicuro. Un dist-upgrade ogni 2-3 mesi deve essere considerato un "fuori limite" riguardo alla sicurezza. Per pacchetti non standard o autocompilati dovrete prestare molta più attenzione all'atto dell'aggiornamento perché possono corrompere il sistema in ogni momento a causa di incompatibilità.

Dopo l'aggiornamento del database con `apt-get update`  potrete vedere i pacchetti per i quali sono disponibili nuove versioni (installate prima apt-show-versions):

~~~  
apt-show-versions -u  
libpam-runtime/unstable upgradeable from 0.79-1 to 0.79-3  
passwd/unstable upgradeable from 1:4.0.12-5 to 1:4.0.12-6  
teclasat/unstable upgradeable from 0.7m02-1 to 0.7n01-1  
libpam-modules/unstable upgradeable from 0.79-1 to 0.79-3.........  
~~~

L'aggiornamento di un singolo pacchetto incluse le sue dipendenze può essere fatto (per esempio, per gcc-4.0) con:

~~~  
apt-get install gcc-4.0  
Reading package lists... Done  
Building dependency tree... Done  
gcc-4.0 is already the newest version.  
0 upgraded, 0 newly installed, 0 to remove and xxx not upgraded  
~~~

#### Solo scaricamento

`Un'opzione assai utile ma poco conosciuta per fare un controllo di quali pacchetti sono presenti in un dist-upgrade è il flag -d:`

~~~  
apt-get update && apt-get dist-upgrade -d  
~~~

L'opzione -d permette di scaricare da una console il dist-upgrade senza installarlo mentre si è in X e di eseguirlo in un secondo momento in init 3. Ciò vi offre anche l'opportunità di controllare gli avvisi relativi alla lista e saggiamente vi propone l'opzione di procedere o annullare come qui:

~~~  
apt-get dist-upgrade -d  
Reading package lists... Done  
Building dependency tree  
Reading state information... Done  
Calculating upgrade... Done  
The following NEW packages will be installed:  
elinks-data  
The following packages have been kept back:  
git-core git-gui git-svn gitk icedove libmpich1.0ldbl  
The following packages will be upgraded:  
alsa-base bsdutils ceni configure-ndiswrapper debhelper  
discover1-data elinks file fuse-utils gnucash.........  
35 upgraded, 1 newly installed, 0 to remove and 6 not upgraded.  
Need to get 23.4MB of archives.  
After this operation, 594kB of additional disk space will be used.  
Do you want to continue [Y/n]?Y   
~~~

scegliendo`'Y' (sì)`  i pacchetti saranno scaricati senza toccare il sistema installato.

Dopo che il 'dist-upgrade -d' ha scaricato i pacchetti, se volete completare effettivamente, subito o in un secondo tempo, il dist-upgrade, seguite le istruzioni che seguono:

<div class="divider" id="du-st"></div>
### dist-upgrade - Passi da fare

<div class="box block">
**MAI E POI MAI fate un dist-upgrade o anche un upgrade mentre siete in X.<div class="highlight-4">Controllate sempre i "Current Warnings" sul sito principale di  [siduction](http://siduction.com) . I "segnali di pericolo" esistono a causa della natura instabile di debian sid che può avere anche 4 aggiornamenti in un giorno.**

~~~  
Chiudete la sessione di KDE.  
Andate in modalità testo con Ctrl+Alt+F1  
Autenticatevi come root e poi digitate:  
init 3  
apt-get update  
apt-get dist-upgrade  
apt-get clean  
init 5 && exit  
~~~

**MAI E POI MAI fate DIST-UPGRADE [o UPGRADE] con adept o synaptic.**


---

**`Se non entrate in init 3, tanto peggio per voi: SIETE AVVERTITI!`**

<div class="divider" id="whyno"></div>
### Ragioni per NON utilizzare altro che apt-get o aptitude per il dist-upgrade

I gestori di pacchetti come adept, synaptic e kpackage non sono sempre in grado di tenere conto della grande mole di variazioni che hanno luogo in sid (cambi di dipendenze, di nomi, di script dei manutentori, ...).

 Ciò non è colpa degli sviluppatori degli strumenti di gestione dei pacchetti, che scrivono strumenti eccellenti per la branca stabile di debian. Il fatto è che questi semplicemente non sono adatti alle assai speciali esigenze di debian sid.

Usate dunque quello che volete per cercare un pacchetto, ma tenetevi ben saldi ad apt-get per installare/rimuovere/fare dist-upgrade.

I gestori di pacchetti come adept, synaptic e kpackage sono come minimo non-deterministici (per una selezione complessa di pacchetti): combinate questo fatto con un bersaglio in rapido movimento come debian sid e, anche peggio, con l'uso di depositi sofware esterni di discutibile qualità (che noi non raccomandiamo ma che sono una realtà sui sistemi degli utenti) e sarete sull'orlo del disastro. 

Altra cosa da notare è che questi tipi di gestori di pacchetti in modalità grafica girano in X: facendo un dist-upgrade in X (o anche un non raccomandabile "upgrade"), finirete con il danneggiare il sistema oltre la possibilità di riparazione, forse non oggi o domani, ma comunque in tempo per vederlo.

apt-get invece fa strettamente ciò che gli si chiede: se c'è un qualsiasi danno potete definirlo con esattezza e fare il debug o ripararne la causa. E se volesse rimuovere mezzo sistema (a causa di transizioni di librerie) è il momento di invocare l'amministratore affinché venga a dare una seria occhiata al tutto.

È questa la ragione per cui le derivate di debian usano apt-get e non gli altri gestori di pacchetti.

<div class="divider" id="apt-cache"></div>
## Cercare un pacchetto con apt-cache

Altro comando molto utile nel sistema APT è apt-cache, il quale cerca nel database di APT e mostra le informazioni sui pacchetti. Ad esempio, potrete ottenere una lista di tutti i pacchetti che contengono o indicizzano "siduction" e "manual" con:

~~~  
$ apt-cache search bluewater-manual  
.......  
bluewater-manual-common - il Manuale Ufficiale di siduction - file comuni  
bluewater-manual-de - il Manuale Ufficiale tedesco di siduction  
bluewater-manual-en - il Manuale Ufficiale inglese di siduction  
bluewater-manual-it - il Manuale Ufficiale italiano di siduction  
bluewater-manual-es - il Manuale Ufficiale spagnolo di siduction  
bluewater-manual-pt-br - il Manuale Ufficiale portoghese-brasiliano di siduction  
bluewater-manual-el - il Manuale Ufficiale greco di siduction  
bluewater-manual - il Manuale Ufficiale di siduction - tutte le lingue  
bluewater-manual-pl - il Manuale Ufficiale polacco di siduction  
bluewater-manual-reader - il lettore del Manuale di siduction  
~~~

Se volete maggiori informazioni su un certo pacchetto:

~~~  
$ apt-cache show siduction-manual-en  
Package: siduction-manual-en  
Priority: optional  
Section: doc  
Installed-Size: 1088  
Maintainer: Kel Modderman <kel@otaku42.de>  
Architecture: all  
Source: siduction-manual  
Version: 01.12.2007.06.03-1  
Depends: siduction-manual-common  
Filename: pool/main/s/siduction-manual/siduction-manual-en_01.12.2007.06.03-1_all.deb  
Size: 391222  
MD5sum: 60f2175c3c5709745a4b4256ccc3c49d  
SHA1: e275a0b27628b6aa210a4ced48d3646b438e78b8  
SHA256: 2792580c7a091521301064180a1d0d8901f0a4af407b90432b9f8d8b6b3603ca  
Description: the official en Manuale siduction  
This manual is divided into common sections, for example, .......  
~~~

Tutte le versioni installabili del pacchetto (che dipendono dal sources.list) possono essere mostrate digitando:

~~~  
$ apt-cache policy siduction-manual-xx  
siduction-manual-xx:  
Installed: (none)  
Candidate: (none)  
Version table:  
500 http://siduction.com sid/main Packages  
~~~

 [Una descrizione completa del sistema APT può essere trovata in APT-HOWTO](http://www.debian.org/doc/user-manuals#apt-howto) 

<div class="divider" id="gui-pacsea"></div>
## Cercare un pacchetto debian mediante interfaccia grafica

~~~  
apt-get update  
apt-get install packagesearch  
~~~

Quando avviate per la prima volta packagesearch dovrete cambiare Packagesearch>Preferences in modo da poter utilizzare `apt-get` .

**`Non usate packagesearch per installare pacchetti, ma solo come motore di ricerca grafico. Aggiornare pacchetti e installarne nuovi senza arrestare X può causare problemi. Leggete:  [Installare un nuovo pacchetto](sys-admin-apt-it.htm#apt-install) .`** 

Nell'uso iniziale può esservi richiesto di installare deborphan. Utilizzatelo con cautela.

La ricerca può essere fatta per:

+ pattern (=schema,chiave di ricerca)  
+ tags (basato sul sistema dei debtags, un nuovo modo di categorizzare i pacchetti Debian)  
+ files  
+ installed status (=stato di installazione)  
+ orphaned packages (=pacchetti orfani)  

In aggiunta vengono visualizzate molte informazioni riguardo ai pacchetti, inclusi i file che ne fanno parte. Leggete Help>Contents per una spiegazione completa su come utilizzare l'applicazione grafica Debian Package Search. Al momento attuale il programma è soltanto in inglese.

 [Una descrizione completa del sistema APT può essere trovata in APT-HOWTO](http://www.debian.org/doc/manuals/apt-howto/)  

<div id="rev">Page last revised 23/04/2012 1825 UTC</div>
