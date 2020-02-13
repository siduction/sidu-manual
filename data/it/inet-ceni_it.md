<div id="main-page"></div>
<div class="divider" id="netcardconfig"></div>
## Andare online / Come configurare la rete con lo script "Ceni"

`Probabilmente avrete bisogno di firmware non-free da installare sul sistema operativo, memorizzato su una chiavetta USB. Fate riferimento a  [non-free firmware .deb su una chiavetta](nf-firm-it.htm#non-free-firmware) .` 

Se avete un server DHCP nella LAN e il computer è connesso ad esso quando si avvia, le impostazioni di rete dovrebbero essere configurate automaticamente. Altrimenti dovrete avviare `Ceni` . Andate su `Kmenu > Internet > Ceni` : si aprirà una finestra di terminale/console e vi verrà chiesta la password di root (sul liveCD non è impostata nessuna password, basta premere invio).

Il modo più rapido per accedere a Ceni è aprire un terminale/console e digitare:

~~~  
ceni  
~~~

Vi verrà a questo punto chiesta la password di root.

![Ceni Network Interfaces](../images-common/images-netcard/Ceni-interface-selection-01.png "Ceni Network Interfaces") 

![Ceni Network Settings](../images-common/images-netcard/Ceni-static-network-configuration-02.png "Ceni Network Settings") 


---

`Uno dei punti di forza di Ceni è la sua capacità di configurare "al volo" le schede di rete wireless. Un'alternativa si può trovare qui:  [WiFi - guida base per il setup](inet-wpa-it.htm#wpa-basic) :`

![Ceni Wireless Settings](../images-common/images-netcard/Ceni-wireless-network-selection-02.png "Ceni Wireless Settings") 

![Scan or Roam](../images-common/images-netcard/Ceni-wireless-network-configuration-01.png "Ceni Scan or Roam") 

<div class="divider" id="dial-mod"></div>
## Connessione con un modem 56k

KDE ha un programma grafico per interagire con i modem dial-up, `KPPP - strumento di connessione dial-up a internet` , che si trova nel menù principale sotto la voce Internet.

Il programma ha un manuale di aiuto interno che fornisce una completa guida all'impostazione del modem per permettere la connessione.

<div class="divider" id="firewalls"></div>
## Firewall

Un Firewall non è normalmente necessario se si dispone di un router propriamente configurato. Riveste, però, un ruolo di sicurezza molto importante se dovete collegarvi a internet con un adattatore ADSL USB o con un classico modem dial-up:

~~~  
apt-get install firestarter  
~~~

 [Firestarter è un firewall Open Source per Linux dotato di interfaccia grafica.](http://www.simonzone.com/software/guarddog/manual2/)  Una volta usciti dall'interfaccia grafica, il firewall resta attivo in background.

<div id="rev">Content last revised 21/02/2012 2130 UTC</div>
