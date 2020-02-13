<div id="main-page"></div>
<div class="divider" id="install-crypt"></div>
## Instalando no cryptoroot

**`Por favor tome as seguintes considerações em nota, pois há algumas armadilhas se seguir este manual para chifrar as suas partições seja ela a partição root ou uma partição utilizada para outros fins:`**  

+ método válido para as versões do siduction depois do siduction 2010-03 "Ἀπάτη".  
+ este é um guia básico para iniciar o utilizador. É da sua responsabilidade aprender mais acerca de LUKS, cryptsetup e encriptação. No fundo desta página são listados links de fontes e resources que poderão servir de ajuda. A lista nao é (definitivamente) exaustiva.  
+ cryptsetup não pode chifrar partições já contendo ficheiros, por isso tem que ser criada uma partição nova. Você pode copiar depois os seus dados de volta.  
+ cryptsetup permite usar até 8 ficheiros chave e ter chaves múltiplas para as partições. Este aspecto não será focado neste guia.  
+ `Não esqueça as frases chaves que escolheu. É a maneira mais fácil de perder todos os seue dados. Náo há possiblidade de os recuperar!`   
+ relativamente cedo, durante o processo de arranque do sistema, você tem que entrar a frase chave que escolheu para os dispositivos chifrados. Só depois disso é que o processo de arranque pode ser completado.  

### Exemplos de encriptação:

+  [Usando crypt com grupos LVM](hd-install-crypt-pt-br.htm#lvm) .  
+  [Notícias ácerca de encriptação com métodos tradicionais de particionamento](hd-install-crypt-pt-br.htm#simple) .  

<div class="divider" id="lvm"></div>
## Usando crypt com grupos LVM

<span class= "highlight-3">Este exemplo usa encriptação dentro de um volume LVM permitindo separar home da raíz <span class= "highlight-2"> / </span> e ter uma partição de swap sem necessidade de palavras chave múltiplas e é aplicável a partir do siduction 2010-03 "Ἀπάτη".</span>

Antes de lançar a aplicação para instalar o siduction, o sistema tem que ser preparado. Para linhas de orientação básica em LVM veja  [Logical Volume Manager - LVM particionamento](part-lvm-pt-br.htm#part=lvm) . 

Você necessita pelo menos de um partição não chifrado <span class= "highlight-3">/boot </span> assim como partições chifradas para <span class= "highlight-2"> / </span> <span class= "highlight-3">/home</span> e <span class= "highlight-3">swap</span>. 

1. se não quer utilizar um volume group já existente, então tem que criar um novo. Vamos supôr para o que se segue que o volume grupo será chamado <span class= "highlight-3">vg</span> e vai conter a partição para o arranque (boot) e para os ficheiros do utilizador (data).  
2. No volume grupo <span class= "highlight-3">vg</span> vão ser criados dois volume lógicos usando <span class= "highlight-3">lvcreate</span> atribuindo-lhes o tamanho desejado:  
   ~~~    
   lvcreate -n boot --size 250m vg    
   lvcreate -n crypt --size 300g vg    
   ~~~
  
   No nosso exemplo atribuimos-lhe os nomes de <span class= "highlight-3">boot</span> e <span class= "highlight-3">crypt</span> com um tamanho de 250MB e 300GB respetivamente..  
3. Formate o volume a ser utilizado para o <span class= "highlight-3">/boot</span> de modo a poder ser utilizado na instalação:  
   ~~~    
   mkfs.ext4 /dev/mapper/vg-boot    
   ~~~
  
4. Use <span class= "highlight-3">cryptsetup</span> para encriptar <span class= "highlight-3">vg-crypt</span> Utilize a opção xts com a chave mais forte possível ( 512 bit). Depois de chifrado abra-o. Vai ter que entrar a frase chave três vezes duas antes de encriptar e uma terceira para poder abrir. Ao abrir atribua-lhe o nome de "cryptroot":  
   ~~~    
   cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/mapper/vg-crypt    
   ~~~
  
   ~~~    
   cryptsetup luksOpen /dev/mapper/vg-crypt cryptroot    
   ~~~
  
5. Agora vamos usar lvm de novo para criar um novo volume grupo que vamos utilizar para os dispositivos do <span class= "highlight-3">/swap</span> e <span class= "highlight-3">/home</span>. Primeiro criamos um volume físico com <span class= "highlight-3">pvcreate</span> que depois utilizamos para definir volume lógicos num novo volume grupo ao qual pomos o nome de <span class= "highlight-3">cryptvg</span>:  
   ~~~    
   pvcreate /dev/mapper/cryptroot    
   vgcreate cryptvg /dev/mapper/cryptroot    
   ~~~
  
6. podemos então usar <span class= "highlight-3">lvcreate</span> para criar os volume lógicos <span class= "highlight-2"> / </span>, <span class= "highlight-3">/swap</span> e <span class= "highlight-3">/home </span>atribuindo-lhes o tamanho que desejarmos:  
   ~~~    
   lvcreate -n swap --size 2g cryptvg    
   lvcreate -n root --size 40g cryptvg    
   lvcreate -n home --size 80g cryptvg    
   ~~~
  
   No nosso exemplo demos-lhes o nome de "swap", "root" e "home" com um tamanho de 2Gb, 40Gb e 80Gb respetivamente.  
7. finalmente formatamos os volume lógicos para torná-los acessíveis á instalação:  
   ~~~    
   mkswap /dev/mapper/cryptvg-swap    
   mkfs.ext4 /dev/mapper/cryptvg-root    
   mkfs.ext4 /dev/mapper/cryptvg-home    
   ~~~
  
8.  **Estamos prontos para poder instalar o siduction no qual utilizaremos:**   
   <span class= "highlight-3">vg-boot</span> para <span class= "highlight-3">/boot</span>,  
   <span class= "highlight-3">cryptvg-root</span> para <span class= "highlight-2"> /</span>,  
   <span class= "highlight-3">cryptvg-home</span> para <span class= "highlight-3">/home</span>,  
   and <span class= "highlight-3">cryptvg-swap</span> para <span class= "highlight-3">swap</span> deverá ser reconhecida automáticamente.  

O sistema instalado terá uma entrada para o kernel incluindo as opções seguintess:

~~~  
root=/dev/mapper/cryptvg-root cryptopts=source=/dev/mapper/vg-crypt,target=cryptroot,lvm=cryptvg-root  
~~~

O sistema tem então os volumes lógicos "crypt" e "boot" no volume "vg". "root", "home" e "swap" estão contidos no volume encryptado "vgcrypt" protegidos pela sua própria frase chave.

<span class= "highlight-3">Note bem:</span> Se estiver a efetuar uma reinstalação utilizando um volume lvm préviamente encriptado, para tornar as partições encripatdas acessíveis ao programa de instalação tem que registar estas no kernel. Para isso são necessários os comandos seguintes:

~~~  
cryptsetup luksOpen /dev/mapper/cryptvg-root cryptvg  
vgchange -a y  
~~~

<div class="divider" id="simple"></div>
## Notícias ácerca de encriptação com métodos tradicionais de particionamento

A primeira decisão a ser tomada tem que definir as partições que queremos usar. No mínimo são precisas duas partições uma a partição de arranque `/boot`  e a outra para os ficheiros encriptados. 

Se o `swap`  é necessário ( que deverá ser encriptado) então o número de particões eleva-se a três. Neste caso durante o processo de arranque do sistema também é necessário entrar a frase chave para o `swap`  separadamente.

É possível utilizar ficheiros chaves, contidos na partição encriptada `/`  para a partição do `swap`  mas deste modo não é permitido o "suspend to disk". Por esta razão é de preferir a uitlização dos volumes do LVM com partições completamente encriptadas..

<!--It is possible to use keys for the swap from inside the encrypted system with traditional partitioning, however you will not be able to suspend to disk. Due to these issues, LVM volumes with fully encrypted partitions with keys is definitely the better option in the long term.

-->
###### Condições essenciais:

+  você tem pelo menos três partiçôes disponíveis:  
   `/boot` , com 250mb  
   `swap` , com 2 gig  
   **`/`**  e `/home`  juntas.  
+ duas frases chave vão ser necessárias, uma para o **`swap`**  e a outra para **`/`**  e `/home`  juntas.  

Depois de ter particionado o disco, precisamos de preparar as partições encriptadas. Estes passos têm que ser feitas num terminal do utilizador root.

##### A partição /boot 

Caso a partição `/boot`  (no nosso exemplo /dev/sda1) ainda não esteja formatada, Formate-a com ext4:

~~~  
/sbin/mkfs.ext4 /dev/sda1  
~~~

##### Partição swap encriptada

Para a partição encriptada do `swap`  (no nosso exemplo /dev/sda2), primeiro precisamos de encriptar a partição, depois abrir o dispositivo encriptado e adiciona-lo ao crypttab.


cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda2  
</li>  
~~~

~~~  
cryptsetup luksOpen /dev/sda2 swap  
</li>  
~~~

~~~  
echo "swap UUID=$(blkid -o value -s UUID /dev/sda2) none luks" >> /etc/crypttab  
</li>  
~~~

</ol>
Finalment podemos formatá-la `/dev/mapper/swap`  de modo a ser reconhecida pelo installer:

~~~  
/sbin/mkswap /dev/mapper/swap  
~~~

##### Partição encriptada / 

Para `/`  ( no nosso exemplo /dev/sda3) fazemos os passos necessários como para o swap não sendo porém necessário adicionar a partição ao crypttab.

~~~  
cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda3  
~~~

~~~  
cryptsetup luksOpen /dev/sda3 cryptroot  
~~~

Para o formato utilizamos ext4 para poder ser reconhecida pelo installer como `/dev/mapper/cryptroot`  :

~~~  
/sbin/mkfs.ext4 /dev/mapper/cryptroot  
~~~

### Lançar o installer

 **Agora temos tudo preparado para lançar a instalação aonde iremos escolher:**   
<span class= "highlight-3">sda1</span> para <span class= "highlight-3">/boot</span>,  
<span class= "highlight-3">cryptroot</span> para <span class= "highlight-2"> /</span> e <span class= "highlight-3"> /home</span>  
<span class= "highlight-3">swap</span> deverá ser reconhecida automáticamente.

O sistema instalado terá uma entrada para o kernel incluindo as opções seguintes (o UUID apropriado vai ser utilizado em cada instalação):

~~~  
root=/dev/mapper/cryptroot cryptopts=source=UUID=12345678-1234-1234-1234-1234567890AB,target=cryptroot  
~~~

O sistema tem então <span class= "highlight-3">boot</span> numa partição não encriptada e <span class= "highlight-3">swap</span> conjuntamente com <span class= "highlight-3">/ </span> em partições encriptadas.

### Fontes e links:

Leitura obrigatória:

~~~  
man cryptsetup  
~~~

 [LUKS](http://code.google.com/p/cryptsetup/) .

 [Redhat](http://www.redhat.com/)  e  [Fedora](http://www.redhat.com/Fedora/) .

 [Protect Your Stuff With Encrypted Linux Partitions](http://www.enterprisenetworkingplanet.com/netsecur/article.php/3683011) .

 [KVM how to use encrypted images](http://blog.bodhizazen.net/linux/kvm-how-to-use-encrypted-images/) .

 [siduction wiki](http://wiki.siduction.de/index.php?title=Installation_auf_einer_verschl%C3%Bcsselten_Festplatte) .

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
