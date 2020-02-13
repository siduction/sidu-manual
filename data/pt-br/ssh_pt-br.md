<div id="main-page"></div>
<div class="divider" id="ssh"></div>
## SSH

Em computação, Secure Shell ou SSH é um pacote de padrões e um protocolo de rede que permitem estabelecer um canal seguro entre um computador local e um remoto. Usa criptografia de chaves públicas para autenticar a máquina remota e (opcionalmente) permitir a esta autenticar o usuário. O SSH proporciona confidencialidade e integridade dos dados trocados entre os dois computadores ao usar encriptação e códigos de autenticação de mensagens (MAC - Message Authentication Code, em Inglês). Normalmente, o SSH é usado para conectar-se a uma máquina remota e executar comandos, mas são possíveis também o tunneling, forwarding de portas TCP arbitrárias e conexões X11; Pode-se ainda transferir arquivos usando os protocolos SFTP ou SCP. Quanto à porta TCP, o padrão de um servidor SSH é ouvir na porta 22.  [Ver wikipedia](http://pt.wikipedia.org/wiki/Secure_Shell) 

<div class="divider" id="ssh-s"></div>
## Como habilitar bons protocolos de segurança para o SSH

Permitir o login como root, via ssh, não é seguro. Não é desejável, também, dar aos usuários 10 minutos que sejam para que eles façam um rápido ataque-dicionário às senhas de nosso login. Portanto, depende de você limitar o tempo e as tentativas!

Para deixar seu ssh mais seguro, torne-se root no terminal e abra o arquivo abaixo em seu editor de textos predileto:

~~~  
/etc/ssh/sshd_config  
~~~

Então, faça as alterações necessárias nos items que podem causar problemas.

###### Esses items problemáticos são os seguintes:

`Port <porta desejada>:`  Especifique a porta correta que você está adiantando ('forwarding') de seu roteador. 'Port forwarding' também precisa ser configurado em seu roteador. Se você não souber como fazer isso, então provavelmente você não está usando ssh. O padrão no Debian é a porta 22, porém o melhor é usar uma porta fora do campo normal de escaneamento. Digamos que você decida usar a porta 5874, então esse item fica assim:

~~~  
Port 5874  
~~~

`ListenAddress <IP da máquina ou interface de rede>:`  É preciso que a máquina tenha um endereço IP estático na rede, a menos que você esteja usando um servidor DNS localmente (mas se você está fazendo algo tão complicado e necessita destas instruções, provavelmente você está cometendo um enorme engano). Portanto, vamos dizer que fique assim:

~~~  
ListenAddress 192.168.2.134  
~~~

Bem, o Protocol 2 já um padrão no Debian, mas confira só para ter certeza:

`LoginGraceTime <tantos segundos para permitir o login>:`  O padrão é absurdo: 600 segundos. Não são necessários 10 minutos para você digitar seu nome de usuário e senha, portanto vamos mudar:

~~~  
LoginGraceTime 45  
~~~

Agora você tem 45 segundos para logar-se e os hackers não têm 600 segundos para tentar descobrir sua senha.

`PermitRootLogin <permitir login como root=yes>:`  Não se compreende porque o padrão no Debian é PermitRootLogin 'yes', portanto vamos passar para 'não':

~~~  
PermitRootLogin no  
~~~

~~~  
StrictModes yes  
~~~

`MaxAuthTries <xxx>:`  Número de tentativas para logar-se; o ideal é 3 ou 4, não mais.

~~~  
MaxAuthTries 2  
~~~

Pode ser necessário adicionar alguns dos items seguintes, se eles não estiverem presentes:

~~~  
AllowUsers <nomes de usuários autorizados a acessar via ssh>  
~~~

`AllowUsers <xxx>:`  dar acesso ssh somente a usuários sem permissões; use 'adduser' para adicionar usuários, depois coloque seus nomes aqui:

~~~  
AllowUsers qualquer_que_seja_seu_nome_de_usuário  
~~~

`PermitEmptyPasswords <xxx>:`  dar a esse usuário uma senha tão longa, que será impossível adivinhar, nem em um milhão de anos, que ele é o único usuário com permissão de entrar no ssh. Uma vez dentro, você pode usar 'su' para tornar-se root:

~~~  
PermitEmptyPasswords no  
~~~

`PasswordAuthentication <xxx>:`  É óbvio que, se o usuário ao logar-se tiver de digitar uma senha (e não uma chave encriptada), essa senha terá de ser autenticada; portanto temos de colocar um 'yes' aqui:

~~~  
PasswordAuthentication yes [a menos que se esteja usando chaves encriptadas]  
~~~

Finalmente:

~~~  
/etc/init.d/ssh restart  
~~~

Agora você tem um ssh mais seguro que antes, ainda que não totalmente seguro. Até melhor, pois incluimos a criação de usuários 'ssh somente' com adduser.

`Observação:`  Se você receber uma mensagem de erro e o ssh se recusar a conectar, procure uma pasta escondida em sua $HOME com o nome de `.ssh` , apague o arquivod`known_hosts`  e tente de novo. Este erro é mais comum com IPs dinâmicos (DHCP).

<div class="divider" id="ssh-x"></div>
## Como usar aplicações do X via rede através do SSH

O ssh -X permite que você se logue a um computador remoto e tenha sua interface gráfica mostrada em sua máquina local. Faça o seguinte, como $usuário (note que o 'X' é maiúsculo):

~~~  
$ ssh -X usuário@xxx.xxx.xxx.xxx (ou IP)  
~~~

Digite a senha do usuário na máquina remota e rode a aplicação X na shell:

~~~  
$ iceweasel OU oocalc OU oowriter OU kspread  
~~~

Algumas conexões realmente muito lentas podem ser beneficiadas se tiverem um nível de compressão para ajudar a velocidade de transferências. Para isso, adicione uma opção extra (mas atenção: em conexões rápidas, o efeito é o inverso):

~~~  
$ ssh -C -X username@xxx.xxx.xxx.xxx (or IP)  
~~~

Leia:

~~~  
$man ssh  
~~~

`Observação:`  Se você receber uma mensagem de erro e o ssh se recusar a conectar, procure uma pasta escondida em sua $HOME com o nome de `.ssh` , apague o arquivod`known_hosts`  e tente de novo. Este erro é mais comum com IPs dinâmicos (DHCP).

<div class="divider" id="ssh-scp"></div>
## Transferir ficheiros e diretórios usando scp

scp utiliza a linha de commando, (terminal/cli), para copiar ficheiros entrs hosts numa rede utilizando os mecanismos de autentificação e a segurança do ssh para efectuar a transferencia dos ficheiros.

Partindo da hipótese de que você tem acesso por SSh a um server, então scp permite-lhe copiar (transferir) ficheiros desse (ou para esse) server para destinos nos quais lhe é permitido criar ficheiros. Isto inclui por exemplo transferir ficheiros de um PC ou um server da sua própria LAN para um dispositivo USB conetado a sua máquina local.

Se desejar a cópia pode ser recursiva permitindo até copiar partições inteiras usando a opção `scp -r` . Note bem que "sc -r" segue os links simbólicos que encontra ao descer um hierarquia de diretórios.

### Exemplos:

`Exemplo 1:`  Copiar uma partição:

~~~  
scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/ /media/diskXpartX/  
~~~

`Exemplo 2:`  Copiar um diretório - neste caso suposto encontar-se no $HOME do utilizador na máquina remota:

~~~  
scp -r <user>@xxx.xxx.x.xxx:~/photos/ /media/diskXpartX/xx  
~~~

`Example 3:`  Copiar um ficheiro - neste caso suposto encontar-se no $HOME do utilizador na máquina remota:

~~~  
scp <user>@xxx.xxx.x.xxx:~/filename.txt /media/diskXpartX/xx  
~~~

`Example 4:`  Copiar um ficheiro:

~~~  
scp <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt /media/diskXpartX/xx  
~~~

`Example 5:`  Copiar ficheiros para o seu actual diretório utilize o '**` **.** `** ' (ponto - dot) :

~~~  
scp -r <user>@xxx.xxx.x.xxx:/media/disk1part6/filename.txt.** `**   
~~~

`Example 6:`  Para copiar ficheiros do para o sistema remoto, (pode utilzar `scp -r`  se deseja copiar recursivamente uma partição ou um diretório:

~~~  
scp /media/disk1part6/filename.txt <user>@xxx.xxx.x.xxx:/media/diskXpartX/xx  
~~~

Dẽ uma olhadela no conteúdo do:

~~~  
man scp  
~~~

<div class="divider" id="ssh-w"></div>
## SSH com X-Forwarding a partir de um PC Windows:

* Baixe e queime o  [Cygwin XLiveCD](http://xlivecd.indiana.edu/)   
* Dentro do Windows, coloque o CD na bandeja do CD-ROM e aguarde a auto-execução.  
Clique "Continue" até que surja uma janela de terminal. Então, digite:

~~~  
ssh -X usuário@xxx.xxx.xxx.xxx  
~~~

Observação: xxx.xxx.xxx.xxx é o endereço IP do computador remoto rodando Linux ou sua URL (por exemplo, uma conta no dyndns.org) e 'usuário' é uma conta de usuário existente na máquina remota, naturalmente. Depois de conectar-se com sucesso, rode "kmail", por exemplo, e cheque seus emails!

Importante: assegure-se de que o arquivo 'hosts.allow' tenha uma entrada que permita acessos de PCs de outras redes. Se você estiver atrás de um firewall NAT ou um roteador, confirme que a porta 22 está aberta para sua máquina Linux.

<div class="divider" id="ssh-f"></div>
## SSH com dolphin

Tanto o dolphin quanto o Krusader são capazes de acessar dados remotos, usando os protocolos `sftp://`  e ssh.

Como funciona:  
1) Abra o dolphin  
2) Digite na barra de endereços: `sftp://nome_do_usuário@ssh-server.com` 

Exemplo 1: 

~~~  
sftp://siduction1@servidor remoto_ou_ip  
(Nota: uma janela vai pedir sua senha ssh; coloque-a e clique OK)  
~~~

Exemplo 2: 

~~~  
sftp://nome_do_usuário:senha@servidor remoto_ou_ip  
(Aqui, NENHUMA  janela pedirá sua senha; você estará conectado diretamente.)  
~~~

Para um ambiente LAN:

~~~  
sftp://nome_do_usuário@10.x.x.x ou 198.x.x.x.x  
(Nota: uma janela vai pedir sua senha ssh; coloque-a e clique OK)  
~~~

A conexão SSH, com uma janela do dolphin, é iniciada agora. Com essa janela, você pode trabalhar com os arquivos (copiar/ver) que estão no servidor SSH, exatamente como se eles estivessem em uma pasta em seu computador local.

`NOTA: se você configurou o ssh para usar outra porta que não a padrão, que é a 22, você precisa especificar qual porta o sftp vai usar:`

~~~  
sftp://usuário@ip:port  
~~~

'user@ip:port' é a sintaxe padrão de muitos programas, como sftp e smb.

<div class="divider" id="ssh-fs"></div>
## SSHFS - como montar remotamente

SSFS é um método fácil, rápido e seguro que usa FUSE para montar um sistema de arquivos remoto. O único requisito do lado do servidor é um daemon ssh sendo executado.

Do lado do cliente, provavelmente você terá de instalar o sshfs: `instalar o fuse e grupos não é mais necessário desde o siduction 11.1, pois eles passaram a ser adicionados na instalação:` 

No cliente, você provavelmente terá de instalar o sshfs: 

~~~  
apt-get update && apt-get install sshfs  
~~~

`Agora, saia e logue-se novamente.`

Montar um sistema de arquivos remoto é muito fácil:

~~~  
sshfs usuário@hospedeiro_remoto:diretório ponto_de_montagem_local  
~~~

onde `usuário`  é a conta de usuário no hospedeiro remoto:

Se nenhum diretório for fornecido, será montado o diretório /home do usuário remoto.`Atenção: os dois pontos **` **:**`**  são essenciais, ainda que nenhum diretório seja dado!` 

Depois de montado, o diretório remoto comporta-se como qualquer outro sistema de arquivos: você pode navegar entre os arquivos, editá-los, rodar scripts etc, da mesma forma que você faz em um sistema local.

Se quiser desmontar o hospedeiro remoto, use o seguinte comando:

~~~  
fusermount -u ponto_de_montagem_local  
~~~

Se você usa sshfs frequentemente, uma boa idéia é adicionar esta entrada no fstab:

~~~  
sshfs#username@remote_hostname://remote_directory /local_mount_point fuse user,allow_other,uid=1000,gid=1000,noauto,fsname=sshfs#username@remote_hostname://remote_directory 0 0  
~~~

Em seguida deative `user_allow_other`  no ficheiro `/etc/fuse.conf` :

~~~  
# Allow non-root users to specify the 'allow_other' or 'allow_root'  
# mount options.  
#  
user_allow_other  
~~~

Assim, fica permitido a todo usuário que faça parte do grupo 'fuse' montar o sistema de arquivos, usando o já conhecido comando:

~~~  
mount /caminho/para/ponto/de/montagem  
~~~

Naturalmente, você poderá também usar o comando para desmontar:

~~~  
umount /caminho/para/ponto/de/montagem  
~~~

Para conferir se você faz parte do grupo ou não, use o seguinte comando:

~~~  
cat /etc/group | grep fuse  
~~~

Você deverá ver mais ou menos isto:

~~~  
fuse:x:117: <nome_do_usuário>  
~~~

Se seu nome de usuário não estiver relacionado, use o comando 'adduser' como root:

~~~  
adduser <nome_do_usuário> fuse  
~~~

Agora seu nome de usuário deve aparecer na lista e você poderá executar o seguinte comando:

`Observação: o "id" não será mostrado no grupo "fuse" enquanto você não sair e logar-se de novo.`

~~~  
mount ponto_de_montagem_local  
~~~

e

~~~  
umount ponto_de_montagem_local  
~~~

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
