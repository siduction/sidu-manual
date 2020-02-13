<div id="main-page"></div>
<div class="divider" id="welcome-quick"></div>
## siduction - szybki start

###### **`BARDZO WAŻNE:`** `siduction, jako linux LIVE-CD, jest oparty na technologii wysokiej kompresji plików, i dlatego wymagane jest poświęcenie specjalnej uwagi wypalaniu obrazu ISO. Zaleca się wykorzystywanie jedynie wysokiej jakości nośników CD / DVD i wypalanie ich w **`trybie DAO (disk-at-once)`** , nie prędkością nie większą niż x8.` 


---

Celem siductiona jest 100% zgodność z Debianem sid, jakkolwek siduction może dostarczać od czasu do czasu chwilowe ważne poprawki (hot-fixes). Repozytorium siductiona posiada specificzne dla siductiona pakiety, które obejmują jądro siductiona, skrypty, narzędzia i dokumentację.

### Ważne strony

`Jest kilka stron, które nowi użytkownicy linuksa albo nowi użytkownicy siductiona powinni przeczytać. Ten plik jest jedną z nich. Pozostałymi są:` 

+  [Terminal](term-konsole-pl.htm#term-kon)  - Opisuje jak używać terminala i komendę sux.  
+  [Partycjonowanie](part-gparted-pl.htm#partition)  - Opisuje jak dzielić na partycje Twój dysk.   
+  [Instalacja siductiona (HD)](hd-install-pl.htm#install-prep)  - Opisuje jak dokonać instalacji na dysk twardy.  
+  [Instalacja siductiona (USB)](hd-install-opts-pl.htm#usb-hd)  - Opisuje jak dokonac instalacji na pena USB/SD/kartę flash.  
+  [Zapis siductiona na pena](hd-ins-opts-oos-pl.htm#usb-hd#raw-usb)  - Opisuje jak zapisać siductiona na pena lub kartę SD/flash zamiast na CD/DVD.  
+  [Nie-wolne sterowniki i źródła](gpu-pl.htm)  - Opisuje jak dostosować listę źródeł i zainstalować nie-wolne sterowniki.  
+  [Podłączenie Internetu](inet-ceni-pl.htm#netcardconfig)  - Opisuje jak osiagnąć połaczenie z Internetem.  
+  [Apt i uaktualnianie dystrybucji (dist-upgrade)](sys-admin-apt-pl.htm#apt-cook)  - Opisuje jak zainstalować dodatkowe oprogramowanie i jak wykonać uaktualnienie dystrybucji (dist-upgrade).  

##### Stabilność Debian sid 

sid jest nazwą określającą niestabilne repozytoria Debiana. Repozytoria Debiana sid są bardzo często aktualizowane po to, aby pozostac na bieżąco z szybko rozwijajacym sie oprogramowaniem. Skrocenie czasu pomiedzy powstaniem oprogramowania a jego dystrybucją w Debian sid powoduje że niemożliwym staje się jego dokładne przetestowanie 

#### Jądro siduction 

Jądro linuxa zostalo zoptymalizowane dla siduction po to, żeby pomóc osiągnąć nastepujące cele: rozwiązanie problemów, rozszerzenie i dodanie nowych funkcji, osiągnięcie wyższej wydajności i większej stabilności. Jądro siduction jest zawsze bazowane na  [http://www.kernel.org/.](http://www.kernel.org/) . 

Listę serverów lustrzanych z jądrem linuksa można znaleźć tutaj:  [Aktualizacja jądra](sys-admin-kern-upg-pl.htm#kern-upgrade) 

#### Zarządzanie pakietami 

siduction jest zgodny z systemem pakietów Debiana i używa apt i dpkg do zarządzania pakietami z repozytoriów Debiana i innych repozytoriów wskazanych przez pliki w `/etc/sources.list.d/*` 

Repozytoria Debian sid zawierają ponad 20,000 pakietów, tak więc istnieją duże szanse znalezienia własciwego pakietu. Instrukcje wyszukiwania pakietów znajdują sie tutaj  [Szukanie pakietu przy pomocy apt-cache](sys-admin-apt-pl.htm#apt-cache)  or with  [Debian Package Search GUI application](sys-admin-apt-pl.htm#gui-pacsea) .

Pakiety instaluje się komendą `apt-get install <nazwa pakietu>`  Patrz także  [Instalacja nowego pakietu](sys-admin-apt-pl.htm#apt-install) 

Repozytoria Debiana sid mogą być uaktualniane nawet do czerech razy dziennie dlatego wykonanie `apt-get update`  jest konieczne zawsze przed instalacją nowego pakietu lub przed uruchomieniem aktualizacji systemu przez `apt-get dist-upgrade`  po to, aby lista dostępnych pakietów była zgodna z najnowszą listą na serwerze repozytoriów. 

###### Użycie repozytoriów innych dystrybucji bazujących na Debianie, Źródła i RPMy

Instalowanie ze źródeł nie jest wspierane. Jeżeli naprawdę chcesz kompilować ze źródła, rób to jako użytkownik, i przechowuj programy w katalogu /home bez instalowania do systemu. Używanie checkinstall oraz konwertowanie RPM-ów z użyciem alien (i innych) do postaci .deb także nie jest wspierane.

Inne dobrze (także mniej) znane dystrybucje bazujące na Debianie przepakowywujące pakiety Debiana do swoich własnych repozytoriów, często używają dla różnych aplikacji odmiennych lokalizacji plików co może powodować niestabilną pracę systemu lub niemożność zainstalowania różnych pakietów, ze względu na brak zaleźności pomiędzy pakietami lub odmiennymi numeracjami wersji. Przykładowo różne wersje glibc mogą spowodować, że żaden program nie wystartuje.

Użyj repozytoriów Debiana, aby zainstalować wymagane pakiety oprogramowania, ponieważ inne repozytoria najprawdopodobniej nie będą mogły być wspierane.

#### Uaktualnienie systemu - dist-upgrade

`apt-get dist-upgrade`  jest zalecanym sposobem uaktualniania siduction. Nie zaleca się natomiast używania do aktualizacji żadnych programów z graficzną powłoką.  [Aktualizacja zainstalowanego systemu - dist-upgrade](sys-admin-apt-pl.htm#apt-upgrade) 

Polecenie dist-upgrade powinno być wykonywana tylko poza graficzną powłoką X. Uruchamienie init 3 z graficznego menedżera (KDE, XFCE, itd.) lub w wirtualnym terminalu (ctrl+alt+f1, ctrl+alt+f2, itd.) spowoduje zatrzymanie X-ów i pozwoli bezpiecznie aktualizować system.

#### Konfiguracja sieci 

`Ceni`  jest narzędziem do szybkiej konfiguracji sieci przewodowej LAN jak i bezprzewodowej WLAN. Program zawiera skrypty możliwiające skanowanie dostępnych sieci bezprzewodowych, zabezpieczanie sieci WEP, WPA lub używania wpa_supplicant dla konfiguracji WLAN. Ethernet, jeżeli używa DHCP (automatczne przydzielanie adresu IP) jest przepuszczany. Możliwa jest także ręczna konfiguracja sieci począwszy od netmask do nameserver. 

Ceni uruchamia się komendą `Ceni`  lub `ceni` . Jeżeli program nie jest zainstalowany, możesz zrobić to za pomocą komendy apt-get install ceni. 

 [Konfiguracja sieci - Ceni](inet-ceni-pl.htm#netcardconfig) 

#### Poziomy uruchamiania - init

Poziomy uruchamiania siduction różnią się od debiana patrz:  [Poziomy uruchamiania siduction - init](sys-admin-gen-pl.htm#init) 

##### Inne menedżery okien

KDE, XFCE oraz fluxbox są standardem dla siduction. Obecnie, Gnome nie jest obsługiwane przez siduction. Niektórzy z użytkowników forum /wiki oraz IRC mają już pewne doświadczenia w tym temacie i mogliby pomóc, w innym przypadku jesteście zdani na siebie. 

#### IRC oraz pomoc na Forum 

Nie obawiaj się poprosić o pomoc poprzez IRC lub na forum:

+  [Gdzie szukać pomocy](help-pl.htm#help-gen)    
+  [Bezpośredni dostęp do Web IRC](http://thegrebs.com/oftc/)  wpisz swój nick i przyłącz się do kanału #siduction  

<div id="rev">Strona ostatnio modyfikowana 05/12/2010 0725 UTC</div>
