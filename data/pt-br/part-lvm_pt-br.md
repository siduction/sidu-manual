<div id="main-page"></div>
<div class="divider" id="part-lvm"></div>
## LVM -particionar para o uso de Logical Volume Manager

**`Este é um guia básico para você começar. É de sua responsabilidade aprender mais sobre o LVM. No fim desta página vai encontrar fontes e URL que lhe servirão de ajuda, no entanto, a lista é definitivamente não exaustiva.`** 

válido para as versões do siduction depois do siduction 2010-03 "Ἀπάτη".

Volumes lógicos podem se estender por vários discos e são escaláveis, ao contrário do método tradicional de particionamento de discos rígidos. 

No entanto, seja qual for o método de particionamento que utilizar o tradicional ou para o uso de LVM, particionamento não é algo que você faz com muita frequência, portanto, exige uma profunda reflexão, ao mesmo tempo experimentar e corrigir, até que você fique satisfeito com o resultado obtido.

Existem três condições básicas da terminologia de que você precisa conhecer:

+ `Volumes físicos:`  Estes são os seus discos físicos ou partições de disco, como /dev/sda ou / dev/sdb1. Estes são o que você estaria acostumado a usar na montagem / desmontagem de coisas. Usando LVM podemos combinar múltiplos volumes físicos em grupos de volume.  
+ `Grupos de volumes:`  Um "grupo de volume" é composto de "volumes físicos" reais, e é o armazenamento usado para criar "volumes lógicos" que você pode criar/redimensionar/ remover e utilizar. Você pode considerar um "grupo de volume" como um "disco virtual" criado a partir de "volumes físicos". Você vai poder cortá-lo em "partições virtuais", que são "volumes lógicos".  
+ `Volumes lógicos:`  volumes lógicos são os volumes que você vai finalmente acabar por montar (utilizar) no seu sistema. Eles podem ser adicionados, removidos e redimensionada a quente "on the fly". Uma vez que os "volumes lógicos" estão contidos nos grupos de volume vão poder ser maiores do que qualquer único volume físico que possa ter. (Ou seja, 4 x 250GB drives podem ser combinados num grupo de volume de 1 TB, em seguida, dividido para criar 2 x 500GB volumes lógicos.)  

### São 6 as etapas básicas necessários

`Para o exemplo apresentado vamos que os discos não estao particionado, ou que é necessário um esquema de particionamento completamente novovo e que por isso vamos apagar todos os dados existentes nas partições que você deseja converter para um LVM.` 

O uso de cfdisk ou fdisk é necessária, pois até à data Gparted e KDE Partition Manager, (partitionmanager), não suportam particionamento LVM.

`1º Passo:`  Criar a tabela de partição:

~~~  
cfdisk /dev/sda  
n para criar uma partição nova no disco  
p para escolher partição primária  
1 emtrar o número da partição (1 para a 1ª)  
`### size allocation  ### defina o primeiro e o último cilindro para fixar o tamanho da partição  
t para definir o typo da partição que quer criar  
8e é o codigo hexadecimal para Linux LVM  
W para escrever a nova tabela de partição no disco. Antes de completar este passo pode anular tudo e reiniciar ou acabar o programa sem escrever nada e restaurar a tabela de partições inicial.##  
~~~

Se você quiser um volume para abranger dois ou mais discos, repita esse processo em cada um dos discos.

`2º Passo:`  Configurar a partição como um volume físico. Isto vai apagar qualquer dados existentes:

~~~  
pvcreate /dev/sda1  
~~~

Repita tantas vezes quantas as necessárias para as partições que deseja utilizar

`3º Passo:`  Criar o grupo de volumes:

~~~  
vgcreate vulcan /dev/sda1  
~~~

Para incluir no grupo de volume pode entrar estes no comando de criação vgcreate:

~~~  
vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1  
~~~

Se executou os camndos anteriores corretamente, vai poder vêr o resultado utilizando o comando "vgscan":

~~~  
vgscan  
~~~

"vgdisplay" mostra as propriedades do grupo de volumes:

~~~  
vgdisplay vulcan  
~~~

`4º Passo:`  Criar o volume lógico. Agora é hora de você decidir como vai definir o volume lógico. Uma vantagem do LVM é que você pode ajustar o tamanho do volume à vontade, sem precisar reiniciar a máquina.

Vamos usar inicialmente 300GB num volume chamado "spock" no grupo de volumes a que chamamos "vulcan":

~~~  
lvcreate -n spock --size 300g vulcan  
~~~

`5º Passo:`  Agora podemos formatar o volume ( seja paciente a formatação pode demorar um pouco, tudo vai depender do tamanho):

~~~  
mkfs.ext4 /dev/vulcan/spock  
~~~

`6º Passo:` 

~~~  
mkdir /media/spock/  
~~~

Utilize o seu editor favorito para entrar a linha correcta no "fstab" para montar o volume na fase de arranque do sistema. 

~~~  
mcedit /etc/fstab  
~~~

É melhor usar `/dev/vulcan/spock`  é do que utilizar UUID com LVM, pois você pode clonar o sistema de arquivos e não precisa se preocupar com possíveis colisões UUID, especialmente com LVM. Você pode acabar com vários sistemas de arquivos com o mesmo número UUID (snapshots é um excelente exemplo).

~~~  
/dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2  
~~~

`Facultativo:`  Você pode mudar os direitos no volume de modo a que outros utilizadores tenham acesso ao LVM:

~~~  
chown root:users /media/spock  
~~~

~~~  
chmod 774 /media/spock  
~~~

E assim finalizamos a configuração básica do LVM.

### Redimensionar o volume

`É altamente recomendado que você use um ISO live para mudar o tamanho das partições` . Enquanto aumentar o tamanho da partição 'on the fly' pode ser isento de erros, o mesmo não pode ser dito quando à redução do mesmo. Em caso de anomalias pode causar perda de dados, especialmente se **`/ (root)`**  ou **`/home`**  estão em causa.

##### Redimensionar o volume de 300 GB para 500 GB, como usado no nosso exemplo:

~~~  
umount /media/spock/  
~~~

~~~  
lvextend -L+200g /dev/vulcan/spock  
~~~

Em seguida deve executar o comando para o sistema de arquivos para ser redimensionado:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### Redimensionar o volume de 300 GB para 280 GB, como usado no nosso exemplo:

~~~  
umount /media/spock/  
~~~

Executar o comando para o sistema de arquivos para ser redimensionado:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock 280g  
~~~

Depois redimensionar o volume

~~~  
lvreduce -L-20g /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### Configurar gráficamente os seus volume LVM

`system-config-lvm`  tem uma interface gráfica e está disponível para ajudá-lo na administração dos seus volumes LVMs e pode ser lançado da linha de comando:

~~~  
apt-get install system-config-lvm  
man system-config-lvm `# leitura obrigatória   
~~~

##### Fontes e links:

+  [Debian Administration - A simple introduction to working with LVM](http://www.debian-administration.org/articles/410)   
+  [IBM - Logical volume management](http://www.ibm.com/developerworks/linux/library/l-lvm2/)   
+  [IBM - Resizing Linux partitions, Part 2: Advanced resizing](http://www.ibm.com/developerworks/linux/library/l-resizing-partitions-2/index.html)   
+   [Red Hat - LVM Administrator's Guide](http://docs.google.com/viewer?a=v&amp;q=cache:1RMpacheCBcJ:www.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/5.4/pdf/Logical_Volume_Manager_Administration.pdf+%22Logical+Volume+Manager+Administration+%22&amp;hl=en&amp;pid=bl&amp;srcid=ADGEEShRiptIjzsnPNsCs4RgyUFNWkYcrDc3SkBSD6cTq39D6wye5JM3tP_ehcn37I5VWs84I_HI45rvG-n6YG4R2fE8hqDByq-KPhNEkha4zwphrR7QIUVnUz6omwY85e-ZEXX723Js&amp;sig=AHIEtbSJyxEst6Wue7_1_TeDYwB480azEw)   
+   [Logical Volume Manager (Linux)](http://en.wikipedia.org/wiki/Logical_Volume_Manager_%28Linux%29)   
+   [Setting up an LVM for Storage](http://thelinuxexperiment.com/guinea-pigs/jon-f/setting-up-an-lvm-for-storage/)   
+   [Creating a LVM in Linux](http://linuxhelp.blogspot.com/2005/04/creating-lvm-in-linux.html)   
+   [Linux lvm - Logical Volume Manager](http://www.linuxconfig.org/Linux_lvm_-_Logical_Volume_Manager)   

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
