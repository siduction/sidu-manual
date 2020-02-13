<div id="main-page"></div>
<div class="divider" id="serv-apache"></div>
## siduction LAMP Stack

The acronym LAMP refers to a set of free software programs commonly used together to run dynamic Web sites or servers  
Linux, the operating system  
Apache, the Web server  
MySQL, the database management system (or database server)  
Perl, PHP, and/or Python, scripting languages

##### WARNING: Never use your day-to-day PC to act as an internet web server! Use a dedicated PC to be an internet web server and let it do nothing else!

Server uses:  
a) `a local test server for web designers without internet connectivity which is the scope of this topic;`   
b) a private "closet" server connected to the net;  
c) a private web server fully propagated to the internet  
d) a commercial web server which is beyond the scope of this manual

##### Minimum Requirements

At least 256MB of RAM available. Anything less than this minimum ram will cause lot of problems since running a server with mysql requires lot of RAM to run properly. Mysql will error of "cannot connect to mysql.sock" if you dont have enough memory in your server.

The packages you will need to install are:

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

**`WARNING `**

~~~  
apt-get remove --purge splashy  
~~~

**`As splashy always breaks mysql`**

The Apache configuration file is located at:`/etc/apache2/apache2.conf`  and your web folder is `/var/www` . Do not tweak the debian default settings for 'mpm-worker/mpm-prefork' as the debian defaults are sane. 

To check whether php is installed and running properly, just create a test.php in your /var/www folder with phpinfo() function exactly as shown below.

~~~  
mcedit /var/www/test.php  
# test.php  
<? phpinfo(); ?>  
~~~

Point your browser to:

~~~  
http://localhost/test.php  
or  
http://yourip:80/test.php  
~~~

This should show all your php configuration and default settings.

You can edit necessary values or setup virtual domains using apache configuration file.

If you want to test your installation go to your browser and type the following

~~~  
http://youripaddress/apache2-default/  
~~~

This should display welcome message then your installation is correct.

Default document root directory for apache2 is `/var/www`  Change this to: 

~~~  
mkdir /home/myself/www  
ln -s /home/myself/www /var/www  
~~~

By doing the above commands you can now edit your web site inside your home as normal user.

<div class="divider" id="serv-ftp"></div>
## FTP Clients

Use SSH and read carefully the  [SSH topic](ssh-en.htm#ssh)  , also siduction has another built in FTP client in the form of Konqueror to enable you to upload your files.

<div class="divider" id="serv-sec"></div>
## Enabling good security protocols for Web Servers

### Firewalls

**`Without a firewall there is absolutely no security for your server. Remember block EVERYTHING until you need it, then reblock it!`** .

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

### Protect Server Files by Default

One aspect of Apache which is occasionally misunderstood is the feature of default access. That is, unless you take steps to change it, if the server can find its way to a file through normal URL mapping rules, therefore it can serve it to clients.

For instance, consider the following example:

~~~  
1. # cd /; ln -s / public_html  
2. Accessing http://localhost/~root/  
~~~

**`This would allow clients to walk through the entire filesystem! To work around this, add the following block to your server's configuration:`**

~~~  
<Directory />  
Order Deny,Allow  
Deny from all  
</Directory>  
~~~

This will forbid default access to filesystem locations. Add appropriate &lt;Directory&gt; blocks to allow access only in those areas you wish. For example,

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

Pay particular attention to the interactions of &lt;Location&gt; and &lt;Directory&gt; directives; for instance, even if &lt;Directory /&gt; denies access, a &lt;Location /&gt; directive might overturn it.

Also be wary of playing games with the UserDir directive; setting it to something like "./" would have the same effect, for root, as the first example above. If you are using Apache 1.3 or above, we strongly recommend that you include the following line in your server configuration files:

~~~  
UserDir disabled root  
~~~

<div class="divider" id="serv-ssl"></div>
## SSL

Run the script “apache2-ssl-certificate”

~~~  
# apache2-ssl-certificate  
~~~

The following screen will appear for you to enter all the required information.

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

Run the script “a2enmod ssl” i.e

~~~  
# a2enmod ssl  
~~~

This will automatically generate a symbolic link between mods- available and mods – enabled 

Make a copy of '/etc/apache2/sites-available/default' file in the /etc/apache2/sites-available/ - call it 'ssl'

~~~  
# cp /etc/apache2/sites-available/default /etc/apache2/sites-available/ssl  
~~~

Make a sym-link to this new site configuration for this use

~~~  
# ln -s /etc/apache2/sites-available/ssl /etc/apache2/sites-enabled/  
(or)  
#a2ensite ssl  
~~~

If you want to change the any basic configuration settings change in /etc/apache2/apache2.conf and if you want to change the default document root change in /etc/apache2/sites-available/default file and restart the apache server.

To Restart Apache server use the following command

~~~  
#/etc/init.d/apache2 restart  
~~~

Now we need to change the port address in /etc/apache2/ports.conf by default it will listen port 80 and now we are installing with SSL we need to change port 443 to listen

~~~  
Listen 443  
~~~

Edit /etc/apache2/sites-available/ssl (or whatever you called your new ssl site's config) and change port 80 in the name of the site to 443.

Add below two lines some where in /etc/apache2/apache2.conf file

~~~  
SSLEngine On  
SSLCertificateFile /etc/apache2/ssl/apache.pem  
~~~

Edit SSLCertificateFile /etc/apache2/ssl/apache.pem and enter the locations of certificate file and certificate key file .Below one is the example

~~~  
SSLCertificateFile /etc/apache2/ssl/online.test.net.crt  
SSLCertificateKeyFile /etc/apache2/ssl/online.test.net.key  
~~~

Set ServerSignature off, follow these steps edit the /etc/apache2/apache2.conf file and add these two lines

~~~  
ServerSignature Off  
ServerTokens ProductOnly  
~~~

If you want to allow the different index files types check for the following line in /etc/apache2/apache2.conf file

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Restart the apache server

~~~  
/etc/init.d/apache2 restart  
~~~

You should now have a test server sandbox, should you want to connect to the interent, with it. **`DONT!... Use another PC purely dedicated to being an internet web server!`** 

Sources:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 10/01/2012 1800 UTC</div>
