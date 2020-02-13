<div id="main-page"></div>
<div class="divider" id="uuid"></div>
## Rebuilding fstab and creating mount points

`By default siduction uses uuid in your fstab when you install.`

Para mostrar uma nova partição (digamos sda6 ou sdb7), que não aparece na fstab ou não quer ser montada, abra o terminal e digite o seguinte, como usuário ($):

~~~  
ls -l /dev/disk/by-uuid  
~~~

Você verá uma saída como esta (o negrito é somente para fins de exemplo):

~~~  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 348ea9e6-7879-4332-8d7a-915507574a80 -> ../../sda4  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 610aaaeb-a65e-4269-9714-b26a1388a106 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 857c5e63-c9be-4080-b4c2-72d606435051 -> ../../sda5  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42 a83b8ede-a9df-4df6-bfc7-02b8b7a5f1f2 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-27 23:42  ad662d33-6934-459c-a128-bdf0393e0f44  -> ../../sda6  
~~~

Nesse exemplo,  **ad662d33-6934-459c-a128-bdf0393e0f44**  é o item faltante. O próximo passo é colocar os dados UUID dessa partição no arquivo /etc/fstab. Para isso, abra-o em um editor de texto (como kate ou kwrite), com privilégios de root:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=ad662d33-6934-459c-a128-bdf0393e0f44  /media/disk1part6 ext4 auto,users,exec 0 2    
~~~
  
Outro exemplo:

~~~  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 30ebb8eb-8f22-460c-b8dd-59140274829d -> ../../sdb8  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 387d6d4b-4508-4b8e-8ed2-76998f41dae4 -> ../../sdb1  
rwxrwxrwx 1 root root 10 2007-05-28 13:18 7014f66f-6cdf-4fe1-83da-9cab7b6fab1a -> ../../sdb5  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 8f042ead-259f-4df0-98ec-3343080396c5 -> ../../sdb6  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 94B0AE63B0AE4B94 -> ../../sda2  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 A61820AA18207B85 -> ../../sda1  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f28725d6-b7b5-4207-8476-36efe1a903ce -> ../../sdb9  
lrwxrwxrwx 1 root root 10 2007-05-28 13:18 f855c263-2521-48d3-8ec9-d2d2b69b6635 -> ../../sda3  
rwxrwxrwx 1 root root 10 2007-05-28 13:18  f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  -> ../../sdb7  
~~~

No caso acima,  **f9aa4027-ecdd-4a86-84e2-df2ef73fe14e**  é a partição a ser colocada na fstab:

~~~  
# <device file system> <mount point> <type> <options> <dump> <pass>    
 UUID=f9aa4027-ecdd-4a86-84e2-df2ef73fe14e  /media/disk2part7 ext4 auto,users,exec 0 2    
~~~
  
### Criação de novos pontos de montagem
  
 `Nota:`  Todo o pomto de montagem necessita de um dirétorio existente. siduction cria estes diretórios como subdiretórios de `/media`  durante o processo de instalação, os nomes atribuidos são semelhantes a `diskXpartX` .

Se você alterar a tabela de partiçôes depois da instalação e supondo que você altera o ficheiro fstab, (por exemplo, 2 novas partilões ) o diretório para o ponto de montagem não exist. Você necessita de o criar manualmente.

##### Exemplo:

Primeiro, como root verifique os pontos de montagem existentes:

~~~  
cd /media  
ls  
~~~

a lista dos pontos de montagem e mostrada, por exemplo:

~~~  
disk1part1 disk1part3 disk2part1  
~~~

Staying in /media, create the mount points of the new partitions:

Permanecendo em /media, crie os novos pontos de montagem para as partições novas:

~~~  
mkdir disk1part6  
mkdir disk2part7  
~~~

Para testar ou usar as partições imediatamente::

~~~  
mount /dev/sda6 /media/disk1part6  
mount /dev/sda6 /media/disk2part7  
~~~

Depois de um reboot a partição será (ou não) montada automáticament tudo dependendo das opções que você escreveu no fstab. Dê uma vista de olhos às pagens do manual:

~~~  
man mount  
man fstab  
~~~

<div class="divider" id="uuid-fstab"></div>
## Uma visão geral: UUID, como rotular partições e a fstab

A nomeação persistente de dispositivos tornou-se possível com a introdução do 'udev' e possui algumas vantagens sobre o método anterior, baseado no 'bus'.

Enquanto as distribuições Linux e o udev evoluem e a detecção de hardware tem se tornado mais confiável, há um novo número de problemas e mudanças:  
 **1)**  Se você tiver mais de um controlador de discos SATA/SCSI ou IDE, eles são adicionados em ordem aleatória. Isso pode resultar em nomes como hdX e hdY fazendo rodízio a cada boot. O mesmo vale para sdX e sdY. A nomeação persistente permite que você nunca mais se preocupe com isso.  
 **2)**  Com a introdução do suporte à nova biblioteca libata pata, todos os seus dispositivos IDE 'hdX' tornar-se-ão 'sdX' num futuro próximo. Por causa da nomeação persisitente, você nem vai notar.  
 **3)**  Máquinas com controladores tanto IDE quanto SATA são bastante comuns hoje em dia. Com as mudanças na libata mencionadas acima, o primeiro problema irá tornar-se ainda mais comum, porque tanto os HDs de um como do outro serão chamados de sdX.

`O padrão do siduction, ao ser instalado, é usar UUID na fstab`

Há outros motivos, mas esses são os principais hoje e no futuro próximo. Porisso, o siduction encoraja-o a usar a persistência em suas configurações.

## Os quatro diferentes esquemas de nomeação persistente:

#### 1. Pelo UUID

UUID significa Universally Unique Identifier (Identificador Único Universal) e é um mecanismo para dar a cada sistema de arquivos um identificador único. Ele foi planejado para que colisões sejam improváveis. Todos os sistemas de arquivos Linux, inclusive a swap, aceitam UUID. Já NTFS e FAT não aceitam; porém, ainda assim, elas são listadas na fstab no formato UUID, ou seja "by-uuid", com um identificador único, caracteristicamente com menos caracteres:

~~~  
$ /bin/ls -lF /dev/disk/by-uuid/  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 2d781b26-0285-421a-b9d0-d4a0d3b55680 -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 31f8eb0d-612b-4805-835e-0e6d8b8c5591 -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 3FC2-3DDB -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 5090093f-e023-4a93-b2b6-8a9568dd23dc -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 912c7844-5430-4eea-b55c-e23f8959a8ee -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 B0DC1977DC193954 -> ../../sdb1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 bae98338-ec29-4beb-aacf-107e44599b2e -> ../../sdb2  
~~~

Como se pode ver, as partições FAT e NTFS possuem nomes menores (sda6 e sdb1), mas ainda assim são listadas pelo uuid.

#### 2. Pelo rótulo (LABEL)

Praticamente todo tipo de sistema de arquivos pode ter um rótulo. Todas as suas partições que possuem um são listadas no diretório /dev/disk/by-label directory:

~~~  
$ ls -lF /dev/disk/by-label  
total 0  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data -> ../../sdb2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 data2 -> ../../sda2  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 fat -> ../../sda6  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 home -> ../../sda7  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 root -> ../../sda1  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 swap -> ../../sda5  
lrwxrwxrwx 1 root root 10 Oct 16 10:27 windows -> ../../sdb1  
~~~

Ainda que os rótulos sejam formados por nomes reconhecíveis, você precisa ser bastante cauteloso para impedir colisões.

Os rótulos podem ser mudados usando-se estes comandos:

~~~  
* swap: Crie uma nova partição swap com: mkswap -L <rótulo> /dev/XXX  
* ext2/ext3/ext4: e2label /dev/XXX <rótulo>  
* jfs: jfs_tune -L <rótulo> /dev/XXX  
* xfs: xfs_admin -L <rótulo> /dev/XXX  
* fat/vfat: Ainda não há aplicativo que faça isso no Linux...  
mas quando criar o sistema de arquivos, use mkdosfs -n <rótulo> <outras opções>.  
Você também pode mudar o rótulo no Windows.  
* ntfs: ntfslabel /dev/XXX <rótulo> ou mude pelo Windows.  
~~~

`Tenha cuidado: para que isso funcione corretamente, os rótulos têm de ser únicos! Isso vale ao mesmo tempo para dispositivos USB/firewire, como pendrives, e para discos rígidos. A sintaxe LABEL=/ UUID= é preferível sobre /dev/disk/by-*/ para partições UN*X.`

#### 3. Pelo id 

'by-id' cria um nome único baseado no número serial do hardware.

#### 4. Pelo path

'by-path' cria um nome único baseado na rota física mais curta (de acordo com o sysfs). Tanto "by-id" quanto "by-path" contêm strings que indicam a qual subsistema eles pertencem e assim não estão habilitados para resolver os problemas mencionados no início deste tópico. Não trataremos mais deles aqui.

#### Como ativar a nomeação persistente

Tendo escolhido o método de nomeação que você deseja usar, vamos agora ativar a persistência em seu sistema:

#### Na fstab

Habilitar persistência no arquivo /etc/fstab é fácil; simplesmente substitua o nome do dispositivo na primeira coluna pelo nome persistente. No exemplo abaixo, vamos substituir /dev/sda7 por um dos seguintes:

~~~  
/dev/disk/by-label/home ou  
/dev/disk/by-uuid/31f8eb0d-612b-4805-835e-0e6d8b8c5591  
~~~

Faça deste mesmo jeito para todas as partições em sua fstab.

Ao invés de citar o dispositivo explicitamente, pode-se indicar o sistema de arquivos a ser montado por UUID ou pelo seu rótulo do volume, escrevendo LABEL=&lt;rótulo&gt; ou UUID=&lt;uuid&gt;. Por exemplo:

~~~  
LABEL=Boot  
~~~

ou

~~~  
UUID=3e6be9de-8139-11d1-9106-a43f08d823a6  
~~~

Fonte:  [wiki.archlinux.org](http://wiki.archlinux.org/index.php/Persistent_block_device_naming)  que usou  [marc.theaimsgroup.com](http://marc.theaimsgroup.com/?l=linux-hotplug-devel&amp;m=114795097514527&amp;w=2) . O conteúdo de wiki.archlinux.org é disponibilizado sob a GNU Free Documentation License 1.2 e foi reeditado para o Manual do siduction.

 [Mais sobre rotulação ('labelling') pode ser encontrado em lissot.net](http://www.lissot.net/partition/ext2fs/labels.html)  

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
