<div id="main-page"></div>
<div class="divider" id="raw-usb"></div>
## Installare una ISO di siduction su una penna USB, una scheda SSD o un dispositivo SDHC con qualsiasi sistema operativo Linux, MS Windows(tm); o Mac OS X(tm);

Indipendentemente dal sistema operativo utilizzato, i seguenti metodi consentiranno l'installazione di una ISO di siduction su penna USB, scheda SSD o dispositivo SDHC (Secure Digital High Capacity).

L'immagine ISO viene scritta sul dispositivo e consente di avere una siduction-on-a-stick senza però la condizione "persist".

Qualora quest'ultima sia richiesta è necessario utilizzare install-usb-gui, non soggetto alla limitazione di cui sopra e quindi opzione raccomandata ove sia già disponibile un sistema siduction. Fate riferimento a  [Installazione con fromiso su USB/SSD, siduction-on-a-stick](hd-install-opts-it.htm#usb-from1) .

### Prerequisiti

+ `Assicuratevi che il BIOS del PC che si vuole avviare con siduction su penna USB/scheda SSD, sia in grado di avviarsi da questi dispositivi. Ciò generalmente avviene su qualsiasi PC che abbia integrato il protocollo USB 2.0 o 3.0 e supporti l'avvio da USB/SSD.`   
+ Il dispositivo USB/SSD è in genere riconosciuto automaticamente e una opzione `F4`  del menu dovrebbe indicare `Hard Disk` , altrimenti richiamate `F4 >Hard Drive`  o aggiungete `fromhd`  alla riga del menu di boot.  
+ **`È importante notare che i metodi di seguito descritti sovrascriveranno e distruggeranno ogni tabella delle partizioni esistente nella periferica selezionata. La perdita di dati dipenderà dalla dimensione della siduction-*.iso. Ciò non riduce la disponibilità di spazio per quanto riguarda Linux e sarà sempre possibile l'accesso a qualsiasi dato non cancellato dall'installazione della ISO; peraltro, MS Windows sembra consentire solo una partizione. Agite, dunque, con sicurezza e non applicate questa procedura su un disco con 100+ GByte di dati!`**   

 [Linux](#raw-lin)  &nbsp; [MS Windows](#raw-ms)  &nbsp; &nbsp; [Mac OS X](#raw-mac)  

<div class="divider" id="raw-lin"></div>
### Sistemi Operativi Linux

Inserite la penna USB o il lettore di schede con la scheda SSD su cui volete installare la ISO e digitate in un terminale:

~~~  
cat /path/to/siduction-*.iso > /dev/USB_raw_device_node  
~~~

oppure

~~~  
dd if=/path/to/siduction-*.iso of=/dev/sdf  
~~~

###### Esempio:

Inserite il dispositivo, lanciate `dmesg`  e osservare l'output:

~~~  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sdf: sdf1 sdf2  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Attached SCSI removable disk  
~~~

Supponendo di aver scaricato una ISO chiamata `siduction-11.1-OneStepBeyond--i386-2011xxxxx`  (potete anche darle come nome `siduction-11.1-onestepbeyond.iso` ), il comando da lanciare sarà allora:

~~~  
cat /home/username/siduction-11.1-onestepbeyond.iso > /dev/sdf  
~~~

oppure

~~~  
dd if=/home/username/siduction-11.1-onestepbeyond.iso of=/dev/sdf  
~~~

Il dispositivo USB/SSD è in genere riconosciuto automaticamente e una opzione `F4`  del menu dovrebbe indicare `Hard Disk` , altrimenti richiamate `F4 >Hard Drive`  o aggiungete `fromhd`  alla riga del menu di boot.

<div class="divider" id="raw-ms"></div>
### Sistemi Operativi MS Windows(tm);

La procedura è facile e veloce. Installate il programma  [flashnul](http://shounen.ru/soft/flashnul/)  ([scaricatelo da qui](http://shounen.ru/soft/flashnul/#download)).

Osservate la dizione di 'flashnul' quando lo si estrae e installa poiché questo può essere visualizzato come directory con nome flashnul-x.x (ad esempio, "flashnul-1rc1.zip" scaricato, estratto e installato nella directory Program Files in una directory chiamata flashnul-1rc1, che a sua volta conterrà una ulteriore directory anch'essa chiamata flashnul-1rc1, contenente infine il programma flashnul e i file e le directory associate, e pertanto verrà mostrato con questa configurazione nell'esempio che segue).

Inserite la penna USB o la scheda SSD.

Se l'estrazione/installazione di flashnul è avvenuta nella cartella Program Files ma non siete certi su dove è montato il dispositivo USB, studiate l'output del comando 'flashnul -p' cliccando `run`  nel menu, poi con il comando `cmd`  aprite una finestra di terminale e da lì andate nella directory di flashnul che contiene ogni singolo file del programma stesso. In questo caso:

~~~  
cd C:\Program Files\flashnul-1rc1\flashnul-1rc1\  
flashnul -p  
~~~

L'output dovrebbe mostrare qualcosa come:

~~~  
Available physical drives:  
0 size = 60022480896 (55 Gb))  
1 size = 2003828736 (1911 Mb)  
~~~

Supponendo di aver scaricato una ISO chiamata `siduction-11.1-OneStepBeyond--i386-2011xxxxx`  (potete anche darle come nome `siduction-11.1-onestepbeyond.iso` ), fate taglia e incolla (o copiate) la ISO nella cartella flashnul-1rc1 che contiene tutti i file del programma.

Siccome nell'output di esempio di "flashnul -p" mostrato, il dispostivo USB è montato in **`1`** , digitate il seguente comando e date invio (sono richiesti privilegi di amministratore):

~~~  
flashnul 1 -L siduction-11.1-onestepbeyond.iso  
~~~

In MS Win7 è necessario specificare le lettere del drive effettivo, D: o C:\ ad esempio:

~~~  
flashnul D: -L c:\flash\siduction-11.1-onestepbeyond.iso  
~~~

Il dispositivo USB/SSD è in genere riconosciuto automaticamente e una opzione `F4`  del menu dovrebbe indicare `Hard Disk` , altrimenti richiamate `F4 >Hard Drive`  o aggiungete `fromhd`  alla riga del menu di boot.

<div class="divider" id="raw-mac"></div>
### Sistemi Operativi Mac OS X(tm);

Una volta inserito il dispositivo USB, Mac OS X dovrebbe montarlo automaticamente. Nel terminale (lo si trova nel menu Applications &gt; Utilities), avviate:

~~~  
diskutil list  
~~~

Accertatevi che il dispositivo USB sia montato, poi smontate le partizioni su di esso (supponiamo /dev/disk1):

~~~  
diskutil unmountDisk /dev/disk1  
~~~

Supponendo di aver scaricato una ISO chiamata `siduction-11.1-OneStepBeyond--i386-2011xxxxx`  in `/Users/username/Downloads/`  (potete anche darle come nome `siduction-11.1-onestepbeyond.iso` ), e che il dispositivo USB sia `disk1` , lanciate:

~~~  
dd if=/Users/username/Downloads/siduction-11.1-onestepbeyond.iso of=/dev/disk1  
~~~

Il dispositivo USB/SSD è in genere riconosciuto automaticamente e una opzione `F4`  del menu dovrebbe indicare `Hard Disk` , altrimenti richiamate `F4 >Hard Drive`  o aggiungete `fromhd`  alla riga del menu di boot.

<div id="rev">Page last revised 22/01/2012 1130 UTC</div>
