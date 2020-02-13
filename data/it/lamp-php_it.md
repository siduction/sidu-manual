<div id="main-page"></div>
<div class="divider" id="serv-php"></div>
## Supporto PHP per Apache2

Assicuratevi di decommentare tutte le seguenti linee nel file apache2.conf (o nel file /etc/php5/apache2/php.ini):

~~~  
LoadModule php5_module modules/libphp5.so  
~~~

~~~  
# Permette all'interprete PHP di gestire i file con estensione .php  
AddType application/x-httpd-php .php  
~~~

Se volete permettere di usare i diversi tipi di file indice, controllate la seguente linea nel file /etc/apache2/apache2.conf :

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Riavviate il server apache:

~~~  
#/etc/init.d/apache2 restart  
~~~

Fonti:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/2.0/misc/security_tips.html](http://httpd.apache.org/docs/2.0/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 15/03/2012 0010 UTC</div>
