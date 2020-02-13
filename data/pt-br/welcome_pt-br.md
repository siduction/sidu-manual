<div id="main-page"></div>
<!--[if lt IE 10]><div class="center warning-box data">Please Note :: Your version of Internet Explorer&#8482; is obsolete, please install  [Firefox from Mozilla Corp&#8482;](http://mozilla.com/)  for Windows&#8482;. The menu distortions you see are the result of using a legacy browser like MSIE 5 or 6.</div><![endif]-->
<div class="divider" id="welcome-gen"></div>
## Bem-vindo ao Manual do Sistema Operacional siduction 

siduction é um jogo de palavras entre sid e sedução. `sid`  é o codinome do ramo instável do Debian. A segunda palavra é a sedução, o que significa trazer debian instável para o usuários

siduction é um sistema operatório baseado no  [kernel do Linux](http://www.kernel.org/)  e no  [GNU project](http://www.gnu.org/) , com aplicações/programas do  [Debian](http://www.debian.org/)  unstable/sid que segue de muito perto os valores essenciais do  [contrato social](http://www.debian.org/social_contract)  do Debian.

Você  
não precisa aguardar novos lançamentos para ter sempre a versão mais  
atual de qualquer que seja o pacote, incluindo kernels. Uma vez  
instalados o siduction e todas as suas aplicações favoritas, tudo que  
você precisa fazer é um  [dist-upgrade](sys-admin-apt-pt-br.htm#apt-upgrade) ,  
que é uma atualização do sistema que inclui todos os softwares  
provenientes do Debian, acrescidos dos pacotes especiais do siduction.

Isto  
significa que é desnecessário reinstalar o siduction.org as novas  
versões que saem a cada 6 meses mais ou menos. Afinal, com atualizações  
diárias, semanais ou mensais, seu sistema terá sempre as versões mais  
recentes.

Vale dizer que, tendo em vista que o siduction  
usa o ramo instável do Debian e devido à própria natureza do 'Sid',  
você precisa estar preparado para usar o  [Terminal.](term-konsole-pt-br.htm) 

Com o 'jeito do siduction', você estará sempre em dia e terá o melhor que o siduction e o Debian 'sid' juntos têm a oferecer.

<div class="divider" id="how-to"></div>
## Como usar este manual

<span class="highlight-3">O  
Manual do Sistema Operacional siduction é uma referência para o  
aprendizado inicial, mas também funciona como atualizador de seus  
conhecimentos do siduction, não somente do básico, pois ele aborda  
muitos tópicos complexos, o que vai ajudá-lo enquanto administrador do  
sistema.</span>

<!--<div class="divider" id="man-read"></div>
Instalar o `siduction-manual-reader ('leitor do manual do siduction')`  para ler o manual do siduction em PCs que tenham telas muito pequenas, como os netbooks, pode trazer vários benefícios. O pacote também oferece uma função básica de busca, o que lhe permite encontrar rapidamente um arquivo que contenha a palavra pesquisada.

-->
<div class="divider" id="man-gen"></div>
##### Geral

Este  
manual está dividido em seções comuns; por exemplo, o assunto referente  
a partições pode ser encontrado em "Particionando seu HD" e tópicos  
sobre Internet/WIFI estão agrupados em "Internet e Rede". Há alguns  
tópicos não passíveis de agrupamento ou que requerem entradas  
individuais. 

Para ajuda sobre um programa/aplicação específico (chamado de `pacote` )  
que tenha vindo instalado ou que você mesmo instalou, procure tanto o  
site do fórum do pacote, como também suas FAQs ('Frequently Asked  
Questions', ou seja, Perguntas Feitas Frequentemente), manuais online e  
ajuda contida nos menus do pacote.

Vários bons programas/aplicações têm um guia de ajuda via páginas de manual, isto é, <span class="highlight-3">man pages</span>, no terminal. Você deve também verificar se a documentação existe em `/usr/share/doc/<pacote>` .

 [Por favor, arranje um tempinho para ler o Guia Rápido do siduction.](wel-quickstart-pt-br.htm#welcome-quick) 

  
Como é normal em qualquer documentação nova, podem ocorrer eventuais  
erros de gramática, de informação ou de digitação (com estes podemos  
conviver; com os outros, não). Esperamos que você encontre poucos e nos  
perdoe.

À medida que o sistema for crescendo, mais  
documentação será adicionada. Estamos certos de que ela se tornará uma  
fonte de pesquisa de imenso valor para você e desejamos agradecer-lhe  
por fazer parte do siduction.

##### Impressão do manual

Imprimir  
partes do manual como 'retrato' não permite que textos dentro de caixas  
de código sejam impressos além das margens do papel (este problema não  
existe no Manual do website, porque lá é possível rolar o que está  
dentro das caixas de código). 

Enquanto isso não é  
nenhuma dor-de-cabeça para sites em geral, acaba sendo um problema  
crítico para aquelas distribuições Linux onde uma simples linha de  
código digitada no terminal pode chegar até a 120 caracteres, o que dá  
uma largura maior que uma típica folha de papel A4 com 12 pt.

Portanto, ajuste sua impressão para `paisagem` .

##### Copyright

Todo o conteúdo é © 2006-2012 e lançado sob a  [GNU Free Documentation License](http://www.gnu.org/licenses/fdl.txt) .  
Permissão garantida para copiar, distribuir e/ou modificar este  
documento sob os termos da da GNU Free Documentation License, Version  
1.2 ou qualquer outra versão publicada mais tarde pela Free Software  
Foundation; sem Seções Invariantes, sem Textos de Capa e sem Textos de  
Contra-capa.

E&amp;OE

## Atenção

Este  
software é experimental. Use por sua conta e risco. O projeto  
siduction, seus desenvolvedores e membros da equipe não podem ser  
considerados culpados, em nenhuma circunstância, por eventuais danos a  
hardware ou software, perda de dados ou quaisquer outros danos diretos  
e indiretos resultantes do uso deste software. Se você não concorda com  
estes termos e condições, você não tem permissão para usar nem  
distribuir este software.

<div class="divider" id="table-contents"></div>
## Índice

Caso  
a barra de navegação e/ou os submenus não pareçam estar inteiramente  
corretos, favor certificar-se de que seu navegador está configurado  
para mostrar um tamanho mínimo de fonte não superior a 12, no Firefox  
(o ideal é 10). <span class="highlight-3">Usuários de netbooks talvez  
precisem de dar um 'Zoom Out' (Ctrl+-) uma ou duas vezes para  
conseguirem ver o menu principal. Outra alternativa é usar o presente  
Índice ou instalar o siduction-manual-reader</span>.

#####  [Manual do siduction](welcome-pt-br.htm#welcome-gen) 

+  [Manual do siduction](welcome-pt-br.htm#welcome-gen)   
+  [Como usar este manual](welcome-pt-br.htm#how-to)   
+  [Índice](welcome-pt-br.htm#table-contents)   
+  [Onde encontrar ajuda](help-pt-br.htm#help-gen)   
+  [IRC !paste](help-pt-br.htm#paste)   
+  [Créditos](credits-pt-br.htm#cred-team)   
+  [Guia Rápido do siduction](wel-quickstart-pt-br.htm#welcome-quick)   

#####  [Lançamentos de ISO, Espelhos e Como Queimar](cd-dl-burning-pt-br.htm#download-siduction) 

+  [ISO e requisitos do sistema](cd-content-pt-br.htm#cd-content)   
+  [Notas sobre atualização automática de versão](sys-admin-release-pt-br.htm#rolling)   
+  [Espelhos para baixar e queimar](cd-dl-burning-pt-br.htm#download-siduction)   
+  [Checando o md5](cd-dl-burning-pt-br.htm#md5)   
+  [Queimando no Windows](cd-dl-burning-pt-br.htm#burn-nero)   
+  [Queimando no Linux](cd-dl-burning-pt-br.htm#burn-linux)   
+  [Script burniso](cd-no-gui-burn-pt-br.htm#burning-no-gui)   
+  [Queimando sem interface gráfica](cd-no-gui-burn-pt-br.htm#burn-no-gui-gen)   

#####  [Modo Live](live-mode-pt-br.htm#rootpw) 

+  [Senha de root no siduction-Live ISO](live-mode-pt-br.htm#rootpw)   
+  [Instalando software no modo siduction-Live ISO](live-mode-pt-br.htm#live-cd-installsoft)   
+  [Escrevendo em partições NTFS com o ntfs-3g](live-mode-pt-br.htm#ntfs-3g)   

#####  [O Terminal/Konsole](term-konsole-pt-br.htm#sux) 

+  [sux](term-konsole-pt-br.htm#sux)   
+  [Terminal/Konsole](term-konsole-pt-br.htm#term-kon)   
+  [Ajuda para a linha de comando](term-konsole-pt-br.htm#cli-help)   
+  [Ferramentas a conhecer no modo texto (tty) - init 3](help-pt-br.htm#init3-tools)   
+  [Lista de comandos do terminal](term-konsole-pt-br.htm#term-cmds)   
+  [Instalando scripts .sh](term-konsole-pt-br.htm#shell-scripts)   

#####  [CheatCodes](cheatcodes-pt-br.htm#cheatcodes) 

+  [Cheatcodes específicas do siduction-Live ISO](cheatcodes-pt-br.htm#cheatcodes)   
+  [Cheatcodes para o Linux em geral](cheatcodes-pt-br.htm#cheatcodes-linux)   
+  [Códigos para VGA](cheatcodes-vga-pt-br.htm#vga)   

#####  [Particionando seu HD](part-gparted-pt-br.htm#partition) 

+  [Particionando seu HD com o GParted/KDE Partition Manager](part-gparted-pt-br.htm#partition)   
+  [Redimensionando a partição NTFS com o GParted/KDE Partition Manager](part-gparted-pt-br.htm#ntfs)   
+  [UUID, nomeando partições e a fstab](part-uuid-pt-br.htm#uuid)   
+  [Como formatar após o particionamento com o gdisk](part-gdisk-pt-br.htm#gdisk-6)   
+  [Particionamento GPT do HD com o gdisk](part-gdisk-pt-br.htm#gdisk-1)   
+  [Nomes dos discos: uma breve explicação](part-cfdisk-pt-br.htm#disknames)   
+  [Particionando seu HD com o cfdisk](part-cfdisk-pt-br.htm#partition)   
+  [Formatando com o cfdisk, após particionamento](part-cfdisk-pt-br.htm#formating)   
+  [Exemplos de tamanhos de partições](part-size-examp-pt-br.htm#part-example)   

#####  [Opções de Instalação](hd-install-pt-br.htm#Inst-prep) 

+  [Preparando a instalação](hd-install-pt-br.htm#Inst-prep)   
+  [Instalando no HD](hd-install-pt-br.htm#Installation)   
+  [Primeira inicialização](hd-install-pt-br.htm#first-hd-boot)   
+  [Inicializando com 'fromiso'](hd-install-opts-pt-br.htm#fromiso)   
+  [Fromiso e Persist](hd-install-opts-pt-br.htm#fromiso-persist)   
+  [Instalando em HD-USB - siduction-on-stick](hd-install-opts-pt-br.htm#usb-hd)   
+  [Writing siduction to a USB/SSD stick with any Linux, MS Windows or Mac OS X system](hd-ins-opts-oos-pt-br.htm#raw-usb)   
+  [Dando o boot do siduction através de uma rede](nbdboot-pt-br.htm#nbd1)   
+  [Virtual Machine installation options](hd-install-vmopts-pt-br.htm#vm)   

#####  [Placas de Vídeo, Dispositivos Diversos e Drivers &amp; xorg.conf](gpu-pt-br.htm) 

+  [Resolução de tela e monitores](hw-dev-mon-pt-br.htm#mon-res)   
+  [Dois monitores e xrandr](hw-dev-mon-pt-br.htm#xrandr)   
+  [Dois monitores (usando binários)](hw-dev-mon-pt-br.htm#mon-binary)   
+  [AMD/ATI 3D drivers](gpu-pt-br.htm#ati-3d)   
+  [Intel 2D and 3D drivers](gpu-pt-br.htm#intel)   
+  [Nvidia 3D drivers](gpu-pt-br.htm#nvidia)   
+  [Open Source Xorg drivers](gpu-pt-br.htm#foss-xorg)   
+  [Firmware detection - non-free](nf-firm-pt-br.htm#fw-detect)   
+  [Adding non-free to Sources List](nf-firm-pt-br.htm#non-free-firmware)   

#####  [Gerenciadores de Janelas](wm-dm-pt-br.htm#desk-freeze) 

+  [Extras úteis para o XFCE](wm-dm-pt-br.htm#xfce-notes)   
+  [Extras úteis para o KDE](wm-dm-pt-br.htm#install-add)   
+  [Travamentos do desktop](wm-dm-pt-br.htm#desk-freeze)   
+  [Não consigo entrar no KDE](wm-dm-pt-br.htm#kde-login)   
+  [Mudando temas](wm-dm-pt-br.htm#ch-th)   

#####  [LAMP no siduction](lamp-apache-pt-br.htm#serv-apache) 

+  [LAMP no siduction](lamp-apache-pt-br.htm#serv-apache)   
+  [Clientes FTP](lamp-apache-pt-br.htm#serv-ftp)   
+  [Protocolos de segurança](lamp-apache-pt-br.htm#serv-sec)   
+  [SSL](lamp-apache-pt-br.htm#serv-ssl)   
+  [Configuração do MySQL](lamp-sql-pt-br.htm#serv-mysql)   
+  [PHP no Apache](lamp-php-pt-br.htm#serv-php)   
+  [Configuração do serviço NTP](ntp-server-pt-br.htm#ntp-server)   

#####  [Internet e Rede](inet-ceni-pt-br.htm#netcardconfig) 

+  [Tor](tor-privoxy-pt-br.htm#tor)   
+  [Privoxy](tor-privoxy-pt-br.htm#privoxy)   
+  [Firewalls](inet-ceni-pt-br.htm#firewalls)   
+  [Configurando o SAMBA (Windows)](samba-pt-br.htm#configure)   
+  [siduction.orgo servidor Samba](samba-pt-br.htm#setup)   
+  [Montagem remota do SSH](ssh-pt-br.htm#ssh-fs)   
+  [Aplicações X via SSH](ssh-pt-br.htm#ssh-x)   
+  [SSH com o Konqueror](ssh-pt-br.htm#ssh-f)   
+  [Acesso remoto SSH a partir do Windows](ssh-pt-br.htm#ssh-w)   
+  [SSH e segurança](ssh-pt-br.htm#ssh)   
+  [Modems discados](inet-ceni-pt-br.htm#dial-mod)   
+  [WiFi - WPA_GUI](inet-wpagui-pt-br.htm#wpa-roaming-gui)   
+  [WiFi - Setting up for WiFi Roaming](inet-setup-pt-br.htm#net-set1)   
+  [WiFi - wpasupplicant](inet-wpa-pt-br.htm#wpa)   
+  [Network switching between WiFi and Cable](inet-ifplug-pt-br.htm#hotswitch)   
+  [Configurando a rede - Ceni](inet-ceni-pt-br.htm#netcardconfig)   

#####  [Dist-upgrade e Gerenciamento de Pacotes](sys-admin-apt-pt-br.htm#apt-cook) 

+  [Guia do APT e a sources list](sys-admin-apt-pt-br.htm#apt-cook)   
+  [Instalando um novo pacote](sys-admin-apt-pt-br.htm#apt-install)   
+  [Apagando um pacote](sys-admin-apt-pt-br.htm#apt-delete)   
+  [Rebaixando um pacote](sys-admin-apt-pt-br.htm#apt-downgrade)   
+  [Procurando pacotes com o apt-cache](sys-admin-apt-pt-br.htm#apt-cache)   
+  [Procurando pacotes no modo gráfico](sys-admin-apt-pt-br.htm#gui-pacsea)   
+  [Atualizando pelo Live- ISO](sys-admin-upgrade-pt-br.htm#live-cd-upgrade)   
+  [dist-upgrade of multiple PCs on a LAN](sys-admin-apt-locarmirr-pt-br.htm#approx)   
+  [Atualizando o kernel](sys-admin-kern-upg-pt-br.htm#kern-upgrade)   
+  [Atualizando todo o sistema (dist-upgrade) - visão geral](sys-admin-apt-pt-br.htm#apt-upgrade)   
+  [Atualizando todo o sistema (dist-upgrade) - os passos](sys-admin-apt-pt-br.htm#du-st)   

#####  [Administração do Sistema](sys-admin-gen-pt-br.htm#start-services) 

+  [Adicionando um novo usuário](hd-install-pt-br.htm#adduser)   
+  [Movendo a /home](home-pt-br.htm#home-bu)   
+  [Backups com o rdiff](sys-admin-rdiff-pt-br.htm#rdiff)   
+  [Backups com o rsync](sys-admin-rsync-pt-br.htm#rsync)   
+  [Antivírus e caçadores de rootkits](vir-rkits-pt-br.htm#virus-rkits)   
+  [Habilitando/desabilitando serviços](sys-admin-gen-pt-br.htm#start-services)   
+  [Perda de senhas root](sys-admin-gen-pt-br.htm#pw-lost)   
+  [Fontes](sys-admin-gen-pt-br.htm#fonts)   
+  [CUPS - sistema de impressão](sys-admin-gen-pt-br.htm#cups)   
+  [Misturadores de som](sys-admin-gen-pt-br.htm#sound)   
+  [Runlevels no siduction - init](sys-admin-gen-pt-br.htm#init)   
+  [Atualizando a BIOS com FreeDOS](bios-freedos-pt-br.htm#bois-prep)   
+  [Grub2 - sobrescrição da MBR](sys-admin-grub2-pt-br.htm#chroot)   
+  [Grub2 - boots duplos e múltiplos](sys-admin-grub2-pt-br.htm#multi-os)   
+  [Grub2 - atualizando a partir do Grub1](sys-admin-grub2-pt-br.htm#grub1-grub2)   
+  [Grub2 - visão geral](sys-admin-grub2-pt-br.htm#grub2)   

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
