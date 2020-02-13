<div id="main-page"></div>
<div class="divider" id="serv-php"></div>
## Suport PHP pentru Apache2

Asiguraţi-vă că există toate aceste linii în fişierul apache2.conf (sau în conf.d/php.ini) : 

~~~  
LoadModule php5_module modules/libphp5.so  
~~~

~~~  
# Cause the PHP interpreter to handle files with a .php extension.  
AddType application/x-httpd-php .php  
~~~

Dacă doriţi să permiteţi diferite tipuri de fisiere index verificaţi dacă aveţi următoarea linie în fişierul /etc/apache2/apache2.conf

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Restartaţi serverul apache

~~~  
#/etc/init.d/apache2 restart  
~~~

Surse :

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 30/11/2012 0900 UTC</div>
