<div id="main-page"></div>
<div class="divider" id="serv-php"></div>
## Suporte PHP para Apache2

Confirme que você possui as linhas seguintes em seu arquivo apache2.conf (ou no arquivo conf.d/php.ini): 

~~~  
LoadModule php5_module modules/libphp5.so  
~~~

~~~  
# Cause the PHP interpreter to handle files with a .php extension ('Permite ao interpretador PHP gerenciar arquivos com extensão .php')  
AddType application/x-httpd-php .php  
~~~

Se você quiser permitir diferentes tipos de arquivos de índice, assegure-se de que a seguinte linha está presente no arquivo /etc/apache2/apache2.conf:

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Reinicie o servidor Apache:

~~~  
#/etc/init.d/apache2 restart  
~~~

Fontes:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
