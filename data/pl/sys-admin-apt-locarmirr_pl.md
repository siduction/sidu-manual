<div id="main-page"></div>
<div class="divider" id="approx"></div>
## Aktualizacja systemu (dist-upgrade) przy niskiej szerokości pasma lub niskiej prędkości połączenia

Użytkownicy z ograniczeniami w szerokości pasma/prędkości/transferu danych lub użytkownicy posiadających więcej niż jeden komputer mają możliwość aktualizowania koputerów przez LAN. 

Rozwiązaniem jest tworzenie lokalnego serwera archiwalnego na komputerze, przez którego się aktualizuje innych komputerów w sieci LAN, w celu oszczędzania szerokości pasma oraz transferu danych z internetu. 

<!--There are various caching solutions to suit your needs: approx, apt-cacher, and squid to name just 3. siduction recommends approx.

-->
### Warunki

6 GB wolnego miejsca w pamięci na cache.

## Korzystanie z approx jako lokalnego serwera archiwalnego

Jeżeli klient komputer żąda pakiety, one są oferowane z cache, zakładając, że `apt-get update` , `dist-upgrade -d`  lub `dist-upgrade`  zostały przeprowadzone na `serwerze approx` .

#### Krok 1: Konfiguracja serwera approx

~~~  
apt-get install approx  
~~~

~~~  
mcedit /etc/approx/approx.conf  
~~~

`approx.conf`  ma użyć serwery lustrzane (online):

~~~  
# Here are some examples of remote repository mappings.  
# See http://www.debian.org/mirror/list for mirror sites.  
debian http://ftp.iinet.net.au/debian/ `<< zmieniaj do swojego lokalnego serwera debian   
siduction http://siduction.net/debian/  
~~~

`Ta sama składnia jest używana dla wszystkich repozytoriów, które są pobierane.` 

Start serwera approx z:

~~~  
update-inetd --enable approx  
~~~

Jeśli to nie wystarczy (approx czasami jest uparty przy uruchomieniu), należy ponownie uruchomić komputer z serwerem approx.

Po ponownym uruchomieniu wykonuje się `apt-get update`  oraz `dist-upgrade`  lub `dist-upgrade -d` . Gwarantuje to, że komputery klienckie mogą uzyskać dostęp do najnowszych pakietów. Powyższe nie ma zastosowania do zainstalowanych pakietów z nie-definiowanych repozytoriów. 

Pakiety można znaleźć po pierwszym dostępu klienta w `/var/cache/approx` .

#### Krok 2: Konfigurowanie klientów do korzystania serwera approx

Najpierw zmieni się `/etc/apt/sources.list.d/*.list` , aby approx jest używany jako serwer lustrzany dla Debian i siduction. 

<!--###### This para is most likely complete and utter rubbish, but put here as a reminder maybe better adding an approx.list and renaming the debian and siduction .lists 

<p></p>-->
Z edytorem, takim jak mcedit, trzeba dodać `#`  (na początku linii z adresami URL), aby je " wyłączyć", i potem dodać następujące linie:

###### Debian sources list

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

~~~  
#deb your current debian mirror (twój lokalny serwer debian)  
deb http://approx:9999/debian/ sid main contrib non-free  
~~~

###### siduction sources list

~~~  
mcedit /etc/apt/sources.list.d/siduction.list  
~~~

~~~  
#deb your current siduction mirror (twój lokalny serwer siduction)  
deb http://approx:9999/siduction/ sid main fix.main  
~~~

###### Inne sources lists

Dla innych plików sources.list, ta sama procedura jest stosowana. 

###### Proxy do dostępu na serwerze

Następnie trzeba edytować `/etc/hosts` , aby dodać lokalnego serwera proxy, aby umożliwić dostęp do adresu IP serwera: 

~~~  
mcedit /etc/hosts  
~~~

~~~  
10.1.1.X approx  
~~~

Teraz uruchom `apt-get update`  oraz `dist-upgrade`  lub `dist-upgrade -d` . Pierwsze uruchomienie na każdym z komputerów klienckich będzie wolne, a nawet może się przerywać z "time out", więc spróbuj ponownie. Kolejne dostępy powinni być szybsze i prawidłowe.

<!--<div class="divider" id="apt-cache2"></div>
## Apt-cacher

 

<div class="divider" id="apt-cache3"></div>
## Squid

 

</div>-->
<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
