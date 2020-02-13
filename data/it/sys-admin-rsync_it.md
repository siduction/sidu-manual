<div id="main-page"></div>
<div class="divider" id="rsync"></div>
## Fare backup con rsync

rsync è uno strumento utilizzato per il backup e la sincronizzazione dei file capace di funzionare in molte versioni di *nix.

**`Un limite di rsync è che NON può copiare da un sistema remoto a un altro sistema remoto. Se volete far questo dovrete copiare uno dei sistemi remoti sul sistema locale e poi copiarlo dal sistema locale all'altro sistema remoto.`**

Con siduction potete scegliere come iniziare l'operazione: FAI-DA-TE oppure tramite un pacchetto .deb in Debian sid:

##### Per il pacchetto debian:

~~~  
apt-get install luckybackup  
~~~

 [Sito internet di luckybackup.](http://luckybackup.sourceforge.net/) 

###### Quanto segue si riferisce alla versione FAI-DA-TE

Questa pagina vi offre una conoscenza sul campo di quello che può fare rsync e qualche esempio di codice da usare per uno script di backup personale.

rsync è un programma di backup dei file molto facile da usare in grado di salvare rapidamente file e cartelle. Ciò è ottenuto mediante una routine molto accorta che controlla quando i file sono stati cambiati, in modo che vengono selezionati per la copia solo questi. rsync usa anche un'utilità di compressione per velocizzare il processo di copia <span class=" highlight-3">(quando è esplicitamente impostato con l'opzione -z)</span>. Tutto questo può essere spiegato molto semplicemente:

- il programma rsync individua i file e le cartelle che devono essere copiati in quanto uno o più dei loro attributi sono cambiati (per esempio la data/ora delle ultime modifiche o la dimensione del file) e quindi v'è qualcosa che non è più lo stesso di quello che era stato salvato in precedenza. Questo processo di selezione è molto veloce.

- quando rsync ha finito di costruire la lista che userà, la copia di questi file cambiati viene eseguita molto più velocemente grazie a una routine di compressione eseguita durante il processo di copia. rsync esegue la compressione prima dell'invio e decomprime "al volo" all'arrivo.

- rsync può copiare file da:  
* sistema locale a sistema locale  
* sistema locale a sistema remoto  
* sistema remoto a sistema locale

- rsync lavora usando o il client predefinito  [ssh](ssh-it.htm) , o un demone rsync attivo sia sul sistema sorgente che su quello di destinazione. Le pagine del manuale di rsync dicono che, se potete utilizzare ssh sul sistema, allora anche rsync potrà connettersi a questo via ssh.

`Come più sopra detto, limite di rsync è che NON può copiare da sistema remoto a sistema remoto. Se volete far questo dovrete copiare uno dei sistemi remoti sul sistema locale e poi copiarlo dal sistema locale all'altro sistema remoto.`

Per fornire un esempio di questa logica, supponiamo di avere tre sistemi:

~~~  
neo - il sistema locale  
morpheus - un sistema remoto  
trinity - un sistema remoto  
~~~

Voi intendete usare rsync per copiare o sincronizzare la cartella /home/[utente]/Dati da ogni sistema verso gli altri. Ciascun sistema "appartiene" a uno specifico utente; in altre parole, un dato utente lo usa specificamente e pertanto quel sistema dovrebbe essere usato come "sorgente" per gli altri due sistemi. A vostra volta, voi farete girare rsync solo sul sistema locale, che è "neo":

~~~  
il principale utente di neo è cuddles  
il principale utente di morpheus è tartie  
il principale utente di trinity è taylar  
~~~

Così, quello che vorreste è fare il backup o sincronizzare le seguenti aree dati:

~~~  
di neo in /home/cuddles/Data su morpheus e trinity  
di morpheus in /home/tartie/Data suo neo e trinity  
di trinity in /home/taylar/Data su neo e morpheus  
~~~

Il problema di rsync e la sua incapacità di copiare da sistema remoto a sistema remoto si manifesterà chiaramente, sulla base di quanto sopra, quando cercheremo di salvare trinity su morpheus, o morpheus su trinity (entrambi i sistemi, sorgente e destinazione, sono remoti), e quindi:

~~~  
neo --> morpheus - funziona, è da locale a remoto  
neo --> trinity - funziona, è da locale a remoto  
morpheus --> neo - funziona, è da remoto a locale  
trinity --> neo - funziona, è da remoto a locale  
morpheus --> trinity - da remoto a remoto - non funziona  
trinity --> morpheus - da remoto a remoto - non funziona  
~~~

Per aggirare questo limite dovrete cambiare un po' lo schema di rsync. Il seguente dovrebbe funzionare:

~~~  
morpheus --> trinity - diventa: morpheus --> neo & neo --> trinity  
trinity --> morpheus - diventa: trinity --> neo & neo --> morpheus  
~~~

Ne risulta quindi un'operazione in più rispetto al passo singolo, ma considerando che si vuole maneggiare i file mediante neo, si tratta solo di un cambiamento della provenienza della sorgente e non del risultato finale. Ciò suppone che i nostri backup siano buoni e nulla vada perso.

`Questo limite di rsync deve essere considerato quando progettate il processo di backup.`

##### Usare gli hostname con rsync

Come descritto in precedenza, l'uso di neo, morpheus o trinity in una traduzione di indirizzi fisici IP è un modo pulito e facile per rendere le cose molto più leggibili. Riuscire a usare quegli hostname è veramente semplice.

Dovrete modificare il vostro file /etc/hosts aggiungendovi gli hostname e i relativi indirizzi IP. Ecco una piccola parte delle linee in cima al file /etc/hosts, che mostra le traslazioni:

~~~  
192.168.1.15 neo  
192.168.1.16 morpheus  
192.168.1.17 trinity  
~~~

La prima riga trasla l'indirizzo IP 192.168.1.15 al nome "neo", la seconda 192.168.1.16 al nome "morpheus" e l'ultima linea 192.168.1.17 al nome "trinity". Dopo aver aggiunto quanto sopra e salvato il file /etc/hosts, potrete il "nome" invece dell'indirizzo IP, ma potete anche continuare a usare l'indirizzo IP. La cosa che rende la traslazione davvero brillante è quando dovete cambiare gli indirizzi IP dei sistemi. Per esempio, supponiamo che neo cambi il suo indirizzo IP da 192.168.1.15 a 192.168.1.25.

Se tutti i vostri script usano gli indirizzi IP, sarete costretti a localizzarli tutti e a sostituire gli indirizzi. Se, invece, i vostri script usano i "nomi", tutto quello che dovrete fare è cambiare il file /etc/hosts per rispecchiare il cambiamento, e tutti gli script funzioneranno. Questo può essere molto pratico quando si hanno molti script che si connettono in remoto ad altri sistemi o viceversa. Il metodo dei "nomi" rende gli script molto più facili da leggere e da seguire in quanto non state usando indirizzi IP ma piuttosto un nome riconoscibile associato all'IP.

#### rsync e i suoi due modi d'uso.

Un modo è  **"spingere"**  i file verso la destinazione, l'altro è  **"tirarli"**  da una sorgente. Ognuno di questi ha i suoi vantaggi e qualche svantaggio. Nella spiegazione che segue supporremo che uno dei sistemi sia locale e l'altro remoto, in modo che possiate comprendere molto meglio la terminologia:

 **"push"**  cioè  **spingere**  - il sistema locale ha nel suo contesto la sorgente dei file e delle cartelle; la destinazione è in un sistema remoto. Il comando rsync è lanciato dal sistema locale e spinge i file verso il sistema di destinazione.

Vantaggi:  
* Potete avere più di un sistema che fa il suo backup su un sistema di destinazione.  
* Il processo di backup è distribuito sull'intero sistema di computer e non è solo un sistema ad essere coinvolto.  
* Se un sistema è più veloce di un altro può finire prima e fare altre cose.

Svantaggi:  
* Se state usando uno script e se ne è programmata l'esecuzione con cron, questo richiederà aggiornamenti e cambiamenti delle molteplici crontabs su ogni sistema così come l'aggiornamento delle molteplici versioni dello script.  
* Il backup non può controllare se il sistema di destinazione ha le partizioni montate e potrebbe non salvare niente sulla destinazione.

 **"pull"**  cioè  **tirare**  - il sistema remoto ha nel suo contesto la sorgente dei file e delle cartelle; la destinazione è nel sistema locale. Il comando rsync viene lanciato dal sistema locale e "tira" i file dal sistema sorgente.

Vantaggi:  
* Un sistema è impostato per fungere da server e controllare tutti i backup per tutti gli altri sistemi: backup centralizzati.  
* Se state usando uno script, questo è tenuto solo su un sistema ed è uno solo, con ciò rendendo facili gli aggiornamenti e le variazioni. Il che vi permette anche di gestire un solo file crontab per programmare l'esecuzione dello script.  
* Lo script può controllare e montare, se necessario, la partizione di destinazione.

###### Sintassi di rsync come descritto nelle sue pagine man:

~~~  
rsync [OPTION]... SRC [SRC]... DEST  
rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST  
rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST  
rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST  
rsync [OPTION]... SRC  
rsync [OPTION]... [USER@]HOST:SRC [DEST]  
rsync [OPTION]... [USER@]HOST::SRC [DEST]  
rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]  
~~~

##### Esempio di comandi rsync:

~~~  
rsync -agEvz --delete-after --exclude='*~' morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Guardiamo un attimo alcune parti di questo comando:

~~~  
il percorso dei file della sorgente è: morpheus:/home/tartie  
la destinazione è: /media/sda7/SysBackups/morpheus/home  
~~~

tutti i file da /home/tartie... verrano salvati in /media/sda7/SysBackups/morpheus/home che apparirà come:

~~~  
/media/sda7/SysBackups/morpheus/home/tartie...  
~~~

È da notare che la sola ragione per cui /tartie è sotto /home è a causa del percorso designato per la DESTINAZIONE, e NON della SORGENTE. La "sorgente" indica solo la provenienza dei file e non dove questi sono diretti. La "destinazione" è quella che dice a rsync dove mettere i file presi dalla "sorgente". Guardate l'esempio seguente:

~~~  
rsync [...] /home/user/data/files /media/sda7/SysBackups/neo  
~~~

In questo comando solo la cartella sorgente /files e il suo contenuto si ritroveranno nella cartella di destinazione /neo - e non in /media/sda7/SysBackups/neo/home/user/data/files

Assicuratevi di tenere in considerazione questo mentre create i comandi di backup per rsync.

##### Spiegazione delle opzioni:

~~~  
-a è usata per il modo archivio.  
La pagina man spiega questa opzione nel modo seguente: "in termini semplici, un modo di salvare ricorsivamente e preservare 'quasi' tutto". Accenna inoltre al fatto che questa opzione non preserva gli 'hardlink' a causa della complessità del processo.  
L'opzione -a è considerata equivalente alla seguente: -rlptgoD che significa:  
-r = recursive - processa le sottocartelle e i file trovati nella nostra locazione "sorgente".  
-l = links - quando incontra dei symlink li ricrea nella cartella di destinazione.  
-p = permissions - dice a rsync di impostare nella destinazione gli stessi permessi della sorgente.  
-t = times - dice a rsync di impostare nella destinazione gli stessi attributi di tempo della sorgente.  
-q = quiet - dice a rsync di tenere al minimo il proprio output anche nel caso che venga aggiunto un livello di verbosità con il comando -v giusto dopo questo. Per rendere il processo completamente 'quiet' rimuovete la 'v' nel comando.  
-o = owner - dice a rsync che anche se è lanciato come root dovrà impostare il proprietario dei file nella destinazione uguale a quello della sorgente.  
-D = equivale a usare i comandi --devices e --specials  
--devices = impone a rsync di trasferire i file dei dispositivi a caratteri e a blocchi al sistema remoto per ricreare questi dispositivi. Sfortunatamente, se non includete anche --super nello stesso comando, il --devices non ha effetto.  
--specials = impone a rsync di trasferire file speciali come i 'named socket' e i 'fifo'.  
-g è usato per preservare l'attributo di "gruppo" della sorgente nella destinazione.  
-E è usato per preservare l'attributo "eseguibile" della sorgente nella destinazione.  
-v è usato per aumentare la verbosità mostrata a video. Allorquando siamo sicuri di star facendo il backup giusto, l'opzione "-v" può essere rimossa. La si può lasciare se, avendo programmato il processo di backup con cron, si preferisce poi "vedere" cosa è stato fatto. Ognuno può decidere liberamente.  
-z è usato per comprimere i dati da "trasferire" o copiare. Ciò velocizza il processo in quanto i dati da trasferire hanno dimensione minore di quella reale.  
--delete-after = i file/cartelle nella destinazione che non esistono più nella sorgente sono cancellati DOPO la fine del trasferimento e non PRIMA. Questo "after" è usato in caso di problemi o crash, e il "delete" è usato per evitare che file che non esistono più nella sorgente rimangano vaganti e non puliti nella destinazione.  
--exclude = uno schema usato per escludere file o cartelle. Ad esempio, --exclude="*~" esclude dal backup TUTTI i file e cartelle che terminano con il carattere "~". Un solo schema può essere gestito da un --exclude, così se ne serve più di uno occorre aggiungere nuovi --exclude con altri schemi nella stringa del comando.  
~~~

Addizionalmente, vi sono altre opzioni utili dei comandi:

~~~  
-c - aggiunge un'altro livello di controllo nella sorgente che verrà confrontata con la destinazione dopo il processo di copia. Verrà impiegato più tempo, a fronte del fatto che rsync già fa un confronto tra sorgente e destinazione durante la copia, e quindi questa opzione non è stata inclusa fra quelle sopra per il semplice fatto che rallenta il processo e in definitiva non è altro che una forma di ridondanza non necessaria.  
--super - come descritto nella pagina man, il ricevente, o il sistema di destinazione, tenterà di agire come superuser.  
--dry-run - mostra cosa verrebbe trasferito, come avviene quando si usa l'opzione -s con apt-get install o apt-get dist-upgrade.  
~~~

La parte restante del nostro comando indica la sorgente dei file/cartelle e la locazione della cartella di destinazione.

##### Esempi di comandi:

~~~  
rsync -agEvz --delete-after --exclude='*~' morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Questo comando salverà tutti i file e le cartelle in /home/tartie sul sistema traslato col nome "morpheus" e li metterà nella cartella /media/sda7/SysBackups/morpheus/home conservandone la struttura presa dalla cartella tartie.

~~~  
rsync -agEvz --delete-after --exclude='*~' /home/tartie neo:/media/sda7/SysBackups/morpheus/home  
~~~

Questo comando è l'inverso del comando di cui sopra. Esso "spingerà" la cartella /home/tartie, i suoi contenuti e le sottocartelle nel sistema chiamato neo nella stessa cartella - notate che un sistema è considerato remoto quando ha il simbolo ":" (due punti) davanti al percorso.

~~~  
rsync -agEvz --delete-after --exclude='*~' /home/cuddles /media/sda7/SysBackups/neo/home  
~~~

Questo comando esegue un backup da locale a locale; notate che non esistono ":" né nella locazione della sorgente né in quella di destinazione. Il comando salverà localmente l'area /home/cuddles nello stesso sistema alla locazione /media/sda7/SysBackups/neo/home.

Vediamo come si presenta un comando multiplo "exclude":

~~~  
rsync -agEvz --delete-after --exclude='*~' --exclude='*.c' --exclude='*.o' "/*" /media/sda7/SysBackups/neo  
~~~

Il comando di cui sopra salverà TUTTO a partire dalla root del sistema locale e metterà tutti i suoi file/cartelle nella locazione di destinazione /media/sda7/SysBackups/neo - ma adesso escluderà tutti i file o le cartelle che finiscono con un "~", o un ".c", o un ".o"'

**`Sotto è riportato un esempio di comando rsync che o esita in errore, o comunque dovrebbe essere evitato quando possibile. È un esempio di un comando rsync da un sistema remoto a un sistema remoto:`**

~~~  
rsync -agEvz --delete-after --exclude='*~' morpheus:/home/tartie trinity:/home  
~~~

**`Come già detto più sopra. questa è una limitazione di rsync.`**

Con l'ultimo esempio, vediamo come si presenta un rsync da remoto a locale se sostituiamo i nostri "nomi di sistema" con gli indirizzi IP.

Il primo comando usa il metodo dei nomi, il secondo è lo stesso esatto comando facendo però uso degli indirizzi IP:

~~~  
rsync -agEvz --delete-after --exclude='*~' morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

~~~  
rsync -agEvz --delete-after --exclude='*~' 192.168.1.16:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Come detto in precedenza, non siete obbligati a usare la traslazione in nomi, ma nel primo esempio, dove viene usata, potete leggere cosa sta facendo il comando molto più facilmente che nel secondo.

Ora dovreste essere in grado di progettare un comando semplice, sia sulla base degli esempi dati, sia mescolando e abbinando i comandi mostrati per ottenere quello che vi serve.

<div id="rev">Page last revised 04/05/2012 1357 UTC</div>
