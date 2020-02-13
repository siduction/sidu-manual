<div id="main-page"></div>
<div class="divider" id="part-example"></div>
## Tamanhos das Partições e Exemplos

**`Para uso normal, recomendamos o ext4, que é o sistema de arquivos padrão do siduction.`**

Com o Gerenciador de Partições  [GParted](part-gparted-pt-br.htm) , você pode formatar e particionar seu HD. O programa possui interface gráfica e é auto-explicativo.

O Gparted também pode diminuir ou mover partições, bem como manipular partições NTFS [lembre-se de que é necessário reiniciar o computador imediatamente após a alteração da partição NTFS, antes de prosseguir com qualquer outra operação].  [Sua documentação está aqui.](http://gparted.sourceforge.net/)  Mudanças em partições NTFS também podem ser feitas com ferramentas proprietárias, como Partition Magic (TM) e Acronis (TM).

**` SEMPRE FAÇA BACKUPS (CÓPIAS) DE SEUS DADOS!`**

<!--Se o GParted mostrar que a partição está montada, é necessário desmontá-la primeiro. Para isso, feche o aplicativo, localize na Área de Trabalho o ícone correspondente à partição, clique com o botão direito sobre ele e, no menu de contexto, clique em 'Unmount' (Desmontar). Se se tratar de partição swap, desmonte-a com: `"sudo swapoff -a"`  (sem as aspas) no terminal. Quando terminar, reabra o GParted. Em princípio, 3GB são suficientes para instalar o siduction no HD, mas tão pouco não lhe proporcionará muita diversão. Um tamanho razoável fica entre 5GB e 8GB. Se você é iniciante no Linux, sugerimos que utilize apenas 2 partições (root e swap), para facilitar sua vida. Se quiser, faça também uma partição extra para /home.

Usuários avançados podem querer partições adicionais para /var, /tmp, ...etc, por razões especiais. Não vamos entrar em detalhes, para não nos desviarmos de nossos objetivos aqui. Você vai mesmo precisar de uma partição swap (semelhante ao 'swapfile' do Windows, porém mais eficiente), cujo tamanho deve ter o dobro de sua memória RAM. `E lembre-se: o sistema de arquivos padrão do siduction é o ext3.` 

Para trocar dados com o Windows, você deve usar vfat (fat32). [Não há suporte para XFS; se você quiser usá-lo para / (root), você terá de criar uma partição /boot (ext2) ou usar o lilo (porque o GRUB não funciona bem com o XFS). No momento, é preciso editar o arquivo ~/.siductionconf se você quiser que o instalador do siduction trabalhe com XFS na /.]

-->
Se a partição estiver montada (inclusive a swap), desmonte-a clicando com o botão direito no ícone referente a ela no GParted ou via terminal. Exemplo:

~~~  
umount /dev/sda1  
~~~

A partição swap pode ser desmontada pelo terminal assim:

~~~  
swapoff -a  
~~~

Em princípio, 5GB são suficientes para uma instalação no HD, mas isso não vai lhe proporcionar muita diversão. Um mínimo razoável seria de 12GB. Para os novatos em Linux, sugerimos apenas duas partições para começar (root/home e swap), porque isto simplifica um pouco o processo de instalação. Mais tarde você pode criar partições extras para uma /home separada e partições adicionais para dados.

Você vai realmente precisar de uma partição swap (equivalente à swapfile do Windows, porém mais funcional e efetiva). Para uso normal, `a swap deve ter um tamanho igual ao dobro de sua memória RAM.` .

Para trocar dados com o Windows, use vfat (fat32) ou ext2 pois existe um driver MS Windows™ disponível para isso. [Não há suporte para o XFS].  [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/)  (Ext2 no Windows) and also  [Writing on NTFS partitions with ntfs-3g](part-gparted-pt-br.htm#hd-ntfs3g) .

It is wise to write down the names of the partitions for reference.

##### Here are some simple examples for different partition sizes:

##### 1 TB for dual boot MS Windows and Linux

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 50 GB | NTFS | MS Windows System | 
| sdb1 | 100 GB | ext4 | / (includes home) | 
| sda3 | 300 GB | FAT32/ext2 | Data for MS Windows System and Linux | 

<td>550 GB</td>
<td>ext4</td>
<td>Data for Linux</td>
</tr>
<tr>
<td>sda4</td>
<td>2 GB</td>
<td>Linux Swap</td>
<td>Linux Swap</td>
</tr>
</tbody>

---

##### 120 GB hard drive with MS Windows, dual boot with Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 30 GB | NTFS | MS Windows System | 
| sda2 | 20 GB | ext3 | / | 
| sda3 | 20 GB | ext3 | /home | 
| sdb1 | 48 GB | FAT32/ext2 | Data exchange MS Windows and Linux | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 60 GB for dual boot MS Windows and Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 24 GB | NTFS | MS Windows System | 
| sda2 | 10 GB | FAT32/ext2 | Data for MS Windows and Linux | 
| sda3 | 10 GB | FAT32/ext2 | Data for MS Windows and Linux | 
| sdb1 | 14 GB | ext4 | / (includes home) | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 200GB hard drive:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20 GB | ext4 | / | 
| sda2 | 20 GB | ext4 | /home | 
| sda3 | 158 GB | ext2/3/4 | data | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 160GB hard drive:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20GB | ext4 | / | 
| sda2 | 20GB | ext4 | /home | 
| sda3 | 59GB | ext4 | data | 
| sdb1 | 59GB | ext4 | data | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 

##### General

Há muitas maneiras de particionar os seus discos duros. Os exemplos seguintes serão suficientes para o começo.

 É aconselhável adquirir um disco USB externo para fazer regularment backup dos seus dados não vá um dos seus discos internos ter um crash... `No caso de utilizar dual boot com o MS Windows(tm);, utiliye para este de preferencia uma partição no primeiro disco duro.` .

For other partitioning options see  [Como particionar para o uso de LVM - Logical Volume Manager](part-lvm-pt-br.htm#part-lvm)  and  [Instalando em partição chifrada - cryptroot](hd-install-crypt-pt-br.htm#install-crypt) .

Para outras opcões de particionamento veja  [Como particionar para o uso de LVM - Logical Volume Manager](part-lvm-pt-br.htm#part-lvm)  e  [Instalando em partição chifrada - cryptroot](hd-install-crypt-pt-br.htm#install-crypt) .

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
