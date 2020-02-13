<div id="main-page"></div>
<div class="divider" id="welcome-gen"></div>
## Benvenuti nel Manuale del Sistema Operativo siduction

siduction è un gioco di parole tra `sid`  e  *seduction* . `sid`  è  *il nome in codice della branca unstable di Debian.* 

siduction è un sistema operativo basato sul  [kernel Linux](http://www.kernel.org/)  e il  [progetto GNU](http://www.gnu.org/) , con applicazioni/programmi provenienti da  [Debian](http://www.debian.org/)  unstable/sid e con uno stretto legame ai valori base del  [contratto sociale](http://www.debian.org/social_contract)  di Debian.

Non dovrete più aspettare un nuovo rilascio per avere sempre le versioni più aggiornate dei programmi, kernel compreso. Una volta installato siduction con tutti i programmi e le applicazioni preferite, tutto quello di cui ha bisogno è un  [dist-upgrade](sys-admin-apt-it.htm#apt-upgrade) , cioè un aggiornamento globale dei programmi provenienti da Debian e dei pacchetti specializzati di siduction.

Ciò significa che con siduction non è più necessario installare un nuovo rilascio ogni 6 o più mesi, dato che il dist-upgrade giornaliero, settimanale o mensile porta tutto all'ultima versione.

È importante notare che, dato che siduction utilizza il ramo instabile di Debian e a causa della stessa natura di "sid", dovrete essere pronti a utilizzare il  [Terminale/Console](term-konsole-it.htm) .

Con il "modo siduction" sarete sempre aggiornati e avrete il meglio che siduction insieme a Debian "sid" possono offrire.

<div class="divider" id="how-to"></div>
## Come usare questo manuale

`Il Manuale del Sistema Operativo siduction è un riferimento per l'apprendimento iniziale e per il ripasso delle conoscenze su un sistema operativo della famiglia linux, e ciò non solo relativamente alle nozioni di base dato che in esso sono affrontati anche parecchi argomenti complessi che vi aiuteranno nella vostra qualità di amministratore di sistema.` 

<div class="divider" id="man-gen"></div>
##### Generalità

Questo manuale è suddiviso in sottosezioni: ad esempio, un argomento riguardante il partizionamento si trova alla voce Partizionare il disco fisso, mentre gli argomenti su Internet/WiFi sono raggruppati alla voce Internet e Networking. Vi sono alcuni argomenti, comunque, che non possono essere raggruppati o che richiedono una trattazione a sé.

Per l'aiuto su uno specifico programma o un'applicazione (chiamati `pacchetto` ), già preinstallati o che avete installato successivamente, cercate nel forum di aiuto nel sito web del pacchetto, nelle FAQ e nei manuali online e/o in un menù di aiuto all'interno del pacchetto stesso, tutti in grado di guidarvi nell'uso del programma/applicazione.

Molti buoni programmi/applicazioni hanno anche una guida nelle pagine <span class="highlight-3">man</span> richiamabili dal terminale. Controllate anche se è presente una documentazione in `/usr/share/doc/<pacchetto>` .

 [Se non intendete leggere altro, date quanto meno un'occhiata alla Guida Rapida.](wel-quickstart-it.htm#welcome-quick) 

 Come in ogni documentazione possono esservi errori, inesattezze, refusi tipografici. Speriamo non ve ne siano delle due prime tipologie (possiamo convivere con i refusi), ma vi chiediamo comunque scusa.

Man mano che la mole del nostro lavoro cresce, verrà aggiunta altra documentazione: tutti noi qui in siduction siamo sicuri che sarà una risorsa molto valida per voi. Vi ringraziamo per essere partecipi di siduction.

##### Stampare le caselle con lunghe righe di codice del manuale

La stampa propriamente detta dei file principali del manuale, impostata come `ritratto` , cioè in verticale, non permette naturalmente che una lunga casella di testo possa essere interamente stampata perché si andrebbe al di là dei margini reali del foglio (il manuale sul sito web non presenta questo inconveniente perché le caselle di testo possono scorrere).

Mentre ciò non è generalmente un problema per un sito web, quale ad esempio un sito tradizionale di informazione, è piuttosto critico per qualsiasi distribuzione linux poiché una singola linea di codice immessa in un terminale può essere lunga fino a 120 caratteri ed è quindi usualmente più larga di una tipica pagina verticale A4 con caratteri di 12 punti.

Impostate pertanto le preferenze di stampa come `paesaggio` , cioè in orizzontale.

##### Copyright

 Tutti i contenuti sono ©2006-2012 e rilasciati sotto la  [GNU Free Documentation License](http://www.gnu.org/licenses/fdl.txt) . È garantito il permesso di copiare, distribuire e/o modificare questo documento sotto i termini della GNU Free Documentation License, Versione 1.2 o qualsiasi più recente versione rilasciata dalla Free Software Foundation; senza Sezioni Invarianti, senza Testi di Copertina in fronte o in retro.

Tutti i marchi registrati e i diritti d'autore appartengono ai loro proprietari, sia questo specificato o no.

E&amp;OE

## Clausola di esonero di responsabilità

Questo è software sperimentale. Usatelo a vostro rischio. Il progetto siduction, i suoi sviluppatori e i componenti della squadra non possono essere ritenuti responsabili in nessuna circostanza di danni all'hardware o al software, perdita di dati, o altri danni diretti o indiretti risultanti dall'uso di questo software. Se non siete d'accordo con questi termini e condizioni, non siete autorizzati a usare o distribuire ulteriormente questo software.

<div class="divider" id="table-contents"></div>
## Indice

Se la barra di navigazione e/o i sottomenu non appaiono correttamente, assicuratevi che nel vostro browser la minima dimensione dei caratteri sia impostata come non più grande di 12 punti (in Firefox), idealmente 10. `Gli utenti che utilizzano un netbook potrebbero aver bisogno di diminuire lo zoom (Ctrl+-) una o due volte per vedere il menu principale, oppure usare l'indice seguente` .

#####  [Manuale di siduction](welcome-it.htm#welcome-gen) 

+  [Manuale di siduction](welcome-it.htm#welcome-gen)   
+  [Come usare questo manuale](welcome-it.htm#how-to)   
+  [Indice](welcome-it.htm#table-contents)   
+  [Come ottenere aiuto](help-it.htm#help-gen)   
+  [IRC !paste](help-it.htm#paste)   
+  [Crediti](credits-it.htm#cred-team)   
+  [Guida rapida di siduction](wel-quickstart-it.htm#welcome-quick)   

#####  [Rilasci ISO, Mirror e Masterizzazione](cd-dl-burning-it.htm#download-siduction) 

+  [ISO e requisiti di sistema](cd-content-it.htm#cd-content)   
+  [Note di rilascio](sys-admin-release-it.htm#rolling)   
+  [Mirror di siduction, download e masterizzazione](cd-dl-burning-it.htm#download-siduction)   
+  [Somma MD5](cd-dl-burning-it.htm#md5)   
+  [Masterizzare in Windows](cd-dl-burning-it.htm#burn-nero)   
+  [Masterizzare in Linux](cd-dl-burning-it.htm#burn-linux)   
+  [Script burniso](cd-no-gui-burn-it.htm#burning-no-gui)   
+  [Masterizzare senza interfaccia grafica](cd-no-gui-burn-it.htm#burn-no-gui-gen)   

#####  [Modalità Live](live-mode-it.htm#rootpw) 

+  [Password di root nel live ISO di siduction](live-mode-it.htm#rootpw)   
+  [Installare software in modalità live ISO](live-mode-it.htm#live-cd-installsoft)   

#####  [Il Terminale/Konsole](term-konsole-it.htm) 

+  [Privilegi di root con sux](term-konsole-it.htm#sux)   
+  [Terminale/Konsole](term-konsole-it.htm#term-kon)   
+  [Aiuto nella linea di comando](term-konsole-it.htm#cli-help)   
+  [Strumenti in modalità testo (tty) e init 3](help-it.htm#init3-tools)   
+  [Lista dei comandi da terminale](term-konsole-it.htm#term-cmds)   
+  [Installare script.sh](term-konsole-it.htm#shell-scripts)   

#####  [Opzioni d'avvio](cheatcodes-it.htm) 

+  [Opzioni d'avvio specifiche del live ISO di siduction](cheatcodes-it.htm#cheatcodes)   
+  [Opzioni d'avvio generiche di Linux](cheatcodes-it.htm#cheatcodes-linux)   
+  [Codici VGA](cheatcodes-vga-it.htm#vga)   

#####  [Partizionare il disco fisso](part-gparted-it.htm#partition) 

+  [Partizionare il disco fisso con GParted/KDE Partition Manager](part-gparted-it.htm#partition)   
+  [Ridimensionare una partizione NTFS con GParted/KDE Partition Manager](part-gparted-it.htm#ntfs)   
+  [UUID, etichettare partizioni e fstab](part-uuid-it.htm#uuid)   
+  [Formattare dopo aver partizionato con gdisk](part-gdisk-it.htm#gdisk-6)   
+  [Partizionamento GPT con gdisk](part-gdisk-it.htm#gdisk-1)   
+  [Assegnare nomi ai dischi: elementi di base](part-cfdisk-it.htm#disknames)   
+  [Partizionare il disco fisso con cfdisk](part-cfdisk-it.htm#partition)   
+  [Formattare dopo aver partizionato con cfdisk](part-cfdisk-it.htm#formating)   
+  [Esempi di dimensione delle partizioni](part-size-examp-it.htm#part-example)   

#####  [Opzioni di installazione](hd-install-it.htm#Inst-prep) 

+  [Preparazione all'installazione](hd-install-it.htm#Inst-prep)   
+  [Installare sul disco fisso](hd-install-it.htm#Installation)   
+  [Primo avvio](hd-install-it.htm#first-hd-boot)   
+  [Avviare con "fromiso"](hd-install-opts-it.htm#fromiso)   
+  ["fromiso" e "persist"](hd-install-opts-it.htm#fromiso-persist)   
+  [Installare siduction su di un dispositivo USB - "siduction-on-stick"](hd-install-opts-it.htm#usb-hd)   
+  [Installare siduction su di un dispositivo USB/SSD con qualsiasi sistema operativo Linux, MS Windows, Mac OS X](hd-ins-opts-oos-it.htm#raw-usb)   
+  [Avviare siduction attraverso una rete](nbdboot-it.htm#nbd1)   
+  [Opzioni di installazione in una Macchina Virtuale](hd-install-vmopts-it.htm#vm)   

#####  [Schede Grafiche, Monitor, Xorg &amp; Driver](gpu-it.htm#non-free) 

+  [Risoluzione dello schermo e tipi di schermi](hw-dev-mon-it.htm#mon-res)   
+  [Doppio schermo e xrandr](hw-dev-mon-it.htm#xrandr)   
+  [Doppio schermo (usando i binari)](hw-dev-mon-it.htm#mon-binary)   
+  [AMD/ATI - driver 3D](gpu-it.htm#ati-3d)   
+  [Intel - driver 2D e 3D](gpu-it.htm#intel)   
+  [Nvidia - driver 3D](gpu-it.htm#nvidia)   
+  [Open Source - driver Xorg](gpu-it.htm#foss-xorg)   
+  [Firmware non-free - individuazione](nf-firm-it.htm#fw-detect)   
+  [Aggiungere non-free alla Sources List](nf-firm-it.htm#non-free-firmware)   

#####  [Gestori di finestre](wm-dm-it.htm#desk-freeze) 

+  [Aggiunte utili per Xfce](wm-dm-it.htm#xfce-notes)   
+  [Aggiunte utili per KDE](wm-dm-it.htm#install-add)   
+  [Blocchi del desktop](wm-dm-it.htm#desk-freeze)   
+  [Impossibilità a entrare in KDE](wm-dm-it.htm#kde-login)   
+  [Cambiare i temi](wm-dm-it.htm#ch-th)   

#####  [LAMP in siduction](lamp-apache-it.htm#serv-apache) 

+  [LAMP in siduction](lamp-apache-it.htm#serv-apache)   
+  [Client FTP](lamp-apache-it.htm#serv-ftp)   
+  [Protocolli di sicurezza](lamp-apache-it.htm#serv-sec)   
+  [SSL](lamp-apache-it.htm#serv-ssl)   
+  [Impostazione di MySQL](lamp-sql-it.htm#serv-mysql)   
+  [PHP in Apache](lamp-php-it.htm#serv-php)   
+  [Impostazione del time server](ntp-server-it.htm#ntp-server)   

#####  [Internet e reti](inet-ceni-it.htm#netcardconfig) 

+  [Tor](tor-privoxy-it.htm#tor)   
+  [Privoxy](tor-privoxy-it.htm#privoxy)   
+  [Firewall](inet-ceni-it.htm#firewalls)   
+  [Configurare Samba (Windows)](samba-it.htm#configure)   
+  [Impostazione del server-samba](samba-it.htm#setup)   
+  [Mount da remoto con SSH](ssh-it.htm#ssh-fs)   
+  [Applicazioni X-Window attraverso SSH](ssh-it.htm#ssh-x)   
+  [Interfaccia grafica per SSH con Konqueror](ssh-it.htm#ssh-f)   
+  [SSH X-forwarding da un PC con Windows](ssh-it.htm#ssh-w)   
+  [SSH e sicurezza](ssh-it.htm#ssh)   
+  [Modem 56k](inet-ceni-it.htm#dial-mod)   
+  [WiFi - WPA_GUI](inet-wpagui-it.htm#wpa-roaming-gui)   
+  [WiFi - Impostare il Roaming WiFi](inet-setup-it.htm#net-set1)   
+  [WiFi - wpasupplicant](inet-wpa-it.htm#wpa)   
+  [Commutare la rete fra WiFi e Cavo](inet-ifplug-it.htm#hotswitch)   
+  [Attivare una connessione di rete con "Ceni"](inet-ceni-it.htm#netcardconfig)   

#####  [Dist-upgrade e gestione dei pacchetti](sys-admin-apt-it.htm#apt-cook) 

+  [APT - Guida rapida e lista dei depositi del software](sys-admin-apt-it.htm#apt-cook)   
+  [Installare un nuovo pacchetto](sys-admin-apt-it.htm#apt-install)   
+  [Eliminare un pacchetto](sys-admin-apt-it.htm#apt-delete)   
+  [Effettuare il downgrade di un pacchetto](sys-admin-apt-it.htm#apt-downgrade)   
+  [Cercare un pacchetto con apt-cache](sys-admin-apt-it.htm#apt-cache)   
+  [Cercare un pacchetto tramite interfaccia grafica](sys-admin-apt-it.htm#gui-pacsea)   
+  [Aggiornare un sistema attraverso il live ISO](sys-admin-upgrade-it.htm#live-cd-upgrade)   
+  [Fare il dist-upgrade di più PC in rete](sys-admin-apt-locarmirr-it.htm#approx)   
+  [Aggiornare il kernel](sys-admin-kern-upg-it.htm#kern-upgrade)   
+  [Aggiornare un sistema installato - dist-upgrade - Panoramica](sys-admin-apt-it.htm#apt-upgrade)   
+  [Aggiornare un sistema installato - dist-upgrade - Passi da fare](sys-admin-apt-it.htm#du-st)   

#####  [Amministrazione del sistema](sys-admin-gen-it.htm#start-services) 

+  [Aggiungere un nuovo utente](hd-install-it.htm#adduser)   
+  [Spostare la directory "home"](home-it.htm#home-bu)   
+  [Backup con rdiff](sys-admin-rdiff-it.htm#rdiff)   
+  [Backup con rsync](sys-admin-rsync-it.htm#rsync)   
+  [Antivirus e ricerca di rootkit](vir-rkits-it.htm#virus-rkits)   
+  [Abilitare e disabilitare servizi](sys-admin-gen-it.htm#start-services)   
+  [Recupero della password di root](sys-admin-gen-it.htm#pw-lost)   
+  [Font](sys-admin-gen-it.htm#fonts)   
+  [CUPS - Sistema di Stampa](sys-admin-gen-it.htm#cups)   
+  [Mixer del suono](sys-admin-gen-it.htm#sound)   
+  [runlevel di siduction - init](sys-admin-gen-it.htm#init)   
+  [Aggiornare il BIOS con FreeDOS](bios-freedos-it.htm#bois-prep)   
+  [Grub2 - MBR: sovrascrittura del settore di boot](sys-admin-grub2-it.htm#chroot)   
+  [Grub2 - Avvio duplice o multiplo](sys-admin-grub2-it.htm#multi-os)   
+  [Grub2 -Aggiornare da Grub1](sys-admin-grub2-it.htm#grub1-grub2)   
+  [Grub2 - Panoramica](sys-admin-grub2-it.htm#grub2)   

<div id="rev">Page last revised 06/05/2012 2337 UTC</div>
