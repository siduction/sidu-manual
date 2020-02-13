<div id="main-page"></div>
<div class="divider" id="partition"></div>
## Partizionare il disco fisso utilizzando KDE Partition Manager o Gparted

##### **`ATTENZIONE: per i nomi dei dischi`**  [fate riferimento a "UUID, etichettare partizioni e fstab" dato che siduction utilizza UUID in maniera predefinita](part-uuid-it.htm) 

##### Gli strumenti di partizionamento potrebbero richiedere una password di root: scrivere `sux`  e quindi fornire la password. Nel Live-ISO, però, non è configurata alcuna password: quindi, scrivere `sux`  e premere "Invio". Vedere:  [Live Mode](live-mode-it.htm) 


---


::: warning  
**Achtung**  
Il ridimensionamento di una partizione NTFS richiede il riavvio del sistema! NON FATE nessuna operazione su questa partizione prima del riavvio oppure andrete incontro a errori. [Leggete qui.](part-gparted-it.htm#ntfs)   
:::

**`Fate sempre il backup dei dati!`**

### Fondamenti

Una partizione deve avere un filesystem. Linux riconosce numerosi filesystem. Ext4 è il formato raccomandato per siduction. Ext2 è comodo come formato di archiviazione dato che è disponibile un driver MS Windows&#8482; per lo scambio dei dati.  [File sytem Ext2 installabile per MS Windows](http://www.fs-driver.org/) .

**`Per un uso normale consigliamo il filesystem ext4, che è poi quello predefinito di siduction.`**

## Utilizzare KDE Partition Manager &amp; Gparted

Creare e gestire partizioni non è cosa che si fa tutti i giorni. Perciò è una buona idea leggere questa guida una volta per tutte per familiarizzare con i concetti e con alcune delle schermate che vi verranno mostrate.

### KDE Partition Manager - avvio in un terminale:

~~~  
sux  
partitionmanager  
~~~

### Gparted - avvio in un terminale:

~~~  
sux  
gparted  
~~~

+ Quando vengono avviati KDE Partition Manager o GParted, si apre una finestra e vengono controllati i drive.
  
   In KDE Partition Manager i drive vengono mostrati in una lista sulla sinistra.
  
   ![KDE Partition Manager partition information](../images-common/images-kpart/kpart-02.png "KDE Partition Manager partition information") 
  
   In Gparted, se si clicca il menu (in alto a sinistra), compare un menu a tendina. Si può selezionare per aggiornare la visualizzazione dei drive del sistema.
  
   ![gparted](../images-it/gparted-it/gparted02-it.png "Gparted Devices View") 
  

###### **`Le schermate che seguono sono di Gparted, ma KDE Partition Manager si comporta più o meno allo stesso modo.`** 

+ ### Modifica
  
   Il menu Modifica ha tre funzioni in grigio che potrebbero risultare cruciali:  
`Annulla l'ultima operazione`   
`Applica tutte le operazioni`   
`Cancella tutte le operazioni` 
  
+ ### Visualizza
  
   <ul>  
   <li>  
   #### Informazioni sul dispositivo
  
   Il pannello `Informazioni sul dispositivo`  visualizza i dettagli relativi al disco fisso come Modello, Dimensione, etc. Questo pannello è più utile in un sistema con più dischi fissi nel quale l'informazione viene utilizzata per confermare che il disco che si sta esaminando è quello giusto.
  
   ![operation view](../images-it/gparted-it/gparted03-it.png "Gparted Harddisk Information") 
  
+ #### Operazioni in sospeso
  
   Nella finestra in basso viene visualizzata una lista di operazioni in sospeso. L'informazione è utile dal momento che fornisce un'indicazione di eventuali operazioni non completate.
  

</li>
<li>
### Dispositivo

Dispositivo permette di assegnare un'etichetta al disco. Se quella corrente è inappropriata cambiatela utilizzando questa opzione.

</li>
<li>
### Partizione

Questo menu è di estrema importanza. Permette di fare operazioni multiple, alcune delle quali sono pericolose.

`Elimina`  viene selezionato se si vuole cancellare una partizione. Per eseguire la cancellazione si deve prima selezionare la partizione.

`Ridimensiona/Sposta`  permette di ridimensionare le partizioni.

</li>
<li>
### Creare una nuova partizione

Nella barra grafica, il pulsante `Nuovo`  consente di creare una nuova partizione se è già stata selezionata una zona non allocata. Comparirà una nuova finestra che vi permetterà di scegliere la dimensione voluta, se la partizione dovrà essere Primaria, Estesa o Logica, e infine il tipo di filesystem.

![file system](../images-it/gparted-it/gparted07-it.png "Gparted New Partition") 

</li>
<li>
### Se si commette un errore

Nel caso abbiate commesso un errore potete utilizzare il pulsante Cancella per eliminare la partizione prescelta oppure, se non avete ancora deciso come proseguire, potete utilizzare il pulsante Annulla.

![delete](../images-it/gparted-it/gparted04-it.png "Gparted Delete") 

</li>
<li>
### Ridimensiona/Sposta

Se volete ridimensionare una partizione selezionata, premete il pulsante `Ridimensiona/Sposta` : apparirà una nuova finestra. Utilizzate il mouse per ridurre (o ingrandire) la partizione o, se preferite, utilizzate le frecce.

![resize / move](../images-it/gparted-it/gparted05-it.png "Gparted Resize") 

Una volta ultimato il comando Ridimensiona, premete Applica dal momento che nessuna operazione sul disco fisso viene fatta fino a quando non si preme quest'ultimo comando.

src="../images-it/gparted-it/gparted09-it.png" alt="operation view" 

La durata delle operazioni dipende dalla nuova dimensione della partizione.

**`Dopo aver modificato la tabella delle partizioni terminate la sessione e riavviate il sistema per consentire a siduction di leggere la nuova tabella delle partizioni.`** 

</li>
</ul>
<div class="divider" id="ntfs"></div>
## Ridimensionare le partizioni NTFS


::: warning  
**Achtung**  
Il ridimensionamento di una partizione NTFS richiede il riavvio del sistema! NON FATE nessuna operazione su questa partizione prima del riavvio oppure andrete incontro a errori.  
:::

+ Dopo il riavvio in MS Windows, il sistema mostrerà una schermata speciale e un messaggio relativo alla consistenza del disco: "Checking file system on C".  
+ Lasciate completare l'AUTOCHK in quanto NT ha bisogno di controllare il proprio filesystem dopo l'operazione di ridimensionamento.  
+ Alla fine del processo il computer si ravvierà automaticamente per la seconda volta. Ciò assicura che le cose funzionino perfettamente.  
+ Dopo il riavvio Windows sarà a posto, ma attendete che il sistema finisca di avviarsi, cioè fino alla comparsa della finestra di autenticazione degli utenti!  

 **La documentazione completa di GParted** , anche riguardo alla copia delle partizioni, si trova sul sito di  [GParted](http://gparted.sourceforge.net) 

<div class="divider" id="hd-ntfs3g"></div>
## Scrivere su partizioni NTFS con ntfs-3g

**` **Avvertimento importante** : sebbene ntfs-3g sia definito "stabile" non usatelo mai senza backup esterni e naturalmente non usatelo su sistemi di produzione! Se lo fate, l'eventuale perdita di dati dovuti al suo utilizzo sarà solo colpa vostra, quindi fate molta attenzione!`**

Aprite una console e immettete i seguenti comandi (Leggete in proposito  [Partizionare il disco fisso - Denominazione dei dischi](part-cfdisk-it.htm)):

~~~  
sux  
apt-get update && apt-get install ntfs-3g  
umount /media/xdxx  
mount -t ntfs-3g /dev/disk/by-uuid/xxyyzz[etc] /media/xdxx  
Per uscire dalla console digitate: exit  
~~~

Ora il volume NTFS dovrebbe essere montato come  **rw**  e dovreste essere in grado di memorizzarvi dati. Ma, di nuovo, state attenti! `Usate ntfs-3g soltanto in situazioni di emergenza e ricordate che non è raccomandato per un uso su base giornaliera.` 

<div id="rev">Content last revised 17/04/2012 0100 UTC</div>
