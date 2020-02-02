<div class="divider" id="serv-apache"></div>

## siduction LAMP-Stack
Das Akronym LAMP bezieht sich auf eine Reihe freier Software, die gemeinsam genutzt wird, um dynamische Websites oder Server zu betreiben:  
Linux: Betriebssystem  
Apache: Web-Server  
MySQL: Datenbank-Management bzw. Datenbank-Server  
Perl, PHP und/oder Python: Skriptsprachen  


#### Zur Beachtung: Der Desktop-PC, mit dem täglich gearbeitet wird, soll nicht als Server dienen. Als Server soll ein eigener PC verwendet werden, der ansonsten keine weiteren Aufgaben erfüllt.
Verwendungsmöglichkeiten als Server:  
1. `ein lokaler Testserver für Webdesigner ohne Internetverbindung (siehe dieses Kapitel)`  
2. ein privater (Daten-)Server mit Internetverbindung  
3. ein privater Webserver mit umfassender Internetverbindung  
4. ein kommerzieller Webserver (nicht behandelt in diesem Handbuch)  


#### Minimale Voraussetzungen
Mindestens 256MB RAM. Weniger RAM wird Probleme bereiten, da ein Server mit MySQL viel RAM benötigt, um ansprechend zu laufen. Ohne ausreichenden Speicher gibt MySQL folgende Fehlermeldung aus: "cannot connect to mysql.sock".

Die zu installierenden Pakete sind:

~~~
apache2  
apache2-utils  
apache2-mpm-prefork  
php5 php5-common  
mysql-server  
mysql-common  
libapache2-mod-php5  
php5-mysql  
phpmyadmin  
~~~

 **`ACHTUNG! `**

~~~
apt-get remove --purge splashy  
~~~

 **`Splashy kann nicht mit mysql!`**

Die Konfigurationsdatei für Apache befindet sich hier:   
`/etc/apache2/apache2.conf  
` , und das Web-Verzeichnis ist hier:   
`/var/www  
` 

Um zu prüfen, ob php installiert ist und korrekt läuft, wird eine Datei test.php in /var/www mit der Funktion phpinfo() auf die Art erstellt, wie es hier angegeben ist:

~~~ php
mcedit /var/www/test.php  

# test.php  
<? phpinfo(); ?>  
~~~

Danach wird der Browser dorthin gelinkt:

~~~
http://localhost/test.php  
oder  
http://yourip:80/test.php  
~~~

Dies zeigt alle php-Konfigurationen und Grundeinstellungen.

Die Einstellungen können nun angepasst werden bzw. virtuelle Domains können mit Hilfe der Apache-Konfiguration eingerichtet werden.

Um die Installation zu testen, wird Folgendes in die URL-Zeile des Browsers eingegeben:

~~~
http://youripaddress/apache2-default/  
~~~

Wenn die Installation erfolgreich und korrekt erfolgt ist, sieht man eine Begrüßungsnachricht.

Das Rootverzeichnis für apache2 ist   
`/var/www  
` . Dies muss folgendermaßen angepasst werden:   


~~~
mkdir /home/myself/www  
ln -s /home/myself/www /var/www  
~~~

Danach kann die Website innerhalb des $HOME als normaler User editiert werden.

<div class="divider" id="serv-ftp"></div>

## FTP-Clients
Empfohlen ist SSH (Informationen im Handbuch unter [SSH](ssh-de.htm#ssh) ),  


<div class="divider" id="serv-sec"></div>

## Aktivieren von Sicherheitsprotokollen für Webserver
### Firewalls
**`Ohne Firewall gibt es absolut keine Sicherheit für Server. Empfohlene Vorgehensweise ist, ALLES zu blockieren, solange es nicht benötigt ist, und nach Gebrauch wieder zu blockieren.  
`** 

~~~
21 (ftp)  
22 (SSH)  
25 110 (email)  
443 (SSL-http or https)  
993 (imap ssl)  
995 (pop3 ssl)  
80 (http)  
und auch jeder andere verwendete Port!  
~~~

### Grundsätzlicher Schutz von Server-Dateien
Ein Aspekt von Apache, der gelegentlich missverstanden wird, ist der in der Grundeinstellung festgelegte Zugang. Das bedeutet, solange die Konfiguration nicht verändert ist, kann der Server Clients bedienen, wenn der Server seinen Weg zu einem File mittels nomaler URL-Mapping-Regeln finden kann.

Zum Beispiel:

~~~
1. # cd /; ln -s / public_html  
2. Zugang hat man mit: http://localhost/~root/  
~~~

 **`Dies erlaubt Clients, das ganze Dateisystem zu durchsuchen! Um dies zu verhindern, muss Folgendes zur Server-Konfiguration gefügt werden:`**

~~~
<Directory />  
   Order Deny,Allow  
   Deny from all  
</Directory>  
~~~

Dies verbietet grundsätzlich Zugang zu Bereichen des Dateisystems. Dementsprechend müssen &lt;Directory&gt;-Blöcke der Konfiguration beigefügt sein, welche Zugriff ausschließlich zu erlaubten Bereichen gestatten. Zum Beispiel:

~~~
<Directory /usr/users/*/public_html>  
   Order Deny,Allow  
   Allow from all  
</Directory>  
<Directory /usr/local/httpd>  
   Order Deny,Allow  
   Allow from all  
</Directory>  
~~~

Besondere Aufmerksamkeit muss dem Zusammenspiel der Anweisungen &lt;Location&gt; und &lt;Directory&gt; geschenkt werden. Zum Beispiel, eine Anweisung &lt;Directory /&gt; kann den Zugang unterbinden, eine Anweisung &lt;Location /&gt; kann dieses Verbot jedoch überschreiben und somit umgehen.

Auch sollte man Experimente mit der Anweisung UserDir vermeiden; eine Konfiguration "./" hätte für root denselben Effekt, wie er im ersten Beispiel gezeigt wurde. Für die Version Apache 1.3 oder höher empfehlen wir nachdrücklichst, folgende Zeile in der Konfigurationsdatei einzufügen:

~~~
UserDir disabled root  
~~~

<div class="divider" id="serv-ssl"></div>

## SSL
Ausführen des Skripts “apache2-ssl-certificate”

~~~
# apache2-ssl-certificate  
~~~

Folgender Dialog wird gestartet, um alle benötigten Informationen eintragen zu können:

~~~
Creating self-signed certificate  
replace it with one signed by a certification authority (CA) enter your ServerName at the Common Name prompt. If you want your certificate to expire after x days call this programm  
with -days x  
-----  
Generating a 1024 bit RSA private key  
--------  
writing new private key to '/etc/apache2/ssl/apache.pem'  
--------  
You are about to be asked to enter information that will be incorporated into your certificate request.  
-----------  
What you are about to enter is what is called a Distinguished Name or a DN. There are quite a few fields but you can leave some blank. For some fields there will be a default value,  
----------  
If you enter '.', the field will be left blank.  
~~~

~~~
Country Name (2 letter code) [GB]:  
State or Province Name (full name) [Some-State]:  
Locality Name (eg, city) []:  
Organization Name (eg, company; recommended) []:  
Organizational Unit Name (eg, section) []:  
server name (eg. ssl.domain.tld; required!!!) []:  
Email Address []:  
~~~

Ausführen des Skripts “a2enmod ssl” i.e

~~~
# a2enmod ssl  
~~~

Dieses generiert automatisch einen symbolischen Link zwischen mods-available und mods-enabled.

Danach legt man eine Kopie von '/etc/apache2/sites-available/default' im Ordner /etc/apache2/sites-available/ an und benennt sie 'ssl':

~~~
# cp /etc/apache2/sites-available/default /etc/apache2/sites-available/ssl  
~~~

Schließlich erstellt man einen symbolischen Link zu dieser neuen Konfigurationsdatei, um sie zu nutzen:

~~~
# ln -s /etc/apache2/sites-available/ssl /etc/apache2/sites-enabled/  
(oder)  
#a2ensite ssl  
~~~

Wenn Einstellungen der Basiskonfiguration in /etc/apache2/apache2.conf und die Grundeinstellung der Document-Route in /etc/apache2/sites-available/default geändert sind, muss der Apache-Server neu gestartet werden.

Der Apache-Server wird mit folgendem Befehl neu gestartet:

~~~
#/etc/init.d/apache2 restart  
~~~

Nun wird die Port-Adresse /etc/apache2/ports.conf angepasst. In der Grundeinstellung wird auf Port 80 gelauscht, und da mit SSL installiert wird, hat dies auf Port 443 geändert zu werden.

~~~
Listen 443  
~~~

/etc/apache2/sites-available/ssl (oder wie immer die ssl-Konfigurationsdatei benannt wurde) wird editiert und Port 80 wird auf 443 geändert.

Darunter werden zwei Zeilen in /etc/apache2/apache2.conf eingefügt:

~~~
SSLEngine On  
SSLCertificateFile /etc/apache2/ssl/apache.pem  
~~~

Die Datei des SSLCertificateFile /etc/apache2/ssl/apache.pem wird editiert und der Ort der Zertifikatsdateien sowie Zertifikatsschlüssel eingegeben. Zum Beispiel:

~~~
SSLCertificateFile /etc/apache2/ssl/online.test.net.crt  
SSLCertificateKeyFile /etc/apache2/ssl/online.test.net.key  
~~~

Um ServerSignature auf off (aus) zu setzen, wird /etc/apache2/apache2.conf editiert, und zwei Zeilen werden eingefügt:

~~~
ServerSignature Off  
ServerTokens ProductOnly  
~~~

Wenn andere Typen von Index-Dateien gewünscht sind, muss folgende Zeile in der Datei /etc/apache2/apache2.conf angepasst werden:

~~~
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Neustart des Apache-Servers

~~~
/etc/init.d/apache2 restart  
~~~

Nun soll die Sandbox eines Testservers eingerichtet sein. Dieser Testserver soll   
**`NICHT mit dem Internet verbunden werden. Zu diesem Zweck soll ausschließlich ein PC verwendet werden, der als Server dienen soll!  
`** 

Quellen:

[http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

[http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

[http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

Page last revised 10/01/2012 1845 UTC  
