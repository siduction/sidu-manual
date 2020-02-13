<div id="main-page"></div>
<div class="divider" id="fromiso"></div>
## Como inicializar com "fromiso" - visão geral

**`Para uma instalação normal, recomendamos usar ext4; ele é o sistema de arquivos padrão do siduction.`**

Com este "cheatcode" você pode iniciar o siduction a partir de uma imagem ISO salva em uma partição do HD (ext2/3/4), o que é muito mais rápido do que dar o boot a partir de um CD (instalações com "fromiso" levam apenas uma fração de tempo).

Além de mais rápido, o 'fromiso' permite liberar o drive de CD/DVD-ROM. Outra alternativa é usar o QEMU.

##### Requisitos:

* um GRUB que funcione (em um disquete, em uma instalação do HD ou em um LiveCD)  
* uma imagem ISO do siduction (p. ex., siduction.iso) e um sistema de arquivos Linux, como ext2/3/4  
* * * * (ATENÇÃO: se você renomeou sua imagem para 'siduction.ISO', você terá de alterar os comandos abaixo de acordo, porque o sistema de nomes de arquivos do UNIX é sensível a maiúsculas/minúsculas).

<div class="divider" id="grub2-fromiso"></div>
## fromiso com Grub2

O siduction oferece um arquivo, chamado 60_fll-fromiso, para gerar uma entrada fromiso no menu do grub2. O único arquivo de configuração do fromiso se chama `grub2-fll-fromiso`  e pode ser encontrado em `/etc/default/grub2-fll-fromiso` .

 Antes de mais nada, abra o terminal e torne-se root:

~~~  
sux  
apt-get update  
apt-get install grub2-fll-fromiso  
~~~

Então, abra um editor, que pode ser tanto o kwrite quanto o mcedit, vim ou ainda qualquer outro de sua preferência:

~~~  
mcedit /etc/default/grub2-fll-fromiso  
~~~

Em seguida, descomente (isto é, remova o caractere**`#`** ) as linhas necessárias para ser efetivo e substitua as instruções padrão, que se encontram dentro das `"aspas"`  com suas preferências.

Por exemplo, compare este arquivo grub2-fll-fromiso, já alterado, com o padrão. As `linhas salientadas`  são as que foram mudadas para fins desta explanação):

~~~  
# Defaults for grub2-fll-fromiso update-grub helper  
# sourced by grub2's update-grub  
# installed at /etc/default/grub2-fll-fromiso by the maintainer scripts  
#  
# This is a POSIX shell fragment  
#  
# specify where to look for the ISO ('mostre onde procurar a ISO')  
# default: /srv/ISO `### Note: This is the path to the directory that contains the ISO, it is not to include the actual siduction-*.iso file.###`   
FLL_GRUB2_ISO_LOCATION="/media/disk1part4/siduction-iso"`   
# array for defining ISO prefices --> siduction-*.iso ('caracteres definidores dos prefixos do nome da ISO')  
# default: "siduction- fullstory-"  
FLL_GRUB2_ISO_PREFIX="siduction-"`   
# set default language ('defina a língua padrão')  
# default: en_US  
FLL_GRUB2_LANG="en_AU"`   
# override the default timezone. ('especifique o fuso horário')  
# default: UTC  
FLL_GRUB2_TZ="Australia/Melbourne"`   
# kernel framebuffer resolution, see ('resolução do framebuffer')  
# http://manual.siduction.org/de/cheatcodes-vga-de.htm#vga  
# default: 791  
#FLL_GRUB2_VGA="791"  
# additional cheatcodes ('cheatcodes adicionais')  
# default: noeject  
FLL_GRUB2_CHEATCODE="noeject nointro"`   
~~~

Salve e feche o editor; daí, rode no terminal:

~~~  
update-grub  
~~~

Seu arquivo grub2 grub.cfg será atualizado e mostrará as diferentes ISOs que você tem no diretório especificado e que estarão disponíveis na sua próxima reinicialização.

<div class="divider" id="fromiso-persist"></div>
## Informações gerais sobre fromiso com persist

### Firmware

<!-- `This applies to all persist requirements, except from RAW device installations.`  For RAW devices see  [Writing siduction to a USB/SSD stick with any Linux, MS Windows or Mac OS X system](hd-ins-opts-oos-en.htm#raw-usb) 

 -->
Simplesmente guarde os ficheiros que pretende adicionar ao sistema "live" `/lib/firmware`  num diretório chamado `/siduction/firmware` . Para os ativar pode durante o processo de arranque, selecionar `Yes`  no menu gráfico `Driver menu`  ou adicionar manualmente o cheatcode `firmware`  à linha de comando do kernel. `firmware=/lib/firmware`  irá então carregar o firmware que encontarar no diretório indicado. Se pretende ativá-lo sempre pode efetuar esta mudança no fichero de configuração do arranque por exemplo `/boot/isolinux/syslinux.cfg` .

Tanto persist como firmware podem ser colocados em diferentes lugares sendo para isso necessário entrar o nome correto do ficheiro ou diretório para poder ser encontrado no arranque do sistema. Por exemplo para utilizar um ficheiro com o nome `persist.img`  na raiz basta utilizar como cheatcode `persist=/persist.img`  e do mesmo modo para encontrar o firmware guardado no diretório `/fw`  basta entrar como cheatcode `firmware=/fw` .

### fromiso e persist no HD

Você pode ter um sistema live persistente em um disco gravável se combinar as configurações de um fromiso com o cheatcode do persist. Quando o fromiso usar ext2/ext3/ext4, o padrão é simplesmente:

~~~  
persist  
~~~

Quando o fromiso usar vfat, você vai precisar usar um arquivo que contenha um sistema de arquivos Linux e a 'cheatcode' será assim:

~~~  
persist=/siduction/base-rw  
~~~

O siduction usa o aufs para habilitar o que é conhecido como "copy on write" em sua ISO, o que permite que você crie novos arquivos e pastas e atualize os já existentes, mantendo-os na memória. O cheatcode `persist`  irá armazenar seus novos arquivos na mesma partição que você usa para armazenar sua imagem ISO fromiso.

`fromiso`  proporciona um sistema live com todos os recursos automáticos de uma ISO live do siduction. Isto traz o benefício de, por exemplo, configurar automaticamente seu hardware, mas também significa que os mesmos arquivos serão sempre recriados a cada inicialização (a menos que você use códigos adicionais).

Usar `persist`  juntamente com outros cheatcodes específicos do siduction, como noxorgconf, nonetwork, resulta na não criação dos mesmos arquivos a cada novo reboot.

Usar persist também significa que você pode instalar pacotes pelo APT e ter aplicações e quaisquer dados salvos disponíveis para acesso quando seu computador for reiniciado.

<div class="divider" id="persist-post"></div>
## fromiso e persist em dispositivos USB ou cartões SD/flash

Talvez o uso ideal da persistência seja em conjunção com a ferramenta install-usb-gui para criar sua própria pendrive inicializável com os arquivos e software que você desejar. Seus arquivos serão armazenados em uma subpasta no HD.

`persist`  em um sistema de arquivos FAT, como é comum em instalações DOS/Windows 9x e geralmente encontrado por padrão em dispositivos flash, exige que você crie um único e grande arquivo para ser usado como dispositivo em loop, que você precisará também formatar.

`Em dispositivos USB ou cartões SD/flash, os sistemas de arquivos recomendados são ext2 e vfat. Eles interagem melhor com outras plataformas em casos de recuperação de dados, já que existe um driver MS Windows(tm); para troca de dados e informações. Por outro lado, a possibilidade de reescrever nesses dispositivos vai depender das especificações de cada um.` 

###### Sistemas de arquivos ext2

Com ext2 toda a partição será utilizada. Além disso, o root atual é aproveitado e um diretório /fll é criado para persistência; isso permite o uso de todo o espaço livre para o persist.

###### Sistema de arquivos vfat

Quando se usa vfat, a persistência é obtida através de um arquivo cujo tamanho máximo não pode ultrapassar 2GB (já o tamanho mínimo não pode ser inferior a 100MB, o que o tornaria inútil). Esse arquivo precisa ser nomeado `siduction-rw` .

#### Exemplo de criação de persist após instalação inicial

Se você não tiver certeza do ponto de montagem, monte a pendrive e rode `ls -lh /media`  para obter uma lista de todos os pontos de montagem de seu sistema. Procure por algo do tipo `drwxr-xr-x 6 username root 4.0K Jan 1 1970 disk` . Se sua saída estiver diferente, então substitua `"/media/disk"`  de acordo com sua realidade (por exemplo "/media/disk-1").

~~~  
disk="/media/disk"  
-->  
~~~

Continuing the example, the command `df -h`  will clarify the information, :

~~~  
/dev/sdc2 3.4G 4.0K 3.4G 1% /media/disk  
/dev/sdc1 4.1G 1.1G 2.8G 28% /media/disk-1  
~~~

Therefore:

~~~  
disk="/media/disk-1"  
~~~

Especifique o tamanho da partição persist:

~~~  
size=1024  
~~~

Faça um diretório na pendrive:

~~~  
mkdir $disk/siduction  
~~~

Digite o seguinte código para fazer a partição persist:

~~~  
dd if=/dev/zero of=$disk-1/siduction/base-rw bs=1M count=$size && echo 'y' | LANG=C /sbin/mkfs.ext2 $disk-1/siduction/base-rw && tune2fs -c 0 "$disk-1/siduction/base-rw"  
~~~

**`Partições NTFS, geralmente usadas em instalações Windows NT/2000/XP (TM) NÃO PODEM ser usadas de forma nenhuma para persistência!!!`**

<div class="divider" id="usb-hd"></div>
## Instalação do siduction em um dispositivo USB ou cartão SD/flash

Instalar o siduction em pendrives ou cartões SD/flash é tão fácil quanto uma instalação em um HD tradicional. Basta seguir as instruções abaixo.

##### Requisitos:

* qualquer PC com suporte a USB 2.0 e capaz de ser inicializado por USB/SD/flash.

* uma imagem siduction.iso.

##### Três tipos de instalação em dispositivos USB/SD/flash:

+ 1)  [fromiso](hd-install-opts-pt-br.htm#usb-from1) ; específico do siduction: siduction-on-a-stick  
+ 2)  [completa](hd-install-opts-pt-br.htm#usb-hdd)  (uma instalação completa em dispositivos USB/SD/flash comporta-se como uma instalação em HD normal e é feita pelo instalador padrão).  
+ 3) [RAW device](hd-ins-opts-oos-pt-br.htm#raw-usb)  Ideal quando se está rodando qualquer Linux, MS Windows ou Mac OS X e se quiser instalar o siduction em pendrives (siduction-on-a-stick) (com muito cuidado).  

<div class="divider" id="usb-from1"></div>
### Instalação fromiso em dispositivos USB/SD/flash, siduction-on-a-stick

 `Comece por formatar seu dispositivo USB com ext2 ou fat32, antes de prosseguir (mínimo de 2 GB de espaço). O dispositivo deve ter apenas uma partição e, como algumas BIOS são temperamentais, deve ser marcado como inicializável ('bootable').` 

Se você estiver usando uma aplicação que roda no X, como o GParted, favor assegurar-se de, primeiro, deletar a partição existente e então recriar a partição antes de formatar.

##### USB fromiso from a HD siduction installed system:

A instalação `fromiso USB`  é feita a partir do `Menu>Sistema>Instalar em USB` . 

##### USB fromiso from a siduction-*.iso:

Em um CD-Live, você também pode clicar no ícone `siduction Installer`  e escolher `live-usbstick installer` .

###### Options:

Você terá a oportunidade de escolher língua, fuso horário e outros códigos de inicialização e se deseja ou não 'persist', via uma caixa de seleção.

Agora, você tem um dispositivo USB/SD/flash capaz de dar o boot. Se você não ativou 'persist', você pode fazê-lo digitando `persist`  na linha de comando da tela do GRUB. (Se você usou vfat, provavelmente será melhor recomeçar).

###### Exemplo no terminal:

~~~  
fll-iso2usb -D /dev/sdb -f none --iso /home/siduction/base.iso -p -- lang=no tz=Pacific/Auckland  
~~~

Com isso, a imagem ISO é instalada no dispositivo USB `sdb`  com persist, língua norueguesa e fuso horário Pacífico/Auckland (Nova Zelândia) na linha padrão do GRUB.

Sua configuração X (placa de vídeo, teclado e mouse) e seu arquivo com as interfaces de rede não foram armazenados, o que é ideal para usar em outras máquinas.

Para mais documentação, incluindo opções de customização:

~~~  
$ man fll-iso2usb  
~~~

### Instalação completa para USB/SD/flash (comporta-se como uma instalação normal)

Para saber o tamanho mínimo recomendado da pendrive ou cartão SD/flash observe que:  
* o siduction "LITE" precisa de 2.5 GB ou mais para os dados  
* o siduction "FULL" precisa de 4 GB ou mais para os dados

 `Antes de mais nada, formate seu dispositivo com`  **`ext2`** `, como você faria em um PC normal.` 

Comece a instalação pelo Live-CD /DVD e escolha a partição do dispositivo onde o siduction será instalado (por exemplo, `sdbX)`  e siga as instruções do instalador. Leia  [Instalando no HD](hd-install-pt-br.htm#Installation) .

`Para dar o boot pelo USB/SD/flash, a opção 'Boot a partir de USB' precisa existir e estar habilitada na BIOS de seu computador!` 

`Outras observações importantes:` 

+ Uma instalação em dispositivos USB ou cartões SD/flash será, normalmente, direcionada para uso no PC que iniciou a instalação original. Se você tiver a intenção de usá-la em outras máquinas, lembre-se de que os drivers não livres da placa de vídeo provavelmente não estarão instalados e nem os 'cheatcodes' pré-configurados (com exceção do cheatcode VESA já declarado no grub.cfg).  
+ Após dar o boot do dispositivo USB/SD/flash em outro PC, será necessário alterar o arquivo fstab (que está em /etc) para que as partições do HD fiquem acessíveis.  
+ "fromiso" com "persist" é a melhor escolha se sua intenção primeira for portabilidade.  

<div class="divider" id="usb-hdd"></div>
### Instalação completa em um HD-USB, como se fosse em uma partição

O HD-USB tem uma grande vantagem (particularmente para novos usuários vindos do Windows ou de outra distro), que é permitir instalar o siduction e depois conectar o dispositivo a um PC sem a necessidade de configurá-lo para boots múltiplos, isto é, sem que seja necessário reparticionar a máquina, fazer alterações no GRUB etc.

Inicie pelo Live-CD/DVD (ou por uma pendrive ou cartão SD/flash), `como se fosse uma instalação normal, não como uma instalação para USB`  e escolha a partição no dispositivo onde o siduction ficará (por exemplo, `sdbX)`  e siga as instruções do instalador. O GRUB deve ser escrito na partição do HD-USB.

Leia  [Instalando no HD](hd-install-pt-br.htm#Installation) .

`Outras observações importantes:` 

+ Uma instalação no HD-USB será direcionada para o PC que iniciou a instalação original. Se você tiver a intenção de usá-la em outras máquinas, lembre-se de que o HD-USB não deverá estar com os drivers não livres da placa de vídeo instalados nem com as 'cheatcodes' pré-configuradas (com exceção, provavelmente, da cheatcode VESA já aposta no grub.cfg).  
+ Se você quiser usar a instalação em outra máquina, esteja alertado para o fato de que serão necessários alguns ajustes, como alterar o arquivo /etc/fstab (para que as partições do PC fiquem acessíveis), editar o xorg.conf e, provavelmente, refazer a configuração da rede.  

<div class="divider" id="usb-gpt-1"></div>
## Full installation to bootable GPT removable devices (behaves as a normal HD installation)

 Refer to  [Partitioning with gdisk for GPT disks](part-gdisk-pt-br.htm#gdisk-1)  and then follow the instructions for  [Installation options - HD, USB, VM and Cryptroot](hd-install-pt-br.htm) .

<div class="divider" id="usb-efi-1"></div>
## Bootable (U)EFI removable devices

<span class='highlight-1'>Applicable from the siduction-11.1-OneStepBeyond release.</span>

If you want to boot using EFI without burning optical media, then you need a vfat partition containing a portable EFI bootloader `/efi/boot/bootx64.efi` . The siduction amd64 isos include such a file and a grub configuration which it can load. To prepare a stick to boot this way, simply copy the contents of the siduction iso to the root of a `vfat`  formatted usb stick. You should also mark the partition as bootable using a disk partitioning tool.

Of course simply copying the files onto a vfat usb stick will not let you boot it on a traditional bios system, however it is quite easy to enable this using syslinux and install-mbr. All you need to do is run (without the stick being mounted): 

~~~  
syslinux -i -d /boot/isolinux /dev/sdXN  
install-mbr /dev/sdX  
~~~

A stick prepared this way, will boot both by EFI to the plain grub2 menu and by traditional bios to the graphical gfxboot menu.

One of the advantages of having a stick created this way, as opposed to a raw stick created due to using isohybrid, is that you can edit the boot files on the stick to add your preferred options automatically. 

For traditional BIOS systems you can edit the `/boot/isolinux/syslinux.cfg`  file and/or the `/boot/isolinux/gfxboot.cfg`  file. For EFI systems you can edit the `/boot/grub/x86_64-efi/grub.cfg`  file.

#### Persistence and firmware

See  [General information on persist](hd-install-opts-pt-br.htm#fromiso-persist) 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
