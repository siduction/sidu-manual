<div id="main-page"></div>
<div class="divider" id="wpa-roaming-gui"></div>
## Utilizzare wpa_gui

wpa_gui offre una interfaccia grafica Qt per wpa_supplicant e permette di scegliere a quale rete configurata connettersi. Offre anche un metodo per visualizzare i risultati della scansione SSID 802.11, uno storico degli eventi di log generati da wpa_supplicant e infine un metodo per aggiungere o modificare reti wpa_supplicant.

wpa_gui è contenuto nel pacchetto wpagui.

**`Prima di provare a utilizzare wpa_gui dovrete utilizzare  [ceni per impostare una configurazione di base](inet-ceni-it.htm)  oppure prendervi un po' di tempo per impostare alcuni file di configurazione con  [Impostare il Roaming WiFi con wpa](inet-setup-it.htm) .`** 

`Probabilmente avrete bisogno di firmware non-free da installare sul sistema operativo memorizzato su una chiavetta USB. Fate riferimento a  [non-free firmware .deb su una chiavetta](nf-firm-it.htm#non-free-firmware) .` 

## Utilizzare l'interfaccia grafica wpa_gui

Si può avviare wpa_gui dal menu o, se si preferisce, da una console, come utente con /usr/sbin/wpa_gui.

Quando si avvia wpa_gui per la prima volta la schermata di default è:

![First Screen](../images-common/images-wpa-roam/wpa-gui-0.01.png "First Screen") 

Per trovare quali reti WiFi sono disponibili cliccate su `Scan` .

![Scanning](../images-common/images-wpa-roam/wpa-roam-04.png "Scanning") 

Fate doppio click sulla rete che volete aggiungere e otterrete questa schermata:

![Enter passphrase and add](../images-common/images-wpa-roam/wpa-roam-05.png "Enter passphrase and add") 

Aggiungete la passphrase richiesta per abilitare l'accesso e cliccate su `add` :

Se tutto funziona potrete aggiungere le impostazioni a `/etc/wpa_supplicant/wpa-roam.conf`  scegliendo `File > Save Configuration` .

Dopo l'inizializzazione di wpa_gui, le `reti riconosciute aggiunte`  nel raggio di portata verranno mostrate dal menù a tendina Network:

![The interface](../images-common/images-wpa-roam/wpa-roam-01.png "The interface") 

<!--Click on `Connect`  to access the network.

-->
In "modalità roaming" dovrete riavviare l'operazione di scansione.

<div id="rev">Content last revised 29/02/2012 0100 UTC</div>
