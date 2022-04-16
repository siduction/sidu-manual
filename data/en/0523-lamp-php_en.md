% LAMP - PHP

## Set up PHP

PHP is ready to use in siduction after installation with the default configuration.  

### PHP in the file system

Debian has fully integrated the files of PHP into the file system according to their function:

+ the executable program `php7.x` and the link `php` into `/usr/bin/`   
    + (The latter points to `/usr/bin/php7.x` via `/etc/alternatives/php`.)  
+ the installed modules into `/usr/lib/php/`  
+ shared program parts and modules into `/usr/share/php/` and `/usr/share/php<module>`  
+ the configuration directories and files into `/etc/php/`  
+ the current state of modules and sessions at runtime into `/var/lib/php/`

### PHP support for Apache2

By default, the Apache web server loads support for PHP. We check this with the following command
(replace the *"x"* with the minor attribute of the currently used PHP version, i.e. something like 7.4):

~~~
# ls /etc/apache2/mods-enabled/* | grep php
/etc/apache2/mods-enabled/php7.x.conf
/etc/apache2/mods-enabled/php7.x.load
~~~

We see that Apache has loaded the PHP module for version 7.x. To cause the PHP interpreter to process files with the extension "*.php*", the `DirectoryIndex` directive in the Apache configuration file `dir.conf` must contain the value `index.php`. We check this as well:

~~~
# cat /etc/apache2/mods-available/dir.conf
<IfModule mod_dir.c>
    DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm
</IfModule>
~~~

Nothing stands in the way of using PHP, because the value *"index.php"* is included.

### PHP configuration

The directory `/etc/php/7.x/` contains the configuration sorted by the available interfaces.  
The output shows the state after the initial installation.

~~~
# ls -l /etc/php/7.x/
total 20
drwxr-xr-x 3 root root 4096 18 Dec 16:54 apache2
drwxr-xr-x 3 root root 4096 18 Dec 16:54 cli
drwxr-xr-x 2 root root 4096 18 Dec 16:54 mods-available
~~~

With the modules *"php7.x-cgi"* and *"php7.x-fpm"* installed below, two new directories have been added.

~~~
# ls -l /etc/php/7.x/
total 20
drwxr-xr-x 3 root root 4096 18 Dec 16:54 apache2
drwxr-xr-x 3 root root 4096 1 Feb 21:23 cgi
drwxr-xr-x 3 root root 4096 18 Dec 16:54 cli
drwxr-xr-x 4 root root 4096 1 Feb 21:23 fpm
drwxr-xr-x 2 root root 4096 1 Feb 13:22 mods-available
~~~

Each of the `apache2`, `cgi`, `cli`, and `fpm` directories contains a `conf.d` folder and a `php.ini` file.  
The respective *"php.ini"* contains the configuration for the corresponding interface and can be changed or supplemented if necessary. The *"conf.d"* folder contains the links to the activated modules.

### PHP modules

**Queries**

A large number of modules are available for PHP. You can find out which ones are already installed with

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

To show available but not installed modules, we change the end of the command a bit:

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

Now we know the exact names of the modules.

**Info**

More detailed descriptions of the modules are provided by the command

~~~
# apt show <module_name>
~~~

**Installation**

To install modules we use e.g.:

~~~
# apt install php7.x-cgi php7.x-fpm
~~~

Both modules support CGI scripts and Fast/CGI requests.  
Then we restart Apache:

~~~
# systemctl restart apache2.service
~~~

**Handling**

The state of PHP modules can be changed during runtime. This also allows controlling modules in scripts to load them before use and unload them afterwards.

+ `phpenmod` - activates modules in PHP  
+ `phpdismod` - disables modules in PHP  
+ `phpquery` - shows the status of PHP modules

Unnecessary modules (imagick in the example) are deactivated in the console by the command

~~~
# phpdismod imagick
~~~

To load the imagick module for all interfaces, use the command

~~~
# phpenmod imagick
~~~

If we use the option `-s apache2`, e.g.:

~~~
# phpenmod -s apache2 imagick
~~~

the module will be loaded for Apache2 only.

The status query with `phpquery` always requires the module version and interface to be specified. Here are some examples:

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

For the imagick module, the string *"Enabled for apache2 by local administrator"* tells us that it was not loaded automatically at startup like the zip module, but that the administrator has enabled it manually. The reason is the previously used `phpdismod` and `phpenmod` commands for this module.

### Apache Log

The Apache server stores the error messages of PHP in its log files under `/var/log/apache2/`. At the same time, if PHP functions fail, a message appears on the called web page.  
Alternatively, we can display the log functions.

~~~
# php --info | grep log
[...]
error_log => no value
log_errors => On
log_errors_max_len => 1024
mail.log => no value
opcache.error_log => no value
[...]
~~~

In the files `/etc/php/7.x/<Interface>/php.ini`, we have the possibility to replace the unset values with our own, actually existing log files.

### Sources PHP

[PHP - manual](https://www.php.net/manual/en/)  
[PHP - current messages](https://www.php.net/)  
[tecadmin - module handling](https://tecadmin.net/enable-disable-php-modules-ubuntu/)

<div id="rev">Last edited: 2022/04/04</div>
