<div id="main-page"></div>
<div class="divider" id="download-siduction"></div>
## Download da imagem ISO do siduction

###### **`OBSERVAÇÃO MUITO IMPORTANTE:`** `o siduction, como LiveCD do Linux, é baseado em tecnologia de alta compressão. Por isso, cuidados especiais são necessários ao queimar a imagem ISO: use apenas mídias de alta qualidade [CD ou DVD+RW] e queime no **`modo DAO (disk-at-once)`**  e em velocidade não superior a 8x.` 


---

###### Favor escolher o espelho mais próximo. Espelhos com caixas de código logo embaixo são atualizados imediatamente após os 'uploads' das alterações (veja /etc/apt/sources.list.d/siduction.list).

#### Europe

+  **Free University Berlin/ spline (Student Project LInux NEtwork), Germany:**   
    [http://ftp.spline.de/pub/siduction/iso](http://ftp.spline.de/pub/siduction/iso)   
    [ftp://ftp.spline.de/pub/siduction/iso](ftp://ftp.spline.de/pub/siduction/iso)   
   rsync://ftp.spline.de/siduction/iso  

~~~  
deb ftp://ftp.spline.de/pub/siduction/base unstable main  
deb ftp://ftp.spline.de/pub/siduction/fixes unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/base unstable main  
deb-src ftp://ftp.spline.de/pub/siduction/fixes unstable main  
~~~

#### North America

+  **`University of Delaware`**   
    [http://mirror.lug.udel.edu/pub/siduction/iso](http://mirror.lug.udel.edu/pub/siduction/iso)   
    [ftp://ftp.lug.udel.edu/pub/siduction/iso](ftp://ftp.lug.udel.edu/pub/siduction/iso)   
   rsync://rsync.lug.udel.edu/siduction/iso  
   </ul>  

deb ftp://ftp.lug.udel.edu/pub/siduction/base unstable main  
deb-src ftp://ftp.lug.udel.edu/pub/siduction/base unstable main  
deb ftp://ftp.lug.udel.edu/pub/siduction/fixes unstable main  
deb-src ftp://ftp.lug.udel.edu/pub/siduction/fixes unstable main  
~~~

+  **`Georgia Tech`**   
    [http://www.gtlib.gatech.edu/pub/siduction/iso](http://www.gtlib.gatech.edu/pub/siduction/iso)   
    [ftp://ftp.gtlib.gatech.edu/pub/siduction/iso](ftp://ftp.gtlib.gatech.edu/pub/siduction/iso) rsync://rsync.gtlib.gatech.edu/siduction/iso  

#### South America

+  **`Universidade Estadual de Campinas (unicamp), São Paulo, Brasilien`**   
    [http://www.las.ic.unicamp.br/pub/siduction/iso/](http://www.las.ic.unicamp.br/pub/siduction/iso/)   
    [ftp://www.las.ic.unicamp.br/pub/siduction/iso/](ftp://www.las.ic.unicamp.br/pub/siduction/iso/)   

~~~  
deb ftp://www.las.ic.unicamp.br/pub/siduction/base unstable main  
deb-src ftp://www.las.ic.unicamp.br/pub/siduction/base unstable main  
deb ftp://www.las.ic.unicamp.br/pub/siduction/fixes unstable main  
deb-src ftp://www.las.ic.unicamp.br/pub/siduction/fixes unstable main  
~~~

#### Asia

+   

#### Africa

+   

#### Australia

+   

<div class="divider" id="siduction-def"></div>
### Definições dos arquivos em cada espelho

Cada espelho do siduction apresenta os seguintes arquivos:

~~~  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
SOURCES  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.arch.manifest  
siduction-20xx-xx-release-name-window-manager-arch-datetimestamp.iso  
~~~

O arquivo com extensão `.manifest`  lista todos os pacotes contidos na iso.

O arquivo com extensão `.iso`  é a imagem a ser baixada.

Os arquivos `.md5 e .sh256`  servem para confirmar a integridade da ISO.

Escolha um link mais perto de você. Os links para o download e os espelhos também podem ser encontrados em  [siduction.org](http://siduction.org) .

Se você ou alguém que você conheça possuir um servidor de FTP rápido, com suficiente tráfico à disposição, favor informar  
a equipe do siduction nos  [fóruns do siduction](http://siduction.org/)  ou ainda em nosso canal de IRC em oftc.net irc://irc.oftc.net:6667 #siduction ou #siduction-br.

<div class="divider" id="md5"></div>
## md5sum e validação

###### **`OBSERVAÇÃO MUITO IMPORTANTE:`** `o siduction, como LiveCD do Linux, é baseado em tecnologia de alta compressão. Por isso, cuidados especiais são necessários ao queimar a imagem ISO: use apenas mídias de alta qualidade [CD ou DVD+RW] e queime no **`modo DAO (disk-at-once)`**  e em velocidade não superior a 8x.` 


---

O método seguinte é usado para verificar a integridade de arquivos. A soma do md5sum encontrada é comparada com uma soma já conhecida. Assim, você pode verificar se um arquivo foi alterado ou sofreu danos; essa checagem é altamente recomendada para arquivos baixados pela internet.

Se o valor do md5 do arquivo baixado corresponder ao valor do md5 do arquivo original, você pode estar seguro de que o arquivo foi baixado corretamente. No Linux, a verificação é feita com este comando (o cálculo demora um pouquinho):

~~~  
$ md5sum arquivo_para_checar  
~~~

A soma será escrita no próprio terminal.  
Esta validação também pode ser feita no Windows. Basta instalar o programa "md5sum" (486 kb).

As imagens ISO do siduction são sempre acompanhadas pelo arquivo de checagem do md5 (ele possui a extensão .md5) e você deve sempre validá-las antes de queimá-las. Isto garante que, se ocorrerem problemas, eles não são causados pelo arquivo que você baixou e ainda mantém o fórum do siduction livre de questões não solucionadas só porque a ISO estava danificada. Isto é feito no terminal. Mude para o diretório onde estão os arquivos com a imagem ISO e com o arquivo .md5 e digite o seguinte comando para validar a soma md5sum:

Baixe os seguintes arquivos, diretamente do espelho:

~~~  
MD5SUM  
MD5SUM.gpg  
SHA256SUM  
SHA256SUM.gpg  
~~~

Agora, digite no terminal:

~~~  
$ md5sum siduction.iso  
~~~

Se os valores encontrados não forem os mesmos, você verá uma mensagem de erro:

~~~  
"siduction.iso: Error  
md5sum: Warning: calculated checksum does not match! (md5sum: Aviso: soma calculada não confere!)"  
~~~

Se o arquivo tiver sido baixado corretamente, o programa finaliza sem nenhuma mensagem.

<div class="divider" id="burn-nero"></div>
## Como eu queimo o CD no Windows?

###### **`OBSERVAÇÃO MUITO IMPORTANTE:`** `o siduction, como LiveCD do Linux, é baseado em tecnologia de alta compressão. Por isso, cuidados especiais são necessários ao queimar a imagem ISO: use apenas mídias de alta qualidade [CD ou DVD+RW] e queime no **`modo DAO (disk-at-once)`**  e em velocidade não superior a 8x.` 


---

Naturalmente, também é possível queimar o CD no Windows. O arquivo baixado deve ser queimado como um arquivo ISO. Se o Winrar (ou qualquer outro programa de compressão) estiver associado ao arquivo .ISO, podem ocorrer problemas, porque ele será visto como um simples arquivo. Portanto, queime um CD diretamente do .ISO. **`Não queime o arquivo ISO como disco de dados!! É necessário queimá-lo no modo Disk-At-Once`** 

Existem vários e bons programas que você pode usar no Windows:

##### Queimadores de código aberto

 [cdrtfe](http://cdrtfe.sourceforge.net/)  : compatível com Windows 9x/ME/2000/XP (testado no Win95, Win98SE, Win2000 e WinXP); somente no Win9x/ME: Camada ASPI funcional (p.ex. Adaptec ASPI 4.60)

 [LinuxLive USB Creator](http://www.linuxliveusb.com) , um projeto de código aberto oferecendo um programa gráfico para o MS Windows&#8482;, que possibilita instalar um siduction-i386.iso de 32 bits a um pendrive. `Você terá que acrescentar o cheatcode **`fromhd`**  à linha de boot` .

###### Queimadores de código fechado e proprietários

+  Nero (não o Nero Express!)  
+ Outra boa ferramenta freeware é  [CD/DVD Burner XP pro](http://www.cdburnerxp.se/)   
+ Burncdcc da  [terabyteunlimited](http://www.terabyteunlimited.com/utilities.html)  (só queima ISOs...)  

<div class="divider" id="burn-linux"></div>
## Como queimar o CD no Linux?

###### **`OBSERVAÇÃO MUITO IMPORTANTE:`** `o siduction, como LiveCD do Linux, é baseado em tecnologia de alta compressão. Por isso, cuidados especiais são necessários ao queimar a imagem ISO: use apenas mídias de alta qualidade [CD ou DVD+RW] e queime no **`modo DAO (disk-at-once)`**  e em velocidade não superior a 8x.` 


---

Se você já roda Linux em sua máquina, você pode queimar o CD tanto pela linha de comando quanto usando algum programa já existente no sistema operacional.

Para tarefas desse tipo, o siduction e outras distribuições instalam o K3b por padrão. Basta abri-lo, clicar em Ferramentas -> Queimar imagem de CD e selecionar o arquivo ISO a ser queimado (p. ex. siduction.iso).

O K3B inicialmente calcula a soma do MD5 para a imagem ISO (o que demora um momento). Se o resultado for igual ao apresentado pelo arquivo MD5 (isto é, o siduction.iso.md5), você pode queimar a imagem, bastando para tal clicar em "Queimar".

`A maioria dos problemas na hora de queimar acontecem com programas gráficos. Você pode queimar diretamente pelo terminal com  [burniso](cd-no-gui-burn-pt-br.htm) .` 

###### Veja também  [Instalando uma ISO siduction em Dispositivos USB ou sdhc e Cartões SSD com Qualquer Linux, MS Windows(tm); ou Mac OS X(tm);](hd-ins-opts-oos-pt-br.htm#raw-usb) .

<div id="rev">Content last revised Sat, 02 Jun 2012 22:41:33 +0200</div>
