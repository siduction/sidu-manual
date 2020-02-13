<div id="main-page"></div>
<div class="divider" id="term-kon"></div>
## Definizione di terminale/konsole

Un terminale - detto anche "bash", "console" e in KDE "konsole" - è un programma che rende possibile interagire direttamente con il sistema operativo Linux immettendo vari comandi che sono poi eseguiti immediatamente. Indicato spesso anche con i termini `"shell"`  o `"linea di comando"` , il terminale è uno strumento molto potente e merita davvero lo sforzo di acquisire alcune conoscenze di base sul suo uso.

In siduction potete in genere trovare il terminale/konsole accanto al K-menu raffigurato con l'icona di una schermo di PC. In funzione del tema di icone prescelto questa può contenere o no l'immagine di una conchiglia (da qui la dizione "shell"). Si troverà la stessa icona nel K-menu sotto la voce "Sistema".

Quando aprite una finestra di terminale vi verrà presentato il cosiddetto "prompt" che avrà il formato seguente:

~~~  
nome_utente@nome_computer:~$  
~~~

Dovreste riconoscervi il nome utente (username) come il nome con cui fate accesso al sistema. La `~ (tilde)`  indica che siete nella vostra cartella home e il `$`  indica che avete a disposizione i privilegi di utente normale. Alla fine avrete il cursore. Questa è la vostra linea di comando nella quale digiterete i comandi che volete eseguire.

Molti comandi devono essere eseguiti con i privilegi di amministratore (root). Per ottenerli digitate: `sux`  al prompt e premete invio. Vi verrà chiesta la password di root: digitatela e premere ancora invio (noterete che mentre digitate questa password nulla viene mostrato sullo schermo).

Se la password è corretta il prompt cambierà così:

~~~  
root@nome_computer:/home/nome_utente#  
~~~

**`ATTENZIONE: Quando è in atto l'accesso come root, il sistema non vi porrà limiti nel fare cose potenzialmente pericolose come cancellare file importanti, etc.: dovete quindi essere assolutamente sicuri di quello che state facendo perché è davvero possibile danneggiare seriamente il sistema.`**

Notate che il `$`  è cambiato in `#`  (hash). In un terminale/konsole il simbolo `#`  indica sempre che siete nel sistema con i privilegi di root. `In questo manuale ometteremo negli esempi ogni scritta che precede i simboli $ o #. Così un comando come` 

~~~  
# apt-get install qualche_cosa  
~~~

significa: aprite un terminale, diventate root (con sux) e immettete il comando al prompt # `(non digitate il simbolo #)` .

Qualche volta una konsole e/o un terminale in esecuzione possono corrompersi. Digitate in tal caso:

~~~  
reset  
~~~

e premete invio.

Se quanto visualizzato da una konsole e/o da un terminale appare distorto potete spesso porvi rimedio premendo `ctrl+l` , il che ridisegna la finestra del terminale. Questa distorsione si presenta per lo più con programmi che usano l'interfaccia ncurses, come irssi.

Occasionalmente una konsole e/o un terminale possono sembrare bloccati, tuttavia non lo sono e qualsiasi cosa digitate verrà poi eseguito in sequenza. Questa situazione può essere causata dalla pressione accidentale di `ctrl+s` . In questo caso provate a premere `ctrl+q`  per sbloccare il terminale.

<div class="divider" id="colours"></div>
### `Prompt a colori del terminale`  `user:~` `$`  e **`root:`** `#` 

I prompt a colori del terminale possono salvarvi dal compiere un imbarazzante e forse catastrofico errore mentre agite come **`root #`**  quando invece avreste voluto essere `user~$` ; potete anche usare i colori del prompt per evidenziare comandi eseguiti qualche centinaio di linee prima.

Per default, entrambi i prompt user~$ e root# hanno lo stesso colore, ma è veramente semplice cambiarlo per entrambi gli account.

I colori di base sono:

~~~  
(la sintassi è 00;XX)  
[00;30] Black  
[00;31] Red  
[00;32] Green  
[00;33] Yellow  
[00;34] Blue  
[00;35] Magenta  
[00;36] Cyan  
[00;37] White  
(Sostituite [00;XX] con [01;XX] per ottenere una variazione di colore).  
~~~

###### Per cambiare il colore del prompt del proprio nome utente ~$ :

Come $ utente, con il vostro editor di testo preferito:

~~~  
$ <editor> ~/.bashrc  
~~~

Scorrete fino alla linea 39 e decommentatela, quindi:

~~~  
force_color_prompt=yes  
~~~

Scorrete fino alla linea 53 e dove trovate, ad esempio, 01;32m, cambiatelo con un colore che piace.

Come esempio, per un prompt user~:$ colorato in `cyan` , [01;36m\], dovrete cambiare il codice [01;XXm\] in 3 diversi posti con la sintassi:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[01;36m\]:\[\033[01;36m\]\w\[\033[00m\]\$'  
~~~

Il nuovo look comparirà nelle nuove sessioni di terminale.

###### Per cambiare il colore del prompt di root # :

~~~  
sux  
<editor> /root/.bashrc  
~~~

Scorrete fino alla linea 39 e decommentatela, poi:

~~~  
force_color_prompt=yes  
~~~

Scorrete fino alla linea 53 e dove trovate, ad esempio, 01;32m, cambiatelo con un colore che piace.

Come esempio, per un prompt root:# colorato in **`red`** , [01;36m\], dovrete cambiare il codice [01;XXm\] in 3 diversi posti con la sintassi:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[01;31m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '  
~~~

Il nuovo look comparirà nelle nuove sessioni di terminale.

###### Colori di sfondo del terminale

Per cambiare il colore di sfondo e le opzioni di carattere del terminale, guardate le opzioni del menù del terminale.

![Terminal colours](../images-common/images-terminal/terminal-colour-0.1.png "Terminal colours") 

V'è una pletora di opzioni disponibili per cambiare colori, tuttavia la raccomandazione è di restare sul semplice.

<div class="divider" id="sux"></div>
## Il comando sux

Numerosi comandi necessitano di essere eseguiti con i privilegi di root. Per ottenerli digitate nel terminale:

~~~  
sux  
~~~

Normalmente il comando per diventare root è "su", ma utilizzando al suo posto `sux` , vi sarà possibile avviare applicazioni con interfaccia grafica (GUI / X11) dalla linea di comando e consentirà a root di lanciare applicazioni grafiche, poiché `sux`  è un involucro attorno al comando standard "su" che trasferisce le vostre credenziali X all'utente a cui punta. (Si veda anche  [sudo](#sudo) ).

 Un esempio di attività con applicazioni X11 avviate via sux è l'uso di un elaboratore di testo come kwrite o kate per modificare un file di root, o anche fare partizionamenti con gparted o lanciare un file manager a interfaccia grafica (Xapp) come dolphin o thunar.

###### Opzioni da tastiera in KDE

Per avviare krunner in KDE:

~~~  
Alt+F2  
~~~

oppure tasto destro nel desktop e scegliere:

~~~  
Esegui comando  
~~~

quindi:

~~~  
kdesu <applicazione>  
~~~

###### Opzioni da tastiera in Xfce

Per avviare Esegui Comando in Xfce:

~~~  
Alt+F2  
~~~

oppure tasto destro nel desktop e scegliere:

~~~  
Esegui comando  
~~~

quindi:

~~~  
gksu <applicazione>  
~~~

###### Altre opzioni dei Desktop Window Manager

Altra opzione da tastiera generica e comune a tutti i maggiori desktop manager è:

~~~  
Alt+F2  
~~~

quindi:

~~~  
su-to-root -X -c <applicazione>  
~~~

`Tutte le opzioni da tastiera di cui sopra possono essere avviate nel terminale.` 

<div class="divider" id="sudo"></div>
## sudo non è supportato

sudo non è abilitato per default nell'installazione su disco rigido. È disponibile per l'uso mentre si è avviato da liveCD dal momento che non è definita nessuna password di root. La ragione di questa scelta è che se qualcuno ottiene le password degli utenti non ottiene immediatamente privilegi da superutente e non può quindi fare cambiamenti potenzialmente dannosi al sistema.

Altro problema di sudo è che induce l'utente ad avviare un'applicazione di root con la configurazione da utente, il che può causare cambiamenti o sovrascrittura di permessi e rendere un'applicazione inutilizzabile dall'utente stesso. Utilizzate `[sux](#sux) , kdesu, gksu`  oppure `su-to-root -X -c`  come raccomandato!

## Essere root

**`ATTENZIONE: Quando è in atto l'accesso come root, il sistema non vi porrà limiti nel fare cose potenzialmente pericolose come cancellare file importanti, etc.: dovete quindi essere assolutamente sicuri di quello che state facendo perché è davvero possibile danneggiare seriamente il sistema.`**

**`In nessuna circostanza dovreste agire come root in una console/terminale per lanciare applicazioni che un utente normale usa per il lavoro quotidiano, coma spedire posta, creare fogli elettronici o navigare in internet e cosi via.`**

<div class="divider" id="cli-help"></div>
## Aiuto dalla Linea di Comando

Ebbene, esiste. Molti comandi e programmi Linux sono forniti con il proprio manuale chiamato "man page" o "manual page" accessibile dalla linea di comando. La sintassi è:

~~~  
$ man nome-comando  
~~~

oppure

~~~  
$ man -k <keyword>  
~~~

Questo porta in console le pagine di manuale per quel comando. Navigate su e giù con i tasti del cursore. Ad esempio provate:

~~~  
$ man apt-get  
~~~

Per uscire dalle pagine di manuale digitate semplicemente `q` .

Altra utile facilitazione è il comando "apropos". Fondamentalmente vi mette in grado di cercare le pagine di manuale per un comando anche se, ad esempio, non ne ricordate la completa sintassi. Per esempio potete provare:

~~~  
$ apropos apt-  
~~~

Verrà visualizzata la lista di tutti i comandi per il gestore dei pacchetti "apt". L'utilità "apropos" è uno strumento abbastanza potente, ma la sua descrizione dettagliata va al di là dello scopo di questo manuale. Per i dettagli sul suo uso leggete la sua man-page.

<div class="divider" id="term-cmds"></div>
## Lista del comandi del terminale Linux (estratti)

Un eccellente sillabario sull'uso di bash si trova in  [linuxcommand.org](http://linuxcommand.org/) 

`Una lista davvero esaustiva di 687 comandi in ordine alfabetico si trova in  [Linux in a Nutshell, 5th Edition: O'Reilly Publications](http://www.linuxdevcenter.com/linux/cmd/#a)  ed è un segnalibro da avere nel browser.`

Vi sono molti manuali su Internet. Uno molto buono indirizzato ai principianti si trova in:  [A Beginner's Bash](http://linux.org.mt/article/terminal) 

Usate il motore di ricerca preferito per trovarne altri.

<div class="divider" id="shell-scripts"></div>
## Lo script e come usarlo

Uno "shell script" (o semplicemente "script")è un modo conveniente per raggruppare in un file molti comandi. Immettendo il nome del file script ogni comando verrà eseguito in sequenza. siduction è fornito di parecchi utili script per facilitare la vita degli utenti.

Se lo script si trova nella cartella corrente, lanciatelo con:

~~~  
./nome_dello_shell-script  
~~~

`Alcuni script richiedono un accesso di root (sux) in un terminale e altri no: dipende interamente da ciò che fa lo script.`

##### Installazione di script e procedura di esecuzione

Usate wget per scaricare il file script mettendolo dove è stato raccomandato `(per esempio può richiedere di essere messo in /usr/local/bin)` ; si può usare la funzionalità copia/incolla via mouse del nome del file direttamente nella finestra della konsole, dopo esservi autenticati con `sux` 

###### Esempio dell'uso di wget come `utente root (sux)` 

~~~  
sux  
cd /usr/local/bin  
wget nome_dello_script  
~~~

Ora occorre rendere eseguibile il file

~~~  
chmod +x nome_dello_script  
~~~

Si può usare anche un browser per scaricare un file script e metterlo dove indicato, ma si dovrà comunque sempre renderlo eseguibile.

<!--
###### Esempio dell'uso di wget come utente normale

Per scaricare un file nella directory `$HOME come utente normale '$'` :

~~~  
$ wget http://bluewater.siduction.com/shell-script-test/test-script.sh  
~~~

~~~  
$ chmod +x test-script.sh  
~~~

Per lanciare uno script, aprire un terminale/konsole, scrivere il nome dello script appena scaricato (preceduto da ./):

~~~  
$ ./test-script.sh  
~~~

Si dovrebbe vedere a schermo la seguente frase:

~~~  
Congratulations user  
You successfully downloaded and executed a bash script!  
Welcome to siduction-manuals http://manual.siduction.com  
~~~

-->
<div id="rev">Page last revised 03/05/2012 2223 UTC</div>
