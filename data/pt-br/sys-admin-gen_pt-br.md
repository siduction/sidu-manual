<div id="main-page"></div>
<div class="divider" id="start-services"></div>
## Como habilitar serviços no siduction

### insserv : para iniciar/parar serviços já instalados:

**`Leia cuidadosamente o arquivo `/usr/share/doc/insserv/README.Debian` , as notas de lançamento ('Release Notes') e as páginas de manual ('Man Pages'):`** 

~~~  
$ man insserv  
$ man invoke-rc.d  
$ man update-rc.d  
google LSB headers  
~~~

Para 'iniciar':

~~~  
/etc/init.d/<serviço> start  
~~~

Para 'parar':

~~~  
/etc/init.d/<serviço> stop  
~~~

Para 'reiniciar':

~~~  
/etc/init.d/<serviço> restart  
~~~

Para impedir que serviços rodem na inicialização:

~~~  
update-rc.d <serviço> remove  
[excluir todos os links de inicialização]  
~~~

Para iniciar um serviço ou não segundo as configurações atuais (nem sempre exigido):

~~~  
update-rc.d <serviço> defaults  
[faz os links de inicialização que faltam]  
~~~

Para ver a lista dos serviços atuais:

~~~  
ls /etc/rc5.d  
~~~

`S`  significa que o serviço vai rodar no runlevel 5.  
`K`  significa que o serviço não vai rodar (configuração manual).

<div class="divider" id="bum"></div>
## Boot-Up Manager (bum) - Ferramenta gráfica para configuração de serviços

Se a lógica da sequência de inicialização do debian não é muito clara e familiar para você, procure não brincar com links simbólicos, permissões e coisas deste tipo. Com a finalidade de evitar que você acidentalmente quebre seu sistema, o programa Boot-Up Manager ajuda-o a automatizar suas configurações.

O Boot-Up Manager é um editor de configuração de 'runlevels' em modo gráfico que permite a você determinar quais serviços serão chamados quando o sistema for inicializado ou reinicializado. Ele mostra uma lista com todos os serviços a ser carregados para que você possa ligá-los ou desligá-los de acordo com suas necessidades.

~~~  
apt-get install bum  
~~~

Como usar o Boot-Up Manager:

~~~  
$ sux  
password:  
bum  
~~~

  [Documentação detalhada sobre o Boot-Up Manager](http://www.marzocca.net/linux/bumdocs.html) . 

<div class="divider" id="pkill"></div>
## Como matar um serviço ou processo

`pkill`  é útil porque é fácil de entender e funciona tanto no nível de usuário quanto no de root, no terminal ou no tty:

~~~  
pkill -n serviço  
~~~

Se você estiver em dúvida quanto à grafia do processo ou serviço que deseja matar, o `pkill <tab> <tab>`  fornece uma listagem.

Htop também é uma boa alternativa (em último caso, use killall -9).

<div class="divider" id="init"></div>
## Runlevels (níveis de execução) no siduction - init

Esta é a lista dos runlevels do siduction; note-se que ela difere da lista do Debian stable:

| Runlevel | siduction | Debian | 
| ---- | ---- | ---- |
|  **init 0**  |  Desliga o PC. |  Desliga o PC. | 
|  **init 1**  | Usuário único (modo de segurança). Dæmons como apache e sshd são interrompidos. Não vá para este nível via acesso remoto. | Usuário único (modo de segurança). Dæmons como apache e sshd são interrompidos. Não vá para este nível via acesso remoto. | 
|  **init 2**  |  Modo multiusuário, com a rede rodando, mas não o X; também parar ou não entrar no X. | Runlevel padrão no Debian para o Modo multiusuário com a rede rodando o X. | 
|  **init 3**  |  Modo multiusuário, com rede rodando, mas não o X; também sair ou não entrar no X  [É aqui que acontece o dist-upgrade](sys-admin-apt-pt-br.htm#apt-upgrade) . | O mesmo que runlevel 2 / init 2. | 
|  **init 4**  |  Modo multiusuário, com a rede rodando, mas não o X; também parar ou não entrar no X. | O mesmo que runlevel 2 / init 2. | 
|  **init 5**  | Padrão no siduction para o Modo multiusuário, com rede e X rodando e/ou iniciar o X. | O mesmo que runlevel 2 / init 2. | 
|  **init 6**  |  Reiniciar/Dar um novo 'boot' no sistema. |  Reiniciar/Dar um novo 'boot' no sistema. | 
|  **init S**  |  Onde os serviços iniciais de boot são executados na base do "apenas uma vez". Você não pode voltar a ele depois de ele ter sido rodado. | Onde os serviços iniciais de boot são executados na base do "apenas uma vez". Você não pode voltar a ele depois de ele ter sido rodado. | 


---

To acertain the runlevel (init) you are currently in:

~~~  
who -r  
~~~

Leitura obrigatória sobre runlevels para todo administrador de sistemas Debian:

~~~  
man init  
~~~

+ `runlevel 0`    
+ `runlevel 1`    
+ `runlevel 2`   
+ `runlevel 3` (é aqui que são feitos os dist-upgrades).  
+ `runlevel 4`   
+ `runlevel 5`   
+ `runlevel 6` reiniciar  
+ `runlevel S`    

<div class="divider" id="pw-lost"></div>
## Perda de senha root

Não é possível recuperar uma senha perdida, mas você pode escolher outra:

Primeiro, dê o boot pelo LiveCD.

Como root, monte sua partição "/" (por exemplo, /dev/sdb2):

~~~  
mount /dev/sdb2 /media/sdb2  
~~~

Agora, chroot em sua velha partição root e especifique uma nova senha:

~~~  
chroot /media/sdb2 passwd  
~~~

<div class="divider" id="pw-new"></div>
## Como criar novas senhas:

Para alterar sua senha de 'usuário', comos `$ usuário` :

~~~  
$ passwd  
~~~

Para alterar sua senha de 'root', como `# root` :

~~~  
passwd  
~~~

Para alterar uma senha de 'usuário, como administrador, isto é, como `# root` :

~~~  
passwd <usuário>  
~~~

<div class="divider" id="fonts"></div>
## Fontes no siduction

##### Configuração correta do dpi - filosofia básica

DPI settings are problematic to guess, but are actually perfectly done by X..

##### Resoluções corretas e atualizações da tela

Todo monitor tem sua perfeita combinação de configurações; infelizmente, porém, nem todos mostram os valores de DCC corretos, o que acaba por exigir trabalho manual.

<!--##### Drivers de placas de vídeo

Algumas placas ATI e NVidia mais recentes não funcionam bem com os drivers livres do Xorg e a única solução viável é valer-se dos drivers comerciais de código fechado. O siduction não os pré-instala por razões legais.  [A solução pode ser encontrada aqui](gpu-pt-br.htm) 

-->
##### Fontes padrão, renderização e tamanhos

O siduction usa as fontes livres pré-selecionadas pelo Debian, comprovadamente bem equilibradas. Usar uma seleção diferente pode resultar em deteriorização da qualidade de renderização. Mas há algumas opções poderosas (além do que pode ser encontrado em KDE > Configurações do sistema ), que também podem ajudar a conseguir renderizações suaves com outras fontes. Lembre-se, no entanto, que cada fonte possui apenas uns poucos tamanhos perfeitos; outros já não dão um resultado tão bom.

Experimentar com os valores do DPI também pode ajudar:

~~~  
fix-dpi-kdm  
~~~

Isso mostra o DPI para sua tela, mas você pode brincar à vontade desde que o faça no init 3 (e depois volte para o init 5 ou simplesmente reinicie sua máquina).

Depois de mudar os tipos de fonte ou os tamanhos do DPI (no X ou no Firefox/Iceweasel), podem ser necessários alguns ajustes até que tudo fique do seu gosto. Isso acontece principalmente quando você muda as fontes de Bitmap para Truetype ou vice-versa:

~~~  
dpkg-reconfigure fontconfig-config  
~~~

Selecione Native e Autohinter. Se não gostar, experimente até conseguir os melhores resultados.

Pode ser necessário reconstruir o cache das fontes:

~~~  
fc-cache -f -vv  
~~~

Se não funcionar, você terá de reinstalar o pacote com um arquivo de configuração padrão do cache de suas fontes:

~~~  
apt-get install --reinstall --yes -o DPkg::Options::=--force-confmiss -o DPkg::Options::=--force-confnew fontconfig fontconfig-config  
~~~

##### Aplicações baseadas em GTK, como Firefox/Icewasel

Em geral, esse tipo de aplicações é problemático com os padrões do KDE. Para resolver, digite como root no terminal:

~~~  
apt-get install gtk2-engines system-config-gtk-kde gtk-qt-engine gtk2-engines-qtcurve  
~~~

Em `System Settings (Sistema) >Appearance (Aparência)`  você encontra um novo menu chamado `GTK Styles and Fonts (Estilos e Fontes do GTK)` . Configure 'GTK Styles' para usar 'Clearlooks' e em 'GTK Fonts' marque a opção 'Use my KDE fonts in GTK applications' `ou`  experimente várias opções até encontrar aquela que vá ao encontro de suas preferências.

Isso DEVE acertar a renderização das fontes em suas aplicações GTK.

<div class="divider" id="cups"></div>
## CUPS

Há uma grande seção dedicada ao CUPS na Ajuda do KDE, porém constantes dist-upgrades podem fazer com que ele passe a ter um comportamento errático. Eis uma solução:

~~~  
modprobe lp  
echo lp >> /etc/modules  
apt-get remove --purge cupsys cups  
apt-get install cups  
OU  
apt-get install cups cups-driver-gutenprint hplip  
~~~

Assegure-se de que o CUPS está rodando:

~~~  
/etc/init.d/cups restart  
~~~

 Então, abra o navegador Web e digite na barra de endereços: 

~~~  
http://localhost:631  
~~~

Outra pegadinha: quando você vai configurar o CUPS pela interface gráfica, uma caixa de diálogo pede sua senha root, mas o que vem preenchido nela é seu nome de usuário; então, se você coloca sua senha de usuário, não funciona. Na verdade, o que você tem de fazer é mudar seu nome de usuário para **`root`**  e entrar sua **`senha root`** .

 [The OpenPrinting database](http://www.linuxfoundation.org/collaborate/workgroups/openprinting/database/databaseintro)  contains a wealth of information about specific printers, along with extensive driver information, the drivers themselves, basic specifications, and an associated set of configuration tools. 

<div class="divider" id="sound"></div>
## Som no siduction

`O som é emudecido no siduction, por padrão.` 

A versão com KDE usa o Kmix ('KMix (Mixer de som)' em Português) e a versão com XFCE usa o Mixer ('Mixador').

Muitas vezes, basta clicar no ícone de som na barra de tarefas e desmarcar a caixa Mute ('Mudo').

###### Kmix

No Kmix, você precisa ativar suas opções para os canais: `Kmix > Setting > Configure Channels (Kmix > Configurações > Configurar Canais).`  Ou no terminal:

~~~  
$ kmix  
~~~

###### XFCE

No XFCE, rode o Mixer ('Mixador') e adicione alguns controles via `Multimedia > Mixer (Multimídia > Mixador)`  e clique na caixa `Select Controls ('Selecionar Controles').`  Ou pelo terminal:

~~~  
$ xfce4-mixer  
~~~

### Alsamixer

Se preferir, você pode usar o Alsamixer, que está no pacote alsa-utils:

~~~  
apt-get update  
apt-get install alsa-utils  
exit  
~~~

Edite suas preferências de som como **`$ usuário`**  a partir do terminal:

~~~  
$ alsamixer  
~~~

<!--
 []() Veja também a wiki.</a>

-->
<div id="rev">Content last revised 24/07/2012 1830 UTC</div>
