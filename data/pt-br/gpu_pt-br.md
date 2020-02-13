<div id="main-page"></div>
<div class="divider" id="foss-xorg"></div>
## Os drivers Xorg de código aberto para nVidia, ATI/AMD, Radeon, Intel &amp; Xorg

Drivers Xorg de código aberto para nVidia, ATI/AMD, Radeon e Intel vêm pré-instalados no siduction.

<p></p>
`Nota: os drivers livres geralmente não necessitarm do xorg.conf` .

Se você estiver usando drivers proprietários e quiser voltar para os drivers de código aberto, edite `/etc/X11/xorg.conf.d/xx-xxxx.conf`  como root. Encontre a sessão SECTION DEVICE e altere o driver para **`radeon`**  OU **`intel`**  (citamos os mais comuns apenas).

<!--
Para desativar o driver proprietãrio do Nvidia e ativar o driver livre do **`nouveau`**  dê uma olhada no wiki no artigo  []() .

-->
To revert to **`nouveau`**  from the Nvidia proprietary drivers refer to  [german siduction-wiki](http://wiki.siduction.de/index.php?title=Wie_entferne_ich_propriet%C3%A4re_nVidia-Treiber%3F)  (Sorry, at the moment we only have a german wiki, we need help to translate it. So if u want to help, please anounce it in the forum or IRC).

**`A edição do xorg.conf é totalmente por sua conta e risco.`**

Maiores informação sobre  [Intel](http://www.x.org/wiki/IntelGraphicsDriver)   [ATI/AMD](http://www.x.org/wiki/radeon)  &nbsp;  [nouveau](http://nouveau.freedesktop.org/wiki/FeatureMatrix)  &nbsp;  [X.Org](http://xorg.freedesktop.org) 

<div class="divider" id="x2d"></div>
## 2D video drivers

Os drivers da X.Org (veja xserver-xorg para uma descrição detalhada) dão suporte em 2D para as placas Riva, TNT, GeForce e Quadro da NVIDIA e Mach, Rage, Radeon e FireGL da ATI, além dos subdrivers atimisc, r128, r6xx/r7xx e radeon. Tanto Radeon quanto Intel dão suporte a aceleração 2D (xv texturizado) para reprodução de vídeo.

<div class="divider" id="ati-3d"></div>
## ATI/AMD 3D Drivers

Algumas placas ATI também dão suporte a 3D (e animações KDE) com `xserver-xorg-video-radeon` . Até o momento, o suporte atinge chipsets até r700.

Para atualizar automáticamente novos pacotes de firmwares não livres para placas de vídeo 2D e 3D:

~~~  
apt-get install firmware-linux  
~~~

Então, reinicie o computador.

<div class="divider" id="intel"></div>
## Intel 2D and 3D

Os drivers da Intel, incluídos em sua série de drivers livres, devem funcionar perfeitamente com placas de vídeo 2D e 3D.

<div class="divider" id="nvidia"></div>
## Drivers binários de código fechado para nVidia, com dmakms &amp; xorg.conf.d

`Você necessita de acrescentar <contrib non-free> no ficheiro debian.list, como exemplo veja em  [Adicionar non-free nos ficheiros das sources.list.d](nf-firm-pt-br.htm#non-free-firmware)` 

Uma lista completa e precisa de GPUs com suporte pode ser obtida no menu Products na página de downloads da  [NVIDIA Linux Graphics Driver (NVIDIA - Drivers Gráficos para Linux)](http://www.nvidia.com/object/unix.html) .

Você também pode ler  [nvnews](http://www.nvnews.net/vbulletin/showthread.php?t=122606)  para outras opções.

Certifique-se de que o directório de configuração `/etc/X11/xorg.conf.d`  para o systema existe e adicione um ficheiro chamado `20-nvidia.conf`  : 

~~~  
mkdir /etc/X11/xorg.conf.d  
touch /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

Com seu editor de textos favorito, (e.g. kwrite, kate, mousepad, mcedit,vi, vim):

~~~  
<editor> /etc/X11/xorg.conf.d/20-nvidia.conf  
~~~

agora, adicione todos os códigos abaixo ao arquivo to 20-nvidia.conf:

~~~  
##  
Section "Device"  
Identifier "Device 0"  
Driver "nvidia"  
EndSection  
# This is a trailing line, it is needed so that End Section is not the last line  
~~~

Se você tiver mais de uma placa de vídeo, será necessário descobrir o PCI e incluí-lo no arquivo 20-nvidia.conf:

~~~  
lspci | grep -i vga  
~~~

Isso deve resultar em uma sintaxe similar a esta:

~~~  
01:00.0 VGA compatible controller:  
~~~

Adicione o busid 01:00.0 como uma linha extra debaixo da linha 'Driver'; entretanto, note que a sintaxe é `PCI:x:y:z:`  com um zero sendo desprezado e com a adição dos dois pontos, assim:

~~~  
BusID "PCI:1:0:0"  
~~~

#### Installing the nvidia drivers

`NOTA: Use 'apt-cache search nvidia' e 'apt-cache show <pacote>' para descobrir o driver certo para você. There are basically 2 types of nvidia drivers, the current Debian Sid 3D drivers and the legacy Debian Sid 3D drivers.` 

##### Para os drivers 3D nVidia correntes: &ge; GeForce 6xxx :

Prepare o módulo:

~~~  
apt-get install nvidia-kernel-source nvidia-kernel-common dmakms  
~~~

Então ative o Dynamic Module-Assistant Kernel Module Support (dmakms) para nVidia, de forma que, da próxima vez que o kernel for atualizado, um módulo nVidia também será preparado para ele, sem intervenção manual. Para isso, adicione `nvidia-kernel-source`  ao arquivo de configuração `/etc/default/dmakms` :

~~~  
echo nvidia-kernel-source >> /etc/default/dmakms  
~~~

Daí:

~~~  
m-a a-i nvidia-kernel-source  
~~~

Seguido de:

~~~  
apt-get install nvidia-glx  
~~~

Reinicie seu PC para que a instalação do módulo faça efeito.

Quando o Xorg for atualizado, você vai precisar somente de reinstalar nvidia-glx:

~~~  
apt-get install --reinstall nvidia-glx  
~~~

Quando um novo driver da nVidia estiver disponível:

~~~  
m-a a-i nvidia-kernel-source  
apt-get install --reinstall nvidia-glx  
~~~

Reinicie sua máquina para que a instalação do módulo faça efeito.

#### Nomenclatura usada no Debian para os drivers legados da NVidia:

+ nvidia-kernel-legacy-71xx é para GeForce 2  
+ nvidia-kernel-legacy-96xx é para GeForce 4  
+ nvidia-kernel-legacy-173xx é para GeForce 5  

##### Exemplo para drivers 3D legados NVidia usando &le; GeForce 5xxx :

Para outros drivers legados, simplesmente substitua o número 173xx pelo número correspondente ao seu driver.

~~~  
m-a a-i nvidia-kernel-legacy-173xx-source && apt-get install nvidia-glx-legacy-173xx dmakms  
~~~

Altere o dmakms:

~~~  
echo nvidia-kernel-legacy-173xx-source >> /etc/default/dmakms  
~~~

Quando o xorg for atualizado, você vai precisar de instalar somente o nvidia-glx-legacy:

~~~  
apt-get install --reinstall nvidia-glx-legacy-173xx  
~~~

#### Falha no carregamento do módulo

Se o carregamento do módulo nVidia falhar, por um motivo ou outro (um componente novo do xorg, um problema no sistema de arquivos, uma recusa do X em iniciar):

~~~  
modprobe nvidia  
~~~

Então, reinicie o computador.

Se ainda assim o módulo não carregar:

~~~  
m-a a-i -f nvidia-kernel-source  
~~~

ou

~~~  
m-a a-i -f nvidia-kernel-legacy-173xx-source  
~~~

Com isso, o módulo é reconstruído. `Agora basta reiniciar.` 

Leia:

~~~  
$ /usr/share/doc/dmakms  
~~~

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
