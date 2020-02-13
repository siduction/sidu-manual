<div id="main-page"></div>
<div class="divider" id="serv-apache"></div>
## La catena LAMP in siduction

L'acronimo LAMP fa riferimento a un insieme di programmi liberi comunemente usati per far funzionare siti o server web dinamici:  
Linux, il sistema operativo  
Apache, il server web  
MySQL, il sistema di gestione dei database (o server database)  
Perl, PHP, e/o Python, i linguaggi di scripting

##### ATTENZIONE: Non usate mai il PC dedicato al lavoro quotidiano come server web! Utilizzate piuttosto un PC dedicato per quella funzione e non usatelo per altro!

Usi di un server:  
a) `un server locale di prova per progettisti web senza connessione internet, che è lo scopo che qui ci ripromettiamo di trattare;`   
b) un server privato "chiuso" connesso alla rete;  
c) un server web privato pienamente accessibile da internet,  
d) un server web commerciale, cosa peraltro al di là dello scopo di questo manuale.

##### Requisiti minimi

Almeno 256 Mb di RAM. Una quantità inferiore può causare molti problemi in quanto un server MySQL richiede molta RAM per funzionare correttamente. MySQL fornirà un errore del tipo "cannot connect to mysql.sock", cioè "non posso connettermi a mysql.sock", se la memoria disponibile non è sufficiente.

I pacchetti che devono essere installati sono:

~~~  
apache2  
apache2-utils  
apache2-mpm-prefork  
php5 php5-common  
mysql-server  
mysql-common  
libapache2-mod-php5  
php5-mysql  
phpmyadmin  
~~~

**`ATTENZIONE! Eseguite il seguente comando:`**

~~~  
apt-get remove --purge splashy  
~~~

**`in quanto splashy va sempre in conflitto con MySQL.`**

Il file di configurazione di Apache si trova in:`/etc/apache2/apache2.conf`  e la directory web è `/var/www` . Non modificate le impostazioni predefinite di debian per 'mpm-worker/mpm-prefork' perché sono corrette.

Per controllare se php è installato e avviato correttamente, create semplicemente un file test.php nella cartella /var/www che includa la funzione phpinfo() esattamente come mostrato qui di seguito:

~~~  
mcedit /var/www/test.php  
# test.php  
<? phpinfo(); ?>  
~~~

Indirizzate il browser web su:

~~~  
http://localhost/test.php  
oppure  
http://vostro_indirizzo_IP:80/test.php  
~~~

Dovrebbe così esser visualizzata tutta la vostra configurazione di php e le impostazioni predefinite.

Potrete modificare i valori che interessano e impostare dei domini virtuali usando il file di configurazione di apache.

Se volete verificare l'installazione, aprite un browser web e digitate nella barra degli indirizzi:

~~~  
http://vostro_indirizzo_IP/apache2-default/  
~~~

Se è visualizzato un messaggio di benvenuto, l'installazione è corretta.

La directory "root" predefinita dei documenti per apache2 è `/var/www` . Cambiatela in:

~~~  
mkdir /home/myself/www  
ln -s /home/myself/www /var/www  
~~~

Con questi comandi potrete modificare il vostro sito web nella directory home come utente normale.

<div class="divider" id="serv-ftp"></div>
## Programmi FTP

Usate SSH e leggete attentamente in questo manuale  [il capitolo SSH](ssh-it.htm) ; siduction ha anche un altro FTP client al suo interno, la funzionalità ftp di Konqueror che permette l'invio di file ai server.

<div class="divider" id="serv-sec"></div>
## Abilitare protocolli di sicurezza validi per i server web

### Il firewall

**`Senza un firewall non c'è assolutamente sicurezza per il server. Ricordate di bloccare TUTTO fino a che non vi serve qualcosa: sbloccatela a quel punto, usatela e poi bloccatela nuovamente!`** 

~~~  
21 (ftp)  
22 (SSH)  
25 110 (email)  
443 (SSL http o https)  
993 (imap ssl)  
995 (pop3 ssl)  
80 (http)  
e qualsiasi altra porta disponibile!  
~~~

### Proteggere in via predefinita i file del server

Un aspetto a volte incompreso di Apache è la funzionalità dell'accesso predefinito, cioè, se non si fa qualcosa per cambiarlo, il modo in cui il server può trovare il percorso verso un file attraverso le normali regole che mappano gli URL, e quindi inviarlo ai client che hanno richiesto quegli URL.

Consideriamo il seguente esempio:

~~~  
1. # cd /; ln -s / public_html  
2. Accessing http://localhost/~root/  
~~~

**`Ciò consentirebbe ai client di muoversi "a piacimento" attraverso l'intero filesystem! Per impedire l'evento, aggiungete il seguente blocco alla configurazione del server:`**

~~~  
<Directory />  
Order Deny,Allow  
Deny from all  
</Directory>  
~~~

Questa impostazione impedirà l'accesso predefinito a locazioni del filesystem. Aggiungete dei corretti blocchi di &lt;Directory&gt; per permettere l'accesso solo alle aree volute. Ad esempio:

~~~  
<Directory /usr/users/*/public_html>  
Order Deny,Allow  
Allow from all  
</Directory>  
<Directory /usr/local/httpd>  
Order Deny,Allow  
Allow from all  
</Directory>  
~~~

Ponete particolare attenzione all'interazione delle direttive &lt;Location&gt; e &lt;Directory&gt;; per esempio, anche se &lt;Directory /&gt; nega l'accesso, una direttiva &lt;Location /&gt; potrebbe sovrascriverla.

Siate anche guardinghi nel far girare giochi con la direttiva UserDir; impostarla in modo tipo "./" potrebbe avere lo stesso effetto, per root, come il primo esempio sopra. Se state usando Apache 1.3 o una versione superiore, vi raccomandiamo fortemente di includere la seguente linea nei file di configurazione del server:

~~~  
UserDir disabled root  
~~~

<div class="divider" id="serv-ssl"></div>
## SSL

Avviare lo script "apache2-ssl-certificate":

~~~  
# apache2-ssl-certificate  
~~~

Apparirà la seguente schermata dove potrete inserire tutte le informazioni richieste.

~~~  
Creating self-signed certificate  
replace it with one signed by a certification authority (CA) enter your ServerName at the Common Name prompt. If you want your certificate to expire after x days call this programm  
with -days x  
-----  
Generating a 1024 bit RSA private key  
--------  
writing new private key to '/etc/apache2/ssl/apache.pem'  
--------  
You are about to be asked to enter information that will be incorporated into your certificate request.  
-----------  
What you are about to enter is what is called a Distinguished Name or a DN. There are quite a few fields but you can leave some blank. For some fields there will be a default value,  
----------  
If you enter '.', the field will be left blank.  
~~~

~~~  
Country Name (2 letter code) [GB]:  
State or Province Name (full name) [Some-State]:  
Locality Name (eg, city) []:  
Organization Name (eg, company; recommended) []:  
Organizational Unit Name (eg, section) []:  
server name (eg. ssl.domain.tld; required!!!) []:  
Email Address []:  
~~~

Avviate lo script "a2enmod ssl":

~~~  
# a2enmod ssl  
~~~

Ciò creerà automaticamente un collegamento simbolico tra mods-available e mods-enabled.

Fate una copia del file "/etc/apache2/sites-available/default" nella cartella /etc/apache2/sites-available/ e chiamatelo "ssl":

~~~  
# cp /etc/apache2/sites-available/default /etc/apache2/sites-available/ssl  
~~~

Create un collegamento simbolico al nuovo file per questo uso:

~~~  
# ln -s /etc/apache2/sites-available/ssl /etc/apache2/sites-enabled/  
oppure  
# a2ensite ssl  
~~~

Se volete cambiare una qualsiasi impostazione della configurazione di base, fatelo in /etc/apache2/apache2.conf; se volete cambiare la root dei documenti predefinita, fatelo nel file /etc/apache2/sites-available/default e riavviate il server apache.

Per riavviare il server Apache usate il seguente comando:

~~~  
#/etc/init.d/apache2 restart  
~~~

Ora dovremo cambiare l'indirizzo della porta in /etc/apache2/ports.conf che in via predefinita starà in ascolto sulla porta 80, mentre ora con SSL occorre impostare l'ascolto sulla porta 443:

~~~  
Listen 443  
~~~

Modificate il file /etc/apache2/sites-available/ssl (o qualsiasi nome che avete dato al file di configurazione del nuovo sito ssl) e cambiate la porta 80 in 443 nel nome del sito.

Aggiungere le seguenti due linee da qualche parte nel file /etc/apache2/apache2.conf:

~~~  
SSLEngine On  
SSLCertificateFile /etc/apache2/ssl/apache.pem  
~~~

Modificate "SSLCertificateFile /etc/apache2/ssl/apache.pem" e immettete le locazioni del file di certificato e del file della chiave certificata. Ecco qui un esempio:

~~~  
SSLCertificateFile /etc/apache2/ssl/online.test.net.crt  
SSLCertificateKeyFile /etc/apache2/ssl/online.test.net.key  
~~~

Impostate "ServerSignature" a off, seguite questi passi e modificate il file /etc/apache2/apache2.conf aggiungendo le seguenti linee:

~~~  
ServerSignature Off  
ServerTokens ProductOnly  
~~~

Se volete permettere dei tipi di file indice differenti, controllate le seguenti linee nel file /etc/apache2/apache2.conf :

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Riavviate il server apache:

~~~  
/etc/init.d/apache2 restart  
~~~

Ora dovreste avere un server di prova, ma nel caso voleste connettervi a internet con questo **`NON FATELO! Usate un altro PC esclusivamente devoluto a essere un server web per internet!`** 

Fonti:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 14/03/2012 2000 UTC</div>
