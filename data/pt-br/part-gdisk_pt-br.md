<div id="main-page"></div>
<div class="divider" id="gdisk-1"></div>
## GPT gdisk partitioning overview

GPT gdisk, Globally Unique Identifier (GUID) Partition Table (GPT), é um programa para particionar discos duros de qualquer tamanho `e absolutamente necessário para discos que excedem 2TB em tamanho` . As partições criadas emm SSDs (ou em discos rígidos que não têm setores de 512 bytes) com gdisk são sempre correctamente alinhadas .

Uma das vantagens principais do particionamento com GPT é não haver necessidade de partições primárias ou lógicas ( específicas e necessárias quando se usa MBR) e não haver qualquer limite no número de partições num disco ( embora `gdisk`  reserve para o efeito apenas espaço para 128 partições).

Contudo o uso de GPT em discos ou pen USB/SSD de pequeneo tamanho ( por exemplo 8GB ) não é recomendado, em especial, se vão ser utilizados frequentemente para transferir ficheiros entre sistemas operativos diferentes.

<!--**`NOTE : USB booting is not supported with GPT.`** 

-->
### Notas importantes

`Os termps UEFI (Unified Extensible Firmware Interface) e EFI (Extensible Firmware Interface) vão ser utilizados aleatóriamente mas possuem ambos o mesmo significado.` 

##### GPT discos para data

`Alguns sistemas operativos não suportam discos GPT para data. Por favor consulte a respectiva documentação.` 

GPT discos para data são possíveis para sistemas de linux em 32 e em 64 bits.

##### Arranque de disco GPT

Discos com duplo e triplo arranque (boot) com Linux, BSD e Apple são suportados usando o modo `EFI`  em 64 bit.

O arranque dual usando discos com GPT com Linux e MS Windows é possível desde que o MS Windows OS possa fazer o arranque de um disco particionado com GPT usando o modo `UEFI`  em 64 bit,.

##### Ferramentas de particionamento gráfico com suport de GPT

Além do gdisk (baseado na consola) também 'gparted' e 'partitionmanager' fornecem uma interface gráfica com suport para o particionamento GPT. Contudo gdisk é preferível para evitar anomalias indesejáveis causadas pelos programas gráficos. Apesar de tudo 'Gparted - gparted' e 'KDE Partition Manager - partitionmanager', (entre outros), são excelentes ferramentas para fornecer uma representação gráfica do particionamente efectuado.

`Leitura altamente recomendada:`

+ ~~~    
   man gdisk    
   ~~~
  
+  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/)   
+  [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table)   

<div class="divider" id="gdisk-2"></div>
## Como particionar um HD usando o gdisk para uso num sistema Linux

###### Aprender os comandos básicos do gdisk como **`m`**  para regressar ao menu principal, **`d`**  ,**`n`** , **`p`**  e **`t`** , entre outros, os principais commandos necessários quando se usa o gdisk para particionar um disco pelo que vale a pena "treinar" numd disco de "teste".

##### **`IMPORTANTE quando usar o commando "n":`** 

<!--###### After creating the first partition you need to press `< Enter > 2 times`  each time you use **`n`**  to bring up the last sector to set the size of the subsequent partitions.-->

Ao usar o commando **`n`** , é necessário pressionar &lt;Enter&gt; para definir o número da partição e depois novamente &lt;Enter&gt; para aceitar o sector de começo antes de entrar o tamanho que deseja para a partição. Por exemplo:

<!-- ###### Understanding key gdisk commands such as **`m`**  to bring you back to the main menu, **`d`**  ,**`n`** , **`p`**  and **`t`** , amongst others, will in the main, become core commands regarding your gdisk partitioning requirements, and it is worthwhile to explore gdisk on a 'test' disk. -->

<!-- ##### **`IMPORTANT NOTE about the n command:`**  -->

<!-- ###### After creating the first partition you need to press `< Enter > 2 times`  each time you use **`n`**  to bring up the last sector to set the size of the subsequent partitions. -->

<!-- When using the **`n`**  command, you press &lt;Enter&gt; to give the partition the next free number and you then you need to press &lt;Enter&gt; again to accept the default start sector for the next partition before setting the size you need for the last sector. For example:

 -->
~~~  
Command (? for help): n  
Partition number (2-128, default 2): 2  
First sector (34-15728606, default = 411648 ) or {+-}size{KMGTP}:  
Last sector (411648 -15728606, default = 15728606) or {+-}size{KMGTP}: +6144M  
~~~

### Exemplos de particionamento usando GPT

 *Adapte conforme as suas necessidades* :

1. Criação de uma partição de arranque, `(presupondo que o disco não vai ser sómente data e que necessita de ter poder iniciar o sistema)`   
2. Criação de uma partição para swap, `(presupondo que o disco não vai ser sómente data e que necessita de ter poder iniciar o sistema)`   
3. Criação de partições para o linux   
4. Criação de partições para data   

**`Nota: O próximo exemplo usa uma pen USB para efeitos de demonstração dos passos necessários e como tal não é exaustivo.`** 

### os passos

Se necessitar de saber o nome do disco, use fdisk para o determinar: (são necessários privilégios de root para todas as actividades relacionadas com o particionamento e formatação das partições):

~~~  
fdisk -l  
~~~

fdisk mostrar-lhe-á todos os discos e possívelmente incluirá a lista das partições existentes, mas nós só vamos necessitar do nome do disco qualquer que sejam as partições existentes nele. Supondo, por exemplo que se trata de `sdb`  então vamos lançar gdisk com:

~~~  
gdisk /dev/sdb  
~~~

`A primeira mensagem é uma chamada de atenção se o disco não usa GPT ou se se tratar de um disco novo sem uma tabela de partições:` 

~~~  
GPT fdisk (gdisk) version 0.7.2  
Partition table scan:  
MBR: MBR only  
BSD: not present  
APM: not present  
GPT: not present  
***************************************************************  
Found invalid GPT and valid MBR; converting MBR to GPT format.  
THIS OPERATION IS POTENTIALLY DESTRUCTIVE! Exit by typing 'q' if  
you don't want to convert your MBR partitions to GPT format!  
***************************************************************  
Command (? for help):  
~~~

Se o `gdisk`  encontrou um disco com uma tabela de partições MBR sem GPT, então uma mensagem de chamada de atenção é mostrada. `Isto é propositado para assustar o utilizador no caso de ter utilizado um disco errado e impedir que acidentalmete outros discos de arranque MBR sejam destruidos.` 

Entrando **`?`**  vai-lhe mostrar a lista dos comandos, (os comandos `coloridos`  são os comandos de ajuda e documentação):

~~~  
Command (? for help): **`?`**   
b back up GPT data to a file  
c change a partition's name  
d delete a partition  
i show detailed information on a partition  
l list known partition types  
n add a new partition  
o create a new empty GUID partition table (GPT)  
p print the partition table  
q quit without saving changes  
r recovery and transformation options (experts only)  
s sort partitions  
t change a partition's type code  
v verify disk  
w write table to disk and exit  
x extra functionality (experts only)  
? print this menu  
~~~

Para verificar que está a utilizar o disco desejado verifique a lista actual de partições entrando para isso **`p`** .

~~~  
Command (? for help): p   
Disk /dev/sdb: 16547840 sectors, 7.9 GiB This example is using an 8GB stck   
Logical sector size: 512 bytes  
Disk identifier (GUID): 0267952D-9B06-4B10-A648-B83684786910  
Partition table holds up to 128 entries  
First usable sector is 34, last usable sector is 16547806  
Partitions will be aligned on 2048-sector boundaries  
Total free space is 16547773 sectors (7.9 GiB)  
Number Start (sector) End (sector) Size Code Name  
~~~

A coluna `Code`  mostra o tipo da partição e a coluna `Name`  contém uma designação da partição que pode ser modificada livremente.

### Removendo a tabela de partiçóes

Caso o disco já possua uma tabela de partições você vai precisar de a remover para definir a nova tabela (GPT) de partições:

~~~  
command (? for help): d   
~~~

<!--If there are multiple partitions gdisk will ask you to type a number representing the partitions you wish to delete.

-->
<div class="divider" id="gdisk-3"></div>
## Para o arranque usando GPT-EFI ou GPT-BIOS

Should booting a GPT disk be a requirement, there are 2 options to format the boot sector of a GPT disk.

The options are:

+ `A sua máquina pode utilizar (U)EFI que está ativado na BIOS e selecionável para possível arranque.`   
+ Você quer utilizar EFI para arrancar de um disco utilizando GPT  

**`ou`** 

+ A sua máquina **`não`**  é capaz de utilizar (U)EFI através da BIOS  
+ Você vai querer utilizar a BIOS para arrancar de um disco utilizando uma tabela de partições GPT  

### arranque utilizando EFI 

**`A BIOS precisa de oferecer a opção EFI, esta estar ativada como capay de arranque.`**  

Neste caso você vai precisar de uma primeira partição formatada com o sistema FAT como Partição "EFI System Partition" (tipo `EF00` ). Esta partição vai ser utilizada para conter os "botlaoders" dos diferentes sistemas. Ao instalar o "siduction" ignore esta partição nas escolhas do instalador. M "bootloader" para o arranque do siduction será instaldo na partição do sistema EFI e pode ser encontrada em `/efi/siduction` . Esta partição vai ser montada em `/boot/efi`  se você deixar a opção "montar todas as partições" ativada.

<!--**`NOTE: USB booting is not supported with GPT.`** 

-->
#### Criar a partição EFI

Type **`n`**  para addicionar uma partição nova e utilize para ela um espaçp equivalente a `+200M` .

~~~  
Command (? for help): n   
Partition number (1-128, default 1): 1   
~~~

~~~  
First sector (34-16547806, default = 34) or {+-}size{KMGTP}:  
Information: Moved requested sector from 34 to 2048 in  
order to align on 2048-sector boundaries.  
Use 'l' on the experts' menu to adjust alignment  
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M   
Current type is 'Linux filesystem'  
~~~

 Entre **`L`**  para obter a lista dos códigos das partições:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): L   
0700 Microsoft basic data 0c01 Microsoft reserved 2700 Windows RE  
4200 Windows LDM data 4201 Windows LDM metadata 7501 IBM GPFS  
7f00 ChromeOS kernel 7f01 ChromeOS root 7f02 ChromeOS reserved  
8200 Linux swap 8300 Linux filesystem 8301 Linux reserved  
8e00 Linux LVM a500 FreeBSD disklabel a501 FreeBSD boot  
a502 FreeBSD swap a503 FreeBSD UFS a504 FreeBSD ZFS  
a505 FreeBSD Vinum/RAID a800 Apple UFS a901 NetBSD swap  
a902 NetBSD FFS a903 NetBSD LFS a904 NetBSD concatenated  
a905 NetBSD encrypted a906 NetBSD RAID ab00 Apple boot  
af00 Apple HFS/HFS+ af01 Apple RAID af02 Apple RAID offline  
af03 Apple label af04 AppleTV recovery be00 Solaris boot  
bf00 Solaris root bf01 Solaris /usr & Mac Z bf02 Solaris swap  
bf03 Solaris backup bf04 Solaris /var bf05 Solaris /home  
bf06 Solaris alternate se bf07 Solaris Reserved 1 bf08 Solaris Reserved 2  
bf09 Solaris Reserved 3 bf0a Solaris Reserved 4 bf0b Solaris Reserved 5  
c001 HP-UX data c002 HP-UX service ef00 EFI System   
ef01 MBR partition scheme ef02 BIOS boot partition fd00 Linux RAID  
~~~

user `ef00`  para criar a partição UEFI:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): ef00   
Changed system type of partition to 'EFI System'  
~~~

### Partição de arranque BIOS

#### Criando uma partição de arranque de BIOS

Se o seu sistema não suporta UEFI, você pode utilizar uma partição de arranque de BIOS (escolha typo EF02) `não formatada` . Ao instalar siduction instale o grub no MBR. Grub reconhecerá esta partição e vai utilizá-la para o bootloader

Type **`n`**  to add a new partition and `+200M`  to give the bootloader a size. (The reason to make it +200M,compared with conventional thinking of +32M, is to have in place an EFI sized partition should you ever need to change the disk to EFI booting).

Use **`n`**  para adicionar uma partição nova e atribua-lhe um tamanho de `+200M` . (A única razão para usar este tamanho é para não ter problemas na eventualidade de mais tarde querer utilizar o disco para fazer o arranque do system em modo UEFI ( com outra placa mãe ou depois de um BIOS upgrade.).

~~~  
Command (? for help): n   
Partition number (1-128, default 1): 1   
~~~

~~~  
First sector (34-16547806, default = 34) or {+-}size{KMGTP}:  
Information: Moved requested sector from 34 to 2048 in  
order to align on 2048-sector boundaries.  
Use 'l' on the experts' menu to adjust alignment  
Last sector (2048-16547806, default = 16547806) or {+-}size{KMGTP}: **`+200M   
Current type is 'Linux filesystem'  
~~~

Escolha `ef02`  para criar uma partição de arranque para a BIOS:

~~~  
Hex code or GUID (L to show codes, Enter = 8300): ef02   
Changed system type of partition to 'BIOS boot'  
~~~

**`Importante: A partição para arranque por BIOS não deve ser formatada`** 

<div class="divider" id="gdisk-4"></div>
### Criando uma partição de swap

A reserva e criação de uma partição para o swap não deve ser menosprezada em especial no caso de máquinas portáveis (laptop ou netbook) pois a sua existência pode ser vital em especial se o utilizador vai querer usar a possibiladate de "suspende para disco". O tamanho do swap deverá ser no minimo igual á memória (RAM) presente no sistema.

Type **`n`**  to add a new partition and `+2G` , (or, `+2048M` ) to give the swap partition a size witha type code of `8200` . An example of this would look like this:

Use **`n`**  para adicionar uma partição nova, e use `+2G` , (ou, `+2048M` ) para criar uma partição com 2GB de tamanho ( depende da quantidadae de memória existente no seu sistema) e usando para o tipo da partição o codigo `8200` . Por exemplo:

~~~  
Command (? for help): n   
Partition number (2-128, default 2): 2   
First sector (34-15728606, default = 411648) or {+-}size{KMGTP}:  
Last sector (411648-15728606, default = 15728606) or {+-}size{KMGTP}: **`+2048M   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 8200   
Changed type of partition to 'Linux swap  
~~~

<div class="divider" id="gdisk-5"></div>
### Criação de uma partição para data

Use **`n`**  para adicionar uma partição nova con o tamanho que deseja `XXXG` . Para tipo da partição use **`8300`** . Por exemplo `+4G` :

~~~  
Partition number (3-128, default 3): 3   
First sector (34-15728606, default = 4605952) or {+-}size{KMGTP}:  
Last sector (4605952-15728606, default = 15728606) or {+-}size{KMGTP}: **`+4G   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 8300   
Changed type of partition to 'Linux filesystem  
~~~

`Repita o processo o número de vezes que desejar para criar as partições que pretende.` 

As this example is a stick it may be wise to make an `Any OS Data`  partition, witha type code of `0700` , otherwise give it the code for a Linux filesystem (8300):

Neste exemplo utilizando uma USB pen é aconselhável utilizar uma partição do tipo `Any OS Data` , usando `0700` , ou então utilize o tipo de uma partição para o Linux `8300` ):

~~~  
Command (? for help): n   
Partition number (4-128, default 4): 4   
First sector (34-15728606, default = 12994560) or {+-}size{KMGTP}:  
Last sector (12994560-15728606, default = 15728606) or {+-}size{KMGTP}:**`+1300M   
Current type is 'Linux filesystem'  
Hex code or GUID (L to show codes, Enter = 8300): 0700   
Changed type of partition to 'Microsoft basic data'  
~~~

Para examinar as partições criadas:

~~~  
Command (? for help): p   
Disk /dev/sdx: 15728640 sectors, 7.5 GiB  
Logical sector size: 512 bytes  
Disk identifier (GUID): F409CFD3-6DDC-4551-BBC5-85DC218C1352  
Partition table holds up to 128 entries  
First usable sector is 34, last usable sector is 15728606  
Partitions will be aligned on 2048-sector boundaries  
Total free space is 73661 sectors (36.0 MiB)  
Number Start (sector) End (sector) Size Code Name  
1 2048 411647 200.0 MiB EF00 Boot  
2 411648 4605951 2.0 GiB 8200 Swap  
3 4605952 12994559 4.0 GiB 8300 Linux File System  
4 12994560 15656959 1.3 GiB 0700 Any OS Data  
~~~

Se desejar pode atribuir a cada partição uma descrição usando o commando **`c`** . Por exemplo:

~~~  
Command (? for help): c   
Partition number (1-4): 4   
Enter name: Descriptive name of your choosing   
~~~

O commando **`w`**  vai escrever todas as mudanças efectuadas enquanto que o commando **`q`**  fechará o gdisk sem as salvaguardar:

~~~  
Command (? for help): w   
Final checks complete. About to write GPT data. THIS WILL OVERWRITE EXISTING  
PARTITIONS!!  
Do you want to proceed? (Y/N): y   
OK; writing new GUID partition table (GPT).  
The operation has completed successfully.  
~~~

<div class="divider" id="gdisk-6"></div>
## Formatando as partições

"gdisk" cria apenas partições pelo que vai ser sempre (quase sempre) necessário formatá-las, por isso tome nota do número das diferentes partições (se for necessário pode usar o comando `p`  para recordar as partições). Usando no nosso exemplo /dev/sdb 

~~~  
gdisk /dev/sdb  
Command (? for help): p   
~~~

Utilize **`q`**  para fechar gdisk e regressar à linha de comando **`#`**  poderemos então formatar as partições.

Se criou uma partição `ef02 BIOS boot partition`  **`não a formate`** , se a primeira partição for `ef00 EFI System`  então formate-a com VFAT:

~~~  
mkfs -t vfat /dev/sdb1  
~~~

Para as partições do Linux por exemplo `/dev/sda3` :

~~~  
mkfs -t ext4 /dev/sdb3  
~~~

Para as partições do tipo 'Any OS Partition', `(possívelmente so necessárias para pen USB utilizadas em mais de um sistema operativo)` :

~~~  
mkfs -t vfat /dev/sdb4  
~~~

formatar a partição do swap:

~~~  
mkswap /dev/sdb2  
~~~

ativar o swap use:

~~~  
swapon /dev/sdb2  
~~~

Verifique que o swap é reconhecido, usando o comando:

~~~  
swapon -s  
~~~

Estes commandos funcionam da mesma maneira como com uma tabela de partições no MBR.

##### **`è absolutamente necessário reiniciar o sistema para que as partições e o sistema de ficheiros seja reconhecido e registado no kernel.`** 

Depoir do re-início você está pronto para efetuar a instalação do siduction ou utilizar o seu disco com a tabela de partições GPT.

<div class="divider" id="gdisk-7"></div>
## Comandos avançados do gdisk

Antes de salvaguardar as sua mudanças, pode verificar que não há problemas flagrantes na tabela de partições. Para isso utilize o comando **`v`** :

~~~  
Command (? for help): v   
No problems found. 0 free sectors (0 bytes) available in 0  
segments, the largest of which is 0 sectors (0 bytes) in size  
~~~

Neste exemplo, o disco está completamente alocado a uma partição e não há problemas latentes. No caso de existir espaço livre, existirem partições sobreadjacentes ou qualquer problema com a tabela principal de partições ou um backup deta o "gdisk" daria notícia do mesmo. A principal utilização do comando **`v`**  é ajudar a identificar problemas provenientes de corrupção de data.

Se foram detectados alguns problemas, você pode corrigi-los com a ajuda das mais variadas opções que o "gdisk" oferece, por exemplo no `recovery & transformation menu` , ao qual pode aceder usando **`r`**  :

~~~  
Command (? for help): r   
recovery/transformation command (? for help): **`?`**   
b use backup GPT header (rebuilding main)  
c load backup partition table from disk (rebuilding main)  
d use main GPT header (rebuilding backup)  
e load main partition table from disk (rebuilding backup)  
f load MBR and build fresh GPT from it  
g convert GPT into MBR and exit  
h make hybrid MBR  
i show detailed information on a partition  
l load partition data from a backup file  
m return to main menu  
o print protective MBR data  
p print the partition table  
q quit without saving changes  
t transform BSD disklabel partition  
v verify disk  
w write table to disk and exit  
x extra functionality (experts only)  
? print this menu  
~~~

Um terceiro menu , `experts menu` , pode ser ativado por meio do comando **`x`**  em qualquer dos menu `main menu`  ou `recovery & transformation menu` .

~~~  
recovery/transformation command (? for help): x   
Expert command (? for help): **`?`**   
a set attributes  
c change partition GUID  
d display the sector alignment value  
e relocate backup data structures to the end of the disk  
g change disk GUID  
i show detailed information on a partition  
l set the sector alignment value  
m return to main menu  
n create a new protective MBR  
o print protective MBR data  
p print the partition table  
q quit without saving changes  
r recovery and transformation options (experts only)  
s resize partition table  
v verify disk  
w write table to disk and exit  
z zap (destroy) GPT data structures and exit  
? print this menu  
~~~

A maior parte destes comandos têm que ser utilizados cuidadosamente. O uso incorrecto pode "confundir" algumas ferramentas de particionar discos. Por exemplo, o comando **`z`**  detroi todas as struturas GPT o que deverá ser efetuado se vocẽ quer utilizar um disco inicialmente particionado usando GPT utilizando um outro esquema de particionamento.

Falando de um modo geral as opções no menu `recovery & transformation`  e no menu `experts`  só deverão ser usados depois de ler atentamente a documentação do "gdisk". Se você tiver necessidade de utilizar estes menus é aconselhável efectuar um backup da tabela de partições num ficheiro externo utilizando o comando **`b`**  antes de efectuar quaisquer modificações. Deste modo é sempre possível reconstruir a tabela de partições original a partir do backup.

###### Fontes de informação: 

  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/) 

  [Windows Hardware Developer Center](http://msdn.microsoft.com/en-us/windows/hardware/gg463525) 

<!--<div class="divider" id="gdisk-8"></div>
## Dual booting with Linux and another OS - TBA

+ ~~~    
   man gdisk    
   ~~~
  
+  [GPT fdisk Tutorial by Roderick W. Smith](http://www.rodsbooks.com/gdisk/)   
+  [en.wikipedia.org/wiki/GUID_Partition_Table](http://en.wikipedia.org/wiki/GUID_Partition_Table)   

</div>-->
<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
