% LAMP-Testserver für Entwickler (lokal)

## LAMP-Webserver

**Ein lokaler Testserver für Entwickler**

Das Akronym **LAMP** bezieht sich auf eine Reihe freier Software, die gemeinsam genutzt wird, um dynamische Websiten zu betreiben:

+ **L**inux: Betriebssystem  
+ **A**pache: Web-Server  
+ **M**ariaDb: Datenbank-Server (ab Debian 9 'Stretch', zuvor mySQL)  
+ **P**HP, Perl und/oder Python: Skriptsprachen  

Verwendungsmöglichkeiten als Server:

1. **ein lokaler Testserver für Webdesigner ohne Internetverbindung (siehe dieses Kapitel)**  
2. ein privater (Daten-)Server mit Internetverbindung  
3. ein privater Webserver mit umfassender Internetverbindung  
4. ein kommerzieller Webserver

Unser Ziel ist es, einen LAMP-Testserver für Entwickler aufsetzen, der über LAN direkt mit dem Arbeitsplatz-PC verbunden ist. Darüber hinaus soll es aus Gründen der Sicherheit für den Server keine Verbindung zu einem lokalen Netzwerk oder gar zum Internet geben.
Einzige Ausnahme: Der Server wird temporär und ausschließlich für System- und Software- Aktualisierungen über eine zweite Netzwerkschnittstelle mit dem Internet verbunden.

> Zur Beachtung:  
> Der Desktop-PC, mit dem täglich gearbeitet wird, soll nicht als Server dienen. Als Server soll ein eigener PC verwendet werden, der ansonsten keine weiteren Aufgaben erfüllt.

Im Server-PC sollte mindestens 500MB RAM Arbeitsspeicher zur Verfügung stehen. Weniger RAM wird Probleme bereiten, da ein Server mit MariaDb/MySQL viel RAM benötigt, um ansprechend zu laufen.

Die zu installierenden Pakete sind:

~~~
apache2  
mariadb-server  
mariadb-client  
php  
php7.4-mysql  
phpmyadmin  
~~~

Wie bei siduction üblich, erledigen wir die Installationen im "multi-user.target" (init 3) im Terminal.

**Vorbereitungen**

Falls der Kommandozeilenbrowser *w3m* noch nicht installiert wurde, holen wir das jetzt nach:

~~~
# apt update
# apt install w3m
~~~

Das ermöglicht es uns *Apache* und *PHP* sofort im Terminal zu testen und erst nach Abschluss aller notwendigen  Installationen wieder in die graphische Oberfläche zurückzukehren.

Nun räumen wir noch apt auf.  
Der Befehl *apt autoremove* sollte zu der folgenden Ausgabe führen. Wenn nicht, bestätigen wir das Entfernen nicht mehr benötigter Pakete mit `j`.

~~~
#apt autremove
Paketlisten werden gelesen... Fertig
Abhängigkeitsbaum wird aufgebaut.
Statusinformationen werden eingelesen.... Fertig
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
~~~

Diese Maßnahme erleichtert uns im Fall einer fehlerhaften Installation die Reparatur ganz wesentlich.  
Siehe unten [Troubleshooting](#troubleshooting)

Es ist sinnvoll sich bereits vor der Installation einige Daten zu notieren.

Während der Installation notwendig:

+ Ein **Passwort** für den Datenbankbenutzer **root** in *phpMyAdmin*.

Später, für die Konfiguration notwendig:

+ **Apache**  
    + *Server Name*
    + *Server Alias*
    + *IP-Adresse* des Servers
    + *Name* des PC
    + *IP-Adresse* des PC

+ **MariaDB:**  
    + Den *Namen der Datenbank* die für das Entwicklungsprojekt verwendet werden soll.
    + Den *Namen* (Login-Name) eines neuen Datendank-Benutzers für das Entwicklungsprojekt.
    + Das *Passwort* für den neuen Datendank-Benutzer.
    + Den *Namen* (Login-Name) eines neuen Datenbank Administrators.
    + Das *Passwort* für den Datenbank Administrator.

### Apache installieren

Die Installation des Webservers Apache erfordert nur die beiden folgenden Befehle. Der install-Befehl holt sich noch die zusätzlichen Pakete *apache2-data* und *apache2-utils* herein. Anschließend fragen wir den Status von Apache ab und testen gleich die Start- und Stop-Anweisungen.

~~~
# apt update
# apt install apache2
[...]
Die folgenden NEUEN Pakete werden installiert:
  apache2 apache2-data apache2-utils
[...]
Möchten Sie fortfahren? [J/n] j
[...]

# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2020-12-06 14:24:44 CET; 4min 8s ago
[...]
~~~

Wie zu erkennen ist, wurde Apache sofort aktiviert.

~~~
# systemctl stop apache2.service
# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Sun 2020-12-06 14:30:27 CET; 6s ago
[...]

# systemctl start apache2.service
# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2020-12-06 14:30:59 CET; 3s ago
[...]
~~~

Der Apache Webserver ist geladen und lässt sich problemlos händeln. Jetzt prüfen wir seine Funktion mit:

~~~
w3m http://localhost/index.html
~~~

Die Apache-Begrüßungsseite mit **It works!** erscheint.  
Wir beenden w3m mit `q` und bestätigen mit `y`.

Als **ServerRoot** wird das Verzeichnis **/etc/apache2/** bezeichnet. Es enthält die Konfiguration.  
Als **DocumentRoot** wird das Verzeichnis **/var/www/html/** bezeichnet. Es enthält die Dateien der Webseite.

Für weitere Informationen und Hinweise zur Absicherung bitte die Handbuchseite  
[LAMP-Apache](./lamp-apache_de.md#apache-einrichten) lesen.

### MariaDb installieren

Die Installation von MariaDb gestaltet sich ähnlich einfach in dem die Metapakete "mariadb-server" und "mariadb-client" angefordert werden.

~~~
# apt install mariadb-server mariadb-client
[...]
Die folgenden NEUEN Pakete werden installiert:  
  galera-4 libcgi-fast-perl libcgi-pm-perl libdbd-mariadb-perl libfcgi-perl libhtml-template-perl libmariadb3  
  mariadb-client mariadb-client-10.5 mariadb-client-core-10.5 mariadb-common mariadb-server mariadb-server-10.5  
  mariadb-server-core-10.5 mysql-common socat
[...]
Möchten Sie fortfahren? [J/n] j
~~~

Weitere Informationen zu MariaDb und der Konfiguration liefert unser Handbuch in [LAMP-MariaDB](./lamp-sql_de.md#mariadb-einrichten)

### PHP installieren

Zur Installation der Scriptsprache PHP genügt der Befehl:

~~~
# apt install php
[...]
Die folgenden NEUEN Pakete werden installiert:
  apache2-bin libapache2-mod-php7.4 libaprutil1-dbd-sqlite3 libaprutil1-ldap php
  php-common php7.4 php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline
[...]
Möchten Sie fortfahren? [J/n] j
~~~

Wie schon zuvor, holt das Metapaket eine ganze Reihe von Abhängigkeiten zusätzlich herein.  
Um nach der Installation zu prüfen, ob php korrekt läuft, wird die Datei *info.php* in */var/www/html* mit der Funktion phpinfo() auf die Art erstellt, wie es hier angegeben ist:

~~~
mcedit /var/www/html/info.php  
~~~

Den folgenden Text einfügen

~~~
<?php
phpinfo();
?>
~~~

mit `F2` speichern, `F10` beendet mcedit.

Danach wird der Terminal-Browser w3m dorthin gelinkt:

~~~
w3m http://localhost/info.php  
oder  
w3m http://yourip:80/info.php  
~~~

~~~
PHP logo

PHP Version 7.4.11

System       Linux <hostname> 5.9.13-towo.1-siduction-amd64 ...
Build Date   Oct 6 2020 10:34:39
server API   Apache 2.0 Handler
...
~~~

Erhalten wir eine Ausgabe, die wie oben gezeigt beginnt und alle php-Konfigurationen und Grundeinstellungen enthält, so funktioniert PHP und benutzt als *server API* den *Apache 2.0 Handler*.  

Wir beenden w3m mit `q` und bestätigen mit `y`.

Jetzt fehlt noch die Unterstützung für MariaDB/mysql in PHP. Wir benötigen das PHP-Modul *php7.4-mysql*.

~~~
# apt install php7.4-mysql
~~~

Wenn wir jetzt wieder die Seite "http://localhost/info.php" aufrufen, finden wir im Bereich der Module (sie sind alphabetisch sortiert) die Einträge zu *mysqli* und *mysqlnd*.

Weitere Informationen zu der Konfiguration von PHP und der Verwaltung ihrer Module enthält die Handbuchseite [LAMP-PHP](./lamp-php_de.md#php-einrichten)

### phpMyAdmin installieren

Um die Datenbank MariaDb zu administrieren benötigen wir *phpmyadmin*:

~~~
# apt install phpmyadmin
[...]
Die folgenden NEUEN Pakete werden installiert:
  dbconfig-common dbconfig-mysql icc-profiles-free libjs-openlayers libjs-sphinxdoc libjs-underscore libonig5 libzip4
  php-bacon-qr-code php-bz2 php-dasprid-enum php-gd php-google-recaptcha php-mbstring php-mysql
  php-phpmyadmin-motranslator php-phpmyadmin-shapefile php-phpmyadmin-sql-parser php-phpseclib php-psr-cache
  php-psr-container php-psr-log php-symfony-cache php-symfony-cache-contracts php-symfony-expression-language
  php-symfony-service-contracts php-symfony-var-exporter php-tcpdf php-twig php-twig-extensions php-xml php-zip
  php7.4-bz2 php7.4-gd php7.4-mbstring php7.4-xml php7.4-zip phpmyadmin
0 aktualisiert, 38 neu installiert, 0 zu entfernen und 60 nicht aktualisiert.
Es müssen noch 15,7 MB von 15,8 MB an Archiven heruntergeladen werden.
Nach dieser Operation werden 70,9 MB Plattenplatz zusätzlich benutzt.
Möchten Sie fortfahren? [J/n]  j
~~~

Während der Installation erscheinen die zwei Dialoge.  
Im ersten, zu Beginn, wählen wir "*apache2*" und bestätigen mit "*ok*"

![PHPMyAdmin Webserverauswahl](./images/lamp-start/phpmyadmin01-de.png)

im zweiten, am Ende der Installation, wählen wir "*ja*" aus.

![PHPMyAdmin Datenbank](./images/lamp-start/phpmyadmin02-de.png)

In den folgenden Dialogen benötigen wir das Passwort für den Datenbankbenutzer *phpmyadmin* (siehe das Kapitel *Vorbereitungen*).

### Weitere Software

Wer sich mit der Entwicklung von Webseiten befasst, kann ein CMS zum Beispiel, WordPress, Drupal oder Joomla installieren, sollte zuvor jedoch unsere Handbuchseiten [LAMP-Apache](./lamp-apache_de.md#apache-einrichten) und [LAMP-MariaDb](./lamp-sql_de.md#mariadb-einrichten)für die Konfiguration des Servers und MariaDb berücksichtigen.

### Statusaugaben Log-Dateien

**Apache**

Der Konfigurationsstatus des Apache Webservers wird mit "*apache2ctl -S*" augegeben.  
Die Ausgabe zeigt den Status ohne Änderungen an der Konfiguration unmittelbar nach der Installation.

~~~
# apache2ctl -S
  AH00558: apache2: Could not reliably determine the server's
  fully qualified domain name, using 127.0.1.1. Set the 'ServerName'
  directive globally to suppress this message
  VirtualHost configuration:
  [::1]:80               127.0.0.1 (/etc/apache2/sites-enabled/000-default.conf:1)
  127.0.0.1:80           127.0.0.1 (/etc/apache2/sites-enabled/000-default.conf:1)
  ServerRoot: "/etc/apache2"
  Main DocumentRoot: "/var/www/html"
  Main ErrorLog: "/var/log/apache2/error.log"
  Mutex default: dir="/var/run/apache2/" mechanism=default 
  Mutex mpm-accept: using_defaults
  Mutex watchdog-callback: using_defaults
  PidFile: "/var/run/apache2/apache2.pid"
  Define: DUMP_VHOSTS
  Define: DUMP_RUN_CFG
  User: name="www-data" id=33
  Group: name="www-data" id=33
~~~

Die Handbuchseite [LAMP-Apache](./lamp-apache_de.md#apache-einrichten) enthält eine Reihe von Hinweisen zur Anpassug der Konfiguration.  
Das Verzeichnis */var/log/apache2/* enthält die Log-Dateien. Ein Blick in diese ist behilflich um Fehlerursachen zu erkennen.

**MariaDB**

In der Konsole zeigt der Befehl

~~~
# systemctl status mariadb.service
~~~

den aktuellen Status von MariaDB und die letzten zehn Logeinträge.  
Die letzten zwanzig Zeilen des Systemd-Journals zeigt der Befehl

~~~
# journctl -n 20 -u mariadb.service
~~~

und

~~~
# journctl -f -u mariadb.service
~~~

hält die Verbindung zum Journal offen und zeigt laufend die neuen Einträge.  
Weitere Informationen liefert die Handbuchseite [LAMP-MariaDB](./lamp-sql_de.md#mariadb-einrichten)

**PHP**

Die Fehlermeldungen von PHP speichert der Apache Server in seinen Log-Dateien unter */var/log/apache2/*. Fehlerhafte PHP-Funktionen erzeugen eine Meldung in der aufgerufenen Webseite.  
Dieses Verhalten lässt sich in den *php.ini*-Dateien des jeweiligen Interface konfigurieren.  
Siehe die Handbuchseite [LAMP-PHP](./lamp-php_de.md#php-einrichten)

### Troubleshooting

Die hier aufgeführten Beispiele zeigen exemplarisch einige Möglichkeiten der Fehlersuche.

**Dateirecht in "DocumentRoot"**

Sollte unmittelbar nach der Installation der Aufruf der Dateien *index.html* und *info.php* fehlschlagen, bitte unbedingt zuerst die Eigentümer- und Gruppenzugehörigkeit des Webseitenverzeichnisses überprüfen und ggf. ändern:

~~~
# ls -la /var/www/html
drwxr-xr-x 2 www-data www-data  4096 14. Dez 18:56 .
drwxr-xr-x 3 root     root      4096 14. Dez 18:30 ..
-rw-r--r-- 1 www-data www-data 10701 14. Dez 19:04 index.html
-rw-r--r-- 1 root     root        20 14. Dez 19:32 info.php
~~~

In diesem Fall wird die Apache Testseite angezeigt, die PHP-Statusseite nicht. Dann hilft ein beherztes

~~~
# chown -R www-data:www-data /var/www/html
~~~

Nun sollten sich beide Seiten aufrufen lassen.

**HTML-Seiten-Ladefehler**

Die Webseite **http://localhost/index.html** wird nicht angezeigt und der Browser meldet einen Seiten-Ladefehler.

Wir fragen den Status des Apache Webservers ab:

~~~
# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: failed (Result: exit-code) since Mon 2020-12-14 18:29:23 CET; 13min ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 4420 ExecStart=/usr/sbin/apachectl start (code=exited, status=1/FAILURE)

Dez 14 18:29:23 lap1 systemd[1]: Starting The Apache HTTP Server...
Dez 14 18:29:23 lap1 apachectl[4423]: AH00526: Syntax error on line 63 of /etc/apache2/conf-enabled/security.conf:
[...]
~~~

Wir sehen, dass die Datei *security.conf* in Zeile 63 einen Fehler aufweist.  
Wir bearbeiten die Datei und versuchen es noch einmal.

~~~
# systemctl start apache2.service
# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2020-12-14 18:34:59 CET; 3s ago
[...]
~~~

Generell ist nach jeder Änderung der Konfiguration ein Reload oder Restart des Apache notwendig.

**Apache Log-Dateien prüfen**

Ein Blick in die Logdateien unter “*/var/log/apache2/*” hilft um Fehler in der Konfiguration des Netzwerks oder des Apache Servers zu erkennen.

**PHP, info.php nur weiße Seite**

Das bedeutet, dass PHP aktiv ist, aber die Seite nicht anzeigen kann.  
Bitte überprüfen:

+ Der Inhalt der Datei *info.php* muss exakt dem im Kapitel PHP gegebenem Beispiel entsprechen.

+ Die Dateirechte, wie zu Beginn des Kapitels Troubleshooting erläutert, prüfen und ggf. ändern.

+ Zusätzliche PHP-Module wurden installiert oder die Konfiguration geändert und der Webserver nicht neu gestartet.  
  Dann hilft:

  ~~~
  # systemctl restart apache2.service
  ~~~

**phpMyAdmin - Error**

Der Aufruf von *http://localhost/phpmyadmin* schlägt mit der Meldung "*phpMyAdmin - Error*" fehl und die folgenden Informationen werden angezeigt.

~~~
Error during session start; please check your PHP and/or webserver log file and  
configure your PHP installation properly. Also ensure that cookies are enabled  
in your browser.

session_start(): open(SESSION_FILE, O_RDWR) failed: Permission denied (13)
session_start(): Failed to read session data: files (path: /var/lib/php/sessions)
~~~

Die Berechtigungen für den Ordner */var/lib/php/sessions* prüfen:

~~~
# ls -l /var/lib/php/
~~~

Die Ausgabe sollte diese Zeile enthalten:

~~~
drwx-wx-wt 2 root root 4096 14. Dez 17:32 sessions
~~~

Zu beachten ist das Sticky-Bit (**t**) und der Eigentümer **root.root**. Bei Abweichungen beheben wir den Fehler.

~~~
# chmod 1733 /var/lib/php/sessions
# chown root:root /var/lib/php/sessions
~~~

Nun ist der Login zu phpmyadmin möglich.

#### Wenn nichts hilft

Die Installation des LAMP-Stack ist in weniger als fünfzehn Minuten erledigt. Eine Fehlersuche kann jedoch Stunden in Anspruch nehmen.  
Deshalb ist es, sofern die zuvor genannten Maßnahmen zu keiner Lösung führen, sinnvoll den LAMP-Stack oder Teile davon zu entfernen und neu zu installieren. Wenn, wie im Kapitel *Vorbereitungen* erwähnt, apt aufgeräumt wurde, hilft der Befehl "*apt purge*" um die zuvor installierten Pakete mit ihren Konfigurationsdateien zu entfernen ohne das irgendwelche anderen Pakete stören.

Hier ein Beispiel mit Apache:

~~~
# apt purge apache2
Paketlisten werden gelesen... Fertig
Abhängigkeitsbaum wird aufgebaut.
Statusinformationen werden eingelesen.... Fertig
Die folgenden Pakete wurden automatisch installiert und werden nicht mehr benötigt:
apache2-data apache2-utils
Verwenden Sie »apt autoremove«, um sie zu entfernen.
Die folgenden Pakete werden ENTFERNT:
  apache2*
0 aktualisiert, 0 neu installiert, 1 zu entfernen und 0 nicht aktualisiert.
~~~

*Apache2* wird entfernt und die Pakete *apache2-data* und *apache2-utils* blieben noch erhalten.  
Jetzt bitte **nicht apt autoremove  verwenden**, denn dann bleiben die Konfigurationsdateien, in denen möglicherweise der Fehler liegt, zurück.  
Wir verwenden den Befehl "*apt purge*".

~~~
# apt purge apache2-data apache2-utils
~~~

Bei Bedarf verfahren wir mit den anderen Programmteile ebenso. Anschließend starten wir einen neuen Versuch.

### Sicherheit

Die bis hierher erklärte Installation führt zu einem Webserver der **"offen wie ein Scheunentor für Jedermann ist"**. Deshalb sollte er ausschließlich autark an einem Arbeitsplatz verwendet und nicht mit dem privaten Netzwerk und auf keinen Fall mit dem Internet verbunden werden.

Für die Absicherung des Servers bitte die Handbuchseiten

[LAMP-Apache](./lamp-apache_de.md#apache-einrichten) 
[LAMP-MariaDB](./lamp-sql_de.md#mariadb-einrichten) 
[LAMP-PHP](./lamp-php_de.md#php-einrichten)

bezüglich der Konfiguration beachten.

Danach kann der Server, ausschließlich für System- und Software- Aktualisierungen, temporär über eine zweite Netzwerkschnittstelle mit dem Internet verbunden werden.

<div id="rev">Zuletzt bearbeitet: 2021-05-05</div>
% LAMP test server for developers (local)

## LAMP web server

**A local test server for developers**.

The acronym **LAMP** refers to a set of free software shared to run dynamic web sites:

+ **L**inux: operating system  
+ **A**pache: web server  
+ **M**ariaDb: database server (as of Debian 9 'Stretch', previously mySQL).  
+ **P**HP, Perl and/or Python: scripting languages  

Uses as a server:

1. **a local test server for webdesigners without internet connection (see this chapter)**  
2. a private (data) server with internet connection  
3. a private web server with full Internet connection  
4. a commercial web server

Our goal is to set up a LAMP test server for developers that is directly connected to the workstation PC via LAN. Furthermore, for security reasons, there should be no connection to a local network or even to the Internet for the server.
The only exception is that the server will be temporarily connected to the Internet via a second network interface exclusively for system and software updates.

> Please note:  
> The desktop PC used for daily work should not be used as a server. A separate PC should be used as the server, which otherwise does not perform any other tasks.

At least 500MB RAM should be available in the server PC. Less RAM will cause problems, because a server with MariaDb/MySQL needs a lot of RAM to run responsively.

The packages to install are:

~~~
apache2  
mariadb-server  
mariadb-client  
php  
php7.4-mysql  
phpmyadmin  
~~~

As usual with siduction, we do the installations in the "multi-user.target" (init 3) in the terminal.

**Preparations**

If the command line browser *w3m* has not been installed yet, we will do it now:

~~~
# apt update
# apt install w3m
~~~

This allows us to test *Apache* and *PHP* immediately in the terminal and return to the graphical user interface only after all necessary installations have been completed.

Now we still clean up apt.  
The command *apt autoremove* should result in the following output. If not, we confirm the removal of unneeded packages with `j`.

~~~
#apt autremove
Package lists are read... Done
Dependency tree is built.
Status information is read.... Done
0 updated, 0 reinstalled, 0 to remove, and 0 not updated.
~~~

This action makes it quite easier for us to repair in case of a faulty installation.  
See below [Troubleshooting](#troubleshooting)

It is useful to note down some data already before the installation.

Necessary during the installation:

+ A **password** for the database user **root** in *phpMyAdmin*.

Later, for the configuration necessary:

+ **Apache**  
    + *Server Name
    + *server alias
    + *IP address* of the server
    + *Name* of the PC
    + *IP address* of the PC

+ **MariaDB:**  
    + The *name of the database* to be used for the development project.
    + The *name* (login name) of a new databank user for the development project.
    + The *password* for the new databank user.
    + The *name* (login name) of a new database administrator.
    + The *password* for the database administrator.

### Install Apache

The installation of the Apache web server requires only the following two commands. The install command gets the additional packages *apache2-data* and *apache2-utils*. Then we query the status of Apache and test the start and stop statements right away.

~~~
# apt update
# apt install apache2
[...]
The following NEW packages will be installed:
  apache2 apache2-data apache2-utils
[...]
Do you want to continue? [Y/n] y
[...]

# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/system/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2020-12-06 14:24:44 CET; 4min 8s ago
[...]
~~~

As you can see, Apache was activated immediately.

~~~
# systemctl stop apache2.service
# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/system/system/apache2.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Sun 2020-12-06 14:30:27 CET; 6s ago
[...]

# systemctl start apache2.service
# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/system/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2020-12-06 14:30:59 CET; 3s ago
[...]
~~~

The Apache web server is loaded and can be handled without any problems. Now we check its function with:

~~~
w3m http://localhost/index.html
~~~

The Apache welcome page with **It works!** appears.  
We exit w3m with `q` and confirm with `y`.

The **ServerRoot** is the directory **/etc/apache2/**. It contains the configuration.  
The **DocumentRoot** is the directory **/var/www/html/**. It contains the files of the website.

For more information and security hints, please refer to the manual page  
[LAMP-Apache](./lamp-apache_en.md#apache-setup).

### Install MariaDb

The installation of MariaDb is similarly simple by requesting the metapackages "mariadb-server" and "mariadb-client".

~~~
# apt install mariadb-server mariadb-client
[...]
The following NEW packages will be installed:  
  galera-4 libcgi-fast-perl libcgi-pm-perl libdbd-mariadb-perl libfcgi-perl libhtml-template-perl libmariadb3  
  mariadb-client mariadb-client-10.5 mariadb-client-core-10.5 mariadb-common mariadb-server mariadb-server-10.5  
  mariadb-server-core-10.5 mysql-common socat
[...]
Do you want to continue? [Y/n] y
~~~

For more information on MariaDb and configuration, see our manual in [LAMP-MariaDB](./lamp-sql_en.md#mariadb-setup)

### Install PHP

To install the PHP scripting language, simply issue the command:

~~~
# apt install php
[...]
The following NEW packages will be installed:
  apache2-bin libapache2-mod-php7.4 libaprutil1-dbd-sqlite3 libaprutil1-ldap php
  php-common php7.4 php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline
[...]
Would you like to continue? [Y/n] y
~~~

As before, the metapackage brings in a whole bunch of dependencies in addition.  
To check if php is running correctly after installation, the file *info.php* in */var/www/html* is created with the phpinfo() function in the way it is given here:

~~~
mcedit /var/www/html/info.php  
~~~

Insert the following text

~~~
<?php
phpinfo();
?>
~~~

save with `F2`, `F10` terminates mcedit.

After that the terminal browser w3m will be linked to it:

~~~
w3m http://localhost/info.php  
or  
w3m http://yourip:80/info.php  
~~~

~~~
PHP logo

PHP version 7.4.11

System Linux <hostname> 5.9.13-towo.1-siduction-amd64 ...
Build Date Oct 6 2020 10:34:39
server API Apache 2.0 Handler
...
~~~

If we get an output that starts as shown above and contains all php configurations and basic settings, PHP is working and uses as *server API* the *Apache 2.0 Handler*.  

We exit w3m with `q` and confirm with `y`.

Now we need support for MariaDB/mysql in PHP. We need the PHP module *php7.4-mysql*.

~~~
# apt install php7.4-mysql
~~~

If we now go back to the "http://localhost/info.php" page, we will find the entries for *mysqli* and *mysqlnd* in the modules section (they are sorted alphabetically).

For more information on configuring PHP and managing its modules, see the manual page [LAMP-PHP](./lamp-php_en.md#php-setup)

### Install phpMyAdmin

To administer the MariaDb database we need *phpmyadmin*:

~~~
# apt install phpmyadmin
[...]
The following NEW packages will be installed:
  dbconfig-common dbconfig-mysql icc-profiles-free libjs-openlayers libjs-sphinxdoc libjs-underscore libonig5 libzip4
  php-bacon-qr-code php-bz2 php-dasprid-enum php-gd php-google-recaptcha php-mbstring php-mysql
  php-phpmyadmin-motranslator php-phpmyadmin-shapefile php-phpmyadmin-sql-parser php-phpseclib php-psr-cache
  php-psr-container php-psr-log php-symfony-cache php-symfony-cache-contracts php-symfony-expression-language
  php-symfony-service-contracts php-symfony-var-exporter php-tcpdf php-twig php-twig-extensions php-xml php-zip
  php7.4-bz2 php7.4-gd php7.4-mbstring php7.4-xml php7.4-zip phpmyadmin
0 updated, 38 reinstalled, 0 to remove and 60 not updated.
There are still 15.7 MB of archives to be downloaded out of 15.8 MB.
After this operation, 70.9 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
~~~

During the installation, two dialogs will appear.  
In the first one, at the beginning, we select "*apache2*" and confirm with "*ok*".

![PHPMyAdmin web server selection](./images/lamp-start/phpmyadmin01-en.png)

in the second one, at the end of the installation, we select "*yes*".

![PHPMyAdmin database](./images/lamp-start/phpmyadmin02-en.png)

In the following dialogs we need the password for the database user *phpmyadmin* (see the chapter *Preparations*).

### Other software

If you are interested in developing websites, you can install a CMS for example, WordPress, Drupal or Joomla, but you should consider our manual pages [LAMP-Apache](./lamp-apache_en.md#apache-setup) and [LAMP-MariaDb](./lamp-sql_en.md#mariadb-setup)for the configuration of the server and MariaDb before.

### Status data log files

**Apache**

The configuration status of the Apache web server is output with "*apache2ctl -S*".  
The output shows the status without any changes to the configuration immediately after installation.

~~~
# apache2ctl -S
  AH00558: apache2: Could not reliably determine the server's
  fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive
  directive globally to suppress this message
  VirtualHost configuration:
  [::1]:80 127.0.0.1 (/etc/apache2/sites-enabled/000-default.conf:1)
  127.0.0.1:80 127.0.0.1 (/etc/apache2/sites-enabled/000-default.conf:1)
  ServerRoot: "/etc/apache2"
  Main DocumentRoot: "/var/www/html"
  Main ErrorLog: "/var/log/apache2/error.log"
  Mutex default: dir="/var/run/apache2/" mechanism=default 
  Mutex mpm-accept: using_defaults
  Mutex watchdog-callback: using_defaults
  PidFile: "/var/run/apache2/apache2.pid"
  Define: DUMP_VHOSTS
  Define: DUMP_RUN_CFG
  User: name="www-data" id=33
  Group: name="www-data" id=33
~~~

The manual page [LAMP-Apache](./lamp-apache_en.md#apache-setup) contains a number of hints for customizing the configuration.  
The directory */var/log/apache2/* contains the log files. A look into them is helpful to identify error causes.

**MariaDB**

In the console the command

~~~
# systemctl status mariadb.service
~~~

shows the current status of MariaDB and the last ten log entries.  
The last twenty lines of the systemd journal are shown by the command

~~~
# journctl -n 20 -u mariadb.service
~~~

and

~~~
# journctl -f -u mariadb.service
~~~

keeps the connection to the journal open and continuously shows the new entries.  
For more information, see the manual page [LAMP-MariaDB](./lamp-sql_en.md#setup-mariadb).

**PHP**

The Apache server stores the error messages of PHP in its log files under */var/log/apache2/*. Erroneous PHP functions generate a message in the called web page.  
This behavior can be configured in the *php.ini* files of the respective interface.  
See the [LAMP-PHP](./lamp-php_en.md#php-setup) manual page.

### Troubleshooting

The examples listed here show some troubleshooting possibilities.

**File right in "DocumentRoot "**

If calling the files *index.html* and *info.php* fails immediately after installation, please be sure to check the ownership and group membership of the web page directory first and change them if necessary:

~~~
# ls -la /var/www/html
drwxr-xr-x 2 www-data www-data 4096 14 Dec 18:56 .
drwxr-xr-x 3 root root 4096 14 Dec 18:30 ...
-rw-r--r-- 1 www-data www-data 10701 14 Dec 19:04 index.html
-rw-r--r-- 1 root root 20 14 Dec 19:32 info.php
~~~

In this case the Apache test page is displayed, the PHP status page is not. Then a spirited

~~~
# chown -R www-data:www-data /var/www/html
~~~

Now you should be able to call both pages.

**HTML page load error**

The web page **http://localhost/index.html** is not displayed and the browser reports a page load error.

We query the status of the Apache web server:

~~~
# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/system/system/apache2.service; enabled; vendor preset: enabled)
     Active: failed (Result: exit-code) since Mon 2020-12-14 18:29:23 CET; 13min ago
       Docs: https://httpd.apache.org/docs/2.4/
    Process: 4420 ExecStart=/usr/sbin/apachectl start (code=exited, status=1/FAILURE)

Dec 14 18:29:23 lap1 systemd[1]: Starting The Apache HTTP Server...
Dec 14 18:29:23 lap1 apachectl[4423]: AH00526: Syntax error on line 63 of /etc/apache2/conf-enabled/security.conf:
[...]
~~~

We see that the file *security.conf* has an error in line 63.  
We edit the file and try again.

~~~
# systemctl start apache2.service
# systemctl status apache2.service
● apache2.service - The Apache HTTP Server
     Loaded: loaded (/lib/system/system/apache2.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2020-12-14 18:34:59 CET; 3s ago
[...]
~~~

In general, a reload or restart of Apache is necessary after each configuration change.

**Check Apache log files**

A look into the log files under "*/var/log/apache2/*" helps to detect errors in the configuration of the network or the Apache server.

**PHP, info.php only white page**

This means that PHP is active but cannot display the page.  
Please check:

+ The content of the *info.php* file must be exactly the same as the example given in the PHP chapter.

+ Check the file permissions as explained at the beginning of the Troubleshooting chapter and change them if necessary.

+ Additional PHP modules have been installed or the configuration has been changed and the web server has not been restarted.  
  Then helps:

  ~~~
  # systemctl restart apache2.service
  ~~~

**phpMyAdmin - Error**

The call to *http://localhost/phpmyadmin* fails with the message "*phpMyAdmin - Error*" and the following information is displayed.

~~~
Error during session start; please check your PHP and/or webserver log file and  
configure your PHP installation properly. Also ensure that cookies are enabled  
in your browser.

session_start(): open(SESSION_FILE, O_RDWR) failed: Permission denied (13)
session_start(): Failed to read session data: files (path: /var/lib/php/sessions)
~~~

Check the permissions for the */var/lib/php/sessions* folder:

~~~
# ls -l /var/lib/php/
~~~

The output should contain this line:

~~~
drwx-wx-wt 2 root root 4096 14 Dec 17:32 sessions
~~~

Note the sticky bit (**t**) and the owner **root.root**. If there are any discrepancies, we will fix the error.

~~~
# chmod 1733 /var/lib/php/sessions
# chown root:root /var/lib/php/sessions
~~~

Now the login to phpmyadmin is possible.

#### If nothing helps

Installing the LAMP stack takes less than fifteen minutes. However, troubleshooting can take hours.  
Therefore, if the previously mentioned measures do not lead to a solution, it makes sense to remove the LAMP stack or parts of it and reinstall it. If, as mentioned in the chapter *Preparations*, apt has been cleaned up, the command "*apt purge*" helps to remove the previously installed packages with their configuration files without disturbing any other packages.

Here is an example with Apache:

~~~
# apt purge apache2
Package lists are read... Done
Dependency tree is built.
Status information is read.... Done
The following packages were installed automatically and are no longer needed:
apache2-data apache2-utils
Use "apt autoremove" to remove them.
The following packages are REMOVED:
  apache2*
0 updated, 0 reinstalled, 1 to remove, and 0 not updated.
~~~

*Apache2* is removed and the packages *apache2-data* and *apache2-utils* still remained.  
Now please **don't use apt autoremove**, because then the configuration files, where the error may be, will be left behind.  
We use the command "*apt purge*".

~~~
# apt purge apache2-data apache2-utils
~~~

If necessary, we do the same with the other parts of the program. Then we start a new attempt.

### Security

The installation explained so far leads to a web server that is **"open like a barn door for everyone "**. Therefore it should only be used standalone at a workstation and not connected to the private network and in no case to the Internet.

For securing the server please read the manual pages

[LAMP-Apache](./lamp-apache_en.md#apache-setup) 
[LAMP-MariaDB](./lamp-sql_en.md#mariadb-setup) 
[LAMP-PHP](./lamp-php_en.md#php-setup)

regarding the configuration.

After that, exclusively for system and software updates, the server can be temporarily connected to the Internet via a second network interface.

<div id="rev">Last edited: 2021-14-08</div>
