<div id="main-page"></div>
<div class="divider" id="rdiff"></div>
## Backup del Sistema con rdiff-backup

rdiff-backup è uno strumento per eseguire il backup dei vostri file e può essere utilizzato su molti sistemi *nix.

**`Eseguite i comandi come root in console, a meno non vi sia detto altrimenti`**

*prezioso per ripristinare il sistema in seguito a problemi con dist-upgrade, kernel upgrade, etc. (ma anche solo per recuperare singoli file).  
*esegue il backup soltanto dei file modificati, come rsync (ogni backup quindi non impiega molto tempo).  
*tiene traccia dei cambiamenti (il che significa che potrete recuperare un file cancellato anche da tre settimane!)  
*esegue backup sicuri attraverso una rete (usando ssh).  
*esegue il backup delle partizioni mentre sono montate (è facile quindi automatizzare un backup giornaliero ... non è necessario smontare alcunché).  
*può ripristinare tutto qualora il vostro disco rigido vada allo sfascio e dobbiate comprarne uno nuovo.  
*si adatta (bene con linux, con qualche difficoltà con windows) al backup di grandi reti ed è utilizzato a livello aziendale.  
*è un'applicazione controllabile da linea di comando ed è quindi preziosa per coloro che amano eseguire in modo potente operazioni come backup automatici (per esempio con uno script bash e cron).  
*ricorda e gestisce proprietà e permessi dei file, ma anche link simbolici (e ogni cosa di questo genere), in modo che quando eseguite un ripristino riavrete tutto esattamente come era.

###### Di cosa avrete bisogno

rdiff-backup mantiene un'intera copia (non compressa) dei file dei quali state facendo il backup, e anche una cronologia (backup incrementali), il che significa che lo spazio necessario per il backup deve essere maggiore delle dimensioni dei file: se state eseguendo il backup di 100 GB di dati, potreste avere bisogno di 120 GB di spazio (su un altro disco rigido preferibilmente!).

###### Come configurarlo

Supponiamo che il vostro PC abbia a disposizione:  
* un disco rigido da 100 GB (sda), in uso insieme a sda1 (partizione root), sda5 (dove sono memorizzati musica o altri file) e sda6 (swap).  
* un disco rigido supplementare da 200 GB (sdb) non in uso, con sdb1 montato ... useremo questo per i nostri backup.  
* Indirizzo IP 192.168.0.1

La prima cosa da fare è installare rdiff-backup:

~~~  
# apt-get install rdiff-backup  
~~~

Ora, sebbene possiate fare il backup di qualsiasi directory, presumiamo di voler fare il backup di intere partizioni ... vogliamo fare il backup di sda1 e sda5 (non di sda6), e allora creiamo alcune directory per immagazzinare i dati:

~~~  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/root  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

Avete bisogno di indirizzi IP distinti se volete usare questo stesso computer anche per il backup di un altro (questione affrontata più oltre).

###### Backup

rdiff-backup utilizza la sintassi `rdiff-backup dir_sorgente dir_destinazione` . Nota: specificate sempre nomi di directory, non di file.

Per il backup di sda5, eseguite:

~~~  
# rdiff-backup /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

E per il backup della partizione root, eseguite:

~~~  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
~~~

Ogni errore "AF_UNIX path too long", cioè percorso AF_UNIX troppo lungo, può essere ignorato. L'operazione potrebbe richiedere un po' di tempo, dato che rdiff-backup la prima volta dovrà fare il backup dell'intera partizione (e non solo le differenze). Notate che non ci interessa il backup di /tmp perché il suo contenuto cambia sempre, né quello di /proc o /sys dato che non contengono veri e propri file, e non vogliamo nemmeno il backup dei punti di mount. Se avviaste il backup dei punti di mount, fareste il backup di sdb1 e potreste incappare in un loop infinito! Una soluzione a questo problema è fare il backup dei punti di mount separatamente.

Ora, la ragione per cui inserite '/proc/*' invece di '/proc' è che in questo modo verrà accortamente eseguito il backup del nome della directory /proc, ma verrà ignorato ogni suo contenuto. La stessa cosa vale per /tmp, /sys, e ancor più accortamente per tutti i nomi dei punti di mount.

In questo modo, se distruggete la vostra partizione root ed effettuate un ripristino completo, /tmp, /proc, /sys e i nomi dei punti di mount verranno creati (proprio come dovrebbe essere). Ci potrebbero essere dei problemi se /tmp non è presente durante l'avvio di X (fate riferimento, in proposito, alla pagina man per maggiori informazioni su --exclude e --include).

###### Ripristinare directory dai backup

rdiff-backup utilizza la sintassi:

~~~  
rdiff-backup -r <da_dove> <dir_sorgente> <dir_destinazione>  
~~~

Se per esempio avete cancellato la directory /media/sda7/photos, potrete ripristinarla con:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5/photos /media/sda5/photos  
~~~

L'opzione "-r now" indica di ripristinare dal backup più recente. Se avete effettuato backup completi periodicamente (con crontab, ad esempio), e non vi siete accorti che la directory photos mancava da un po' di tempo, avrete bisogno di effettuare il ripristino da un backup di qualche giorno prima (e non "now", perchè nel backup più recente la directory photos non esiste). Oppure magari volete soltanto ritornare alla versione precedente di qualcosa.

Se volete recuperare qualcosa risalente a tre giorni prima, allora usate l'opzione "-r 3D" ... ma, come dice la pagina man, notate:

`"3D" si riferisce a 72 ore prima dal momento dell'esecuzione, e se non è presente alcun backup risalente a quel momento, rdiff-backup ripristina il backup precedente. Per esempio, nel caso di cui sopra, se viene usato "3D", e ci sono solamente backup di 2 o 4 giorni prima, la directory verrà ripristinata così com'era 4 giorni prima (bisogna tenerlo presente prima di effettuare un ripristino).`

Il seguente comando mostrerà le date e gli orari in cui sono stati effettuati backup di sda5:

~~~  
# rdiff-backup -l /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

##### Recuperare partizioni

Potete recuperare anche intere partizioni: dopotutto, un punto di mount è semplicemente una directory.

**`ATTENZIONE: Non ripristinate la partizione root mentre è in uso! Con un solo comando perdereste tutti i file di tutte le partizioni, inclusi tutti i backup presenti su un disco rigido esterno!! rdiff-backup esegue esattamente le istruzioni: se il backup della partizione root ha punti di mount vuoti, durante il ripristino cancella tutto ciò che si trova nei filesystem montati per ripristinare lo stato del backup.`**

Per recuperare sda5 dal backup più recente, eseguite semplicemente:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5 /media/sda5  
~~~

##### Ripristinare la partizione root

Ripristinare la partizione root non è così semplice. Non ripristinatela mentre è montata (vedi avvertimento sopra). È veramente utile poter ripristinare la partizione root, perché qualora creaste qualche pasticcio durante installazioni o aggiornamenti, o installando un nuovo kernel (etc.), avete la sicurezza di poter rimettere tutto a posto, e vi ci vorranno solo 20 minuti.

Un modo per ripristinare la partizione root è eseguire il boot in una partizione linux libera, se ne avete una sul disco fisso. Potrete quindi recuperare la partizione che volete, perchè non verrà montata come root. Dopo averla recuperata, eseguitevi il boot e sarà esattamente come era al momento del backup! Questo è sicuramente il metodo più semplice.

Un altro modo per recuperare la partizione root è eseguire il boot dal live-CD di siduction e poi il ripristino da lì. rdiff-backup è incluso in siduction, ma qualora la versione del live-CD di siduction in vostro possesso non lo includa, potete digitare in grub (Bootoptions, (Cheatcodes)) il cheatcode, cioè il codice 'trucco', "unionfs": così potrete installare programmi sul live-CD. Basta avviare e utilizzare i seguenti comandi:

~~~  
$ sudo su  
# wget -O /etc/apt/sources.list http://siduction.com/files/misc/sources.list  
# apt-get update  
# apt-get install rdiff-backup  
~~~

###### Ora procediamo con il ripristino:

~~~  
# mount /dev/sda1 /media/sda1  
# mount /dev/sdb1 /media/sdb1  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

Nota: Se non avete un CD di siduction e il vostro Live-CD è supportato da klik, potete installare rdiff-backup attraverso klik:

~~~  
$ sudo ~/.zAppRun ~/Desktop/rdiff-backup_0.13.4-5.cmg rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

Si consiglia a chi esegue il backup della propria partizione root (con l'intenzione di ripristinarla in caso di necessità) di testare il processo di ripristino. Niente di peggio che pensare che tutto andrà bene e poi incappare in un'emergenza inaspettata.

Se il disco rigido è stato cambiato o riformattato, ricontrollate gli UUID (o le Label) in <span class="highlight-3">/boot/grub/menu.lst (grub-legacy)</span> oppure i file in <span>/etc/grub.d (grub2)</span> e `/etc/fstab` , e modificatei di conseguenza. Un modo semplice per avere l'informazione per modificare i file menu.lst e fstab, se necessario, come root, è:

~~~  
blkid  
~~~

##### Backup di un altro PC

Se il PC locale può comunicare attraverso ssh con un altro PC, è possibile fare il backup di questo nel PC locale (ovviamente a condizione che quest'ultimo abbia abbastanza spazio libero nel disco rigido). Il server ssh (sshd) deve essere attivo nel PC remoto. L'altro PC non deve obbligatoriamente essere nella vostra LAN, ma può trovarsi ovunque.

Supponiamo che il vostro PC remoto abbia a disposizione:  
1) un disco rigido da 100 GB (sda) in uso, con montati:  
2) sda1 per la partizione root  
3) sda5 per i file temporanei di cui non vogliamo il backup  
4) e sda6 per lo swap  
5) Indirizzo IP 192.168.0.2

Nota: il backup di entrambi i drive da 100 GB di solito non può essere effettuato su un drive da 200 GB utilizzando rdiff-backup (poiché non vi sarebbe spazio per i file incrementali), ma dal momento che non state eseguendo il backup di sda5 sul PC remoto (e dal momento che di solito i dischi rigidi non sono usati al 100% - anche se non conviene contare troppo su questo) potreste calcolare di avere abbastanza spazio. Ogni volta che rdiff-backup effettua un altro backup, vengono creati ancora altri file incrementali e questo richiede sempre più spazio.

Potete ordinare a rdiff-backup di mantenere soltanto i backup risalenti al massimo a un mese prima (il relativo comando è mostrato più avanti), risparmiando spazio rispetto a ordinargli di mantenere dati di interi anni. E naturalmente, se volete mantenere il backup di interi anni dovrete avere sul disco rigido spazio sufficiente per memorizzare interi anni di file incrementali).

La prima cosa che dovete fare è installare rdiff-backup anche sul PC remoto (ogni computer di cui volete il backup, incluso il server backup, deve avere installato rdiff-backup).

Per il backup del PC remoto sul PC locale, eseguite su quest'ultimo (cioè su 192.168.0.1): `Si noti l'uso della coppia di due punti ::` 

~~~  
# mkdir /media/sdb1/rdiff-backups/192.168.0.2/root  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' 192.168.0.2::/ /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Ora, se volete ripristinare una directory sul PC remoto, iniziate il ripristino o sul PC locale o su quello remoto.

Ecco come potreste ripristinare dal PC remoto la directory /usr/local/games sul PC remoto stesso:

~~~  
# rdiff-backup -r now 192.168.0.1::/media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games /usr/local/games  
~~~

Ed ecco come farlo dal PC locale:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games 192.168.0.2::/usr/local/games  
~~~

Usate lo stesso tipo di sintassi per ripristinare la vostra partizione root da un live-CD (quando il PC remoto è stato avviato da live-CD ... vedasi sopra).

##### Automatizzare i backup:

Se state eseguendo il backup di un altro PC sul PC locale, la prima cosa da fare è abilitare il login ssh senza password. **`Notate che si sta parlando di login ssh come root senza password. Si potrebbe fare in modo che solo che i comandi rdiff-backup siano eseguiti, ma questo non rientra negli scopi di questa trattazione. Fate riferimento a questo proposito a  [Configurazione di SSH](samba-it.htm#ssh-s)`** . Presumiamo che nel nostro caso non ci siano problemi di sicurezza e imposteremo quindi nel modo più semplice possibile i login senza password.

Dal PC locale eseguite i seguenti comandi:

~~~  
# [ -f /root/.ssh/id_rsa ] || ssh-keygen -t rsa -f /root/.ssh/id_rsa  
~~~

Premete invio due volte per avere una password vuota. Poi eseguite:

~~~  
# cat /root/.ssh/id_rsa.pub | ssh 192.168.0.2 'mkdir -p /root/.ssh;\<!--dunno if this is wrong-->  
> cat - >>/root/.ssh/authorized_keys2'  
~~~

Vi verrà richiesta la password di root.

Ora potrete controllare il PC remoto come root attraverso ssh senza dover inserire una password, e potrete automatizzare rdiff-backup.

Create quindi uno script bash che contenga tutti i comandi di rdiff-backup. Il nostro script bash potrebbe essere qualcosa del genere:

~~~  
#!/bin/bash  
RDIFF=/usr/bin/rdiff-backup  
echo  
echo "=======Backing up 192.168.0.1 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
echo "(and purge increments older than 1 month)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/root  
echo  
echo "=======Backing up 192.168.0.1 mount sda5======="  
${RDIFF} --ssh-no-compression --exclude /media/sda5/myjunk /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo "(and purge increments older than 1 months)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo  
echo "=======Backing up 192.168.0.2 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' --exclude '/mnt/*/*' 192.168.0.2::/media/sdb1/rdiff-backups/192.168.0.2/root  
echo "(and purge increments older than 1 months)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Ora potete salvare questo script bash come "myrdiff-backups.bash", metterlo in /usr/local/bin sulla nostra macchina locale (server backup) e impostarlo come eseguibile. Eseguite lo script bash e assicuratevi che funzioni.

E infine potete far sì che cron lo esegua ogni sera alle 20:0. La linea seguente inserita nel crontab di root servirà allo scopo:

~~~  
# crontab -e  
e inserite  
0 20 * * * /usr/local/bin/myrdiff-backups.bash  
~~~

<div id="rev">Content last revised 30/04/2012 2054 UTC</div>
