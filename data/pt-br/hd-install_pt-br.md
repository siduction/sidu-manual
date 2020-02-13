<div id="main-page"></div>
<div class="divider" id="Inst-prep"></div>
## Instalação no HD - preparação

**`Para uma instalação normal, recomendamos usar ext4; ele é o sistema de arquivos padrão do siduction e conta com uma boa manutenção.`**

`Antes de instalar, favor remover todos os dispositivos USB, como cartões de memória, pendrives, câmeras etc` .  [Instalar em dispositivos USB requer passos adicionais.](hd-install-opts-pt-br.htm)  Você pode editar o arquivo instalador `~/.sidconf` , e escolher outro sistema de arquivos ou espalhar sua instalação por diferentes partições. Por exemplo, montar uma /home separada.

`Recomendamos que você tenha uma partição só para os dados. Os benefícios em termos de estabilidade ou recuperação após um possível desastre são incomensuráveis.`

Assim, sua $HOME torna-se um espaço para guardar as configurações básicas dos programas. Ou, dito de outra maneira, um recipiente onde as aplicações armazenam suas configurações.

###### Como listar aplicações para duplicação em outra máquina

Para fazer uma lista das aplicações instaladas, de forma que você possa duplicar a base instalada em outro computador ou mesmo fazer uma reinstalação do sistema em sua máquina, abra um terminal:

~~~  
dpkg -l|awk '/^ii/{ print $2 }'|grep -v -e ^lib -e -dev -e $(uname -r) >/home/usuário/instalados.txt  
~~~

Então copie o arquivo 'instalados.txt' para uma pendrive ou qualquer outro dispositivo removível que você queira.

Na nova máquina, copie o arquivo para $HOME e use a lista como referência para instalar as aplicações necessárias.

##### RAM e Swap

Caso sua máquina tenha menos de 512 MB de RAM, você vai precisar de uma partição swap. O tamanho não deve ser inferior a 128 MB (cfdisk-output não é confiável, porque calcula com base 10); mais de 01 GB é desnecessário.

`Por favor, veja  [Particionando seu HD com o GParted](part-gparted-pt-br.htm) `

**`NÃO SE ESQUEÇA DE FAZER CÓPIAS (BACKUPS) DE SEUS DADOS, inclusive Favoritos e endereços de email!`**  Veja  [Back-Ups com rdiff](sys-admin-rdiff-pt-br.htm#rdiff)  e  [Back-Ups com rsync](sys-admin-rsync-pt-br.htm#rsync) . Outra opção é sbackup (precisa ser instalado).

Rodar o sistema instalado no HD é mais confortável e muito mais rápido do que rodá-lo a partir do LiveCD.

Antes de tudo, você precisa editar a BIOS de sua máquina e colocar o CD-ROM como o primeiro a dar o boot. Para isso, basta ligar o computador e pressionar a tecla [DEL] (ou Delete) enquanto ele inicia. Em seguida, usando as setas direcionais, vá em Boot > Boot Device Priority > 1st Boot Device > seu CD-ROM (existem várias versões de BIOS; talvez o menu da sua seja um pouco diferente, mas você entendeu a idéia, não? Há BIOS, como a AMI-BIOS, que permitem que o dispositivo seja escolhido na inicialização simplesmente pressionando teclas como F11 ou F8. Verifique, pode ser seu caso).

Feito isso, o siduction já deve iniciar. Se tal não acontecer, você pode lançar mão das chamadas "cheatcodes", opções que podem ser usadas na tela do gerenciador de boot. Usar parâmetros de boot (p. ex., resolução de tela ou seleção da língua) permite economizar muito tempo na fase pós-instalação.  [Veja também Cheatcodes](cheatcodes-pt-br.htm)  e  [Códigos para VGA](cheatcodes-vga-pt-br.htm) 

## Como escolher a língua de sua instalação

###### `Pacotes de linguagem são passíveis de instalação apenas com o KDE-full` 

Selecione sua língua pressionando a tecla **`F4 na tela de menu do GRUB`**  em `versões do siduction.org kde-full` , para instalar pacotes de localização do desktop e outras aplicações, enquanto o computador é iniciado. 

Isto assegura que esses elementos estarão presentes após a instalação do siduction. A quantidade de memória necessária dependerá da língua desejada e o siduction pode recusar-se a instalar os pacotes correspondentes automaticamente se a memória RAM for insuficiente. Se isso acontecer, a sequência de inicialização vai continuar em Inglês, mas com a localização (moeda, formato de data e hora, teclado) configurada para a língua que você selecionou. 1 GB de memória ou mais devem ser suficientes para todas as línguas para as quais o siduction oferece suporte. Essas línguas são:

  
Padrão - German (Alemão)  
Padrão - English (Inglês EUA)  
*Čeština (Czech)  
*Dansk (Danish)  
*Español (Espanhol)  
*English (Inglês Grã-Bretanha)  
*Français (Francês)  
*Italiano (Italiano)  
*Nihongo (Japonês)  
*Nederlands (Holandês)  
*Polski (Polish)  
*Português (Português BR e PT)  
*Română (Romeno)  
*Russian (Russo)  


O suporte para uma língua depende de sua disponibilidade entre as traduções do Manual do siduction; procure envolver-se para adicionar sua língua se ela não estiver nesta relação.

###### `Instalação de outra língua no KDE-lite` 

1. Selecione sua língua pressionando a tecla **`F4 na tela de menu do gfxboot`** . (Veja também  [Cheatcodes específicas do siduction (somente LiveCD)](cheatcodes-pt-br.htm#cheatcodes) ). Os arquivos da linguagem selecionada não estão no LiveCD, portanto o sistema vai continuar em Ingês. Entretanto, isto vai fazer a configuração correta para sua língua, o que torna desnecessária qualquer outra alteração no sistema, exceto a instalação propriamente dita dos arquivos faltantes.  
2.  Inicie a instalação.  
3. Instale no HD e reinicie.  
4. Após a instalação no HD, instale a língua de sua escolha e aplicações via 'apt-get'.  

###### Primeiro 'boot' com o HD

`Depois de dar o 'boot' (isto é, iniciar seu sistema) pela primeira vez, você vai descobrir que o siduction esqueceu as configurações de sua rede.`  A rede pode ser facilmente configurada em  [Kmenu > Internet > Ceni](inet-ceni-pt-br.htm) . Para mais informações sobre WIFI/WLAN Roaming (redes 'wireless', sem fio, pelo método 'wpa-roaming') [queira ler aqui, por favor.](inet-wpagui-pt-br.htm) 

<div class="divider" id="Installation"></div>
## O Instalador do siduction

 **1.**  O Instalador pode ser executado a partir do `ícone no Desktop (Área de Trabalho), clicando em KMenu > System (Sistema) > siduction-installer` , ou via terminal usando:

~~~  
sux  
install-gui.bash  
~~~

![siduction-Installer1](../images-pt-br/installer-pt-br/installer1-pt-br.png "Welcome tab - siduction Installer") 


---

 **2.**  Após ler (e entender) a tela de avisos, vamos escolher uma partição. 

![siduction-Installer2](../images-pt-br/installer-pt-br/installer2-pt-br.png "Partitioning tab - siduction Installer") 

Agora escolhemos onde a instalação será feita e estabelecemos os pontos de montagem. Partições para as quais não definimos pontos de montagem são montadas pelo instalador (a partição swap será montada automaticamente quando o sistema for inicializado). 

**`NOTA: Se sua partição root ('/') já estiver formatada com seu sistema de arquivos predileto, você pode desmarcar o campo "formatar com", desde que a caixa à direita reflita o sistema de arquivos de sua escolha.`** 

Todas as outras partições serão tratadas como partições `/media/` . Aqui você tem de selecionar a partição root ('/') para sua instalação do siduction. No entanto, `é neste momento que você pode criar também uma partição de dados.`  `Ao pressionar o botão esquerdo do mouse, você ativa suas opções para cada uma das partições.` 

`Você já fez backup de seus dados?`

Se seu HD ainda não estiver particionado, faça-o em `Iniciar o Gestor de Partições`  e dê uma olhada em  [Particionando seu HD com o GParted](part-gparted-pt-br.htm)  ou, se preferir usar a linha de comando, leia  [Particionando seu HD com o cfdisk](part-cfdisk-pt-br.htm) 

Você pode iniciá-los pelo terminal, também:

~~~  
sux  
gparted  
~~~

ou

~~~  
su  
cfdisk  
~~~


---

 **3.**  Como gerenciador de boot, o siduction usa o GRUB, portanto instale o  **Grub na MBR** ! Só escolha uma opção diferente aqui, se souber o que está fazendo. Você terá que editar outros gerenciadores de boot manualmente se quiser mantê-los. Do contrário, será impossível iniciar o siduction.

O Grub reconhece os outros sistemas instalados (p. ex., Windows) e adiciona-os no menu de boot. 

![grub-to-mbr](../images-pt-br/installer-pt-br/installer3-pt-br.png "Grub/Timesone tab - siduction Installer") 


---

 **4.**  Seguimos em frente, com o usuário e sua senha e também a senha para o root (lembre-se delas!). Favor não escolher senhas fáceis de descobrir. Para adicionar outros usuários, é necessário esperar o fim da instalação, abrir um terminal e digitar, como root: [adduser](hd-install-pt-br.htm#adduser) .

![choosing-pw](../images-pt-br/installer-pt-br/installer4-pt-br.png "User/Password tab - siduction Installer") 


---

 **5.**  Agora coloque o nome da Instalação no campo 'Nome da máquina' (escreva o que quiser, desde que contenha apenas letras e números e não comece com um número).

Depois disto, você pode escolher também se deseja ou não que o ssh seja iniciado automaticamente.

![hostname](../images-pt-br/installer-pt-br/installer5-pt-br.png "Network tab - siduction Installer") 


---

 **6.**  Agora você tem a derradeira oportunidade de revisar os ajustes feitos. Leia cuidadosamente e então clique `Guardar a configuração e continuar` .

![installation-config](../images-pt-br/installer-pt-br/installer6-pt-br.png "Installation tab - siduction Installer") 

Neste ponto é possível alterar/editar o arquivo de configuração e dar início à instalação. O instalador não faz nenhuma conferência e você `não pode clicar em "Retroceder", do contrário as mudanças que você fez se perderão.`  

Para editar o arquivo `~/.sidconf`  basta clicar em "Edite a configuração", MAS ISSO SÓ DEVE SER FEITO POR USUÁRIOS EXPERIENTES, que desejem escrever suas mudanças diretamente no arquivo de configuração ou que tenham um esquema de particionamento especial, que seria rejeitado pelo instalador.

**`Você será avisado pelo instalador caso esteja usando uma $HOME antiga, e não será possível prosseguir até que seja escolhido um nome de usuário diferente.`** 

![Begin Installtion](../images-pt-br/installer-pt-br/installer7-pt-br.png "Begin Installation - siduction Installer") 

Para começar a instalação, clique em `Iniciar a instalação` . Dependendo de seu sistema, todo o processo levará entre 5 e 15 minutos, com a ressalva de que, em PCs muito antigos, esse tempo pode se estender por algo em torno de 1 hora...

Não aborte a instalação se a barra de progresso parecer travar: apenas aguarde mais um pouco.

Fim! Tire o CD da bandeja, reinicie a máquina e divirta-se com seu novo sistema operacional!

<div class="divider" id="first-hd-boot"></div>
## O primeiro boot

`Carregado a sistema pela primeira vez, você vai descobrir que o siduction esqueceu sua configuração de rede! Portanto, você terá de reconfigurá-la (Wlan, Modem, ISDN,...).`

Se antes sua rede foi automaticamente detectada usando um modem roteador (DHCP), reative-a (se necessário) com:

~~~  
ceni  
~~~

As ferramentas apropriadas encontram-se em  *Kmenu > siduction > Internet > ceni* . Você pode ainda dar uma lida em:  [Internet e Rede](inet-ceni-pt-br.htm) 

Para adicionar na nova instalação uma partição $home do siduction já existente, é necessário alterar o arquivo fstab; veja  [Como mover a /home](home-pt-br.htm#home-move) .

 **`Não utilize ou compartilhe uma $home existente originária de outra distribuição, porque os arquivos de configuração $home no diretório/home entrarão em conflito caso você use o mesmo nome de usuário entre as diferentes distros.`** 

<div class="divider" id="adduser"></div>
## Como adicionar usuários

Para adicionar um `novo usuário`  com as permissões de grupo aplicadas automaticamente, digite no terminal, como root:

~~~  
adduser <nome_do_novo_usuário>  
~~~

... pressione [ENTER] e deixe o sistema lidar com toda a complexidade requerida. Observe que você terá de digitar a senha duas vezes.

Os ícones específicos do siduction (como os do Manual e do canal IRC) precisam ser adiconados manualmente..

Como deletar usuários:

~~~  
deluser <nome_do_usuário>  
~~~

Leitura indicada:

~~~  
man adduser  
man deluser  
~~~

`O programa kuser`  também cria novos usuários; no entanto, você terá de ajustar as permissões de grupo manualmente para cada um deles.

<div class="divider" id="sux"></div>
## Sobre o sux

Muitos comandos só rodam com privilégios de root. Para isso, digite:

~~~  
sux  
~~~

O comando mais comum para se tornar root é o 'su", porém ao usar `sux`  você poderá rodar aplicações GUI / X11 pela linha de comando e executar aplicações gráficas. Isto porque o `sux`  envolve o 'su', que transfere suas credenciais X para o usuário alvo.

Algumas aplicações do KDE exigem que o `dbus-launch`  seja rodado à frente delas:

~~~  
dbus-launch <aplicação>  
~~~

Um exemplo disso é rodar um editor de texto, como o KWrite ou KEdit, para alterar arquivos root, usar o GParted para particionar um HD, ou rodar o gerenciador de arquivos Konqueror. Você também pode fazer alterações em arquivos que exijam privilégios de root clicando no arquivo com o botão direito do mouse e escolhendo 'Editar como root'. Em seguida entre com a senha e comece a edição.

Diferentemente do 'sudo', isso tudo significa que não será possível a qualquer um simplesmente ir chegando e digitando 'sudo' para começar a fazer alterações potencialmente danosas ao seu sistema.

**`ATENÇÃO: enquanto estiver numa sessão como root, o sistema não irá impedi-lo de fazer coisas perigosas, como apagar arquivos importantes etc. Portanto, é necessário que você esteja absolutamente seguro do que está fazendo, porque há uma grande possibilidade de você danificar seu sistema.`**

**`Em nenhuma circunstância torne-se root para rodar aplicações que um usuário comum executa no seu dia a dia, como enviar emails, montar planilhas, navegar na Internet etc.`**

<div id="rev">Page last revised 08/01/2012 1915 UTC</div>
