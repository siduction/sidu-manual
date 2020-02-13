<div id="main-page"></div>
<div class="divider" id="ntp-server"></div>
## Konfiguracja serwera czasu

W konsoli jako root: 

~~~  
apt-cache search ntp  
apt-get update && apt-get install ntp ntp-doc  
update-rc.d -f ntp defaults  
uruchom później update-rc.d, po dokonaniu konfiguracji  
~~~

Znajdź dokumentację w:

~~~  
/usr/share/doc/ntp-doc/html/index.html  
i dodaj do ulubionych  
~~~

Jest to duży dokument i nie wszystko dotyczy interesujących nas kwestii.

ntp nie zostanie aktywowane do czasu ponownego uruchomienia systemu, ale powinieneś ustawić czas tak dokładnie, jak to jest możliwe przed restartem.

ntp pobierze czas z serwerów z listy /etc/ntp.conf, głównego pliku konfiguracyjnego.

ntpdate i demon ntpd pobiera listę serwerów czasu z /etc/ntp.conf. Oto przykład:

~~~  
pool.ntp.org maps to more than 100 low-stratum NTP servers.  
# Your server will pick a different set every time it starts up.  
# *** Please consider joining the pool! ***  
# ***  [http://www.pool.ntp.org/#join](http://www.pool.ntp.org/#join)  ***  
server 192.168.3.24  
server ntp.blueyonder.co.uk  
server uk.pool.ntp.org  
server 1.uk.pool.ntp.org  
server 2.uk.pool.ntp.org  
server 0.europe.pool.ntp.org  
server 1.europe.pool.ntp.org  
server 2.europe.pool.ntp.org  
~~~

Pierwszy to inny komputer w tej samej sieci, na którym działa usługa ntp [w tym przypadku to 'server 192.168.3.1']

Drugi to serwer czasu twojego ISP.

Następne to uk.pool.ntp.org i kilka europejskich serwerów czasu. Często serwer nazw pełni też funkcję serwera czasu, możesz to sprawdzić poprzez uruchomienie:

~~~  
ntpdate -v  
~~~

Polecenie nie zmieni czasu systemowego, jedynie wskaże pobrany z serwera:

~~~  
# ntpdate -v 192.168.3.24  
19 Sep 19:09:27 ntpdate[13329]: ntpdate 4.2.2@1.1532-o Wed Aug 9 12:08:54 UTC 2006 (1)  
~~~

 [A full list of ntp timeservers is here http://www.pool.ntp.org/](http://www.pool.ntp.org) 

Teraz możesz pozwolić na dostęp do twoich lokalnych systemów:

~~~  
# Local users may interrogate the ntp server more closely.  
restrict 127.0.0.1 nomodify  
restrict 192.168.3.0/24  
~~~

Następnie aktywuj serwer czasu:

~~~  
# If you want to provide time to your local subnet, change the next line.  
# (Again, the address is an example only.)  
broadcast 192.168.3.255  
~~~

Plik ntp.conf wygląda trochę dziwnie, ponieważ jest traktowany jako plik diff. Przed uruchomieniem ntp, musisz ustawić czas, np.

~~~  
# ntpdate -u -b uk.pool.ntp.org  
19 Sep 19:19:33 ntpdate[15641]: step time server 62.3.200.116 offset 0.001523 sec  
~~~

Następnie uruchom ntp jako usługę, aby była uruchamiana przy każdym starcie:

~~~  
ntpq -pn  
~~~

Jeśli wszystko poszło dobrze, powinieneś zobaczyć coś takiego:

~~~  
# ntpq -pn  
remote refid st t when poll reach delay offset jitter  
----------------------------------------------------------------------------  
192.168.3.24 .INIT. 16 u - 1024 0 0.000 0.000 0.000  
+194.117.157.4 192.5.41.40 2 u 97 128 377 7.849 1.548 30.157  
82.219.3.1 195.66.241.2 2 u 101 128 377 17.755 0.794 24.722  
82.133.58.132 .INIT. 16 u - 1024 0 0.000 0.000 0.000  
+194.153.168.75 195.66.241.3 2 u 37 128 377 23.475 3.259 12.203  
+82.68.126.114 209.81.9.7 2 u 101 128 377 44.567 -1.366 46.922  
+194.88.2.88 194.159.73.44 3 u 90 128 377 17.208 -5.569 27.527  
+130.226.232.145 213.112.52.151 3 u 89 128 377 62.130 -0.797 39.999  
127.127.1.0 .LOCL. 10 l 18 64 377 0.000 0.000 0.001  
192.168.3.255 .BCST. 16 u - 64 0 0.000 0.000 0.001  
~~~

Gwiazdka w trzeciej linii w tym przykładzie: *82.219.3.1,oznacza aktywny serwer czasu, uznawany przez system za najbardziej dokładny. Używany jest port 123. Przykładowa linia iptables dla serwera czasu:

~~~  
# Network Time Protocol (NTP) Server  
$IPT -A udp_inbound -p UDP -s 0/0 --destination-port 123 -j ACCEPT  
$IPT -A INPUT -j ACCEPT -p tcp --dport 123  
~~~

<div id="rev">Content last revised 14/08/2010 0100 UTC </div>
