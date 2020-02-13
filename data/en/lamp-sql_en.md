<div id="main-page"></div>
<div class="divider" id="serv-mysql"></div>
## Mysql Setup

Make sure you have all the following lines need to uncomment somewhere in your apache2.conf (or in your conf.d/php.ini) file:

~~~  
#extension=php_mysql.so  
~~~

So this becomes

~~~  
extension=php_mysql.so  
~~~

The configuration file of mysql is located at: /etc/mysql/my.cnf

By default mysql creates user as root and runs with no password. To change Root Password

~~~  
mysql> USE mysql;  
mysql> UPDATE user SET Password=PASSWORD('new-password') WHERE user='root';  
mysql> FLUSH PRIVILEGES;  
~~~

##### To Create User

To access the mySQL database from PHP script, you must never use the root password, you need to create a user for that purpose. Alternatively you can add users to mysql database by using a control panel like phpMyAdmin to easily create or assign database permission to users.

To access the web interface type the following in you web browser and enter:

~~~  
http://ipaddress/phpmyadmin/  
~~~

When it prompts for username and password enter the database root as username and enter the password (By default there is no password for database root user)

Sources:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 12/01/2012 2200 UTC</div>
