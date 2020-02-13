<div id="main-page"></div>
<div class="divider" id="netcardconfig"></div>
## Conectarea la Internet / Configurarea Reţelei cu Ceni

`De regulă veți avea nevoie de 'non-free firmware' disponibile pe un USB-stick pentru a le instala în sistemul de operare. Pentru asta vă rog să citiți  [Drivere 'non-free firmware debs' pe stick](nf-firm-ro.htm#non-free-firmware) .` 

 Dacă sunteți conectați la o rețea cu un server DHCP, (inclusiv un modem-router) la boot-are rețeaua va fi configurată automat, în caz contrar trebuie pornit `Ceni` : click `Kmenu>siduction>Internet>Ceni` . Acesta va deschide un terminal / consolă, în care vi se va cere parola de root ( notați că live-Cđ-ul nu are setată această parolă) .

 Pentru un acces rapid deschideți un terminal / consolă, și tastați 

~~~  
ceni  
~~~

 după care vi se va cere parola de root.

![Ceni Network Interfaces](../images-common/images-netcard/Ceni-interface-selection-01.png "Ceni Network Interfaces") 

![Ceni Network Settings](../images-common/images-netcard/Ceni-static-network-configuration-02.png "Ceni Network Settings") 


---

`WiFi, Unul din marile avantaje ale lui ceni este abilitatea de a configura plăcile wireless,  [WiFi - Ghid sumar de setare](inet-wpa-ro.htm#wpa-basic) :`

![Ceni Wireless Settings](../images-common/images-netcard/Ceni-wireless-network-selection-02.png "Ceni Wireless Settings") 

![Scan or Roam](../images-common/images-netcard/Ceni-wireless-network-configuration-01.png "Ceni Scan or Roam") 

<!-- [Se poate face acest pas și în X prin centrul de control siductioncc: KDE-Start-Menu>System>siduction Control Centre](siductioncc-ro.htm) 

-->
<div class="divider" id="dial-mod"></div>
## Conectarea dial-up printr-un modem 56k

KDE conţine o unealtă pentru conectarea prin modem numită `KPPP Internet Dial-up Tool`  , care se găseşte în meniul principal --> Internet .

Aplicaţia are ataşat un manual intern ce oferă un ghid foarte intuitiv pentru setarea modemului pentru accesul online . 

<div class="divider" id="firewalls"></div>
## Firewall-uri

Firewall-urile nu sunt în mod normal necesare dacă rulaţi din spatele unui router configurat corect , oricum au un rol foarte important dacă doriţi să vă conectaţi la internet cu un modem usb adsl sau via dial-up modem :

~~~  
apt-get install shorewall  
~~~

sau

~~~  
apt-get install shorewall6  
~~~

pentru computere care folosesc IPV6.

  [Shorewall este un firewall cu o interfaţă prietenoasă rulând în Linux.](http://www.shorewall.net/) Vă rugăm nu instalaţi shorewall pe un computer aflat la distanţa. Dacă o veţi face computerul respectiv vă va deveni inaccesibil.

<div id="rev"> Page last revised 30/11/2012 1440 UTC</div>
