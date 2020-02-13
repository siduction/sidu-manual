<div id="main-page"></div>
<div class="divider" id="approx"></div>
## dist-upgrade dei PC laddove il binomio banda/velocità costituisce un problema

Per gli utenti che possiedono più di 1 PC, o hanno più di 1 PC e restrizioni di banda, o vogliono avere 1 PC aggiornato quando sono in atto restrizioni in velocità dell'ISP e/o restrizioni di banda, vi sono soluzioni per aiutare a mantenere i PC in uno stato "aggiornato", siano essi in una LAN permanente o temporanea.

La soluzione consiste nell'utilizzare un archivio mirror locale in uno dei PC al quale gli altri PC della LAN possano accedere per il dist-upgrade, conservando così l'uso della banda per le operazioni giornaliere più importanti.

### Prerequisiti

Assicuratevi di avere a disposizione 6 GB di spazio libero per la cache.

## Utilizzare approx come archivio mirror locale

Quando il PC client chiede dei file gli verranno forniti quelli presenti nella cache, ammesso che abbiate lanciato `apt-get update` , `dist-upgrade -d`  o `dist-upgrade`  nel PC che ospita un `server approx` .

#### Passo 1: Configurare il Server per i Client che vogliono usare approx

~~~  
apt-get install approx  
~~~

~~~  
mcedit /etc/approx/approx.conf  
~~~

Abilitate il file `approx.conf`  a utilizzare i mirror online:

~~~  
# Ecco alcuni esempi di mappatura dei depositi remoti.  
# Si veda http://www.debian.org/mirror/list per i siti mirror.  
debian http://ftp.iinet.net.au/debian/ `<< cambiatelo con il vostro mirror debian locale, ad esempio http://mi.mirror.garr.it/mirrors/debian/`   
siduction http://siduction.net/debian/  
~~~

`Applicate lo stesso stile di sintassi ad altri repositori di cui volete avere un mirror locale.` 

Avviate il server approx con:

~~~  
update-inetd --enable approx  
~~~

Se non funziona, riavviate il PC nel quale è installato approx per funzionare come server: approx è ben riconosciuto come difficile da avviare.

Dopo il riavvio eseguite `apt-get update`  e `dist-upgrade`  o `dist-upgrade -d` . Questo per assicurarvi che approx possa accedere agli ultimi pacchetti per i vostri PC client a meno che vi siano pacchetti installati localmente nei PC client non presenti sul server. In questo caso approx cercherà di ottenere i pacchetti appropriati.

I pacchetti si accumulano in `/var/cache/approx`  che viene popolata dopo il primo avvio dei client.

#### Passo 2: Configurare i Client per utilizzare il Server approx

Primo: modificate i file `/etc/apt/sources.list.d/*.list`  in modo che sia possibile utilizzare approx come mirror debian e siduction.

<!--###### This para is most likely complete and utter rubbish, but put here as a reminder maybe better adding an approx.list and renaming the debian and siduction .lists 

<p></p>-->
Con mcedit, commentate gli indirizzi dei vostri collegamenti diretti (mettetegli un `#`  davanti), aggiungete le linee seguenti e salvate i cambiamenti, per esempio:

###### Lista delle sorgenti debian

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

~~~  
#deb your current debian mirror  
deb http://approx:9999/debian/ sid main contrib non-free  
~~~

###### Lista delle sorgenti siduction

~~~  
mcedit /etc/apt/sources.list.d/siduction.list  
~~~

~~~  
#deb your current siduction mirror  
deb http://approx:9999/siduction/ sid main fixes  
~~~

###### Altre liste di sorgenti

Applicate lo stesso stile di sintassi in maniera che rispecchi altri file sources.list.

###### Proxy Host

Quindi modificate `/etc/hosts`  aggiungendovi il proxy locale per accedere all'indirizzo IP del vostro server:

~~~  
mcedit /etc/hosts  
~~~

~~~  
10.1.1.X approx  
~~~

Adesso eseguite `apt-get update`  e `dist-upgrade`  o `dist-upgrade -d` . La prima esecuzione in ognuno dei PC client sarà lenta e potrebbe dare errore di timeout (cioè di "fuori tempo massimo"), quindi provate di nuovo. Le esecuzioni successive dovrebbero fornirvi le migliorie a lungo termine che state cercando.

<div id="rev">Content last revised 24/04/2012 0758 UTC/div>
