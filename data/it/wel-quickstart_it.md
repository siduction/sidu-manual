<div id="main-page"></div>
<div class="divider" id="welcome-quick"></div>
## siduction - Guida di avvio rapido

###### **`MOLTO IMPORTANTE:`** `siduction, come LIVE-ISO Linux, si basa su una tecnologia ad alta compressione, e per questo motivo è richiesta particolare attenzione nel masterizzare l'immagine ISO. Utilizzate solo supporti CD (o DVD+RW) di alta qualità e masterizzate in **`modalità DAO (disk-at-once)`**  non più velocemente di 8x.` 


---

siduction cerca di essere al 100% compatibile con Debian sid, tuttavia di quando in quando siduction può fornire delle correzioni temporanee. Il deposito di apt di siduction contiene pacchetti specifici che includono anche il kernel, gli script, le utilità e la documentazione.

### File da leggere

`Ci sono molte pagine che un utente "nuovo" di linux o di siduction" dovrebbe leggere. Questo file è uno di quelle. Le altre sono:` 

+  [Il Terminale](term-konsole-it.htm#term-kon)  - Descrive come utilizzare il terminale e l'uso del comando sux.  
+  [Partizionamento](part-gparted-it.htm#partition)  - Descrive come partizionare il disco.  
+  [Installare siduction (HD)](hd-install-it.htm#install-prep)  - Descrive come fare l'installazione in un disco rigido.  
+  [Installare siduction (USB)](hd-install-opts-it.htm#usb-hd)  - Descrive come fare l'installazione in una chiavetta USB o in una scheda SD/flash.  
+  [Scrivere siduction nelle chiavette](hd-ins-opts-oos-it.htm#usb-hd#raw-usb)  - Descrive come scrivere siduction in una chiavetta o in una scheda SD/flash invece in un CD/DVD.  
+  [Driver e sorgenti non-free](nf-firm-it.htm#non-free-firmware)  - Descrive come configurare le sorgenti e come installare i firmware non-free.  
+  [Connessione a Internet](inet-ceni-it.htm#netcardconfig)  - Descrive come collegarsi a Internet.  
+  [Apt e dist-upgrading](sys-admin-apt-it.htm#apt-cook)  - Descrive come installare nuovo software e come eseguire un dist-upgrade.  

##### Stabilità di Debian sid/unstable

sid è un'etichetta di riferimento per i depositi 'unstable' di Debian. Debian sid è un deposito frequentemente aggiornato, rapidamente in sincronia con le ultime e più grandi versioni 'upstream', cioè 'a monte', del software mantenuto. Data la frequenza degli aggiornamenti è possibile vi sia una valutazione meno profonda dei pacchetti nel breve periodo tra la versione 'upstream' e quella ufficiale dei pacchetti Debian. 

#### Kernel siduction

Il kernel è ottimizzato per siduction in modo da aiutare a eliminare problemi e aggiungere nuove funzionalità, è configurato per ottenere migliori prestazioni e maggiore stabilità, ed è messo a punto a partire dall'ultimo kernel rilasciato da  [http://www.kernel.org/](http://www.kernel.org/)  .

Il kernel ha un sito mirror qui:  [Aggiornare il kernel](sys-admin-kern-upg-it.htm#kern-upgrade) 

#### Gestione dei pacchetti

siduction è conforme alle modalità di creazione dei pacchetti Debian e utilizza apt e dpkg per la gestione del software tramite i depositi debian e altri elencati in `/etc/sources.list.d/*` 

Debian sid ha oltre 30.000 pacchetti: dovreste quindi riuscire a trovare quello che volete usare con  [Cercare un pacchetto con apt-cache](sys-admin-apt-it.htm#apt-cache)  o con l'applicazione desctitta in  [Cercare un pacchetto debian mediante interfaccia grafica](sys-admin-apt-it.htm#gui-pacsea) .

Per installare il pacchetto che vi serve scrivete in console: `apt-get install <nome pacchetto>`   [Si veda 'Installare un nuovo pacchetto'](sys-admin-apt-it.htm#apt-install) 

I depositi di Debian sid possono essere aggiornati anche 4 volte al giorno: è quindi fondamentale, per mantenere aggiornate le proprie liste con quelle dei pacchetti sul server, avviare `apt-get update`  prima di installare un pacchetto nuovo o prima di avviare `apt-get dist-upgrade` .

###### Utilizzare depositi di altre distribuzioni basate su Debian, Sorgenti e RPM

 Installazioni da codice sorgente non sono raccomandate. Se davvero avete bisogno di compilare la vostra applicazione, fatelo come utente normale e mettete il programma nella vostra home senza installarlo nel sistema. L'uso di checkinstall e la conversione dei pacchetti RPM a .deb con alien (e altri convertitori simili) non sono raccomandati.

Altre famose (e meno famose) distribuzioni basate su Debian che reimpacchettano i pacchetti Debian per i propri depositi spesso usano differenti locazioni dei file per varie applicazioni: ciò può causare instabilità nel sistema e qualche pacchetto potrebbe non installarsi a causa di dipendenze non risolvibili derivate da schemi differenti di assegnazione dei nomi ai pacchetti o per strani numeri di versione. Per esempio, una differente versione di glibc può impedire l'avvio di un'applicazione.

Usate i depositi Debian per installare i pacchetti software necessari, dal momento che altri depositi molto probabilmente non possono essere supportati.

#### Aggiornare l'intero sistema - dist-upgrade

`apt-get dist-upgrade`  è la modalità raccomandata per aggiornare siduction. L'uso di qualunque interfaccia grafica per questo lavoro non è raccomandato.  [Aggiornare un sistema installato - dist-upgrade](sys-admin-apt-it.htm#apt-upgrade) 

Un dist-upgrade è raccomandato sia fatto al di fuori dell'interfaccia grafica X. Lanciando "init 3" da una console nel vostro gestore di finestre (KDE, XFCE, etc.) o in un terminale virtuale raggiunto con (ctrl+alt+F1, ctrl+alt+F2, etc.) uscirete da X e potrete aggiornare in sicurezza il sistema.

#### Configurazione della rete

`Ceni`  è uno strumento per configurare rapidamente e senza problemi la scheda di rete ethernet o la scheda wireless. La funzione wireless può fare la scansione delle reti, usare wep e wpa per la crittografia e i wireless-tools o wpa_supplicant per la configurazione. La configurazione della scheda ethernet è immediata usando dhcp (assegnazione automatica di indirizzo ip), ma è possibile anche impostare manualmente tutto, dalle netmask ai nameserver.

Ceni si avvia con il comando`Ceni`  o `ceni` . Se non è installato, 'apt-get install ceni' lo installerà. 

 [Connettersi - Ceni](inet-ceni-it.htm#netcardconfig) 

#### Runlevel - init

I runlevel, cioè i livelli d'avvio, di siduction sono differenti da quelli di debian. Si veda:  [I runlevel di siduction - init](sys-admin-gen-it.htm#init) 

##### Altri gestori di finestre

KDE, XFCE e fluxbox sono i predefiniti di siduction. Gnome non è supportato da siduction a tutt'oggi. Alcuni utenti di forum, wiki e chat IRC possono avere esperienza su questo ed essere desiderosi di aiutare, altrimenti dovrete fare da soli.

#### IRC e il Forum di aiuto

Non abbiate timore a chiedere aiuto tramite IRC o il forum:

+  [In questo manuale alla voce 'Dove trovare aiuto'](help-it.htm#help-gen)   
+  [Qui sul Web IRC.](http://thegrebs.com/oftc/)  Immettete il soprannome e connettetevi al canale #siduction.  

<div id="rev">Page last revised 30/04/2012 1125 UTC</div>
