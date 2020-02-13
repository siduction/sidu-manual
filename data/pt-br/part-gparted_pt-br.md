<div id="main-page"></div>
<div class="divider" id="partition"></div>
## Como particionar seu HD com o Gparted/KDE Partition Manager

##### **`AVISO: a respeito de nomes de discos`**  [veja UUID, Nomeando Partições e fstab; por padrão, o siduction agora usa UUID](part-uuid-pt-br.htm) 

##### Ferramentas de particionamento podem pedir senha root; digite `sux`  seguido de sua senha. No LiveCD basta digitar `sux`  e pressionar [ENTER] . Veja:  [Modo Live](live-mode-pt-br.htm) 


---


::: warning  
**Achtung**  
Redimensionar uma partição NTFS exige que o sistema seja reiniciado! NÃO FAÇA nenhuma outra operação na partição antes disso, senão você ficará com vários erros. [Por favor, leia isto.](part-gparted-pt-br.htm#ntfs)   
:::

**`Sempre faça backups (cópias) de seus dados!`**

### O básico

Uma partição precisa ter um sistema de arquivos. O Linux reconhece vários tipos, como ReiserFS, Ext4 e, para usuários experientes, XFS e JFS. O Ext2 é ótimo para armazenamento, pois existe disponível um driver MS Windows&#8482; para troca de dados.  [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/)  (Ext2 no Windows).

## Como usar o KDE Partition Manager &amp; Gparted

Criar e gerenciar partições não são coisas que fazemos todos os dias. Sendo assim, uma boa ideia é ler este guia pelo menos uma vez, para você se familiarizar com os conceitos e algumas das telas que irão aparecer.

### KDE Partition Manager (Gerenciador de Partições do KDE) - digitar no terminal:

~~~  
sux  
partitionmanager  
~~~

### Gparted - digitar no terminal:

~~~  
sux  
gparted  
~~~

+ Quando o GParted ou o KDE Partition Manager rodarem, uma janela vai abrir-se e seus drives serão inspecionados.
  
   No KDE Partition Manager, Os drives são mostrados em uma lista à esquerda.
  
   ![KDE Partition Manager partition information](../images-common/images-kpart/kpart-02.png "KDE Partition Manager partition information") 
  
   No Gparted, Se você clicar no menu GParted (acima, à esquerda), um menu do tipo cortina é apresentado. Se quiser, selecione 'Refresh Devices' (Atualizar Dispositivos) para que sejam mostrados os drives em seus sistema.
  
   ![gparted](../images-common/images-gparted/gparted02-en.png "Gparted Devices View") 
  

###### **`As telas a seguir são do Gparted. O KDE Partition Manager comporta-se quase da mesma maneira.`** 

+ ### Editar (Edit)
  
   O menu 'Editar' (Edit) tem 03 funções desabilitadas, que podem ser cruciais para você:  
`Desfaz a última operação (Undo last operations)`   
`Aplica todas as operações (Apply)`   
`Limpa lista de operações (Clear all operations)` .
  
+ ### Ver (View)
  
   #### Informações do Dispositivo (Device Information)
  
   O menu  **'Informações do Dispositivo' (Device Information)**  mostra detalhes sobre o HD, como Modelo, Tamanho etc. Esse menu é mais útil quando existe mais de um drive no sistema, pois pode-se fazer uso das informações mostradas para certificar-se de que o drive examinado é realmente aquele desejado.
  
   ![operation view](../images-common/images-gparted/gparted03-en.png "Gparted Harddisk Information") 
  
   #### Operações Pendentes (Pending Operations)
  
   Na janela inferior fica a lista das operações pendentes. As informações são úteis, já que indicam as modificações que pretendemos fazer no(s) drive(s).
  
+ ### Dispositivo (Device)
  
   'Dispositivo' (Device) permite que você crie uma nova tabela de partições, se a atual não for apropriada.
  
+ ### Partição (Partition)
  
   Esse é o menu mais importante. Ele permite que você faça várias operações, algumas delas perigosas.
  
    **Apagar (Delete)**  é usada para apagar uma partição previamente selecionada.
  
    **Redimensionar/Mover (Resize/Move)**  é uma função útil, auto-explicativa.
  
+ ### Como criar uma nova partição
  
   Na barra de ferramentas, o botão  **Novo (New)**  permite-lhe criar uma nova partição, desde que você já tenha selecionado uma área não alocada. Na nova janela que aparece, você pode escolher o tamanho, o sistema de arquivos e se ela será do tipo Primária, Estendida ou Lógica.
  
   ![file system](../images-common/images-gparted/gparted07-en.png "Gparted New Partition") 
  
+ ### Se você cometer um engano
  
   Se você errar alguma coisa, use o botão Apagar (Delete) para apagar a partição e recomeçar; caso a operação ainda esteja pendente, use o botão Desfazer (Undo).
  
   ![delete](../images-common/images-gparted/gparted04-en.png "Gparted Delete") 
  
+ ### Redimensionar/Mover (Resize/Move)
  
   Se você quiser redimensionar uma partição pré-selecionada, clique no botão  **Redimensionar/Mover (Resize/Move)** : surge uma nova janela. Use o mouse ou as setas direcionais para reduzir ou aumentar a partição.
  
   ![resize / move](../images-common/images-gparted/gparted05-en.png "Gparted Resize") 
  
   Depois do comando Redimensionar (Resize), você precisa clicar em Aplicar (Apply) para que a alteração seja escrita no HD.
  
   ![operation view](../images-common/images-gparted/gparted09-en.png "Gparted Apply") 
  
   Quanto tempo vai demorar depende do novo tamanho da partição.
  
    **Depois de realizadas todas as alterações, reinicie o siduction para que ele possa ler a nova tabela de partições.** 
  

<div class="divider" id="ntfs"></div>
## Como redimensionar partições NTFS


::: warning  
**Achtung**  
Redimensionar uma partição NTFS exige que o sistema seja reiniciado! NÃO FAÇA nenhuma outra operação na partição antes disso, senão você acabará com vários erros.  
:::

+ Quando você der o boot pelo MS Windows&#8482;, o sistema irá mostrar uma tela especial e uma mensagem sobre consistência do HD: Checando sistema de arquivos em C:  
+ Deixe o AutoCheck (AUTOCHK) rodar: NT precisa verificar seu sistema de arquivos após a operação de redimensionamento.  
+ No final do processo, o computador será reiniciado automaticamente pela segunda vez. Isso assegura que tudo funcionará perfeitamente.  
+ Depois de recarregado, seu Windows estará ok, mas você tem de aguardar até a tela de login!  

 **Documentação completa do GParted:** para uma documentação completa, inclusive How-To sobre cópia de partições, favor ir à página do  [GParted](http://gparted.sourceforge.net) 

<div class="divider" id="hd-ntfs3g"></div>
## Como escrever em partições NTFS com ntfs-3g

**` **ATENÇÃO:** : Ainda que o ntfs-3g seja considerado 'estável', jamais use-o sem antes fazer cópias de seus arquivos importantes; não o use, também, em sistemas de produção! Se o fizer e perder dados, lembre-se de que foi avisado. Portanto, o risco é todo seu!`**

Abra um terminal e digite os comandos abaixo. Veja  [Particionando seu HD - Nomes dos Discos](part-cfdisk-pt-br.htm#disknames) 

~~~  
sux  
apt-get update && apt-get install ntfs-3g  
umount /media/xdxx  
mount -t ntfs-3g /dev/disk/by-uuid/xxyyzz[etc] /media/xdxx  
Para sair do terminal, digite: exit  
~~~

Agora seu volume NTFS deve estar montado  **rw**  e você será capaz de armazenar dados nele. Repetimos, porém: `use apenas em situações emergenciais, NUNCA no dia-a-dia!!!` 

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
