<div id="main-page"></div>
<div class="divider" id="wpa-roaming-gui"></div>
## Utilizarea  *wpa_gui* 

 *wpa_gui*  oferă o interfață grafică Qt GUI pentru  *wpa_supplicant*  și vă ajută să alegeți care rețea configurată să fie conectată. Vă oferă de asemenea o metodă de căutare (scanare) a rezultatelor 802.11 SSID, un istoric al mesajelor generate de  *wpa_supplicant*  și o metodă de a adăuga sau edita  *wpa_supplicant networks* .

 *wpa_gui*  este în pachetul  *wpagui* .

**`Înainte de a încerca folosirea lui  *wpa_gui*  trebuie să folosiți  [*ceni*  pentru a seta o configurație de bază](inet-ceni-ro.htm)  sau alocați câteva momente configurării unor fișiere cu  [Setarea pentru  *WiFi Roaming*  cu  *wpa*](inet-setup-ro.htm) .`** 

`Cel mai probabil veți avea nevoie de firmware non-free să fie disponibile pe un USB-stick pentru a le putea instala în sistemul de operare. Vă rugăm să citiți la  [non-free firmware debs pe un stick](nf-firm-ro.htm#non-free-firmware) .` 

## Utilizarea interfeței grafice  *wpa_gui* 

Puteți porni  *wpa_gui*  din menu sau, dacă preferați, din linia de comandă (cli), ca  *user*  cu  *$ /usr/sbin/wpa_gui* .

Când  *wpa_gui*  pornește pentru prima dată va arăta cam așa:

![First Screen](../images-common/images-wpa-roam/wpa-gui-0.01.png "First Screen") 

Ca să vedeți ce rețele WiFi sunt disponibile dați click pe `Scan`  pentru a vă afișa o listă cu acestea.

![Scanning](../images-common/images-wpa-roam/wpa-roam-04.png "Scanning") 

Dublu-click pe rețeaua pe care doriți s-o adăugați și vă va arăta următoarea fereastră:

![Enter passphrase and add](../images-common/images-wpa-roam/wpa-roam-05.png "Enter passphrase and add") 

Introduceți  *passphrase* -ul cerut pentru acces și dați click pe `add` :

Dacă sunteți mulțumit și totul merge bine, puteți adăuga setările la `/etc/wpa_supplicant/wpa-roam.conf`  alegând `File > Save Configuration` .

După inițializarea  *wpa_gui* , `known added networks`  vă vor fi disponibile într-o listă derulantă astfel:

![The interface](../images-common/images-wpa-roam/wpa-roam-01.png "The interface") 

<!--Click on `Connect`  to access the network.

-->
Într-un  *'roaming mode'*  va trebui să restartați procesul de scanare.

<div id="rev">Content last revised 30/11/2012 1140 UTC</div>
