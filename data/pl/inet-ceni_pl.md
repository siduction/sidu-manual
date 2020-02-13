<div id="main-page"></div>
<div class="divider" id="netcardconfig"></div>
## Połączenie z internetem / Konfiguracja sieci przy pomocy Ceni

`Prawdopodobnie musisz zainstalować non-free firmware z USB flash. Więcej informacji pod  [Wskazówki dla sprzętu wymagającego niewolnego oprogramowania](nf-firm-pl.htm#non-free-firmware) .` 

Jeśli posiadasz serwer DHCP w twojej sieci lokalnej i twój komputer jest do niej podłączony w trakcie startu systemu, ustawienia sieci powinny być uzyskane automatycznie - w przeciwnym razie musisz uruchomić `Ceni` . Kliknij `Kmenu>siduction>Internet>Ceni` . Otworzy się konsola, w której zostaniesz poproszony o podanie hasła administratora (na live-Cd hasło nie jest ustawione).

Szybkim sposobem dostępu do Ceni jest otwarcie terminalu/konsoli i wpisanie 

~~~  
ceni  
~~~

gdzie zostaniesz poproszony o podanie hasła administratora.

![Ceni Network Interfaces](../images-common/images-netcard/Ceni-interface-selection-01.png "Ceni Network Interfaces") 

![Ceni Network Settings](../images-common/images-netcard/Ceni-static-network-configuration-02.png "Ceni Network Settings") 


---

`WiFi, Jedną z silnych stron Ceni jest możliwość konfiguracji kart bezprzewodowych,  [WiFi - Basic setup guide](inet-wpa-pl.htm#wpa-basic) :`

![Ceni Wireless Settings](../images-common/images-netcard/Ceni-wireless-network-selection-02.png "Ceni Wireless Settings") 

![Scan or Roam](../images-common/images-netcard/Ceni-wireless-network-configuration-01.png "Ceni Scan or Roam") 

<div class="divider" id="dial-mod"></div>
## Połączenie przy pomocy 56k Dial-up Modem

KDE posiada interfejs do modemów dial up `KPPP Internet Dial-up Tool` , mieszczący się w głównym menu w dziale Internet.

Aplikacja posiada system pomocy i udostępnia instrukcję konfiguracji modemu. 

<div class="divider" id="firewalls"></div>
## Firewalle

Firewalle są zwykle niepotrzebne, jeśli jesteś za poprawnie skonfigurowanym routerem, jednakże pełnią bardzo ważną rolę w bezpieczeństwie twojego systemu, jeśli łączysz się z internetem przy pomocy modemu usb adsl lub via dial-up modem:

~~~  
apt-get install guarddog  
LUB  
apt-get install firestarter  
~~~

  [Guarddog jest bardzo przyjaznym narzędziem konfigurującym firewalla dla KDE. Najlepszym sposobem rozpoczęcia pracy z programem jest przeczytanie krótkich tutoriali, które tu się znajdują.](http://www.simonzone.com/software/guarddog/manual2/) 

 [Firestarter - firewall z graficznym interfejsem dla linuksa.](http://www.fs-security.com/) [Kiedy opuścisz interfejs, firewall pozostanie aktywny w tle.] 

<div id="rev"> Strona ostatnio modyfikowana 14/08/2010 0100 UTC</div>
