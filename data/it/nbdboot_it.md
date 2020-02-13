<div id="main-page"></div>
<div class="divider" id="nbd1"></div>
## Avviare siduction attraverso una rete (network block device - nbd)

**`Attenzione: dnsmasq include un server dhcp che può andare in conflitto con un server dhcp eventualmente già esistente nella rete (ad es., quello del router)`** `. L'opzione più sicura consiste nell'utilizzare un solo server dhcp: dovrete, quindi, disabilitare qualunque altro server dhcp presente nella stessa rete. Le opzioni del proxy dnsmasq indicate più avanti dovrebbero, peraltro, essere in grado di coesistere con un altro server dhcp nella stessa rete. Comunque, non provatele a meno che non siate gli amministratori della rete e oltretutto pronti a fronteggiare qualsiasi conseguenza imprevista.` 

#### Le basi

L'avvio da rete richiede per prima cosa la disponibilità di una macchina capace di farlo, che possa cioè essere connessa attraverso la vostra rete con una macchina che possiate impostare per offrire i relativi servizi.

Non fatelo comunque nella rete di lavoro o in altra rete di cui non abbiate il controllo, a meno che non ne siate proprietari o abbiate il permesso e l'assistenza di coloro che lo sono. Se cooperate in una rete più grande potrete ricercare le opzioni utili in dnsmasq, come ad esempio limitare le interfacce che ascolta oppure i client a cui risponde, in modo da limitare l'impatto della vostra configurazione sulla rete.

#### I prerequisiti

Una iso di siduction 2011.1 (o successiva) attiva, da utilizzare come server per l'avvio da rete. Le istruzioni dovrebbero essere le stesse con ogni siduction o debian sid aggiornate e dovrebbero fornire tutte le risposte che avete necessità di usare in altri sistemi. Linux è richiesto per gestire le periferiche nbd.

dnsmasq verrà utilizzato per fornire tutto il necessario per le fasi di avvio iniziali; di nuovo, non dovrebbe essere difficile trasferire le conoscenze richieste ad altri software.

###### Installazione

~~~  
apt-get install nbd-server dnsmasq  
~~~

### Impostare il server nbd

Presumendo che la ISO si trovi in `/dev/scd0`  (dovrebbe essere così se avete avviato il sistema da cd, ma eventualmente cambiate con il file o la periferica adatti), potete configurare un file conf per nbd-server denominato `nbd-siduction.conf`  con una sezione denominata siduction-iso per esportarvi il cd digitando::

~~~  
echo '[generic]' > nbd-siduction.conf  
nbd-server 0.0.0.0:10809 /dev/scd0 -o siduction-iso >> nbd-siduction.conf  
~~~

L'header generica è sempre richiesta. Se volete configurare nbd-server per lavorare automaticamente su un sistema reale, invece, dovrete probabilmente configurare /etc/nbd-server.conf. Vi sono molte altre opzioni per nbd-server oltre a quelle qui indicate: si veda, in proposito, `man nbd-server` .

Per far partire il server adesso, come utente normale e senza preoccuparsi della configurazione o di copiare il file in `/etc/nbd-server.conf` , si può semplicemente eseguire:

~~~  
nbd-server -C nbd-siduction.conf  
~~~

L'obiettivo di nbd-server non deve essere una iso o un cd/dvd/chiavetta-usb, ma deve semplicemente contenere un'immagine adatta di un filesystem.

#### dnsmasq

L'esempio seguente dà per scontato che stiate lavorando in una rete semplice nella quale la vostra macchina ha una connessione ethernet configurata tramite dhcp da un'altra macchina e che i client che si avviano tramite rete possono utilizzare per configurare le loro interfacce tramite dhcp.

Le principali e rilevanti opzioni per dnsmasq per avviare da rete siduction sono configurare un percorso per i file del server tftp e un file per avviare da lì.

Create una directory `tftp`  per avviare in `/home`  (la potete anche creare altrove, se preferite). Il percorso sarà dunque `/home/tftp` .

Quindi create un file di nome `pxe-siduction.conf`  e incollateci le righe seguenti:

~~~  
dhcp-range=0.0.0.0,proxy  
pxe-service=x86PC, &quot;boot linux&quot;, pxelinux  
enable-tftp  
tftp-root=/home/tftp  
tftp-secure  
~~~

Quando usate un proxy dhcp dovete fornire un menu pxe con pxelinux come sola voce, che lo avvierà pertanto automaticamente. A questo serve l'unica voce pxe-service presente sopra.

Come root, muovete il nuovo file creato `pxe-siduction.conf`  in `/etc/dnsmasq.d/` :

~~~  
sux  
mv pxe-siduction.conf /etc/dnsmasq.d/  
~~~

Nota: per una rete (ad.es. 192.168.0.*) senza altri server dhcp potete cambiare le prime due linee in:

~~~  
dhcp-range=192.168.0.100,192.168.0.199,1h  
dhcp-boot=pxelinux.0  
~~~

Rendere disponibili gli indirizzi IP partendo da 192.168.0.100 fino a 192.168.0.199 con un tempo di uso di un'ora, e dare il nome pxelinux.0 al file da avviare soltanto come parte della richiesta dhcp (quando si utilizza il proxy invece si fornisce un menu pxe con una sola voce chiamata pxelinux che quindi lo farà partire automaticamente), probabilmente non configurerà la vostra rete come voluto a meno che il vostro server dnsmasq sia anche il server dns e il gateway per i client.

Per abilitare il nuovo file dovrete decommentare l'impostazione `conf-dir=/etc/dnsmasq.d`  alla fine di `/etc/dnsmasq.conf`  e quindi riavviare dnsmasq.

dnsmasq ha molte opzioni e può funzionare sia come server dns che dhcp, pxe, tftp. Quanto sopra è solo una minima panoramica dei pezzi necessari per utilizzare pxelinux.

#### tftp

tftp è l'equivalente della directory boot in rete. Utilizzando l'esempio della directory `/home/tftp` , è necessario popolarla. Se il cdrom è montato su `/fll/scd0` :

~~~  
cp /fll/scd0/boot/isolinux/* /home/tftp  
mkdir /home/tftp/pxelinux.cfg  
mv /home/tftp/isolinux.cfg /home/tftp/pxelinux.cfg/default  
mkdir /home/tftp/boot  
cp /fll/scd0/boot/vmlin /fll/scd0/boot/initr /fll/scd0/boot/memtest /home/tftp/boot/  
cp /usr/lib/syslinux/pxelinux.0 /home/tftp/  
# required for the tftp-secure option to dnsmasq  
chown -R dnsmasq.dnsmasq /home/tftp/*  
~~~

Adesso potete modificare le opzioni di avvio secondo convenienza in `/home/tftp`  in entrambi i file `pxelinux.cfg/default`  e `gfxboot.cfg` .

In particolare è suggerito che nella sezione `[install]`  impostiate `install=` a `install=nbd` , `install.nbd.server`  all'IP del server nella rete e `install.nbd.port`  al nome della sezione da esportare di nbd, ad esempio siduction-iso (poiché adesso si fa riferimento agli "export" di nbd piuttosto che semplicemente ai numeri delle porte).

In alternativa potete disabilitare completamente il menu F3 e modificare le linee di comando del kernel per usare qualcosa come:

~~~  
fromhd=/dev/nbd0 root=/dev/nbd0 nbdroot=192.168.1.23,siduction-iso nonetwork  
~~~

###### Codice di avvio di toram

Se aggiungete toram alle opzioni di avvio, le macchine con sufficiente RAM si staccheranno dal server non appena avranno copiato il file e le macchine senza sufficiente RAM andranno avanti e si avvieranno normalmente. Per toram è richiesto almeno 1 GB di RAM (idealmente, 2 GB o più).

#### Avvio da rete

Assicuratevi che il BIOS del PC client sia impostato in modo da poter utilizzare `Boot from Network` . 

Se il BIOS supporta l'avvio da rete, la macchina è connessa a una rete con il vostro server e se il kernel siduction e initrd.img supportano la scheda di rete, dovreste essere in grado di avviare siduction dalla rete.

Alcune schede di rete potrebbero richiedere firmware non-free, ed è quindi necessario ricostruire l'immagine initrd per includerlo.

<div id="rev">Page last revised 07/05/2012 2053 UTC </div>
