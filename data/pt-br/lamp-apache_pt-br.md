<div id="main-page"></div>
<div class="divider" id="serv-apache"></div>
## LAMP no siduction

O acrônimo LAMP refere-se a um conjunto de softwares livres usados em servidores ou sites dinâmicos da Web. São eles:  
Linux, o sistema operacional  
Apache, o servidor Web  
MySQL, o sistema gerenciador de banco de dados (ou, simplesmente, servidor de banco de dados)  
Perl, PHP e/ou Python, linguagens usadas nos scripts

##### ATENÇÃO: Nunca use seu computador pessoal como servidor Web! Use um PC dedicado para fazer exclusivamente esse papel e nada mais!!

Tipos de servidores:  
a) `servidor de testes local para 'web designers', sem conexão com a Internet (será tratado no presente tópico);`   
b) servidor privado "fechado", conectado com a Internet;  
c) servidor privado aberto, com total propagação pela Internet;  
d) servidor web comercial (está além da cobertura deste tópico).

##### Requisitos Mínimos

256MB de RAM; menos que isso irá causar uma série de problemas, pois um servidor com mysql exige uma grande quantidade de RAM para rodar a contento. O mysql emitirá mensagens de erro como "impossível conectar com mysql.sock" se seu servidor não tiver memória suficiente.

<!--#### O pacote genérico do siduction para servidores

O pacote 'Generic_server' do siduction consiste de vários programas empacotados juntos e instalados via instalador do Meta-Package. Os aplicativos são os seguintes:

-->
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

**`ATENÇÃO:`**

~~~  
apt-get remove --purge splashy  
~~~

**`...porque a splashy sempre corrompe o mysql`**

O arquivo de configuração do Apache fica em: `/etc/apache2/apache2.conf`  e sua pasta web é `/var/www`  

Para confirmar que o php está instalado e rodando de forma apropriada, crie o arquivo 'test.php' em sua pasta /var/www com a função phpinfo(), exatamente como mostrado abaixo:

~~~  
mcedit /var/www/test.php  
# test.php  
<? phpinfo(); ?>  
~~~

Aponte seu navegador para:

~~~  
http://localhost/test.php  
ou  
http://yourip:80/test.php  
~~~

Isso deve mostrar toda a configuração de seu php.

Você pode editar valores necessários ou criar domínios virtuais usando o arquivo de configuração do Apache.

Se quiser testar sua instalação, digite o seguinte no navegador:

~~~  
http://seu_endereço_IP/apache2-default/  
~~~

Se você vir uma mensagem de boas-vindas, então a instalação está correta.

O diretório de documentos padrão do Apache2 é `/var/www` . Digite os comandos abaixo para mudá-lo: 

~~~  
mkdir /home/seu_nome_de_usuário/www  
ln -s /home/seu_nome_de_usuário/www /var/www  
~~~

Agora, você já pode editar seu site dentro de sua pasta /home, como usuário comum.

<div class="divider" id="serv-ftp"></div>
## Clientes FTP

Use SSH e leia atentamente o  [tópico sobre o SSH](ssh-pt-br.htm)  . O siduction também possui outro cliente FTP incorporado, usando o Konqueror, que lhe permite transmitir (upload) seus arquivos.

<div class="divider" id="serv-sec"></div>
## Como habilitar bons protocolos de segurança em servidores Web

### Firewalls

**`Sem um firewall, seu servidor fica absolutamente sem segurança. Lembre-se de bloquear TUDO, desbloquear momentaneamente o que precisar e voltar a BLOQUEAR logo em seguida!`** !

~~~  
21 (ftp)  
22 (SSH)  
25 110 (email)  
443 (SSL, http ou https)  
993 (imap, ssl)  
995 (pop3, ssl)  
80 (http)  
... e quaisquer outras portas!  
~~~

### Proteja arquivos de servidores

Um aspecto do Apache que às vezes é mal-entendido é seu 'default access' (acesso padrão). Funciona assim: a menos que você altere o padrão de comportamento, se o servidor conseguir encontrar um arquivo pelas regras normais de mapeamento de URL, ele poderá disponibilizá-lo para os clientes.

Para ilustrar, veja o seguinte exemplo:

~~~  
1. # cd /; ln -s / public_html  
2. Accessing http://localhost/~root/  
~~~

**`Isso permite aos clientes navegar por o todo o sistema de arquivos! Para impedir isso, adicione o seguinte bloqueio à configuração de seu servidor:`**

~~~  
<Directory />  
Order Deny,Allow  
Deny from all  
</Directory>  
~~~

Com isso fica proibido o acesso padrão ao sistema de arquivos. Adicione bloqueios aos &lt;Directory&gt; (Diretórios) apropriados, de forma a permitir o acesso somente àquelas áreas que você desejar. Por exemplo:

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

Preste atenção, particularmente, à interação entre as diretivas &lt;Location&gt; (Local) e &lt;Directory&gt; (Diretório); por exemplo, ainda que &lt;Directory /&gt; negue acesso, uma diretiva &lt;Location /&gt; se sobreporá a ele.

Cuidado também ao brincar com a diretiva UserDir; configurando-a para algo do tipo "./" terá o mesmo efeito, para o root, do primeiro exemplo acima. Se você estiver usando o Apache 1.3 ou superior, recomendamos que inclua a seguinte linha no arquivo de configuração do servidor:

~~~  
UserDir disabled root  
~~~

<div class="divider" id="serv-ssl"></div>
## SSL

Rode o script “apache2-ssl-certificate”

~~~  
# apache2-ssl-certificate  
~~~

Aparece a seguinte tela, onde você deverá fornecer todas as informações solicitadas (para deixar um campo em branco, digite ".", sem as aspas):

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
Country Name (2 letter code) [GB]: [Nome do país, com 2 letras]  
State or Province Name (full name) [Some-State]: [Nome do estado, por extenso]  
Locality Name (eg, city) []: [Nome da cidade]  
Organization Name (eg, company; recommended) []: [Nome da empresa]  
Organizational Unit Name (eg, section) []: [Nome da Unidade Organizacional]  
server name (eg. ssl.domain.tld; required!!!) []: [Nome do servidor; obrigatório]  
Email Address []: [Endereço de email]  
~~~

Rode o script “a2enmod ssl”:

~~~  
# a2enmod ssl  
~~~

Ele vai gerar, automaticamente, um link simbólico entre mods- available e mods – enabled 

Faça uma cópia do arquivo '/etc/apache2/sites-available/default' em /etc/apache2/sites-available/ - com o nome de 'ssl':

~~~  
# cp /etc/apache2/sites-available/default /etc/apache2/sites-available/ssl  
~~~

Faça um link simbólico para essa novo arquivo de configuração:

~~~  
# ln -s /etc/apache2/sites-available/ssl /etc/apache2/sites-enabled/  
OU  
#a2ensite ssl  
~~~

Se você quiser mudar qualquer coisa na configuração básica, faça-o no arquivo /etc/apache2/apache2.conf e se quiser mudar o documento root padrão, edite o arquivo /etc/apache2/sites-available/default; em seguida, reinicie o servidor Apache.

Para reiniciar o servidor Apache, digite o comando:

~~~  
#/etc/init.d/apache2 restart  
~~~

Agora precisamos alterar o endereço da porta no arquivo /etc/apache2/ports.conf. O padrão é escutar na porta 80, mas como estamos instalando o SSL, teremos de mudar para a porta 443:

~~~  
Listen 443  
~~~

Edite o arquivo /etc/apache2/sites-available/ssl (ou qualquer que seja o nome do arquivo de configuração de seu novo site SSL) e altere a porta 80 no nome do site para 443.

Adicione as linhas seguintes no final do arquivo /etc/apache2/apache2.conf:

~~~  
SSLEngine On  
SSLCertificateFile /etc/apache2/ssl/apache.pem  
~~~

Edite o arquivo SSLCertificateFile /etc/apache2/ssl/apache.pem e entre com os locais do arquivo de certificado e do arquivo com a chave. Um exemplo:

~~~  
SSLCertificateFile /etc/apache2/ssl/online.test.net.crt  
SSLCertificateKeyFile /etc/apache2/ssl/online.test.net.key  
~~~

Agora, edite o arquivo /etc/apache2/apache2.conf para configurar ServerSignature para 'off' (desabilitado):

~~~  
ServerSignature Off  
ServerTokens ProductOnly  
~~~

Se você quiser permitir os diferentes tipos de arquivos de índice, confirme que existe a seguinte linha no arquivo /etc/apache2/apache2.conf:

~~~  
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.shtml  
~~~

Reinicie o Apache:

~~~  
/etc/init.d/apache2 restart  
~~~

Agora você já deve ter um servidor para testes. Se desejar conectá-lo com a Internet, **`NÃO O FAÇA!... use outro PC, dedicado a ser apenas e tão somente seu servidor Web!`** 

Fontes::

 [http://www.mysql-apache-php.com](http://www.mysql-apache-php.com/) 

 [http://httpd.apache.org/docs/1.3/misc/security_tips.html](http://httpd.apache.org/docs/1.3/misc/security_tips.html) 

 [http://www.debianhelp.co.uk/webserver.htm](http://www.debianhelp.co.uk/webserver.htm) 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
