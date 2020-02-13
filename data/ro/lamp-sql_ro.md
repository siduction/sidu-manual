<div id="main-page"></div>
<div class="divider" id="serv-mysql"></div>
## Setarea MySQL 

Asiguraţi-vă că aveţi linia următoare undeva în fişierul apache2.conf (sau în conf.d/php.ini) :

~~~  
#extension=php_mysql.so  
~~~

Deci aceasta devine 

~~~  
extension=php_mysql.so  
~~~

Fişierul de configurare pentru mySQL este localizat la : /etc/mysql/my.cnf

Implicit mySQL crează utilizatorii ca root şi rulează fără autentificare. Pentru a schimba parola de root :

~~~  
mysql> USE mysql;  
mysql> UPDATE user SET Password=PASSWORD('new-password') WHERE user='root';  
mysql> FLUSH PRIVILEGES;  
~~~

##### Creerea unui utilizator mySQL 

Pentru accesarea bazei de date mySQL dintr-un script PHP, NU trebuie să folositi NICIODATĂ parola de root. Pentru acest scop va trebui să creaţi un utilizator care să se poată fae asta . Ca alternativă puteţi adăuga utilizatori la baza de date mySQL folosind un panou de control ca phpMyAdmin care poate crea sau atribui foarte uşor permisiuni utilizatorilor bazei de date .

Pentru a accesa interfaţa web tastaţi următoarele în browserul dumneavoastră :

~~~  
http://ipaddress/phpmyadmin/  
~~~

Când vi se va cere username şi password introduceţi database root ca username şi apoi parola (implicit nu există parolă pentru utilizatorul database root )

Surse :

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Page last revised 30/11/2012 0900 UTC</div>
