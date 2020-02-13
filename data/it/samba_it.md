<div id="main-page"></div>
<div class="divider" id="configure"></div>
## Configurare siduction per usare condivisioni SAMBA (Windows) con macchine remote

Eseguite tutti i comandi come  **root**  (in un terminale o una console). Mettete gli URL in Dolphin (eseguitelo come utente normale).

` - server = nome_server o indirizzo IP della macchina Windows  
`- share = nome della cartella condivisa` `

In KDE - Dolphin mettete come URL `smb://server`  o l'URL completo `smb://server/share` 

In una console potrete vedere le condivisioni localizzate su un dato server con:

~~~  
smbclient -L nome_server  
~~~

Per montare una condivisione in una cartella (con pieno accesso per TUTTI gli utenti) ricordate che il punto di mount, cioè la cartella dove verrà visualizzata la condivisione, deve esistere già. Altrimenti dovrete crearla prima (il nome è arbitrario):

~~~  
mkdir -p /mnt/server_share  
~~~

Poi montate la condivisione con un filesystem remoto VFAT:

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777 //server/share /mnt/server_share  
~~~

o con un filesystem remoto NTFS :

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777,lfs //server/share /mnt/server_share  
~~~

Per chiudere la connessione, smontatela con:

~~~  
umount /mnt/server_share  
~~~

Se volete mettere una voce in  */etc/fstab*  per facilitare la procedura, inseritevi la seguente stringa:

~~~  
//server/share /mnt/server_share cifs defaults,username=your_username,password=**********,file_mode=0777,dir_mode=0777 0 0  
~~~

<div class="divider" id="setup"></div>
## Come impostare siduction come server Samba

Poiché samba non è preinstallato, dovrete procedere così per avervi accesso:

~~~  
sux  
apt-get update  
apt-get install samba samba-tools smbclient smbfs samba-common-bin  
~~~

#### Installazione su disco fisso:

##### Esempio 1:

In caso di installazione du disco fisso è necessario adattare la configurazione di Samba. Ecco un semplice esempio. Se volete saperne di più sull'uso di Samba e sulle impostazioni di un Server Samba Linux  [è consigliabile leggere la Documentazione Samba.](http://us5.samba.org/samba/) 

Per adattare la configurazione di Samba procedete come segue:

Aprite il file `/etc/samba/smb.conf`  in un elaboratore di testo (come kedit o kwrite) e scrivete:

~~~  
# Variazioni globali- Proposta "tutto semplice" per quanto possibile -  
# nessuna password, comportamento come in Windows 9x  
[global]  
security = share  
workgroup = WORKGROUP  
# Condivisione senza permessi di scrittura -importante se i filesystem condivisi sono NTFS!  
[WINDOWS]  
comment = Windows Partition  
browseable = yes  
writable = no  
path = /media/sda1 # <-- correggete 'sda1' mettendo la vostra partizione  
public = yes  
# Condivisione di partizione con permessi di scrittura - la partizione deve essere montata  
# in modalità scrivibile - ha senso con FAT32, ad esempio.  
[DATA]  
comment = Data Partition (first extended Partition)  
browseable = yes  
writable = yes  
path = /media/sda5  
public = yes  
~~~

Riavviate il server Samba

~~~  
/etc/init.d/samba restart  
~~~

#### Esempio 2:

~~~  
groupadd smbuser  
useradd -g smbuser <utente-voluto>  
smbpasswd -a <utente-voluto>  
smbpasswd -e <utente-voluto>  
~~~

Quindi modificate `/etc/samba/smb.conf`  per dare i permessi di condivisione (fate attenzione a quali directory abilitate), per esempio:

~~~  
[homes]  
comment = Home Directories  
browseable = yes.  
writeable = yes  
[media, attenzione!]  
path = /media  
browseable = yes  
read only = no  
#read only = yes  
guest ok = no  
writeable = yes  
[video]  
path = /var/lib/video  
browseable = yes  
#read only = no  
read only = yes  
guest ok = no  
#qualsiasi altra directory che volete condividere con Windows/Linux/Mac  
#path = path = /media/xxxx/xxxx  
#browseable = yes  
#read only = no  
#read only = yes  
#guest ok = no  
~~~

Riavviate il server Samba

~~~  
/etc/init.d/samba restart  
~~~

## Controllare le condivisioni in samba

Per impostare le condivisioni in samba lasciando perdere le questioni sulla sicurezza, eseguite i seguenti comandi (ad esempio per una impostazione su rete LAN):

Impostate le cartelle e i file contenuti, con almeno i seguenti permessi: -rwxr-xr-x:

~~~  
ls -la percorso_verso_/nome_cartella_condivisa/*  
~~~

Altrimenti eseguite:

~~~  
chmod -R 755 percorso_verso_/nome_cartella_condivisa  
~~~

Se volete abilitarla in scrittura:

~~~  
chmod -R 777 percorso_verso_/nome_cartella_condivisa  
~~~

Un modo per assicurarvi che la condivisione stia funzionando (non dimenticate di avviare il server):

~~~  
smbclient -L localhost  
~~~

Dovreste vedere qualcosa del tipo:

~~~  
smbclient -L localhost  
Password:  
Domain=[HOME] OS=[Unix] Server=[Samba 3.0.26a]  
Sharename Type Comment  
--------- ---- -------  
IPC$ IPC IPC Service (3.0.26a)  
MaShare Disk comment  
print$ Disk Printer Drivers  
Domain=[MSHOME] OS=[Unix] Server=[Samba 3.0.26a]  
~~~

Se non avete impostato una password, premete semplicemente INVIO

Non dimenticate di salvare. Potete ora avviare/fermare samba con:

~~~  
/etc/init.d/samba start  
~~~

e:

~~~  
/etc/init.d/samba stop  
~~~

Potete anche far avviare/fermare samba automaticamente all'avvio. Eseguite questa chiamata:

~~~  
update-rc.d samba defaults  
~~~

Ora samba si avvierà assieme al sistema e si fermerà al suo spegnimento.

 [Ulteriori informazioni su samba a questo collegamento.](http://wiki.linuxquestions.org/wiki/Samba) 

<div id="rev">Page last revised 19/04/2012 1730 UTC</div>
