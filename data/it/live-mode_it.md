<div id="main-page"></div>
<div class="divider" id="rootpw"></div>
## siduction-*.iso - Password di root nella modalità liveCD

<p class='highlight-2'>Tenete ben presente che ogni qual volta eseguite qualcosa con i permessi di root dovete avere chiaro che cosa state facendo! Per navigare in internet non è richiesto l'accesso come root.</p>
### Password predefinita per siduction-*.iso

Nel liveCD di siduction non è impostata alcuna password di root. Se volete avviare un programma che richiede privilegi di root avete numerose scelte:

Metodo semplice, scrivete soltanto:

~~~  
sux  
~~~

###### Per impostare una (temporanea) password di root

Aprite una console/shell:

~~~  
siduction@0[siduction]$ sudo passwd  
Enter new UNIX password (immettete la nuova password UNIX):  
Retype new UNIX password (ridigitate la nuova password UNIX):  
passwd: password updated successfully (password aggiornata con successo)  
siduction@0[siduction]$  
~~~

Ora potrete usare questa password per il resto della sessione live di siduction.

`sudo non è preconfigurato nelle installazoni su hard disk. Vi raccomandiamo di usare il vero account di root: vedasi, in proposito,`  [sudo](term-konsole-it.htm#sudo)  e  [sux](term-konsole-it.htm#sux) .

###### Avviare un programma da una console di root

Digitando `sux`  diventerete root con privilegi anche per le applicazioni richiedenti X.

Aprite una console/shell:

~~~  
siduction@0[siduction]$ sux  
root@0[siduction]# gparted  *(o quello che si vuole...)*   
~~~

Altra opzione generica valida per tutti i principali Desktop Manager è:

~~~  
Alt+F2 su-to-root -X -c <applicazione>  
~~~

Per esempio:

~~~  
Alt+F2 su-to-root -X -c gparted  
~~~

`Per uscire dalla condizione di root digitate nella console:`

~~~  
exit  
~~~

oppure, più semplicemente, cliccate nell'angolo in alto a destra della finestra per chiudere la console.

**`Nel caso di un blocco di un siduction-*.iso dovrete fare le azioni seguenti e seguire le indicazioni per impostare una password:`** 

~~~  
alt+ctrl+F1  
sudo passwd  
~~~

Non appena la password è attiva, eseguite:

~~~  
alt+ctrl+F7  
~~~

<div class="divider" id="live-cd-installsoft"></div>
## Installare un software durante una sessione liveCD

~~~  
apt-get update  
apt-get install nome-del-pacchetto  
~~~

Nota: quando uscirete dalla sessione liveCD, nessuna delle modifiche apportate verrà mantenuta, a meno che non si abilitino  [fromiso e persist](hd-install-opts-it.htm#fromiso-persist) .

<div id="rev">Content last revised 15/03/2012 1245 UTC</div>
