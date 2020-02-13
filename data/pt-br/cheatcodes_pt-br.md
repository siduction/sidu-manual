<div id="main-page"></div>
<div class="divider" id="cheatcodes"></div>
## "Cheatcodes"

 Se os valores possíveis estão listados na coluna "Valor" da tabela abaixo, eles devem ser adicionados ao "cheatcode" com o sinal **`=`** . Por exemplo, se 1280x1024 for o valor desejado para o "cheatcode" referente à resolução de tela, então você deve digitar: `screen=1280x1024`  na tela inicial do grub; para idioma, `lang=pt` , (ou en, fr etc).

 [Listagem completa de códigos de inicialização do kernel](http://www.kernel.org/pub/linux/kernel/people/gregkh/lkn/lkn_pdf/ch09.pdf) 

<div class="divider" id="cheatcodes-siduction"></div>
## Cheatcodes específicas do siduction (somente LiveCD)

| Cheatcode | Valor | Descrição | 
| ---- | ---- | ---- |
|  **blacklist**  | nome do módulo | desabilitar módulos temporariamente, antes de udev | 
|  **desktop**  | kde | escolher seu ambiente gráfico | 
|  | fluxbox |  | 
|  **fromiso**  |  |  [veja o tópico Como inicializar com "fromiso"](hd-install-opts-pt-br.htm)  | 
|  **hostname**  | meu host | hostname, mudar o hostname do LiveCD | 
|  **lang**  |  be, bg, cz, da, de, de_CH, el, en, en_AU, en_GB, en_IE, es, fr, fr_BE, ga, hr, hu, it, ja, nl, nl_BE, pl, pt (pt_BR), pt_PT, ro, ru, zh | ativar sua língua, bem como localização, teclado (console e X), fuso horário e espelho Debian. Quando a forma expandida `lang=ll_cc`  ou `lang=ll-cc`  é dada, `ll`  será usado para a seleção da língua e `cc`  para teclado, espelho e fuso horário (p. ex. `lang=fr-be` ). Os padrões para a língua inglesa são 'en_US' com fuso horário UTC e para a língua alemã, 'de' com fuso horário Europe/Berlin. Exemplo: `lang=pt_PT tz=Pacific/Auckland`  | 
|  **md5sum**  |  | testar integridade da mídia | 
|  **noaptlang**  |  | Desativar a instalação de pacotes localizados baseado na lingua selecionada | 
|  **nodhcp**  |  | desativar o uso automático do dhcp - Dynamic Host Configuration Protocol (tenta configurar a conexão de sua placa de rede) | 
|  **noeject**  |  | não pedir a ejeção do CD ao reiniciar/desligar a máquina | 
|  **nofstab**  |  | não criar um novo fstab | 
|  **nointro**  |  | saltar a exibição do index.html ao iniciar o LiveCD | 
|  **nocpufreq**  |  | não ativar Speedstep/Powernow | 
|  **nonetwork**  |  | desabilitar a configuração automática dos dispositivos de rede durante o boot | 
|  **noswap**  |  | não ativar a partição do swap | 
|  **persist**  |  |  [veja fromiso e persist](hd-install-opts-pt-br.htm#fromiso-persist)  | 
|  **smouse**  |  | procurar mouse serial com hwinfo | 
|  **tz**  | tz=Europe/Dublin | estabelecer o fuso horário. Se o relógio de sua BIOS estiver configurado para UTC, use `utc=yes` . A list of all timezones supported can be found by copying and pasting into your browser: `file:///usr/share/zoneinfo/`  . | 
|  **toram**  |  | copiar o CDxrandr para a memória RAM e rodar a partir dela | 


---

###### Cheatcodes relacionadas com o X

Tanto a cheatcode xrandr quanto a xmodule pode ser usada também, se você estiver rodando cheatcodes relacionadas com o X em placas de vídeo Radeon, Intel ou MGA.

| Cheatcode | Valor | Descrição | 
| ---- | ---- | ---- |
|  **dpi**  | auto ou XX | estabelecer a quantidade desejada de Pontos Por Polegada (sigla 'DPI' em Inglês) do monitor. Você pode configurar o DPI dividindo a largura em pixels pela diagonal em polegadas e multiplicando o resultado por 1.25 para uma tela 4:3, 1.18 para tela 16:10 ou 1.147 para telas 16:9. Para uma tela de 24", com resolução de 1920x1080, deve-se fazer a seguinte conta: 1.147*1920/24, o que dá um DPI=92; agora, se a tela for de 15" e a resolução 1600x1200, a conta a ser feita é 1.25*1600/15, resultando em um DPI=133. | 
|  **hsync**  | 80 (p.ex.) | taxa de atualização horizontal do monitor (kHz) | 
|  **noml**  |  | evitar que a configuração do X.org contenha uma lista de 'Modelines' e causar a autodetecção do Modo correto | 
|  **noxrandr**  |  | desativar uso das extensões RandR 1.2 por novos drivers do X.org e usar técnicas precisas para monitores legacy | 
|  **screen**  | 800x600 (p.ex.) | configurar a resolução do monitor, isto é, 1024x768, 1600x1200 etc | 
|  **vsync**  | 60 (p.ex.) | taxa de atualização vertical do monitor (Hz) | 
|  **xdepth**  | 8 15 16 24 | profundidade de cores padrão a ser usada pelo X.org | 
|  **keytable**  | br, us, d (p.ex.) | leiaute de teclado a ser usado pelo X.org | 
|  **xkbmodel**  | pc105 (p.ex.) | modelo de teclado a ser usado pelo X.org | 
|  **xkboptions**  | (p. ex.) grp:alt_shift_toggle | variante de teclado para uso do X.org | 
|  **xkbvariant**  | (p. ex.) nodeadkeys,  | especificar uma variante de teclado | 
|  **xmode**  | 800x600 (p.ex.) | configurar sua resolução de tela: 1024x768, 1600x1200 etc | 
|  **xmodule**  ou  **xdriver**  | ati, fbdev, i810, intel, mga, nv, radeon, savage, vesa | usar o módulo do X especificado | 
|  **xrandr**  |  | forçar X.org a usar as extensões do RandR 1.2 nos novos drivers do X.org | 
|  **xrate**  | XX | forçar taxa de atualização preferencial da tela dos drivers X.org que suportam RandR 1.2; deve ser usada juntamente com a "cheatcode" xmode.  [Veja a documentação detalhada aqui](http://wiki.debian.org/XStrikeForce/HowToRandR12)  | 
|  **xhrefresh**  | 80 (p.ex.) | taxa de atualização horizontal do monitor no X (kHz) | 
|  **xvrefresh**  | 60 (p.ex.) | taxa de atualização vertical do monitor no X (Hz) | 


---

<div class="divider" id="cheatcodes-linux"></div>
## Cheatcodes com parâmetros comuns para o kernel do Linux

| Cheatcode | Valor | Descrição | 
| ---- | ---- | ---- |
|  **apm**  | off | desligar energia | 
|  **1, 2, 3, 4, 5**  |  (p.ex.) 3  |  **init runlevel**  números que podem ser colocados manualmente na linha de inicialização do GRUB  [runlevels no siduction - init](sys-admin-gen-pt-br.htm#init)  | 
|  **irqpoll**  |  | usar IRQ poll | 
|  **mem**  | (p.ex.) 128M, 1G | total de memória RAM a ser usada | 
|  **noacpi**  |  | desativar acpi- Advanced Configuration and Power Interface (ACPI) | 
|  **noagp**  |  | desativar agp | 
|  **nodma**  |  | desativar dma - Direct Memory Access para seus discos | 
|  **noisapnpbios**  |  | desativar ISA Plug'n'Play | 
|  **nomce**  |  | desativar checagem da máquina | 
|  **nosmp**  |  | desativar suporte a smp - Symetric Multi Processor | 
|  **pci**  | noacpi | não usar ACPI para rotear interrupções PCI | 
|  **quiet**  |  | não mostrar tudo no terminal | 
|  **vga**  | normal | ajustar VGA; os códigos correspondentes estão aqui:  [códigos para VGA](cheatcodes-vga-pt-br.htm#vga)  | 
|  **video**  | (p. ex.) DVI-0:800x600  ou  800x600 | Para placas com habilitação KMS. Aplica-se a placas Intel e ATI (o driver Radeon), onde DVI-X/LVDS-X é a saída de vídeo conforme mostrada pelo xrandr. | 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
