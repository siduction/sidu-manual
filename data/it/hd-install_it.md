<div id="main-page"></div>
<div class="divider" id="Inst-prep"></div>
## Preparazione all'installazione sul disco rigido

**`Per un normale uso desktop si raccomanda l'utilizzo del filesystem ext4: è il predefinito per siduction ed è ben seguito.`**

`Prima dell'installazione rimuovete tutti i dispositivi USB, chiavette, fotocamere, etc` .  [L'installazione su dispositivi USB richiede, come vedremo, ulteriori passi.](hd-install-opts-it.htm#usb-hd)  Potete modificare il file del programma di installazione `~/.sidconf`  e usare un diverso filesystem o distribuire l'installazione su partizioni diverse. Per esempio, potreste voler usare una /home separata.

`È fortemente raccomandato l'utilizzo di una partizione separata per i dati. I benefici relativi al recupero da eventi disastrosi e alla stabilità dei dati stessi sono incommensurabili.`

In questo caso la $HOME diventa il luogo ove sono registrate le configurazioni delle applicazioni di base. Detto in altri termini, la $HOME è un contenitore nel quale le applicazioni conservano le proprie impostazioni.

###### Reinstallare le applicazioni sullo stesso PC o duplicarle su un altro computer

Per creare una lista delle applicazioni installate, sì da poter replicare l'installazione di base su un'altra macchina o reinstallare nuovamente il tutto sul PC, digitate in una console:

~~~  
dpkg -l|awk '/^ii/{ print $2 }'|grep -v -e ^lib -e -dev -e $(uname -r) >/home/username/installed.txt  
~~~

e copiate il file di testo risultante in una chiavetta usb o in altro dispositivo rimovibile.

Sulla nuova macchina copiate il file in $HOME e usate la lista come riferimento per installare le applicazioni che intendete replicare.

##### RAM e Swap

Su PC con meno di 512 MByte di RAM è necessario avere una partizione di swap. La dimensione non dovrebbe essere inferiore a 128 MByte (il valore fornito da cfdisk non è affidabile in quanto questo programma fa i calcoli in base 10); più di 1 GByte di swap serve raramente, ad esempio se si copiano file molto grandi, come avviene quando si duplica un CD/DVD al volo, o se servono le funzioni sospensione/ibernazione, o ancora su sistemi server. In questo caso, destinate almeno 2 GByte allo swap.

`Per favore, si veda attentamente:  [Partizionare il disco fisso](part-gparted-it.htm#partition) `

**`FATE SEMPRE IL BACKUP DEI DATI, inclusi i segnalibri e i messaggi di posta!`**  Si veda in proposito  [Backup con rdiff](sys-admin-rdiff-it.htm#rdiff)  e  [Backup con rsync](sys-admin-rsync-it.htm#rsync) . Altra opzione possibile è sbackup (ma è necessario installarlo).

L'installazione su disco fisso è molto più confortevole e rende il sistema operativo assai più veloce di quanto si abbia eseguendolo da liveCD.

Innanzitutto, regolate le impostazioni del BIOS in modo che il primo dispositivo di avvio sia il CD-ROM. Con la maggior parte dei computer si può entrare nelle impostazioni del BIOS premendo il tasto "del" o "canc" della tastiera durante l'avvio (alcune versioni di BIOS, ad esempio i BIOS AMI, offrono la possibilità di scegliere estemporaneamente il dispositivo di avvio premendo F11 o F8).

Fatto questo, siduction dovrebbe avviarsi nella maggior parte dei casi. Se ciò non avviene, può essere necessario far uso di opzioni di avvio (dette anche cheatcodes), immettendole nelle stringhe del gestore d'avvio. L'uso di queste opzioni (ad esempio, per la risoluzione dello schermo o per la selezione della lingua) consente di risparmiare molto tempo nella configurazione post-installazione.  [Vedasi anche "Opzioni d'avvio"](cheatcodes-it.htm#cheatcodes-siduction)  e  ["Codici VGA"](cheatcodes-vga-it.htm#vga) 

<!-- hiding crap for the moment
<div class="divider" id="efi"></div>
## (U)EFI booting

The bootloader will be an EFI program installed to `/efi/siduction`  within your `EFI system partition`  and mounted below `/boot/efi/`  on your installed system, provided the following conditions are met:

+ The BIOS needs to be EFI capable, and turned on, and selected to be bootable.  
+ x86-64/ EM64T system (amd64) machines.  
+ A current siduction-amd64.iso</li><li>Booted using UEFI and this is apparent from the plain white/blue grub2 menu, instead of the usual graphical boot menu provided by isolinux for BIOS booting, on the live medium.  
+ A vfat formatted EFI system partition on a GPT disk (type EF00) exists on the target system.  
+ The install target is not a USB disk.  

For partitioning GPT disks consult  [Partitioning with gdisk for GPT disks.](part-gdisk-en.htm#gdisk-1) 

-->
<!-- hiding crap for the moment <div class="divider" id="lang"></div>
## Choosing the language for your installation

###### `Language Installs with KDE` 

Select your main language from the **`grub menu (F4)`**  in the `kde-full release` , to install the localisations for the desktop and many applications while booting. 

This ensures they are also present after installing siduction, while only installing the required languages for the given system. The amount of memory required for this feature depends on the language and siduction may refuse to install the given language packs automatically with insufficient RAM and the boot sequence will be continued in English language but with the desired locales settings (currency, date and time format, keyboard charsets). 1 GB memory or more should be safe for all supported languages, which are:

  
Default - Deutsch (German)  
Default - English (English-US)  
*Čeština (Czech)  
*Dansk (Danish)  
*Español (Spanish)  
*English (GB)  
*Français (French)  
*Italiano (Italian)  
*Nihongo (Japanese)  
*Nederlands (Dutch)  
*Polski (Polish)  
*Português (Portuguese BR and PT)  
*Română (Romanian)  
*Русский (Russian)  


The language selection depends on the availability of siduction-manual translations, get involved to add your language.

-->
###### `Installazione della lingua con KDE-lite` 

1. Selezionate la lingua principale desiderata dal **`menu gfxboot (F4)`** . (Si veda anche  [Opzioni d'avvio specifiche del Live-CD di siduction](cheatcodes-it.htm#cheatcodes) ). I file delle lingue non sono tutti presenti nel LiveCD e il sistema utilizzerà quindi per default l'inglese. Tuttavia verrà fatta la corretta configurazione per la lingua selezionata e non vi sarà quindi bisogno di altri cambiamenti nel sistema, a parte l'installazione dei file mancanti della lingua.  
2. Iniziate l'installazione.  
3. Installate nel disco fisso e riavviate.  
4. Dopo l'installazione, installate la lingua prescelta e le applicazioni mediante apt-get.  

###### Primo avvio da disco fisso

`Dopo aver avviato per la prima volta vi accorgerete che siduction ha dimenticato la configurazione della rete` . Questa, però, può essere agevolmente configurata da  [Kmenu > Internet > Ceni](inet-ceni-it.htm#netcardconfig) . Per eventuali roaming WiFi/WLAN aggiuntivi  [leggete qui.](inet-wpagui-it.htm) 

<div class="divider" id="Installation"></div>
## Il programma di installazione di siduction

 **1.**  Si può avviare il programma di installazione `dall'icona sulla scrivania o da KMenu > Sistema > siduction-installer` .

![siduction-Installer1](../images-it/installer-it/installer1-it.png "Welcome tab - siduction Installer") 


---

 **2.** Dopo aver letto (e ben valutato) l'avviso della prima schermata, procedete alla preparazione del disco fisso.

![siduction-Installer2](../images-it/installer-it/installer2-it.png "Partitioning tab - siduction Installer") 

`Avete fatto il backup dei dati?`

Se non avete ancora partizionato il disco fisso, cliccate sul pulsante `Execute`  nel pannello `Avvia Part.Manager`  e date anche un'occhiata a  [Partizionate il vostro HD usando gparted](part-gparted-en.htm#partition)  o, se preferite usare la shell, leggete  [Partizionate il vostro HD](part-cfdisk-en.htm#disknames) 


---

 **3.**  Ora decidete dove installare e stabilite i punti di mount. Le partizioni per le quali questi non vengono stabiliti sono montate automaticamente dal programma (la partizione di swap sarà anch'essa montata automaticamente all'avvio).

**`NOTA: la partizione root ("/") sarà formattata con il filesystem prescelto.`** 

![grub-to-mbr](../images-en/installer-en/installer3-en.png "Grub/Timesone tab - siduction Installer") 


---

 **4.**  In questa fase potete decidere se creare altri punti di mount oltre a quello di /. È consigliabile una partizione separata /home. Ancora, `è a questo punto che potete decidere di creare una partizione dati.`  `Semplicemente fate le vostre scelte per ogni partizione` . `Aggiungete le vostre scelte per ciascuna partizione` .

Tutte le altre partizioni saranno localizzate nella partizione `/media/` .

![choosing-pw](../images-en/installer-en/installer4-en.png "User/Password tab - siduction Installer") 


---

 **5.**  Come gestore dell'avvio siduction usa GRUB: installate  **Grub nel MBR** ! Scegliete diversamente solo se sapete cosa state facendo. Dovrete editare manualmente gli altri gestori d'avvio se volete tenerli.

Grub riconosce gli altri sistemi operativi installati (ad esempio, Windows) e li aggiunge al menu di avvio.

In questa finestra potete anche cambiare il fuso orario.

![hostname](../images-it/installer-it/installer5-it.png "Network tab - siduction Intaller") 


---

 **6.**  Si procede ora con l'utente, la sua password e la password di root (ricordatele!). Non scegliete password troppo facili da indovinare. Per aggiungere altri utenti, fatelo dopo l'installazione tramite terminale con  [adduser](hd-install-it.htm#adduser) .

Questa è l'ultima occasione per verificare gli aggiustamenti apportati. Rileggete tutto attentamente, poi cliccate `Avanti` .

![installation-config](../images-it/installer-it/installer6-it.png "Installation tab - siduction Installer") 


---

 **7.**  Ora date un nome all'installazione (potete chiamarla come volete, tenendo presente che lo "Host Name" deve essere composto da lettere e numeri soltanto, e NON può iniziare con un numero).

![installation-config](../images-en/installer-en/installer7-en.png "Installation tab - siduction Installer") 

Dopo questo potete decidere se ssh dovrà partire automaticamente all'avvio oppure no.

 <p>A questo punto è ancora possibile cambiare/editare manualmente il file di configurazione e poi avviare la procedura con gli ultimi cambiamenti effettuati. Il programma di installazione non fa alcun controllo e dovrete quindi fare attenzione a `non premere "Indietro" altrimenti verranno persi i cambiamenti introdotti manualmente.`  </p>
![Begin Installtion](../images-en/installer-en/installer8-en.png "Begin Installation - siduction Installer") 

Per iniziare l'installazione cliccate su `Avvia l'installazione`  L'intero processo richiede, a seconda del PC usato, 5-15 minuti, ma nei PC più vecchi può andare avanti anche per 60 minuti.

Se la barra di avanzamento si ferma in qualche punto per un po', non annullate l'operazione, ma concedetele un po' di tempo

Fine! Togliete il CD dal lettore e riavviate la vostra nuova installazione du disco rigido.

<div class="divider" id="first-hd-boot"></div>
## Primo avvio

`Dopo il primo avvio potrete constatare che siduction ha dimenticato la configurazione di rete. Dovrete pertanto riconfigurarla (Wlan, Modem, ISDN,...).`

Se in precedenza si fossero rilevati automaticamente gli indirizzi di rete (DHCP) usando un router DSL, si dovranno ora riattivare digitando in un terminale:

~~~  
ceni  
~~~

Il programma "ceni" si trova in  *Kmenu > Internet > Ceni* . Fate anche riferimento, in questo Manuale, a:  [Internet e rete](inet-ceni-it.htm#netcardconfig) 

Per aggiungere una partizione $HOME siduction già esistente a una nuova installazione dovrà essere modificato fstab. Fate riferimento a:  [Spostare la /home](home-it.htm#home-move) .

 **`Non usate e non condividete una $HOME già esistente di un'altra distribuzione poiché i file di configurazione in una directory home andranno in conflitto se si utilizza lo stesso nome utente per distribuzioni diverse.`** 

<div class="divider" id="adduser"></div>
## Aggiungere utenti all'installazione

Per aggiungere un `nuovo utente`  con i permessi di gruppo garantiti automaticamente, digitate come root: 

~~~  
adduser <nome_nuovo_utente>  
~~~

Premete semplicemente invio: il comando si occuperà dell'intera operazione. Vi verrà solo richiesto due volte di digitare la password del nuovo utente.

Le icone specifiche di siduction (come quelle del Manuale e di IRC) devono essere aggiunte manualmente.

Per cancellare un utente, digitate come root:

~~~  
deluser <nome_utente>  
~~~

Leggete:

~~~  
man adduser  
man deluser  
~~~

Anche `kuser`  può essere utilizzato per creare un nuovo utente: in questo caso, però, si dovranno impostare manualmente i permessi di gruppo per l'utente.

<div class="divider" id="sux"></div>
## Il comando sux

Numerosi comandi devono essere avviati con privilegi di root. Per ottenerli digitate:

~~~  
sux  
~~~

Il comando normale per diventare root è "su", ma usando `sux`  potrete anche avviare applicazioni a interfaccia grafica (GUI / X11) dalla console. `sux`  è in effetti un involucro attorno al comando standard "su" che trasferisce le vostre credenziali X all'utente destinatario (root).

Alcune applicazioni KDE richiedono `dbus-launch`  prima del nome dell'applicazione:

~~~  
dbus-launch <applicazione>  
~~~

Ecco alcuni esempi dell'avvio di applicazioni X11 mediante "sux": usare un elaboratore di testo come kate o kwrite per modificare un file con permessi di root; partizionare con gparted; avviare come root un file manager come Konqueror. Potrete anche modificare file appartenenti a root cliccando sul file col tasto destro e scegliendo "edit-as-root", cioè "modifica come root", e immettendo la relativa parola chiave, con ciò richiamando kdesu.

Diversamente da "sudo", con "sux" non può accadere che una qualunque persona estemporaneamente presente sia in grado di fare cambiamenti potenzialmente dannosi al sistema digitando "sudo".

**`ATTENZIONE: Quando siete autenticati come "root", il sistema non vi impedirà di fare cose potenzialmente pericolose come danneggiare file importanti, etc.: dovete quindi essere assolutamente sicuri di quello che state facendo perché è davvero possibile danneggiare seriamente il sistema.`**

**`In nessuna circostanza dovreste avviare come root in una console applicazioni di produttività giornaliera, come la gestione della posta, la creazione di fogli elettronici, la navigazione in Internet, e così via.`**

<div id="rev">Page last revised 24/01/2012 1720 UTC</div>
