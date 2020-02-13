<div id="main-page"></div>
<div class="divider" id="part-example"></div>
## Dimensionamento delle partizioni ed esempi

**`Per i normali usi raccomandiamo ext4, che è peraltro il filesystem predefinito di siduction.`**

I dischi vengono partizionati e/o formattati con il gestore delle partizioni  [GParted](part-gparted-it.htm) . Il programma ha un'interfaccia grafica ed è facilmente comprensibile.

Gparted può anche ridurre o spostare partizioni come pure manipolare partizioni NTFS (con un accorgimento particolare: una volta modificata la partizione NTFS dovete riavviare immediatamente prima di fare qualsiasi altra operazione).  [Leggete la documentazione completa per gparted](http://gparted.sourceforge.net/) . Le modifiche alle partizioni NTFS possono essere eseguite anche con strumenti proprietari come Partition Magic &#8482; e Acronis&#8482;.

**` SALVATE SEMPRE I DATI PRIMA DI MODIFICARE LE PARTIZIONI!`**

Se una partizione è montata, smontatela, incluso lo swap, con un click del tasto destro del mouse sulla sua icona in gparted oppure mediante terminale. Per esempio:

~~~  
umount /dev/sda1  
~~~

La partizione di swap può essere smontata in un terminale con:

~~~  
swapoff -a  
~~~

In linea di massima, 5 GB sono più che sufficienti per un'installazione su disco fisso, ma non sarete molto contenti con questa configurazione. Un'installazione ragionevole dovrebbe disporre come minimo di 12 GB di spazio. Per chi è un novizio di Linux suggeriamo soltanto 2 partizioni per iniziare (root/home e swap) in quanto ciò semplifica un po' la prima installazione, ma successivamente è utile creare partizioni aggiuntive per una /home a sé stante e per i dati.

Se il vostro dispositivo è un portatile richiedente talora una sospensione o un desktop con poca RAM (1 GByte o meno), dovreste avere sempre una partizione di swap (equivalente al file di swap di windows, ma molto più efficace). Per un utilizzo normale, `la partizione di swap dovrebbe essere pari al doppio della quantità della RAM` . Dispositivi con 4 GByte o più di RAM, peraltro, non richiedono necessariamente uno swap.

Per lo scambio dei dati con un'installazione Windows dovreste usare vfat (fat32) o ext2, per il quale è disponibile un apposito driver per MS Windows™ (XFS non è supportato).  [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/)  e anche  [Writing on NTFS partitions with ntfs-3g](part-gparted-it.htm#hd-ntfs3g) .

È cosa saggia assegnare dei nomi alle partizioni per futuro riferimento.

##### Ecco alcuni semplici esempi per partizioni di differenti dimensioni:

##### 1 TB per il doppio avvio MS Windows e Linux

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

##### 120 GB per il doppio avvio MS Windows e Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 30 GB | NTFS | MS Windows System | 
| sda2 | 20 GB | ext3 | / | 
| sda3 | 20 GB | ext3 | /home | 
| sdb1 | 48 GB | FAT32/ext2 | Data exchange MS Windows and Linux | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 60 GB per il doppio avvio MS Windows e Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 24 GB | NTFS | MS Windows System | 
| sda2 | 10 GB | FAT32/ext2 | Data for MS Windows and Linux | 
| sda3 | 10 GB | FAT32/ext2 | Data for MS Windows and Linux | 
| sdb1 | 14 GB | ext4 | / (includes home) | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### Disco fisso da 200GB:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20 GB | ext4 | / | 
| sda2 | 20 GB | ext4 | /home | 
| sda3 | 158 GB | ext2/3/4 | data | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### Disco fisso da 160GB:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20GB | ext4 | / | 
| sda2 | 20GB | ext4 | /home | 
| sda3 | 59GB | ext4 | data | 
| sdb1 | 59GB | ext4 | data | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 

##### Generalità

Vi sono molti modi di partizionare i vostri dischi. Gli esempi sopra riportati dovrebbero esservi sufficienti per iniziare.

È cosa sensata acquistare un disco esterno USB per farvi regolarmente il backup dei dati nel caso succedesse qualcosa ai vostri dischi fissi. `Se utilizzate il doppio avvio con MS Windows(tm);, mettete sempre Windows sulla prima partizione del primo disco` .

Per altre opzioni di partizionamento leggete  [Partizionamento LVM - Logical Volume Manager](part-lvm-it.htm#part-lvm)  e  [Installare su partizioni criptate - cryptroot](hd-install-crypt-it.htm#install-crypt) .

<div id="rev">Content last revised 18/04/2012 - 1301 UTC </div>
