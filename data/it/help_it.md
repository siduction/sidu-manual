<div id="main-page"></div>
<div class="divider" id="help-gen"></div>
## Dove trovare aiuto

Trovare tempestivamente un aiuto può fare la differenza tra finire in lacrime o proseguire nelle cose per voi importanti. Questo tema viene qui trattato a fondo per darvi modo di sapere dove e come ottenere l'aiuto che siduction fornisce come distribuzione.

+  [Forum e Wiki](help-it.htm#for-wiki)   
+  [IRC](help-it.htm#irc)   
+  [Strumenti da conoscere in modalità testo (tty) e init 3](help-it.htm#init3-tools)   
+  [Utilizzare IRC in modalità testo e/o init 3](help-it.htm#irc-init3)   
+  [Navigare in rete in modalità testo e/o init 3](help-it.htm#init3-web)   
+  [inxi](help-it.htm#inxi)   

<div class="divider" id="for-wiki"></div>
## I forum di siduction

I forum di siduction offrono un luogo ove inviare domande e ricevere le relative risposte: fate ricerche nei forum prima di inviare domande, perché altri utenti potrebbero avere già posto un'identica domanda. I  [forum](http://www.siduction.com/module-PNphpBB2.html)  sono in tedesco e/o in inglese.

## Il wiki di siduction

Il wiki di siduction può essere usato e modificato liberamente da tutti gli utenti di siduction.

Ci auguriamo che arrivino contributi da parte di utenti Linux di qualsiasi livello di esperienza poiché il wiki è concepito per dare aiuto a utenti di tutti i livelli. I pochi minuti di tempo che dedicherete al nostro wiki possono aiutare altri utenti in cerca di una soluzione (e forse anche voi stessi) evitando ore di pena e ricerche.  [Il wiki](http://siduction.com/module-Wikula.html) .

<div class="divider" id="irc"></div>
## Aiuto interattivo in diretta con IRC (Internet Relay Chat)

### Protocolli di comportamento per IRC

**`Mai IRC come "root"! .. siete i benvenuti nella chat IRC come utente normale, mai come root: se avete difficoltà ditelo immediatamente.`**

### Entrare nel canale IRC #siduction

<!--Ci sono 2 metodi per ottenere direttamente aiuto on line -->  
Cliccate sull'`icona siduction-irc`  che si trova sul desktop, oppure usate un altro programma client IRC.  
<!-- 2) Cliccate su `Meet the Team`  nel menu sul sito  [siduction.org](http://siduction.com) 

 -->
#### Konversation

Il modo più facile è cliccare sull'`icona siduction-irc`  sul desktop oppure usare il menu di KDE dove c'è il programma di chat Konversation già preconfigurato.

Nel caso preferiate usare un altro programma di chat, impostate il server su:

~~~  
irc.oftc.net  
port 6667  
~~~

<!--#### IRC sul sito siduction.com 

Andare su  [siduction.com](http://siduction.com)  e premere `Meet the Team`  in the menu list. This will give you options to use a Chat (cgi) or Chat (java) web based irc chat client.

Immettere il nickname (soprannome) che si è scelto nella riga "nickname" e "#siduction" nella riga "channel" e premere su "login" e/o seguire le indicazioni.

 -->
<div class="divider" id="paste"></div>
## !paste

### siduction-paste

il "paste" di siduction vi consentirà di incollare l'output di un file dal terminale e dalla console, ed è pertanto l'ideale se avete difficoltà in init 3. Il paste di siduction utilizza come link http://paste.siduction.org.

Potete abilitare il paste di siduction indifferentemente come utente o come root, ma alcune richieste di output richiedono l'accesso come root.

~~~  
siduction-paste FILE | COMMAND  
oppure  
COMMAND | siduction-paste  
~~~

###### Esempio di siduction-paste &lt;file&gt;

~~~  
siduction-paste /etc/fstab  
Il vostro paste può essere visto qui: http://paste.siduction.org/xyz.html  
~~~

Il collegamento `http://paste.siduction.org/n8miQp85.html`  dovrà essere inserito nell'IRC #siduction.

###### Esempio di COMMAND | siduction-paste

~~~  
fdisk -l | siduction-paste  
Il vostro paste può essere visto qui: http://paste.siduction.org/xyz.html  
~~~

Il collegamento `http://paste.siduction.org/xyz.html`  dovrà essere inserito nell'IRC #siduction.

Potete anche catturare istantanee dello schermo e incollarle in unica mandata:

~~~  
siduction-paste -s  
~~~

Avete alcuni secondi di tempo a disposizione per spostarvi sull'immagine da catturare. Tenete presente che perché questa caratteristica funzioni dovrà essere installato scrot.

<div class="divider" id="init3-tools"></div>
## Strumenti da conoscere in modalità testo (tty) e init 3

Di solito vi trovate in modalità testo e init 3 perché siete sul punto di fare un dist-upgrade (oppure perché è successo qualcosa di terribile al sistema).

#### gpm

Un buon strumento di cui disporre in modalità testo è `gpm` , il quale permette di usare il mouse per il copia/incolla tra terminali/console.

`gpm`  è già preconfigurato in siduction, ma nel caso non funzionasse digitate:

~~~  
gpm -t imps2 -m /dev/input/mice  
~~~

Assicuratevi che sia presente /etc/gpm.conf

~~~  
/etc/init.d/gpm restart  
~~~

Ora potrete utilizzare il mouse in modalità testo (tty).

#### Gestione dei file ed editor di testo

Midnight Commander, installato in via predefinita e abbastanza semplice da usare, è un gestore di file in modalità testo (tty) a pieno schermo e anche un editor di testo.

Oltre ai normali comandi da tastiera risponde anche al mouse per la navigazione grazie a gpm.

`mc`  carica il gestore dei file, mentre il comando `mcedit`  carica un file vuoto o apre direttamente un vostro file.

Ecco come aprire direttamente un file:

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

Adesso potete modificare il file per cambiare i parametri e salvandolo otterrete un effetto immediato.

Leggete:

~~~  
man mc  
~~~

<div class="divider" id="irc-init3"></div>
### Utilizzare IRC in modalità testo e/o init 3

#### Protocolli di comportamento per IRC

**`Mai IRC come "root"! .. siete i benvenuti nella chat IRC come utente normale, mai come root: se avete difficoltà ditelo immediatamente.`**

#### IRC in modalità testo e/o init 3

Il programma predefinito in siduction è weechat.

Se siete in init 3, potete passare a un altro terminale/console con:

~~~  
# CTRL+ALT+F2  
$ siductionbox login: <username> <password> (non come root)    
poi digitate    
$ siduction-irc (il che avvia weechat)    
~~~
  
Se avete installato un altro programma simile a weechat:

~~~  
# CTRL+ALT+F2  
$ siductionbox login: <username> <password> (non come root)    
poi digitate    
$ weechat-curses    
~~~
  
Ora connettetevi a irc.oftc.net alla porta 6667. Una volta connessi, cambiate il vostro nickname:

~~~  
/nick soprannome_scelto  
~~~

Per entrare nel canale siduction:

~~~  
/join #siduction  
~~~

Se volete connettervi a un altro server:

~~~  
/server server.name  
~~~

Nella barra in basso, nel caso vi siano delle attività in quei canali, vedrete apparire dei numeri. Per entrare premete ALT+1, ALT+2, ALT+3, ALT+4, etc.

Per uscire:

~~~  
/exit  
~~~

Se è in corso un dist-upgrade, ad esempio, e volete controllare a che punto è:

~~~  
per tornare al dist-upgrade (per esempio, se avviato in tty 1)  
$ CTRL+ALT+F1  
poi, per ritornare all'IRC  
# CTRL+ALT+F2  
~~~

 [Qui si trova la documentazione su weechat](http://irssi.org/documentation) 

<div class="divider" id="init3-web"></div>
#### Navigare in rete in modalità testo e/o init 3

w3m e/o elinks vi permetteranno di navigare in un terminale/console o in modalità testo e/o al runlevel init 3

Controllate che w3m e/o elinks siano installati, altrimenti digitate:

~~~  
apt-get update  
apt-get install w3m elinks  
~~~

Per accedere, ad esempio, a w3m aprite un terminale/console:

~~~  
$w3m URL  
oppure  
w3m ?  
oppure  
w3m siduction.org  
~~~

Se compare uno schermo nero con le istruzioni sul fondo `nessun panico` : usate la combinazione di tasti:

~~~  
SHIFT+U  
~~~

Vedrete allora aprirsi nel disco locale qualcosa come "Goto URL: file:///home/username/$"; premete backspace fino a "Goto URL:" e digitate un indirizzo web. Per esempio:

~~~  
http://siduction.org  
~~~

Ora potrete navigare verso  [siduction.org](http://siduction.org)  o verso qualsiasi altro sito di vostra scelta.

Se siete in init 3:

~~~  
# CTRL+ALT+F2  
$ siductionbox login: <username> <password> (non come root)    
poi digitate    
$ w3m siduction.org    
Per tornare ancora al dist-upgrade (come nell'esempio di cui sopra)    
$ CTRL+ALT+F1    
~~~
  
Per andare direttamente al Manuale on line di siduction

~~~  
$w3m manual.siduction.org  
~~~

 [home page di w3m](http://w3m.sourceforge.net/) 

###### `È consigliabile familiarizzarsi nell'uso di elinks/w3m, weechat e midnight commander prima che capiti un'eventuale emergenza. Può essere molto utile stampare queste pagine come riferimento su come ottenere aiuto on line nelle emergenze.` 

<div class="divider" id="inxi"></div>
## inxi

inxi è uno script di informazione sul sistema utilizzato indipendente da un particolare programma client IRC. Lo script può mostrare tutto ciò che riguarda l'hardware e il software del vostro PC a coloro che in quel momento sono presenti sul canale IRC, sì che possano aiutarvi a diagnosticare i problemi, ... o semplicemente meravigliarsi per le specifiche del sistema o per la versione del kernel, almeno durante il tempo in cui rimarrete nella console.

Per utilizzare lo script inxi in Konversation, scrivete nella casella di testo della chat:

~~~  
/cmd inxi -v1  
~~~

Per utilizzare lo script inxi in altri client IRC, scrivete nella casella di testo della chat:

~~~  
/exec -o inxi -v1  
oppure  
/inxi -v1  
oppure  
/shell -o inxi -v1 (weechat)  
~~~

In una console, invece, digitate:

~~~  
inxi -v1  
~~~

Aiuto per inxi:

~~~  
inxi -help  
~~~

<div class="divider" id="links"></div>
## Collegamenti utili

###### Documentazione Generale su Linux 

 [debian.org/doc/user-manuals](http://www.debian.org/doc/user-manuals#apt-howto) 

 [Debian Reference Card - per stamparlo su di una pagina singola](http://www.debian.org/doc/user-manuals#refcard) 

 [debian.org/doc/#howtos](http://www.debian.org/doc/#howtos) 

 [Concetti di base, installazione e amministrazione di un sistema Debian](http://qref.sourceforge.net/index.en.php)  documenti disponibili nei formati HTML, text, PDF o PS in molte lingue diverse

 [Linux Basics](http://linuxbasics.org/) 

Il Centro di Aiuto di KDE in siduction ha un aiuto interno dedicato alla Stampa/CUPS, altrimenti fate riferimento a  [Common Unix Printing System CUPS](http://www.cups.org/) 

 [LibreOffice](http://it.libreoffice.org/) 

<div id="rev">Content last revised 03/02/2012 1202 UTC </div>
