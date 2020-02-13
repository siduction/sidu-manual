<div id="main-page"></div>
<div class="divider" id="part-lvm"></div>
## Partizionamento LVM - Logical Volume Manager

**`È qui proposta una guida di base per consentirvi di iniziare. Sta a voi imparare di più riguardo a LVM. Le risorse che possono esservi di aiuto sono elencate alla fine di questo testo, ma la lista è sicuramente non esaustiva.`** 

Applicabile da siduction-onestepbeyond.iso in poi.

I volumi logici possono utilizzare simultaneamente più dischi e sono scalabili, a differenza di quanto avviene con i metodi tradizionali di partizionamento dei dischi fissi.

Tuttavia, sia che per il partizionamento si utilizzi il metodo tradizionale o il LVM, non è cosa che dobbiate fare spesso: pertanto vi è richiesta grande concentrazione e un buon numero di tentativi prova/correggi prima di rimanere soddisfatti del risultato ottenuto.

Nel contesto vi sono 3 termini fondamentali da conoscere:

+ `Volumi fisici:`  sono i vostri dischi fisici, o le partizioni del disco, come ad esempio /dev/sda o /dev/sdb1. A ciò dovreste essere abituati con l'uso di mount/umount. Utilizzando LVM potrete raggruppare volumi fisici multipli in gruppi di volumi.  
+ `Gruppi di Volumi:`  comprendono veri volumi fisici e sono il contenitore utilizzato per creare volumi logici che possono essere creati/ridimensionati/cancellati e utilizzati. Potete considerare un gruppo di volumi come un "disco virtuale" composto da volumi fisici che potete suddividere in "partizioni virtuali", cioè in volumi logici.  
+ `Volumi logici:`  sono i volumi che finirete per montare nel vostro sistema. Possono essere aggiunti, cancellati e ridimensionati "al volo". Dal momento che sono contenuti nei gruppi di volumi potrebbero essere più grandi di ogni singolo volume fisico posseduto (ad es., 4 drive da 250GB possono essere combinati in un gruppo di volumi da 1TB ed eventualmente divisi per creare due volumi logici da 500GB).  

### Sono richiesti 6 passi base

`Nell'esempio seguente si suppone che i dischi non siano partizionati o che sia richiesto un nuovo schema di partizionamento, cosa questa che cancellerà tutti i dati esistenti nelle partizioni che si vogliono convertire in LVM.` 

È richiesto l'utilizzo di cfdisk o fdisk dal momento che ad oggi Gparted e KDE Partition Manager non supportano il partizionamento LVM.

`Passo 1:`  Create la tabella delle partizioni:

~~~  
cfdisk /dev/sda  
n per creare una nuova partizione nel disco  
p per farla diventare partizione primaria  
1 per dare come identificatore della partizione il numero 1  
`### size allocation  ### Impostate il primo e l'ultimo cilindro ai valori di default (premere Invio) per comprendere l'intero drive  
t seleziona il tipo di partizione da creare  
8e è il codice esadecimale per un LVM Linux  
w per scrivere i cambiamenti nel disco. ##Questo scriverà la tabella delle partizioni. Se a questo punto vi accorgete di aver fatto un errore potete ripristinare il vecchio schema di partizione e i dati saranno integri.##  
~~~

Se volete che il volume sia esteso a 2 o più dischi ripetete il procedimento per ognuno dei dischi.

`Passo 2:`  Impostate la partizione come volume fisico. Questo cancellerà tutti i dati:

~~~  
pvcreate /dev/sda1  
~~~

Ripetete il processo su tutte le altre partizioni secondo quanto desiderato.

`Step 3:`  Create il gruppo di volumi:

~~~  
vgcreate vulcan /dev/sda1  
~~~

Se, ad esempio, volete utilizzare 3 dischi, includeteli nel comando vgcreate:

~~~  
vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1  
~~~

Se avete eseguito correttamente la procedura, ne vedrete i risultati nell'output di:

~~~  
vgscan  
~~~

vgdisplay restituirà le `dimensioni`  come proprietà:

~~~  
vgdisplay vulcan  
~~~

`Passo 4:`  create il volume logico. È ora il momento di decidere la dimensione iniziale del volume logico. Uno dei vantaggi dell'utilizzo di LVM è quello di poter modificare la dimensione del volume attivo senza necessità di riavviare.

Supponiamo che inizialmente vogliate ottenere un volume di 300GB di nome spock all'interno del LVM chiamato vulcan:

~~~  
lvcreate -n spock --size 300g vulcan  
~~~

`Passo 5:`  formattate il volume, ma siate pazienti perché questa operazione potrebbe durare un bel po':

~~~  
mkfs.ext4 /dev/vulcan/spock  
~~~

`Passo 6:` 

~~~  
mkdir /media/spock/  
~~~

Modificate fstab con l'editor preferito per far sì che il volume sia montato all'avvio.

~~~  
mcedit /etc/fstab  
~~~

Con LVM, utilizzare `/dev/vulcan/spock`  è meglio che utilizzare i numeri UUID, perché in tal modo potrete clonare il filesystem senza dovervi preoccupare di potenziali collisioni di UUID, evento possibile specialmente con LVM, con il quale potreste trovarvi con più filesystem con lo stesso numero UUID (valga ad esempio l'utilizzo delle snapshot).

~~~  
/dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2  
~~~

~~~  
chown root:users /media/spock  
~~~

~~~  
chmod 775 /media/spock  
~~~

A questo punto il vostro LVM di base dovrebbe essere configurato.

### Ridimensionare il volume

`È fortemente raccomandato l'uso di una live-ISO per modificare le dimensioni della partizione. Mentre l'ingrandire la partizione "al volo" può non generare errori, lo stesso non può dirsi quando il volume è ridotto, poiché eventuali anomalie causeranno perdita di dati, soprattutto se sono coinvolti **`/ (root)`**  o **`/home`** .` 

##### Per ridimensionare il volume da 300GB a 500GB, procedete come proposto nell'esempio che segue:

~~~  
umount /media/spock/  
~~~

~~~  
lvextend -L+200g /dev/vulcan/spock  
~~~

Poi eseguite i comandi di ridimensionamento del filesystem:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### Per ridimensionare il volume da 300GB a 280GB:

~~~  
umount /media/spock/  
~~~

Poi eseguite i comandi di ridimensionamento del filesystem:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock 280g  
~~~

Poi ridimensionate il volume

~~~  
lvreduce -L-20g /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### Una interfaccia grafica per LVM

`system-config-lvm`  fornisce una interfaccia grafica ed è disponibile per aiutarvi nella gestione di LVM. Viene avviato dalla linea di comando come root:

~~~  
apt-get install system-config-lvm  
man system-config-lvm `# richiede la lettura   
~~~

##### Fonti e Risorse:

+  [Debian Administration - A simple introduction to working with LVM](http://www.debian-administration.org/articles/410)   
+  [IBM - Logical volume management](http://www.ibm.com/developerworks/linux/library/l-lvm2/)   
+  [IBM - Resizing Linux partitions, Part 2: Advanced resizing](http://www.ibm.com/developerworks/linux/library/l-resizing-partitions-2/index.html)   
+   [Red Hat - LVM Administrator's Guide](http://docs.google.com/viewer?a=v&amp;q=cache:1RMpacheCBcJ:www.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/5.4/pdf/Logical_Volume_Manager_Administration.pdf+%22Logical+Volume+Manager+Administration+%22&amp;hl=en&amp;pid=bl&amp;srcid=ADGEEShRiptIjzsnPNsCs4RgyUFNWkYcrDc3SkBSD6cTq39D6wye5JM3tP_ehcn37I5VWs84I_HI45rvG-n6YG4R2fE8hqDByq-KPhNEkha4zwphrR7QIUVnUz6omwY85e-ZEXX723Js&amp;sig=AHIEtbSJyxEst6Wue7_1_TeDYwB480azEw)   
+   [Logical Volume Manager (Linux)](http://en.wikipedia.org/wiki/Logical_Volume_Manager_%28Linux%29)   
+   [Setting up an LVM for Storage](http://thelinuxexperiment.com/guinea-pigs/jon-f/setting-up-an-lvm-for-storage/)   
+   [Creating a LVM in Linux](http://linuxhelp.blogspot.com/2005/04/creating-lvm-in-linux.html)   
+   [Linux lvm - Logical Volume Manager](http://www.linuxconfig.org/Linux_lvm_-_Logical_Volume_Manager)   

<div id="rev">Page last revised 17/04/2012 2004 UTC</div>
