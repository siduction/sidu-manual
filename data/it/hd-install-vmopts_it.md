<div id="main-page"></div>
<div class="divider" id="vmopts"></div>
## Opzioni per la Macchina Virtuale

+  [KVM per Intel VT o AMD-V](hd-install-vmopts-it.htm#kvm)   
+  [Virtualbox](hd-install-vmopts-it.htm#vbox)   
+  [QEMU](hd-install-vmopts-it.htm#qemu)   
+  [Installare altre distribuzioni in un'immagine VM](hd-install-vmopts-it.htm#oos)   

`Gli esempi che seguono utilizzano siduction: sostituitela, se volete, con la distribuzione di vostra scelta.` 

<div class="divider" id="oos"></div>
## Installare altre distribuzioni in un'immagine VM

Nota: se e quando vorrete installarle in un'immagine di una macchina virtuale, la maggior parte delle distribuzioni Linux richiederanno all'incirca uno spazio di 12G. Se, però, avete esigenza di utilizzare MS Windows in una macchina virtuale, vi sarà necessario rendere disponibili circa 30G o più per l'immagine. In definitiva, la dimensione di allocazione di un'immagine dipende dalle vostre necessità.

Generalmente, la dimensione di allocazione di un'immagine non richiederà spazio ulteriore nel disco fisso fino a quando verranno installati i dati. Ma anche allora occuperà spazio nel disco fisso solo dinamicamente, dipendente dalla quantità reale di dati che si espandono nell'immagine. E ciò in dipendenza dal rapporto di compressione di qcow2.

<div class="divider" id="kvm"></div>
## Abilitare una macchina virtuale KVM

KVM è una soluzione di virtualizzazione completa per Linux su CPU x86 che comprende le estensioni per la virtualizzazione (Intel VT o AMD-V).

### Prerequisiti

Per accertarvi se il vostro hardware supporta KVM, assicuratevi che KVM sia abilitato nel BIOS (in alcuni casi su di un sistema Intel VT o AMD-V potrebbe non essere evidente dove si trova l'opzione, ma ritenete pure che si trovi in una voce dello stato KVM). Per controllare, eseguite in una console:

~~~  
cat /proc/cpuinfo | egrep --color=always 'vmx|svm'  
~~~

Se vedete `svm`  o `vmx`  nel campo dei flags della CPU, il sistema supporta KVM. Altrimenti, se credete che sia supportato, tornate al BIOS e controllate di nuovo, oppure cercate su Internet dove l'opzione per abilitare KVM possa nascondersi nei menù del BIOS.

Se il BIOS non supporta KVM fate riferimento a  [Virtualbox](hd-install-vmopts-it.htm#vbox)   
o  [QEMU](hd-install-vmopts-it.htm#qemu) 

Per installare e avviare KVM, assicuratevi per prima cosa che i moduli di Virtualbox non siano caricati (la migliore opzione è utilizzare --purge); quindi, a seconda del chipset:

Per `vmx` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-intel  
~~~

Per `svm` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-amd  
~~~

Quando avvierete il sistema gli script di init di qemu-kvm provvederanno a caricare i moduli.

#### Utilizzare KVM per avviare una siduction-*.iso

**`Come utente:`** 

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom <siduction.iso>  
~~~

##### Installare siduction in un'immagine KVM

Per prima cosa creare una immagine su disco fisso (questa sarà minimale ed aumenterà solo quanto richiesto dal rapporto di compressione qcow2):

~~~  
$ qemu-img create -f qcow2 siduction-VM.img 12G  
~~~

Avviate siduction-*.iso con i seguenti parametri per far sì che KVM riconosca la disponibilità di un'immagine QEMU su disco fisso:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom </path/to/siduction-*.iso> -boot d </path/to/siduction-VM.img>  
~~~

Non appena il CD-ROM si è avviato cliccate sull'icona del programma di installazione di siduction per attivarlo (o fate uso del menu), cliccate sul tab di partizionamento e lanciate l'applicazione di partizionamento preferita. Seguite quindi le istruzioni fornite da  [Partitionare il Disco Fisso - Tradizionale, GPT e LVM](part-gparted-it.htm)  (non dimenticate di aggiungere una partizione di swap se avete poca RAM disponibile). La formattazione occuperà un po' di tempo: quindi, siate paziente.

![gparted kvm hard disk naming](../images-common/images-vm/kvm-gparted02.png "gparted kvm hard disk naming") 


---

Adesso avete una VM pronta all'uso:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -drive if=virtio,boot=on,file=<percorso/verso/siduction-VM.img>    
~~~
  
Alcuni sistemi guest non supportano virtio: dovrete quindi usare altre opzioni quando avviate KVM, ad esempio

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </percorso/verso/vostro_guest.img> -cdrom vostra_altra.iso -boot d  
~~~

or

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </percorso/verso/vostro_guest.img>  
~~~

Guardate anche:  [Documentazione KVM](http://www.linux-kvm.org/page/Main_Page) .

##### Gestire le installazioni della macchina virtuale KVM

~~~  
apt-get install aqemu  
~~~

Quando utilizzate AQEMU assicuratevi di aver scelto la modalità KVM dal menu a tendina di "Tipo di emulator" nella scheda "Generale" (La documentazione per AQEMU praticamente non esiste e perciò alcuni "tentativi ed errori" saranno necessari per scoprire come utilizzare la GUI; tuttavia un buon inizio è quello di utilizzare il menu "VM" seguito dalla scheda "Generale".

<div class="divider" id="vbox"></div>
## Avviare e installare in una macchina virtuale VirtualBox

Passi da fare:

+ 1. create un'immagine su disco fisso per VirtualBox  
+ 2. avviate la iso con VirtualBox  
+ 3. installate nell'immagine  

#### Requisiti

`RAM raccomandata: 1 gig` : Idealmente 512 MByte per il guest e 512 MByte per l'host (l'avviamento può riuscire o no, ma non ci si aspetti grandi prestazioni).

`Spazio sul disco fisso:`  mentre VirtualBox in sé è piuttosto "scarno" (una tipica installazione necessiterà soltanto di ~30 MB), le macchine virtuali richiedono invece file decisamente grossi sul disco per emularvi i propri dischi. Così, per installare MS Windows XP (TM), ad esempio, servirà un file che può crescere facilmente fino a parecchi GB. Per siduction sarà necessario allocare in VirtualBox un'immagine di 5 gig oltre a una partizione di swap.

### Installazione:

~~~  
apt-get update  
apt-get install virtualbox-ose-qt virtualbox-source virtualbox-dkms  
~~~

### Installare siduction nella macchina virtuale

Usate il wizard di virtualbox per creare una nuova macchina virtuale per siduction. Poi seguite le istruzioni per una normale installazione di siduction.

 [VirtualBox ha un file di aiuto esaustivo in formato PDF che potete scaricare qui](http://www.virtualbox.org/) 

<div class="divider" id="qemu"></div>
## Avviare e installare in una macchina virtuale QEMU

+ 1. create un'immagine su disco fisso per QEMU  
+ 2. avviate la iso con QEMU  
+ 3. installate nell'immagine  

È disponibile uno strumento con interfaccia grafica QT per aiutare a configurare QEMU:

~~~  
apt-get install qtemu  
~~~

#### Creare l'immagine su disco fisso

Per avviare qemu probabilmente vi servirà un'immagine su disco fisso. Trattasi di un file che immagazzina il contenuto del disco fisso emulato.

Usate il comando:

~~~  
qemu-img create -f qcow siduction-VM-img 3G  
~~~

per creare il file immagine denominato "siduction-VM.img". Il parametro "3G" specifica la dimensione del disco: in questo caso 3 GB Si può usare il suffisso M per megabyte (per esempio "256M"). Non preoccupatevi troppo riguardo alla dimensione del disco - il formato qcow comprime l'immagine in modo tale che lo spazio vuoto non si aggiunge alla dimensione del file.

#### Installare il sistema operativo

Questa è la prima volta che dovrete avviare l'emulatore. `Tenete presente che quando cliccate dentro la finestra di qemu, il puntatore del mouse viene catturato. Per rilasciarlo premete:` 

~~~  
Ctrl+Alt  
~~~

Se volete usare un floppy avviabile, avviate Qemu con:

~~~  
qemu -floppy siduction.iso -net nic -net user -m 512 -boot d siduction-VM.img  
~~~

Se il vostro CD-ROM è avviabile, avviate Qemu con:

~~~  
qemu -cdrom siduction.iso -net nic -net user -m 512 -boot d siduction-VM.img  
~~~

Ora installate siduction come fareste su un disco fisso reale.

#### Avviare il sistema

Per avviare il sistema, digitate:

~~~  
qemu [hd_image]  
~~~

Buona idea è utilizzare immagini overlay ()cioé di sovrapposizione). In questo modo potrete creare le immagini del disco fisso una volta e far salvare a Qemu i cambiamenti in un file esterno. Vi sbarazzerete di ogni instabilità dato che è facile ritornare a uno stato precedente del sistema.

Per creare una immagine overlay, digitate:

~~~  
qemu-img create -b [[base''image]] -f qcow [[overlay''image]]  
~~~

Sostituite l'immagine del disco fisso a base_image (nel nostro caso siduction-VM.img), dopodiché potrete avviare qemu con:

~~~  
qemu [overlay_image]  
~~~

L'immagine originale non verrà toccata. Un intoppo: l'immagine di base non può essere ridenominata o spostata in quanto l'overlay ricorda il percorso completo della base.

#### Usare una qualsiasi partizione reale come la sola partizione primaria di un'immagine su disco fisso

Talvolta potreste voler usare una delle partizioni del sistema dall'interno di qemu (per esempio se si vuole avviare sia la macchina reale che qemu usando una certa partizione come root). Potete farlo usando il software RAID in modalità lineare (vi servirà il driver del kernel "linear.ko") e un dispositivo di loopback: il trucco consiste nel mettere dinamicamente un master boot record (MBR) all'inizio della partizione reale che si vuole inglobare in un'immagine del disco grezzo di qemu.

Supponiamo che abbiate una partizione pulita e non montata /dev/sdaN con un qualche filesystem su di essa e che vogliate faccia parte di un'immagine disco di qemu. Prima salvate in un piccolo file l'MBR:

~~~  
dd if=/dev/zero of=/percorso/verso/mbr count=32  
~~~

Verrà creato un file di 16 KB (32 * 512 byte). È importante non crearlo troppo piccolo (anche se al MBR serve solo un singolo blocco di 512 byte), poiché più piccolo sarà e più piccola dovrà essere la parte più grossa del dispositivo del software RAID, e ciò potrebbe influire sulle prestazioni. Poi impostate un dispositivo di loopback al file MBR:

~~~  
losetup -f /percorso/verso/mbr  
~~~

Supponiamo che il dispositivo risultante sia /dev/loop0, in quanto potremmo non avere ancora usato altri loopback. Il prossimo passo sarà creare il "combinato" MBR + /dev/sdaN (l'immagine disco che usa il software RAID):

~~~  
modprobe linear  
mdadm --build --verbose /dev/md0 --chunk=16 --level=linear --raid-devices=2 /dev/loop0 /dev/sdaN  
~~~

Il risultante /dev/md0 sarà quello che userete come immagine del disco grezzo qemu (non dimenticate di impostare i permessi in modo che l'emulatore vi possa accedere). L'ultimo (e un po' astuto) passo è impostare la configurazione del disco (geometria del disco e tabella della partizioni) in modo che il punto di inizio della partizione primaria nell'MBR corrisponda a quello di /dev/sdaN dentro /dev/md0 (una dislocazione di esattamente 16 * 512 = 16384 byte in questo esempio). Fatelo utilizzando fdisk sulla macchina host, non nell'emulatore: la routine predefinita di qemu per il rilevamento di dischi grezzi fornisce spesso la dislocazione in kilobyte non arrotondabili (ad esempio, 31.5 KB, come nella sezione precedente) che non può essere gestita dal codice del software RAID. Quindi, dall'host:

~~~  
fdisk /dev/md0  
~~~

Ivi, create una partizione primaria singola corrispondente a /dev/sdaN e giocate con il comando "s"ector dal menu "x"pert finché il primo cilindro (dove inizia la prima partizione) viene a corrispondere alla dimensione dell'MBR. Alla fine, scrivete ("w"rite) il risultato nel file, e avete finito. Ora avete una partizione che potrete direttamente montare dall'host, nel contempo come parte di un'immagine disco qemu:

~~~  
qemu -hdc /dev/md0 [...]  
~~~

Potete naturalmente impostare in sicurezza qualsiasi bootloader in questa immagine disco che usa qemu, purché la partizione originale /boot/sdaN contenga gli strumenti necessari.

<!--#### Usare il modulo acceleratore di QEMU

Gli sviluppatori di qemu hanno creato un modulo opzionale per il kernel per accelerare qemu quasi fino ai livelli di prestazioni native del sistema. Questo dovrebbe essere caricato con l'opzione:

~~~  
major=0  
~~~

per automatizzare la creazione del necessario dispositivo /dev/kqemu. Il seguente comando:

~~~  
echo "options kqemu major=0" >> /etc/modprobe.conf  
~~~

imposterà modprobe.conf perché l'opzione venga aggiunta ad ogni caricamento del modulo.

~~~  
qemu [...] -kernel-kqemu  
~~~

Il comando qui sopra abilita la virtualizzazione completa migliorando notevolmente la velocità.

#### Per attivare qemu:

~~~  
qemu -cdrom /tmp/pkg/siduction-debug.iso -net nic -net user -m 512  
-->  
~~~

 [Qui si trova la documentazione ufficiale del progetto QEMU](http://www.nongnu.org/qemu/user-doc.html) 

 [Alcuni contenuti relativi a QEMU per il Manuale di siduction sono stati tratti dal wiki di Archlinux sotto la Licenza 1.2 della documentazione libera GNU e opportunamente modificati per il Manuale di siduction](http://wiki.archlinux.org/index.php/Qemu) 

<div id="rev">Page last revised 04/02/2012 2000 UTC</div>
