<div id="main-page"></div>
<div class="divider" id="disknames"></div>
## Denominazione dei Dischi e delle Partizioni

##### **`ATTENZIONE: Per la denominazione dei dischi e delle partizioni`**  [fate riferimento al capitolo "UUID, Etichettare le partizioni e fstab" poiché siduction utilizza in via predefinita UUID](part-uuid-it.htm) .

#### Prassi di denominazioni attuali

##### Per i dischi

A seguito dell'adozione da parte di udev dell'Universal Unique Identifier (UUID) e dell'arrivo degli ultimi kernel linux, tutte le "periferiche a blocchi" usano una denominazione di tre lettere e uno schema numerico basato su `sda, sdb, etc.`  per i dischi e `sdaX, sdbX, etc.`  (dove X è un numero) per le loro partizioni.

Qualsiasi standard essi usino, PATA (IDE), SATA (Serial ATA) o SCSI, il solo modo di differenziare un disco da un altro nella vostra macchina è, al momento attuale, la terza lettera del dispositivo `/dev/sda1, /dev/sdb1, /dev/sdc1, /dev/sdd1,`  etc.

Vedrete i dispositivi elencati in questo modo nelle finestre che compaiono quando si porta il puntatore del mouse sulle icone dei media presenti sulla scrivania di una siduction in versione liveCD o installata su disco.

Vi invitiamo caldamente a creare una tabella, manualmente o con appositi programmi, nella quale potrete elencare i dettagli di tutti i dispositivi a blocchi disponibili nel computer. Attività magari noiosa ma che può in seguito fare risparmiare un sacco di tempo e di problemi.

Il file `/etc/fstab`  di siduction, sia nel liveCD sia in un'installazione su disco, tiene l'informazione `/dev/sdaX`  tra parentesi quadre nella linea commentata (#) sopra ogni stringa dei vari dispositivi. Per esempio (l'eventuale grassetto è usato solo a scopo esemplificativo):

~~~  
# added by siduction [ **/dev/sdd1 , no label]  
UUID=2ae950df-7d72-4d9b-a71a-bad1eb2d4f6a / ext4 defaults,errors=remount-ro,relatime 0 1  
~~~

##### Per le partizioni

Come vedete sopra, per le partizioni l'identificatore `/dev/disk`  è completato da un numero. 

Vi sono i seguenti tipi di partizione: primaria, estesa e logica, dove queste ultime sono contenute dentro quelle di tipo esteso. Su un singolo dispositivo possono esistere un massimo di 4 partizioni primarie o 3 primarie e una estesa, e questa può contenere fino a 11 (undici) partizioni logiche. 

Il nuovo standard in arrivo quale componente dello UEFI-Standard, la GUID Partition Table (GPT), è il successore del MBR. Consente di usare dimensioni dei dischi e delle partizioni maggiori di 2 TByte, il quale costituisce il limite massimo del MBR, e di creare un numero illimitato - almeno in teoria - di partizioni. Maggiori informazioni possono essere trovate in  [Wikipedia](http://en.wikipedia.org/wiki/GUID_Partition_Table) .

Le partizioni primarie e le estese hanno un nome compreso tra sda1 e sda4. Le partizioni logiche sono sempre contigue e parte di una partizione di tipo esteso: potete definire (a piacere) al massimo 11 di tali partizioni e la loro denominazione inizia dal numero 5 (es., sda5) e finisce con il 15 (sda15).

##### Alcuni esempi applicativi

`/dev/sda5` : può solo essere una partizione logica (in questo caso, la prima del dispositivo a disco al quale appartiene), localizzata o sul primo disco SATA o sul primo disco IDE del vostro computer (dipende da come è impostato il BIOS).

`/dev/sdb3`  potrebbe essere una partizione primaria o una partizione estesa; essendo la lettera del disco differente da quella del precedente esempio possiamo solo dire che la partizione non può in nessun caso essere localizzata sullo stesso dispositivo.

#### Vecchie denominazioni ora obsolete per i dispositivi IDE

Sui vecchi sistemi linux, i dispositivi disco IDE (PATA) erano differenzati da quelli che usano lo standard corrente da un nome come `hdaX`  invece di sdaX.

<div class="divider" id="partition"></div>
## Partizionare il disco fisso usando cfdisk

**`Per usi normali siduction raccomanda il file system ext4: è quello predefinito ed è ben mantenuto.`**

Aprite una konsole/xterm, diventate root e avviate cfdisk  
 *(se state usando una siduction installata su disco dovrete immettere la password di root)* :

~~~  
su  
cfdisk /dev/sda  
~~~

##### L'interfaccia utente

Nella prima schermata cfdisk mostra la tabella delle partizioni corrente con i nomi e alcuni dati riguardo ogni partizione. In basso nella schermata vi sono alcuni pulsanti di comando. Per cambiare partizione usate  **i tasti freccia su e giù** ; per cambiare comando usate  **i tasti freccia sinistra e destra** .

##### Cancellare una partizione

![Delete a partition](../images-en/cfdisk-en/cfdisk0-en.png "Delete a partition") 

Per cancellare una partizione, evidenziatela raggiungendola con i tasti freccia su e giù, e selezionate il comando

~~~  
Delete  
~~~

con i tasti freccia sinistra e destra, poi, premete

~~~  
Invio  
~~~

##### Creare una nuova partizione

![Create a new partition](../images-en/cfdisk-en/cfdisk1-en.png "Create a new partition") 

Per creare una nuova partizione usate il comando:

~~~  
New  
~~~

(selezionatelo con i tasti freccia sinistra e destra) e premete "Invio". Dovrete decidere il tipo della partizione,  **primaria**  o  **logica** . In caso di una partizione logica, il programma automaticamente creerà prima una partizione estesa. Poi dovrete scegliere la dimensione della partizione (in MB). Se non vi riesce di inserire un valore in MB, ritornate alla schermata principale con il tasto ESC e selezionate MB con il comando

~~~  
Units  
~~~

##### Tipo di partizione

![Type of a partition 1](../images-en/cfdisk-en/cfdisk2-en.png "Type of a partition 1") 

Per impostare il tipo di una partizione come  **Linux swap**  o  **Linux**  evidenziate la partizione attuale e usate il comando:

~~~  
Type  
 .  
~~~

Otterrete una lista di tipi differenti. Premete "spazio" e otterrete ancora altri tipi. Trovate quello che vi serve e immettetene il numero al prompt ( **Linux swap**  è il Tipo  **82** , i filesystem  **Linux**  dovrebbero essere Tipo  **83** ).

![Type of a partition 2](../images-en/cfdisk-en/cfdisk3-en.png "Type of a partition 2") 

##### Rendere avviabile una partizione

Con linux non c'è bisogno di rendere avviabile una partizione ma alcuni sistemi operativi lo richiedono. NOTA: quando si installa su un disco fisso esterno, una partizione deve essere avviabile. Evidenziate la partizione e selezionate il comando:

~~~  
Bootable  
~~~

##### Scrivere sul disco i cambiamenti apportati

Quando avete finito le vostre impostazioni potete registrarle usando il comando di scrittura Write. La tabella delle partizioni verrà registrata sul disco (se vi è segnalato errore relativo a 'DOS' potete ignorarlo). Poiché la scrittura dei cambiamenti comporta la distruzione di tutti i dati sulle partizioni che intendete cancellare o cambiare, dovete essere molto sicuri di volerlo fare prima di premere il tasto

~~~  
Invio  
~~~

![Write the result to disk](../images-en/cfdisk-en/cfdisk4-en.png "Write the result to disk") 

##### Chiudere il programma

Per uscire dal programma, selezionate il comando Quit. Dopo essere usciti da cfdisk e prima di iniziare la formattazione o l'installazione, dovrete riavviare il sistema in modo che siduction possa leggere la nuova tabella delle partizioni.


---

<div class="divider" id="formating"></div>
## Formattare le partizioni (dopo il partizionamento con cfdisk)

##### Informazioni di base

Una partizione deve avere un filesystem. Linux riconosce e può usare diversi filesystem. Vi sono ReiserFs, Ext4, e, per utenti con una certa esperienza, XFS e JFS. Ext2 è pratico come formato di immagazzinamento dati poiché è disponibile un driver utilizzabile da Windows per lo scambio dei dati tra i due sistemi.  [File system Ext2 installabile per MS Windows](http://www.fs-driver.org/) .

**`Per usi normali di siduction raccomandiamo il filesystem ext4: è quello predefinito ed è ben mantenuto.`**

##### Formattare

Con la chiusura di  **cfdisk**  si ritorna alla console. Per formattare dovete essere root. Per formattare la partizione root e/o la home - nell'esempio seguente  **sdb1**  - immettiamo i comandi  *(se state usando una siduction installata su disco fisso vi sarà richiesta la password di root):* 

~~~  
su  
mkfs -t ext4 /dev/sdb1  
~~~

Vi sarà posto il quesito se siete sicuri di aver scelto la partizione giusta, al quale risponderete 'sì'.

Quando il comando è eseguito, verrete informati che la formattazione ext4 è stata scritta con successo sul disco. Se ciò non avviene, qualcosa probabilmente è andato storto nel partizionamento con cfdisk, o sdb1 non è una partizione linux. In tal caso potete controllare con 

~~~  
fdisk -l /dev/sdb  
~~~

Se qualcosa è andato storto, dovrete partizionare di nuovo.

Se la formattazione ha avuto successo, seguite la stessa procedura per la partizione "home" (se ne volete una separata).

Infine, formattate la partizione swap, in questo esempio hdb3:

~~~  
mkswap /dev/sdb3  
~~~

e poi attivatela:

~~~  
swapon /dev/sdb3  
~~~

Controllate quindi se viene riconosciuta scrivendo in console:

~~~  
swapon -s  
~~~

la swap appena montata dovrebbe essere riconosciuta, nel nostro caso, come:

<table class="center">
| Filename | Type | Size | Used | Priority | 
| ---- | ---- | ---- | ---- | ---- |
| /dev/sdb3 | partition | 995988 | 248632 | -1 | 


---

Se la swap è correttamente riconosciuta, potete disattivarla con 

~~~  
swapoff -a  
~~~

e riavviare.

Ora siete pronti per avviare l'installazione.

<div id="rev">Content last revised 1/04/2012 2315 UTC</div>
