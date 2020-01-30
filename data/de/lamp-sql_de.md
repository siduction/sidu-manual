<div class="divider" id="serv-mysql"></div>

## Mysql: Konfiguration

Zunächst muss sichergestellt sein, dass folgende Zeilen in der Konfigurationsdatei apache2.conf (oder in der Datei conf.d/php.ini) nicht mit einer Raute versehen sind. Falls dem so ist:

~~~
# extension=php_mysql.so
~~~

muss dies geändert werden in:

~~~
extension=php_mysql.so
~~~

Die Konfigurationsdatei von mysql befindet sich in: /etc/mysql/my.cnf

In der Grundeinstellung erstellt mysql Benutzer als Root und läuft ohne Passwort. Um das Root-Passwort zu ändern, wird folgendes gemacht:

~~~
mysql> USE mysql;
mysql> UPDATE user SET Password=PASSWORD('neues_passwort') WHERE user='root';
mysql> FLUSH PRIVILEGES;
~~~

### Um einen User anzulegen

Da nie das Root-Passwort benutzt werden soll, muss ein Benutzer angelegt werden, um mittels PHP-Skript auf die mysql-Datenbank zuzugreifen. Alternativ können Benutzer über Kontrollprogramme wie phpMyAdmin angelegt werden, um auf einfache Weise Zugriffsberechtigungen auf die Datenbank erstellen oder adaptieren zu können.

Um auf die Browserschnittstelle zugreifen zu können, muss Folgendes in die URL-Zeile des Browsers eingegeben werden:

~~~
http://ipaddress/phpmyadmin/
~~~

Bei Nachfrage nach Nutzername und Passwort müssen der Datenbank-Root-Name und das dazugehörige Passwort eingegeben werden (in der Grundeinstellung gibt es kein Passwort für den Datenbank-Root-User).

Quellen:

[http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/)  
[http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html)  
[http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Page last revised 12/01/2012 2145 UTC</div>
