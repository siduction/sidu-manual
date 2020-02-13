<div id="main-page"></div>
<div class="divider" id="ssh"></div>
## SSH

Nel mondo dei computer, Secure Shell (SSH) è un insieme di standard con associato un protocollo di rete che permette di stabilire un canale sicuro tra un computer locale e uno remoto. Usa una crittografia a chiave pubblica per autenticare il computer remoto e (opzionalmente) permettergli di autenticare l'utente. SSH fornisce confidenzialità e integrità allo scambio dei dati tra due computer usando la crittografia e i codici di autenticazione dei messaggi (MAC). SSH è usato tipicamente per autenticarsi presso una macchina remota ed eseguire comandi, ma supporta anche il tunneling (cioè la creazione di un tunnel cifrato diretto al computer esterno), il reindirizzamento arbitrario di porte TCP e connessioni X11; può trasferire i file usando i protocolli SFTP o SCP associati. Un server SSH ascolta, in via predefinita, sulla porta TCP standard numero 22.  [fonte Wikipedia](http://it.wikipedia.org/wiki/Secure_Shell) 

<div class="divider" id="ssh-s"></div>
## Abilitare validi protocolli di sicurezza per SSH

Permettere un accesso root, via ssh, non è atto sicuro. Non vogliamo che, in via predefinita, utenti root entrino in ssh; debian dovrebbe essere sicura, non insicura, nè vogliamo concedere agli utenti 10 minuti per fare un rapido attacco al nostro accesso ssh con un dizionario di password. Quindi sta a voi limitare il tempo e i tentativi di accesso!

Per aiutare a rendere più sicuro il sistema ssh, lanciate semplicemente con privilegi di root un elaboratore di testo e aprite il file:

~~~  
/etc/ssh/sshd_config  
~~~

Poi localizzate e cambiate i punti potenzialmente pericolosi.

###### Punti pericolosi da localizzare sono:

`Port <porta_desiderata>:`  Questo valore deve essere impostato sulla porta corretta che si sta reindirizzando dal router. Naturalmente anche sul router deve essere impostato il 'Port forwarding', cioè il reindirizzamento del traffico. Se non si sa come farlo forse non si dovrebbe usare ssh da remoto. Debian assegna in modo predefinito la porta 22, ma è raccomandato usare una porta al di fuori della normale gamma di scansione. Supponendo di usare la porta 5874, il valore da assegnare al comando 'port' diventa:

~~~  
Port 5874  
~~~

`ListenAddress <ip_della_macchina_o_della_interfaccia_di_rete >:`  Ora, naturalmente, poiché state reindirizzando una porta dal router, c'è bisogno che la macchina abbia un indirizzo statico sulla rete, a meno che non usiate un server dns localmente (ma se state facendo qualcosa di complicato e vi servono queste direttive probabilmente state per fare un grosso pasticcio). Così supponiamo che questo indirizzo sia:

~~~  
ListenAddress 192.168.2.134  
~~~

Poi, il Protocol 2 è nei predefiniti di debian, ma controllate per essere sicuri con:

`LoginGraceTime <tempo in secondi per l'accesso>:`  Questa voce ha un tempo assurdo predefinito di 600 secondi, e non vi ci vogliono certo 10 minuti per scrivere il nome utente e la parola chiave. Rendiamo quindi più sicura la voce impostando:

~~~  
LoginGraceTime 45  
~~~

Ora avrete 45 secondi per autenticarvi e gli hackers non avranno 600 secondi ogni volta per tentare di scoprire la vostra parola chiave.

`PermitRootLogin <yes>:`  Per qual motivo debian imposti PermitRootLogin a 'sì' è incomprensibile: impostiamo quindi 'no'.

~~~  
PermitRootLogin no  
~~~

~~~  
StrictModes yes  
~~~

`MaxAuthTries <xxx>:`  Numero di tentativi per l'autenticazione dell'accesso; impostate 3 o 4 tentativi ma non di più.

~~~  
MaxAuthTries 3  
~~~

Potreste aver bisogno di aggiungere alcune di queste voci se non già presenti:

~~~  
AllowUsers <nome degli utenti con spazi consentiti per accedere via ssh>  
~~~

`AllowUsers <xxx>:`  Permettete a un unico utente ssh senza diritti di root di usare adduser per aggiungere l'utente e impostarne il nome:

~~~  
AllowUsers chiunque_sia  
~~~

`PermitEmptyPasswords <xxx>:`  Assegnate a quell'utente una lunga e simpatica parola chiave impossibile da indovinare anche in un milione di anni, la sola che permette l'accesso. Una volta entrati, potete usare "su" per diventare root:

~~~  
PermitEmptyPasswords no  
~~~

`PasswordAuthentication <xxx>:`  Ovviamente, per l'accesso con password, non per l'accesso con chiave, avete bisogno di una password forte, e, a meno di usare chiavi, serve che quanto segue sia impostato sul 'sì':

~~~  
PasswordAuthentication yes [a meno di usare chiavi]  
~~~

Infine:

~~~  
/etc/init.d/ssh restart  
~~~

Ora avete a disposizione un ssh più sicuro, non completamente sicuro ma migliore, inclusa la creazione di un utente unico ssh con adduser.

`Nota:` span> Se ricevete un messaggio di errore e ssh rifiuta di connettervi, andate nella $HOME e cercate una cartella nascosta chiamata `.ssh` span>, cancellate il file `known_hosts` span>, quindi riprovate. Questo errore si presenta principalmente quando avete impostato dinamicamente gli indirizzi IP (DCHP)

<div class="divider" id="ssh-x"></div>
## Uso di applicazioni X Window via rete mediante SSH

ssh -X vi permette di autenticarvi in un computer remoto e di ottenere la visualizzazione della sua interfaccia grafica nel vostro PC locale. Come $utente scrivete (la X deve essere maiuscola!):

~~~  
$ ssh -X nome_utente@xxx.xxx.xxx.xxx (indirizzo IP)  
~~~

Inserite la password per il nome utente nel computer remoto e avviate l'applicazione X nella shell:

~~~  
$ iceweasel OPPURE oocalc OPPURE oowriter OPPURE kspread  
~~~

Alcune connessioni di rete del PC veramente lente possono beneficiare di un livello di compressione che aiuti a velocizzare i trasferimenti; aggiungete quindi un'opzione extra (la quale, peraltro, sulle connessioni veloci ha l'effetto opposto):

~~~  
$ ssh -C -X nome_utente@xxx.xxx.xxx.xxx  
~~~

Leggete la pagina del manuale:

~~~  
man ssh  
~~~

`Nota:` span> Se ricevete un messaggio di errore e ssh rifiuta di connettervi, fate come più sopra detto.

<div class="divider" id="ssh-scp"></div>
## Copiare file e directory in remoto con ssh ed scp

scp utilizza la linea di comando (terminale / cli) per copiare file tra utenti in una rete. Utilizza l'autenticazione e la sicurezza di ssh per il trasferimento dei dati e pertanto richiederà le password o le passphrase richieste per l'autenticazione.

Assumendo che abbiate i diritti ssh in un PC o server remoti, scp vi permette di copiare partizioni, directory o file da e in quel PC in una posizione specifica o in una destinazione a scelta per la quale si abbiano i permessi per abilitare un trasferimento di dati a un disco USB connesso al vostro PC. Per esempio, potrebbe trattarsi di un PC o un server di cui si hanno i permessi di accesso nella LAN (o in qualunque altro posto al mondo). 

Potete copiare ricorsivamente intere partizioni e directory con l'opzione `scp -r` . Notate che scp -r segue i collegamenti simbolici trovati nell'albero delle directory.

### Esempi:

`Esempio 1:`  Copia una partizione:

~~~  
scp -r <nome_utente>@xxx.xxx.x.xxx:/media/disk1part6/ /media/diskXpartX/  
~~~

`Esempio 2:`  Copia una directory in una partizione, in questo caso la directory si chiama photos nella $HOME:

~~~  
scp -r <nome_utente>@xxx.xxx.x.xxx:~/photos/ /media/diskXpartX/xx  
~~~

`Esempio 3:`  Copia un file da una directory in una partizione, in questo caso un file nella $HOME:

~~~  
scp <nome_utente>@xxx.xxx.x.xxx:~/filename.txt /media/diskXpartX/xx  
~~~

`Esempio 4:`  Copia un file in una partizione:

~~~  
scp <nome_utente>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt /media/diskXpartX/xx  
~~~

`Esempio 5:`  Se vi trovate già nel drive/directory nel quale intendete copiare una directory o un file, utilizzate un '**` **.** `** ' (punto) :

~~~  
scp -r <nome_utente>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt.** `**   
~~~

`Esempio 6:`  Per copiare file dal proprio PC/server in un altro (utilizzate `scp -r`  se si sta copiando una partizione o una directory):

~~~  
scp /media/disk1part6/filename.txt <nome_utente>@xxx.xxx.x.xxx:/media/diskXpartX/xx  
~~~

Leggete:

~~~  
man scp  
~~~

<div class="divider" id="ssh-w"></div>
## Accesso remoto ssh con reindirizzamento di X da un PC-Windows:

* Scaricate e masterizzate il  [XLiveCD Cygwin](http://xlivecd.indiana.edu/)   
* Mettete il CD nel lettore CD-ROM del PC con Windows e aspettate che si avvii.  
Premete "continua" fino all'avvio di una finestra di shell e immettete:

~~~  
ssh -X nome_utente@xxx.xxx.xxx.xxx  
~~~

Notate: xxx.xxx.xxx.xxx è l'indirizzo IP del computer remoto linux o il suo URL (per esempio un URL di dyndns.org), mentre il "nome_utente" è naturalmente quello di un utente che esiste sul computer remoto. Dopo l'accesso, avviate "kmail", per esempio, e controllate la vostra posta!

Importante: assicuratevi che il file host.allow abbia una voce che permetta l'accesso da PC che sono situati su altre reti. Se siete dietro un Firewall-NAT o un router assicuratevi che la porta 22 sia 'forwarded', cioè reindirizzata alla vostra macchina linux.

<div class="divider" id="ssh-f"></div>
## SSH con Dolphin

Dolphin e Krusader sono entrambi in grado di accedere a dati remoti usando `sftp://`  e entrambi usano il protocollo ssh.

Ecco come funziona:  
1) Aprite una nuova finestra di Dolphin  
2) Immettete nella barra degli indirizzi: `sftp://nome_utente@ssh-server.com` 

Esempio 1: 

~~~  
sftp://siduction1@hostname_remoto_o_IP  
(Nota: Comparirà una finestra chiedendovi la vostra password ssh: digitatela e premete OK)  
~~~

Esempio 2: 

~~~  
sftp://nome_utente:password@hostname_remoto_o_IP  
(In questo modo NON  vedrete la finestra con richiesta di password ma verrete direttamente connessi).  
~~~

Per un sistema di rete LAN:

~~~  
sftp://nome_utente@10.x.x.x or 198.x.x.x  
(Note: Comparirà la finestra di richiesta della password ssh: digitatela e premete OK)  
~~~

La connessione SSH a interfaccia grafica di Dolphin ora è inizializzata. Con questa finestra di Dolphin potete lavorare con i file (copy/view) sul server SSH come se fossero in una cartella della vostra macchina locale.

`NOTA: Se avete impostato una porta ssh diversa dalla 22, quella predefinita, dovete specificarne il numero sì che i programmi sftp possano usarla:`

~~~  
sftp://nome_utente@ip:port  
~~~

'nome_utente@ip:port' è la sintassi standard per molti programmi come sftp e smb.

<div class="divider" id="ssh-fs"></div>
## SSHFS - Montare filesystem da remoto

SSHFS è un metodo facile, veloce e sicuro che usa FUSE per montare un filesystem remoto. L'unica richiesta per il lato server è un daemon ssh in esecuzione.

Sul lato client dovrete probabilmente installare sshfs: `installare fuse e groups non è necessario su siduction dalla versione 2011.1 in poi poichè sono installati per default:` 

Comunque, per installare sshfs: 

~~~  
apt-get update && apt-get install sshfs  
~~~

`Ora dovete uscire e autenticarvi nuovamente`

Montare un filesystem remoto è molto facile:

~~~  
sshfs nome_utente@hostname_remoto:cartella_del_punto_di_mount_locale  
~~~

Se non è specificata nessuna cartella verrà montata la cartella "home" dell'utente remoto.`Attenzione: il carattere due punti (**` **:**`**  ) è essenziale anche se non viene poi digitato alcun nome di cartella!` 

Le cartelle remote, una volta montate, si comportano come qualsiasi altra cartella del filesystem locale: potete sfogliarne i file, modificarli ed eseguire script su di essi, proprio come fareste su un filesystem locale.

Se volete smontare l'host remoto usate il comando:

~~~  
fusermount -u nome_del_punto_di_mount_locale  
~~~

Se usate sshfs frequentemente, buona scelta è aggiungere una voce specifica in fstab:

~~~  
sshfs#nome_utente@hostname_remoto://directory_remota /mount_point_locale fuse user,allow_other,uid=1000,gid=1000,noauto,fsname=sshfs#nome_utente@hostname_remoto://directory_remota 0 0  
~~~

Poi decommentate `user_allow_other`  in `/etc/fuse.conf` :

~~~  
# Allow non-root users to specify the 'allow_other' or 'allow_root'  
# mount options.  
#  
user_allow_other  
~~~

Ciò permetterà a ogni utente appartenente al gruppo "fuse" di montare il filesystem usando il ben noto comando mount:

~~~  
mount /percorso/del/punto/di/mount  
~~~

Con quella stringa nel vostro fstab potete naturalmente usare anche il comando umount per smontare il filesystem:

~~~  
umount /percorso/del/punto/di/mount  
~~~

Per controllare se appartenete o no al gruppo "fuse" usate il comando:

~~~  
cat /etc/group | grep fuse  
~~~

Dovreste vedere qualcosa come:

~~~  
fuse:x:117: <nome_utente>  
~~~

Se il vostro nome utente "username" non appare, usate il comando adduser come root:

~~~  
adduser <vostro_nome_utente> fuse  
~~~

Ora il vostro nome utente dovrebbe venire elencato e dovreste essere in grado di eseguire il comando:

`Nota: Lo "id" non viene elencato nel gruppo "fuse" finchè non siete usciti e rientrati di nuovo`

~~~  
mount punto_di_mount_locale  
~~~

e

~~~  
umount punto_di_mount_locale  
~~~

<div id="rev">Content last revised 21/04/2012 1830 UTC</div>
