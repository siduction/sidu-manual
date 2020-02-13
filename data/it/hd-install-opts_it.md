<div id="main-page"></div>
<div class="divider" id="fromiso"></div>
## Avviare con "fromiso" - panoramica

**`Per un normale uso desktop è raccomandato il filesystem ext4, che è il predefinito per siduction.`**

Con questa opzione d'avvio è possibile avviare il sistema da un'immagine iso su una partizione (ext2, 3 o 4), il che risulta molto più veloce rispetto all'avvio da CD (l'installazione su disco fisso con "fromiso" richiede anche minor tempo).

"fromiso" per di più lascia libero il lettore CD/DVD. Come alternativa è possibile anche usare virtualbox, kvm o QEMU.

##### Requisiti:

* grub funzionante (su floppy, su disco fisso, o su liveCD)  
* immagine iso di siduction, per semplicità d'uso ridenominata ad esempio siduction.iso, su filesystem Linux ext2, 3 o 4.

<div class="divider" id="grub2-fromiso"></div>
## fromiso con Grub2

siduction fornisce un file denominato 60_fll-fromiso, integrato in grub2, che genera nel relativo menu una voce per fromiso. L'unico file necessario per configurare fromiso è `grub2-fll-fromiso` , che si trova in `/etc/default/grub2-fll-fromiso` .

 Innanzitutto, aprite un terminale, acquisite i privilegi di root e installatelo:

~~~  
sux  
apt-get update  
apt-get install grub2-fll-fromiso  
~~~

Poi, aprite un editor (kwrite, mcedit, vim o qualunque altro di vostro gradimento):

~~~  
mcedit /etc/default/grub2-fll-fromiso  
~~~

Quindi, decommentate (eliminando il **`#`** ) le linee che dovranno essere operative e sostituite le istruzioni di default con le proprie preferenze`tra doppie virgolette ("")` .

A titolo d'esempio, confrontate il grub2-fll-fromiso modificato, qui riportato, con quello di default (le `linee evidenziate`  sono le linee cambiate a scopo istruttivo):

~~~  
# Valori di default del programma update-grub di grub2-fll-fromiso  
# indicati dall'update-grub di grub2  
# installati in /etc/default/grub2-fll-fromiso dagli scripts del manutentore  
#  
# Questo è un frammento della shell POSIX  
#  
# specificate dove trovare la ISO  
# default: /srv/ISO `### Nota: Questo è il percorso per trovare la directory che contiene la ISO, e non per includere il vero file siduction-*.iso.###`   
FLL_GRUB2_ISO_LOCATION="/media/disk1part4/siduction-iso"`   
# array per definire i prefissi ISO --> siduction-*.iso  
# default: "siduction- fullstory-"  
FLL_GRUB2_ISO_PREFIX="siduction-"`   
# impostate la lingua principale  
# default: en_US  
FLL_GRUB2_LANG="it_IT"`   
# correggete il fuso orario di default.  
# default: UTC  
FLL_GRUB2_TZ="Europe/Rome"`   
# per la risoluzione del framebuffer del kernel, si veda  
# http://manual.siduction.com/de/cheatcodes-vga-de.htm#vga  
# default: 791  
#FLL_GRUB2_VGA="791"  
# codici d'avvio addizionali  
# default: noeject  
FLL_GRUB2_CHEATCODE="noeject nointro"`   
~~~

Salvate e chiudete l'editor, quindi lanciate in un terminale

~~~  
update-grub  
~~~

Il vostro file grub.cfg di grub2 verrà aggiornato e potrete vedere le varie ISO messe nella directory specificata disponibili al prossimo avvio.

<div class="divider" id="fromiso-persist"></div>
## Informazioni generali su persist

<!--</div>
<div class="divider" id="persist-firm-1">--></div>
### Firmware

`Quanto segue si applica a tutti le esigenze di persist, eccetto quelle delle installazioni su dispositivo RAW.`  Per i dispositivi RAW si veda  [Scrivere siduction su una chiavetta/scheda USB/SSD con sistema operativo Linux, MS Windows o Mac OS X](hd-ins-opts-oos-en.htm#raw-usb) 

Per quanto concerne il firmware, introdurrete semplicemente i dati che volete aggiungere ai sistemi live, `/lib/firmware` , in una directory denominata `/siduction/firmware`  nel vostro dispositivo. Potrete abilitarlo al momento del boot selezionando `Yes`  dal `Driver menu`  grafico o manualmente aggiungendo `firmware`  alla linea di comando del kernel. `firmware=/lib/firmware`  caricherebbe il firmware dalla prima installazione che trova sul PC. Se volete abilitarlo di default potete editare i vostri file di configurazione, ad esempio `/boot/isolinux/syslinux.cfg` .

Tanto persist quanto fromiso possono utilizzare file situati in differenti locazioni sul disco. Per esempio, se il file per la persistenza è nella /root della chiavetta/scheda ed è denominato `persist.img` , potete usare semplicemente `persist=/persist.img` , e analogamente per il firmware della directory denominata fw potete usare `firmware=/fw` .

### fromiso e persist su un disco rigido

Potete avere un sistema live persistente su un disco scrivibile associando un setup "fromiso" con l'opzione d'avvio "persist". Per usare persist con un filesystem ext2, 3 o 4, il default è semplicemente:

~~~  
persist  
~~~

Per usare persist con un filesystem vfat, dovrete usare un file contenente un filesystem linux e l'opzione d'avvio sarà:

~~~  
persist=/siduction/base-rw  
~~~

siduction utilizza aufs per abilitare il cosiddetto "copy on write" sulla vostra ISO per permettervi di scrivere nuovi file e directory e aggiornare quelli esistenti mantenendo i nuovi file in memoria. L'opzione `persist`  farà sì che i nuovi file siano salvati nella stessa partizione utilizzata per l'immagine ISO.

`fromiso`  vi permette di ottenere un sistema live con le stesse caratteristiche automatiche del liveISO di siduction. Ciò offre il vantaggio di poter fare cose come, ad esempio, il configurare automaticamente l'hardware, ma significa anche che saranno ricreati gli stessi file ogni volta che avviate il sistema, a meno che non usiate codici addizionali.

Utilizzare `persist`  insieme ad altre opzioni specifiche di siduction come noxorgconf, nonetwork, farà, ad esempio, sì che non siano ricreati gli stessi file ogni volta che avviate.

Con l'eccezione dell'aggiornamento del kernel nel contesto di fromiso, utilizzare persist farà anche sì che si possano installare pacchetti da apt e avere l'applicazione e ogni dato salvato disponibili e accessibili al successivo riavvio. Alcuni pacchetti, comunque, richiedono che l'elenco delle sorgenti includa contrib e non-free: si veda in proposito  [Aggiungere non-free all'elenco delle sorgenti](nf-firm-en.htm#non-free-firmware) .

<div class="divider" id="persist-post"></div>
## fromiso e persist su chiavetta USB e scheda flash SD

Probabilmente l'utilizzo ideale della persistenza è in combinazione con lo strumento install-usb-gui per creare il proprio flash drive avviabile con i file e il software di cui avete bisogno. I file verranno memorizzati in una sottodirectory nel drive stesso.

`persist`  in un filesystem FAT, comunemente utilizzato per le installazioni DOS e solitamente di default nelle periferiche flash, vi impone di creare un singolo grande file da utilizzare come una periferica loop, file che naturalmente dovrete formattare.

`Nelle chiavette USB e nelle schede flash SD, ext2 e vfat sono i filesystem raccomandati e sono quelli che danno, nel momento del bisogno, una migliore capacità di recupero dei dati fra piattaforme differenti data la disponibilità di un driver MS Windows(tm); per lo scambio dei dati. La velocità di riscrittura sui flash drive è condizionata dalle specifiche della chiavetta USB e delle schede SD.` 

###### filesystem ext2

Con ext2 verrà utilizzata l'intera partizione e nella root corrente verrà creata una directory /fll che sarà utilizzata da persist permettendogli l'utilizzo di tutto lo spazio libero nel dispositivo.

###### filesystem vfat

Quando è utilizzato vfat, la persistenza è realizzata mediante un file di dimensioni massime di 2Gbyte e minime non inferiori a 100MByte (di meno non ne renderebbe possibile l'uso). Il file dovrebbe essere denominato `siduction-rw` .

#### Esempio della creazione di persist dopo l'installazione iniziale

Se non siete sicuri del punto di mount, montate la chiavetta ed eseguite `ls -lh /media`  per ottenere una lista di tutti i punti di mount del sistema. Cercatevi qualcosa come `drwxr-xr-x 6 username root 4.0K Jan 1 1970 disk` . Se il vostro output è diverso, sostituite `"/media/disk"`  in linea con le vostre esigenze (per esempio, con "/media/disk-1").

~~~  
disk="/media/disk"  
-->  
~~~

Continuando l'esempio, il comando `df -h`  chiarirà le informazioni:

~~~  
/dev/sdc2 3.4G 4.0K 3.4G 1% /media/disk  
/dev/sdc1 4.1G 1.1G 2.8G 28% /media/disk-1  
~~~

Pertanto:

~~~  
disk="/media/disk-1"  
~~~

Impostate la dimensione della partizione persist:

~~~  
size=1024  
~~~

Create una directory nella chiavetta:

~~~  
mkdir $disk-1/siduction  
~~~

Avviate il codice per creare una partizione persist:

~~~  
dd if=/dev/zero of=$disk-1/siduction/base-rw bs=1M count=$size && echo 'y' | LANG=C /sbin/mkfs.ext2 $disk-1/siduction/base-rw && tune2fs -c 0 "$disk-1/siduction/base-rw"  
~~~

**`Partizioni NTFS, utilizzate di solito da installazioni dei sistemi operativi MS Windows™, NON POSSONO essere utilizzate per la persistenza.`**

<div class="divider" id="usb-hd"></div>
## Installare siduction su periferiche USB e flash SD

Installare siduction su una chiavetta USB o una scheda flash SD è semplice come una normale installazione su disco rigido. Seguite questa semplice guida.

##### Requisiti:

Qualsiasi PC con USB 2.0/3.0 e la possibilità di avviarsi da USB/flash-SD.

Una immagine siduction.iso

##### 3 modi di installare su USB/flash-SD

+ 1)  [fromiso](hd-install-opts-it.htm#usb-from1) ; specifico di siduction: siduction-on-a-stick.  
+ 2)  [completo](hd-install-opts-it.htm#usb-hdd)  (l'installazione completa su USB/flash-SD si comporta come una normale installazione su disco fisso e viene realizzata con l'usuale programma di installazione).  
+ 3) scrittura su  [dispositivo RAW](hd-ins-opts-oos-it.htm#raw-usb) . È l'ideale quando si utilizza un qualsiasi sistema operativo Linux, MS Windows o Mac OS X e si vuole installare siduction-on-a-stick (con precauzioni!).  

<div class="divider" id="usb-from1"></div>
### Installazione di fromiso su USB/flash-SD, siduction-on-a-stick

 `Prima di procedere, formattate la periferica USB (di almeno 2 GByte) con ext2 o fat32. La periferica dovrebbe avere solo 1 partizione e dal momento che alcuni BIOS sono temperamentali questa deve essere marcata come avviabile.` 

Se per formattare utilizzate un'applicazione a interfaccia grafica, come gparted, assicuratevi di cancellare la partizione esistente e quindi ricreatela prima di formattare.

##### fromiso su USB da un sistema siduction installato su disco fisso:

L'installazione `fromiso su USB`  è realizzata mediante `Menu>System>install-siduction-to-usb` . 

##### fromiso su USB da una siduction-*.iso:

In una LiveISO cliccate sull'icona `siduction Installer`  e scegliete `Installa su USB` .

###### Opzioni:

Vi viene offerta la possibilità di scegliere la lingua, il fuso orario e altre opzioni d'avvio e se attivare o meno persist, mediante una casella selezionabile.

Adesso avete un dispositivo USB/flash-SD avviabile. Se non avete attivato persist potete farlo ora aggiungendo `persist`  nella linea di grub della schermata di avvio (se il filesystem è vfat, però, probabilmente è meglio ricominciare da capo).

###### Esempio da terminale:

~~~  
fll-iso2usb -D /dev/sdb -f none --iso /home/siduction/base.iso -p -- lang=it tz=Europe/Rome  
~~~

Questo comando installa l'immagine ISO nella periferica USB `sdb`  con persist, la localizzazione per la lingua italiana e il fuso orario di Roma nella linea di default di grub.

La configurazione di X (scheda video, tastiera, mouse) e il file con le interfacce di rete non sono stati salvati, e ciò lo rende ideale per l'utilizzo in altri computer.

Per una maggiore documentazione, incluse le opzioni di personalizzazione, si veda:

~~~  
$ man fll-iso2usb  
~~~

### Installazione completa su USB/flash-SD (si comporta come una normale installazione su disco fisso)

Dimensione minima raccomandata per la chiavetta o la scheda:  
siduction richiede 2-4 GByte (2 per LXDE, 4 per KDE) PIÙ lo spazio per i dati.

 `Preformattate la periferica con`  **`ext2`**  `e partizionate la chiavetta o la scheda come fareste su un PC standard.` 

Avviate l'installazione dal LiveISO, scegliete la partizione sulla periferica USB/flash-SD dove deve essere installato siduction, per esempio `sdbX`  e seguite le istruzioni del programma di installazione. Leggete  [Installazione su disco fisso](hd-install-it.htm#Installation) 

`Per avviare dall'USB/flash-SD, deve essere abilitato nel BIOS "Boot from USB".` 

`Ecco alcuni punti degni di considerazione:` 

+ Un'installazione USB/flash-SD sarà usualmente condizionata dal PC che ha iniziato l'installazione originale. Se è vostra intenzione utilizzare la chiavetta USB o la scheda SD in un altro PC, non devono essere presenti driver grafici non-free e codici d'avvio preconfigurati, con l'eccezione del codice vesa probabilmente già presente in grub.cfg (il tutto da verificare dopo una installazione riuscita).  
+ Dopo aver avviato da USB/flash-SD in un altro PC, è necessario modificare fstab per accedere ai dischi fissi.  
+ "fromiso" con "persist" è l'opzione migliore nel caso si voglia privilegiare la portabilità.  

<div class="divider" id="usb-hdd"></div>
### Installazione completa su di un hard disk USB come un'installazione su una partizione

Un hard disk USB ha un'applicazione abbastanza buona e invitante (particolarmente per i nuovi utenti provenienti da MS Windows o da un'altra distribuxione), che rende possibile installare siduction in un hard disk USB, collegarlo senza la necessità di configurare il PC per il doppio avvio (ripartizionare, cambiare grub, etc.).

Avviate l'installazione dal LiveISO (o da USB/flash-SD) `come installazione standard e non installazione USB` ; scegliete la partizione nella periferica ove siduction deve essere installato, per esempio `sdbX`  e seguite le istruzioni del programma di installazione di siduction. Grub deve essere scritto nella partizione dell'hard disk USB.

Leggete  [Installare sul disco fisso](hd-install-it.htm#Installation) 

`Altri punti degni di considerazione sono:` 

+ Un'installazione su hard disk USB sarà usualmente condizionata dal PC che ha iniziato l'installazione originale. Se è vostra intenzione utilizzare l'hard disk USB in un altro PC, non devono essere presenti driver grafici non-free e codici d'avvio preconfigurati, con l'eccezione del codice vesa probabilmente già presente in grub.cfg (il tutto da verificare dopo una installazione riuscita).  
+ Se volete usare l'installazione in un'altra macchina siate consapevoli di dover fare alcuni aggiustamenti. In particolare, dovrete modificare fstab per accedere ai dischi fissi del PC, forse xorg.conf e probabilmente anche la configurazione di rete.  

<div class="divider" id="usb-gpt-1"></div>
## Installazione completa su dispositivi GPT rimovibili avviabili (si comporta come una normale installazione su disco fisso)

 Fate riferimento a  [Partizionare con gdisk per dischi GPT](part-gdisk-en.htm#gdisk-1)  e seguite le istruzioni per  [Opzioni di installazione - HD, USB, VM e Cryptroot](hd-install-en.htm) .

<div class="divider" id="usb-efi-1"></div>
## Dispositivi rimovibili avviabili (U)EFI

<span class='highlight-1'>Applicabile a partire da siduction-11.1/OneStepBeyond.</span>

Se volete avviare usando EFI senza masterizzare alcun supporto ottico, avete bisogno di una partizione vfat contenente un bootloader EFI portabile `/efi/boot/bootx64.efi` . Gli iso amd64 di siduction contengono questo file e hanno una configurazione di grub che può caricare. Per preparare una chiavetta ad avviarsi in questo modo, copiate il contenuto della iso di siduction nella root di una chiavetta formattata con `vfat` . Dovreste anche marcare la partizione come avviabile usando un programma di partizionamento.

Naturalmente la semplice copia dei file nella chiavetta USB vfat non vi consentirà di avviarla con un sistema BIOS tradizionale, ma è abbastanza semplice abilitare quest'ultimo utilizzando syslinux e install-mbr. Tutto quello che avete da fare è digitare (con la chiavetta NON montata): 

~~~  
syslinux -i -d /boot/isolinux /dev/sdXN  
install-mbr /dev/sdX  
~~~

Una chiavetta preparata in questo modo si avvierà sia con EFI nel semplice menu di grub2, sia con BIOS tradizionale nel menu grafico gfxboot.

Uno dei vantaggi dell'avere una chiavetta preparata in questo modo, in confronto a una chiavetta grezza creata utilizzando isohybrid, è la possibilità di editare i file di avvio per aggiungervi automaticamente le opzioni preferite. 

Con i sistemi BIOS tradizionali potete editare il file `/boot/isolinux/syslinux.cfg`  e/o il file `/boot/isolinux/gfxboot.cfg` . Con i sistemi EFI potete editare il file `/boot/grub/x86_64-efi/grub.cfg` .

#### Persistenza e firmware

Si veda  [Informazioni generali su persist](hd-install-opts-it.htm#fromiso-persist) 

<div id="rev">Page last revised 28/01/2012 2010 UTC</div>
