<div id="main-page"></div>
<div class="divider" id="hotswitch"></div>
## Passare dalla connessione mediante cavo a quella WiFi

`Probabilmente avrete bisogno di firmware non-free da installare sul sistema operativo, memorizzato su una chiavetta USB. Fate riferimento a  [non-free firmware .deb su una chiavetta](nf-firm-it.htm#non-free-firmware) .` 

Il modo più semplice per passare da una rete cablata a una wireless è utilizzare il demone ifplugd, installato per default.

<div class="divider" id="interfaces"></div>
###### Modificare /etc/network/interfaces

Il primo passo da fare è assicurarsi che eth0 non sia già configurato:

~~~  
ifdown eth0  
~~~

###### Esempi di interfacce funzionanti:

La configurazione è semplice: l'interfaccia cablata (qui: eth0) non deve essere preceduta da qualsiasi configurazione come "allow-hotplug" o altre:

~~~  
auto lo  
iface lo inet loopback  
# governed by ifplugd ... do not use allow-hotplug or auto options  
iface eth0 inet dhcp  
~~~

Poi riconfigurare ifplugd:

~~~  
dpkg-reconfigure ifplugd  
~~~

###### Impostazioni Debconf di ifplugd

Lasciare libere le interfacce statiche:

![Static interfaces](../images-common/images-hotplug/ifplugd1.png "Static interfaces") 

Aggiungete le vostre interfacce cablate (qui "eth0") a "hotplugged interfaces":

![Hotplugged interfaces](../images-common/images-hotplug/ifplugd2.png "Hotplugged interfaces") 

Pagina di aiuto per le configurazioni personalizzate:

![Configuration help](../images-common/images-hotplug/ifplugd3.png "Configuration help") 

Lasciate le configurazioni di default, premete solo OK:

![Default configuration](../images-common/images-hotplug/ifplugd4.png "Default configuraton") 

Dite a ifplugd di fermarsi prima di eseguire suspend, ma verrà riavviato automaticamente dopo il resume:

![Suspend behaviour](../images-common/images-hotplug/ifplugd5.png "Suspend behaviour") 

Il risultato è un file di configurazione /etc/default/ifplugd contenente:

~~~  
INTERFACES=""  
HOTPLUG_INTERFACES="eth0"  
ARGS="-q -f -u0 -d10 -w -I"  
SUSPEND_ACTION="stop"  
~~~

Il computer adesso è impostato per muoversi fra varie reti incluse quelle wireless. Per impostare la modalità wireless roaming fate riferimento a  [Impostare il Roaming WiFi con wpa](inet-setup-it.htm) .

<div id="rev">Content last revised 23/02/2012 1330 UTC</div>
