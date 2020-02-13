<div id="main-page"></div>
<div class="divider" id="install-add"></div>
## Alcune utili applicazioni di KDE non preinstallate in siduction KDE Lite

 `Dovrete probabilmente abilitare non-free in /etc/apt/debian.sources.list` 

###### konq-plugins - plugin per Konqueror

Questo pacchetto contiene diversi utili plugin per Konqueror: gestore dei file, web browser e visualizzatore di documenti di KDE. Molti di questi plugin compariranno nel menu Strumenti di Konqueror.

~~~  
apt-get install konq-plugins  
~~~

Le utilità per la navigazione nel web comprendono: la traduzione di pagine web, la loro archiviazione, l'aggiornamento automatico, l'analisi strutturale di HTML e css, una barra di ricerca, una barra laterale per le notizie, l'accesso veloce alle opzioni più comuni, i preferiti, un notificatore di crash, un indicatore di disponibilità del microformato, una barra laterale per i preferiti del.icio.us, l'integrazione con il lettore di feed RSS aKregator.

Le utilità per la navigazione nelle directory comprendono: i filtri, la creazione di una galleria di immagini, la compressione ed estrazione di archivi, il copia/sposta veloce, una barra laterale per il lettore audio, una barra laterale per informazioni sui file, un supporto per le directory media, un visualizzatore grafico dell'uso del disco, nonché conversioni e trasformazioni di immagini.

###### Ricerche nel desktop KDE - Nepomuk e Strigi 

Le ricerche semantiche di Nepomuk nel desktop KDE sono già abilitate nella siduction-kde.iso.

Attendetevi che la prima iterazione dell'indicizzazione richieda un po' di tempo.  [Per maggiori informazioni su Nepomuk](http://nepomuk.kde.org/) . 

<div class="divider" id="kde-login"></div>
## Problemi di accesso al sistema in KDE

Il contenuto della cartella /tmp viene solitamente cancellato a ogni avvio, così come alcune cartelle e collegamenti necessari al server X.

Normalmente, durante il processo di avvio, lo script x11-common per X-Org ricrea queste cose.

Talora, però, questi script non vengono richiamati durante il processo di avvio: ricreate i link necessari lanciando:

~~~  
# X-ORG: # dpkg-reconfigure x11-common  
~~~

KDE necessita di un 5% di allocazioni libere nella partizione in cui risiede la cartella /tmp per i file temporanei creati all'accesso. Se state lavorando con una partizione piena al 95% non sarete in grado di entrare in KDE e verrete dislocati in una tty.

Lo stesso avviene con il kdm in looping che non vi consente l'accesso. Una soluzione è autenticarsi in una tty in modo da poter cancellare e/o pulire alcune applicazioni o file non più necessari.

Alternativamente, per accedere al sistema potete usare un gestore X window che non richieda così tanto spazio libero al sistema (per esempio fluxbox, già presente in un'installazione siduction), o fare chroot usando un live-CD/DVD di siduction per pulire la partizione in modo da riuscire ad avviare di nuovo KDE.

È raccomandato che una partizione usata da KDE per il suo /tmp sia occupata per un massimo dell'85% (15% libero).

<div class="divider" id="ch-th"></div>
## Installare siduction KDE Art e i Temi

Per installare i più recenti siduction-art in un sistema esistente:

~~~  
apt-get install siduction-art-kde-xxxx siduction-art-wallpaper-xxxx  
(dove xxxx è il nome della release, per esempio siduction-art-kde-onestepbeyond)  
~~~

Verranno installati lo sfondo di siduction e i temi

#### Per cambiare lo sfondo:

`Tasto destro del mouse`  sul desktop, scegliete `Impostazioni di Vista delle cartelle` . Impostate la voce `Sfondo`  su `Immagine`  e vi verrà mostrata una sottofinestra dalla quale scegliere uno sfondo da visualizzare. Cliccando sul pulsante `Apri`  situato nella parte inferiore della finestra potrete anche scegliere un'immagine situata in un file presente in qualunque parte del PC.

#### Per cambiare la schermata di accesso:

Per prima cosa aprite `Impostazioni di sistema`  con privilegi di amministratore/root:

~~~  
Alt + F2 (per far comparire krunner)  
~~~

~~~  
kdesu systemsettings  
~~~

Adesso andate in `Amministrazione di sistema`  e cliccate sull'icona `Schermata d'accesso`  e quindi sulla scheda `Tema`  e selezionate il tema preferito. `Per attivare il nuovo gestore di accesso dovrete riavviare il computer` .

 [Qui si trovano molte altre informazioni e collegamenti riguardo a KDE](http://kde.org) 

<div class="divider" id="xfce-notes"></div>
## Aggiunte utili per Xfce

<div class="divider" id="xfce-notes-1"></div>
### Installare grafica e temi siduction in Xfce

Per installare la grafica di siduction più recente in un'installazione già esistente:

~~~  
apt-get install siduction-art-xfce-xxxx siduction-art-wallpaper-xxxx  
(dove xxxx è il nome del rilascio, per es. siduction-art-xfce-onestepbeyond)  
~~~

Verranno installati lo sfondo di siduction e i temi; poi cambiate i predefiniti nel menù Configurazione di Xfce.

 [Documentazione su Xfce](http://www.xfce.org/documentation) 

 [wiki di Xfce](http://wiki.xfce.org) 

<div class="divider" id="dm"></div>
## Installare altri ambienti desktop insieme a quello preinstallato:

Ogni qual volta installate un altro ambiente desktop insieme a quello dell'installazione corrente (per esempio avete installato siduction-kde.iso e adesso volete aggiungere l'ambiente desktop Xfce oppure LXDE), un gestore di sessioni (dm) verrà probabilmente installato insieme a questo oppure potreste averlo installato per conto vostro (gdm, slim o qualche altro pacchetto dm).

Il problema che ne consegue è che vi troverete nella configurazione di default per i runlevel Debian e dovrete quindi arrestare X manualmente nel runlevel 3 prima di fare un dist-upgrade.

La soluzione è:

~~~  
apt-get update  
apt-get install --reinstall distro-defaults  
update-rc.d <dm> remove  
update-rc.d <dm> defaults  
~~~

Esempi per `update-rc.d <dm> defaults` . Notate il punto **`.`**  :

~~~  
update-rc.d kdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d gdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d slim start 01 5 . stop 01 0 1 2 3 4 6 .  
~~~

<div class="divider" id="desk-freeze"></div>
## Il desktop si blocca

In questa situazione non sempre dovrete premere il tasto reset. Ciò può danneggiare il filesystem o portare a una perdita di dati. In ogni modo, il filesystem non sarà pulito dopo un reset hardware (filesystem not clean).

Per prima cosa cercate di andare in una console con `ctrlalt-F1`  o di riavviare il server X con `ctrl-alt-backspace` . (Se entrambe queste opzioni non funzionano c'è ancora speranza):

Il tasto SYSRQ (Tasto Stamp o Print, in alto a destra sulla tastiera) può aiutarvi a risvegliare in modo pulito un sistema bloccato.

Sono possibili le seguenti combinazioni di tasti:  
*`alt+sysrq+r`  (dovrebbe ripristinare il controllo della tastiera)  
*`alt+sysrq+s`  (sblocca un sync)  
*`alt+sysrq+e`  (invia un comando di term a tutti i processi eccetto init)  
*`alt+sysrq+i`  (invia un comando di kill a tutti i processi eccetto init)  
*`alt+sysrq+u`  (i filesystem sono montati in sola lettura e ciò impedisce il file system check - fsck - al riavvio)  
*`alt+sysrq+b`  (riavvia il sistema senza i passi precedenti: è un 'hard reset').

È meglio concedere alcuni secondi a ogni passo sì che possa completarsi: chiudere tutti i processi, per esempio, può richiedere un po' di tempo. Le lettere dei comandi di cui sopra associate al tasto 'Stamp' possono essere ricordate ricorrendo all'acronimo inglese:  
 **"**`R`** eboot **`S`** ystem **`E`** ven **`I`** f **`U`** tterly **`B`** roken"** 

Altro modo per ricordarle è:  
 **"**`R`** aising **`S`** kinny **`E`** lephants **`I`** s **`U`** tterly **`B`** oring"** 

<div id="rev">Page last revised 29/04/2012 1715 UTC </div>
