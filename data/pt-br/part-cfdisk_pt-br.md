<div id="main-page"></div>
<div class="divider" id="disknames"></div>
## Nomes dos Discos

##### **`AVISO: Sobre nomes dos discos, favor ver:`**  [UUID, Nomeando Partições e fstab, pois o padrão no siduction agora é UUID](part-uuid-pt-br.htm) 

#### Nomenclatura atual

##### Nos discos

Desde que o udev adotou o UUID - Universal Unique Identifier (Identificador Único Universal) e desde os kernels mais recentes, todos os dispositivos passaram a usar um esquema de nomes com três letras + um número, no formato `sda`  para dispositivos de discos e `sdaX`  para as partições dos HDs.

Não importa o padrão usado, seja ele PATA (IDE), SATA (Serial ATA) ou SCSI, a única maneira de diferenciar um disco de outro em sua máquina é pela terceira letra do dispositivo: `/dev/sda1, /dev/sdb1, /dev/sdc1, /dev/sdd1`  etc.

Você pode ver seus dispositivos listados desta maneira observando as pop-ups mostradas quando você passa o mouse por cima dos ícones correspondentes na área de trabalho do siduction, tanto no LiveCD quanto numa instalação em HD.

Encorajamos-lhe a construir você mesmo uma tabela, à mão ou com ferramentas do micro, onde sejam colocados os detalhes de todos os dispositivos existentes em seu computador. Ainda que tediosa, essa operação pode representar economia de tempo e evitar muita dor-de-cabeça no futuro.

O arquivo `/etc/fstab`  no LiveCD ou no siduction instalado no HD mantém a informação `/dev/ sdaX`  entre chaves na linha comentada imediatamente acima das linhas dos dispositivos. Por exemplo (o negrito foi usado somente para realçar o que falamos aqui):

~~~  
# added by siduction [ **/dev/sdd1 , no label]  
UUID=2ae950df-7d72-4d9b-a71a-bad1eb2d4f6a / ext4 defaults,errors=remount-ro,relatime 0 1  
~~~

##### Nas partições

Como você pode ver acima, o identificador `/dev/disk`  é completado por um número, que representa as partições.

Existem 03 tipos de partições: primária, estendida e lógica, sendo que as lógicas ficam dentro das estendidas. Podem existir 04 partições primárias, no máximo, ou 03 primárias e 01 estendida. A estendida pode conter até 11 partições lógicas.

As primárias e as estendidas têm nomes entre sda1 e sda4. As partições lógicas são sempre contíguas e fazem parte de uma partição estendida. Você pode definir (com libata) um máximo de 11 dessas partições, sendo sua designação iniciada pelo número 5 (p.ex., sda5) e indo até 15 (sda15, p.ex.).

##### Alguns exemplos

`/dev/sda5`  : só pode ser uma partição lógica (neste caso, a primeira de seu HD), provavelmente localizada ou em seu primeiro HD SATA ou em seu primeiro HD IDE (vai depender da configuração de sua BIOS).

`/dev/sdb3`  : só pode ser uma partição ou primária ou estendida; como a terceira letra que designa o disco é diferente do exemplo anterior (lá, sda; aqui, sdb), podemos ter certeza de que não há como essa partição estar localizada no mesmo dispositivo.

#### Designação anterior, agora obsoleta, dos dispositivos IDE

Nos sistemas Linux antigos, os dispositivos de discos IDE (PATA) diferenciavam-se uns dos outros pelo padrão `hdaX`  ao invés de sdaX.

<div class="divider" id="partition"></div>
## Como particionar seu HD com o cfdisk

**`Para uso normal, recomendamos o sistema de arquivos 'ext4'. Ele é o padrão do siduction e tem uma boa manutenção.`**

Abra o terminal, torne-se root e execute o cfdisk:  
 *(se você estiver com o siduction já instalado, você terá de fornecer a senha root aqui)* 

~~~  
su  
cfdisk /dev/sda  
~~~

##### A interface do usuário

Na primeira tela, o cfdisk lista a tabela de partições atual, com os respectivos nomes e alguns dados sobre cada uma delas. Na parte inferior há alguns botões de comandos. Para mudar de uma partição para outra, use as  **setas para cima e para baixo** . Para mudar de um comando para outro, use as  **setas esquerda e direita.** 

##### Apagar uma partição

![Delete a partition](../images-pt-br/cfdisk-pt-br/cfdisk0-pt-br.png "Delete a partition") 

Para apagar uma partição, marque-a usando as setas para cima/para baixo, selecione o comando:

~~~  
Excluir (ou Delete)  
~~~

 ...usando as setas esquerda/direita e pressione:

~~~  
Enter  
~~~

##### Criar uma nova partição

![Create a new partition](../images-pt-br/cfdisk-pt-br/cfdisk1-pt-br.png "Create a new partition") 

Para criar uma nova partição, use o comando:

~~~  
Nova (ou New)  
~~~

(selecione-o com as setas esquerda/direita) e aperte [enter]. Você deve decidir-se entre uma partição  **primária**  e uma  **lógica** . Se você quiser uma partição lógica, o programa automaticamente faz uma partição estendida para você. Em seguida, você precisa escolher o tamanho da partição (em MB). Se não conseguir entrar um valor em MB, pressione a tecla [Esc] para voltar à tela principal e selecione MB com o comando:

~~~  
Unidades (ou Units)  
~~~

##### Tipo da partição

![Type of a partition 1](../images-pt-br/cfdisk-pt-br/cfdisk2-pt-br.png "Type of a partition 1") 

Para escolher o tipo da partição, seja ela  **Linux swap**  ou  **Linux** , marque-a e use o comando:

~~~  
Tipo (ou Type)  
 .  
~~~

Surgirá uma lista com vários tipos. Se você pressionar [Espaço], ela será ainda maior. Encontre o tipo desejado e entre com o respectivo número no prompt. ( **Linux swap**  é Tipo  **82** , sistemas de arquivos  **Linux**  devem ser do tipo  **83** )

![Type of a partition 2](../images-pt-br/cfdisk-pt-br/cfdisk3-pt-br.png "Type of a partition 2") 

##### Tornar uma partição capaz de dar a partida no computador (Bootable Partition)

Não há nenhuma necessidade de fazer esse tipo de partição no Linux, mas há sistemas operacionais que precisam disso. Basta marcar a partição e selecionar o comando. Nota: se a instalação for feita em um HD externo, então uma partição tem de ser do tipo 'Bootable':

~~~  
Bootable  
~~~

##### Salvar o resultado no disco

Até agora, você deletou ou criou partições, escolheu seus tipos etc, mas nada foi escrito ainda no HD! Agora que tudo está pronto, sim, salve todas as mudanças que você fez usando o comando Gravar (ou Write). A nova tabela de partições será escrita no disco rígido (se aparecer uma mensagem de erro sobre DOS, ignore). Como isso vai destruir todos os dados existentes nas partições que você instruiu o programa para apagar ou alterar, tenha bastante certeza de que é isso mesmo que você deseja, e só então pressione a tecla:

~~~  
Enter  
~~~

![Write the result to disk](../images-pt-br/cfdisk-pt-br/cfdisk4-pt-br.png "Write the result to disk") 

##### Sair

Para sair do programa, selecione o comando Sair (ou Quit). Depois de fechar o cfdisk e antes de começar a formatar e instalar, é preciso que você reinicie sua máquina para o siduction poder reler sua tabela de partições.


---

<div class="divider" id="formating"></div>
## Como formatar partições (após particionamento com o cfdisk)

##### O básico

Uma partição necessita de um sistema de arquivos. O Linux reconhece vários deles: ReiserFs, Ext4 e, para usuários experientes, XFS e JFS. O Ext2 é ótimo para armazenamento, pois há um driver Windows disponível que permite a troca de dados. [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/)  (Ext2 no Windows).

**`Para uso normal, recomendamos o sistema de arquivos Ext4, que é o padrão do siduction. Além do mais, ele possui uma boa manutenção.`**

##### Formatar

Depois de sair do  **cfdisk** , voltamos ao terminal. Somente como root é possível formatar partições; por exemplo, para formatar a partição /root em  **sdb1** , digitamos:  *(se o siduction já estiver instalado, você terá de fornecer a senha de root aqui)* 

~~~  
su  
mkfs -t ext4 /dev/sdb1  
~~~

Surgirá um pergunta, cuja resposta deve ser 'yes' (desde que você tenha certeza de ter escolhido a partição correta).

Quando a execução do comando estiver terminada, você receberá um aviso de que a partição foi corretamente formatada com ext4. Caso essa mensagem não apareça, o mais provável é que alguma coisa tenha dado errado no particionamento com o cfdisk ou, então, sdb1 não é uma partição Linux. Você pode verificar com:

~~~  
fdisk -l /dev/sdb  
~~~

Se tiver havido algum erro, talvez você tenha de repetir o processo de particionamento.

Se a formatação foi concluída com êxito, repita o procedimento acima para a partição /home, se você quiser ter uma separada.

Por último, vamos formatar a partição swap; no nosso exemplo, ela é sdb3:

~~~  
mkswap /dev/sdb3  
~~~

Em seguida, digite:

~~~  
swapon /dev/sdb3  
~~~

Então, checamos se a swap é reconhecida pelo sistema:

~~~  
swapon -s  
~~~

Agora, a recém-montada swap deve ser reconhecida, no nosso caso como:

<table class="center">
| Nome do Arquivo | Tipo | Tamanho | Usado | Prioridade | 
| ---- | ---- | ---- | ---- | ---- |
| /dev/sdb3 | partição | 995988 | 248632 | -1 | 


---

Se a swap foi reconhecida corretamente, digitamos:

~~~  
swapoff -a  
~~~

... e reiniciamos o computador.

Pronto, agora você pode começar a instalação do siduction.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
