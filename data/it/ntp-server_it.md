<div id="main-page"></div>
<div class="divider" id="ntp-server"></div>
## Configurazione del Timeserver

Per prima cosa, come root, digitate in console:

~~~  
apt-cache search ntp  
apt-get update && apt-get install ntp ntp-doc  
update-rc.d -f ntp defaults  
avviare update-rc.d dopo aver fatto un po' di configurazione  
~~~

Troverete la documentazione sul vostro sistema in:

~~~  
/usr/share/doc/ntp-doc/html/index.html  
aggiungetelo ai segnalibri!  
~~~

È una documentazione molto ampia e non tutto il suo contenuto, molto estensivo, si rende necessario.

ntp non si attiverà se non dopo il riavvio, ma dovreste ugualmente impostare l'orario vigente il più accuratamente possibile prima di riavviare.

ntp preleverà l'orario dalla lista di server presente in /etc/ntp.conf, che è il principale file da modificare.

Sia ntpdate che il demone ntpd [chiamato ntp] interrogano i timeserver elencati all'inizio di /etc/ntp.conf. Ecco, come esempio, una lista:

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

Il primo è un'altra macchina presente sulla stessa rete, anch'essa avente in esecuzione ntp (su di essa è "server 192.168.3.1")

La seconda è il timeserver dell'ISP al quale siete connessi.

Poi ci sono un po' di uk.pool.ntp.org, poi ancora per buona fortuna un po' di timeserver europei. Per inciso, i vostri isp-nameserver sono spesso anche timeserver: potete controllarlo eseguendo:

~~~  
ntpdate -v  
~~~

Questo non cambierà nulla, ma restituirà un risultato relativo al tempo del tipo:

~~~  
# ntpdate -v 192.168.3.24  
19 Sep 19:09:27 ntpdate[13329]: ntpdate 4.2.2@1.1532-o Wed Aug 9 12:08:54 UTC 2006 (1)  
~~~

 [Un elenco completo di timeserver ntp è riportato qui http://www.pool.ntp.org/](http://www.pool.ntp.org) 

A questo punto vorrete consentire alle vostre macchine locali l'accesso:

~~~  
# Gli utenti locali potranno interrogare il server ntp più a fondo.  
restrict 127.0.0.1 nomodify  
restrict 192.168.3.0/24  
~~~

Poi vorrete fornire l'ora alla sottorete locale:

~~~  
# Se volete fornire l'ora a tutta la sottorete locale, modificate la linea seguente.  
# (Come sempre, l'indirizzo è solo un esempio.)  
broadcast 192.168.3.255  
~~~

Il file ntp.conf è di per se un po' strano e viene trattato come un diff se semplicemente vi cliccate sopra. Prima di avviare ntp, dovrete impostare il tempo, cioè:

~~~  
# ntpdate -u -b uk.pool.ntp.org  
19 Sep 19:19:33 ntpdate[15641]: step time server 62.3.200.116 offset 0.001523 sec  
~~~

Poi attivate ntp come servizio in modo che parta a ogni boot (in pratica, a ogni riavvio). Dopo un po' che ntp è stato avviato, date:

~~~  
ntpq -pn  
~~~

Se tutto è andato bene, dovreste vedere qualcosa del tipo:

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

L'asterisco nella terza linea dell'esempio, *82.219.3.1, mostra il timeserver attivo, che è la cosa più importante. Significa che l'ora è esatta e che è in uso la porta 123. Un esempio di linea iptables potrebbe essere:

~~~  
# Network Time Protocol (NTP) Server  
$IPT -A udp_inbound -p UDP -s 0/0 --destination-port 123 -j ACCEPT  
$IPT -A INPUT -j ACCEPT -p tcp --dport 123  
~~~

<div id="rev">Content last revised 17/03/2012 2220 UTC</div>
