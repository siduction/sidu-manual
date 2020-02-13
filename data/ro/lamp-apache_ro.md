<div id="main-page"></div>
<div class="divider" id="serv-apache"></div>
## Setul LAMP din siduction

Acronimul LAMP se referă la un set de programe libere, de obicei folosite împreună , pentru a rula pagini web dinamice sau servere :  
 **L** inux , sistemul de operare  
 **A** pache, serverul Web  
 **M** ySQL, managementul bazelor de date (sau database server)  
 **P** erl, PHP, si/sau Python, limbaje de programare

##### ATENŢIE : Nu folosiţi niciodată computerul de zi cu zi pentru a se comporta ca un internet web server ! Utilizaţi un PC dedicat ca server şi care să nu facă nimic altceva !

Utilizările Serverului :  
a) `un server local de test pentru desenatorii de pagini web fără conexiune la internet , care este şi ţinta acestui articol ;`   
b) un server privat (closet) conectat la internet ;  
c) un server de web privat complet accesibil de pe internet  
d) un server de web comercial , care este în afara scopului acestui manual 

##### Cerinţe Minime

Necesită cel puţin 256 MB de RAM . Orice cantitate de memorie mai mică decât aceasta va genera o mulţime de probleme , din cauză că un server cu mysql necesită multă memorie RAM pentru a rula corect . Mysql va gerera erori de genul "cannot connect to mysql.sock" dacă nu există destulă memorie RAM în server .

Pachetele ce trebuie instalate sunt:

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

**`ATENŢIE: `**

~~~  
apt-get remove --purge splashy  
~~~

**`Deoarece splashy întotdeauna împiedică rularea mysql.`**

Fişierul de configurare Apache este localizat la `/etc/apache2/apache2.conf`  şi directorul web este `/var/www`  

Pentru a verifica dacă php este instalat şi rulează corect, creaţi un fișier numit test.php în directorul /var/www cu funcţia phpinfo() exact cum este arătat mai jos.

~~~  
mcedit /var/www/test.php  
# test.php  
<? phpinfo(); ?>  
~~~

Directionaţi browserul către :

~~~  
http://localhost/test.php  
(sau)  
http://yourip:80/test.php  
~~~

Aceasta vă va arăta toată configuraţia php şi setările implicite .

Puteţi edita valorile necesare sau seta domeniile virtuale folosind fişierul de configurare apache.

Dacă doriţi să vă testaţi instalarea mergeţi în browserul dumneavoastră şi tastaţi următoarele :

~~~  
http://youripaddress/apache2-default/  
~~~

Aceasta va întoarce mesajul de bun venit şi apoi că instalarea este corectă .

Directorul web root implicit pentru apache 2 este `/var/www` . Schimbaţi aceasta în: 

~~~  
mkdir /home/myself/www  
ln -s /home/myself/www /var/www  
~~~

Lansând comanda de mai sus veţi putea edita pagina web din directorul home ca utilizator normal .

<div class="divider" id="serv-ftp"></div>
## Clienţi FTP 

Folosiţi SSH și citiţi cu atenţie  [topicul SSH](ssh-ro.htm) , deasemeni siduction are un alt client FTP încorporat şi anume Konqueror , pentru a vă permite să faceţi upload la fişierele dumneavoastră.

<div class="divider" id="serv-sec"></div>
## Activarea celor mai bune protocoale de securitate pentru Web Servere

### Firewalls

**`Dacă nu aveţi un firewall nu aveţi securitate pe server . Tineţi minte : blocaţi TOTUL până la folosire , apoi re-blocaţi !`** .

~~~  
21 (ftp)  
22 (SSH)  
25 110 (email)  
443 (SSL http or https)  
993 (imap ssl)  
995 (pop3 ssl)  
80 (http)  
and any other port going!  
~~~

### Protejarea Implicită a Fişierelor din Server 

Un aspect din Apache care este de multe ori înţeles greşit este opţiunea accesului implicit . Aceasta înseamnă că, pănă când nu va fi schimbată de dumneavoastră, că dacă serverul poate găsi calea către un fişier prin reguli normale de URL mapping, atunci aceasta poate servi şi clienților.

De pildă , în următorul exemplu :

~~~  
1. # cd /; ln -s / public_html  
2. Accessing http://localhost/~root/  
~~~

**`Aceasta va permite clientilor să "se plimbe " prin întreg sistemul de fisiere ! Pentru a corecta , adăugaţi următorul bloc la configurarea serverului :`**

~~~  
<Directory />  
Order Deny,Allow  
Deny from all  
</Directory>  
~~~

Aceasta va interzice accesul implicit către locaţiile fişierelor . Adăugaţi blocuri &lt;Directory&gt; specifice pentru a permite accesul doar în zonele care doriţi . De exemplu ,

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

Acordaţi o atenţie deosebită interacţiunii dintre directivele &lt;Location&gt; și &lt;Directory&gt; pentru că , chiar dacă &lt;Directory /&gt; interzice accesul , o directivă &lt;Location /&gt; poate schimba acest lucru .

Deasemeni fiţi foarte precauţi dacă jucaţi jocuri cu directiva UserDir ; setând aceasta ca "./" va avea acelaşi efect , pentru root , ca în primul exemplu de mai sus . Dacă folosiţi versiunea Apache 1.3 sau ulterioară , vă recomandăm în mod deosebit să includeţi următoarea linie în fişierul de configurare al serverului :

~~~  
UserDir disabled root  
~~~

<div class="divider" id="serv-ssl"></div>
## SSL

Rulaţi scriptul “apache2-ssl-certificate” 

~~~  
# apache2-ssl-certificate  
~~~

Următorul ecran va apare, introduceţi toate informaţiile cerute .

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

Rulaţi scriptul “a2enmod ssl” i.e

~~~  
# a2enmod ssl  
~~~

Acesta va genera automat un link simbolic între mods- available şi mods – enabled 

Copiați fișierul '/etc/apache2/sites-available/default' în /etc/apache2/sites-available/ - și numiți-l 'ssl'

~~~  
# cp /etc/apache2/sites-available/default /etc/apache2/sites-available/ssl  
~~~

Faceţi un sym-link către această nouă configurare de site pe care să o folosiţi 

~~~  
# ln -s /etc/apache2/sites-available/ssl /etc/apache2/sites-enabled/  
(sau)  
#a2ensite ssl  
~~~

Dacă doriţi să modificaţi oricare dintre setările configuraţiei de baza schimbaţi în /etc/apache2/apache2.conf şi dacă doriţi să schimbaţi document root schimbaţi în /etc/apache2/sites-available/default şi restartaţi serverul apache .

Pentru a Restarta serverul Apache folosiţi următoarea comandă :

~~~  
#/etc/init.d/apache2 restart  
~~~

Acum trebuie să schimbăm adresa portului în /etc/apache2/ports.conf ; implicit va asculta pe portul 80 iar acum instalăm cu SSL va trebui să schimbăm portul de ascultare pe portul 443 

~~~  
Listen 443  
~~~

Editati /etc/apache2/sites-available/ssl (sau cum aţi denumit noua configurare ssl a site-ului ) şi schimbaţi portul 80 din numele site-ului în 443.

Adăugaţi următoarele două linii în fişierul /etc/apache2/apache2.conf 

~~~  
SSLEngine On  
SSLCertificateFile /etc/apache2/ssl/apache.pem  
~~~

Editaţi SSLCertificateFile /etc/apache2/ssl/apache.pem şi introduceţi locaţiile pentru certificate file şi certificate key file . Mai jos este exemplul 

~~~  
SSLCertificateFile /etc/apache2/ssl/online.test.net.crt  
SSLCertificateKeyFile /etc/apache2/ssl/online.test.net.key  
~~~

Setaţi ServerSignature off , urmaţi aceşti paşi, editaţi fişierul /etc/apache2/apache2.conf şi adăugaţi aceste două linii :

~~~  
ServerSignature Off  
ServerTokens ProductOnly  
~~~

Dacă doriţi să permiteţi diferite tipuri de fişiere index verificaţi dacă există următoarea linie în fişierul /etc/apache2/apache2.conf 

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Restartaţi serverul apache

~~~  
/etc/init.d/apache2 restart  
~~~

Veţi avea de acum un server de test , dacă doriţi să vă conectaţi la internet cu el ..., **`NU O FACEŢI , folosiţi un alt PC pentru a fi un server web dedicat internet !`** 

Informații complete la :

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 30/11/2012 1433 UTC</div>
