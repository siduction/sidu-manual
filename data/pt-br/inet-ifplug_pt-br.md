<div id="main-page"></div>
<div class="divider" id="hotswitch"></div>
## Como passar de cabo para wireless e vice-versa

`Provavelmente, será necessário disponibilizar firmware não livre em uma pendrive ou outro dispositivo USB, para instalar no sistema operacional. Favor consultar  [pacotes .deb com firmware não livre em uma pendrive e afins](nf-firm-pt-br.htm#non-free-firmware)` .

A maneira mais fácil de comutar entre uma conexão com fios e uma wireless é usando o daemon ifplugd. Ele vem junto com a instalação padrão do siduction.

<div class="divider" id="interfaces"></div>
###### Ajuste seu arquivo /etc/network/interfaces

O primeiro passo é assegurar-se de que a eth0 não está configurada:

~~~  
ifdown eth0  
~~~

###### Exemplo de uma interface operativa:

A configuração é simples: a interface com fios (aqui: eth0) não deve ser precedida de qualquer configuração do tipo "allow-hotplug" ou outras:

~~~  
auto lo  
iface lo inet loopback  
# comandado pelo ifplugd ... não use allow-hotplug ou opções auto  
iface eth0 inet dhcp  
~~~

Então, reconfigure o ifplugd:

~~~  
dpkg-reconfigure ifplugd  
~~~

###### Especificações debconf para o ifplugd

Deixe interfaces estáticas livres:

![Static interfaces](../images-common/images-hotplug/ifplugd1.png "Static interfaces") 

Adicione sua interface com fios (aqui "eth0") a "hotplugged interfaces":

![Hotplugged interfaces](../images-common/images-hotplug/ifplugd2.png "Hotplugged interfaces") 

Obtenha ajuda para configurações personalizadas:

![Configuration help](../images-common/images-hotplug/ifplugd3.png "Configuration help") 

Aceite as configurações padrão; simplesmente pressione [OK]:

![Default configuration](../images-common/images-hotplug/ifplugd4.png "Default configuraton") 

Diga ao ifplugd para parar antes de suspender; ele será reiniciado automaticamente:

![Suspend behaviour](../images-common/images-hotplug/ifplugd5.png "Suspend behaviour") 

Como resultado o conteúdo do ficheiro de configuração /etc/default/ifplugd vai ser:

~~~  
INTERFACES=""  
HOTPLUG_INTERFACES="eth0"  
ARGS="-q -f -u0 -d10 -w -I"  
SUSPEND_ACTION="stop"  
~~~

Agora, seu computador está preparado para mover-se entre várias redes, inclusive sem fio. A configuração "roaming' wireless pode ser vista em  [Wifi - Configurando para wifi "roaming"com wpa](inet-setup-pt-br.htm) .

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
