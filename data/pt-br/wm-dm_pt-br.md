<div id="main-page"></div>
<div class="divider" id="install-add"></div>
## Algumas aplicações úteis não pré-instaladas no siduction KDE Lite

 `O repositório non-free precisa estar habilitado em /etc/apt/sources.list.d/debian.list` 

###### konq-plugins - plugins para o Konqueror 

Este pacote contém uma série de plugin úteis para o Konqueror, o gerenciador de arquivos, navegador web e visualizador de documentos do KDE. Muitos deles aparecerão no menu Ferramentas do Konqueror.

~~~  
apt-get install konq-plugins  
~~~

Os destaques para a navegação web são tradução e arquivamento de páginas, análise estrutural de HTML e css, barra de pesquisa, barra para exibição de notícias, acesso rápido a opções comuns, 'bookmarklets', monitor de travamentos, atualização automática de páginas, indicador de disponibilidade de microformatos, ferramentas de marcadores para o del.icio.us e integração com o leitor de feeds RSS aKregator.

Os destaques para a navegação entre arquivos são filtros para diretórios, criação de galerias de imagens, extração e compressão de arquivos, copiar/mover rápidos, barra para media player, metabarra para informações sobre arquivos, assistente para pasta de arquivos multimídia, visualizador gráfico de utilização do HD e conversões/transformações de imagens. 

###### KDE Deskop Search - (Nepomuk and Strigi) 

KDE's Nepomuk semantic desktop search is not enabled on an siduction-kde.iso. To enable it, do the following:

Install the virtuoso-minimal and strigi-client packages:

~~~  
apt-get install virtuoso-minimal strigi-client  
~~~

Navigate to System Settings &gt; System Administration &gt; Startup and Shutdown &gt;Service Manager, put a check mark in the box for `Nepomuk Search Module` , and then click on `Apply` .

Navigate to System Settings > Workspace Appearance and Behavior &gt; Desktop Search &gt; Basic Settings, and put check marks in the boxes for `Enable Nepomuk Semantic Desktop`  and `Enable Strigi Desktop File Indexer` , and then click the `Apply` . Note that the amount of memory allocated to the Nepomuk database can be adjusted in the `Advanced Settings`  tab.

The KDE session must be restarted for the indexing service to become effective. Expect the first iteration of indexing to take a long time.  [More information about Nepomuk](http://nepomuk.kde.org/) . 

<div class="divider" id="kde-login"></div>
## Problemas do sistema no login do KDE

Normalmente, todo o conteúdo do diretório /tmp é apagado a cada reinicialização do sistema. Com isso, alguns sub-diretórios e sockets necessários ao servidor X o são também.

Em geral, durante o processo de boot, o script x11-common para o X-Org recria essas coisas.

O que acontece é que, possivelmente, esse script não está sendo chamado; mas você pode recriar os links necessários desta forma:

~~~  
# X-ORG: # dpkg-reconfigure x11-common  
~~~

O KDE precisa que sejam alocados 5% da partição onde está o diretório /tmp, para que seja possível criar os arquivos temporários após o login. Se sua partição estiver 95% cheia, você não vai conseguir abrir o KDE e será levado ao tty (terminal).

O mesmo vale para quando o KDM entra em loop e não permite que você entre no KDE. Uma solução é logar-se no terminal (tty) e apagar alguns arquivos ou mesmo aplicações que você não usa mais.

Uma alternativa seria usar um gerenciador de janelas que não requeira tanto espaço em disco (como o Fluxbox, que já faz parte da instalação padrão do siduction). Outra seria usar 'chroot' com um CD/DVD-Live do siduction para limpar sua partição, o que permitiria que você entrasse no KDE.

Recomendamos que você use um máximo de 85% de sua partição, deixando os outros 15% disponíveis para o KDE acessar os arquivos do diretório /tmp.

<div class="divider" id="ch-th"></div>
## Como instalar temas e arte do KDE no siduction

Para colocar em um siduction já instalado os pacotes de arte mais recentes:

~~~  
apt-get install siduction-art-kde-xxxx siduction-art-wallpaper-xxxx  
(Onde xxxx é o nome da versão para os pacotes 'siduction-art-kde-onestepbeyond' e o 'siduction-art-wallpaper')  
~~~

Com isso, você instala os novos temas e papéis de parede.

#### Como mudar o papel de parede:

`Clique com o botão direito` em sua área de trabalho ('Desktop') e escolha `Configurar Área de Trabalho ('Desktop Settings', se você estiver usando o KDE em Inglês)` . No lado esquerdo, clique em `Fundo de Tela` . Observe que do lado direito há o subtítulo `Figura` . Ele oferece uma caixa com uma lista onde você pode escolher qual papel de parede será exibido. Você pode também clicar no botão de Navegação (ícone azul) para escolher alguma imagem que você tiver dentro de seu HD.

#### Como mudar a Tela de Login:

Para mudar a Tela de Login, em primeiro lugar abra o `systemsettings` , como root:

~~~  
Alt + F2 (para abrir o krunner)  
~~~

~~~  
kdesu systemsettings  
~~~

A seguir, clique na aba `Avançado ('Advanced')`  e em `Gerenciador de Login ('Login Manager')` , para ir à aba `Temas ('Theme')`  e escolher seu tema predileto.`Para ativar a nova Tela de Login é necessário reiniciar o computador` .

 [Mais informações sobre o KDE e links](http://kde.org)  

<div class="divider" id="xfce-notes"></div>
## Alguns extras úteis do XFCE

<div class="divider" id="xfce-notes-1"></div>
### Como instalar pacotes com temas e arte no XFCE

Instalar pacotes de arte mais recentes com o siduction já instalado anteriormente:

~~~  
apt-get install siduction-art-xfce-xxxx siduction-art-wallpaper-xxxx  
(Onde xxxx é o nome da versão. Por exemplo, siduction-art-xfce-onestepbeyond)  
~~~

Com isso você instala os temas e papéis de parede do siduction e muda os padrões no menu de configuração do XFCE.

 [Documentação do XFCE](http://www.xfce.org/documentation) 

 [Wiki do XFCE](http://wiki.xfce.org) 

<div class="divider" id="dm"></div>
## Gerenciadores de ambientes - dm

###### Como instalar outros ambientes gráficos ao lado de um ambiente pré-instalado:

Sempre que você instalar outro ambiente gráfico junto com um já existente (por exemplo, você instalou uma ISO do siduction.org KDE e agora deseja instalar o XFCE ou o LXDE), um gerenciador de ambientes ('display manager' ou simplesmente dm) provavelmente será instalado também (ou talvez você mesmo o tenha instalado, seja ele o gdm, o slim ou algum outro gerenciador qualquer).

The problem with this is you will end up with the default Debian runlevel configuration with the consequence that you will need to stop X manually in runlevel 3 before commencing a dist-upgrade.

A solução é:

~~~  
apt-get update  
apt-get install --reinstall distro-defaults  
update-rc.d <dm> remove  
update-rc.d <dm> defaults  
~~~

Exemplos para `update-rc.d <dm> defaults` . Note o pontinho **`.`**  :

~~~  
update-rc.d kdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d gdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d slim start 01 5 . stop 01 0 1 2 3 4 6 .  
~~~

<div class="divider" id="desk-freeze"></div>
## Travamentos do desktop

Em tais situações, nem sempre é necessário reiniciar seu computador, pois isso pode danificar o sistema de arquivos ou levar a perda de dados.

Primeiramente, tente mudar para o modo de texto com `Alt-Ctrl-F1`  ou reiniciar o servidor X com `Alt-Ctrl-Backspace` . Se não funcionar, ainda há esperanças:

A tecla SysRq (Print ou PrtSc, na região superior direita do teclado) pode ajudá-lo a fazer uma reinicialização "limpa" de seu sistema travado.

A seguinte sequência de combinações de teclas são possíveis:  
*`alt+sysrq+r`  (devolve-lhe o controle do teclado)  
*`alt+sysrq+s`  (envia um sync)  
*`alt+sysrq+e`  (envia um "term" - finalizar - para todos os processos, exceto o init)  
*`alt+sysrq+i`  (envia um "kill" - matar - para todos os processos, exceto para o init)  
*`alt+sysrq+u`  (monta o sistema de arquivos como "readonly" - somente leitura -, o que evita a execução do fsck na reinicialização)  
*`alt+sysrq+b`  (reinicia o sistema sem os passos anteriores. este é o chamado 'hard reset', ou seja, reiniciar "na marra").

Após cada passo, aguarde um pouquinho antes de ir para o próximo; finalizar todos os processos, por exemplo, leva algum tempo. Em Inglês, há um jeito mnemônico de lembrar facilmente as letras necessárias: **"**`R`** eboot **`S`** ystem **`E`** ven **`I`** f **`U`** tterly **`B`** roken"** 

Another way to remember it is:  
 **"**`R`** aising **`S`** kinny **`E`** lephants **`I`** s **`U`** tterly **`B`** oring"** 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
