<div id="main-page"></div>
<div class="divider" id="nbd1"></div>
## Como Iniciar o siduction Através de uma Rede (NBD - Network Block Device)

**`Advertência: O dnsmasq inclui um servidor dhcp que pode entrar em conflito com outro servidor dhcp existente em sua rede (pode haver um em seu roteador, por exemplo).`**  `A opção mais segura é usar apenas um servidor dhcp em qualquer rede. Isso significa que você deve desabilitar quaisquer outros servidores dhcp na mesma rede! As opções proxy do dnsmasq abordadas logo abaixo deveriam ser capazes de coexistir pacificamente com outros servidores na mesma rede; todavia não tente fazer isso, a menos que você seja o administrador da rede e esteja preparado para enfrentar qualquer consequência imprevista que saltar à sua frente.` 

#### O básico

Dar o boot por rede exige que você tenha uma máquina capaz de fazer isso, isto é, que possa ser conectada via uma rede que você opere a uma máquina que você possa configurar para oferecer serviços de boot por rede.

Não é recomendável que você faça isso na rede de seu local de trabalho ou em uma que você não controle, a não ser que você opere a rede ou tenha permissão e instruções daqueles que a administrem. Se você estiver copilotando uma rede grande, você pode investigar todas as opções do dnsmasq, como limitação das interfaces que ele escuta ou dos clientes a quem ele vai responder, com o objetivo de restringir o impacto de suas intervenções na rede.

#### Pré-requisitos

Uma ISO do siduction 2009-04 (ou mais recente) para usar como servidor de boot. As instruções são basicamente as mesmas de qualquer máquina com siduction ou Debian sid atualizados e oferecem todas as pistas necessárias para usar em outros sistemas. O Linux é obrigatório para dispositivos NBD.

O dnsmasq providenciará tudo que for preciso para as fases iniciais da inicialização; não deverá ser difícil traduzir o conhecimento necessário para outro software.

###### Instalação

~~~  
apt-get install nbd-server dnsmasq  
~~~

### Configuração do servidor nbd

 Vamos presumir que a ISO esteja em `/dev/scd0` , (deve ser este o caso se você iniciou pelo CD; se não for assim, substitua pelo arquivo ou dispositivo apropriado); daí, você pode editar um arquivo de configuração do servidor NBD, chamado `nbd-siduction.conf` , with a section called siduction-iso to export the cd by running the following:

~~~  
echo '[generic]' > nbd-siduction.conf  
nbd-server 0.0.0.0:10809 /dev/scd0 -o siduction-iso >> nbd-siduction.conf  
~~~

O cabeçalho ('header') 'generic' é sempre exigido. Atenção: se você quiser configurar o servidor NBD para funcionar automaticamente em um sistema real, o arquivo a editar deverá ser, provavelmente, o /etc/nbd-server.conf. Existem inúmeras outras opções do servidor NBD, além daquelas mostradas aqui. Veja: `man nbd-server.` 

Para realmente iniciar o servidor agora, como usuário normal e sem se preocupar em configurar ou copiar o arquivo para `/etc/nbd-server.conf` , simplesmente rode:

~~~  
nbd-server -C nbd-siduction.conf  
~~~

O alvo do servidor NBD não precisa necessariamente estar em uma ISO ou no CD/DVD/USB; só precisa de conter uma imagem dos sistema de arquivos apropriado.

#### dnsmasq

O exemplo a seguir assume que você está rodando uma rede simples, onde sua máquina possui uma conexão ethernet configurada por dhcp de outra máquina e que os clientes podem usar para configurar suas interfaces também por dhcp.

Os opções mais relevantes do dnsmasq são referentes à configuração de um caminho para o servidor tftp e de um arquivo para que ele dê o boot dali.

Crie um diretório `tftp`  para o boot em `/home`  (se preferir, você pode criá-lo em outro lugar). Assim, o caminho será `/home/tftp` .

A seguir, crie um arquivo com o nome de `pxe-siduction.conf`  e cole as seguintes linhas nele:

~~~  
dhcp-range=0.0.0.0,proxy  
pxe-service=x86PC, &quot;boot linux&quot;, pxelinux  
enable-tftp  
tftp-root=/home/tftp  
tftp-secure  
~~~

Sempre que usar o proxy dhcp, você precisa fornecer um menu pxe com pxelinux como única entrada, o que permite que ele seja iniciado automaticamente. É isto que faz o solitário item pxe-service acima.

Como root, mova o recém-criado arquivo `pxe-siduction.conf`  para `/etc/dnsmasq.d/` :

~~~  
sux  
mv pxe-siduction.conf /etc/dnsmasq.d/  
~~~

Nota: Para uma rede (p. ex. 192.168.0.*) sem nenhum outro servidor dhcp, você pode trocar as duas primeiras linhas para:

~~~  
dhcp-range=192.168.0.100,192.168.0.199,1h  
dhcp-boot=pxelinux.0  
~~~

Isso distribui endereços IP começando por 192.168.0.100 e terminando com 192.168.0.199 em um período de tempo de 01 hora e também especifica que o pxelinux.0 deve ser rodado como parte de uma requisição do dhcp (quando você usa proxy, você se vale do menu pxe com uma única entrada - pxelinux - que passará a iniciá-lo automaticamente, como já vimos). No entanto, isso provavelmente não configurará sua rede do jeito que você deseja, a menos que seu servidor dnsmasq seja também seu servidor dns e gateway para os clientes.

Para habilitar seu novo arquivo, você vai precisar de descomentar a linha `conf-dir=/etc/dnsmasq.d`  no final do arquivo `/etc/dnsmasq.conf`  e reiniciar o dnsmasq.

O dnsmasq possui uma série de opções e pode agir tanto como servidor dhcp quanto como servidor dns, pxe e tftp. O que vimos acima é apenas um esboço mínimo das peças necessárias para usar o pxelinux.

#### tftp

O tftp é o equivalente, na rede, ao diretório de boot. Voltemos ao exemplo do diretório `/home/tftp` : você precisa preenchê-lo. Se seu CD-ROM estiver montado em `/fll/scd0` :

~~~  
cp /fll/scd0/boot/isolinux/* /home/tftp  
mkdir /home/tftp/pxelinux.cfg  
mv /home/tftp/isolinux.cfg /home/tftp/pxelinux.cfg/default  
mkdir /home/tftp/boot  
cp /fll/scd0/boot/vmlin /fll/scd0/boot/initr /fll/scd0/boot/memtest /home/tftp/boot/  
cp /usr/lib/syslinux/pxelinux.0 /home/tftp/  
# required for the tftp-secure option to dnsmasq  
chown -R dnsmasq.dnsmasq /home/tftp/*  
~~~

Agora você pode editar as opções de inicialização para satisfazer suas necessidades em `/home/tftp` , nos arquivos `pxelinux.cfg/default`  e `gfxboot.cfg` .

In particular it is suggested that under the `[install]`  section you set the `install=` to `install=nbd` , `install.nbd.server`  to the server's IP on the network and `install.nbd.port`  to the name of the nbd export section, for example. siduction-iso (as nbd exports are named now rather then simply using port numbers).

Alternativamente, você pode desabilitar a tecla [F3] no menu completamente e editar as linhas de comando do kernel para usar algo deste tipo:

~~~  
fromhd=/dev/nbd0 root=/dev/nbd0 nbdroot=192.168.1.23,siduction-iso nonetwork  
~~~

###### Código de boot toram

Se você adicionar toram às opções de boot, máquinas com RAM suficiente liberarão o servidor assim que copiarem o arquivo, enquanto que máquinas sem RAM suficiente darão o boot normalmente. Para toram, é exigido 01GB de RAM (o ideal são 02GB ou mais).

#### Boot por rede

Certifique-se de que as BIOS dos PCs clientes estão configuradas para usar `Boot from Network` . 

Desde que sua BIOS seja capaz de dar o boot por rede ('Boot from Network'), que sua máquina esteja conectada a uma rede com seu servidor e que o kernel do siduction e a initrd.img deem suporte à placa de rede, você vai conseguir iniciar o siduction pela rede.

Algumas placas necessitam de drivers não livres, o que vai exigir que a imagem initrd seja remontada com a inclusão do firmware correspondente.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
