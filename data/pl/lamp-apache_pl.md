<div id="main-page"></div>
<div class="divider" id="serv-apache"></div>
## System LAMP siduction.org

Akronim LAMP odnosi się do się do zestawu oprogramowania z otwartym dostępem do kodu źródłowego powszechnie używanego jako platforma serwerowa dynamicznych stron WWW  
Linux, system operacyjny  
Apache, serwer WWW  
MySQL, system zarządzania bazami danych (lub serwer baz danych)  
Perl, PHP, i/lub Python, języki skryptowe

##### UWAGA: Nigdy nie używaj komputera, z którego korzystasz codziennie, w roli an internet web serwera! Przeznacz inny komputer, aby był serwerem i niech to będzie jego jedyne zadanie!

Serwer używa:  
a) `lokalnego serwera testowego dla projektantów stron bez połączenia do sieci; jest on głównym tematem tego opracowania`   
b) prywatnego serwera z połączeniem do internetu  
c) prywatnego serwera z pełnym dostępem do internetu  
d) komercyjnego serwera WWW, którym ta instrukcja się nie zajmie

##### Minimalne wymagania

Dostępne przynajmniej 256MB pamięci RAM. Mniejsza ilość pamięci będzie powodować wiele problemów, ponieważ działający serwer z mysql wymaga dużo pamięci, aby działać poprawnie. Mysql będzie informować o błędzie "cannot connect to mysql.sock", jeśli nie masz wystarczająco dużo RAM w twoim serwerze.

Pakiety potrzebne do instalacji:

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

**`UWAGA `**

~~~  
apt-get remove --purge splashy  
~~~

**`splashy zawsze psuje mysql`**

Plik konfiguracyjny Apache znajduje się w:`/etc/apache2/apache2.conf` , a katalog WWW jest w `/var/www`  

Aby sprawdzić, czy php jest zainstalowane i działa poprawnie, stwórz test.php w katalogu /var/www z funkcją phpinfo() dokładnie jak podano poniżej:

~~~  
nano /var/www/test.php  
# test.php  
<? phpinfo(); ?>  
~~~

Wskaż swojej przeglądarce adres:

~~~  
http://localhost/test.php  
lub  
http://yourip:80/test.php  
~~~

Powinno to pokazać całą konfigurację php oraz domyślne ustawienia.

Możesz edytować niezbędne wartości lub konfiguracje wirtualnych domen używając pliku konfiguracyjnego apache.

Jeśli chcesz przetestować swoją instalację, uruchom przeglądarkę i wpisz

~~~  
http://twojdresip/apache2-default/  
~~~

Powinna pojawić się informacja powitalna oznaczająca, że instalacja jest poprawna.

Domyślny katalog główny dla dokumentów dla apache2 znajduje się w `/var/www`  

Jeśli chcesz zmienić domyślny katalog główny dla dokumentów w apache2 musisz zmodyfikować plik `/etc/apache2/sites-available/default` . Edytuj ten plik i zmień ścieżkę.

<div class="divider" id="serv-ftp"></div>
## Klienty FTP

Użyj SSH i przeczytaj dokładnie  [temat o SSH](ssh-pl.htm)  , także siduction posiada wbudowany klient FTP w postaci Konquerora, aby umożliwić ci wysłanie swoich plików.

<div class="divider" id="serv-sec"></div>
## Włączenie bezpiecznych protokołów dla serwerów WWW

### Firewalle

**`Bez firewalla nie masz żadnego zabezpieczenia dla twojego serwera. Pamiętaj, aby blokować WSZYSTKO do czasu, aż będziesz tego potrzebować, po wykorzystaniu zablokuj to ponownie!`** .

~~~  
21 (ftp)  
22 (SSH)  
25 110 (email)  
443 (SSL http lub https)  
993 (imap ssl)  
995 (pop3 ssl)  
80 (http)  
i wszystkie inne używane porty!  
~~~

### Ochrona danych serwera

Jednym z aspektów Apache, który jest czasami źle rozumiany, jest funkcja domyślnego dostępu. Oznacza to, że jeśli nie podejmiesz kroków, aby to zmienić, jeśli serwer może znaleźć drogę do pliku poprzez normalne zasady mapowania URL, to będzie mógł dostarczyć go klientom.

Rozważ następujący przykład:

~~~  
1. # cd /; ln -s / public_html  
2. Accessing http://localhost/~root/  
~~~

**`To umożliwiłoby klientom przejście przez cały system plików! Aby to uniemożliwić, dodaj następującą blokadę do konfiguracji twojego serwera:`**

~~~  
<Directory />  
Order Deny,Allow  
Deny from all  
</Directory>  
~~~

Uniemożliwi domyślny dostęp do systemu plików. Dodaj odpowiednie blokady &lt;Directory&gt; aby pozwolić na dostęp tylko do tych katalogów, do których chcesz. Na przykład,

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

Zwróć szczególną uwagę na interakcje pomiędzy instrukcjami &lt;Location&gt; i &lt;Directory&gt; ; na przykład, nawet jeśli &lt;Directory /&gt; zabrania dostępu, to instrukcja &lt;Location /&gt; może to unieważnić.

Bądź nieufny w stosunku do gier, które zawierają instrukcję UserDir; ustawienie jej w np. taki sposób "./", miałoby ten sam efekt dla roota, jak pierwszy przykład powyżej. Jeśli używasz Apache 1.3 lub nowszego, zalecamy, abyś dołączył następującą linię do twojej konfiguracji serwera:

~~~  
UserDir disabled root  
~~~

<div class="divider" id="serv-ssl"></div>
## SSL

Uruchom skrypt “apache2-ssl-certificate”

~~~  
# apache2-ssl-certificate  
~~~

Pojawi się następujący ekran, abyś mógł wprowadzić wszystkie wymagane informacje.

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

Uruchom skrypt “a2enmod ssl” 

~~~  
# a2enmod ssl  
~~~

Wygeneruje to link symboliczny między dostępnymi a aktywnymi mods- 

Utwórz kopię pliku '/etc/apache2/sites-available/default' w /etc/apache2/sites-available/ - nazywając ją 'ssl'

~~~  
# cp /etc/apache2/sites-available/default /etc/apache2/sites-available/ssl  
~~~

Utwórz link symboliczny do tej nowej konfiguracji

~~~  
# ln -s /etc/apache2/sites-available/ssl /etc/apache2/sites-enabled/  
(lub)  
#a2ensite ssl  
~~~

Jeśli chcesz zmienić jakiekolwiek podstawowe ustawienia, zmień w /etc/apache2/apache2.conf, a jeśli chcesz zmienić domyślny katalog dla dokumentów, zmień plik /etc/apache2/sites-available/default i uruchom ponownie serwer apache.

Aby uruchomić ponownie serwer Apache, użyj następującego polecenia

~~~  
#/etc/init.d/apache2 restart  
~~~

Teraz musimy zmienić port w /etc/apache2/ports.conf, domyślnie używany jest port 80, a my musimy zmienić go na 443

~~~  
Listen 443  
~~~

Edytuj /etc/apache2/sites-available/ssl (lub inny, w którym masz konfigurację ssl) i zmień port 80 w nazwie strony na 443.

Dodaj poniżej dwie linie gdzieś w pliku /etc/apache2/apache2.conf

~~~  
SSLEngine On  
SSLCertificateFile /etc/apache2/ssl/apache.pem  
~~~

Edytuj SSLCertificateFile /etc/apache2/ssl/apache.pem i wpisz lokalizacje pliku z certyfikatem i pliku z kluczem certyfikatu. Poniżej przykład

~~~  
SSLCertificateFile /etc/apache2/ssl/online.test.net.crt  
SSLCertificateKeyFile /etc/apache2/ssl/online.test.net.key  
~~~

Wyłącz ServerSignature, edytuj plik /etc/apache2/apache2.conf i dodaj dwie linie:

~~~  
ServerSignature Off  
ServerTokens ProductOnly  
~~~

Jeśli chcesz pozwolić na różne typy pliku index, sprawdź następujące linie w pliku /etc/apache2/apache2.conf

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Uruchom ponownie serwer apache

~~~  
/etc/init.d/apache2 restart  
~~~

Powinieneś teraz mieć sandbox serwera testowego. Ten testowy serwer **`nie powinien być podłączony do internetu. Używaj do tego komputera przeznaczonego, aby pełnić rolę an internet web serwera!`** 

Źródła:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
