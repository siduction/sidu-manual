<div id="main-page"></div>
<div class="divider" id="grub2"></div>
## GRUB 2

###### Resumo básico das principais diferenças entre o GRUB 1 (agora chamado de grub-legacy) e o GRUB 2:

+ `Não existe mais o arquivo menu.lst.`   
+ Um arquivo com o nome de `grub.cfg`  agora controla a tela do Grub.  
+ O grub.cfg é gerado automaticamente pelos scripts localizados em `/etc/grub.d` .  
+ O sistema de numeração das partições também é diferente. Elas agora começam em 1, ao invés de 0 (os drives continuam a ser numerados a partir de 0):  
   ~~~    
   Linux grub1 grub2    
   /dev/sda1 (hd0,0) (hd0,1)    
   /dev/sda2 (hd0,1) (hd0,2)    
   /dev/sda3 (hd0,2) (hd0,3)    
   /dev/sdb1 (hd1,0) (hd1,1)    
   /dev/sdb2 (hd1,1) (hd1,2)    
   /dev/sdb3 (hd1,2) (hd1,3)    
   ~~~
  
+ As seções do grub.cfg são formadas de maneira levemente diferente, se comparadas com o menu.lst. Não é possível, portanto, copiar as instâncias do menu.lst diretamente para o grub.cfg, já que este é o arquivo "resultante". **`Aliás, o arquivo grub.cfg não deve nunca ser alterado manualmente.`**   

<div class="divider" id="grub2-files"></div>
#### O arquivo de configuração padrão do Grub 2

O arquivo `/etc/default/grub`  contém as variáveis do grub2. Por exemplo, fim de espera ('timeout') no menu, entradas a ser ativadas pelo menu, parâmetros do kernel, o uso ou não de gráficos e por aí afora.

#### Os scripts do Grub 2

Os arquivos que estão em `/etc/grub.d`  controlam o arquivo "resultante", chamado, como já vimos, `grub.cfg` . Este arquivo se encontra no diretório `/boot/grub/` .

**`O grub.cfg não deve nunca ser alterado manualmente.`** Todas as alterações são feitas em um ou em todos os scripts localizados no diretório `/etc/grub.d` . os-prober deve lidar com 90% de todos os casos:

~~~  
00_header:  
05_debian_theme: Especifica o fundo, cores do texto e temas  
10_hurd: Localiza os kernels Hurd  
10_linux: Localiza os kernels Linux com base nos resultados do comando lsb_release.  
20_memtest86+: Se o arquivo /boot/memtest86+.bin existir, ele é incluído no menu.  
30_os-prober: Procura por Linux e outros SOs em todas as partições e os inclue no menu.  
40_custom: Um 'template' (modelo de documento vazio) para adicionar entradas personalizadas no menu para outros SOs.  
60_fll-fromiso: Um 'template' para adicionar entradas personalizadas no menu para fromisos a partir de dispositivos USB/cartões SSD.  
<span class="highlight-2">60_fll-fromiso não deve ser alterado; use /etc/default/grub2-fll-fromiso  
Read  [Booting 'fromiso' with Grub 2](hd-install-opts-pt-br.htm#grub2-fromiso) </span>  
~~~

Depois que uma alteração é feita, o grub.cfg precisa saber das mudanças. No caso de atualizações do kernel do siduction, o comando é rodado automaticamente. No caso de uma alteração manual feita por você em qualquer dos arquivos acima, como administrador do sistema, é necessário rodar: 

~~~  
update-grub  
~~~

`O pacote deb do Grub2 existente nos repositórios Debian foi montado de tal forma que alterações manuais raramente são necessárias.` 

<div class="divider" id="grub1-grub2"></div>
## Como atualizar do Grub-Legacy para o Grub 2

**`Recomendamos uma atualização limpa, com total remoção do Grub 1`** . Tenha em mente que você pode estragar tudo, portanto seja extremamente cuidadoso.

###### Passo 1: 

Assegure-se de que seu sistema está inteiramente atualizado por `dist-upgrade no init 3:` 

~~~  
apt-get update  
Ctrl+Alt+F1  
init 3  
apt-get dist-upgrade  
init 5 && exit  
~~~

###### Passo 2:

Remova totalmente o Grub 1:

~~~  
rm -rf /boot/grub  
apt-get purge grub-gfxboot  
~~~

O resultado será a remoção dos arquivos `fll-iso2usb* grub-gfxboot* install-usb-gui*` . Digite `S (ou 'Y')`  para confirmar.

###### Passo 3:

~~~  
apt-get install grub2 os-prober  
~~~

![Grub2](../images-common/images-grub2/grub2-2.png "Grub2") 

Use a tecla Tab para selecionar OK

![Grub2](../images-common/images-grub2/grub2-3.png "Grub2") 

Use a tecla Tab para selecionar OK

![Grub2-conversion 1](../images-common/images-grub2/grub2-convert-1.png "Grub2-conversion 1") 

Use a seta e a barra de espaço para colocar um caractere `* (asterisco)`  no dispositivo em cuja MBR o Grub 2 será escrito.  *(Neste exemplo, a instalação se dará em um drive USB)* .

###### Passo 4:

~~~  
update-grub  
~~~

###### Passo 5:

~~~  
,  
apt-get install install-usb-gui fll-iso2usb  
~~~

###### Passo 6:

 Reinicie seu PC e o menu.cfg vai mostrar uma lista com o kernel e os sistemas operacionais, como esta:

![Grub2-OS list](../images-common/images-grub2/grub2-os-list.jpg "Grub2-OS list") 

Se algo estiver corrompido ou acontecer alguma coisa errada, consulte  [Grub 2 na MBR sobrescrito ou corrompido](sys-admin-grub2-pt-br.htm#chroot) . 

### Como editar as opções do Grub2 via tela de edição

![Grub2-Edit](../images-common/images-grub2/grub2-e-1.JPG "Grub2-Edit") 

Se, por algum motivo, você tiver de fazer uma alteração temporária nas opções de boot de um kernel presente no Grub2, pressione a letra **`e`**  para editar as opções do kernel. Use as setas direcionais para navegar até a linha desejada. Daí, ainda na tela de edição, use `Ctrl+x`  para reiniciar o computador.

Por exemplo, para ir direto para o runlevel 3, adicione `3`  no final da linha`linux /boot/vmlinuz` .

As edições que você fizer na tela de edição não são permanentes. Para que elas o sejam, você necessita editar os arquivos apropriados. Veja  [arquivos do Grub2](sys-admin-grub2-pt-br.htm#grub2-files) .

<div class="divider" id="multi-os"></div>
## Boots duplos e múltiplos com o Grub 2

Como o Grub2 é modular na configuração, com um simples comando é possível procurar novos sistemas operacionais. Se algum é encontrado, ele tenta implementar a alteração no menu.cfg, atualizando-o. Este comando é o seguinte:

~~~  
update-grub  
~~~

Caso haja necessidade de incluir uma entrada personalizada ou caso o script 30_os-prober falhe ao escrever menus do tipo 'chainloader' no menu.cfg, use seu editor de textos favorito para fazer suas alterações no arquivo `/etc/grub.d/40_custom` .

Exemplos de customização do 40_custom file:

~~~  
menuentry "second mbr"{  
set root=(hd1)  
chainloader +1  
}  
~~~

~~~  
menuentry "second partition"{  
set root=(hd0,2)  
chainloader +1  
}  
~~~

Então, após suas edições, rode:

~~~  
update-grub  
~~~

Se ele reclamar que não consegue reconhecer o dispositivo, será necessário gerar o devicemap ('mapa de dispositivos') novamente.

`Para isso, assegure-se de escolher a partição, não a MBR, ao instalar o outro sistema operacional:` 

~~~  
grub-mkdevicemap --no-floppy  
update-grub  
~~~

As mensagens de advertência podem ser ignoradas sem problemas.

Se você cometer um erro, a atualização provavelmente irá sobrescrever sua MBR e você terá de fazer a correção com  [Grub2 - sobrescrição da MBR](sys-admin-grub2-pt-br.htm#mbr-over-grub2) .

<div class="divider" id="mbr-over-grub2"></div>
## Como simplesmente reescrever o grub2 na MBR, a partir do HD:

~~~  
/usr/sbin/grub-install --recheck --no-floppy /dev/sda  
~~~

Pode ser necessário rodar este comando mais de uma vez, até que ele esteja convencido de que é isso mesmo que você quer.

## MBR reescrita pelo Windows, Grub2 corrompido e como recuperar o Grub2

**`NOTA: para restaurar o Grub2, você precisa ter uma iso da versão ou superior do siduction.`**   [Alternativamente, use chroot em qualquer live.iso](sys-admin-grub2-pt-br.htm#chroot) .

 Para reescrever o grub2 na MBR e/ou recuperar o grub2 em geral, será necessário dar o boot pela `siduction.iso` :

1. Para identificar e confirmar suas partições (p. ex. [h,s]d[a..]X), todas as ações a seguir precisam de privilégios de administrador, portanto torne-se root (#):  
   ~~~    
   $ sux    
   ~~~
  
2. Daí digite:  
   ~~~    
   fdisk -l    
   cat /etc/fstab    
   ~~~
  
   Isto é para obter os nomes corretos.  
3. Quando souber qual é a partição que dá o boot, crie o ponto de montagem:  
   ~~~    
   mkdir -p /media/[hdxx,sdxx,diskx]    
   ~~~
  
4. Monte a partição:  
   ~~~    
   mount /dev/xdxx /media/xdxx    
   ~~~
  
5. Agora reescreva o Grub para a MBR do primeiro HD (genérico):  
   ~~~    
   /usr/sbin/grub-install --recheck --no-floppy --root-directory=/media/xdxx /dev/sda    
   ~~~
  

<div class="divider" id="chroot"></div>
### Como usar o chroot para recuperar um Grub2 corrompido ou sobrescrito na MBR

Para recuperar o Grub 2, se ele tiver sido corrompido ou sobrescrito na MBR, crie um ambiente `chroot` . `Qualquer live.iso é suficiente pois o chroot vai utilizar o sistema instalado no seu disco, de modo que você vai poder restaurar a versão apropriada do grub seja ela grub1 (legacy) ou grub2.` 

Inicie sua máquina com uma live.iso do siduction que seja apropriada para seu sistema (CD, DVD, pendrive ou cartão SSD de 32 ou 64 bit) e abra o terminal. Digite `sux`  e pressione [ENTER] para passar a ter permissões de root.

Use `fdisk -l ou blkid`  para assegurar-se de qual é a partição que dá o boot e pegue o nome correto. Se preferir o ambiente gráfico, use o `Gparted` :

~~~  
blkid  
~~~

... e para checar se os dados do fstab combinam com a saída do blkid:

~~~  
cat /etc/fstab  
~~~

Vamos assumir que seu sistema de arquivos root está em `/dev/sda2` 

~~~  
mkdir /mnt/siduction-chroot  
mount /dev/sda2 /mnt/siduction-chroot  
~~~

Em seguida, monte /proc, /run, /dev e /sys assim:

~~~  
mount --bind /proc /mnt/siduction-chroot/proc  
mount --bind /run /mnt/siduction-chroot/run  
mount --bind /sys /mnt/siduction-chroot/sys  
mount --bind /dev /mnt/siduction-chroot/dev  
mount --bind /dev/pts /mnt/siduction-chroot/dev/pts  
~~~

Se você iniciou o sistema usando uma partição EFI é necessário montar a partição EFI. Supondo que esta é /dev/sda1:

~~~  
mount /dev/sda1 /mnt/siduction-chroot/boot/efi  
~~~

Seu ambiente chroot agora está criado; acesse-o com:

~~~  
chroot /mnt/siduction-chroot /bin/bash  
~~~

Agora você é capaz de usar o cache local do apt ou alterar arquivos que precisem de correção como se você tivesse dado o boot pelo sistema; no nosso caso, o que desejamos é colocar o Grub de volta na MBR.

`Paa restaurar o Grub 2` 

~~~  
apt-get install --reinstall grub-pc  
~~~

Para assegurar que o grub foi installado no disco ou partição correta, use:

~~~  
dpkg-reconfigure grub-pc  
~~~

`Para restaurar o Grub 2 EFI` 

~~~  
apt-get install reinstall grub-efi-amd64  
~~~

`Para restaurar o Grub 1 (grub-legacy)` 

~~~  
apt-get install --reinstall grub-legacy  
~~~

Siga as instruções do instalador.

Para sair do chroot:

~~~  
Ctrl+d  
~~~

Reinicie seu computador.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
