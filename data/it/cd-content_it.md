<div id="main-page"></div>
<div class="divider" id="cd-content"></div>
## Contenuti del Live ISO

`siduction fornisce nella ISO live solo software conforme al Debian dfsg-free;  [si veda questo collegamento se si desiderano ulteriori informazioni sulle fonti non-libere di firmware.](nf-firm-it.htm#non-free-firmware) `

L'immagine ISO è interamente basata su Debian Sid (aggiornata al 2011-12-31), ma arricchita e stabilizzata con pacchetti e script propri di siduction. Viene fornita con l'ultimo kernel siduction ottimizzato, il quale a sua volta è basato sul  [kernel standard 3.1.6](http://www.kernel.org/) . ACPI e DMA sono abilitati per default.

`Un elenco completo delle applicazioni installate in ognuna delle varianti rilasciate è incluso in ogni mirror di download:`  [Mirrors di siduction, Download e Masterizzazione](cd-dl-burning-it.htm#download-siduction) .

<div class="divider" id="release-vari"></div>
## Varianti di rilascio ISO

siduction offre come punto d'accesso diversificato a Debian Sid 6 diversi live-ISO aggiornati; l'installazione di solito non richiede più di 10-20 minuti. 

###### Le varianti sono:

1.  **KDE 32 bit** , live-ISO di circa 1GByte:  
   include un minimo di applicazioni per il desktop KDE4. Mediante apt è poi possibile con semplicità aggiungere altre applicazioni per soddisfare le necessità di lungo termine.  
2.  **KDE 64 bit** , live-ISO di circa 1GByte:  
   include un minimo di applicazioni per il desktop KDE4. Mediante apt è poi possibile con semplicità aggiungere altre applicazioni per soddisfare le necessità di lungo termine.  
3.  **XFCE 32 bit** , live-ISO di circa 800MByte:  
   include un ambiente desktop completo (non minimale) e dispone di tutte le applicazioni necessarie per essere produttivi da subito. Richiede minori risorse rispetto a KDE4.  
4.  **XFCE 64 bit** , live-ISO di circa 800MByte:  
   include un ambiente desktop completo (non minimale) e dispone di tutte le applicazioni necessarie per essere produttivi da subito. Richiede minori risorse rispetto a KDE4.  
5.  **LXDE 32 bit** , live-ISO di circa 650MByte:  
   include un ambiente desktop leggero. Richiede ancora minori risorse rispetto a XFCE.  
6.  **LXDE 64 bit** , live-ISO di circa 650MByte:  
   include un ambiente desktop leggero. Richiede ancora minori risorse rispetto a XFCE.  

<div class="divider" id="system-requirements"></div>
## Requisiti di sistema minimi per KDE4, XFCE e LXDE

### AMD64

+ ##### Requisiti CPU:
  
   <ul>  
   <li>AMD64  
+ Intel Core2  
+ Intel Atom 330  
+ qualsiasi CPU con x86-64/EM64T o più recente  
+ Nuovi processori a 64 bit AMD Sempron e Intel Pentium 4 (controllare il flag "lm" in /proc/cpuinfo oppure utilizzare inxi -v2).  

</li>
<li>
##### Requisiti RAM:

+  **KDE:** &ge;512 MByte RAM (&ge;1 GByte RAM raccomandati), &ge;1 GByte RAM per liveapt.  
+  **XFCE:**  &ge;512MByte RAM.  
+  **LXDE:**  &ge;512MByte RAM.  

</li>
<li>scheda grafica VGA con risoluzione di almeno 640x480 pixel.</li>
<li>lettore CD/DVD o dispositivo USB.</li>
<li>&ge;3 GByte di spazio libero nel disco fisso, &ge;10+ GByte raccomandati.</li>
</ul>
### i686

+ ##### Requisiti CPU:
  
   <ul>  
   <li>Intel Pentium pro / Pentium II  
+ AMD K7 Athlon (non K5 / K6)  
+ Intel Atom N-270 / 230  
+ VIA C3-2 (Nehemiah, non C3 Samuel o Ezra)/ C7  
+ qualsiasi CPU con x86-64/EM64T o più recente  
+ è richiesto il set completo di comandi i686.  

</li>
<li>
##### Requisiti RAM:

+  **KDE:**  &ge;512 MByte RAM (&ge;1 GByte raccomandati), &ge;1 GB RAM per liveapt.  
+  **XFCE:**  &ge;512 MByte RAM.  
+  **LXDE:**  &ge;512 MByte RAM.  

</li>
<li>scheda grafica VGA risoluzione di almeno 640x480 pixel.</li>
<li>lettore CD/DVD o dispositivo USB.</li>
<li>&ge;3 GByte di spazio libero nel disco fisso, &ge;10+ GB raccomandati.</li>
</ul>
<div class="divider" id="apps-tools"></div>
## Applicazioni e strumenti

La ISO di siduction contiene una varietà di programmi e strumenti che coprono quasi ogni necessità di un utente-desktop nell'uso giornaliero.

 V'è scelta fra 3 principali Desktop Manager all'avanguardia per accedere ai programmi e alle applicazioni:  
 [KDE4 (en + de),](http://www.kde.org/)  uno dei migliori desktop manager;  
 [Xfce4 (en + de),](http://www.xfce.org/)  un desktop manager di medio spessore.  
 [LXDE (en + de),](http://www.lxde.org/)  un desktop manager leggero.

 [Fluxbox (en + de)](http://fluxbox.org/)  è incluso nelle varianti KDE e XFCE come opzione di desktop manager leggero.

Per navigare in internet, a seconda della versione, sono disponibili  [Konqueror](http://www.konqueror.org/)  e  [iceweasel](http://www.mozilla.com/)  o  [midori](http://www.twotoasts.de/index.php?/pages/midori_summary.html/) .

Quali Applicazioni di produttività per l'Ufficio, nelle varianti XFCE e LXDE sono disponibili Abiword e Gnumeric, quali gestori di file Dolphin, Thunar e PCmanFM.

Per la configurazione delle connessioni di rete e di Internet v'è  [Ceni](inet-ceni-it.htm#netcardconfig) ; per il WIFI si veda la nostra documentazione  [WIFI Roaming](inet-wpagui-it.htm) .

Le informazioni per i driver non liberi si trovano  [qui](nf-firm-it.htm#non-free-firmware) .

Per il partizionamento del disco fisso vengono forniti  [cfdisk](part-cfdisk-it.htm#disknames)  e  [e GParted](http://gparted.sourceforge.net/) , il quale dispone di un'opzione per il ridimensionamento delle partizioni ntfs.

Sono inclusi anche strumenti diagnostici come  [Memtest86+](http://www.memtest.org/) , uno strumento avanzato di diagnosi della memoria.

`Tutte le varianti ISO contengono un set completo di strumenti a linea di comando. Un elenco completo di ognuna delle varianti rilasciate è incluso in ogni mirror di download:`  [Mirrors siduction, Download e Masterizzazione](cd-dl-burning-it.htm#download-siduction) .

###### Nota legale - Clausola di esonero di responsabilità

Questo qui proposto è software sperimentale. Usatelo a vostro rischio. Il progetto siduction, i suoi sviluppatori e i membri della squadra non possono essere ritenuti responsabili in nessuna circostanza per danni all'hardware o al software, perdita di dati, o altri danni diretti o indiretti risultanti dall'uso di questo software. Se non siete d'accordo con questi termini e condizioni, non siete autorizzati a usare o distribuire ulteriormente questo software.

<div id="rev">Content last revised 19/01/2012 1714 UTC</div>
