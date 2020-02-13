<div id="main-page"></div>
<div class="divider" id="netcardconfig"></div>
## Como Configurar a Rede - Conexão com a Internet - Ceni

`Provavelmente, você vai precisar de firmware não livre disponível em uma pendrive ou outro dispositivo USB para instalar no sistema operacional. Favor consultar  [pacotes .deb de firmware não livre em uma pendrive](nf-firm-pt-br.htm#non-free-firmware) .` 

Se você tiver um servidor DHCP ligado a seu computador, a configuração de sua rede deverá ser feita automaticamente. Se não for este o caso, você precisa rodar o programa `Ceni` . Clique `Kmenu>Internet>Ceni` . Com isso, será aberto um terminal. Digite sua senha root (se estiver usando o LiveCD, não há nenhuma):

A maneira mais rápida de rodar o Ceni é abrir um terminal e digitar:

~~~  
ceni  
~~~

Ao abrir, ele pedirá sua senha root.

![Ceni Network Interfaces](../images-common/images-netcard/Ceni-interface-selection-01.png "Ceni Network Interfaces") 

![Ceni Network Settings](../images-common/images-netcard/Ceni-static-network-configuration-02.png "Ceni Network Settings") 


---

`Wireless - um dos pontos fortes do Ceni é sua incrível capacidade de configurar placas sem fio.  [WiFi - guia básico de configuração](inet-wpa-pt-br.htm#wpa-basic) :`

![Ceni Wireless Settings](../images-common/images-netcard/Ceni-wireless-network-selection-02.png "Ceni Wireless Settings") 

![Scan or Roam](../images-common/images-netcard/Ceni-wireless-network-configuration-01.png "Ceni Scan or Roam") 

<div class="divider" id="dial-mod"></div>
## Conexões discadas com modems 56k

O KDE tem um programa para conexões discadas, chamado `KPPP Internet Dial-up Tool` , encontrado em KMenu>Internet.

Este aplicativo possui um manual interno, com um guia completo de como configurar seu modem para torná-lo capaz de conectar-se com a Internet. 

<div class="divider" id="firewalls"></div>
## Firewalls

Em geral, firewalls são desnecessários se você usa um modem roteador configurado corretamente, porém desempenham um papel muito importante se você se conecta via ADSL com modem USB ou via conexão discada. Portanto, instale:

~~~  
apt-get install guarddog  
OU  
apt-get install firestarter  
~~~

  [O Guarddog é um firewall gráfico para o KDE, simples e fácil de configurar. A melhor maneira de começar é lendo os pequenos tutoriais, começando pelo primeiro.](http://www.simonzone.com/software/guarddog/manual2/) 

 [O Firestarter é outro firewall gráfico para o Linux, igualmente fácil de configurar, geralmente o preferido pelos usuários do Gnome (o que não impede que seja usado no siduction). Uma observação: você pode fechar a interface gráfica sem medo, pois o firewall continuará ativo.]](http://www.fs-security.com/) 

<div id="rev"> Content last revised 13/01/2012 2330 UTC</div>
