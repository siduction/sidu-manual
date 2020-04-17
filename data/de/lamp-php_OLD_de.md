<div class="divider" id="serv-php"></div>

## PHP-Unterstützung für Apache2

Es muss sichergestellt sein, dass all die folgenden Zeilen unkommentiert in apache2.conf (oder in conf.d/php.ini) vorhanden sind: 

~~~
LoadModule php5_module modules/libphp5.so
~~~

~~~
### Der PHP-Interpreter wird veranlasst, Dateien mit der Endung .php zu verarbeiten.
AddType application/x-httpd-php .php
~~~

Falls mehrere Arten von Index-Dateien erlaubt sein sollen, muss folgende Zeile in /etc/apache2/apache2.conf adaptiert werden.

~~~
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml
~~~

Nach den Änderungen muss der Apache-Server neu gestartet werden.

~~~
#/etc/init.d/apache2 restart
~~~

Quellen:

[http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/)  
[http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html)  
[http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Page last revised 08/01/2012 1545 UTC</div>
