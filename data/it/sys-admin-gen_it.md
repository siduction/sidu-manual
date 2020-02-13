<div id="main-page"></div>
<div class="divider" id="start-services"></div>
## Abilitare i servizi in siduction

### insserv: Avviare/fermare i servizi già installati:

**`Leggete `/usr/share/doc/insserv/README.Debian` , le note di rilascio e le pagine di manuale attentamente:`** 

~~~  
$ man insserv  
$ man invoke-rc.d  
$ man update-rc.d  
google LSB headers  
~~~

Per "avviare":

~~~  
/etc/init.d/<service> start  
~~~

Per "fermare":

~~~  
/etc/init.d/<service> stop  
~~~

Per "riavviare":

~~~  
/etc/init.d/<service> restart  
~~~

Per evitare che un servizio venga avviato all'avvio:

~~~  
update-rc.d <servizio> remove  
(rimuoverà tutti i collegamenti dell'avvio)  
~~~

Per porre un servizio al valore predefinito all'avvio (non necessariamente richiesto):

~~~  
update-rc.d <servizio> defaults  
(creerà i link per l'avvio)  
~~~

Per leggere la lista attuale dei servizi al valore predefinito:

~~~  
ls /etc/rc5.d  
~~~

`S`  significa che il servizio partirà con il livello d'avvio 5.  
`K`  significa che il servizio non partirà (intervento manuale).

<div class="divider" id="bum"></div>
## Boot-Up Manager (bum) - Strumento grafico per la configurazione dei servizi

Se la logica della sequenza di avvio di un sistema debian non vi è chiara e familiare, non dovreste giocare con i collegamenti simbolici, permessi e via dicendo. Ciò al fine di evitare di scompigliare il vostro sistema. Boot-Up Manager vi aiuterà nell'automazione della configurazione.

Boot-Up Manager è un editor a interfaccia grafica per la configurazione del runlevel, cioè del livello d'avvio del sistema, che permette di scegliere quali servizi verranno avviati quando questo si avvia o riavvia. Visualizza una lista di ogni servizio che può esser fatto partire all'avvio: potete configurare ciascuno di questi come "on" oppure "off".

~~~  
apt-get install bum  
~~~

Per utilizzare Boot-Up Manager GUI:

~~~  
$ sux  
password:  
bum  
~~~

  [Documentazione dettagliata su Boot-Up Manager (bum).](http://www.marzocca.net/linux/bumdocs.html) 

<div class="divider" id="pkill"></div>
## Interrompere ('kill') un servizio o un processo

`pkill`  è molto utile per la sua leggibilità e può lavorare sia in modalità root che utente normale, in un terminale o nella tty:

~~~  
pkill -n service  
~~~

Se non siete sicuri della corretta denominazione del processo/servizio che volete interrompere `pkill <tab> <tab>`  ve ne fornirà una lista.

Alternativa altrettanto valida è "htop". Alternativa di ultima istanza a vostra disposizione è "killall -9".

<div class="divider" id="init"></div>
## I runlevel di siduction

Questa è la lista dei runlevel di siduction. È opportuno notare che i relativi 'init' sono differenti da quelli predefiniti in Debian:

| Runlevel | siduction | Debian | 
| ---- | ---- | ---- |
|  **init 0**  |  Spegne il PC. |  Spegne il PC. | 
|  **init 1**  | Utente singolo (modalità di sicurezza o di ripristino). Demoni come apache e sshd vengono fermati. Non entrate in questo livello da un accesso remoto. | Utente singolo (modalità di sicurezza o di ripristino). Ferma i servizi. Non entrate in questo livello da un accesso remoto. | 
|  **init 2**  | Modalità Multi-Utente con rete funzionante, con X-Window System fermo, e/o per fermare o non entrare in X-Window System. | Runlevel predefinito di Debian per la modalità Multi-Utente con rete e X-Window System funzionanti. | 
|  **init 3**  | Modalità Multi-Utente con rete funzionante, con X-Window System fermo, e/o per fermare o non entrare in X-Window System.  [Qui è dove far funzionare un dist-upgrade](sys-admin-apt-it.htm#apt-upgrade) . | Lo stesso del runlevel 2 / init 2. | 
|  **init 4**  | Modalità Multi-Utente con rete funzionante, con X-Window System fermo, e/o per fermare o non entrare in X-Window System. | Lo stesso del runlevel 2 / init 2. | 
|  **init 5**  | Il predefinito di siduction per la modalità Multi-Utente con rete e X-Window System in funzione, e/o per far avviare X-Window System. | Lo stesso del runlevel 2 / init 2. | 
|  **init 6**  | Riavvia il sistema. | Riavvia il sistema. | 
|  **init S**  | Questo è il runlevel nel quale i primi servizi dell'avvio vengono eseguiti "una sola volta". Non si può commutare dopo che è stato avviato. | Questo è il runlevel nel quale i primi servizi dell'avvio vengono eseguiti "una sola volta". Non si può commutare dopo che è stato avviato. | 


---

Per accertarvi in quale runlevel (init) siete:

~~~  
who -r  
~~~

Lettura sui runlevel richiesta per ogni amministratore di siduction e Debian:

~~~  
man init  
~~~

<div class="divider" id="pw-lost"></div>
## Password di root dimenticata

Non potete recuperare la password persa ma ne potete impostare una nuova.

Per prima cosa avviate da Live-CD.

Diventate root e montate la vostra partizione di root (supponiamo "/dev/sdb2"):

~~~  
mount /dev/sdb2 /media/sdb2  
~~~

Ora eseguite il chroot nella partizione di root e impostate la nuova password:

~~~  
chroot /media/sdb2 passwd  
~~~

<div class="divider" id="pw-new"></div>
## Impostare nuove password

Per cambiare la password "utente", come `$ utente` :

~~~  
$ passwd  
~~~

Per cambiare la password di "root", come `# root` :

~~~  
# passwd  
~~~

Per cambiare la password di un utente mentre si è amministratori, come `# root` :

~~~  
# passwd <utente>  
~~~

<div class="divider" id="fonts"></div>
## Caratteri in siduction

##### Corretta impostazione dei DPI - Filosofia di base

Indovinare le impostazioni dei DPI è cosa problematica, ma le scelte sono in realtà possibili perfettamente da X.

##### Corretta risoluzione e valore di refresh

Ogni schermo ha la sua combinazione di impostazioni perfetta ma sfortunatamente non tutti riportano i giusti valori DCC, e talvolta occorre scriverli manualmente.

<!--##### I driver corretti della schede grafiche

Alcune delle più nuove schede ATi e nVidia semplicemente non funzionano bene con i driver liberi Xorg e l'unica ragionevole soluzione in tal caso è l'utilizzo dei driver commerciali a sorgente chiuso. siduction non li preinstalla per ragioni legali, comunque  [la soluzione si può trovare qui](gpu-it.htm) 

-->
##### Selezione dei caratteri predefiniti, rendering e dimensioni

siduction usa i caratteri liberi preselezionati di Debian che si sono dimostrati molto bilanciati; la scelta di caratteri personali può deteriorare la qualità del rendering, cioè della resa. Vi sono alcune potenti opzioni in Debian (oltre a KDE> Impostazioni di sistema) che possono aiutare a ottenere una resa pulita anche con altri caratteri, ma dovete essere consci del fatto che ogni carattere ha poche dimensioni perfette mentre altre potrebbero non funzionare bene.

Può esser d'aiuto anche provare a cambiare la dimensione dei DPI con la linea di comando:

~~~  
fix-dpi-kdm  
~~~

Il comando dovrebbe mostrare i DPI scelti per la dimensione del vostro schermo, ma potete anche provare a giocarci un po'. Dovrete andare in init 3 e poi tornare in init 5 per far rilevare l'impostazione, oppure fare un riavvio.

Dopo aver cambiato tipo di carattere o DPI (in X o in Firefox/Iceweasel), potreste dover apportare alcuni aggiustamenti per ottenere risultati di vostro gradimento, specialmente dopo un cambio da caratteri Bitmap a TrueType o viceversa:

~~~  
dpkg-reconfigure fontconfig-config  
~~~

Ponete nativo e autohinter su automatico. Altrimenti provate a variare le impostazioni.

Se aveste bisogno di ricostruire la cache dei caratteri:

~~~  
fc-cache -f -vv  
~~~

Se il comando di cui sopra non funzionasse potreste dover reinstallare il pacchetto con un file di configurazione predefinito della cache dei caratteri. Potete farlo con il comando:

~~~  
apt-get install --reinstall --yes -o DPkg::Options::=--force-confmiss -o DPkg::Options::=--force-confnew fontconfig fontconfig-config  
~~~

##### Applicazioni basate su GTK come Firefox/Icewasel

Le applicazioni basate su GTK generalmente presentano problemi con le impostazioni predefinite di KDE. Potete risolvere il tutto installando:

~~~  
apt-get install gtk2-engines system-config-gtk-kde gtk-qt-engine gtk2-engines-qtcurve  
~~~

In `Impostazioni di sistema > Aspetto delle applicazioni`  troverete due voci di menù chiamate `Stile e Caratteri` . Impostate 'Stile' per utilizzare 'Cleanlooks' e impostate 'Caratteri' su 'caratteri KDE' (se presente) `oppure`  sperimentate le varie opzioni per aggiustarle come preferito.

Questo POTREBBE aggiustare la resa dei caratteri nelle applicazioni gtk.

<div class="divider" id="cups"></div>
## CUPS

KDE ha una vasta sezione dedicata a CUPS nelle pagine di help. Gli aggiornamenti con dist-upgrade, comunque, spesso causano cattivi funzionamenti di CUPS, per i quali una soluzione conosciuta è la seguente:

~~~  
modprobe lp  
echo lp >> /etc/modules  
apt-get remove --purge cupsys cups  
apt-get install cups  
oppure  
apt-get install cups cups-driver-gutenprint hplip  
~~~

Assicuratei che CUPS sia avviato con:

~~~  
/etc/init.d/cups restart  
~~~

Poi in un web browser:

~~~  
http://localhost:631  
~~~

Un altro intoppo può verificarsi quando si imposta CUPS mediante interfaccia grafica: si apre una finestra di dialogo che chiede di immettere la password e siccome nella finestra di dialogo appare il nome utente attuale si è indotti a mettere la password relativa ma questa non funziona. Quello che bisogna fare è sostituire il nome utente con **`root`**  e poi mettere la **`password di root`** .

 [Il database OpenPrinting](http://www.linuxfoundation.org/collaborate/workgroups/openprinting/database/databaseintro)  contiene molte informazioni riguardo a stampanti specifiche, insieme a informazioni esaustive sui driver, i driver stessi, le specifiche di base e un set di strumenti per la configurazione.

<div class="divider" id="sound"></div>
## Il suono in siduction

`In via predefinita il suono è impostato su "muto" in siduction.` 

La versione KDE usa Kmix e quella XFCE usa Mixer.

Spesso è solo questione di cliccare nell'icona suono nella barra e togliere la spunta da "mute".

###### Kmix

In Kmix dovrete attivare le opzioni preferite per i canali, `Kmix>Impostazioni>Configura canali.`  Oppure in un terminale:

~~~  
$ kmix  
~~~

###### XFCE

In XFCE avviate l'applicazione mixer e aggiungete alcuni controlli mediante il menù `Multimedia>Mixer`  e cliccate la casella `Select Controls.`  Oppure in un terminale:

~~~  
$ xfce4-mixer  
~~~

### Alsamixer

Se preferite utilizzare Alsamixer, la si trova nel pacchetto alsa-utils:

~~~  
apt-get update  
apt-get install alsa-utils  
exit  
~~~

Impostate i settaggi preferiti per il suono come **`$utente`**  dal terminale:

~~~  
$ alsamixer  
~~~

<div id="rev">Content last revised 24/07/2012 1541 UTC </div>
