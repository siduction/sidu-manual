<div id="main-page"></div>
<div class="divider" id="serv-mysql"></div>
## Configuração do Mysql

Assegure-se de que a linha abaixo existe em seu arquivo apache2.conf (ou no conf.d/php.ini):

~~~  
#extension=php_mysql.so  
~~~

Descomente-a, de forma que ela fique assim:

~~~  
extension=php_mysql.so  
~~~

O arquivo de configuração do mysql pode ser encontrado em /etc/mysql/my.cnf.

Por padrão, o mysql cria usuários como root e roda sem senha. Para mudar a Senha de Root:

~~~  
mysql> USE mysql;  
mysql> UPDATE user SET Password=PASSWORD('nova-senha') WHERE user='root';  
mysql> FLUSH PRIVILEGES;  
~~~

##### Para criar um novo usuário

Você nunca deve usar a senha de root, portanto você precisa criar um usuário para conectar-se ao banco de dados do mysql para um script PHP. Alternativamente, você pode adicionar usuários ao banco de dados do mysql usando um painel de controle, como o phpMyAdmin, para facilmente criar ou atribuir permissões aos usuários, para que eles possam acessar o banco.

Para ter acesso à interface web, digite na barra de endereço do navegador e pressione [ENTER]:

~~~  
http://ipaddress/phpmyadmin/  
~~~

Quando ele pedir usuário e senha, entre o root do banco de dados como usuário e a senha (conforme já dissemos, o padrão do mysql é rodar sem senha para o usuário root).

Maiores informações:

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
