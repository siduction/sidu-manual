<div id="main-page"></div>
<div class="divider" id="serv-mysql"></div>
## Konfiguracja Mysql

Upewnij się, że masz poniższą linię gdzieś w swoim pliku apache2.conf (lub w conf.d/php.ini):

~~~  
# extension=php_mysql.so  
~~~

Usuń z niej znak komentarza (#)

~~~  
extension=php_mysql.so  
~~~

Plik konfiguracyjny mysql znajduje się w: /etc/mysql/my.cnf

Domyślnie mysql tworzy użytkownika root bez hasła. Aby zmienić hasło roota:

~~~  
mysql> USE mysql;  
mysql> UPDATE user SET Password=PASSWORD('new-password') WHERE user='root';  
mysql> FLUSH PRIVILEGES;  
~~~

##### Tworzenie użytkowników

Nie należy używać hasła roota, więc powinieneś stworzyć konto użytkownika, by połączyć się z bazą danych ze skryptem PHP. Możesz dodać użytkowników przy użyciu panelu kontrolnego takiego jak phpMyAdmin.

Aby uzyskać dostęp do interfejsu, wpisz w swojej przeglądarce internetowej:

~~~  
http://ipaddress/phpmyadmin/  
~~~

Kiedy zostaniesz spytany o nazwę użytkownika i hasło, wpisz identyfikator i hasło roota (domyślnie nie ma hasła dla roota)

Źródła:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Strona ostatnio modyfikowana 14/08/2010 0100 UTC</div>
