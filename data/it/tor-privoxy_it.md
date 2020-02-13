<div id="main-page"></div>
<div class="divider" id="privoxy"></div>
## Privoxy

Privoxy è un proxy web dotato di capacità avanzate di filtraggio per la protezione della privacy, le modifiche ai dati nelle pagine web, la gestione dei cookies, il controllo degli accessi e la rimozione di annunci, striscioni, pop-up e altra odiosa spazzatura Internet. Ha una configurazione molto flessibile e può essere personalizzato per adattarsi a necessità e gusti individuali. Trova applicazione sia per sistemi singoli che in reti multiutente. È basato su Internet Junkbuster (tm).

Per installare privoxy:

~~~  
apt-get update  
apt-get install privoxy  
~~~

Un'installazione standard dovrebbe fornire un punto ragionevole di partenza per i più. Vi saranno sicuramente casi nei quali vorrete modificare la configurazione, ma questo problema si pone per lo più man mano che crescono le necessità: nella maggior parte dei casi inizialmente è richiesta poca o nessuna configurazione.

<!--Per usare privoxy con il meta-installer di siduction  [fare riferimento qui](sys-admin-meta-it.htm#meta-proxy) .

-->
Nella configurazione di privoxy potreste dover togliere il commento alle linee in funzione della vostre preferenze: questa perciò sarà differente per ogni utente.

 [Il manuale completo per l'utente di Privoxy con argomenti avanzati di configurazione si trova qui.](http://www.privoxy.org/user-manual/index.html) 

<div class="divider" id="tor"></div>
## Tor

Tor è una rete di tunnels virtuali che permette ai singoli o a gruppi di utenti di migliorare la loro privacy e sicurezza su Internet. Permette anche agli sviluppatori di sofware di creare nuovi strumenti di comunicazione con funzionalità integrate di privacy. Tor fornisce la base per una gamma di applicazioni che consente alle organizzazioni ed ai singoli di condividere le informazioni su una rete pubblica senza comprometterne la riservatezza.

Per installare Tor:

~~~  
apt-get update  
apt-get install tor  
~~~

Il file di default torrc dovrebbe funzionare in prima battuta per la maggior parte degli utenti di Tor. Dovrete però configurare Privoxy per usare Tor in Internet:  [Tor e la navigazione in Internet](https://www.torproject.org/docs/tor-doc-unix#privoxy) .

Dovrete inoltre essere consapevoli del fatto che la velocità del collegamento Internet sarà modificata negativamente.

<!--Per il browser Iceweasel c'è un componente aggiuntivo disponibile:  [Torbutton](https://addons.mozilla.org/en-US/firefox/addon/2275) .

-->
 [La documentazione di Tor](https://www.torproject.org/documentation.html.en)  comprende tutti gli aspetti del suo funzionamento.

Vidalia è un'interfaccia grafica per il software Tor e permette di avviarlo e fermarlo, vederne lo stato a colpo d'occhio e monitorarne l'uso della banda.

~~~  
apt-get update  
apt-get install vidalia  
~~~

 [Homepage di Vidalia](http://www.vidalia-project.net)  

<div id="rev">Content last revised 02/05/2012 1232 UTC</div>
