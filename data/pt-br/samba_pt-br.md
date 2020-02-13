<div id="main-page"></div>
<div class="divider" id="configure"></div>
## Como configurar o siduction para usar SAMBA (Windows) - Diretórios compartilhados a partir de máquinas eemotas

Todos os comandos devem ser digitados como  **root**  (em um terminal). Use o Konqueror (como usuário normal) para a URL.

`server = nome do servidor ou IP da Máquina Windows  
`share = nome do diretório compartilhado` `

No KDE - coloque esta URL no Konqueror: `smb://server`  ou a URL completa: `smb://server/share` 

Pelo terminal, você pode ver o que está sendo compartilhado (share) no servidor com:

~~~  
smbclient -L server  
~~~

Para montar o que será compartilhado em um diretório (com acesso total para TODOS os usuários), lembre-se: o ponto de montagem tem de existir. Se não existir, você primeiro precisa criar um diretório como este (o nome é arbitrário):

~~~  
mkdir -p /mnt/server_share  
~~~

Agora, monte; ou com o sistema de arquivos remoto VFAT... :

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777 //server/share /mnt/server_share  
~~~

...ou com o sistema de arquivos remoto NTFS:

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777,lfs //server/share /mnt/server_share  
~~~

Para terminar a conexão, use:

~~~  
umount /mnt/server_share  
~~~

Se você quiser colocar uma entrada no arquivo  */etc/fstab*  para tornar a montagem mais fácil, insira nele a seguinte linha:

~~~  
//server/share /mnt/server_share cifs defaults,username=your_username,password=**********,file_mode=0777,dir_mode=0777 0 0  
~~~

<div class="divider" id="setup"></div>
## Como configurar o siduction.orgo Servidor Samba

Como o Samba não está no LiveCD do siduction, abra o terminal e faça o seguinte para acessá-lo:

~~~  
sux  
apt-get update  
apt-get install samba samba-tools smbclient smbfs samba-common-bin  
~~~

#### Instalação no HD:

##### Example 1:

Após a instalação, é necessário ajustar as configurações. Damos um exemplo aqui. Se você quiser se aprofundar no uso desse aplicativo e em como configurar o Linux como Servidor Samba,  [recomendamos a leitura da Documentação sobre o Samba](http://us5.samba.org/samba/) .

Para ajustar a configuração do Samba, faça o seguinte:

Abra o arquivo `/etc/samba/smb.conf`  em um editor (como o kedit ou kwrite ou, ainda, kate) e acrescente:

~~~  
# Mudanças Globais - A proposta é que tudo seja o mais  
#simples possível - nada de senhas, como no Windows 9x  
[global]  
security = share  
workgroup = WORKGROUP  
# Compartilhe sem permissão de escrita - importante, caso existam arquivos NTFS a compartilhar!  
[WINDOWS]  
comment = Windows Partition  
browseable = yes  
writable = no  
path = /media/sda1 # <-- ajuste de acordo com sua partição  
public = yes  
# Compartilhando uma partição com permissão de escrita - a partição tem de ser montada  
# como writable ('onde se pode escrever'), o que faz sentido com, p. ex., FAT32.  
[DATA]  
comment = Data Partition (first extended Partition)  
browseable = yes  
writable = yes  
path = /media/sda5  
public = yes  
~~~

Restart the samba server

~~~  
/etc/init.d/samba restart  
~~~

#### Example 2:

~~~  
groupadd smbuser  
useradd -g smbuser <the-user-you-want>  
smbpasswd -a <the-user-you-want>  
smbpasswd -e <the-user-you-want>  
~~~

Next edit `/etc/samba/smb.conf`  to give it share permissions, (be careful with what folders you enable), for example:

~~~  
[homes]  
comment = Home Directories  
browseable = yes.  
writeable = yes  
[media, be careful!]  
path = /media  
browseable = yes  
read only = no  
#read only = yes  
guest ok = no  
writeable = yes  
[video]  
path = /var/lib/video  
browseable = yes  
#read only = no  
read only = yes  
guest ok = no  
#any other folder you want to share with windows/linux/mac  
#path = path = /media/xxxx/xxxx  
#browseable = yes  
#read only = no  
#read only = yes  
#guest ok = no  
~~~

Restart the samba server

~~~  
/etc/init.d/samba restart  
~~~

## Confirmando o que está sendo compartilhado

Para configurar os compartilhamentos sem atentar muito com segurança, digite os seguintes comandos (isto é, configuração LAN):

Confirme que as permissões das pastas e o que elas contêm são, no mínimo: -rwxr-xr-x:

~~~  
ls -la caminhoDo/diretórioCompartilhado/*  
~~~

Se não, digite:

~~~  
chmod -R 755 caminhoDo/diretórioCompartilhado  
~~~

Se quiser que se possa escrever nelas:

~~~  
chmod -R 777 diretórioCompartilhado  
~~~

Uma maneira de confirmar que seu compartilhamento está funcionando (não se esqueça de iniciar o servidor):

~~~  
smbclient -L localhost  
~~~

Você deverá ver qualquer coisa assim:

~~~  
smbclient -L localhost  
Password:  
Domain=[HOME] OS=[Unix] Server=[Samba 3.0.26a]  
Sharename Type Comment  
--------- ---- -------  
IPC$ IPC IPC Service (3.0.26a)  
MaShare Disk comment  
print$ Disk Printer Drivers  
Domain=[MSHOME] OS=[Unix] Server=[Samba 3.0.26a]  
~~~

Se você não colocou senha, basta pressionar ENTER.

Não se esqueça de salvar. Agora você pode iniciar/fechar o Samba com:

~~~  
/etc/init.d/samba start  
~~~

e

~~~  
/etc/init.d/samba stop  
~~~

Você pode também iniciar/fechar o Samba automaticamente ao inicializar o siduction. Basta executar:

~~~  
update-rc.d samba defaults  
~~~

Agora o Samba é iniciado durante o boot e finalizado quando você desligar sua máquina.

 [Mais informações sobre o Samba aqui](http://wiki.linuxquestions.org/wiki/Samba) .

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
