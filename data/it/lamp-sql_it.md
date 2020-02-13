<div id="main-page"></div>
<div class="divider" id="serv-mysql"></div>
## MySQL Setup

Assicuratevi di decommentare nel file apache2.conf (o nel file /etc/php5/apache2/php.ini):

~~~  
#extension=php_mysql.so  
~~~

Quindi, avrete:

~~~  
extension=php_mysql.so  
~~~

Il file di configurazione di mysql si trova in: /etc/mysql/my.cnf

Secondo la configurazione predefinita, MySQL crea l'utente come root e non richiede una password. Per inserire la password di root:

~~~  
mysql> USE mysql;  
mysql> UPDATE user SET Password=PASSWORD('nuova-password') WHERE user='root';  
mysql> FLUSH PRIVILEGES;  
~~~

##### Creare un utente

Per accedere al database MySQL da uno script PHP, non utilizzate mai la password di root: create un utente per quell'uso. In alternativa, potete aggiungere utenti al database MySQL usando un pannello di controllo come phpMyAdmin per creare o assegnare facilmente i permessi del database agli utenti.

Per accedere all'interfaccia di phpMyAdmin scrivete nel browser web:

~~~  
http://ipaddress/phpmyadmin/  
~~~

Quando vi verranno chiesti il nome utente e la password immettete root come nome utente e la password (per default non ci sono password per l'utente root del database)

Fonti:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/2.0/misc/security_tips.html](http://httpd.apache.org/docs/2.0/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 15/03/2012 1200 UTC</div>
