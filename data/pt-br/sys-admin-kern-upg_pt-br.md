<div id="main-page"></div>
<div class="divider" id="kern-upgrade"></div>
## Como Instalar Novos Kernels

##### `Os kernels do siduction são encontrados no repositório siduction.orgo um .deb e são incluídos automaticamente no dist-upgrade.` 


---

##### `Os kernels do siduction são encontrados no repositório siduction.orgo um .deb e são incluídos automaticamente no dist-upgrade.` 


---

Os kernels estão disponíveis nos seguintes formatos:

+  **siduction-686**  - kernel para a família de processadores i686, com dual core ou não e outras CPUs  
+  **siduction-amd64**  - kernel para a plataforma de 64 bit  

##### Os passos para carregar novos kernels manualmente, isto é, sem dist-upgrade são:

 **1.**  Abra o terminal e torne-se root; depois digite:

~~~  
apt-get update  
~~~

 **2.**  Para instalar a última versão do kernel:

~~~  
apt-get install linux-image-siduction-686 linux-headers-siduction-686  
~~~

Para usar o novo kernel, é necessário reiniciar o computador

`Se ele trouxer problemas, você pode reiniciar a máquina e escolher um kernel antigo.` 

##### Módulos

Para saber de quais módulos você precisa, o comando a seguir lista os módulos disponíveis; copie-o para o terminal:

~~~  
apt-cache search 2.6.*.towo.*-siduction| awk '/modules/{print $1}'  
~~~

Copie a linha seguinte para o terminal, caso queira uma descrição completa de cada módulo:

~~~  
apt-cache search 2.6.*.towo.*-siduction  
~~~

Para instalar os módulos necessários (por exemplo, virtual-ose e qc-usb):

~~~  
apt-get install virtualbox-ose-modules-2.6.24-2.6.24.2.towo.7-siduction-686 (EXEMPLO)  
apt-get install qc-usb-modules-2.6.24-2.6.24.2.towo.7-siduction-686 (EXEMPLO)  
~~~

Para checar os módulos carregados no kernel:

~~~  
ls /sys/module/  
ou  
cat /proc/modules  
~~~

<div class="divider" id="dmakms"></div>
## Como instalar módulos com o Dynamic Module-Assistant Kernel Module Support (dmakms)

O dmakms é útil na instalação de módulos do kernel que não são preparados antecipadamente para o kernel do siduction. O dmakms destina-se a automatizar a instalação dos módulos com o module-assistant `(m-a)`  quando atualizando ou instalando novos kernels.

~~~  
apt-get install dmakms module-assistant  
~~~

Antes de ativar o Dynamic Module-Assistant Kernel Module Support, use o module-assistant para instalar o(s) módulo(s) desejado(s) para o kernel rodando atualmente. Para mais informações sobre module-assistant queira ler, por favor, sua página de manual:

~~~  
man m-a  
~~~

O nome do módulo compatível com o module-assistant precisa ser adicionado a `/etc/default/dmakms` , de forma que o processo de preparar e instalar o(s) mesmo(s) módulo(s) a cada novo kernel seja automatizado.

#### Exemplo: como instalar o `módulo speakup`  com o module-assistant

Assegure-se de ter a linha `#deb-src http://ftp.br.debian.org/debian/ sid main contrib non-free`  no seguinte arquivo: `/etc/apt/sources.list.d/debian.list`  

~~~  
apt-cache search speakup-s  
speakup-source - Source of the speakup kernel modules  
~~~

A seguir, prepare o módulo:

~~~  
m-a prepare  
m-a a-i speakup-source  
~~~

Então ative o Dynamic Module-Assistant Kernel Module Support para o speakup, de forma que, da próxima vez que o kernel for atualizado, um módulo speakup seja preparado para ele também, sem sua intervenção manual. Para isso, adicione `speakup-source`  ao arquivo de configuração `/etc/default/dmakms` .

~~~  
mcedit /etc/default/dmakms  
speakup-source  
~~~

Repita o mesmo processo para todos os outros pacotes de módulos do kernel compatíveis com o module-assistant.

Um pacote 'linux-headers' deve ser instalado para cada pacote com uma imagem do kernel correspondente, para que o module-assistant possa compilar os módulos do kernel.

#### Falha no carregamento do módulo

Se houver falha no carregamento do módulo, por qualquer motivo (um novo componente do xorg, um problema no sistema de arquivos ou uma recusa do X em reiniciar após um reboot] :

~~~  
modprobe <módulo>  
~~~

Daí, reinicie o computador.

Se ainda assim o módulo se recusar a ser carregado:

~~~  
m-a a-i -f module-source  
~~~

Isso reconstrói o módulo. `Agora reinicie.` 

##### Como funciona

O Dynamic Module-Assistant Kernel Module Support consiste de um simples initscript (/etc/init.d/dmakms) que é executado no momento do boot ou por um script disparado após a instalação de novos pacotes Debian com imagens do kernel.

A cada boot, o /etc/init.d/dmakms é rodado para descobrir se cada pacote com os fontes do módulo listado em /etc/default/dmakms providenciou um pacote com o módulo para o kernel em utilização, chamando o module-assistant para montar e instalar o módulo necessário.

Quando uma nova imagem do kernel é instalada, o arquivo /etc/init.d/dmakms é executado via um script pós-instalação com dois argumentos, 'start' e 'version string' (número da versão do kernel) para preparar um novo pacote com o módulo. Nessa hora, os pacotes de módulos listados no arquivo de configuração /etc/default/dmakms são processados com o module-assistant, e pacotes derivados são agendados para instalação no momento em que o computador for desligado. `O motivo da instalação se dar quando do desligamento da máquina é simples: é necessário atrasar a instalação de forma que o apt/dpkg não esteja bloqueado por outro processo` .

~~~  
$ /usr/share/doc/dmakms  
~~~

<!--</div>
<div class="divider" id="other-kern-inst"></div>
## Outros métodos de instalação do kernel

##### siductioncc

Você pode também instalar kernels pela interface gráfica [siductioncc](siductioncc-pt-br.htm) , que fica no KMenu > Sistema > siduction Control Centre. O siductioncc possui diversas outras aplicações gráficas referentes a administração do sistema.

-->
<div class="divider" id="kern-remove"></div>
## Como remover kernels antigos com o kernel remover

Depois de um novo kernel instalado com sucesso, os kernels antigos podem ser apagados, ainda que seja prudente ficar com pelo menos um deles por mais alguns dias, pois pode acontecer de você enfrentar imprevistos com o novo. Assim, se for preciso, basta selecioná-lo na tela do Grub.

Old kernels can be removed from the system. To do so, install `kernel-remover` :

~~~  
apt-get update  
apt-get install kernel-remover  
~~~

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
