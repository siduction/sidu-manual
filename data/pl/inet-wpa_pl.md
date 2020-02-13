<div id="main-page"></div>
<div class="divider" id="wpa-basic"></div>
## Podstawowe instrukcje konfigurowania połączenia WLAN (WiFi)

`Ze względu na złożoność prawa, siduction tylko zapewnia dfsg-wolnego oprogramowania, czytaj to  [Wskazówki dla sprzętu wymagającego niewolnego oprogramowania](hw-dev-mon-pl.htm#non-free) `

Aby uzyskać Wlan do pracy, trzeba połączenia kablowego na kilka minut, aby pobrać odpowiednie oprogramowanie. 

Jeśli połączenie kablowe nie jest możliwe, trzeba będzie umieścić firmware na przenośnych urządzeń (np. USB flash) i zainstalować jako root przy użyciu: 

~~~  
#dpkg -i <firmware.deb>  
~~~

Aby znaleźć odpowiedni firmware nie wiedząc marki lub rodzaju chip-Wifi można użyć kod polecenia: 

~~~  
#fw-detect  
~~~

To daje następujące informacje:

~~~  
#apt-get update  
#apt-get install <name of firmware>  
#modprobe -r <modulename>  
#modprobe <modulename>  
~~~

Użyj kod "apt-get install nazwa_firmware" jaki fw-detect wykrywał. Zanim można skonfigurować interfejs WiFi, musi być załadowany moduł (nazwę modułu pokażę ci fw-detect)

Jako root w konsoli zrobić to: 

~~~  
modprobe -r <modulename>  
modprobe <modulename>  
~~~

Jako &lt;modulename&gt; użyj informacje od fw-detect. Najprostszym sposobem jest skorzystanie z automatycznego uzupełniania tekstu (bash) przez naciśnięcie klawisza Tab. Po pierwszej literze właściwej nazwy modułu, naciśnięcie klawisza Tab automatycznie podaje pełną nazwę. Na przykład: "modprobe ipw [TAB]". Tą metodą można unikać nieprzyjemnych literówek. 

Oba rozkazy modprobe nie daję żaden wynik, gdy moduł został prawidłowo zainstalowany. Pojawja się nowa linia kodowa (#). 

Można to sprawdzić z:

~~~  
#lsmod | grep <module>  
~~~

Teraz można rozpocząć Ceni w K-Menu->Internet lub uruchomić z konsoli jako root. Informacje na temat tu  [Ceni](inet-ceni-pl.htm#netcardconfig) . Konfigurowalny interfejs bezprzewodowy powinnien się pojawić. 

Aby uzyskać instrukcje dotyczące sposobu kontaktowania się z różnymi sieciami Wi-Fi przez wpagui czytaj w tym rozdziale:  [Korzystanie z wpa_gui](inet-wpagui-pl.htm) .

<div class="divider" id="wpa"></div>
## Tryby działania programu wpasupplicant dla Debiana

`Ze względu na komplikacje prawne siduction będzie udostępniać tylko oprogramowanie wolne w sensie dfsg,  [sprawdź ten link, aby uzyskać dodatkowe informacje dotyczące niewolnych źródeł firmware](nf-firm-pl.htm#non-free-firmware) `

Pakiet Debiana wpasupplicant udostępnia dwa (2) wygodne tryby działania, które są w pełni zintegrowane z infrastrukturą sieciową; ifupdown.

#### Streszczenie

###### 1. Wyszczególnienie backendów sterowników w wpa_supplicant

* Tabela wspieranych sterowników  
* Rekomendacje sterowników 

###### 2. Tryb #1: Tryb zarządzany (managed mode)

* Przykład  
* Tabela parametrów wpa  
* Ważne informacje o trybie zarządzanym  
* Jak to działa 

###### 3. Mode #2: Tryb roamingowy (roaming mode)

* wpa_supplicant.conf  
* /etc/network/interfaces  
* Kontrolowanie demona roamingowego przy pomocy wpa_action  
* Dostrajanie konfiguracji roamingowej  
* Plik dziennika  
* Używanie zewnętrznych skryptów mapujących np. guessnet)  
* /etc/network/interfaces z zewnętrznym mapowaniem 

###### 4. Rozwiązywanie problemów 

 * Ukryte ssid-y 

###### 5. Rozważania na temat bezpieczeństwa 

 * Uprawnienia pliku konfiguracyjnego 

## 1. Wyszczególnienie backendów sterowników w wpa_supplicant

Backend sterownika wext będzie użyty dla wszystkich interfejsów, które wyraźnie nie ustawią 'wpa-driver' dla typu sterowników urządzenia. Użytkownicy kerneli linuksa 2.4 lub 2.6 mniejszych niż 2.6.14 powinny wybrać wpa-driver.

### Tabela wspieranych sterowników

| Sterownik | Opis | 
| ---- | ---- |
| wext | Linux wireless extensions (generic) | 


---

### Rekomendacje sterowników

Adaptery Intel Pro Wireless (ipw2100, ipw2200 and ipw3945) używają backendu 'wext', chyba że twój kernel jest starszy niż 2.6.14

Madwifi wspiera backendy 'wext' i 'madwifi'. Preferowany jest 'wext' , choć 'madwifi' może działać lepiej w niektórych przypadkach.

Ndiswrapper NIE WSPIERA backendu 'ndiswrapper' od wersji 1.16. Należy użyć 'wext', chyba że używasz starej wersji ndiswrapper.

Ustaw typ sterownika w /etc/network/interfaces dla twojego urządzenia opcją 'wpa-driver'. Na przykład:

~~~  
iface eth0 inet dhcp  
wpa-driver wext  
. . . . . inne opcje  
~~~

## 2. Tryb #1: Tryb zarządzany (managed mode)

Ten tryb umożliwia ustanowienie połączenia via wpa_supplicant do jednej znanej sieci. Podobnie działa pakiet wireless-tools. Każdy element potrzebny do ustanowienia połączenia via wpa_supplicant jest poprzedzony przedrostkiem 'wpa-' a po nim znajduje się wartość, która będzie użyta przez ten element.

###### Przykłady trybu #1 pliku wpa.conf - Przykład 1.

~~~  
# Przykład trybu #1 pliku wpa.conf - Przykład 1.  
# UWAGA: wartość 'wpa-psk' jest tylko wtedy prawidłowa, gdy:  
# 1. Jest to ciąg tekstowy (ascii) o długości od 8 do 63 znaków  
# 2. Jest to ciąg heksadecymalny o długości 64 znaków  
# Połącz do punktu dostępowego ssid 'NETBEER' z typem kodowania  
# WPA-PSK/WPA2-PSK. Zakłada, że sterownik użyje backendu 'wext'  
# wpa_supplicant ponieważ żadna opcja sterownika wpa nie została określona.  
# Hasło podano jako ciąg tekstowy ASCII. DHCP jest użyte do pobrania adresu sieciowego.  
#  
iface wlan0 inet dhcp  
wpa-ssid NETBEER  
# plaintext passphrase  
wpa-psk PlainTextSecret  
# Połącz to punktu dostępowego ssid 'homezone' z kodowaniem typu  
# WPA-PSK/WPA2-PSK, używając backendu 'wext' wpa_supplicant.  
# psk (personal key) jest podany jako zakodowany ciąg heksadecymelny.  
# DHCP jest użyty do pobrania adresu sieciowego.  
#  
iface wlan0 inet dhcp  
wpa-driver wext  
wpa-ssid homezone  
# heksadecymalny psk jest kodowany z hasła w postaci ciągu tekstowego  
wpa-psk 000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f  
# Połącz do punktu dostępowego ssid 'HotSpot1' i bssid '00:1a:2b:3c:4d:5e'  
# z kodowaniem typu WPA-PSK/WPA2-PSK, używając backendu 'madwifi' wpa_supplicant.  
# Hasło jest podane jako ciąg tekstowy  
# Adres sieciowy jest przydzielony statycznie.  
#  
iface ath0 inet static  
wpa-driver madwifi  
wpa-ssid HotSpot1  
wpa-bssid 00:1a:2b:3c:4d:5e  
# hasło w postaci ciągu tekstowego  
wpa-psk madhotspot  
wpa-key-mgmt WPA-PSK  
wpa-pairwise TKIP CCMP  
wpa-group TKIP CCMP  
wpa-proto WPA RSN  
# ustawienia statycznego ip  
address 192.168.0.100  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
# wpa_supplicant.conf wskazany przez użytkownika jest użyty dla eth1.  
# Wszystkie informacje sieciowe są zawarte w pliku wpa_supplicant.conf użytkownika.  
# Żaden typ sterownikaa wpa nie jest określony, więc użyty jest wext.  
# DHCP jest użyty do pobrania adresu sieciowego.  
#  
iface eth1 inet dhcp  
wpa-conf /sciezka/do/wpa_supplicant.conf  
~~~

<div class="divider" id="wpa1"></div>
## Tabela opcji wpa

Krótkie podsumowanie najpopularniejszych opcji 'wpa-', które mogą być użyte w /etc/network/interfaces dla urządzeń bezprzewodowych. Patrz też sekcja 'Ważne informacje o trybie zarządzanym' - poprawne i niepoprawne wartości 'wpa-'.

**`UWAGA: istotna jest wielkość LiTeR`**

~~~  
Element Przykładowa wartość Opis  
======= ============= ===========  
wpa-ssid łańcuch tekstowy ustawi ssid twojej sieci  
wpa-bssid 00:1a:2b:3c:4d:5e bssid twojego AP  
wpa-psk 0123456789...... twój psk. Użyj  
wpa_passphrase(8) by wygenerować psk  
z hasła i identyfikatora sieci ssid  
wpa-key-mgmt NONE, WPA-PSK, WPA-EAP, lista zaakceptowanych poświadczonych kluczy  
IEEE8021X protokoły zarządzania  
wpa-group CCMP, TKIP, WEP104, lista zaakceptowanych grup szyfrów WPA  
WEP40  
wpa-pairwise CCMP, TKIP, NONE lista zaaceptowanych typów szyfrowania  
WPA  
wpa-auth-alg OPEN, SHARED, LEAP lista dozwolonych algorytmów poświadczania  
EEE 802.11  
wpa-proto WPA, RSN lista akceptowanych protokołów  
wpa-identity nazwa nazwa administratora  
(poświadczanie EAP)  
wpa-password hasło twoje hasło (poświadczanie EAP)  
wpa-scan-ssid 0 lub 1 zmienia skanowanie ssid z określonymi  
"Probe Request frames"  
wpa-ap-scan 0 lub 1 lub 2 ustawia sposób skanowania wpa_supplicant  
~~~

 Pełna funkcjonalność wpa_cli(8) powinna być zaimplementowana. Jakikolwiek brak należy traktować jako błąd, który powinien być zgłoszony. Łatki są mile widziane. 

## Ważne informacje o trybie zarządzanym

 Prawie wszystkie opcje 'wpa-' wymagają przynajmniej określenia ssid. Tylko kilka opcji daje efekt globalny: 'wpa-ap-scan' i 'wpa-preauthenticate'. 

 Każda opcja 'wpa-' podana dla urządzenia w pliku interfaces(5) jest wystarczająca, by uruchomić demona wpa_supplicant. 

 Skrypt ifupdown wpasupplicanta przyjmuje takie założenie o typie danych wejściowych, że są właściwe dla każdej opcji. Na przykład, zakłada że pewne dane wejściowe są łańcuchem tekstowym i obejmuje go cudzysłowem przed wysłaniem go do wpa_cli, który dodaje te dane do bloku sieciowego stworzonego przez gniazdo ctrl_interface wpa_supplicanta. 

 Uruchomienie ifup "ręcznie" z opcją '--verbose' ujawni wszystkie polecenia użyte do stworzenia bloku sieciowego przez wpa_cli. Jeśli wartość, którą użyłeś dla jakiejkolwiek opcji wpa-* w /etc/network/interfaces jest objęta przez cudzysłów, wtedy zakłada się, że wartość jest typu "łańcuch tekstowy" lub "ascii". 

Zakłada się, że niektóre dane wejściowe są łańcuchem heksadecymalnym (np. wpa-wep-key*). Wartość 'type' opcji wpa-psk jest jednak ustalana poprzez sprawdzenie, czy w łańcuchu znajduje się przynajmniej jeden znak inny niż szesnastkowy.

## Jak to działa

Jak wcześniej wspomniano, każdy określony element wpa_supplicant jest poprzedzony przez 'wpa-'. Każdy element jest powiązany z właściwością wpa_supplicanta opisaną na stronach man-a wpa_supplicant.conf(5), wpa_supplicant(8) i wpa_cli(8).

Supplicant jest uruchamiany bez jakiejkolwiek wcześniejszej konfiguracji, a wpa_cli tworzy konfigurację sieciową z danych dostarczonych przez linie 'wpa-*'. Początkowo, wpa_supplicant/wpa_cli nie ustawia bezpośrednio właściwości urządzenia (jak na przykład ustawienie essid przy pomocy iwconfig), raczej informuje urządzenie, który access point jest odpowiedni do połączenia. Kiedy urządzenie przeskanuje pasmo i znajdzie ten odpowiedni access point dostępny do użytku, ustawienia zostają wprowadzone.

Skrypt, który wykonuje całą pracę jest umieszczony w:

~~~  
/etc/wpa_supplicant/ifupdown.sh  
/etc/wpa_supplicant/functions.sh  
~~~

ifupdown.sh: Jest on wykonywany przez run-parts, który z kolei jest wywoływany przez ifupdown podczas faz 'pre-up', 'pre-down' i 'post-down'.

W fazie 'pre-up', demon wpa_supplicant jest uruchamiany po serii poleceń wpa_cli, które ustawiają konfiguracji sieci według opcji 'wpa-' znajdujących się w /etc/network/interfaces dla urządzenia.

Jeśli użyty jest wpa-roam, demon wpa_cli zostaje uruchomiony w fazie 'post-up'.

W fazie 'pre-down', demon wpa_cli jest "zabijany" jeśli jest uruchomiony.

W fazie 'post-down' demon wpa_supplicant jest "zabijany".

## 3. Tryb #2: Tryb roamingowy (roaming mode)

 W tym pakiecie znajduje się samodzielny, prosty mechanizm roamingowy. Jest on formą skryptu wpa_cli, /sbin/wpa_action, i przejmuje kontrolę nad ifupdown. Strona pomocy man wpa_action(8) opisuje szczegóły techniczne w sposób pogłębiony. 

Aby uaktywnić interfejs roamingowy, zmodyfikuj poniższy przykładowy listing pliku interfaces(5):

~~~  
iface eth1 inet manual  
wpa-driver wext  
wpa-roam /sciezka/do/wpa_supplicant.conf  
~~~

W tym przykładzie są uruchomione dwa demony: wpa_supplicant i wpa_cli. Jest wymagane, aby wskazać wpa_supplicant.conf. Dobrym punktem startowym jest dostarczony przykład pliku konfiguracyjnego:

~~~  
# copy the template to /etc/wpa_supplicant/  
cp /usr/share/doc/wpasupplicant/examples/wpa-roam.conf \  
/etc/wpa_supplicant/wpa_supplicant.conf  
# allow only root to read and write to file  
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf  
NOTE: it is critical that the used wpa_supplicant.conf defines the location of  
the 'ctrl_interface' so that a communication socket is created for the  
wpa_cli (wpa-roam daemon) to attach. The mentioned example configuration,  
/usr/share/doc/wpasupplicant/examples/wpa-roam.conf, has been set to a  
sane default.  
~~~

 Konieczna jest edycja tego pliku konfiguracyjnego przez dodanie bloków sieciowych dla wszystkich znanych sieci. Jeśli nie rozumiesz, co to znaczy, zacznij czytać stronę pomocy man wpa_supplicant.conf(5). 

Dla każdej sieci możesz określić specjalną opcję 'id_str'. Powinien to być prosty łańcuch tekstowy. Tworzy on bazę do profili sieci; powiązany jest z interfejsem logicznym zdefiniowanym w pliku interfaces(5). Jeśli nie zostanie podany 'id_str' dla sieci, wpa_action przyjmuje domyślny interfejs logiczny jako zastępstwo. Interfejs zasptępczy może być wybrany przez opcję 'wpa-default-iface'.

Co to wszystko oznacza? Zilustrujmy to małym przykładem wziętym ze strony pomocy man wpa_action(8).

###### Przykład wpa_supplicant.conf

~~~  
wpa_supplicant.conf example:  
network={  
ssid="foo"  
key_mgmt=NONE  
# this id_str will notify /sbin/wpa_action to 'ifup uni'  
id_str="uni"  
}  
network={  
ssid="bar"  
psk=123456789...  
# this id_str will notify /sbin/wpa_action to 'ifup home_static'  
id_str="home_static"  
}  
network={  
ssid=""  
key_mgmt=NONE  
# no 'id_str' parameter is given, /sbin/wpa_action will 'ifup default'  
}  
~~~

<div class="divider" id="wpa2"></div>
###### Przykład /etc/network/interfaces

~~~  
Przykład /etc/network/interfaces:  
# interfejs roamingowy MUSI użyć ręcznej metody inet  
# 'allow-hotplug' lub 'auto' zapewnia automatyczne wystartowanie demona  
allow-hotplug eth1  
iface eth1 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
# brak id_str, 'domyślny' jest użyty jako zastępczy cel mapowania  
iface default inet dhcp  
# id_str="uni"  
iface uni inet dhcp  
# id_str="home_static"  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
~~~

Interfejs logiczny jest podnoszony przez ifup, a wyłączany przez ifdown, ponieważ wpa_supplicant tworzy i usuwa skojarzenia z siecią przez opcję 'id_str' używaną w pliku konfiguracyjnym wpa_supplicant.conf.

Log /sbin/wpa_action jest tworzony w /var/log/wpa_action.log, dołącz go, gdy zgłaszasz problemy.

## Współpraca wpa_supplicant z wpa_cli i wpa_gui

Proces wpa_supplicant może zachowywać się interaktywnie z użytkownikami należącymi do grupy "netdev", jeśli przykładowa konfiguracja roamingu została użyta (lub dla grupy whatever lub gid określonego przez parametr GROUP=crtl_interface).

~~~  
# domyślna opcja ctrl_interface użyta w przykładowym pliku  
# /usr/share/doc/wpasupplicant/examples/wpa-roam.conf  
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev  
Do współdziałania z supplicant-em, zostały przewidziane wpa_cli (w linii komend)  
i wpa_gui (QT). Przy ich pomocy możesz się łączyć, rozłączać, dodawać/usuwać nowe  
bloki sieciowe, dostarczać wymaganą interaktywną informację bezpieczeństwa itd.  
~~~

## Kontrolowanie demona roamingowego przy pomocy wpa_action

Gdy demon roamingowy wystartuje, przejmuje kontrolę nad ifupdown. Oznacza to, że wpa_cli wywołuje ifup kiedy wpa_supplicant skojarzy z access pointem i wywołuje ifdown kiedy połączenie zostanie utracone lub przerwane. Podczas gdy demon roamingowy jest aktywny, ifupdown nie powinien być kontrolowany "ręcznie" przez wywoływanie poleceń, zatrzymywanie i restartowanie demona roamingowego należy zostawić /sbin/wpa_action. Na przykład, aby zatrzymać demona roamingowego korzystającego z urządzenia 'eth1':

~~~  
wpa_action eth1 stop  
~~~

Jeśli zachodzi potrzeba uaktualnienia demona roamingowego o nowe informacje o sieci, można to zrobić bez jego zatrzymania. Edytuj plik wpa_supplicant.conf, który jest używany przez demona, dodaj dodatkowe ustawienia specyficzne dla nowej sieci (oznaczonej przez 'id_str') do /etc/network/interfaces i załaduj ponownie demona w ten sposób:

~~~  
wpa_action eth1 reload  
~~~

Aby zapoznać się z dokumentacją techniczną wpa_action, przeczytaj stronę pomocy man wpa_action(8).

<div class="divider" id="wpa3"></div>
## Dostrajanie konfiguracji roamingowej

Możesz spotkać się z sytuacją, że wiele znanych access pointów jest w bliskiej odległości. Możesz wtedy wybrać ten preferowany ręcznie, przy pomocy wpa_cli lub wpa_gui, lub możesz też dać każdej z sieci jej własny priorytet. Możliwość ta dostarczana jest przez opcję 'priority' w wpa_supplicant.conf.

<div class="divider" id="wpa4"></div>
## Plik dziennika

Cała aktywność demona roamingowego jest zapisywana w /var/log/wpa_action.log. Przechowywane są następujące informacje:

*czas i data  
*nazwa interfejsu i i zdarzenie  
*wartości zmiennych środowiskowych (WPA_ID, WPA_ID_STR, WPA_CTRL_DIR)  
*wywołane polecenia ifupdown  
*status wpa_cl (oparty o WPA-PSK, sieć może wyświetlić inne informacje)  
*bssid  
*ssid  
*id  
*id_str  
*pairwise_cipher  
*group_cipher  
*key_mgmt  
*wpa_state  
*ip_address

<div class="divider" id="wpa5"></div>
## Użycie zewnętrznych skryptów mapujących (np. guessnet)

W dodatku do wewnętrznego mapowania logicznych interfejsów przez 'id_str', wpa_action może uruchomić zewnętrzny skrypt mapowania. Skrypt mapowania powinien zwrócić nazwę interfejsu logicznego, który powinien być podniesiony. Skrypt mapujący, który działa z mechanizmu mapującego ifpdown (patrz man interfaces) powinien także działać, gdy jest wywołany z wpa_action.

Aby wywołać skrypt mapujący dodaj linię 'wpa-mapping-script nazwa-skryptu' do interfaces dotyczącej urządzenia roamingowego. (może będziesz musiał określić absolutną ścieżkę do skryptu mapującego.)

Zawartość linii zaczynających się od wpa-map są przekazywane do stdin skryptu mapującego. Ponieważ ifupdown pozwala tylko na jedną linię wpa-map, możesz dodać dowolną liczbę do wpa-map, aby stworzyc dodatkowe linie. Na przykład:

~~~  
iface wlan0 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
wpa-mapping-script guessnet-ifupdown  
wpa-map0 home  
wpa-map1 work  
wpa-map2 school  
# ... additional wpa-mapX lines as required  
~~~

Domyślnie skrypt mapujący będzie użyty, kiedy do bieżącej sieci nie będzie dostępny 'id_str'. Jeśli chcesz całkowicie wyłączyć powiązanie 'id_str' i korzystać tylko z zewnętrznego skryptu mapującego, użyj opcji 'wpa-mapping-script-priority 1', aby zastąpić domyślne zachowanie.

 Jeśli skrypt mapujący zwróci pusty łańcuch tekstowy, wpa_action przywróci domyślny interfejs, chyba że zdefiniowano alternatywę opcją 'wpa-roam-default-iface'. 

Poniżej znajduje się zaawansowany przykład, w którym użyty jest guessnet-ifupdown jako zewnętrzny skrypt mapujący.

###### Przykład /etc/network/interface z zewnętrznym skryptem mapującym

~~~  
Przykład /etc/network/interfaces z zewnętrznym skryptem mapującym:  
allow-hotplug wlan0  
iface wlan0 inet manual  
wpa-driver wext  
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf  
wpa-roam-default-iface default-wparoam  
wpa-mapping-script guessnet-ifupdown  
wpa-map default: default-guessnet  
wpa-map0 home_static  
wpa-map1 work_static  
# szkoła może być wybrana tylko przez 'id_str'  
iface school inet dhcp  
# resolvconf  
dns-nameservers 11.22.33.44 55.66.77.88  
iface home_static inet static  
address 192.168.0.20  
netmask 255.255.255.0  
network 192.168.0.0  
broadcast 192.168.0.255  
gateway 192.168.0.1  
test peer address 192.168.0.1 mac 00:01:02:03:04:05  
iface work_static inet static  
address 192.168.3.200  
netmask 255.255.255.0  
network 192.168.3.0  
broadcast 192.168.3.255  
gateway 192.168.3.1  
test peer address 192.168.3.1 mac 00:01:02:03:04:05  
iface default-guessnet inet dhcp  
iface default-wparoam inet dhcp  
~~~

 W tym przykładzie wpa_action użyje guessnet do wyboru odpowiedniego interfejsu logicznego tylko, gdy nie będzie opcji 'id_str' dla bieżącej sieci w dostarczonym wpa_supplicant.conf. 

Linie 'wpa-map' dostarczają do guessnet interfejsy logiczne, które mają być przetestowane, a także domyślny interfejs, gdyby wszystkie testy zawiodły. Linie 'test' każdego interfejsu logicznego są używane przez guessnet, aby określić czy jesteśmy połączeni z siecią. Na przykład, guessnet wybierze interfejs logiczny 'home_static', jeśli istnieje urządzenie z adresem IP 192.168.0.1 i MAC 00:01:02:03:04:05 w bieżącej sieci. Jeśli wszystkie testy zawiodą, interfejs 'default-guessnet' będzie skonfigurowany.

Przeczytaj stronę pomocy man guessnet(8), aby otrzymać więcej informacji.

## 4. Rozwiązywanie problemów

 W celu rozwiązania problemów z połączeniem, skojarzeniem urządzeń i identyfikacją, sugerujemy uruchomienie `wpa_cli -i &lt;interface&gt;` w innej konsoli, przed podniesieniem interfejsu. Użyj najpierw polecenia 'level 0', aby otrzymać wszystkie komunikaty o błędach. Następnie użyj `ifup --verbose &lt;interface&gt;`, aby otrzymać wszystkie komunikaty ze skryptu uruchamiającego wpasupplicant. 

<div class="divider" id="wpa6"></div>
## Ukryte ssid-y

 Dla innych źródeł, patrz #358137. W celu nawiązania połączenia do ukrytych ssid-ów, spróbuj ustawić opcję 'ap_scan=1' w głównej sekcji i 'scan_ssid=1' w sekcji bloku sieci pliku wpa_supplicant.conf. Jeśli korzystasz z trybu zarządzanego, możesz to zrobić wg tego wzoru: 

~~~  
iface eth1 inet dhcp  
wpa-conf managed  
wpa-ap-scan 1  
wpa-scan-ssid 1  
# ... dodatkowe opcje twojej konfiguracji  
~~~

 Według #368770, skojarzenie może potrwać bardzo długo w przypadku sieci zabezpieczonych WEP. W niektórych przypadkach ustawienie parametru 'ap_scan=2' w pliku konfiguracyjnym (lub użycie 'wpa-ap-scan 2', co jest jego ekwiwalentem) może znacznie przyspieszyć skojarzenie. 

<div class="divider" id="wpa7"></div>
## 5. Rozważania na temat bezpieczeństwa

##### Uprawnienia pliku konfiguracyjnego

 Bardzo ważne, aby trzymać PSK i inne poufne informacje dotyczące twojej sieci w tajemnicy, dlatego upewnij się, że ważne pliki konfiguracyjne zawierające te dane są dostępne do odczytu tylko dla ich właściciela. Na przykład: 

~~~  
chmod 0600 /etc/network/interfaces  
# Ustaw ścieżkę do pliku wpa_supplicant.conf  
chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf  
~~~

Domyślnie, /etc/network/interfaces jest dostępne do odczytu przez wszystkich, tak więc nieodpowiednie do przechowywania sekretnych kluczy i haseł.

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
