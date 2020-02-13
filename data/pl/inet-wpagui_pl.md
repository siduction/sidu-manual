<div id="main-page"></div>
<div class="divider" id="wpa-roaming-gui"></div>
## Korzystanie z wpa_gui (graficzny frontend)

Wpa_gui udostępnia interfejs Qt GUI dla wpa_supplicant i pozwala na wybór predefiniowanej sieci, aby się połączyć, i udostępnia metodę, aby wyświetlić wyniki skanowania 802.11 SSID. Ponadto, ustawienia mogą być zmieniane przez wpa_supplicant i log wiadomości wyświetlany.

wpa_gui znajduje się w pakiecie wpagui.

**`Przed próbą użycia wpa_gui musisz albo użyć  [Ceni](inet-ceni-pl.htm)  lub ustawić pliki konfiguracyjne (czytaj tu  [Konfigurowanie WiFi Roaming z wpa](inet-setup-pl.htm) ).`** 

`Prawdopodobnie musisz zainstalować non-free firmware z USB flash. Więcej informacji pod  [Wskazówki dla sprzętu wymagającego niewolnego oprogramowania](nf-firm-pl.htm#non-free-firmware) .` 

## Korzystanie z GUI interfejs wpa_gui

Możesz startować wpa_gui z menu, lub jeśli wolisz terminalu jako użytkownik z $/usr/sbin/wpa_gui.

Podczas uruchamiania wpa_gui po raz pierwszy wygląd taki:

![First Screen](../images-common/images-wpa-roam/wpa-gui-0.01.png "First Screen") 

Aby dowiedzieć się, jakie sieci WiFi są dostępne kliknij `Scan` .

![Scanning](../images-common/images-wpa-roam/wpa-roam-04.png "Scanning") 

Podwójne kliknięcie na żądaną sieć otwiera to: 

![Enter passphrase and add](../images-common/images-wpa-roam/wpa-roam-05.png "Enter passphrase and add") 

Dodaj wymagane hasło w celu umożliwienia dostępu i kliknij `add` :

Jeśli jesteś szczęśliwy i wszystko działa, można dodać ustawienia do `/etc/wpa_supplicant/wpa-roam.conf`  wybierając `File > Save Configuration` .

To sprawia, że zapisywane sieci pojawią się w Drop-Down-menu "Network".

![The interface](../images-common/images-wpa-roam/wpa-roam-01.png "The interface") 

<!--Click on `Connect`  to access the network.

-->
Powtarza się proces skanowania w trybie roamingu. 

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
