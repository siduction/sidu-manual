<div id="main-page"></div>
<div class="divider" id="gdisk-1"></div>
## Partizionamento con gdisk secondo lo standard GPT

gdisk è uno strumento per partizionare dischi fissi di qualunque dimensione secondo lo standard GPT, acronimo di GUID (Globally Unique Identifier) Partition Table (PT), cioè tabella delle partizioni con identificatore globalmente unico, `indispensabile per dischi di capacità maggiore di 2 TB` . In via predefinita, gdisk farà sì che le vostre partizioni siano bene allineate per i dischi SSD (o per dischi fissi che non hanno settori di 512 byte).

Vantaggio fondamentale di GPT è che elimina la necessità di basarsi su partizioni primarie, estese o logiche come è proprio del partizionamento dei dischi basati sul Main Boot Record, cioè sul record di avvio principale. GPT può supportare un numero pressoché illimitato di partizioni e ha quale limite solo l'ammontare dello spazio riservato per le partizioni nel disco. Si noti, tuttavia, che lo strumento `gdisk`  ha quale valore predefinito 128 partizioni.

Tuttavia, utilizzare GPT su piccole penne USB/SSD (ad esempio, una penna di 8GB) potrebbe essere controproducente se avete necessità di trasferire dati da un computer all'altro o da un sistema operativo all'altro.

### Osservazioni importanti

`I termini UEFI ed EFI sono interscambiabili e significano la stessa cosa.` 

##### Dischi GPT

`Alcuni sistemi operativi non supportano i dischi di dati GPT: fate riferimento, in proposito, alla documentazione del sistema operativo` .

I dischi di dati GPT possono essere utilizzati in Linux con macchine a 32 o a 64 bit.

##### Avviare dischi GPT

Il doppio e triplo avvio dei dischi GPT con Linux, BSD e Apple è supportato utilizzando il modo `EFI`  a 64 bit.

Il doppio avvio dei dischi GPT con Linux e MS Windows è possibile, a patto che MS Windows possa avviare i dischi GPT in modalità `UEFI`  a 64 bit.

##### Strumenti grafici di partizionamento per usare GPT

A parte gdisk, basato su terminale, strumenti come "gparted" e "partitionmanager" forniscono un'interfaccia grafica per supportare i dischi GPT. Stabilito ciò, gdisk dovrebbe essere il vostro strumento preferito per aiutare a evitare  
anomalie non intenzionali dell'ambiente grafico. Tuttavia "Gparted - gparted" insieme a "KDE Partition Manager - partitionmanager", fra gli altri, sono ottimi strumenti per darvi un'immagine visiva di quello che avete fatto con gdisk.

`Letture obbligatorie prima di procedere oltre:`

+ ~~~    
   man gdisk    
   ~~~
  
+  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/)   
+  [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table)   

<div class="divider" id="gdisk-2"></div>
## Partitionare il disco fisso con gdisk in un sistema Linux

###### Per ben comprendere i comandi principali di gdisk come **`m`**  per tornare al menu principale, **`d`** ,**`n`** , **`p`**  e **`t`** , fra gli altri, che saranno fondamentalmente i comandi base per le vostre esigenze di partizionamento, varrà la pena esplorare gdisk su diun disco di prova.

##### **`NOTA IMPORTANTE riguardo al comando "n":`**  

Quando utilizzate il comando **`n`** , premete &lt;Enter&gt; una prima volta per dare alla partizione il primo numero progressivo libero e poi premete nuovamente &lt;Enter&gt; per accettare il settore iniziale di default per la partizione prima di impostare la dimensione di cui avete bisogno per l'ultimo settore. Per esempio:

~~~  
Command (? for help): n  
Partition number (2-128, default 2): 2  
First sector (34-15728606, default = 411648 ) or {+-}size{KMGTP}:  
Last sector (411648 -15728606, default = 15728606) or {+-}size{KMGTP}: +6144M  
~~~

### Esempio di partizionamento di un disco GPT

 *Sequenza per soddisfare le vostre esigenze* :

1. Creare una partizione bootloader `(assumendo che il disco non debba contenere unicamente dati e debba essere avviabile)`   
2. Creare una partizione swap `(con le stesse assunzioni di cui al punto precedente)`   
3. Creare le partizioni linux   
4. Creare eventuali partizioni per i dati   

**`NOTA: l'esempio seguente fa riferimento a una penna USB per dimostrare i passi richiesti e pertanto non è esaustivo.`** 

### I passi

Se non siete sicuri del nome del disco, utilizzate fdisk per  
identificarlo (sono richiesti privilegi di root per tutti i comandi di partizionamento e formattazione):

~~~  
fdisk -l  
~~~

fdisk restituirà il percorso richiesto e probabilmente includerà anche nomi di partizioni: tuttavia, al momento attuale, dovrete considerare solo il percorso del disco senza tenere conto di partizioni che possono esistere nel suo contesto. Per esempio, supponiamo che sia `sdb`  e avviamo gdisk con il percorso:

~~~  
gdisk /dev/sdb  
~~~

`Se il disco non è nuovo oppure utilizza già GPT verrà all'inizio visualizzato un avvertimento:` 

~~~  
GPT fdisk (gdisk) version 0.7.2  
Partition table scan:  
MBR: MBR only  
BSD: not present  
APM: not present  
GPT: not present  
***************************************************************  
Found invalid GPT and valid MBR; converting MBR to GPT format.  
THIS OPERATION IS POTENTIALLY DESTRUCTIVE! Exit by typing 'q' if  
you don't want to convert your MBR partitions to GPT format!  
***************************************************************  
Command (? for help):  
~~~

Quando si avvia `gdisk`  su un disco con partizioni MBR già esistenti e non GPT, il programma visualizza un messaggio contornato da asterischi riguardo alla possibile conversione delle partizioni esistenti a GPT. `Ciò ha lo scopo di destare in voi un allarme nel caso abbiate avviato gdisk nel disco sbagliato oppure se non abbiate idea di cosa si sta facendo. Dovrete rispondere esplicitamente a questo avvertimento prima di procedere. Trattasi dunque di un messaggio finalizzato a evitare il danneggiamento dei dischi di avvio.` 

Premete **`?`**  e vedrete una lista di comandi disponibili (i comandi `colorati`  sono qui riportati per motivi di documentazione):

~~~  
Command (? for help): **`?`**   
b back up GPT data to a file  
c change a partition's name  
d delete a partition  
i show detailed information on a partition  
l list known partition types  
n add a new partition  
o create a new empty GUID partition table (GPT)  
p print the partition table  
q quit without saving changes  
r recovery and transformation options (experts only)  
s sort partitions  
t change a partition's type code  
v verify disk  
w write table to disk and exit  
x extra functionality (experts only)  
? print this menu  
~~~

Per verificare che stiate veramente lavorando sul disco giusto premete **`p`** .

~~~  
Command (? for help): p   
Disk /dev/sdb: 16547840 sectors, 7.9 GiB Questo esempio si riferisce a una penna da 8GB   
Logical sector size: 512 bytes  
Disk identifier (GUID): 0267952D-9B06-4B10-A648-B83684786910  
Partition table holds up to 128 entries  
First usable sector is 34, last usable sector is 16547806  
Partitions will be aligned on 2048-sector boundaries  
Total free space is 16547773 sectors (7.9 GiB)  
Number Start (sector) End (sector) Size Code Name  
~~~

La colonna `Code`  dell'output mostra il codice del tipo di partizione, la colonna `Name`  una stringa di testo che potete modificare.

### Cancellare la tabella delle partizioni

Adesso è necessario cancellare per intero la tabella delle partizioni del disco per poter impostare il partizionamento GPT:

~~~  
command (? for help): d   
~~~

<div class="divider" id="gdisk-3"></div>
## Avvio con GPT-EFI o con GPT-BIOS

Ove fosse necessario poter avviare da un disco GPT avete a disposizione 2 opzioni per formattarne il settore d'avvio.

Le opzioni sono diverse se:

+ `Nella macchina è disponibile (U)EFI tramite il BIOS, è abilitato e selezionato come avviabile`   
+ volete utilizzare EFI per avviare un disco formattato come GPT  

**`oppure`** 

+ Nella macchina **`non`**  è disponibile (U)EFI tramite il BIOS  
+ volete utilizzare il BIOS per avviare un disco formattato come GPT.  

### Avvio EFI

**`Il BIOS dispone di EFI abilitato e selezionato come avviabile.`**  

Se state per avviare utilizzando EFI deve essere disponibile una partizione di sistema EFI formattata come FAT (tipo `EF00` ) come prima partizione. Questa partizione conterrà il/i bootloader. Quando installate il programma, questo ignorerà ogni scelta "da dove avviare" prospettata in install-gui e un bootloader siduction verrà installato nella partizione di sistema EFI in `/efi/siduction` . La partizione di sistema EFI verrà montata come `/boot/efi` : se si lascia selezionata l'opzione "monta altre partizioni" non c'è bisogno di dire al programma di installazione di fare il mount di questa partizione.

**`NOTA: il boot da USB non è supportato via GPT.`** 

#### Creare la partizione bootloader EFI

Scrivete **`n`**  per aggiungere una nuova partizione e `+200M`  per dare una dimensione al bootloader.

~~~  
Command (? for help): n   
Partition number (1-128, default 1): 1   
~~~

~~~  
First sector (34-16547806, default = 34) or {+-}size{KMGTP}:  
Information: Moved requested sector from 34 to 2048 in  
order to align on 2048-sector boundaries.  
Use 'l' on the experts' menu to adjust alignment  
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M   
Current type is 'Linux filesystem'  
~~~

 Scrivendo **`L`**  vi verrà prospettato un elenco di codici:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): L   
0700 Microsoft basic data 0c01 Microsoft reserved 2700 Windows RE  
4200 Windows LDM data 4201 Windows LDM metadata 7501 IBM GPFS  
7f00 ChromeOS kernel 7f01 ChromeOS root 7f02 ChromeOS reserved  
8200 Linux swap 8300 Linux filesystem 8301 Linux reserved  
8e00 Linux LVM a500 FreeBSD disklabel a501 FreeBSD boot  
a502 FreeBSD swap a503 FreeBSD UFS a504 FreeBSD ZFS  
a505 FreeBSD Vinum/RAID a800 Apple UFS a901 NetBSD swap  
a902 NetBSD FFS a903 NetBSD LFS a904 NetBSD concatenated  
a905 NetBSD encrypted a906 NetBSD RAID ab00 Apple boot  
af00 Apple HFS/HFS+ af01 Apple RAID af02 Apple RAID offline  
af03 Apple label af04 AppleTV recovery be00 Solaris boot  
bf00 Solaris root bf01 Solaris /usr & Mac Z bf02 Solaris swap  
bf03 Solaris backup bf04 Solaris /var bf05 Solaris /home  
bf06 Solaris alternate se bf07 Solaris Reserved 1 bf08 Solaris Reserved 2  
bf09 Solaris Reserved 3 bf0a Solaris Reserved 4 bf0b Solaris Reserved 5  
c001 HP-UX data c002 HP-UX service ef00 EFI System   
ef01 MBR partition scheme ef02 BIOS boot partition fd00 Linux RAID  
~~~

Scrivete `ef00`  per ottenere una partizione UEFI:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): ef00   
Changed system type of partition to 'EFI System'  
~~~

### Avvio BIOS

#### Creare una partizione di avvio BIOS

Se il sistema non supporta UEFI, potete creare una partizione di avvio BIOS, che va a sostituire, in un disco partizionato come DOS, il settore che si trova tra la tabella delle partizioni e la prima partizione dove viene scritto direttamente grub.

Scrivete **`n`**  per aggiungere una nuova partizione e `+200M`  per dare una dimensione al bootloader (la ragione di crearla di +200M, a fronte dei tradizionali +32M, è avere pronta una partizione dimensionata per EFI nel caso si dovesse cambiare l'avvio del disco in EFI).

~~~  
Command (? for help): n   
Partition number (1-128, default 1): 1   
~~~

~~~  
First sector (34-16547806, default = 34) or {+-}size{KMGTP}:  
Information: Moved requested sector from 34 to 2048 in  
order to align on 2048-sector boundaries.  
Use 'l' on the experts' menu to adjust alignment  
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M   
Current type is 'Linux filesystem'  
~~~

Scrivete `ef02`  per ottenere una partizione di avvio BIOS:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): ef02   
Changed system type of partition to 'BIOS boot'  
~~~

**`Nota Importante: la partizione di avvio BIOS non deve essere formattata.`** 

<div class="divider" id="gdisk-4"></div>
### Creare la partizione di swap

La dimensione della partizione di swap non dovrebbe mai essere sottostimata, soprattutto per i portatili che devono avere la possibilità di fare il "sospendi su disco" quando richiesto. Dovrebbe almeno eguagliare la dimensione della RAM.

Scrivete **`n`**  per aggiungere una nuova partizione e `+2G`  (o `+2048M` ) per dare una dimensione alla partizione di swap con codice di tipo `8200` . Un esempio di questa procedura avrà aspetto simile a:

~~~  
Command (? for help): n   
Partition number (2-128, default 2): 2   
First sector (34-15728606, default = 411648) or {+-}size{KMGTP}:  
Last sector (411648-15728606, default = 15728606) or {+-}size{KMGTP}: **`+2048M   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 8200   
Changed type of partition to 'Linux swap  
~~~

<div class="divider" id="gdisk-5"></div>
### Creare le partizioni dati

Scrivete **`n`**  per aggiungere una partizione e `XXXG`  per darle una dimensione. In questo esempio `+4G` :

~~~  
Partition number (3-128, default 3): 3   
First sector (34-15728606, default = 4605952) or {+-}size{KMGTP}:  
Last sector (4605952-15728606, default = 15728606) or {+-}size{KMGTP}: **`+4G   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 8300   
Changed type of partition to 'Linux filesystem  
~~~

`Ripetete il procedimento per eventuali altre partizioni.` 

Dal momento che l'esempio che segue si riferisce a una penna USB può essere saggio creare una partizione `Any OS Data` , cioè di dati utilizzabili con qualunque SO, con codice di tipo `0700` , altrimenti darle il codice per un filesystem linux (8300):

~~~  
Command (? for help): n   
Partition number (4-128, default 4): 4   
First sector (34-15728606, default = 12994560) or {+-}size{KMGTP}:  
Last sector (12994560-15728606, default = 15728606) or {+-}size{KMGTP}:**`+1300M   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 0700   
Changed type of partition to 'Microsoft basic data'  
~~~

Per esaminare le partizioni create:

~~~  
Command (? for help): p   
Disk /dev/sdx: 15728640 sectors, 7.5 GiB  
Logical sector size: 512 bytes  
Disk identifier (GUID): F409CFD3-6DDC-4551-BBC5-85DC218C1352  
Partition table holds up to 128 entries  
First usable sector is 34, last usable sector is 15728606  
Partitions will be aligned on 2048-sector boundaries  
Total free space is 73661 sectors (36.0 MiB)  
Number Start (sector) End (sector) Size Code Name  
1 2048 411647 200.0 MiB EF00 Boot  
2 411648 4605951 2.0 GiB 8200 Swap  
3 4605952 12994559 4.0 GiB 8300 Linux File System  
4 12994560 15656959 1.3 GiB 0700 Any OS Data  
~~~

Per aggiungere una descrizione a ognuna delle partizioni, utilizzate il comando **`c`**  per indicarne lo scopo. Per esempio:

~~~  
Command (? for help): c   
Partition number (1-4): 4   
Enter name: Nome descrittivo di vostra scelta   
~~~

Il comando **`w`**  scrive i cambiamenti sul disco mentre il comando **`q`**  esce dal programma senza salvarli:

~~~  
Command (? for help): w   
Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING  
PARTITIONS!!  
Do you want to proceed? (Y/N): y   
OK; writing new GUID partition table (GPT).  
The operation has completed successfully.  
~~~

<div class="divider" id="gdisk-6"></div>
## Formattare le partizioni

Dal momento che gdisk crea partizioni e non filesystem, dovrete  
formattare ogni partizione creata tramite la console. Tuttavia è necessario conoscere i nomi delle partizioni in modo da eseguire correttamente la formattazione. Perciò, eseguite:

~~~  
fdisk -l  
~~~

e fdisk vi fornirà l'informazione richiesta. Supponendo che questa sia `sdb`  :

~~~  
gdisk /dev/sdb  
Command (? for help): p   
~~~

Adesso premete **`q`**  per uscire da gdisk e tornare al prompt root **`#`** , in modo da poter inserire il percorso per ogni numero di partizione:

Per le partizioni UEFI **`(non formattate la partizione di avvio BIOS)`** :

~~~  
mkfs -t vfat /dev/sdb1  
~~~

Per le partizioni Linux `(la sintassi cambierà per ogni partizione addizionale, quindi sdb4, sdb5, e così via)` :

~~~  
mkfs -t ext4 /dev/sdb3  
~~~

Per la partizione comune a sistemi operativi differenti ('Any OS Partition') `(probabilmente richiesta soltanto se una penna USB è necessaria per l'interoperabilità)` :

~~~  
mkfs -t vfat /dev/sdb4  
~~~

Formattate la partizione di swap:

~~~  
mkswap /dev/sdb2  
~~~

Quindi:

~~~  
swapon /dev/sdb2  
~~~

Infine, controllate se swap viene riconosciuto digitando nella console:

~~~  
swapon -s  
~~~

In caso affermativo, eseguite

~~~  
swapoff -a  
~~~

Questi comandi funzionano come per per le partizioni MBR.

##### **`È assolutamente necessario riavviare per fare in modo che il nuovo schema di partizionamento possa essere letto dal kernel.`** 

Dopo il riavvio siete pronti per iniziare l'installazione nel disco GPT, o per utilizzarlo.

<div class="divider" id="gdisk-7"></div>
## Comandi avanzati di gdisk

Prima di salvare le modifiche è utile verificare che non ci siano problemi con le strutture dati GPT. Per farlo si può utilizzare il comando **`v`** :

~~~  
Command (? for help): v   
No problems found. 0 free sectors (0 bytes) available in 0  
segments, the largest of which is 0 sectors (0 bytes) in size  
~~~

In questo caso, ogni byte disponibile nel disco è allocato alle partizioni e non sono stati rilevati problemi. Se ci fosse stato spazio disponibile per la creazione di altre partizioni, il comando "v" ne avrebbe indicato la quantità. Se gdisk trova problemi, come partizioni sovrapposte oppure tabelle delle partizioni principale e di backup non corrispondenti, li avrebbe riportati. Naturalmente, gdisk include misure di sicurezza per  
essere certi che l'utente non possa creare problemi. L'opzione di controllo "v" è intesa per dare un aiuto nel rilevare problemi che possono risultare da corruzione dei dati.

Se sono stati rilevati problemi, si possono correggere tramite le varie opzioni del `recovery & transformation menu` , che è un secondo menu di opzioni disponibile premendo **`r`**  :

~~~  
Command (? for help): r   
recovery/transformation command (? for help): **`?`**   
b use backup GPT header (rebuilding main)  
c load backup partition table from disk (rebuilding main)  
d use main GPT header (rebuilding backup)  
e load main partition table from disk (rebuilding backup)  
f load MBR and build fresh GPT from it  
g convert GPT into MBR and exit  
h make hybrid MBR  
i show detailed information on a partition  
l load partition data from a backup file  
m return to main menu  
o print protective MBR data  
p print the partition table  
q quit without saving changes  
t transform BSD disklabel partition  
v verify disk  
w write table to disk and exit  
x extra functionality (experts only)  
? print this menu  
~~~

Un terzo menu, `experts menu` , può essere visualizzato premendo **`x`**  o nel `main menu`  o nel `recovery & transformation menu` .

~~~  
recovery/transformation command (? for help): x   
Expert command (? for help): **`?`**   
a set attributes  
c change partition GUID  
d display the sector alignment value  
e relocate backup data structures to the end of the disk  
g change disk GUID  
i show detailed information on a partition  
l set the sector alignment value  
m return to main menu  
n create a new protective MBR  
o print protective MBR data  
p print the partition table  
q quit without saving changes  
r recovery and transformation options (experts only)  
s resize partition table  
v verify disk  
w write table to disk and exit  
z zap (destroy) GPT data structures and exit  
? print this menu  
~~~

Potete eseguire delle modifiche a basso livello, come cambiare i GUID delle partizioni o dei dischi (opzioni **`c`**  e **`g`** , rispettivamente). L'opzione **`z`**  distrugge immediatamente le strutture dati GPT, cosa che deve essere fatta se si vuole riutilizzare un disco GPT con un altro schema di partizionamento. Se queste strutture non vengono cancellate, alcuni strumenti di partizionamento possono confondersi per la presenza  
apparente di due sistemi di partizioni.

In termini generali, le opzioni nei menu `recovery & transformation`  ed `experts`  non dovrebbero essere utilizzate se non si è esperti. Tuttavia, anche i non esperti potrebbero essere costretti a utilizzare questi menu se un disco è danneggiato. Prima di fare azioni drastiche si dovrebbe utilizzare l'opzione **`b`**  nel menu principale per creare un backup in un file e memorizzarlo in una penna USB o in altro posto che non sia nel disco che si sta modificando. In tal modo potrete recuperare la configurazione originale se si danneggiano le partizioni.

###### Fonti: 

  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/) 

  [Windows Hardware Developer Center](http://msdn.microsoft.com/en-us/windows/hardware/gg463525) 

<!--<div class="divider" id="gdisk-8"></div>
## Doppio avvio con Linux e un altro SO - TBA

+ ~~~    
   man gdisk    
   ~~~
  
+  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/)   
+  [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table)   

</div>-->
<div id="rev">Content last revised 16/04/2012 1822 UTC</div>
