<div id="main-page"></div>
<div class="divider" id="raw-usb"></div>
## Instalando uma ISO siduction em Dispositivos USB ou sdhc e Cartões SSD com Qualquer Linux, MS Windows(tm); ou Mac OS X(tm);

Independentemente do sistema operacional que você usar, os métodos a seguir lhe possibilitarão instalar o siduction em uma pendrive, cartão SSD ou leitor de cartões sdhc (Secure Digital High Capacity).

A imagem ISO do siduction é escrita no dispositivo e, ainda que a persistência não seja possível, ao menos permite que você tenha um 'siduction-on-a-stick', ou seja, um siduction portátil.

Se a persistência for importante para você, lembre-se que o 'install-usb-gui' não está sujeito a essa limitação e é a opção recomendada quando um siduction está disponível. Consulte  [Instalação fromiso em dispositivos USB/SSD, siduction-on-a-stick](hd-install-opts-pt-br.htm#usb-from1) .

### Pré-requisitos

+ `Assegure-se de que a BIOS do PC que você deseja que dê o boot com um siduction portátil seja capaz de inicializar por dispositivos USB ou cartões SSD. Normalmente, isso acontece com qualquer máquina que tenha o protocolo USB 2.0 e dê suporte a boots por USB/SSD.`   
+ O dispositivo USB/SSD é normalment reconhecido automáticament e você deverá ver a opção `F4`  do menu que dirá `Hard Disk` , caso contrário pressione a tecla `F4 >Hard Drive`  ou adicione `fromhd`  às linhas de inicialização do boot menu.  
+ **`É importante notar que os métodos abaixo sobrescreverão/destruirão qualquer tabela de partições existente do dispositivo usado. Perdas de dados vão depender do tamanho do arquivo siduction-*.iso. O Linux não restringe o espaço de armazenamento disponível, de forma que você pode resgatar qualquer dado não apagado pela ISO; porém, parece que o MS Windows permite apenas uma partição, portanto não tente isso naquele seu HD que tem mais de 100G!!`**   

 [Linux](#raw-lin)  &nbsp; [MS Windows](#raw-ms)  &nbsp; &nbsp; [Mac OS X](#raw-mac)  

<div class="divider" id="raw-lin"></div>
### Sistemas operacionais Linux

Conecte seu dispositivo USB ou leitor de cartões onde será feita a instalação e digite no terminal:

~~~  
cat /caminho/para o/siduction-*.iso > /dev/nome_assumido_pelo_USB  
~~~

ou

~~~  
dd if=/caminho/para o/siduction-*.iso of=/dev/sdf  
~~~

###### Exemplo:

Conecte seu dispositivo, rode o `dmesg`  e observe a saída:

~~~  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sdf: sdf1 sdf2  
sd 13:0:0:0: [sdf] Assuming drive cache: write through  
sd 13:0:0:0: [sdf] Attached SCSI removable disk  
~~~

Digamos que você baixou uma ISO com o nome de `siduction-YYYY-NN-xxxxx--i386-YYYYMMDDhhmm.iso`  (você pode renomeá-la para `siduction-.iso` ); então, o comando será:

~~~  
cat /home/username/siduction-.iso > /dev/sdf  
~~~

ou

~~~  
dd if=/home/username/siduction-.iso of=/dev/sdf  
~~~

O dispositivo USB/SSD é normalment reconhecido automáticament e você deverá ver a opção `F4`  do menu que dirá `Hard Disk` , caso contrário pressione a tecla `F4 >Hard Drive`  ou adicione `fromhd`  às linhas de inicialização do boot menu.

<div class="divider" id="raw-ms"></div>
### Sistemas operacionais MS Windows(tm);

Rápido e simples: instale um programa chamado  [flashnul](http://shounen.ru/soft/flashnul/)  ([página onde baixar](http://shounen.ru/soft/flashnul/#download)).

Note o nome 'flashnul' quando extrair e instalar, porque ele deve mostrar uma pasta chamada flashnul-x.x. Por exemplo, 'flashnul-1rc1.zip' baixado, extraído e instalado em Arquivos de Programas tem uma pasta com o nome de flashnul-1rc1, que deverá ter uma pasta dentro daquela, chamada flashnul-1rc1, que, por sua vez, contém o programa flashnul e arquivos/pastas associados, que serão usados no decorrer deste exemplo.

Conecte sua pendrive ou leitor de cartão.

Se você extraiu e instalou o flashnul em Arquivos de Programas e agora não sabe ao certo onde o dispositivo USB está montado, estude a saída de 'flashnul -p'. Para isso, clique `run ('rodar')`  no menu, daí digite `cmd`  para abrir o terminal e navegue pelos diretórios (pastas) até chegar naquele que contém os arquivos individuais do programa. No nosso caso:

~~~  
cd C:\Program Files\flashnul-1rc1\flashnul-1rc1\  
flashnul -p  
~~~

Você verá algo desse tipo:

~~~  
Available physical drives:  
0 size = 60022480896 (55 Gb))  
1 size = 2003828736 (1911 Mb)  
~~~

Vamos dizer que você baixou uma ISO chamada `siduction-YYYY-NN-xxxxx--i386-YYYYMMDDhhmm.iso`  (você pode renomeá-la para `siduction-.iso` ). Use Recortar (ou Copiar) e Colar para colocá-la na pasta flashnul-1rc1 que contém todos os arquivos/pastas do programa.

Como a saída do 'flashnul -p' em nosso exemplo mostrou que o dispositivo USB foi montado em **`1`** , digite o comando abaixo e pressione [ENTER], como root:

~~~  
flashnul 1 -L siduction.iso  
~~~

MS Win7 may need the actual drive letters specified, for example the D: and c:\ drives:

MS Win7 pode necessitar da letra de designação do disco por exemplo D: e ou c:\ 

~~~  
flashnul D: -L c:\flash\siduction-.iso  
~~~

O dispositivo USB/SSD é normalment reconhecido automáticament e você deverá ver a opção `F4`  do menu que dirá `Hard Disk` , caso contrário pressione a tecla `F4 >Hard Drive`  ou adicione `fromhd`  às linhas de inicialização do boot menu.

<div class="divider" id="raw-mac"></div>
### Sistemas Mac OS X(tm);

Conecte seu dispositivo USB, que será montado automaticamente pelo Mac OS X. No Terminal (encontrado nas pastas Aplicações &gt; Utilitários), rode:

~~~  
diskutil list  
~~~

Verifique como seu dispositivo é chamado, então desmonte as partições nele contidas (vamos assumir que seja /dev/disk1):

~~~  
diskutil unmountDisk /dev/disk1  
~~~

Digamos que você baixou uma ISO chamada `siduction-YYYY-NN-xxxxx--i386-YYYYMMDDhhmm.iso`  que está em `/Usuários/nome_do_usuário/Downloads/`  (você pode renomeá-la para `siduction-.iso` ) e se o dispositivo USB foi designado como `disk1` , rode:

~~~  
dd if=/Users/username/Downloads/siduction-.iso of=/dev/disk1  
~~~

O dispositivo USB/SSD é normalment reconhecido automáticament e você deverá ver a opção `F4`  do menu que dirá `Hard Disk` , caso contrário pressione a tecla `F4 >Hard Drive`  ou adicione `fromhd`  às linhas de inicialização do boot menu.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
