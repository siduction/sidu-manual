<div id="main-page"></div>
<div class="divider" id="serv-php"></div>
## PHP Support For Apache2

Make sure you have all the following lines need to uncomment somewhere in your apache2.conf (or in your conf.d/php.ini) file:

~~~  
LoadModule php5_module modules/libphp5.so  
~~~

~~~  
# Cause the PHP interpreter to handle files with a .php extension.  
AddType application/x-httpd-php .php  
~~~

If you want to allow the different index files types check for the following line in /etc/apache2/apache2.conf file

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Restart the apache server

~~~  
#/etc/init.d/apache2 restart  
~~~

Sources:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 12/01/2012 1400 UTC</div>
