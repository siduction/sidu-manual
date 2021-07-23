% LAMP - PHP

## PHP einrichten

PHP ist in siduction nach der Installation mit der standardmäßigen Konfiguration sofort einsatzfähig.  

### PHP im Dateisystem

Debian hat die Dateien von PHP entsprechend ihrer Funktion vollständig in das Dateisystem integriert.

+ In **/usr/bin/** das ausführbare Programm *php7.x*  
    + und der Link *php*, der über */etc/alternatives/php* auf */usr/bin/php7.x* verweist.  
+ In **/usr/lib/php/** die installierten Module.  
+ In **/usr/share/php/** und **/usr/share/php\<Modul\>** gemeinsam genutzte Programmteile und Module.  
+ In **/etc/php/** die Konfigurationsverzeichnisse und -dateien.  
+ In **/var/lib/php/** der zur Laufzeit aktuelle Zustand der Module und Sessions.

### PHP-Unterstützung für Apache2

Standardmäßig lädt der Apache Webserver die Unterstützung für PHP. Wir überprüfen das mit:
(dabei ist im Folgenden das x mit der dem Minor-Attribut der aktuell verwendeten PHP-Version zu ersetzen, also etwa 7.4)
~~~
# ls /etc/apache2/mods-enabled/* | grep php
/etc/apache2/mods-enabled/php7.x.conf
/etc/apache2/mods-enabled/php7.x.load
~~~

und erkennen, dass Apache das PHP-Modul für die Version 7.x geladen hat. Damit der PHP-Interpreter veranlasst wird, Dateien mit der Endung "*.php*" zu verarbeiten, muss in der Apache Konfigurationsdatei *dir.conf* die Direktive *DirectoryIndex* den Wert *index.php* enthalten. Auch das prüfen wir:

~~~
# cat /etc/apache2/mods-available/dir.conf
<IfModule mod_dir.c>
    DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm
</IfModule>
~~~

Der Verwendung von PHP steht nichts im Wege, denn wir sehen das der Wert *index.php* enthalten ist.

### PHP Konfiguration

Das Verzeichnis */etc/php/7.x/* enthält die Konfiguration geordnet nach den zur Verfügung stehenden Interfaces.  
Die Ausgabe zeigt den Zustand nach der Erstinstallation.

~~~
# ls -l /etc/php/7.x/
insgesamt 20
drwxr-xr-x 3 root root 4096 18. Dez 16:54 apache2
drwxr-xr-x 3 root root 4096 18. Dez 16:54 cli
drwxr-xr-x 2 root root 4096 18. Dez 16:54 mods-available
~~~

Mit den weiter unten installierten Modulen *php7.x-cgi* und *php7.x-fpm* sind zwei neue Verzeichnise hinzugekommen.

~~~
# ls -l /etc/php/7.x/
insgesamt 20
drwxr-xr-x 3 root root 4096 18. Dez 16:54 apache2
drwxr-xr-x 3 root root 4096  1. Feb 21:23 cgi
drwxr-xr-x 3 root root 4096 18. Dez 16:54 cli
drwxr-xr-x 4 root root 4096  1. Feb 21:23 fpm
drwxr-xr-x 2 root root 4096  1. Feb 13:22 mods-available
~~~

Jedes der Verzeichnisse *apache2*, *cgi*, *cli* und *fpm* enthält einen Ordner *conf.d* und eine Datei *php.ini*.  
Die jeweilige *php.ini* beinhaltet die Konfiguration für das entsprechende Interface und kann bei Bedarf geändert oder ergänzt werden. Der Ordner *conf.d* enthält die Links zu den aktivierten Modulen.

### PHP Module

**Abfragen**

Für PHP steht eine Vielzahl von Modulen zu Verfügung. Welche bereits installiert wurden, erfährt man mit

~~~
# dpkg-query -f='${Status}\ ${Package}\n' -W php7.4* | grep '^install'
install ok installed php7.4
install ok installed php7.4-bz2
install ok installed php7.4-cli
install ok installed php7.4-common
install ok installed php7.4-curl
install ok installed php7.4-gd
install ok installed php7.4-imagick
install ok installed php7.4-json
install ok installed php7.4-mbstring
install ok installed php7.4-mysql
install ok installed php7.4-opcache
install ok installed php7.4-readline
install ok installed php7.4-xml
install ok installed php7.4-zip
~~~

Um verfügbare, aber nicht installierte Module anzuzeigen, schreiben wir die Suche am Ende etwas um:

~~~
# dpkg-query -f='${Status}\ ${Package}\n' -W php7.4* | grep 'not-install'
unknown ok not-installed php7.4-calendar
unknown ok not-installed php7.4-cgi
unknown ok not-installed php7.4-ctype
unknown ok not-installed php7.4-dom
unknown ok not-installed php7.4-exif
unknown ok not-installed php7.4-ffi
unknown ok not-installed php7.4-fileinfo
unknown ok not-installed php7.4-fpm
unknown ok not-installed php7.4-ftp
unknown ok not-installed php7.4-gettext
unknown ok not-installed php7.4-iconv
unknown ok not-installed php7.4-pdo
unknown ok not-installed php7.4-pdo-mysql
unknown ok not-installed php7.4-phar
unknown ok not-installed php7.4-posix
unknown ok not-installed php7.4-shmop
unknown ok not-installed php7.4-simplexml
unknown ok not-installed php7.4-sockets
unknown ok not-installed php7.4-sysvmsg
unknown ok not-installed php7.4-sysvsem
unknown ok not-installed php7.4-sysvshm
unknown ok not-installed php7.4-tokenizer
unknown ok not-installed php7.4-xsl
~~~

Jetzt kennen wir die genauen Bezeichnungen der Module.

**Info**

Ausführlichere Beschreibungen zu den Modulen liefert der Befehl

~~~
# apt show <Modulname>
~~~

**Installation**

Um Module zu installieren verwenden wir z.B.:

~~~
# apt install php7.x-cgi php7.x-fpm
~~~

Die beiden Module unterstützen CGI-Scripte und Fast/CGI Requests.  
Anschließend starten wir den Apache neu:

~~~
# systemctl restart apache2.service
~~~

**Handling**

Der Zustand der PHP-Module ist während der Laufzeit veränderbar. Das ermöglicht auch die Steuerung von Modulen in Scripten um sie vor der Verwendung zu laden und nachher wieder zu entladen.

+ **phpenmod** – aktiviert Module in PHP  
+ **phpdismod** – deaktiviert Module in PHP  
+ **phpquery** – Zeigt den Status der PHP Module

Nicht benötigte Module (im Beispiel imagick) deaktiviert in der Konsole der Befehl

~~~
# phpdismod imagick
~~~

Um das Modul *imagick* für alle Iterfaces zu laden, dient der Befehl

~~~
# phpenmod imagick
~~~

Verwenden wir die Option "*-s apache2*"

~~~
# phpenmod -s apache2 imagick
~~~

wird das Modul nur für Apache2 geladen.

Die Statusabfrage mit *phpquery* erfordert immer die Angabe der Modulversion und des Interface. Hier einige Beispiele:

~~~
# phpquery -v 7.4 -s apache2 -m zip
zip (Enabled for apache2 by maintainer script)

# phpquery -v 7.4 -s cli -m zip
zip (Enabled for cli by maintainer script)

# phpquery -v 7.4 -s fpm -m zip
zip (Enabled for fpm by maintainer script)

# phpquery -v 7.4 -s apache2 -m imagick
imagick (Enabled for apache2 by local administrator)
~~~

Bei dem Modul *imagick* zeigt uns der String "*Enabled for apache2 by local administrator*", dass es nicht wie das *zip*-Modul automatisch beim Start geladen wurde, sondern dass der Administrator es manuell aktiviert hat. Die Ursache liegt in den zuvor benutzten Befehlen *phpdismod* und *phpenmod* für diese Modul.

### Apache Log

Der Apache Server speichert die Fehlermeldungen von PHP in seinen Log-Dateien unter */var/log/apache2/*. Gleichzeitig erscheint bei fehlerhaften PHP-Funktionen eine Meldung in der aufgerufenen Webseite.  
Alternativ lassen wir uns die Log-Funktionen anzeigen.

~~~
# php --info | grep log
[...]
error_log 			=> no value
log_errors 			=> On
log_errors_max_len 	=> 1024
mail.log 			=> no value
opcache.error_log 	=> no value
[...]
~~~

In den Dateien */etc/php/7.x/\<Interface\>/php.ini* haben wir die Möglichkeit die nicht gesetzten Werte durch eigene, tatsächlich vorhandenen Logdateien zu ersetzen.

### Quellen PHP

[PHP - deutsches Handbuch](https://www.php.net/manual/de/)  
[PHP - aktuelle Meldungen](https://www.php.net/)  
[tecadmin - Modulhandling](https://tecadmin.net/enable-disable-php-modules-ubuntu/) (englisch)

<div id="rev">Zuletzt bearbeitet: 2021-07-20</div>
