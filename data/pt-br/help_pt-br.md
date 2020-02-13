<div id="main-page"></div>
<div class="divider" id="help-gen"></div>
## Onde Obter Ajuda

Conseguir ajuda na hora pode significar a diferença entre cair no choro e continuar com o que é importante em sua vida. Este tópico divide-se em seções que lhe mostrarão os meios de acessar todos os tipos de ajuda que o siduction proporciona:

+  [Fórums e Wiki](help-pt-br.htm#for-wiki)   
+  [IRC](help-pt-br.htm#irc)   
+  [Ferramentas para usar em init 3 e modo texto (tty)](help-pt-br.htm#init3-tools)    
+  [Usar IRC em modo texto e/ou init 3](help-pt-br.htm#irc-init3)    
+  [Navegar na web em modo texto e/ou init 3](help-pt-br.htm#init3-web)    
+  [inxi](help-pt-br.htm#inxi)   

<div class="divider" id="for-wiki"></div>
## Os fórums do siduction

Nos fórums você posta dúvidas e recebe respostas a elas; por favor, pesquise nele antes de enviar suas questões, porque outros usuários já podem ter postado mensagens sobre os mesmos problemas. [Os fórums](http://siduction.org)  estão disponíveis em Alemão e Inglês.

## A wiki do siduction

A wiki pode ser utilizada e editada livremente por todos os usuários do siduction. Esperamos que a documentação cresça com o tempo e se desenvolva junto com este projeto.

Esperamos contribuições dos usuários com quaisquer níveis do conhecimento, porque a wiki é destinada a ajudar pessoas com qualquer nível de experiência. Os poucos minutos que você doar à nossa wiki podem representar para outros a economia de horas quebrando a cabeça e pesquisando soluções que acabam por se revelar insatisfatórias.  [A Wiki](http://wiki.siduction.de/index.php?title=Hauptseite) .

<div class="divider" id="irc"></div>
## Ajuda ao vivo pelo IRC 

### Regras de comportamento no IRC

**`Nunca entre no IRC como root ... você é sempre bem-vindo como usuário, nunca como root; se você estiver com problemas, explique-os imediatamente.`**

### Como conectar-se ao #siduction 

Há 2 métodos para se conseguir ajuda online ao vivo:  
1) Clicar no `ícone do siduction-irc`  na Área de Trabalho ou usando outro cliente de chat;  
2) Clicar em `Meet the Team`  no menu do  [siduction.org.](http://siduction.org) 

#### Konversation

A maneira mais fácil é clicar no `ícone do siduction-irc`  na Área de Trabalho ou ir no KMenu e rodar o Konversation pré-configurado.

Se você preferir usar outro cliente de chat, configure o servidor para:

~~~  
irc.oftc.net  
port 6667  
~~~

#### irc ativado no site do siduction

Vá em  [siduction.org](http://siduction.org)  e clique em `Meet the Team`  in the menu list. This will give you options to use a Chat (cgi) or Chat (java) web based irc chat client.

Preencha a caixa 'nickname' com um apelido (nick) qualquer e clique em 'Start web applet!'

<div class="divider" id="paste"></div>
## !paste

**`!paste será o seu amigo no canal irc; sem ele, você poderá até ser acusado de "flooding"`** . Portanto, se lhe solicitarem que use !paste para mostrar a saída de seu terminal, digite `!paste`  na caixa de diálogo do chat (pode acontecer de alguém já ter providenciado o factoid para habilitar 'paste' para você) e isto é o que será mostrado:

~~~  
"paste" is <a href="http://paste.debian.net/">  
http://paste.debian.net/</a> :please choose no  
syntax highlighting;make your paste;  
then give #siduction the link to your paste..  
.  
~~~

Tudo que você precisa fazer é clicar no link para abrir o site, colar a saída solicitada na caixa apropriada, rolar a tela para cima e clicar em `send` .

Você verá que os dados fornecidos foram adicionados ao banco de dados, com várias opções para ligá-los ao IRC, que é o canal requerido. (Exemplo: `para conexão com os dados fornecidos, use: http://paste.debian.net/524`  ). O 'Debian paste' pode ser configurado para mostrar as informações por um determinado período (até 72 horas). Há ainda a opção para você apagar os dados.

### siduction-paste

siduction-paste permite que saídas do terminal sejam coladas no site http://paste.siduction.org, onde ficam disponíveis por 24 horas. Esse serviço é ideal se você tiver problemas no init 3.

Para habilitar o siduction-paste, você pode tanto estar logado como usuário ou como root; no entanto, observe que certas ações exigem que você seja root.

~~~  
siduction-paste <arquivo>  
ou  
command | siduction-paste"  
~~~

###### Exemplo de siduction-paste &lt;arquivo&gt;

~~~  
siduction-paste /etc/fstab [ENTER]  
Mensagem no terminal:  
Your paste can be seen here: http://paste.siduction.org/p/xxXxxxXx.html  
('Sua colagem pode ser vista aqui: http://paste.siduction.org/p/xxXxxxXx.html')  
~~~

O link `http://rafb.net/p/xxXxxxXx.html`  será necessário, caso você solicite ajuda no IRC #siduction.

###### Exemplo de command | siduction-paste

~~~  
fdisk -l | siduction-paste [ENTER]  
Mensagem no terminal:  
Your paste can be seen here:http://paste.siduction.org/p/YYxyXYxx.html  
~~~

O link `http://rafb.net/p/YYxyXYxx.html`  será necessário, caso você solicite ajuda no IRC #siduction.

<div class="divider" id="init3-tools"></div>
## Ferramentas que você precisa conhecer no modo texto (tty) e init 3 

Normalmente, se você está no modo texto/init 3 é porque se prepara para um dist-upgrade ou porque alguma coisa terrível aconteceu com seu sistema. 

#### gpm

Uma boa ferramenta enquanto você está no modo texto é o `gpm` . Ele permite que você use o mouse para copiar e colar entre terminais.

`O gpm`  geralmente já vem pré-configurado no siduction; se não for assim, digite:

~~~  
gpm -t imps2 -m /dev/input/mice  
~~~

Assegure-se de que /etc/gpm.conf existe:

~~~  
/etc/init.d/gpm restart  
~~~

Agora o mouse vai funcionar no modo texto (tty).

#### Explorar arquivos e editar textos

O Midnight Commander é um gerenciador de arquivos em modo texto (tty) e também um editor de textos; ele vem pré-instalado e não apresenta nenhuma complexidade.

Além dos comandos normais pelo teclado, ele também responde aos cliques do mouse, graças ao gpm.

`O mc`  abre o sistema de arquivos, enquanto o `mcedit`  abre um arquivo em branco (mas você pode ir direto a um arquivo já existente).

Exemplo de como ir direto para um arquivo:

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

Agora você pode editar o arquivo para mudar parâmetros e salvar as alterações para que elas tenham efeito imediato.

Leia:

~~~  
man mc  
~~~

<div class="divider" id="irc-init3"></div>
### Como acessar o irc #siduction em modo texto e/ou init 3

**`Nunca entre no IRC como root... você é sempre bem-vindo como usuário, nunca como root; se você estiver com problemas, explique-os imediatamente.`**

#### irc em modo texto e/ou init 3

O padrão é irssi.

Dentro do init 3, você pode mudar para outro terminal desta maneira:

~~~  
# CTRL-ALT-F2  
$ login do siductionbox: <usuário> <senha> (não como root)  
daí digite:  
$ siduction-irc (para levantar o irssi)  
~~~

ou, caso você tenha instalado outro cliente, como o weechat:

~~~  
#apt-get install weechat-curses  
~~~

Se você estiver em init 3, você pode mudar para outro terminal com:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <usuário> <senha> (não como root)  
em seguida, digite:  
$ weechat-curses  
~~~

Agora, conecte-se com irc.oftc.net pela porta 6667. Uma vez conectado, mude seu apelido:

~~~  
/nick um_nome_de_sua_preferência  
~~~

Para juntar-se ao canal #siduction:

~~~  
/join #siduction  
~~~

Se quiser conectar-se com outro servidor:

~~~  
/server nome_do_servidor  
~~~

Na barra inferior aparecerão números, caso haja atividade nos canais. Para mudar para outro canal, use ALT-1, ALT-2, ALT-3, ALT-4 etc....

Para sair:

~~~  
/exit  
~~~

Se você estiver fazendo um dist-upgrade, por exemplo, você pode checar o progresso:

~~~  
para voltar para o dist-upgrade, por exemplo:  
$ CTRL-ALT-F1  
e para voltar para o irc:  
# CTRL-ALT-F2  
~~~

`Aconselhamos que você se familiarize com o irssi (ou outro cliente qualquer) no terminal, antes que aconteça alguma emergência.`

 [Documentação do irssi](http://irssi.org/documentation) 

 [Documentação do WeeChat](http://www.weechat.org/) 

<div class="divider" id="init3-web"></div>
#### Navegação web no modo texto e/ou init 3

O wm3 permite que você navegue no modo texto e/ou init 3.

Veja se o w3m e elinks estão instalados; se não:

~~~  
apt-get update  
apt-get install w3m elinks  
~~~

Então, abra um terminal:

~~~  
$w3m URL  
ou  
w3m ?  
ou  
w3m siduction.org  
~~~

Se você ficar com uma tela preta com instruções embaixo, `não entre em pânico,`  pois basta usar esta combinação de teclas:

~~~  
SHIFT+U  
~~~

Você verá que ele se abre para seu HD, com algo do tipo Goto URL: file:///home/nome_do_usuário/$; apague tudo até GOTO URL e digite, por exemplo:

~~~  
http://siduction.org  
~~~

Agora, você pode navegar até o site do  [siduction.org](http://siduction.org)  ou qualquer outro que quiser.

Se estiver no init 3:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <seu_nome-de_usuário> <senha> (não como root)  
depois digite:  
$ w3m siduction.org  
Para retornar ao d-u, por exemplo:  
$ CTRL-ALT-F1  
~~~

Para ir direto para o manual:

~~~  
$w3m manual.siduction.org  
~~~

 [Homepage do w3m](http://w3m.sourceforge.net/) 

###### `Aconselha-se que você se familiarize com elinks/w3m, irssi/weechat e midnight commander antes que surja alguma emergência. Esta é uma boa página para se imprimir, pois é ótima referência sobre a maneira de se obter ajuda online em tais ocasiões.` 

<div class="divider" id="inxi"></div>
## inxi

O inxi é um script que fornece informações sobre o sistema; ele independe do cliente de IRC que você usa. O script mostra todo tipo de informação sobre seu hardware e software para as pessoas que estão no canal. Desse modo, elas podem ajudá-lo a diagnosticar seu problema... ou apenas se maravilhar com as especificações de sua máquina e a versão de seu kernel, em tempo real via terminal. 

Para usar o inxi no Konversation, digite na caixa de chat:

~~~  
/cmd inxi -v1  
~~~

Para usar o inxi em outros clientes, digite na caixa de chat:

~~~  
/exec -o inxi -v1  
ou  
/inxi -v1  
ou  
/shell -o inxi -v1 (weechat)  
~~~

No terminal, digite:

~~~  
inxi -v1  
~~~

Leia o tutorial com tudo sobre o inxi:

~~~  
inxi -help  
~~~

<div class="divider" id="links"></div>
## Links úteis

###### Documentação Geral do Linux

 [debian.org/doc/user-manuals](http://www.debian.org/doc/user-manuals#apt-howto) 

 [Debian Reference Card - cabe em uma única página impressa](http://www.debian.org/doc/user-manuals#refcard) 

 [debian.org/doc/#howtos](http://www.debian.org/doc/#howtos) 

 [O básico sobre o Debian, instalação e administração do sistema](http://qref.sourceforge.net/index.en.php)  documento disponível em HTML, texto, PDF ou PS em diversas línguas

 [linuxbasics](http://linuxbasics.org/) 

O KDE Help Center (Centro de Ajuda do KDE) no siduction possui uma ajuda interna para Impressão/CUPS; por outro lado, veja:  [Common Unix Printing System CUPS](http://www.cups.org/) 

 [LibreOffice](http://pt-br.libreoffice.org/) 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
