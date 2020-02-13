<div id="main-page"></div>
<div class="divider" id="mon-res"></div>
## Resoluções de Tela e Monitores

#### xrandr

##### Placas com suporte

+  xserver-xorg-video-intel (desde a versão 2.0)  
+ xserver-xorg-video-nouveau ([Refer to the nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (desde a versão 6.7.192)  

O primeiro passo é digitar xrandr, para ver se há suporte. Se não houver, confira a versão do xorg e o driver utilizado.

Para mudar a resolução de sua tela principal, desde que sua placa dê suporte:

~~~  
xrandr --output VGA --mode 1440x900  
~~~

<div class="divider" id="xrandr"></div>
## Dois monitores (Dual Monitors) e xrandr

 <span class="highlight-2">xorg.conf is deprecated, if you use free drivers.</span> If you have an xorg.conf stanza under <span class= "highlight-3">/etc/X11/xorg.conf.d</span>, because you use proprietary drivers for your graphics card, you should save it now before proceeding.

xorg.conf, if present at all, is now modular, for example, each module contains everything referring a "device" for instance, the display or a mouse.

With xrandr you can configure your primary and secondary screen without restarting X, (hotplug). O xrandr substitui tanto o xinerama quanto o mergedFB. Com o xrandr 1.2 habilitado, configurar o xorg.conf à maneira antiga (xinerama e mergedFB) pode não funcionar mais.

##### Placas suportadas

+  xserver-xorg-video-intel (desde 2.0)  
+ xserver-xorg-video-nouveau ([Refer to the nouveau Feature Matrix](http://nouveau.freedesktop.org/wiki/FeatureMatrix))  
+ xserver-xorg-video-ati (desde 6.7.192)  

### Preparação de uma configuração xrandr para um PC usar dois monitores/telas

**`Nota:`**  O ideal, caso você use 2 monitores/telas no PC todo o tempo, é que seu`xorg.conf`  seja alterado para refletir este modo permanentemente.

Um laptop precisa ser configurado dinamicamente (ao contrário de um PC com dois monitores) e quando você o reinicia, será necessário refazer tudo, a não ser que você configure os dois monitores com os parâmetros usados no xrandr e copie/cole em um script no`~/.kde/Autostart/` .

Você vai precisar do xorg 7.3:

~~~  
apt-cache policy xorg  
xorg:  
Installed: 1:7.3+2  
Candidate: 1:7.3+2  
Version table:  
*** 1:7.3+2 0  
500 http://ftp.at.debian.org sid/main Packages  
100 /var/lib/dpkg/status  
~~~

...e do xrandr 1.2:

~~~  
xrandr -v  
Server reports RandR version 1.2  
~~~

#### Familiarizando-se com o xrandr

O primeiro passo é digitar xrandr no terminal, como usuário, para se familiarizar com a saída:

~~~  
xrandr  
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768  
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm  
1024x768 60.0+ 75.1 70.1 60.0 59.9  
832x624 74.6  
800x600 72.2 75.0 60.3 56.2  
640x480 75.0 72.8 66.7 60.0  
720x400 70.1  
~~~

Aqui temos apenas o VGA (veja o  [Apêndice A](hw-dev-mon-pt-br.htm#aa)  para uma explicação sobre os nomes usados). Pode-se ver também as resoluções suportadas e (o que é importante no caso de dois monitores), o tamanho máximo da tela (neste caso, 2048x768).

Agora, conecte sua tela externa e torne a rodar xrandr:

~~~  
$ xrandr  
Screen 0: minimum 320 x 200, current 2048 x 768, maximum 2048 x 768  
VGA-0 connected 1024x768+0+0 (normal left inverted right x axis y axis) 304mm x 228mm  
1024x768 60.0+ 75.1 70.1 60.0 59.9  
832x624 74.6  
800x600 72.2 75.0 60.3 56.2  
640x480 75.0 72.8 66.7 60.0  
720x400 70.1  
DVI-0 connected 1024x768+1024+0 (normal left inverted right x axis y axis) 310mm x 230mm  
1024x768_85.00 85.0+  
1024x768 85.0 + 84.9 74.9 75.1 70.1 60.0 43.5  
832x624 74.6  
800x600 84.9 72.2 75.0 60.3 56.2  
640x480 84.6 75.0 72.8 66.7 60.0  
720x400 87.8 70.1  
S-video disconnected (normal left inverted right x axis y axis)  
~~~

Veja que, além do VGA, agora uma tela DVI também está conectada, com suporte a resoluções de 720x400 a 1024x768.

###### Possibilidades de configuração

Sintaxe básica:

~~~  
xrandr --output <output> --rate <rate> --mode <mode> --left-of|--right-of|--above|--below|--same-as <output>  
~~~

Onde:

+ &lt;output&gt;: é o nome de saída (veja o  [Apêndice A](hw-dev-mon-pt-br.htm#aa))  
+ &lt;rate&gt;: é a taxa de atualização dada pela saída do xrandr (opcional)  
+ &lt;mode&gt;: é a resolução dada pela saída do xrandr (opcional)  

##### Para mudar a resolução da tela primária:

~~~  
xrandr --output VGA --mode 1024x768  
~~~

###### Clone

Como muitas telas externas/projetores não rodam em 1280x800 mas em 1024x768, tente, por exemplo:

~~~  
xrandr --output VGA --mode 1024x768 --output LVDS --mode 1024x768  
~~~

Para desligar sua tela secundária e ter a resolução normal de volta no monitor principal:

~~~  
xrandr --output VGA --off --output LVDS --mode 1280x800  
~~~

##### Múltiplas telas em desktops

Como Intel GMA &lt;=945GM/GMS perde suporte a 3D com uma tela virtual &gt;2048x2048, não é possível colocar ambas as telas lado a lado usando resoluções muito altas, mas 1024x768 funciona bem:

~~~  
xrandr --output LVDS --mode 1024x768 --output VGA --mode 1024x768 --left-of LVDS  
~~~

Para desabilitar telas múltiplas, simplesmente desabilite a tela secundária e altere a resolução da principal (caso seja necessário):

~~~  
xrandr --output VGA --off (--output LVDS --mode 1280x800)  
~~~

Outra opção é colocar a tela secundária com uma resolução abaixo ou acima da principal:

~~~  
xrandr --output LVDS --mode 1280x800 --output VGA --mode 1280x1024 --above LVDS  
~~~

O resultado é uma resolução de 1280x1824 para a tela virtual, o que é inferior a 2048x2048. Outra solução, ainda, é rotacionar a tela:

~~~  
xrandr --verbose --output LVDS --mode 1280x800 --output VGA --mode 1024x768 --rotate left --left-of LVDS  
~~~

NOTA: Isso somente funciona se você puder girar fisicamente a tela de seu monitor, também.

###### Example of a permanently configured PC with dual monitors with xrandr with code snippet in `/etc/X11/xorg.conf.d/30-screen.conf` :

~~~  
#30-screen.conf  
Section "Monitor"  
Identifier "DVI-0"  
Option "Primary" "true"  
EndSection  
Section "Monitor"  
Identifier "DVI-1"  
Option "RightOf" "DVI-0"  
EndSection  
Section "Device"  
Identifier "ATI Radeon HD 2600"  
Option "Monitor-DVI-0" "DVI-0"  
Option "Monitor-DVI-1" "DVI-1"  
EndSection  
~~~

Observações:

+  Telas virtuais estão limitadas a 2048x2048 nas placas Intel, como vimos. Ainda que seja possível obter uma resolução virtual mais alta, você perderá o suporte DRI. Parece não haver limites para placas nVidia e ATI.   
+ TV Out não funciona com ATI.  
+  se DDC não funcionar direito com ATI (Xorg.0.log: (WW) RADEON(0): DDC2/I2C is not properly initialised OU SEJA '(WW) RADEON(0): DDC2/I2C não foi inicializada corretamente'), você não conseguirá sobrepor os valores dos modelines.  
+ Ao tentar configurar um monitor desktop de muitas polegadas (para dividir em múltiplas telas) e o xrandr disser que a resolução solicitada é maior do que a que ele consegue suportar, você pode usar "Virtual" e a resolução desejada. (Veja 'Screen Section' no Apêndice A).  
+ Para quaisquer placas, exceto Intel, a resolução virtual pode ser grande o bastante para ambos os monitores. Exemplo: monitor1= 1024x768 e monitor2=1280x1024, então a tela virtual deverá ser (1024+1280)x(1024>768) -> 2304x1024.  

<div class="divider" id="aa"></div>
###### Apêndice A

###### Intel

~~~  
Nomes de saída:  
* LVDS: tela interna do laptop  
* TMDS-1: porta DVI externa  
* VGA: porta VGA externa  
* TV: saída de TV externa  
~~~

###### ATI

~~~  
Nomes de saída:  
* LVDS: tela interna do laptop  
* DVI-0: primeira porta DVI externa  
* DVI-1: segunda porta DVI externa (se houver)  
* VGA-0: primeira porta VGA externa  
* VGA-1: segunda porta VGA externa (se houver)  
* S-video  
~~~

###### Nvidia

~~~  
O driver nv dá suporte ao RandR1.2 em placas G80  
Nomes de saída:  
* LVDS: tela interna de laptops  
* DVI0: primeira porta DVI externa  
* DVI1: segunda porta DVI externa (se houver)  
~~~

###### Links

 [http://wiki.debian.org/XStrikeForce/HowToRandR12](http://wiki.debian.org/XStrikeForce/HowToRandR12) 

 [http://bgoglin.livejournal.com/9846.html](http://bgoglin.livejournal.com/9846.html) 

 [http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419](http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=420419) 

 [http://www.thinkwiki.org/wiki/Xorg_RandR_1.2](http://www.thinkwiki.org/wiki/Xorg_RandR_1.2) 

<div class="divider" id="mon-binary"></div>
## Dois monitores (usando binários)

 `Para drivers proprietários, leia a documentação do fabricante de sua placa de vídeo.` 

### nvidia

Usar o configurador do xorg para nVidia  [http://www.sorgonet.com/linux/nv-online/](http://www.sorgonet.com/linux/nv-online/)  e fazer as alterações necessárias em seus arquivos xorg.

##### ATI nativo - radeon

<!-- [http://siduction.org/index.php?name=PNphpBB2&amp;file=viewtopic&amp;p=19794#19794](http://siduction.org/index.php?name=PNphpBB2&amp;file=viewtopic&amp;p=19794#19794)  mostra alguns xorg.conf funcionando com o driver livre radeon.

-->
NOTA: Você vai necessitar das informações da configuração do segundo monitor. Para isso, desligue da tomada um dos monitores e dê a partida pelo LiveCD, o que vai gerar um arquivo xorg.conf. Copie-o e faça o mesmo com o outro monitor.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
