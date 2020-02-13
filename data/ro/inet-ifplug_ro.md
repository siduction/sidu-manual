<div id="main-page"></div>
<div class="divider" id="hotswitch"></div>
## Comutarea între conexiunea prin cablu și cea wireless

`În general veți avea nevoie de drivere 'non-free firmware' disponibile pe un USB-stick pentru a putea fi instalate în sistemul de operare. Vă rog să citiți  [pachete 'non-free firmware debs' pe stick](nf-firm-ro.htm#non-free-firmware)` .

Cel mai ușor mod de a comuta între o conexiune LAN prin fir și una fără fir (wireless) este folosirea demonului 'ifplugd'. Este instalat 'by default'.

<div class="divider" id="interfaces"></div>
###### Modificarea /etc/network/interfaces

În primul rând asigurați-vă că interfața eth0 nu este configurată:

~~~  
ifdown eth0  
~~~

###### Examplu de configurare a interfețelor:

Configurarea e simplă: - placa de rețea prin cablu (aici "eth0") nu trebuie precedată de nici o configurare ca "allow-hotplug" sau altele:

~~~  
auto lo  
iface lo inet loopback  
# governed by ifplugd ... do not use allow-hotplug or auto options  
iface eth0 inet dhcp  
~~~

Apoi reconfigurați 'ifplugd':

~~~  
dpkg-reconfigure ifplugd  
~~~

###### Setarea 'ifplugd' cu 'Debconf' 

Lăsați libere interfețele statice:

![Static interfaces](../images-common/images-hotplug/ifplugd1.png "Static interfaces") 

Adăugați interfața pentru cablu de rețea (aici "eth0") la "hotplugged interfaces":

![Hotplugged interfaces](../images-common/images-hotplug/ifplugd2.png "Hotplugged interfaces") 

Pagina de ajutor pentru configurări personale:

![Configuration help](../images-common/images-hotplug/ifplugd3.png "Configuration help") 

Lăsați configurările de bază așa cum sunt, apăsați doar "OK":

![Default configuration](../images-common/images-hotplug/ifplugd4.png "Default configuraton") 

Alegeți "stop" pentru ca 'ifplugd' să se oprească înainte de suspendare; va fi repornit automat după "resume":

![Suspend behaviour](../images-common/images-hotplug/ifplugd5.png "Suspend behaviour") 

Rezultatul este un fișier de configurare /etc/default/ifplugd care conține:

~~~  
INTERFACES=""  
HOTPLUG_INTERFACES="eth0"  
ARGS="-q -f -u0 -d10 -w -I"  
SUSPEND_ACTION="stop"  
~~~

Computerul vostru este acum pregătit să se mute între diferite rețele inclusiv cele 'wireless'. Pentru setarea 'wireless roaming' citiți  [Setarea unui 'WiFi Roaming' cu 'wpa'](inet-setup-ro.htm) .

<div id="rev">Content last revised 30/11/2012 1400 UTC</div>
