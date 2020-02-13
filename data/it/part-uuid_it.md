<div id="main-page"></div>
<div class="divider" id="uuid"></div>
## Ricostruire fstab e creare i punti di mount

`Una volta installata, siduction utilizza in via predefinita uuid nel fstab.`

Per far comparire una partizione appena creata (supponiamo sia sda6 o sdb7) non presente in fstab o che deve essere montata, digitate in una console, come utente normale ($), il seguente comando:

~~~  
ls -l /dev/disk/by-uuid  
~~~

il quale vi mostrerà sullo schermo qualcosa di simile a quanto segue (il grassetto è usato solo a titolo di esempio):

~~~  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 348ea9e6-7879-4332-8d7a-915507574a80 -> ../../sda4  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 610aaaeb-a65e-4269-9714-b26a1388a106 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 857c5e63-c9be-4080-b4c2-72d606435051 -> ../../sda5  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 a83b8ede-a9df-4df6-bfc7-02b8b7a5f1f2 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42  ad662d33-6934-459c-a128-bdf0393e0f44  -> ../../sda6  
~~~

In questo esempio,  **ad662d33-6934-459c-a128-bdf0393e0f44**  è il valore mancante. Il passo successivo consiste nell'immettere la partizione UUID nel file /etc/fstab. Usate allo scopo un editor di testo (come kate o kwrite) avviato con privilegi di root:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=ad662d33-6934-459c-a128-bdf0393e0f44  /media/disk1part6 ext4 auto,users,exec 0 2    
~~~
  
Altro esempio:

~~~  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 30ebb8eb-8f22-460c-b8dd-59140274829d -> ../../sdb8  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 387d6d4b-4508-4b8e-8ed2-76998f41dae4 -> ../../sdb1  
rwxrwxrwx 1 root root 10 2007-05-28 13:18 7014f66f-6cdf-4fe1-83da-9cab7b6fab1a -> ../../sdb5  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 8f042ead-259f-4df0-98ec-3343080396c5 -> ../../sdb6  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 94B0AE63B0AE4B94 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 A61820AA18207B85 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f28725d6-b7b5-4207-8476-36efe1a903ce -> ../../sdb9  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f855c263-2521-48d3-8ec9-d2d2b69b6635 -> ../../sda3  
rwxrwxrwx 1 root root 10 2007-05-28 13:18  f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  -> ../../sdb7  
~~~

In questo caso  **f9aa4027-ecdd-4a86-84e2-df2ef73fe14e**  è il valore mancante e verrà aggiunto al file /etc/fstab:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  /media/disk2part7 ext4 auto,users,exec 0 2    
~~~
  
### Creare nuovi punti di mount
  
 `Nota:`  Ogni nome di punto di mount, come mostrato in fstab, ha bisogno di avere una directory già esistente. Siduction crea queste directory durante la fase di installazione in `/media`  e le denomina `diskXpartX` .

Se avete manipolato la tabella delle partizioni dopo l'iniziale installazione e supponendo abbiate già modificato fstab (per esempio, avete creato 2 nuove partizioni), la directory per ognuno dei due punti di mount non esisterà e dovrà essere creata manualmente.

##### Esempio:

Per prima cosa, come root, confermate i punti di mount esistenti:

~~~  
cd /media  
ls  
~~~

Dovreste vederli elencati, ad esempio:

~~~  
disk1part1 disk1part3 disk2part1  
~~~

Rimanendo in /media, create i punti di mount delle nuove partizioni:

~~~  
mkdir disk1part6  
mkdir disk2part7  
~~~

Per verificare o per usare immediatamente le partizioni:

~~~  
mount /dev/sda6 /media/disk1part6  
mount /dev/sdb7 /media/disk2part7  
~~~

Al riavvio del computer i filesystem verranno montati automaticamente.

Naturalmente non dovete ritenervi vincolati allo schema di nomi proposto `diskXpartX` .  *Potete denominare i vostri punti di mount (e di riflesso anche i valori in fstab) con dizioni comprensibili come 'dati' o 'musica'.* 

Leggete:

~~~  
man mount  
~~~

<div class="divider" id="uuid-fstab"></div>
## Veduta d'insieme: UUID, Denominazione delle partizioni e fstab

Una denominazione persistente dei dispositivi a blocchi è stata resa possibile dall'introduzione di udev e offre alcuni vantaggi rispetto alla denominazione basata su bus.

Man mano che le distribuzioni di Linux e udev evolvono e il rilevamento dell'hardware diviene più affidabile, si presentano anche nuovi problemi e cambiamenti:  
 **1)**  Nel caso abbiate più di un controller per dischi sata/scsi o ide e l'ordine secondo cui vengono aggiunti è casuale, può accadere che dispositivi con nomi come hdX e hdY vadano incontro casualmente a scambio del nome a ogni riavvio. Lo stesso accade per sdX e sdY. La denominazione persistente fa sì che non dobbiate preoccuparvi di questo problema.  
 **2)**  Con l'introduzione recente del nuovo supporto libATA PATA, tutti i dispositivi ide hdX sono denominati sdX. E ancora, con la denominazione persistente, non ve ne accorgerete neppure.  
 **3)**  Attualmente le macchine dotate contemporaneamente di controller sata e ide sono piuttosto comuni. Con i cambi di libATA, di cui sopra, il primo problema è diventato ancora meno comune dato che i dischi sata e ide hanno adesso entrambi nomi di tipo sdX.

`Durante l'installazione siduction userà in via predefinita la denominazione uuid in fstab.`

## I quattro diversi schemi di denominazione persistente:

#### 1. Denominazione persistente mediante UUID

UUID significa "Universally Unique Identifier" (cioè, identificatore unico universale) ed è un meccanismo per assegnare ad ogni filesystem un identificatore unico. È stato disegnato in modo che le collisioni siano improbabili. Tutti i filesystem Linux (incluso lo swap) supportano UUID. I filesystem FAT e NTFS non supportano UUID, ma vengono lo stesso elencati in 'by-uuid' con un identificatore unico:

~~~  
$ /bin/ls -lF /dev/disk/by-uuid/  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 2d781b26-0285-421a-b9d0-d4a0d3b55680 -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 31f8eb0d-612b-4805-835e-0e6d8b8c5591 -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 3FC2-3DDB -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 5090093f-e023-4a93-b2b6-8a9568dd23dc -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 912c7844-5430-4eea-b55c-e23f8959a8ee -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 B0DC1977DC193954 -> ../../sdb1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 bae98338-ec29-4beb-aacf-107e44599b2e -> ../../sdb2  
~~~

Come potete vedere, le partizioni fat e ntfs (sda6 e sdb1) hanno nomi più corti, ma vengono elencate lo stesso con uuid.

#### 2. Denominazione persistente mediante LABEL

Quasi tutti i tipi di filesystem possono avere una label (cioè, un'etichetta). Tutte le partizioni che ne hanno una sono elencate nella cartella /dev/disk/by-label:

~~~  
$ ls -lF /dev/disk/by-label  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data2 -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 fat -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1  
~~~

Anche se le label possono avere nomi riconoscibili, dovrete sempre usare estrema cautela per evitare collisioni nei nomi.

Potete cambiare le etichette del filesystem con i comandi seguenti:

~~~  
* swap: Create un nuovo spazio di swap in questo modo: mkswap -L <label> /dev/XXX  
* ext2/ext3/ext4: e2label /dev/XXX <label>  
* jfs: jfs_tune -L <label> /dev/XXX  
* xfs: xfs_admin -L <label> /dev/XXX  
* fat/vfat: Non v'è alcuno strumento in Linux per cambiarne le etichette, ma quando create il filesystem usate mkdosfs -n <label> <other options>. Potete anche cambiare l'etichetta di un filesystem esistente utilizzando Windows.  
* ntfs: ntfslabel /dev/XXX <label> o cambiarla usando Windows.  
~~~

`Fate attenzione: le etichette devono essere uniche perché funzionino e ciò vale sia per i dischi fissi che per i dispositivi USB/firewire. Per le partizioni UN*X, la sintassi LABEL= UUID= è da preferire a /dev/disk/by-*/`

#### 3. Denominazione persistente mediante id

'by-id' crea una denominazione unica a partire dal numero di serie del dispositivo hardware.

#### 4. Denominazione persistente mediante path

'by-path' crea una denominazione unica dipendente dal più corto percorso fisico (in accordo a sysfs). Entrambe però contengono stringhe indicanti a quale subsystem appartengono e pertanto non sono adatte alla soluzione dei problemi menzionati all'inizio di questo paragrafo. Non vi si farà qui più menzione.

#### Abilitare la denominazione persistente

Avendo scelto quale metodo di denominazione utilizzare, vediamo come abilitarlo nel sistema:

#### In fstab

L'abilitazione in /etc/fstab è facile; semplicemente sostituite il nome del dispositivo nella prima colonna con il nuovo nome persistente. In questo esempio si vuole sostituire /dev/sda7 con uno dei seguenti:

~~~  
/dev/disk/by-label/home  
oppure  
/dev/disk/by-uuid/31f8eb0d-612b-4805-835e-0e6d8b8c5591  
~~~

Fate così per tutte le partizioni del file fstab.

Invece di scrivere esplicitamente il nome del dispositivo, indicate il filesystem che dovrà essere montato con il suo UUID o con la sua etichetta di volume scrivendo LABEL=&lt;etichetta&gt; oppure UUID=&lt;denominazione-uuid&gt;, per esempio:

~~~  
LABEL=Boot  
~~~

oppure

~~~  
UUID=3e6be9de-8139-11d1-9106-a43f08d823a6  
~~~

Fonte:  [wiki.archlinux.org](http://wiki.archlinux.org/index.php/Persistent_block_device_naming)  che ha usato il contenuto di  [marc.theaimsgroup.com](http://marc.theaimsgroup.com/?l=linux-hotplug-devel&amp;m=114795097514527&amp;w=2)  da wiki.archlinux.org disponibile sotto la Licenza 1.2 della Libera Documentazione GNU ed è stata ri-modificata per i manuali di siduction

 [Ulteriori informazioni circa l'etichettatura si trovano su lissot.net](http://www.lissot.net/partition/ext2fs/labels.html)  

<div id="rev">Content last revised 19/04/2012 1211 UTC</div>
