<div id="main-page"></div>
<div class="divider" id="vmopts"></div>
## Opções de instalação de Máquina Virtual (VM)

+  [KVM com Intel VT ou AMD-V](hd-install-vmopts-pt-br.htm#kvm)   
+  [Virtualbox](hd-install-vmopts-pt-br.htm#vbox)   
+  [QEMU](hd-install-vmopts-pt-br.htm#qemu)   
+  [instalar uma outra distribuiçâo numa VM](hd-install-vmopts-pt-br.htm#oos)   

`Os exemplos seguintes utilizam siduction para a instalação. Simplesmente substitua siduction pela distribuição que você deseja experimentar.` 

<div class="divider" id="oos"></div>
## Installing other distributions to a VM image

Nota: a maior parte das distribuições do Linux vão precisar de pouco espaço no seu disco. Como o disco efetivamente usado depende únicamente da instalação que fizer, nós recomendamos reservar 12GB para Linux e 30GB para o MS Windows.. 

<div class="divider" id="kvm"></div>
## Como ativar uma VM usando KVM (VM basead no kernel do Linux)

KVM é uma solução de virtualização para Linux utilizando hardware x86 que possua extensões de virtualização (Intel VT ou AMD-V).

### Pré-requisitos

Para verificar se seu hardware suporta KVM, certifique-se que a virtualização não está desativada na BIOS - o lugar para a ativar/desativar não é evidente e pode estar escondido, por isso consulte o seu Manual da BIOS. A maneira de verificar se está ativada, é executando numa consola os comandos seguintes:

~~~  
cat /proc/cpuinfo | egrep --color=always 'vmx|svm'  
~~~

Se você vir `svm`  ou `vmx`  então o seu sistema suporta o KVM. (se isso não acontecer e você está seguro de que deveria suportar, então controle novamente a sua configuração da BIOS, consulte o manual da mesma ou procure na Net aonde essa opção está "escondida").

Se o seu sistema não suporta a virtualização KVM o melhor será utilizar  [Virtualbox](hd-install-vmopts-pt-br.htm#vbox)   
ou  [QEMU](hd-install-vmopts-pt-br.htm#qemu) 

Para utilizar KVM, assegure-se que os módulos da "Virtualbox" não estão carregados, (o melhor é desinstalá-los com a opção "--purge" ). Depois instale o respetivo pacote tudo dependendo do chip que possui:

Para (Intel) `vmx` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-intel  
~~~

Para (AMD) `svm` :

~~~  
apt-get install qemu-kvm qemu-utils  
modprobe kvm-amd  
~~~

Quando reiniciar o sistema os scripts de inicialização do qemu-kvm tomarão conta de carregar os módulos necessários.

#### Utilizar KVM para lançar um iso do siduction

**`Como utilizador normal:`** 

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom <siduction.iso>  
~~~

##### Como instalar o siduction numa imagem de KVM

Primeiro é necessário criar uma imagem de disco, (o espaço ocupado por esta imagem é inicialmente minimo e aumentará únicamente quando necessário):

~~~  
$ qemu-img create -f qcow2 siduction-VM.img 12G  
~~~

Utilize os parâmetros seguintes para lançar o iso e para tornar o disco acessível à VM.:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -cdrom </path/to/siduction.iso> -boot d </path/to/siduction-VM.img>  
~~~

Depois da inicialização do sistema estar completada clique no icon do programa de instalação do siduction para o lançar ( ou utilize o menu), vá ao Particionamento e á sua esquerda terá uma caixa que deve ter um disco pronto para o particionamento e formatar, muito provávelmente `/dev/sda` . Escolha gparted ou partitionmanager. Tome atenção que o partionmanager tem um layout um pouco diferente do gparted, que vamos utilzar neste exemplo.

![gparted kvm particionando o disco](../images-common/images-vm/kvm-gparted02.png "gparted kvm particionando o disco") 


---

A sua VM está pronta a ser utilizada:

~~~  
$ kvm -net nic,model=virtio -net user -soundhw ac97 -m 512 -monitor stdio -drive if=virtio,boot=on,file=<path/to/siduction-VM.img>    
~~~
  
Nota: alguns guest sistemas não têm suporte de virtio (não é o caso do siduction) então o comando do kvm vai necessitar de outros parâmetros:

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda <your_guest.img> -cdrom your_other.iso -boot d  
~~~

ou

~~~  
$ kvm -net nic, -net user -soundhw ac97 -m 512 -monitor stdio -hda </path/to/your_guest.img>  
~~~

Leitura altamente recomendada:  [Documentação do KVM](http://www.linux-kvm.org/page/Main_Page) .

##### Administração das suas máquinas virtuais de KVM

A administração das máquinas virtuais do KVM poderá ser feita por intermédio do "aqemu" que terá que ser instalado.

~~~  
apt-get install aqemu  
~~~

Tenha o cuidado de escolher o modo KVM como 'Emulator Typo' na página de preferências 'General' (A documentação do AQEMU é minima, pelo que serão necessárias algumas tentativas para o uso correto. Um bom ponto de partida é começar a pelas páginas menu "VM" e depois "General").

<div class="divider" id="vbox"></div>
## Booting and installing to a VirtualBox Virtual Machine

Passos:

+ 1. crie uma imagem do HD para VirtualBox  
+ 2. dê o boot em ISOs com VirtualBox  
+ 3. instale a imagem  

#### Requisitos:

`RAM recomendada: 1 GB` ; idealmente, 512 MB para o guest e 512 MB para o host (pode ser rodado com menos memória, porém não espere bom desempenho).

`Espaço no HD:`  Enquanto o VirtualBox em si é magro (uma instalação típica ocupa apenas 30 MB de espaço), as máquinas virtuais necessitarão de grandes arquivos no disco para representar seus próprios HDs. Assim, para instalar o MS Windows XP (TM), por exemplo, você vai precisar de um arquivo que facilmente crescerá por diversos GB em tamanho. Para não se apertar, vai ser preciso que você aloque uma imagem de 5 GB e mais a swap.

### Instalação:

~~~  
apt-get update  
apt-get install virtualbox-ose-qt virtualbox-source dmakms module-assistant  
~~~

Então prepare o módulo:

~~~  
m-a prepare  
m-a a-i virtualbox-source  
~~~

Daí ative o Dynamic Module-Assistant Kernel Module Support (dmakms) para o Virtualbox, de forma que, na próxima vez que o kernel for atualizado, um módulo do Virtualbox também seja preparado para ele, sem intervenção manual. Para fazer isso, adicione `virtualbox-source`  ao arquivo de configuração `/etc/default/dmakms` .

~~~  
mcedit /etc/default/dmakms  
virtualbox-source  
~~~

Em seguida, reinicie sua máquina.

 [Leitura essencial sobre o dmakms](sys-admin-kern-upg-pt-br.htm#dmakms) 

### Como instalar o siduction na máquina virtual

Use o assistente do virtualbox para criar uma nova máquina virtual para o siduction, depois é só seguir as instruções de uma instalação normal.

 [O VirtualBox tem uma boa Ajuda em PDF, que você pode baixar aqui.](http://www.virtualbox.org/)  

<div class="divider" id="qemu"></div>
## >Booting and installing a QEMU Virtual Machine

+ 1. crie uma imagem do HD para o qemu  
+ 2. dê o boot da iso pelo qemu  
+ 3. instale a imagem  

Existe uma interface gráfica em QT para ajudá-lo a fazer a configuração:

~~~  
apt-get install qtemu  
~~~

#### Como criar a imagem do HD

Para rodar o QEMU, você provavelmente irá precisar de uma imagem do HD. Trata-se de um arquivo que armazena o conteúdo do HD emulado.

Use este comando:

~~~  
qemu-img create -f qcow siduction.qcow 3G  
~~~

Isso cria o arquivo de imagem "siduction.qcow". O parâmetro "3G" especifica o tamanho do disco - no caso, 3 GB. Você pode usar o sufixo M para megabytes (por exemplo, "256M"). Não se preocupe muito com o tamanho do disco - o formato qcow comprime a imagem, de forma que o espaço vago não é adicionado ao tamanho do arquivo.

#### Como instalar o sistema operacional

Esta é a primeira vez que você vai precisar de abrir o emulador. `Atenção: quando você clica dentro da janela do qemu, o ponteiro do mouse fica preso. Para soltá-lo, pressione:` 

~~~  
Ctrl+Alt  
~~~

Se for preciso dar o boot a partir de um disquete, rode o Qemu com:

~~~  
qemu -floppy siduction.iso -net nic -net user -m 512 -boot d siduction.qcow  
~~~

...e se for a partir de um CD:

~~~  
qemu -cdrom siduction.iso -net nic -net user -m 512 -boot d siduction.qcow  
~~~

 Agora instale o siduction.orgo se fosse em um HD de verdade.

#### Como rodar o sistema

Para rodar o sistema, digite:

~~~  
qemu [hd_image]  
~~~

Uma boa ideia é usar imagens sobrepostas. Dessa forma, você pode criar a imagem do HD uma vez e dizer ao qemu para armazenar as mudanças em um arquivo externo. Você se livra de toda possível instabilidade, porque é facílimo reverter o sistema para o estado original.

Para criar uma imagem sobreposta ("overlay"), digite:

~~~  
qemu-img create -b [[base''image]] -f qcow [[overlay''image]]  
~~~

Isso substitui a imagem do HD para base_image (no caso, siduction.qcow). Depois, é só rodar o qemu assim:

~~~  
qemu [overlay_image]  
~~~

A imagem original permanece intocada. Um probleminha: a imagem base não poderá ser renomeada ou movida. A sobreposição (overlay) lembra o caminho completo da base.

#### Como usar qualquer partição real como a partição primária de uma imagem do HD

Pode acontecer de você desejar usar uma de suas partições de dentro do qemu (por exemplo, dar o boot tanto em sua máquina real quanto no qemu, usando uma partição como root). Isso pode ser feito utilizando software RAID no modo linear (é necessário o driver linear.ko) e um dispositivo loopback: o truque é preceder dinamicamente uma MBR à partição real que você deseja embutir em uma imagem de HD bruta (raw) no qemu.

Suponha que você tenha uma partição desmontada /dev/sdaN com alguns arquivos do sistema que você deseja que façam parte de uma imagem de HD do qemu. Primeiro, crie um pequeno arquivo para guardar a MBR:

~~~  
dd if=/dev/zero of=/caminho/para/mbr count=32  
~~~

Com isso, um arquivo de 16 KB (32 * 512 bytes) é criado. É importante não fazê-lo muito pequeno (ainda que a MBR precise de apenas um bloco de 512 bytes), pois quanto menor ele for, menor terá de ser o tamanho do software RAID, o que pode impactar no desempenho. Agora, você configura um dispositivo loopback para a MBR:

~~~  
losetup -f /caminho/para/mbr  
~~~

Assumamos que o dispositivo resultante seja /dev/loop0, pois até agora não usamos nenhum outro loopback. O próximo passo é criar a imagem do HD resultante da fusão MBR + /dev/sdaN usando software RAID:

~~~  
modprobe linear  
mdadm --build --verbose /dev/md0 --chunk=16 --level=linear --raid-devices=2 /dev/loop0 /dev/sdaN  
~~~

O /dev/md0 resultante é o que você usará como imagem bruta do disco no qemu (não se esqueça de ajustar as permissões para que o emulador possa acessá-la). O último passo é fixar a configuração do disco (geometria do disco e tabela de partições) de forma que o ponto inicial da partição primária na MBR seja igual ao do /dev/sdaN dentro de /dev/md0 (exatamente 16 * 512 = 16384 bytes neste exemplo). Para isso, use o fdisk na máquina hospedeira, não no emulador: a rotina padrão de detecção de imagem bruta (raw) do qemu muitas vezes dá resultados não arredondáveis em kilobytes (como 31.5 KB na seção anterior), impossíveis de serem gerenciados pelo código do RAID. Portanto, no hospedeiro:

~~~  
fdisk /dev/md0  
~~~

Lá, crie uma partição primária correspondente a /dev/sdaN e experimente com o comando 's'ector no menu 'x'pert até que o primeiro cilindro (onde está a primeira partição) tenha tamanho igual ao da MBR. Finalmente, use 'w'rite para escrever o resultado no arquivo e... acabou! Agora você tem uma partição que pode ser montada direto da máquina hospedeira e que também é parte da imagem de disco do qemu:

~~~  
qemu -hdc /dev/md0 [...]  
~~~

Naturalmente, você pode configurar qualquer carregador de boot na imagem usando o qemu, desde que a partição /boot/sdaN contenha as ferramentas necessárias.

<!--#### Como usar o Módulo de Aceleração do QEMU

Os desenvolvedores do qemu criaram um módulo opcional para o kernel, de forma a acelerar o qemu às vezes até a níveis de operação nativos. Ele pode ser carregado com a opção:

~~~  
major=0  
~~~

... para automatizar a criação do necessário dispositivo /dev/kqemu. Já este comando:

~~~  
echo "options kqemu major=0" >> /etc/modprobe.conf  
~~~

corrige o modprobe.conf para assegurar que a opção do módulo seja adicionada sempre que ele é carregado.

~~~  
qemu [...] -kernel-kqemu  
~~~

Isto habilita total virtualização, o que melhora a velocidade consideravelmente.

#### Para ativar o qemu:

~~~  
qemu -cdrom /tmp/pkg/siduction-debug.iso -net nic -net user -m 512  
-->  
~~~

 [Documentação oficial do Projeto QEMU](http://www.nongnu.org/qemu/user-doc.html)  

 [Parte do que está escrito sobre o QEMU neste Manual do siduction foi conseguido acessando-se este site, sob a GNU Free Documentation License 1.2 e modificada para este manual.](http://wiki.archlinux.org/index.php/Qemu)  

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
