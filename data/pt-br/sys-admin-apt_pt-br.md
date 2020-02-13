<div id="main-page"></div>
<div class="divider" id="apt-cook"></div>
## Pequeno Guia do APT

### O que significa APT?

APT é a abreviatura de 'Advanced Packaging Tool', isto é, Ferramenta Avançada de Empacotamento. Trata-se de uma coleção de programas e scripts que ajudam o administrador do sistema (no seu caso, o root) na instalação e gerenciamento de arquivos .deb. Ele também ajuda o próprio sistema a saber o que está instalado.

<div class="divider" id="sources-list"></div>
## A sources list

O "APT" precisa de um arquivo de configuração que contenha os locais onde se encontram os pacotes instaláveis e atualizáveis. Este arquivo normalmente é chamado de `sources.list` .

 As fontes para a sources.list do siduction estão na pasta:  
`/etc/apt/sources.list.d/` 

Dentro dela existem dois arquivos:  
`/etc/apt/sources.list.d/debian.list`  e  
`/etc/apt/sources.list.d/siduction.list` 

A vantagem é que a troca de espelhos é automatizada, tornando o processo mais fácil. Além disso, substituir entradas fica mais seguro.

Você pode adicionar seus próprios arquivos `/etc/apt/sources.list.d/*.list` sem problemas.

### Todas as ISOs do siduction usam a seguinte 'sources.list' por padrão:

~~~  
#siduction  
# Free University Berlin/ spline (Student Project LInux NEtwork), Germany  
deb ftp://ftp.spline.de/pub/siduction/debian/ sid main fix.main  
#deb-src ftp://ftp.spline.de/pub/siduction/debian/ sid main fix.main  
~~~

Fontes complementares, com pacotes não-livres, podem ser encontradas em nossa sempre atualizada  [siduction.list](http://siduction.org/files/misc/sources.list.d/siduction.list)  e  [debian.list](http://siduction.org/files/misc/sources.list.d/debian.list) .:

~~~  
#Debian  
# Unstable  
deb http://ftp.us.debian.org/debian/ unstable main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ unstable main contrib non-free  
# Testing  
#deb http://ftp.us.debian.org/debian/ testing main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ testing main contrib non-free  
# Experimental  
#deb http://ftp.us.debian.org/debian/ experimental main contrib non-free  
#deb-src http://ftp.us.debian.org/debian/ experimental main contrib non-free  
~~~

OBSERVAÇÃO: Neste exemplo, 'ftp.us' significa que os repositórios usados são dos Estados Unidos. Você pode editar o arquivo, como root, e usar os espelhos brasileiros: simplesmente mude o país, isto é, 'ftp:us' para 'ftp.br'. Com isso, preserva-se a largura de banda e aumenta-se a velocidade.

 [Listagem dos Servidores Debian e status atual dos espelhos ('mirrors')](http://www.debian.org/mirrors/) .

Para receber informações sobre atualizações dos pacotes, o APT usa um banco de dados. Este banco contém não só o pacote em si, mas também outros pacotes necessários para que ele funcione (as chamadas dependências). O programa apt-get usa o banco de dados para instalar os pacotes que você pediu e também todas as dependências necessárias, o que garante que tudo irá funcionar no final do processo. A atualização do banco é feita pelo comando 'apt-get update':

~~~  
# apt-get update  
(que retorna o seguinte:)  
Get:1 http://siduction.org sid Release.gpg [189B]  
Get:2 http://siduction.org sid Release.gpg [189B]  
Get:3 http://siduction.org sid Release.gpg [189B]  
Get:4 http://ftp.de.debian.org unstable Release.gpg [189B]  
Get:5 http://siduction.org sid Release [34.1kB]  
Get:6 http://ftp.us.debian.org unstable Release [79.6kB]  
~~~

<div class="divider" id="apt-install"></div>
## Como instalar um novo pacote

**`Atualização ou instalação de pacotes sem parar X pode causar problemas. Qualquer método de instalação de pacotes no X tem esse problema.`** 

**`Enquanto qualquer pacote que deseja instalar não atualizar pacotes adicionais, então a instalação pode ser feita sem para X. No entanto, se instalação do pacote necessitar de actualizar outros que já estão instalados então você precisa de ser cuidadoso e, a menos que você esteja certo que os pacotes a actualizar não estão a ser usados, você deve parar de X antes de instalar o pacote.`** 

**`Se você estiver em dúvida o melhor é deixar X antes de efetuar a instalação e seguir as instrções dadas para o caso do dist-upgrade  [Como atualizar todo o sistema - dist-upgrade - os passos](sys-admin-apt-pt-br.htm#du-st)`**  .

Presumindo-se que o banco de dados do APT está atualizado e que o nome do pacote é conhecido, então o seguinte comando instalará um pacote chamado 'qemu' e todas suas dependências: (daqui a pouco mostraremos como procurar e encontrar pacotes)

~~~  
# apt-get install qemu  
Reading package lists... Done --> (Lendo lista de pacotes...Pronto)  
Building dependency tree... Done --> (Construindo árvore de dependências...Pronto)  
The following extra packages will be installed: --> (Os seguintes pacotes extras serão instalados:)  
bochsbios openhackware proll vgabios  
Recommended packages: --> (Pacotes recomendados:)  
debootstrap vde  
The following NEW packages will be installed: --> (Os seguintes pacotes NOVOS serão instalados:)  
bochsbios openhackware proll qemu vgabios  
0 upgraded, 5 newly installed, 0 to remove and 20 not upgraded. --> (0 atualizados, 5 novos instalados, 0 a remover e 20 não atualizados.)  
Need to get 4152kB of archives. --> (Será necessário baixar 4152kB em arquivos.)  
After unpacking 11.9MB of additional disk space will be used. --> (Após o desempacotamento, 11.98MB de espaço em disco serão usados.)  
Do you want to continue [Y/n]? n --> (Deseja continuar [S/n]?)  
~~~

<div class="divider" id="apt-delete"></div>
## Como apagar um pacote

Da mesma forma, não é nenhuma surpresa que o comando a seguir desinstale um pacote (mas não remove suas dependências): 

~~~  
apt-get remove gaim  
~~~

~~~  
apt-get remove gaim  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED: --> (Os seguintes pacotes serão REMOVIDOS:)  
gaim gaim-irchelper  
0 upgraded, 0 newly installed, 2 to remove and 310 not upgraded.  
Need to get 0B of archives.  
After unpacking 4743kB disk space will be freed. --> (Após o desempacotamento, 4743kb serão liberados no HD)  
Do you want to continue [Y/n]?  
(Reading database ... 174409 files and directories currently installed.) --> (Lendo o banco de dados... 174409 arquivos e diretórios instalados atualmente)  
Removing gaim-irchelper ... --> (Removendo gaim-irchelper ...)  
Removing gaim ... --> (Removendo gaim ...)  
~~~

No caso acima, os arquivos de configuração do pacote 'gaim' não foram apagados do sistema. Eles podem ser úteis se você reinstalar o pacote, pois todas as configurações existentes serão assumidas.

Se você quiser que esses arquivos de configuração sejam apagados também, use o seguinte comando:

~~~  
apt-get --purge remove gaim  
~~~

~~~  
Reading package lists... Done  
Building dependency tree... Done  
The following packages will be REMOVED:  
gaim  
0 upgraded, 0 newly installed, 1 to remove and 309 not upgraded.  
Need to get 0B of archives.  
After unpacking 4678kB disk space will be freed.  
Do you want to continue [Y/n]? Y  
(Reading database ... 174405 files and directories currently installed.)  
Removing gaim ...  
Purging configuration files for gaim ... --> (Purificando arquivos de configuração do gaim ...)  
~~~

Note o `*`  após o nome do pacote nas mensagens de saída do apt. Este asterisco significa que os arquivos de configuração também serão removidos.

<div class="divider" id="apt-downgrade"></div>
## Como rebaixar e/ou congelar um pacote

Às vezes, pode ser necessário reverter um pacote à sua versão anterior (downgrade) ou colocá-lo em espera (hold), devido a um bug sério na versão mais recente que você acabou de instalar. 

### Colocar um pacote no modo de espera:

~~~  
echo pacote hold|dpkg --set-selections  
~~~

### Tirar um pacote do modo de espera:

~~~  
echo pacote install|dpkg --set-selections  
~~~

### Listar os pacotes em modo de espera:

~~~  
dpkg --get-selections | grep hold  
~~~

### Rebaixar um pacote:

 **`Debian não suporta o "downgrade". Pode ser possível em alguns casos simples, mas pode falhar espetacularmente para outros pacotes. Por favor consulte`**  [Emergency downgrading](http://www.debian.org/doc/manuals/reference/ch02.en.html#_emergency_downgrading) .

<!-- Despite the fact that it is not supportable, downgrading has been known to work for simple packages. The steps for downgrading a simple package using `kmahjongg`  as an example are:

 -->
1. comment unstable sources in `/etc/apt/sources.list.d/debian.list`  with a `#`   
2. <!-- Add testing sources in `/etc/apt/sources.list.d/debian.list` , for example: -->  
   Mesmo não sendo suportado, vamos dar aqui um exemplo simples utilizando para isso o pacote `kmahjongg` :
  
   <ol>  
   <!-- <li>comment unstable sources in `/etc/apt/sources.list.d/debian.list`  with a `#` -->  
3. Adicione fontes para "testing" à sua lista de debian `/etc/apt/sources.list.d/debian.list` , por exemplo:  
   ~~~    
   deb http://ftp.nl.debian.org/debian/ testing main contrib non-free    
   ~~~
  
4. ~~~    
   apt-get update    
   ~~~
  
5. ~~~    
   apt-get install kmahjongg/testing    
   ~~~
  
6. <!-- Put the newly installed package on hold with: -->  
   <li>Coloque o pacote "on hold" utilizando:  
   ~~~    
   echo kmahjongg hold|dpkg --set-selections    
   ~~~
  
7. comment &lt;#&gt;the testing sources in /etc/apt/sources.list.d/debian.list with and uncomment the unstable sources so that you get back to using unstable sources, then:  
8. desative a linha &lt;#&gt;com as fontes para o "testing" no ficheiro /etc/apt/sources.list.d/debian.list e actualize as fontes novamente:  
9. ~~~    
   apt-get update    
   ~~~
  

Quando quiser instalar a última versão do pacote, faça assim:

~~~  
echo kmahjongg install|dpkg --set-selections  
apt-get update  
apt-get install kmahjongg  
~~~

<div class="divider" id="apt-upgrade"></div>
## Como atualizar um sistema já instalado - dist-upgrade - uma visão geral

Uma atualização de todo o sistema é feita através de um `dist-upgrade` . Sempre verifique os Current Warnings ('Alertas Atuais') no site do  [siduction](http://siduction.org) , e veja se há avisos contra atualizações de algum pacote. Se houver necessidade de `congelar`  um pacote, veja a seção  [Rebaixando e/ou congelando um pacote.](sys-admin-apt-pt-br.htm#apt-downgrade) 

Não é recomendável comandar um 'upgrade' apenas para o 'debian sid'.

##### Frequência de um 'dist-upgrade'

Comande um 'dist-upgrade' pelo menos uma vez por semana, ou a cada duas semanas. Em último caso, uma vez por mês. Um 'dist-upgrade' feito apenas a cada dois ou três meses está no limite da segurança. Em caso de pacotes que não obedeçam aos padrões ou em caso de pacotes que você mesmo tenha compilado, seja mais cuidadoso ao fazer atualizações, porque eles podem quebrar seu sistema devido a incompatibilidades.

Após atualização do banco de dados, pode-se descobrir quais pacotes possuem versões mais novas: (antes de mais nada, é preciso instalar o pacote 'apt-show-versions')

~~~  
apt-show-versions -u  
libpam-runtime/unstable upgradeable from 0.79-1 to 0.79-3  
passwd/unstable upgradeable from 1:4.0.12-5 to 1:4.0.12-6  
teclasat/unstable upgradeable from 0.7m02-1 to 0.7n01-1  
libpam-modules/unstable upgradeable from 0.79-1 to 0.79-3.........  
~~~

A atualização de um único pacote, por exemplo 'gcc-4.0', e todas suas dependências, pode ser feita com:

~~~  
apt-get install gcc-4.0  
Reading package lists... Done  
Building dependency tree... Done  
gcc-4.0 is already the newest version.  
0 upgraded, 0 newly installed, 0 to remove and xxx not upgraded  
~~~

#### Apenas baixar

`Uma ótima e pouco conhecida opção é aquela que permite que se conheça quais pacotes farão parte de um 'dist-upgrade'. Para isso, use a variável -d:`

~~~  
apt-get update && apt-get dist-upgrade -d  
~~~

Essa variável faz com que os pacotes sejam baixados (porém não instalados), a partir do X. Instale-os mais tarde, no init 3, com o 'dist-upgrade'. Isso também lhe dá a oportunidade de verificar se existem alertas contra qualquer pacote, pois você pode continuar ou abortar:

~~~  
apt-get dist-upgrade -d  
Reading package lists... Done  
Building dependency tree  
Reading state information... Done  
Calculating upgrade... Done  
The following NEW packages will be installed:  
elinks-data  
The following packages have been kept back:  
git-core git-gui git-svn gitk icedove libmpich1.0ldbl  
The following packages will be upgraded:  
alsa-base bsdutils ceni configure-ndiswrapper debhelper  
discover1-data elinks file fuse-utils gnucash.........  
35 upgraded, 1 newly installed, 0 to remove and 6 not upgraded.  
Need to get 23.4MB of archives.  
After this operation, 594kB of additional disk space will be used.  
Do you want to continue [Y/n]?Y   
~~~

Respondendo `'Y'` , os pacotes serão baixados para seu computador, sem tocar no sistema instalado.

Quando o 'dist-upgrade -d' terminar, você precisa completar o processo, imediatamente ou mais tarde; para isso, siga as instruções abaixo:

<div class="divider" id="du-st"></div>
### dist-upgrade - os passos

<div class="box block">
**NUNCA NUNCA faça atualizações dos pacotes (upgrades) nem atualizações do sistema (dist-upgrades) dentro do X.<div class="highlight-4"> Sempre cheque os Alertas na página principal do  [siduction](http://siduction.org) . Esses avisos, atualizados diariamente, estão lá por um motivo: a própria natureza do ramo 'instável' do Debian.**

~~~  
Saia do KDE:  
pressione Ctrl+Alt+F1 [para ir para o terminal de modo texto ]  
logue-se como usuário root e digite init 3  
apt-get update  
apt-get dist-upgrade  
apt-get clean  
init 5 && exit  
~~~

**NUNCA FAÇA ATUALIZAÇÕES (DIST-UPGRADE E/OU UPGRADE) com adept, synaptic ou aptitude.**


---

**`Se você não for para o init 3,as coisas vão ficar difíceis!!! Você foi avisado!`**

<div class="divider" id="whyno"></div>
##### Razões para NÃO usar nada além do apt-get para um dist-upgrade

Gerenciadores de pacotes como adept, aptitude, synaptic e kpackage nem sempre dão conta da quantidade enorme de mudanças que acontecem no sid ( mudanças nas dependências, nos nomes, nos scripts de manutenção...). 

Não é culpa dos desenvolvedores daquelas aplicações. Essas ferramentas são fabulosas, excelentes para o ramo 'estável' do Debian, só que não estão aptas para lidar com as necessidades muito especiais do Debian sid.

Use qualquer um deles para procurar pacotes, mas fique com o apt-get na hora de realmente instalar/remover/atualizar o sistema.

Gerenciadores tais como adept, aptitude, synaptic e kpackage são, no mínimo, não-deterministas (para uma seleção de pacotes complexa). Misture isso com um alvo sempre móvel, como é o caso do sid, e (pior ainda) com repositórios não oficiais de qualidade questionável (não usamos nem recomendamos, mas eles são uma realidade nos desktops) e você estará clamando por desastre. 

Uma outra desvantagem de todos os tipos de GUI é a necessidade de X e para o dist-upgrade é recomendado efectuá-lo na consola.

Já o apt-get faz estritamente o que é pedido a ele. Se houver algum problema, fica fácil localizar o erro para depuração/correção; se o apt-get quiser remover metade de seu sistema (devido a transições nas bibliotecas), é só chamar o administrador (quer dizer, você mesmo) para dar, no mínimo, uma olhada séria (e consultar os Avisos na página do siduction, não se esqueça).

É por isso que o Debian usa exclusivamente o apt-get, não uma das outras ferramentas de gerenciamento de pacotes.

<div class="divider" id="apt-cache"></div>
## Procurar pacotes com o apt-cache

Outro comando muito útil do sistema APT é o apt-cache; ele procura no banco de dados do APT e mostra informações sobre pacotes; p. ex., uma lista com todos os pacotes que contenham ou referenciem "siduction" e "manual" pode ser obtida assim:

~~~  
$ apt-cache search siduction manual  
.......  
siduction-manual-common - the official siduction manual - common files  
siduction-manual-es - the official Spanish siduction manual  
siduction-manual-de - the official German siduction manual  
siduction-manual-el - the official Greek siduction manual  
siduction-manual - the official siduction manual - all languages  
siduction-manual-pt-br - the official Brazilian Portuguese siduction manual  
siduction-manual-en - the official English siduction manual  
siduction-manual-reader - siduction manual reader  
~~~

Se quiser mais informações sobre um pacote em particular, você pode usar:

~~~  
$ apt-cache show siduction-manual-en  
Package: siduction-manual-en  
Priority: optional  
Section: doc  
Installed-Size: 1088  
Maintainer: Kel Modderman <kel@otaku42.de>  
Architecture: all  
Source: siduction-manual  
Version: 01.12.2007.06.03-1  
Depends: siduction-manual-common  
Filename: pool/main/s/siduction-manual/siduction-manual-en_01.12.2007.06.03-1_all.deb  
Size: 391222  
MD5sum: 60f2175c3c5709745a4b4256ccc3c49d  
SHA1: e275a0b27628b6aa210a4ced48d3646b438e78b8  
SHA256: 2792580c7a091521301064180a1d0d8901f0a4af407b90432b9f8d8b6b3603ca  
Description: the official en siduction manual  
This manual is divided into common sections, for example, .......  
~~~

Todas as versões instaláveis do pacote (elas dependem de sua sources.list) podem ser listadas se você digitar:

~~~  
$ apt-cache policy siduction-manual-pt-br  
siduction-manual-pt-br:  
Installed: (none)  
Candidate: 01.34.2007.08.29-2  
Version table:  
*** 01.34.2007.08.29-2 0  
500 http://siduction.org sid/main Packages  
100 /var/lib/dpkg/status  
~~~

 [Uma descrição completa do Sistema APT pode ser encontrada em APT-HOWTO](http://www.debian.org/doc/user-manuals#apt-howto)  

<div class="divider" id="gui-pacsea"></div>
## Debian Package Search, uma aplicação com interface gráfica para pesquisar pacotes Debian

~~~  
apt-get update  
apt-get install packagesearch  
~~~

Ao rodar o Debian Package Search pela primeira vez, é necessário editar Packagesearch > Preferences para habilitar o `apt-get` .

**`Please do not use Packagesearch to install packages, use it only as a GUI search engine. Upgrading packages and installing new packages without stopping X can cause problems. Please read  [Installing a new package](sys-admin-apt-pt-br.htm#apt-install) .`** 

O programa deverá pedir, também, para você instalar o pacote deborphan. For favor, seja cauteloso.

Faça sua pesquisa preenchendo os campos:

+ Search for pattern  
+ Debtags (tags baseadas no sistema debtags, uma nova maneira de dispor os pacotes Debian nas respectivas categorias)  
+ Filenames  
+ Orphans  
+ Installed Filter  

Uma série de informações sobre o pacote será mostrada, incluindo quais arquivos fazem parte dele. Favor ler Help > Contents para uma completa explicação sobre o uso desta aplicação. Até o presente momento, só existe a versão em Inglês para a interface.

 [A descrição completa do Sistema APT pode ser encontrada em APT-HOWTO](http://www.debian.org/doc/manuals/apt-howto/)  

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
