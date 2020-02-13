<div id="main-page"></div>
<div class="divider" id="hotswitch"></div>
## Przełączanie pomiędzy sieciami przewodowymi i bezprzewodowymi 

`Prawdopodobnie musisz zainstalować non-free firmware z USB flash. Więcej informacji pod  [Wskazówki dla sprzętu wymagającego niewolnego oprogramowania](nf-firm-pl.htm#non-free-firmware)` .

Najprostszym sposobem, aby przełączać się między przewodową siecą LAN i siecią WLAN jest użycie demona ifplugd. To jest już zainstalowany na siduction.

<div class="divider" id="interfaces"></div>
###### Dostosowanie /etc/network/interfaces

Musisz najpierw zapewnić, że eth0 nie jest aktywne:

~~~  
ifdown eth0  
~~~

###### Przykład pliku konfiguracji 'interfaces':

Ustawienie jest proste: - kabel interfejsu (tu: eth0) nie powinno być poprzedzone dowolnej konfiguracji jak "allow-hotplug" lub podobnych:

~~~  
auto lo  
iface lo inet loopback  
# governed by ifplugd ... do not use allow-hotplug or auto options  
iface eth0 inet dhcp  
~~~

Następnie ponownie skonfiguruj ifplugd:

~~~  
dpkg-reconfigure ifplugd  
~~~

###### Debconf-ustawienie ifplugd

"Static interfaces" pozostaje wolne:

![Static interfaces](../images-common/images-hotplug/ifplugd1.png "Static interfaces") 

Add your wired interface (here "eth0") to "hotplugged interfaces":

![Hotplugged interfaces](../images-common/images-hotplug/ifplugd2.png "Hotplugged interfaces") 

Strona pomocy dla niestandardowych konfiguracji:

![Configuration help](../images-common/images-hotplug/ifplugd3.png "Configuration help") 

Pozostaw domyślne konfiguracje, wystarczy kliknąć OK:

![Default configuration](../images-common/images-hotplug/ifplugd4.png "Default configuraton") 

'ifplugd' ma być powstrzymany przed rozpoczęciem stanu bezczynności. Automatycznie zostanie uruchomiony po stanu bezczynności:

![Suspend behaviour](../images-common/images-hotplug/ifplugd5.png "Suspend behaviour") 

The result is a configuration file /etc/default/ifplugd containing:

~~~  
INTERFACES=""  
HOTPLUG_INTERFACES="eth0"  
ARGS="-q -f -u0 -d10 -w -I"  
SUSPEND_ACTION="stop"  
~~~

Komputer teraz jest gotowy do przełączania między wieloma interfejsami sieciowymi. Aby skonfigurować bezprzewodowego roamingu zobać tutaj  [Konfigurowanie WiFi Roaming z wpa](inet-setup-pl.htm) .

<div id="rev">Content last revised 06/11/2011 1400 UTC</div>
