<div id="main-page"></div>
<div class="divider" id="serv-php"></div>
## Wsparcie PHP dla Apache2

Upewnij się, że masz wszystkie poniższe linie w swoim apache2.conf (lub w conf.d/php.ini): 

~~~  
LoadModule php5_module modules/libphp5.so  
~~~

~~~  
# Powoduje, że interpreter PHP zostaje skojarzony z plikami z rozszerzeniem .php  
AddType application/x-httpd-php .php  
~~~

Jeśli chcesz pozwolić na różne typy plików index, sprawdź, czy masz następującą linię w pliku /etc/apache2/apache2.conf

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Uruchom ponownie serwer apache

~~~  
#/etc/init.d/apache2 restart  
~~~

Źródła:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
