<div id="main-page"></div>
<div class="divider" id="live-cd-upgrade"></div>
## Aggiornare tramite Live-CD

Una funzione per aggiornare mediante un "live-CD" un'installazione di siduction non esiste. Prima di procedere all'installazione di siduction **`SALVATE I VOSTRI DATI! inclusi i segnalibri e la posta`** .

`È altamente raccomandato tenere i dati in una partizione separata. I benefici in termini di recupero dopo alterazioni disastrose del sistema e di stabilità dei dati è incommensurabile.`

In questo modo la vostra $HOME diventa un posto dove vengono conservate le configurazioni delle applicazioni basilari. O, per dirla in altro modo, un contenitore dove le applicazioni possano immagazzinare le proprie impostazioni.

**`SALVATE SEMPRE I VOSTRI DATI inclusi i segnalibri e la posta!`**

<div class="divider" id="hd-upgrade"></div>
## Aggiornamento di un'installazione su disco fisso - Dist-Upgrade

L'aggiornamento di un sistema installato è ottenuto mediante "dist-upgrade", cioè con aggiornamento dell'intera distribuzione, in modo da esser sicuri di avere da quel momento in poi le ultime versioni dei pacchetti e gli aggiornamenti di sicurezza. È estrememente importante controllare prima quali pacchetti verranno aggiornati.

In siduction la procedura si chiama 'dist-upgrade' e viene fatta tramite rete.

` **L'unico metodo supportato di dist-upgrade è il seguente:** `

<div class="box block">
**MAI E POI MAI fate un dist-upgrade o anche un upgrade mentre siete in X.<div class="highlight-4"> Controllate sempre i "Current Warnings" sul sito principale di  [siduction](http://siduction.com) . Questi avvisi sono lì per una precisa ragione: la natura instabile e gli aggiornamenti su base giornaliera.**

~~~  
## chiudere la sessione KDE.  
## andare in motalità testo con Ctrl+Alt+F1  
## autenticarsi come root, poi:  
init 3  
apt-get update  
apt-get dist-upgrade  
apt-get clean  
init 5 && exit  
~~~

**MAI E POI MAI fate DIST-UPGRADE (o UPGRADE) con adept o synaptic.  [Leggete "Aggiornamento di un sistema installato".](sys-admin-apt-it.htm#apt-upgrade)**


---

#### Ragioni per usare apt-get per il dist-upgrade

I gestori di pacchetti come adept, synaptic e kpackage non sono sempre in grado di tenere conto della grande mole di variazioni che hanno luogo in sid (cambi di dipendenze, di nome, di script dei manutentori, ...). Ciò non è colpa degli sviluppatori di questi strumenti, che scrivono strumenti eccellenti e favolosi per la branca stabile di debian. Il fatto è che che questi semplicemente non sono adatti alle speciali esigenze di debian sid.

Usate dunque quello che volete per cercare un pacchetto, ma tenetevi ben saldi ad apt-get per installare/rimuovere/fare dist-upgrade.

I gestori di pacchetti come adept, synaptic e kpackage sono come minimo, non-deterministici (per una selezione complessa di pacchetti): combinate questo fatto con un bersaglio in rapido movimento come debian sid e, anche peggio, con l'uso di depositi sofware esterni di discutibile qualità (che noi non raccomandiamo ma che sono una realtà sui sistemi degli utenti) e sarete sull'orlo del disastro. Altra cosa da notare è che tutti questi tipi di gestori grafici di pacchetti funzionano in init 5 e/o in X: facendo un dist-upgrade in init 5 e/o X (o anche un non raccomandabile "upgrade") finirete con produrre un danno irreparabile al vostro sistema, forse non oggi o domani, ma sarete comunque in tempo a vederlo.

apt-get invece fa strettamente ciò che gli si chiede: se c'è un qualsiasi danno potete definirlo con esattezza e fare il debug o ripararne la causa. E se volesse rimuovere mezzo sistema (a causa di transizioni di librerie) è il momento di invocare l'amministratore affinché venga a dare una seria occhiata al tutto.

È questa la ragione per cui le derivate di debian usano apt-get e non gli altri gestori di pacchetti.

<div id="rev">Page last revised 03/05/2012 0919 UTC</div>
