<div id="main-page"></div>
<div class="divider" id="part-example"></div>
## Exemple de Dimensionare a Partiţiilor

**`Pentru uzul normal recomandăm tipul ext4; este sistemul de fişiere implicit în siduction.`**

Cu Partition-Manager  [gparted](part-gparted-ro.htm)  hard discurile sunt partiţionate şi/sau formatate . Programul are o interfaţa grafică şi este auto explicativ .

Gparted poate de asemeni să micșoreze, să mute partiții sau să modifice partiții NTFS [cu mențiunea specială că, imediat după modificarea unei partiții NTFS, trebuie să reboot-ați PC-ul înainte de a face orice alte operațiuni].  [Documentaţia completă gparted](http://gparted.sourceforge.net/) . Schimbările pe partiţii NTFS pot fi făcute și cu programe proprietare ca Partition Magic (TM) şi Acronis (TM).

**` ÎNTOTDEAUNA SALVAŢI-VĂ DATELE !`**

<!--Dacă o partiţie este arătată ca montată va trebui să închideţi partition -manager şi unmount dispozitiv (clic dreapta pe iconul dispozitivului montat de pe desktop->unmount). Ar trebui să aveţi o partiţie swap , unmount cu :`"sudo swapoff -a"`  în Konsolă . Acestea odată făcute porniţi din nou programul de partiţionare . În principiu , o partiţie de 3 GB este mai mult decât suficient pentru instalarea pe hard disc , dar nu va fi prea distractiv . O partiţie minimă pentru instalare e bine să aibă 5 - 8 GB . Pentru cei noi în linux , sugerăm doar 2 partiţii pentru început (root şi swap), pentru că aceasta simplifică suficient prima instalare pe care o veţi face . Este bine deasemeni să faceţi o partiţie suplimentară /home.

Utilizatorii avansaţi pot avea partiţii suplimentare pentru /var, /tmp, ...etc, din motive speciale . Nu intrăm în alte detalii aici pentru că ar fi prea mult deocamdată . Trebuie să aveţi o partiţie swap (echivalentă fişierului swap din windows , dar mult mai folositoare). Pentru o folosire normală , partiţia swap trebuie să fie de două ori cât memoria ram din sistem. `Sistemul de fişiere standard în siduction este ext3 .` 

Pentru schimbul de date cu un Windows instalat trebuie să folosiţi vfat (fat32). [XFS is not supported and whomever wants to use XFS pentru / (root) trebuie să creeze o extra partiţie /boot (ext2) sau să folosească lilo (deoarece grub nu lucrează foarte bine cu tipul xfs ). Installer-ul în acest moment suportă xfs pe partiţia / numai prin editarea fişierului ~/.siductionconf.]

-->
Dacă o partiție apare ca 'mounted', 'unmount' discul, inclusiv partiția swap cu un click-dreapta pe icon-ul partiției din gparted sau via un terminal, de examplu:

~~~  
umount /dev/sda1  
~~~

Partiția swap poate fi 'unmounted' într-un terminal cu: 

~~~  
swapoff -a  
~~~

În principiu, 5 GB ar fi mai mult decât suficient pentru o instalare pe Hard Disk, dar nu veți avea prea multe bucurii doar cu atâta spațiu. Un spațiu minim rezonabil ar trebui să aibă cam 12 GB. Pentru începătorii în linux, sugerăm doar 2 partiții pentru început (root/home și swap), asta simplificând un pic prima voastră instalare, comparativ cu stabilirea mai multor partiții separate pentru /home și date adiționale.

Trebuie să aveți o partiție swap (equivalentul din windows a swapfile, dar este mult mai eficace). În mod normal, `partiția swap trebuie să fie dublă decât memoria RAM` .

Pentru schimbul de date cu un sistem Windows va trebui să folosiți vfat (fat32) sau ext2 deoarece există un driver sub MS Windows™ pentru data-swapping. [XFS nu este suportat].  [Ext2 Sistem de Fișiere compatibil cu MS Windows](http://www.fs-driver.org/)  și de asemeni  [Scrierea pe partiții NTFS cu  *ntfs-3g*](part-gparted-ro.htm#hd-ntfs3g) .

Este înțelept să dați nume partițiilor pentru a ști despre care este vorba.

##### Iată câteva exeple de partiții cu diferite dimensiuni:

##### 1 TB pentru dual boot MS Windows și Linux

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 50 GB | NTFS | MS Windows System | 
| sdb1 | 100 GB | ext4 | / (inclusiv home) | 
| sda3 | 300 GB | FAT32/ext2 | Date pentru MS Windows System și Linux | 

<td>550 GB</td>
<td>ext4</td>
<td>Date pentru Linux</td>
</tr>
<tr>
<td>sda4</td>
<td>2 GB</td>
<td>Linux Swap</td>
<td>Linux Swap</td>
</tr>
</tbody>

---

##### 120 GB hard drive cu MS Windows, dual boot cu Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 30 GB | NTFS | MS Windows System | 
| sda2 | 20 GB | ext3 | / | 
| sda3 | 20 GB | ext3 | /home | 
| sdb1 | 48 GB | FAT32/ext2 | Date de schimb între MS Windows și Linux | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 60 GB pentru dual boot MS Windows și Linux:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 24 GB | NTFS | MS Windows System | 
| sda2 | 10 GB | FAT32/ext2 | Date de schimb între MS Windows și Linux | 
| sda3 | 10 GB | FAT32/ext2 | Date de schimb între MS Windows și Linux | 
| sdb1 | 14 GB | ext4 | / (inclusiv home) | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 200GB hard drive:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20 GB | ext4 | / | 
| sda2 | 20 GB | ext4 | /home | 
| sda3 | 158 GB | ext2/3/4 | date | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 


---

##### 160GB hard drive:

|  **Disk**  |  **Size**  |  **Filesystem**  |  **Mountpoint/System**  | 
| ---- | ---- | ---- | ---- |
| sda1 | 20GB | ext4 | / | 
| sda2 | 20GB | ext4 | /home | 
| sda3 | 59GB | ext4 | date | 
| sdb1 | 59GB | ext4 | date | 
| sda4 | 2 GB | Linux Swap | Linux Swap | 

##### General

Sunt multe moduri de a vă partiționa hard-disk-ul. Aceste exemple ar trebui să eie suficiente pentru început.

Este indicat să vă cumpărați un HDD extern pe USB pe care să faceți salvări regulate a datelor pentru cazul în care HDD-ul vostru poate să se strice. `Dacă optați pentru boot-are duală cu MS Windows(tm);, instalați întotdeauna MS pe primul/prima hard disk/partiție` .

Pentru alte opțiuni de partiționare vedeți  [Partiționarea pentru a folosi LVM - Logical Volume Manager](part-lvm-ro.htm#part-lvm)  și  [Instalarea pe partiții criptate - cryptroot](hd-install-crypt-ro.htm#install-crypt) .

<div id="rev">Content last revised 20/04/2011 - 0745 UTC </div>
