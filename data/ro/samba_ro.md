<div id="main-page"></div>
<div class="divider" id="configure"></div>
## Configurarea siduction să folosească SAMBA (Windows) Shares de la Remote Machines

Executaţi toate comenzile ca  **root**  (într-un Terminal sau Konsole). Scrieţi adresa în Konqueror (rulaţi Konqueror ca utilizator normal).

`server = nume server sau IP-ul computerului Windows  
`share = nume director share` `

În KDE - Konqueror scrieţi la adresa :`smb://server`  sau adresa completă :`smb://server/share` 

Într-o consolă puteţi vedea directorul share dintr-un server cu:

~~~  
smbclient -L server  
~~~

Pentru a face un director să fie share -(cu acces total pentru TOŢI utilizatorii) ţineţi minte: Mountpoint trebuie să existe. Dacă nu există trebuie întâi creat acest director aşa (numele e arbitrar):

~~~  
mkdir -p /mnt/server_share  
~~~

Apoi montaţi directorul share - sistem de fişiere VFAT-remote:

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777 //server/share /mnt/server_share  
~~~

sau sistem de fişiere NTFS-remote:

~~~  
mount -t cifs -o username=Administrator,file_mode=0777,dir_mode=0777,lfs //server/share /mnt/server_share  
~~~

Pentru a închide conexiunea folosiţi:

~~~  
umount /mnt/server_share  
~~~

dacă vreţi să introduceti o linie în  */etc/fstab*  pentru a face montarea mai uşoară introduceţi următoarea linie în fişier:

~~~  
//server/share /mnt/server_share cifs defaults,username=your_username,password=**********,file_mode=0777,dir_mode=0777 0 0  
~~~

<div class="divider" id="setup"></div>
## Setarea siduction ca Server Samba

Pentru că samba nu este pe live-cd va trebui să executaţi următoarele pentru a avea acces samba:

~~~  
sux  
apt-get update  
apt-get install samba samba-tools smbclient cifs-utils samba-common-bin  
~~~

#### Instalarea pe HD:

##### Exemplul 1:

Într-un sistem instalat pe Hard Disc trebuie să ajustaţi configurarea Samba. Aici aveţi un exemplu simplu. Dacă vreţi să ştiţi mai multe despre folosirea Samba şi despre setarea unui server Samba în Linux  [vă recomandăm să citiţi documentaţia Samba](http://us5.samba.org/samba/) .

Pentru a ajusta configurarea Samba faceţi următoarele:

deschideţi fişierul `/etc/samba/smb.conf`  cu un editor (ex. kedit) şi introduceţi:

~~~  
# Globale Changes - Proposal everything simple as  
#possible - no passwords, perform like Windows 9x  
[global]  
security = share  
workgroup = WORKGROUP  
# Share without write-permission -important if NTFS Filesystems are to be shared!  
[WINDOWS]  
comment = Windows Partition  
browseable = yes  
writable = no  
path = /media/sda1 # <-- adjust to your partition  
public = yes  
# Sharing a partition with permission to write- the partition has to be mounted  
# writable - makes sense with e.g. FAT32.  
[DATA]  
comment = Data Partition (first extended Partition)  
browseable = yes  
writable = yes  
path = /media/sda5  
public = yes  
~~~

Restart-ați serverul samba

~~~  
/etc/init.d/samba restart  
~~~

#### Exemplul 2:

~~~  
groupadd smbuser  
useradd -g smbuser <the-user-you-want>  
smbpasswd -a <the-user-you-want>  
smbpasswd -e <the-user-you-want>  
~~~

Apoi editați `/etc/samba/smb.conf`  pentru a da permisiuni de share, (fiți atenți ce dosare le faceți disponibile), de exemplu:

~~~  
[homes]  
comment = Home Directories  
browseable = yes.  
writeable = yes  
[media, be careful!]  
path = /media  
browseable = yes  
read only = no  
#read only = yes  
guest ok = no  
writeable = yes  
[video]  
path = /var/lib/video  
browseable = yes  
#read only = no  
read only = yes  
guest ok = no  
#any other folder you want to share with windows/linux/mac  
#path = path = /media/xxxx/xxxx  
#browseable = yes  
#read only = no  
#read only = yes  
#guest ok = no  
~~~

Restart-ați serverul samba

~~~  
/etc/init.d/samba restart  
~~~

## Verificarea share-urilor în samba

Pentru a face share cu samba fără a uita de securitate executați următoarele comenzi (i.e. pentru o setare LAN):

Setați directorul și conținutul său să fie cel puțin -rwxr-xr-x:

~~~  
ls -la pathTo/dirShareName/*  
~~~

Dacă nu-i așa, faceți:

~~~  
chmod -R 755 pathTo/dirShareName  
~~~

Dacă vreți să se poată și scrie în el:

~~~  
chmod -R 777 dirShareName  
~~~

O modalitate de a vă asigura că share-ul vostru funcționează (nu uitați să porniți server-ul):

~~~  
smbclient -L localhost  
~~~

Ar trebui să vedeți ceva de genul:

~~~  
smbclient -L localhost  
Password:  
Domain=[HOME] OS=[Unix] Server=[Samba 3.0.26a]  
Sharename Type Comment  
--------- ---- -------  
IPC$ IPC IPC Service (3.0.26a)  
MaShare Disk comment  
print$ Disk Printer Drivers  
Domain=[MSHOME] OS=[Unix] Server=[Samba 3.0.26a]  
~~~

Dacă nu ați setat o parolă atunci doar apăsați ENTER

Nu uitaţi să salvaţi. Acum puteţi porni / opri Samba cu:

~~~  
/etc/init.d/samba start  
~~~

şi opri cu:

~~~  
/etc/init.d/samba stop  
~~~

Puteţi deasemeni porni / opri Samba automat odată cu calculatorul. Rulaţi următoarele:

~~~  
update-rc.d samba defaults  
~~~

Acum Samba va porni şi se va opri odată cu calculatorul.

 [Mai multe informații despre samba găsiți aici](http://wiki.linuxquestions.org/wiki/Samba) 

<div id="rev">Page last revised 20/05/2012 1520 UTC</div>
