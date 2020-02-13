<div id="main-page"></div>
<div class="divider" id="kern-upgrade"></div>
## Installare nuovi kernel

##### `I kernel di siduction si trovano nel deposito siduction sotto forma di file .deb e vengono inclusi automaticamente nel dist-upgrade.` 


---

Sono disponibili nelle seguenti versioni:

+  **siduction-686**  per la famiglia di processori i686 singolo/doppio core o più  
+  **siduction-amd64**  per processori a 64 bit  

##### I passi da fare per l'installazione manuale, senza passare per il dist-upgrade, sono:

 **1.**  In una console autenticatevi come root, poi:

~~~  
apt-get update  
~~~

 **2.** Per installare l'ultima versione del kernel:

~~~  
apt-get install linux-image-siduction-686 linux-headers-siduction-686  
~~~

Riavviate per utilizzare il nuovo kernel.

`Se il nuovo kernel dovesse dare problemi, potete riavviare e scegliere un kernel più vecchio.` 

##### Moduli

Per trovare i moduli che vi servono, il seguente comando vi fornisce la lista del moduli correntemente disponibili; copiate questa linea nella console/terminale:

~~~  
apt-cache search 3.*-*.towo.*-siduction | awk '/modules/{print $1}'  
~~~

Per avere una completa descrizione di ogni modulo, copiate la seguente linea nella console/terminale:

~~~  
apt-cache search 3.*-*.towo.*-siduction  
~~~

Per installare i moduli richiesti (per esempio virtualbox-ose e qc-usb):

~~~  
apt-get install virtualbox-ose-modules-3.1-4.towo.2-siduction-686 (ESEMPIO)  
apt-get install qc-usb-modules-3.1-4.towo.2-siduction-686 (ESEMPIO)  
~~~

Per controllare i moduli caricati nel kernel:

~~~  
ls /sys/module/  
oppure  
cat /proc/modules  
~~~

<div class="divider" id="dmakms"></div>
## Installare i moduli con Dynamic Module-Assistant Kernel Module Support (dmakms)

dmakms è utile per installare i moduli kernel che non sono preconfezionati per il kernel siduction ed è concepito per automatizzare l'installazione dei moduli del kernel con module-assistant `(m-a)`  quando si aggiorna il kernel o se ne installa uno nuovo.

~~~  
apt-get install dmakms module-assistant  
~~~

Prima di attivare Dynamic Module-Assistant Kernel Module Support, utilizzate module-assistant per installare il/i modulo/i del kernel desiderato/i per il kernel corrente. Per maggiori informazioni su module-assistant leggete la sua pagina del manuale:

~~~  
man m-a  
~~~

Il nome del pacchetto compatibile con module-assistant quindi deve essere aggiunto a `/etc/default/dmakms` , in modo che l'operazione di preparare e installare lo stesso modulo/i per ogni nuovo kernel Linux possa essere automatizzata.

#### Esempio: Installare il `modulo speakup`  con module-assistant

Assicuratevi che la lista delle sorgenti software contenga `contrib non-free`  aggiunti nella linea in: `/etc/apt/sources.list.d/debian.list`  

~~~  
apt-cache search speakup-s  
speakup-source - Source of the speakup kernel modules  
~~~

quindi preparate il modulo:

~~~  
m-a prepare  
m-a a-i speakup-source  
~~~

Adesso attivate Dynamic Module-Assistant Kernel Module Support per speakup, in modo che la prossima volta che il kernel verrà aggiornato venga preparato un nuovo modulo per speakup compatibile, senza intervento manuale. Per fare ciò aggiungete `speakup-source`  al file di configurazione `/etc/default/dmakms` .

~~~  
mcedit /etc/default/dmakms  
speakup-source  
~~~

Ripetete lo stesso procedimento per ogni altro pacchetto di modulo kernel compatibile con module-assistant.

Un pacchetto linux-headers deve essere installato per ogni pacchetto linux-image per far sì che module-assistant possa compilare i moduli del kernel.

#### Errore nel caricamento del modulo

Se il modulo non si dovesse caricare per u qualunque motivo (nuovo componente xorg, problema sul filesystem, oppure se X non parte dopo il riavvio):

~~~  
modprobe <modulo>  
~~~

Quindi riavviate il sistema.

Se ancora dovesse dare errore nel caricamento:

~~~  
m-a a-i -f module-source  
~~~

Questo comando ricostruisce il modulo, `quindi riavviate` .

##### Come funziona

Dynamic Module-Assistant Kernel Module Support consiste in un singolo initscript (/etc/init.d/dmakms) che viene eseguito all'avvio oppure da un altro script che viene avviato dopo l'installazione di un nuovo pacchetto linux-image Debian.

A ogni avvio /etc/init.d/dmakms viene eseguito per verificare che ogni pacchetto sorgente del modulo compreso nella lista di /etc/default/dmakms abbia un corrispettivo pacchetto per il kernel Linux corrente, richiamando, se necessario, module-assistant per compilare e installare il pacchetto.

Quando un nuovo pacchetto linux-image Debian viene installato, /etc/init.d/dmakms viene eseguito attraverso uno script post-installazione con due argomenti, 'start' e 'version string' (cioè, numero di versione)) del kernel Linux di cui preparare il pacchetto. A questo punto, i pacchetti dei moduli listati nel file di configurazione /etc/default/dmakms sono lavorati con module-assistant e i pacchetti risultanti sono programmati per l'installazione allo spegnimento del sistema. `La ragione dell'installazione allo spegnimento è perché si rende necessario ritardare l'installazione sino a che apt/dpkg non sono bloccati da altri processi` .

~~~  
$ /usr/share/doc/dmakms  
~~~

<!--</div>
<div class="divider" id="other-kern-inst"></div>
## Altri metodi per installare il kernel

##### siductioncc

Si può anche installare i kernel mediante il centro di controllo siduction ad interfaccia grafica  [siductioncc](siductioncc-it.htm)  che nel menù è localizzato in KDE Start Menu > Sistema > siduction Control Centre; siductioncc offre anche parecchie altre applicazioni a interfaccia grafica di amministrazione del sistema 

-->
<div class="divider" id="kern-remove"></div>
## Rimozione di vecchi kernel (kernel-remover)

Dopo aver installato con successo il nuovo kernel, i vecchi kernel possono essere rimossi; si raccomanda, comunque, di tenerli per alcuni giorni nel caso si evidenzino problemi con il nuovo kernel: si potrà in tal caso riavviare il PC con uno dei vecchi kernel presenti nella lista di avvio di grub.

I vecchi kernel possono essere rimossi dal sistema. Per farlo installare `kernel-remover` :

~~~  
apt-get update  
apt-get install kernel-remover  
~~~

<div id="rev">Content last revised 24/04/2012 1025 UTC</div>
