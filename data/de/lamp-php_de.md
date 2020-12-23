% LAMP - PHP

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2020-12:

+ Inhalt überarbeitet.
+ Für die Verwendung mit pandoc optimiert. 

ENDE   INFOBEREICH FÜR DIE AUTOREN

---

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
# sevice apache2 restart
~~~

---

## Module

Nach installierbaren Modulen suchen:

~~~
# apt-cache search php7.4 | less
~~~

mit den Pfeiltasten durchsuchen wir die Liste nach den gewünschten Modulen. Um eine Beschreibung anzuzeigen benutzen wir:

~~~
# apt show <Modulname>
~~~

Um Module zu installieren:

~~~
# apt install php7.4-curl php7.4-intl php7.4-imap php-memcache php-memcached
~~~

Anschließend starten wir den Apache neu:

~~~
# service apache2 restart
~~~

Quellen:

[http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/)  
[http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html)  
[http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Zuletzt bearbeitet: 2020-12-09</div>
