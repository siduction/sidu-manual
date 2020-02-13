<div id="main-page"></div>
<div class="divider" id="welcome-quick"></div>
## Guia Rápido do siduction

###### **`OBSERVAÇÃO MUITO IMPORTANTE:`** `o siduction, como LiveCD do Linux, é baseado em tecnologia de alta compressão. Por isso, cuidados especiais são necessários ao queimar a imagem ISO: use apenas mídias de alta qualidade [CD ou DVD+RW] e queime no **`modo DAO (disk-at-once)`**  e em velocidade não superior a 8x.` 


---

O siduction tem por objetivo ser 100% compatível com o Debian sid; no entanto, o siduction pode disponibilizar correções "quentinhas" temporárias de vez em quando. O repositório apt do siduction abriga os pacotes específicos da distro, isto é, o kernel do siduction, scripts, ferramentas e documentação.

### Leitura obrigatória

`Alguma das páginas deste manual são altamente recomendáveis para to o utilizador "novo no linux" ou então "novo no siduction". Esta é uma delas. As outras são as seguintes:` 

+  [O terminal ou Konsole](term-konsole-pt-br.htm#term-kon)  - como utilizar o terminal e o uso do commando "sux".  
+  [Particionar](part-gparted-pt-br.htm#partition)  - como particionar o seu disco.   
+  [Instalação no HD](hd-install-pt-br.htm#install-prep)  - como fazer a instalação num disco duro.  
+  [Instalação do siduction em USB ou cartão SD/flash](hd-install-opts-pt-br.htm#usb-hd)  - como fazer a instalação em um dispositivo USB ou cartão SD/flash.  
+  [Copiar siduction to USB ou cartão SSD/flash](hd-ins-opts-oos-pt-br.htm#usb-hd#raw-usb)  - como utilizar o siduction num dispositivo USB/SSD/flash em vez de utilizar um CD/DVD.  
+  [Drivers não livres e as sources.list](nf-firm-pt-br.htm#non-free-firmware)  - como adaptar as suas fontes "/etc/apt/sources.list.d/list" para instalar firmware não livre.  
+  [Conexão com a Internet](inet-ceni-pt-br.htm#netcardconfig)  - como fazer a configuração para se ligar a internet.  
+  [Uso do "apt" e dist-upgrade](sys-admin-apt-pt-br.htm#apt-cook)  - como manter o sistema atualizado e instalar novo software.  

##### Estabilidade do Debian sid/instável

sid é um apelido dado aos repositórios instáveis do Debian. O Debian sid é atualizado frequentemente e traz sempre as versões mais recentes dos pacotes mantidos. Por causa dessa alta frequência de atualizações, não é possível fazer uma grande quantidade de testes nos pacotes, entre o momento em que eles chegam aos repositórios e o momento em que são disponibilizados. 

##### O kernel do siduction

O kernel é otimizado pelo siduction, para ajudar a evitar problemas e adicionar novas funcionalidades. Também é configurado para obter um desempenho melhor e mais estável. Todas essas otimizações são feitas a partir do site [http://www.kernel.org/](http://www.kernel.org/) . 

Há um espelho para o kernel aqui:  [Como atualizar o kernel](sys-admin-kern-upg-pt-br.htm#kern-upgrade) 

#### Gerenciamento de pacotes

O siduction segue o sistema de empacotamento do Debian, daí usar apt e dpkg para o gerenciamento de pacotes. Os repositórios, tanto do Debian quanto os outros, são identificados pelos arquivos em `/etc/sources.list.d/*` 

O Debian sid possui mais de 20.000 pacotes, portanto você, com certeza, encontrará o que precisa. Para isso, use o  [Como procurar pacotes com o apt-cache](sys-admin-apt-pt-br.htm#apt-cache)  ou com a  [aplicação de interface gráfica Debian Package Search](sys-admin-apt-pt-br.htm#gui-pacsea) .

Para instalar pacotes: `apt-get install <nome do pacote>` :  [Como instalar um novo pacote](sys-admin-apt-pt-br.htm#apt-install) 

 Os repositórios do Debian sid podem ser atualizados até quatro vezes por dia; portanto, é essencial rodar `apt-get update`  antes de instalar quaisquer novos pacotes ou antes de um `apt-get dist-upgrade` ; assim, você mantém seu sistema sempre sincronizado com os pacotes existentes no servidor.

###### Como usar repositórios de outras distribuições baseadas no Debian, Código-Fonte e RPMs

Instalações a partir dos arquivos fonte não são possíveis. Se você tiver mesmo de compilar sua aplicação, faça-o como usuário, na sua pasta /home, sem instalar no sistema. Também não há suporte para o uso do 'checkinstall' e conversões de RPMs para .deb com o 'alien' (ou outro programa desse tipo).

Algumas distribuições bem conhecidas (e outras bem menos) refazem os pacotes do Debian para os seus próprios repositórios, muitas vezes colocam os arquivos das aplicações em locais diferentes, o que pode causar instabilidades no sistema. Alguns pacotes, inclusive, nem conseguem ser instalados, devido a dependências não resolvidas causadas pelo uso de nomes ou números de versões diferentes para os pacotes. Por exemplo, uma versão diferente da 'glibc' pode fazer com que a aplicação nem seja executada!

Use os repositórios do Debian para instalar os pacotes desejados. É bem provável que pacotes de repositórios alheios não podem ser suportados.

#### Como atualizar todo o sistema - dist-upgrade

`apt-get dist-upgrade`  é a maneira padrão de atualizar o siduction. Usar qualquer 'front-end' (interface gráfica) para atualizar o siduction não é possível.  [Como atualizar todo o sistema - dist-upgrade](sys-admin-apt-pt-br.htm#apt-upgrade) 

Um 'dist-upgrade' só é possível fora do ambiente X. Para parar o X, basta digitar "init 3" (sem as aspas) no terminal do KDE, XFCE ou qualquer que seja o gerenciador de janelas que você esteja usando. Você pode também usar um terminal virtual (ctrl+alt+f1, ctrl+alt+f2, etc).

#### Configuração da rede

O `Ceni`  é uma ferramenta que permite a configuração rápida de sua rede ou placa wireless, sem nenhuma complicação. A opção 'wireless' procura pelas redes disponíveis, usa encriptação WEP e WPA e usa os pacotes wireless-tools ou wpa_supplicant para configuração. Já a conexão com fios (Ethernet) é automática se você usar dhcp. Se não for o caso, você pode configurá-la manualmente, desde as máscaras de rede aos nomes de servidores. 

Execute o Ceni com o comando`Ceni`  ou `ceni` . Se ele não estiver instalado, faça-o com o comando 'apt-get install ceni'. 

 [Conexão com a Internet - Ceni](inet-ceni-pt-br.htm#netcardconfig) 

#### Runlevels no siduction - init

O modo como o siduction executa os diversos níveis ('runlevels') difere do Debian. Veja:  [Runlevels (níveis de execução) no siduction - init](sys-admin-gen-pt-br.htm#init) 

##### Outros gerenciadores de janelas

O KDE, XFCE e o Fluxbox são os padrões no siduction. Gnome is not supported by siduction to date. Alguns usuários nos fórums, wiki e IRC do siduction podem, quem sabe, ajudá-lo. Do contrário, você terá de se arranjar sozinho.

#### Ajuda no IRC e no Fórum

Não receie solicitar ajuda no IRC ou nos fórums:

+  [Onde obter ajuda](help-pt-br.htm#help-gen)    
+  [web IRC](http://thegrebs.com/oftc/)  digite seu nick e junte-se ao #siduction  

<div id="rev">Content last revised 03/06/2012 1400 UTC</div>
