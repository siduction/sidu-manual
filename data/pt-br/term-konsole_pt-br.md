<div id="main-page"></div>
<div class="divider" id="term-kon"></div>
## Definição de Terminal/Konsole

Um terminal, também chamado de 'console' e, no KDE, 'konsole', é um programa que possibilita interagir diretamente com o sistema operacional Linux, através de vários comandos que são imediatamente executados. Conhecido também por `'shell' ou 'linha de comando'` , o terminal é uma ferramenta poderosa e merece o esforço dispendido para ganhar algum conhecimento básico sobre seu uso.

No siduction, você encontra o terminal/konsole perto do K-menu, simbolizado por um pequeno monitor. Dependendo do tema que você estiver usando, ele pode ou não conter ainda a imagem de uma concha ('shell', em Inglês). O mesmo ícone pode ser encontrado também em K-menu > Sistema.

Ao abrir a janela do terminal, você é apresentado ao 'prompt', cujo formato é este:

~~~  
nome_do_usuário@nome_do_computador:~$  
~~~

Você pode ver que o 'nome_do_usuário' é seu próprio nome de login. O `~ (til)`  mostra que você está em seu diretório /home e o `$`  indica que você está logado com privilégios de usuário. No final, fica o cursor. Esta é sua linha de comando, onde você digita os comandos que deseja executar.

Muitos comandos só rodam com privilégios de 'root' ou 'superusuário'. Para se tornar root, basta digitar `sux`  no prompt e pressionar [ENTER]. O sistema pedirá sua senha de root. Digite-a e aperte [ENTER] de novo (note que quando você digita a senha não aparece nada na tela).

Se a senha estiver correta, o prompt vai mudar para:

~~~  
root@nome_do_computador:/home/nome_do_usuário#  
~~~

**`ATENÇÃO: Enquanto estiver logado como root, o sistema não o impedirá de fazer coisas perigosas, como apagar arquivos importantes etc; você precisa ter certeza absoluta do que está fazendo, porque há grandes possibilidades de você causar sérios danos ao sistema.`**

Note que o sinal `$`  mudou para `#`  (cerquilha). No terminal/konsole a `#`  mostra que você está logado como root. `Neste manual, omitiremos tudo que estiver à esquerda do $ ou da #. Assim, um comando como:` 

~~~  
# apt-get install algum_pacote  
~~~

Significa: abra um terminal, torne-se root (com sux) e digite o comando acima no prompt `(Não digite a #)` 

Pode acontecer de a tela do terminal/console ficar corrompida. Basta digitar:

~~~  
reset  
~~~

... e pressionar [ENTER].

Se a saída parecer distorcida, pressione `ctrl+l,`  para refazer a janela. Essa distorsão geralmente acontece quando se usa programas que usam a interface ncurses, como o irssi.

Às vezes, o konsole/terminal parece estar travado; na verdade, não está e tudo que você digitar será processado. Isso pode acontecer quando se pressiona `ctrl+s`  por acidente. Nesse caso, experimente `ctrl+q`  para 'destravá-lo'.

Uma observação sobre o `sux` : o comando normal para se tornal root é 'su', mas o 'sux' permite-lhe rodar aplicações X11 pela linha de comando.

<div class="divider" id="colours"></div>
### `Prompts coloridos para o`  `usuário:~` `$`  e o **`root:`** `#`  `:` 

Prompts em cores podem impedir que você cometa embaraçosos e possivelmente catastróficos erros como **`root #`**  quando o que você queria mesmo era ser `user~$` ; pode-se também usar prompts coloridos para marcar comandos executados a umas 100 linhas atrás.

Por padrão, tanto o prompt do user~$ quanto o do root# têm a mesma cor, mas é fácil trocar ambas.

As cores básicas são:

~~~  
(a sintaxe é 00;XX)  
[00;30] Preta  
[00;31] Vermelha  
[00;32] Verde  
[00;33] Amarela  
[00;34] Azul  
[00;35] Magenta  
[00;36] Ciano  
[00;37] Branca  
[Substitua [00;XX] por [01;XX] para obter uma variedade de cor diferente].  
~~~

###### Como mudar a cor do prompt de seu nome de usuário ~$:

Como usuário $, com seu editor predileto:

~~~  
$ <editor> ~/.bashrc  
~~~

Vá até a linha 39 e descomente-a, deixando-a assim:

~~~  
force_color_prompt=yes  
~~~

Vá para a linha 53 e onde estiver 01;32m, (por exemplo), mude para a cor desejada.

A título de ilustração: para um prompt de usuário-$ `ciano` , [01;36m\], você precisará mudar o código [01;XXm\] em 3 lugares, com a seguinte sintaxe:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[01;36m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '  
~~~

Esse novo visual só terá efeito em novas sessões de terminal.

###### Como mudar a cor do prompt do root #:

~~~  
sux  
<editor> /root/.bashrc  
~~~

Vá até a linha 39 e descomente-a. Ela deverá ficar assim:

~~~  
force_color_prompt=yes  
~~~

Agora, vá à linha 53 e onde estiver 01;32m, (por exemplo), substitua pela cor que lhe interessa.

Exemplo: para um prompt root-# na cor **`vermelha`** , [01;31m\], você deverá alterar o código [01;XXm\] em 3 lugares, usando a seguinte sintaxe:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[01;31m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '  
~~~

Isso só fará efeito nas próximas sessões de terminal.

###### Cores de fundo do terminal

Para mudar a cor de fundo e as fontes do terminal, veja as opções no Menu do Terminal. 

![Terminal colours](../images-common/images-terminal/terminal-colour-0.1.png "Terminal colours") 

Há um grande arco de opções disponíveis; entretanto, recomendamos atentar sempre para a simplicidade.

<div class="divider" id="sux"></div>
## Sobre o sux

Muitos comandos só rodam com privilégios de root. Para isso, digite:

~~~  
sux  
~~~

O comando mais comum para se tornar root é o "su", porém ao usar `sux`  você poderá rodar aplicações GUI / X11 pela linha de comando e executar aplicações gráficas. Isto porque o `sux`  envolve o 'su', que transfere suas credenciais X para o usuário alvo. (Veja também  [sudo](#sudo) ).

Um exemplo disso é rodar um editor de texto, como o KWrite ou KEdit, para alterar arquivos root, usar o GParted para particionar um HD, ou rodar o gerenciador de arquivos Dolphin ou Thunar. <!--Você também pode fazer alterações em arquivos que exijam privilégios de root clicando no arquivo com o botão direito do mouse e escolhendo 'Editar como root'. Em seguida entre com a senha e comece a edição.-->

Algumas aplicações do KDE exigem que o `dbus-launch`  seja rodado à sua frente:

~~~  
dbus-launch <Aplicação>  
~~~

###### Opções do KDE pelo teclado:

Para iniciar o krunner no KDE:

~~~  
Alt+F2  
~~~

...ou clique com o botão direito na área de trabalho e escolha:

~~~  
Executar Comando  
~~~

então:

~~~  
kdesu <aplicação>  
~~~

###### Opções do XFCE pelo teclado:

Para iniciar o 'Executar Comando' no XFCE:

~~~  
Alt+F2  
~~~

...ou clique com o botão direito na área de trabalho e escolha:

~~~  
Executar Programa  
~~~

daí:

~~~  
gksu <aplicação>  
~~~

###### Opções para outros Gerenciadores de Janelas

Outra opção genérica, usando o teclado, para a maioria dos principais Gerenciadores de Janelas é:

~~~  
Alt+F2  
~~~

então:

~~~  
su-to-root -X -c <aplicação>  
~~~

`Todas as opções de teclado acima podem ser rodadas pelo terminal.` 

<div class="divider" id="sudo"></div>
## Não há suporte para o sudo

O sudo não é habilitado automaticamente quando o siduction é instalado no HD. Ele está disponível para uso quando se dá o boot pelo LiveCD, já que nenhuma senha de root é cadastrada. A motivação por trás disso é que, se alguém atacar a máquina e se apoderar da senha dos usuários, esse alguém não terá controle de imediato dos privilégios do superusuário. Isso impede que ele cause potenciais danos ao sistema.

Outro problema com o sudo é que ele permite que uma aplicação típica do root seja rodada com uma configuração de usuário, o que pode substituir ou alterar permissões. Em certos casos, isto pode subsequentemente fazer com que uma aplicação se torne inútil para o usuário. Use `[sux](#sux) , kdesu, gksu ou su-to-root -X -c`  conforme recomendado!

## Enquanto root

**`ATENÇÃO: enquanto estiver numa sessão como root, o sistema não irá impedi-lo de fazer coisas perigosas, como apagar arquivos importantes etc. Portanto, é necessário que você esteja absolutamente seguro do que está fazendo, porque há uma grande possibilidade de você danificar seu sistema.`**

**`Em nenhuma circunstância torne-se root para rodar aplicações que um usuário comum executa no seu dia a dia, como enviar emails, montar planilhas, navegar na Internet etc.`**

<div class="divider" id="cli-help"></div>
## Ajuda pela Linha de Comando

Sim, existe. Muitos comandos/programas do Linux vêm com seu próprio manual, chamado 'man page', ou seja, 'manual page (página de manual)', acessível pela linha de comando. A sintaxe é a seguinte:

~~~  
$ man comando  
~~~

ou

~~~  
$ man -k <palavra-chave>    
~~~
  
Isso traz a página de manual para o comando solicitado. Navegue por ela usando as setas direcionais. Por exemplo, digite:

~~~  
$ man apt-get  
~~~

Para sair de uma página de manual, basta apertar `q` 

Outro utilitário útil é o comando "apropos". Basicamente, o 'apropos' permite que você procure páginas de manual para um comando, mesmo sem saber a sintaxe correta. Por exemplo:

~~~  
$ apropos apt-  
~~~

Isso vai listar todos os comandos para o gerenciador de pacotes 'apt'. O 'apropos' é uma ferramenta bastante poderosa, mas descrevê-la em detalhes está além do propósito (desculpe o trocadilho) deste manual. Se você quiser, veja sua própria 'man page'.

<div class="divider" id="term-cmds"></div>
## Listagem dos Comandos de Terminal no Linux

Aprenda mais sobre o uso do Shell no  [linuxcommand.org](http://linuxcommand.org/) 

`Uma lista com 687 comandos em ordem alfabética do  [Linux in a Nutshell, 5th Edition: O'Reilly Publications](http://www.linuxdevcenter.com/linux/cmd/#a)  estão disponíveis nessa página; o endereço merece entrar para seus Favoritos.`

Há numerosos tutoriais na Internet, inclusive um que é ótimo para iniciantes:  [A Beginner's Bash](http://linux.org.mt/article/terminal) 

Todos os exemplos fornecidos acima estão em Inglês; em Português há o excelente  [Guia/FOCA GNU/Linux](http://focalinux.cipsga.org.br/) . Você pode também usar sua ferramenta de busca preferida para encontrar mais sobre o assunto.

<div class="divider" id="shell-scripts"></div>
## Scripts - um exemplo e como usá-los

 Um 'shell script' (ou simplesmente 'script') é uma maneira conveniente de agrupar diversos comandos em um arquivo. Ao digitar o nome do script, cada comando será executado. O siduction vem com vários scripts úteis, para tornar mais fácil a vida do usuário.

Para executar um 'shell script', se ele estiver em seu diretório atual:

~~~  
./nome_do_script  
~~~

`Alguns scripts exigem a senha root (sux) e outros não. Tudo depende da finalidade do script.`

##### Procedimentos para instalar e executar scripts

Use 'wget' para baixar o script e coloque-o onde tiver sido recomendado `(por exemplo, pode ter sido indicado o diretório /usr/local/bin)` . Você pode usar o mouse para copiar e colar o arquivo diretamente no terminal, após digitar `sux` 

###### Exemplo de uso do wget quando é necessário `acesso root (sux)` 

~~~  
sux  
cd /usr/local/bin  
wget nome_do_script  
~~~

Agora, você precisa tornar o arquivo executável:

~~~  
chmod +x nome_do_script  
~~~

Você também pode usar o navegador de Internet para baixar um script e colocá-lo onde tiver sido recomendado. Lembre-se que, ainda assim, é necessário torná-lo executável.

<!--
###### Exemplo de uso do wget como usuário

Para colocar o arquivo em sua `$HOME como usuário comum ('$')` :

~~~  
$ wget http://manual.siduction.org/shell-script-test/test-script.sh  
~~~

~~~  
$ chmod +x test-script.sh  
~~~

Para rodar um script, execute-o pelo nome:

~~~  
$ ./test-script.sh  
~~~

Você deverá ver isto:

~~~  
Congratulations user [Parabéns seu_nome_de-usuário]  
You successfully downloaded and executed a bash script! [Você baixou e executou um script com sucesso!]  
Welcome to siduction-manuals http://manual.siduction.org [Bem-vindo ao manual do siduction em http://manual.siduction.org]  
~~~

-->
<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
