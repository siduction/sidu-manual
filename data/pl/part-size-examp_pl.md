<div id="main-page"></div>
<div class="divider" id="part-example"></div>
## Rozmiary partycji i przykłady

**`Dla zwykłego użytku zalecamy ext4.`**

Przy pomocy menadżera partycji  [gparted](part-gparted-pl.htm)  twarde dyski są partycjonowane i/lub formatowane. Program posiada graficzny interfejs i jego obsługa jest intuicyjna.

Gparted potrafi także zmniejszyć lub przesunąć partycje a także prowadzić działania na partycjach NTFS [ze szczególnym zastrzeżeniem, że po dokonaniu zmian na partycji NTFS musisz natychmiast ponownie uruchomić system przed jakimkolwiek innym działaniem].  [Patrz: pełna dokumentacja gparted](http://gparted.sourceforge.net/) . Zmiany na partycjach NTFS mogą być też dokonywane przy pomocy komercyjnych narzędzi takich jak Partition Magic (TM) i Acronis (TM).

**` ZAWSZE TWÓRZ KOPIĘ ZAPASOWĄ SWOICH DANYCH!`**

W przypadku, gdy partycja pojawi się jako zamontowana, odmontuj urządzenie, także partycję wymiany (swap) za pomocą kliknięcia prawym klawiszem myszy na ikonie partycji w gparted lub terminalu, przykładowo:

~~~  
umount /dev/sda1  
~~~

Partycja wymiany (swap) może być odmontowana w terminalu za pomocą: 

~~~  
swapoff -a  
~~~

W zasadzie, 5 GB jest więcej niż wystarczające dla instalacji na hd, ale zbyt dużo z tym nie zwojujesz. Rozsądna minimalna instalacja powinna mieć 12 GB miejsca. Linuksowym nowicjuszom, zalecamy na początek tylko dwie partycje (root / home i swap), ponieważ upraszcza to znacznie pierwszą instalację, a następnie założenie dodatkowych partycji na oddzielny katalog /home i dodatkowe partycje z danymi.

Powinieneś koniecznie mieć partycję wymiany (swap), która jest odpowiednikiem pliku wymiany windows, lecz znacznie bardziej efektywna). Dla normalnego uzytku, `partycja wymiany (swap) powinna mieć wymiar dwukrotnie większy niz ram` .

Aby mieć możliwość wymiany danych z instalacjami Windows powinienieś uzywać vfat (fat32) lub ext2 jako, że istnieje odpowiedni w tym celu sterownik MS Windows™. [XFS nie jest wspierany].  [Ext2 System plików umożliwiający instalację MS Windows](http://www.fs-driver.org/)  and also  [Writing on NTFS partitions with ntfs-3g](part-gparted-pl.htm#hd-ntfs3g) .

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

There are many ways to partition your hard drives. These examples should be enough for a start.

 It makes good sense to purchase a USB hard drive to make a regular data back up should any of your hard drives fail. `If dual booting with MS Windows(tm);, always put MS on the first hard disk/partition` .

For other partitioning options see  [Partitioning to use LVM - Logical Volume Manager](part-lvm-pl.htm#part-lvm)  and  [Installing to encrypted partitions - cryptroot](hd-install-crypt-pl.htm#install-crypt) .

<div id="rev">Content last revised 20/04/2011 - 0745 UTC </div>
