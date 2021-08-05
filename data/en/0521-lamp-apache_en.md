% LAMP - Apache 

## Apache einrichten

Diese Handbuchseite basiert auf Apache 2.4.46.

Unserem Beispiel aus der Installationsanleitung entsprechend, wollen wir einen *LAMP-Testserver für Entwickler* aufsetzen, der über LAN direkt mit dem Arbeitsplatz-PC verbunden ist. Darüber hinaus soll es aus Gründen der Sicherheit für den Server keine Verbindung zu einem lokalen Netzwerk oder gar zum Internet geben.  
Einzige Ausnahme: Der Server wird temporär und ausschließlich für System- und Software- Aktualisierungen über eine zweite Netzwerkschnittstelle mit dem Internet verbunden.

### Apache im Dateisystem

Debian hat die Dateien des Apache entsprechend ihrer Funktion vollständig in das Dateisystem integriert.

+ In **/usr/sbin/** das ausführbare Programm *apache2*.  
+ In **/usr/lib/apache2/modules/** die installierten Module für Apache.  
+ In **/usr/share/apache2/** Dateien, die auch für andere Programme verfügbar sind.  
+ In **/etc/apache2/** die Konfigurationsverzeichnisse und -dateien.  
+ In **/var/www/html/** die vom Benutzer angelegte Webseite.
+ In **/run/apache2/, /run/lock/apache2/** zur Laufzeit notwendige Systemdateien.
+ In **/var/log/apache2/** verschiedene Log-Dateien.

Wichtig ist die Unterscheidung zwischen den verwendeten Variablen *ServerRoot* und *DocumentRoot*.

**ServerRoot** ist das Konfigurationsverzeichnis, also "*/etc/apache2/*".  
**DocumentRoot** beinhaltet die Webseitendaten, also "*/var/www/html/*".

### Verbindung zum Server

Die Verbindung zwischen Testserver und PC wird in das IPv4-Netzwerksegment **192.168.3.xxx** gelegt, während die Internetverbindung des PC außerhalb dieses Netzwerksegmentes erfolgt. Die verwendeten Daten sind:

**Server**  
IP: 192.168.3.1/24  
Name: server1.org  
Alias: www.server1.org

**PC**  
IP: 192.168.3.10/24  
Name: pc1

Wir legen von der Datei */etc/hosts* auf dem Server und auf dem PC eine Sicherungskopie an und fügen beiden die notwendigen Zeilen hinzu.

+ Server */etc/hosts*:

  ~~~sh
  cp /etc/hosts /etc/hosts_$(date +%f)
  echo "192.168.3.1 server1.org   www.server1.org" >> /etc/hosts
  echo "192.168.3.10 pc1" >> /etc/hosts
  ~~~

+ PC */etc/hosts*:

  ~~~sh
  cp /etc/hosts /etc/hosts_$(date +%f)
  echo "192.168.3.1 server1.org   www.server1.org" >> /etc/hosts
  ~~~

Als nächstes geben wir im *NetworkManager* die Daten für den Server in die rot umrandeten Feldern ein. Die Methode wird von "*Automatisch (DHCP)*" auf "*Manuell*" geändert und in die Adressfelder tragen wir die zu Beginn genannten Werte ein.

![Server - Dateneingabe im NetworkManager](./images/lamp-apache/server_lan.png)

Zusätzlich sollte im Reiter "*Allgemein*" die Option "*Automatisch mit Priorität verbinden*" aktiviert sein.  
Sinngemäß nehmen wir am PC die entsprechenden Einstellungen für die verwendete LAN-Schnittstelle vor.

Am PC testen wir die Verbindung in der Konsole mit

~~~sh
$ ping -c3 www.server1.org
~~~

und bei Erfolg prüfen wir gleich die Funktion von Apache, indem wir in die Adresszeile des Webbrowsers "*http://www.server1.org/index.html*" eingeben.

Die Apache-Begrüßungsseite mit "*It works!*" sollte erscheinen.

### Apache Konfiguration

Die Konfigurationsdateien und -verzeichnisse befindet sich im "*ServerRoot*" Verzeichnis "*/etc/apache2/*".  
Die zentrale Konfigurationsdatei ist "*apache2.conf*". Sie wird in der Regel nicht bearbeitet, da viele Konfigurationen in separaten Dateien vorliegen. Die Aktivierung und Deaktivierung erfolgt über Sym-Links. Das hat den Vorteil, dass eine Reihe verschiedener Konfigurationen vorhanden sind und nur die benötigten eingebunden werden.

Bei den Konfigurationsdateien handelt es sich um Textdateien, welche mit einem Editor und Root-Rechten angelegt bzw. editiert werden. Der Name der Datei darf beliebig sein, aber die Dateiendung muss "*.conf*" lauten. Die gültigen Direktiven, die in den Konfigurationsdateien verwendet werden dürfen, beschreibt die [Apache Dokumentation](https://httpd.apache.org/docs/current/de/) ausführlich.

Die Dateien liegen in den Verzeichnissen 

"*/etc/apache2/conf-available*",  
"*/etc/apache2/mods-available*" und  
"*/etc/apache2/sites-available*".

Ihre Aktivierungs-Links finden wir in

"*/etc/apache2/conf-enable*",  
"*/etc/apache2/mods-enable*" und  
"*/etc/apache2/sites-enable*".

Um eine .conf-Datei zu aktivieren bzw. deaktivieren benutzen wir die Befehle "*a2enconf*" und "*a2disconf*". Das erstellt oder entfernt die Aktivierungs-Links.

~~~sh
a2enconf NAME_DER_DATEI.conf 
~~~

Aktiviert die Konfiguration. Die Deaktivierung erfolgt entsprechend mit:

~~~sh
a2disconf NAME_DER_DATEI.conf 
~~~

In gleicher Weise verfahren wir bei Modulen und Virtual-Hosts mit den Befehlen "*a2enmod*", "*a2ensite*" und "*a2dismod*", "*a2dissite*".

Der Apache Webserver liest mit dem Befehl

~~~sh
systemctl reload apache2.service
~~~

die geänderte Konfiguration ein.

Nun kommen wir wieder auf unseren *LAMP-Testserver für Entwickler* zurück und passen die Konfiguration an die Serverdaten an.

1. Datei "*/etc/apache2/apache2.conf*"

   Es ist eine der wenigen Ausnahmen die *apache2.conf* zu editieren. Wir fügen zu Beginn des Abschnits *Global configuration* die folgende Zeile ein:

   ~~~sh
   ServerName 192.168.3.1
   ~~~

   Hiermit teilen wir dem Apache-Webserver die IP-Adresse mit, unter der das Entwicklungsprojekt erreichbar sein soll und unterdrücken Umleitungen zur IP 127.0.1.1 mit Fehlermeldungen.

2. Neue "*sites*"-Datei

   Mit dem Texteditor unserer Wahl erstellen wir die Datei "*/etc/apache2/sites-available/server1.conf*" z. B.

   ~~~sh
   mcedit /etc/apache2/sites-available/server1.conf
   ~~~

   und fügen den folgenden Inhalt ein, speichern die Datei und beenden den Editor.

   ~~~apache
   <VirtualHost *:80>
	   ServerName server1.org
	   ServerAlias www.server1.org
	   ServerAdmin webmaster@localhost
	   DocumentRoot /var/www/html
	   ErrorLog ${APACHE_LOG_DIR}/error_server1.log
	   CustomLog ${APACHE_LOG_DIR}/access_server1.log combined
   </VirtualHost>
   ~~~

   Anschließend stellen wir die Konfiguration auf den neuen "*VirtualHost*" um und geben die Änderungen dem Apache Webserver bekannt.

   ~~~sh
   # a2ensite server1.conf 
     Enabling site server1.
   [...]

   # a2dissite 000-default.conf 
     Site 000-default disabled.
   [...]

   systemctl reload apache2.service
   ~~~

### Benutzer und Rechte

Der Apache Webserver läuft mit der USER.GROUP "*www-data.www-data*" und "*DocumentRoot*" gehört unmittelbar nach der Installation "*root.root*".  
Um Benutzern Schreibrechte für die in "*DocumentRoot*" enthaltenen Dateien zu gegeben, sollte dafür eine neue Gruppe angelegt werden. Es ist nicht sinnvoll die bestehende Gruppe "*www-data*" zu nutzten, da mit den Rechten dieser Gruppe Apache läuft.  
Wir nennen die neue Gruppe "*developer*".

**Mit CMS**

Wird ein Content-Management-System (Software zur gemeinschaftlichen Bearbeitung von Webseiten-Inhalten) hinzugefügt, bereiten wir "*DocumentRoot*" entsprechend vor:

1. Gruppe anlegen und dem Benutzer zuweisen.

   ~~~sh
   groupadd developer
   adduser BENUTZERNAME developer
   chgrp developer /var/www/html
   ~~~

   Um die neuen Rechte zu aktivieren, muss man sich einmal ab- und neu anmelden oder als Benutzer den Befehl newgrp verwenden.

   ~~~sh
   $ newgrp developer
   ~~~

2. SGID-Bit für "*DocumentRoot*" setzen,  
   damit alle hinzukommenden Verzeichnisse und Dateien die Gruppe "*developer*" erben.

   ~~~sh
   chmod g+s /var/www/html
   ~~~

3. Eigentümer und Dateirechte anpassen,  
   damit Unbefugte keinen Zugriff erhalten und der Apache Webserver einwandfrei läft.  
   Wir schauen uns die derzeitigen Rechte an:

   ~~~sh
   # ls -la /var/www/html
   insgesamt 24
   drwxr-sr-x 2 root developer  4096  9. Jan 19:32 .           (DocumentRoot mit SGID-Bit)
   drwxr-xr-x 3 root root       4096  9. Jan 19:04 ..          (Das übergeordnete Verzeichnis /var/www)
   -rw-r--r-- 1 root developer 10701  9. Jan 19:04 index.html
   -rw-r--r-- 1 root developer    20  9. Jan 19:32 info.php
   ~~~

   Wir ändern für "*DocumentRoot*" den Eigentümer zu "*www-data*", geben der Gruppe Schreibrecht und entziehen allen anderen auch das Leserecht. Alles rekursiv.

   ~~~sh
   chown -R www-data /var/www/html
   chmod -R g+w /var/www/html
   chmod -R o-r /var/www/html
   ~~~

   Das Ergebnis überprüfen wir noch einmal.

   ~~~sh
   # ls -la /var/www/html
   insgesamt 24
   dr-xrws--x 2 www-data developer  4096  9. Jan 19:32 .
   drwxr-xr-x 3 root     root       4096  9. Jan 19:04 ..
   -rw-rw---- 1 www-data developer 10701  9. Jan 19:04 index.html
   -rw-rw---- 1 www-data developer    20  9. Jan 19:32 info.php
   ~~~

   Jetzt haben in "*DocumentRoot*" nur Mitglieder der Gruppe "*developer*" Schreibrecht, der Apache Webserver kann die Dateien lesen und schreiben, allen anderen wird der Zugriff verweigert.

4. Nachteile dieser Einstellungen

   Beim Anlegen neuer Verzeichnisse und Dateien unterhalb "*DocumentRoot*" ist der Eigentümer der jeweilige "*User*" und nicht "*www-data*". Dadurch kann der Apache-Webserver die Dateien nicht lesen.  
   Abhilfe schafft eine "*Systemd Path Unit*", die Änderungen unterhalb "*DocumentRoot*" überwacht und die Eigentümer- und Dateirechte anpasst. (Siehe das Beispiel in der Handbuchseite [Systemd-Path](./0715-systemd-path_de.md#systemd-path).)

**Ohne CMS**

Bei statischen Webseiten ist ein Content-Management-System vielfach nicht notwendig und bedeutet nur ein weiteres Sicherheitsrisiko und erhöhten Wartungsaufwand. Zusätzlich zu den zuvor getätigten Einstellungen kann dem Apache-Webserver das Schreibrecht an "*DocumentRoot*" entzogen werden, um die Sicherheit zu stärken, denn für den Fall, dass ein Angreifer eine Lücke in Apache findet, erhält er dadurch keine Schreibrechte in "*DocumentRoot*".

~~~sh
chmod -R u-w /var/www/html
~~~

### Sicherheit - Apache Standard

Wichtige Absicherungen enthält die Datei "*/etc/apache2/apache2.conf*" bereits standardmäßig.

Die nachfolgenden drei Direktiven verhindern den Zugang zum root-Dateisystem und geben dann die beiden vom Apache-Webserver verwendeten Verzeichnisse "*/usr/share*" und "*/var/www*" frei.

~~~apacheconf 
<Directory />
	Options FollowSymLinks
	AllowOverride None
	Require all denied
</Directory>

<Directory /usr/share>
	AllowOverride None
	Require all granted
</Directory>

<Directory /var/www/>
	Options Indexes FollowSymLinks
	AllowOverride None
	Require all granted
</Directory>
~~~

Die Optionen "*FollowSymLinks*" und "*Indexes*" bergen ein Sicherheitsrisiko und sollten geändert werden, sofern sie nicht unbedingt notwendig sind. Siehe weiter unten.

Die folgende Direktive unterbindet die Anzeige der Dateien "*.htaccess*" und "*.htpasswd*".

~~~apacheconf
<FilesMatch "^\.ht">
	Require all denied
</FilesMatch>
~~~

### Sicherheit - weitere Konfigurationen

+ In der Datei **/etc/apache2/apache2.conf**

  **FollowSymLinks** kann dazu führen, dass Inhalte außerhalb "*DocumentRoot*" gelistet werden.  
  **Indexes** listet den Inhalt eines Verzeichnisses, sofern keine "*index.html*" oder "*index.php*" usw. vorhanden ist.

  Es ist empfehlenswert "*FollowSymLinks*" zu entfernen und die Projektdaten alle unterhalb "*DocumentRoot*" abzulegen. Für die Option "*Indexes*" ist der Eintrag zu ändern in

  ~~~apacheconf
  Options -Indexes
  ~~~

  wenn die Anzeige des Verzeichnisinhaltes **nicht** erwünscht ist.  
  Alternativ erstellt man in dem Verzeichnis eine leere "*index*"-Datei, die an Stelle des Verzeichnisinhaltes an den Client ausgeliefert wird. Zum Beispiel für das "*upload*"-Verzeichnis:

  ~~~sh
  $ echo "<!DOCTYPE html>" > /var/www/html/upload/index.html
       oder
  $ echo "<?php" > /var/www/html/upload/index.php
  ~~~

+ In der Host-Konfiguration **/etc/apache2/sites-available/server1.conf**

  können wir mit dem "*\<Directory\>*"-Block alle IP-Adressen sperren, außer die darin gelisteten.

  ~~~apacheconf
  <Directory "/var/www/html">
	  Order deny,allow
	  Deny from all
	  Allow from 192.168.3.10
	  Allow from 192.168.3.1
  </Directory>
  ~~~

+ **"merging"** der Konfiguration

  Die Direktiven der Konfiguration verteilen sich auf eine ganze Reihe von Dateien innerhalb "*ServerRoot*" und auf die "*.htaccess*"-Dateien in "*DocumentRoot*". Es ist deshalb besonders wichtig zu wissen an welcher Stelle die Direktive zu platzieren ist, um die gewünschte Wirkung zu erzielen.  
  Wir empfehlen dringend die Webseite  
  [apache.org - How the sections are merged](https://httpd.apache.org/docs/current/de/sections.html#merging)  
  intensiv zu Rate zu ziehen.

+ Der **Eigentümer** von "*DocumentRoot*"

  ist nach der Installion "*root.root*" und sollte unbedingt geändert werden. Siehe hierzu das Kapitel [Benutzer und Rechte](#benutzer-und-rechte).

### HTTPS verwenden

Ohne HTTPS geht heute kein Webseitenprojekt an den Start.  
Wie man ein Zertifikat erlangt beschreibt die Webseite [HTTP-Guide](https://www.https-guide.de/) ausführlich und leicht verständlich.

Wir legen zuerst die nötigen Ordner innerhalb "*DocumentRoot*" an:

~~~sh
cd /etc/apache2/
/etc/apache2/# mkdir ssl ssl/certs ssl/privat
~~~

In diesen legen wir die Certifikatsdatei *server1.org.crt* und den privaten Schlüssel *server1.org.key* ab.

Dann sichern wir die Verzeichnisse gegen unbefugten Zugriff.

~~~bash
/etc/apache2/# chown -R root.root ssl
/etc/apache2/# chmod -R o-rwx ssl
/etc/apache2/# chmod -R g-rwx ssl
/etc/apache2/# chmod u-w ssl/certs/server1.org.crt
/etc/apache2/# chmod u-w ssl/private/server1.org.key
~~~

Der ls-Befehl zur Kontrolle:

~~~sh
/etc/apache2/# ls -la ssl
   insgesamt 20
   drwx------ 5 root root 4096 25. Jan 18:17 .
   drwxr-xr-x 9 root root 4096 25. Jan 18:43 ..
   drwx------ 2 root root 4096 25. Jan 18:16 certs
   drwx------ 2 root root 4096 25. Jan 18:16 private

/etc/apache2/# ls -l ssl/certs
   -r-------- 1 root root 1216 25. Jan 15:27 server1.org.crt
~~~

### Sicherheits Tipps

+ Die Apache Dokumentation enhält eine empfehlenswerte Seite mit diversen Tipps zur Absicherung.  
  [apache.org - Security Tipps](https://httpd.apache.org/docs/current/de/misc/security_tips.html) (englisch)

+ Darüber hinaus finden sich im Internet zahlreiche Hinweise zum sicheren Betrieb des Apache Webservers.

+ Die regelmäßige Kontrolle der Logdateien in "*/var/log/apache2/*" hilft um Fehler oder Sicherheitslücken zu erkennen.

+ Sollte der Server, anders als in dieser Handbuchseite vorgesehen, mit dem lokalen Netzwerk oder mit dem Internet verbunden werden, ist eine Firewall unerlässlich.

### Integration in Apache2

Das ssl-Modul ist in Apache per default aktviert. Es genügt die Datei "*/etc/apache2/sites-available/server1.conf*" zu bearbeiten.

+ Eine neue VirtualHost-Directive wird zu Beginn eingefügt. Diese leitet eingehende Client-Anfragen von Port 80 mittels "*Redirect*" auf Port 443 (ssl) weiter.

+ Die bisherige VirtualHost-Directive wird auf Port 443 umgeschrieben.

+ Nach den Standard Host-Anweisungen fügen wir die SSL-Anweisungen ein.

+ Für den Fall, dass unser Webprojekt dynamisch generierte Webseiten enthalten soll, werden die beiden letzten FileMatch- und Directory-Direktiven mit der "*SSLOptions*"-Anweisung eingefügt.

Die erweiterte "*server1.conf*" weist dann folgenden Inhalt auf:

~~~apacheconf
<VirtualHost *:80>
    ServerName server1.org
    ServerAlias www.server1.org
    Redirect / https://server1.org/
</VirtualHost>

<VirtualHost *:443>
    ServerName server1.org
    ServerAlias www.server1.org
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    ErrorLog ${APACHE_LOG_DIR}/error_server1.log
    CustomLog ${APACHE_LOG_DIR}/access_server1.log combined

    SSLEngine on
    SSLProtocol all -SSLv2 -SSLv3
    SSLCertificateFile	    /etc/apache2/ssl/certs/server1.org.crt
    SSLCertificateKeyFile	/etc/apache2/ssl/private/server1.org.key

    <Directory "/var/www/html">
    	Order deny,allow
    	Deny from all
    	Allow from 192.168.3.10
    	Allow from 192.168.3.1
    </Directory>

    <FilesMatch "\.(cgi|shtml|phtml|php)$">
    	SSLOptions +StdEnvVars
    </FilesMatch>

    <Directory /usr/lib/cgi-bin>
    	SSLOptions +StdEnvVars
    </Directory>
</VirtualHost>
~~~

Für den Fall, dass unser fertiges Projekt später bei einem Hoster ohne Zugriff auf "*ServerRoot*" liegt (das ist die Regel), können wir in "*DocumentRoot*" die Datei "*.htaccess*" um eine Rewrite-Anweisung ergänzen bzw. die Datei mit der Rewrite-Anweisung anlegen.

~~~apacheconf
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteCond %{HTTPS} !=on
RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
</IfModule>
~~~

### Quellen Apache

[apache.org - Dokumentation](https://httpd.apache.org/docs/current/de/) (teilweise deutsch)  
[apache.org - Konfigurationsdateien](https://httpd.apache.org/docs/current/de/configuring.html)  
[apache.org - SSL Howto](https://httpd.apache.org/docs/2.4/ssl/ssl_howto.html)  
[HTTPS Guide - Servercertifikate erstellen und integrieren](https://www.https-guide.de/)

<div id="rev">Zuletzt bearbeitet: 2021-07-12</div>
