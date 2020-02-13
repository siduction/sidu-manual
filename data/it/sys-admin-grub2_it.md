<div id="main-page"></div>
<div class="divider" id="grub2"></div>
## GRUB 2

#### Differenze principali fra GRUB 1 (oggi detto "grub-legacy") e GRUB 2:

+ `Non esiste più il file menu.lst`   
+ Al controllo della schermata di Grub è adesso preposto il file `grub.cfg` .  
+ grub.cfg viene generato automaticamente dagli script presenti in `/etc/grub.d` .  
+ La numerazione delle partizioni è differente in quanto inizia da 1 invece che da 0 (i drive vengono ancora numerati a partire da 0):  
   ~~~    
   Linux grub1 grub2    
   /dev/sda1 (hd0,0) (hd0,1)    
   /dev/sda2 (hd0,1) (hd0,2)    
   /dev/sda3 (hd0,2) (hd0,3)    
   /dev/sdb1 (hd1,0) (hd1,1)    
   /dev/sdb2 (hd1,1) (hd1,2)    
   /dev/sdb3 (hd1,2) (hd1,3)    
   ~~~
  
+ Le sezioni in grub.cfg sono strutturate in modo leggermente differente rispetto a quanto avviene in menu.lst e non possono essere copiate direttamente dal file di Grub 1 menu.lst al file di Grub 2 grub.cfg in quanto quest'ultimo è un file "generato". **`Il file grub.cfg non dovrebbe essere mai modificato manualmente.`**   

<div class="divider" id="grub2-files"></div>
#### Il file di configurazione predefinito di Grub 2

Il file `/etc/default/grub`  contiene le impostazioni variabili di grub2. Per esempio, timeout del menu, voci predefinite del menu da attivare, parametri del kernel, grafica di grub e via dicendo.

#### I file script di Grub 2

I file in `/etc/grub.d`  controllano il file "generato" `grub.cfg` , che si trova in `/boot/grub/` .

**`Il file grub.cfg, come sopra detto, non dovrebbe essere mai modificato manualmente.`**  Tutte le modifiche devono essere fatte con uno o tutti i seguenti script che si trovano in `/etc/grub.d` . os-prober dovrebbe poter gestire il 90% dei casi:

~~~  
00_header:  
05_debian_theme: configura sfondo, colori del testo, temi  
10_hurd: trova i kernel Hurd  
10_linux: trova i kernel Linux basandosi sul risultato del comando lsb_release.  
20_memtest86+: se esiste il file /boot/memtest86+.bin, viene incluso nel menu di avvio.  
30_os-prober: cerca Linux e altri sistemi operativi nelle diverse partizioni e li include nel menu di avvio.  
40_custom: uno schema-guida per aggiungere voci nel menu di avvio personalizzate per altri sistemi operativi.  
60_fll-fromiso: uno schema-guida per aggiungere voci nel menu di avvio personalizzate per chiavette USB/schede SSD.  
<span class="highlight-2">60_fll-fromiso non deve essere modificato: usate allo scopo /etc/default/grub2-fll-fromiso.  
Leggere:  [Avviare "fromiso" con Grub 2](hd-install-opts-it.htm#grub2-fromiso) .</span>  
~~~

Ogni volta che è apportata una modifica, grub.cfg deve essere informato sui cambiamenti avvenuti. Nel caso di aggiornamenti del kernel di siduction il comando update viene avviato automaticamente. Nel caso che la modifica di uno qualunque dei file sopra indicati sia stata apportata manualmente da voi in qualità di amministratore del sistema, dovrete avviare:

~~~  
update-grub  
~~~

`Il pacchetto Debian di Grub 2 è concepito in modo tale che una modifica da parte vostra si renderà necessaria solo raramente.` 

<div class="divider" id="grub1-grub2"></div>
## Aggiornare da Grub Legacy a Grub 2

**`Raccomandiamo di aggiornare a Grub 2 in maniera pulita e di rimuovere completamente Grub 1`** . Dovreste essere ben consci del fatto che potreste danneggiare ogni cosa: siate quindi molto attenti.

###### Passo 1: 

Assicuratevi che il sistema sia pienamente aggiornato eseguendo `dist-upgrade in init 3.` 

~~~  
apt-get update  
Ctrl+alt+F1  
init 3  
apt-get dist-upgrade  
init 5 && exit  
~~~

###### Passo 2:

Rimuovete completamente Grub 1:

~~~  
rm -rf /boot/grub  
apt-get purge grub-gfxboot  
~~~

Il risultato sarà che `fll-iso2usb* grub-gfxboot* install-usb-gui*`  verranno rimossi. Premete `Y`  per confermare.

###### Passo 3:

~~~  
apt-get install grub2 os-prober  
~~~

![Grub2](../images-common/images-grub2/grub2-2.png "Grub2") 

Utilizzate il tasto tab per selezionare OK

![Grub2](../images-common/images-grub2/grub2-3.png "Grub2") 

Utilizzate il tasto tab per selezionare OK

![Grub2-conversion 1](../images-common/images-grub2/grub2-convert-1.png "Grub2-conversion 1") 

Utilizzate le frecce e la barra spaziatrice della tastiera per mettere un `* (asterisco)`  per selezionare il disco fisso sul quale Grub2 dovrà scrivere l'MBR.  *(Nell'esempio sopra riportato si installa su di un disco esterno USB)* .

###### Passo 4:

~~~  
update-grub  
~~~

###### Passo 5:

~~~  
apt-get install install-usb-gui fll-iso2usb  
~~~

###### Passo 6:

Riavviate il PC e menu.cfg vi mostrerà il kernel e la lista dei sistemi operativi:

![Grub2-OS list](../images-common/images-grub2/grub2-os-list.jpg "Grub2-OS list") 

Se dovesse esservi un errore o qualcosa andasse storto fate riferimento a  [Grub2 sovrascritto o corrotto nell'MBR](sys-admin-grub2-it.htm#chroot)  

### Modificare le opzioni d'avvio di Grub2 mediante la schermata di modifica

![Grub2-Edit](../images-common/images-grub2/grub2-e-1.JPG "Grub2-Edit") 

Se, per qualche ragione, doveste apportare una modifica temporanea alle opzioni d'avvio di un kernel evidenziato in Grub2, premete la lettera **`e`**  e con i tasti freccia portatevi sulla linea che volete modificare; quindi, sempre dalla schermata di modifica, usate `Ctrl+x`  per riavviare il computer con le opzioni modificate.

Per esempio, per avviare direttamente il sistema in level 3, aggiungete `3`  alla fine della linea `linux /boot/vmlinuz` .

Le modifiche apportate mediante la schermata di modifica non sono definitive. Per renderle permanenti dovrete modificare i file appropriati. Vedere in proposito  [I file di Grub 2](sys-admin-grub2-it.htm#grub2-files) .

<div class="divider" id="multi-os"></div>
## Avvio doppio o multiplo con Grub 2

Poiché Grub2 ha una configurazione modulare, consente con un comando semplice di cercare nuovi sistemi operativi e se ne vengono trovati prova ad applicare il cambiamento necessario per aggiornare menu.cfg. Il comando semplice è:

~~~  
update-grub  
~~~

Se doveste aver bisogno di aggiungere una voce di menu personalizzata in menu.cfg oppure se 30_os-prober non riesce a scrivere su grub.cfg con i menu chainloader, usate il vostro editor di testo preferito per apportare gli aggiustamenti a `/etc/grub.d/40_custom` .

Esempi di personalizzazione del file 40_custom:

~~~  
menuentry "second mbr"{  
set root=(hd1)  
chainloader +1  
}  
~~~

~~~  
menuentry "second partition"{  
set root=(hd0,2)  
chainloader +1  
}  
~~~

Apportati gli aggiustamenti, lanciate:

~~~  
update-grub  
~~~

Se si dovesse lamentare che non conosce la periferica grub di un disco, significa che si deve rigenerare devicemap.

`Assicuratevi di scegliere la partizione e non l'MBR quando installate un altro sistema operativo:` 

~~~  
grub-mkdevicemap --no-floppy  
update-grub  
~~~

Gli avvertimenti possono essere semplicemente ignorati.

Se doveste fare un errore, l'aggiornamento probabilmente sovrascriverà l'MBR e si dovrà correggerlo con  [Grub2 - MBR sovrascritto](sys-admin-grub2-it.htm#mbr-over-grub2) .

<div class="divider" id="mbr-over-grub2"></div>
## Per riscrivere soltanto grub2 nell'MBR dal disco rigido:

~~~  
/usr/sbin/grub-install --recheck --no-floppy /dev/sda  
~~~

Potrebbe essere necessario lanciare più volte questa riga, finché si convince che volete davvero far quello.

## Settore d'avvio MBR sovrascritto da Windows, Grub 2 corrotto o da ripristinare

**`NOTA: per ripristinare il gestore d'avvio Grub 2 dovete avere a disposizione una iso siduction.iso.`**   [In alternativa potete utilizzare chroot con qualsiasi live.iso](sys-admin-grub2-it.htm#chroot) .

Per riscrivere Grub 2 nell'MBR e/o per ripristinare Grub 2 in generale, dovrete avviare `siduction.iso` :

1. Per identificare e confermare le partizioni (ad esempio, [h,s]d[a..]X) sono richiesti privilegi di amministratore, quindi diventate root (#):  
   ~~~    
   $ sux    
   ~~~
  
2. Poi scrivete:  
   ~~~    
   fdisk -l    
   cat /etc/fstab    
   ~~~
  
   Questo per ottenere i nomi corretti.  
3. Individuata la partizione corretta, create il punto di mount:  
   ~~~    
   mkdir -p /media/[hdxx,sdxx,diskx]    
   ~~~
  
4. Montatela:  
   ~~~    
   mount /dev/xdxx /media/xdxx    
   ~~~
  
5. Infine riscrivete Grub nell'MBR del primo disco fisso (generico):  
   ~~~    
   /usr/sbin/grub-install --recheck --no-floppy --root-directory=/media/xdxx /dev/sda    
   ~~~
  

<div class="divider" id="chroot"></div>
### Utilizzare chroot per ripristinare nell'MBR un Grub2 sovrascritto o corrotto

Per ripristinare Grub 2 se è stato sovrascritto o se si è corrotto nell'MBR, configurate un ambiente `chroot` . `Basterà avere una qualsiasi live.iso dato che attraverso chroot si riesce ad arrivare al sistema installato nel disco rigido e si può quindi ripristinare la versione di grub appropriata, Grub 1 (Grub-legacy) oppure Grub 2.` 

Avviate una live siduction.iso appropriata per il sistema (su CD, DVD, chiavetta USB o scheda SSD, 32 o 64 bit) e aprite la console. Scrivete `sux`  e premete Invio per ottenere i permessi di root.

Utilizzando `fdisk -l o blkid` , verificate quale è la partizione di avvio e annotatene il nome corretto. Se preferite una interfaccia grafica utilizzate `Gparted` :

~~~  
blkid  
~~~

e controllate che in fstab corrisponda il risultato del comando blkid:

~~~  
cat /etc/fstab  
~~~

Supponiamo che il filesystem di root sia su `/dev/sda2` 

~~~  
mkdir /mnt/siduction-chroot  
mount /dev/sda2 /mnt/siduction-chroot  
~~~

Quindi dovrete montare /proc, /run, /sys e /dev come segue:

~~~  
mount --bind /proc /mnt/siduction-chroot/proc  
mount --bind /run /mnt/siduction-chroot/run  
mount --bind /sys /mnt/siduction-chroot/sys  
mount --bind /dev /mnt/siduction-chroot/dev  
mount --bind /dev/pts /mnt/siduction-chroot/dev/pts  
~~~

Se avviate usando una partizione di sistema EFI dovrete montare anche questa. Supponendo che sia /dev/sda1:

~~~  
mount /dev/sda1 /mnt/siduction-chroot/boot/efi  
~~~

Adesso che l'ambiente chroot è configurato, accedetevi con:

~~~  
chroot /mnt/siduction-chroot /bin/bash  
~~~

Ora siete in grado di utilizzare la cache locale di apt o di modificare i file da aggiustare proprio come se aveste propriamente avviato il sistema operativo, in questo caso per risistemare Grub nell'MBR.

`Per ripristinare Grub 2` 

~~~  
apt-get install --reinstall grub-pc  
~~~

Per assicurarvi che Grub sia installato nel disco o nella partizione corretta, eseguite:

~~~  
dpkg-reconfigure grub-pc  
~~~

`Per ripristinare Grub 2 EFI` 

~~~  
apt-get install reinstall grub-efi-amd64  
~~~

`Per ripristinare Grub 1 (Grub-legacy)` 

~~~  
apt-get install --reinstall grub-legacy  
~~~

Seguite quindi le istruzioni del programma di installazione.

Per uscire dall'ambiente chroot:

~~~  
Ctrl+d  
~~~

Riavviate il PC.

<div id="rev">Page last revised 24/04/2012 1944 UTC</div>
