<div id="main-page"></div>
<div class="divider" id="bois-prep"></div>
## Actualizarea (Upgrading) BIOS-ului cu FreeDOS

Puteți dori sau să aveți nevoie să faceți o actualizare de BIOS al PC-ului dumneavoastră, când producătorul plăcii de bază anunță unele îmbunătățiri ale soft-ului (BIOS software). De obicei programul de instalare este oferit ca o aplicație ce rulează sub MS-DOS.

Vă prezentăm o metodă de actualizare a BIOS-ului de pe un USB în linux. Aceasta va funcționa cu un USB keys, USB sticks și cu card-uri micro/mini/SD (cu adaptorul adecvat).

În primul rând, BIOS-ul dvs. trebuie să poată boota de pe USB - și să recunoască USB harddisk-uri. Unele BIOS-uri acceptă USB Floppies, CD-ROM-uri sau ZIP drives, acestea ar putea fi utilizate chiar dacă s-ar putea să întâmpinați unele dificultăți la implementarea update-ului; oricum s-ar putea să nu aveți altă opțiune în unele cazuri (netbooks în particular).

### Aveți nevoie de trei lucruri:

1. Un USB stick, preferabil de &lt;2 GB (FAT16 nu suportă mai mult de 2 GB), iar instalarea programului FreeDOS (fdbasecd.iso) ocupă doar 5.8 MB. `FAT16 este formatul recomandat deoarece formatul FAT32 nu este detectat ca bootabil de toate BIOS-urile` .  
2. Programul FreeDOS de la  [fdbasecd.iso (8MB)](http://www.freedos.org/freedos/files/) .  
3. qemu (apt-get install qemu), qemu este necesar pentru că emulatorul lui de BIOS face ca stick-ul USB să aparâ pentru FreeDOS ca un harddisk ordinar și deci puteți face o instalare normală (scutiți de asemenea arderea unui CD cu FreeDOS).  

##### **`FOARTE IMPORTANT !!: în orice acțiune USB stick-ul este cel ce trebuie montat. Fiți foarte atenți și selectați dispozitivul corect, altfel toate datele de pe disk-ul greșit ales le veți pierde fără posibilitatea recuperării, de exemplu disk-ul dvs. principal.`** 


---

Introduceți stick-ul USB într-un port, **`nu uitați, nu-l montați în sistem!`** . Verificați 'dmesg' (ultimele mesaje, dacă doar l-ați atașat), care 'device node' a fost atribuit stick-ului USB să zicem `/dev/sdb`  .

Curățați stick-ul USB ,`toate datele de pe el vor fi șterse` ; puteți șterge tot sau doar primii 16 MB. 

~~~  
$ sux  
Password:  
dd if=/dev/zero of=/dev/sdb bs=1M count=16  
16+0 records in  
16+0 records out  
16777216 bytes (17 MB) copied, 2.35751 s, 7.1 MB/s  
~~~

### Partiționarea stick-ului USB

Partiționarea și formatarea corectă a stick-ului USB este probabil cea mai grea etapă.

Setați eticheta (label) a partiției pe FAT16, la stick-uri &lt;2 GB (oferă o mai bună compatibilitate).

Urmează partiționarea cu 'fdisk':

~~~  
# fdisk /dev/sdb  
fdisk /dev/sdb  
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel  
Building a new DOS disklabel with disk identifier 0xa8993739.  
Changes will remain in memory only, until you decide to write them.  
After that, of course, the previous content won't be recoverable.  
Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)  
~~~

Acum creați o partiție:

~~~  
Command (m for help): n   
Command action  
e extended  
p primary partition (1-4)  
p   
Partition number (1-4): 1   
First cylinder (1-1018, default 1):  
Using default value 1  
Last cylinder or +size or +sizeM or +sizeK (1-1018, default 1018):  
Using default value 1018  
~~~

Confirmați crearea partiției prin scrierea tabelei cu partiții:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MB, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 1 1018 1956595+ 83 Linux  
~~~

Setați eticheta corectă a partiției, '6' pentru FAT16:

~~~  
Command (m for help): t   
Selected partition 1  
Hex code (type L to list codes): l   
0 Empty 1e Hidden W95 FAT1 80 Old Minix be Solaris boot  
1 FAT12 24 NEC DOS 81 Minix / old Lin bf Solaris  
2 XENIX root 39 Plan 9 82 Linux swap / So c1 DRDOS/sec (FAT-  
3 XENIX usr 3c PartitionMagic 83 Linux c4 DRDOS/sec (FAT-  
4 FAT16 <32M 40 Venix 80286 84 OS/2 hidden C: c6 DRDOS/sec (FAT-  
5 Extended 41 PPC PReP Boot 85 Linux extended c7 Syrinx  
6 FAT16 42 SFS 86 NTFS volume set da Non-FS data  
7 HPFS/NTFS 4d QNX4.x 87 NTFS volume set db CP/M / CTOS / .  
8 AIX 4e QNX4.x 2nd part 88 Linux plaintext de Dell Utility  
9 AIX bootable 4f QNX4.x 3rd part 8e Linux LVM df BootIt  
a OS/2 Boot Manag 50 OnTrack DM 93 Amoeba e1 DOS access  
b W95 FAT32 51 OnTrack DM6 Aux 94 Amoeba BBT e3 DOS R/O  
c W95 FAT32 (LBA) 52 CP/M 9f BSD/OS e4 SpeedStor  
e W95 FAT16 (LBA) 53 OnTrack DM6 Aux a0 IBM Thinkpad hi eb BeOS fs  
f W95 Ext'd (LBA) 54 OnTrackDM6 a5 FreeBSD ee EFI GPT  
10 OPUS 55 EZ-Drive a6 OpenBSD ef EFI (FAT-12/16/  
11 Hidden FAT12 56 Golden Bow a7 NeXTSTEP f0 Linux/PA-RISC b  
12 Compaq diagnost 5c Priam Edisk a8 Darwin UFS f1 SpeedStor  
14 Hidden FAT16 <3 61 SpeedStor a9 NetBSD f4 SpeedStor  
16 Hidden FAT16 63 GNU HURD or Sys ab Darwin boot f2 DOS secondary  
17 Hidden HPFS/NTF 64 Novell Netware b7 BSDI fs fd Linux raid auto  
18 AST SmartSleep 65 Novell Netware b8 BSDI swap fe LANstep  
1b Hidden W95 FAT3 70 DiskSecure Mult bb Boot Wizard hid ff BBT  
1c Hidden W95 FAT3 75 PC/IX  
Hex code (type L to list codes): 6   
Changed system type of partition 1 to 6 (FAT16)  
~~~

Activați noua și singura partiție:

~~~  
Command (m for help): a   
Partition number (1-4): 1   
~~~

Scrieți din nou tabela cu partiții, reconfirmați că partiția trbuie într-adevăr activată:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MB, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 * 1 1018 1956595+ 6 FAT16  
~~~

Scrieți noua tabelă cu partiții pe stick-ul USB și ieșiti din 'fdisk':

~~~  
Command (m for help): w   
The partition table has been altered!  
Calling ioctl() to re-read partition table.  
WARNING: If you have created or modified any DOS 6.x  
partitions, please see the fdisk manual page for additional  
information.  
Syncing disks.  
# exit  
~~~

Formatați nou creatul stick USB :

~~~  
mkfs -t vfat -n FreeDOS /dev/sdb1  
exit  
~~~

Faza pregătitoare este acum completă. Aveți stick-ul USB partiționat și formatat, deci nu mai aveți altceva de făcut decât să treceți direct la procesul de instalare.

### Boot-area FreeDOS cu qemu

Ca și DOS nu are habar de USB stick, deci va trebui să găsiți o cale de a convinge instaler-ul FreeDOS să recunoască USB-ul ca fiind un "harddisk" ordinar atunci când bootează, BIOS-ul sistemului făcând asta pentru noi - dar aici trebuie să fim inventivi cu qemu:

~~~  
as user$:  
qemu -hda /dev/sdb -cdrom /path/to/fdbasecd.iso -boot d  
~~~

`ctrl-alt`  va elibera mouse-ul și tastatura pentru a putea naviga printre desktop-uri și să recitiți instrucțiunile pentru fiecare pas.

![QEMU FreeDOS](../images-common/images-qemu-freedos/qemu-boot01.jpg "QEMU FreeDOS") 

Acesta-i ecranul de bootare a FreeDOS CD și indică stick-ul USB ca 'primary master HD' (aici emulatorul de BIOS al lui 'qemu' face ca stick-ul USB să apară pentru DOS ca un harddisk ordinar). Selectați instalarea din meniul de start al virtualului FreeDOS :

~~~  
1) Continue to boot FreeDOS from CD-ROM  
1   
enter  
~~~


---

Continuați să alegeți opțiunea implicită `1`  și/sau alegeți `Yes`  când sunteți întrebați.


---

![freedos-inst1](../images-common/images-qemu-freedos/qemu-boot02.jpg "Freedos Installation - 1") 


---

![freedos-inst2](../images-common/images-qemu-freedos/qemu-boot04.jpg "Freedos Installation - 2") 


---


---

![freedos-inst3](../images-common/images-qemu-freedos/qemu-boot09.jpg "Freedos Installation - 3") 


---

Install-erul vă solicită să 'reboot' - `NU faceți asta încă, fiind nevoie să reparăm două erori în instalerul FreeDOS pentru 'mbr' și 'bootmenu'` . Tastați litera `**n**` .


---

![freedos-do not reboot type n](../images-common/images-qemu-freedos/qemu-boot18.jpg "Freedos Installation - do not reboot type n") 


---

### Scrierea sectorului de boot pe stick-ul USB

Prima eroare de reparat este 'mbr' cu:

~~~  
fdisk /mbr 1  
~~~

A doua eroare de reparat este 'bootmenu' în noul 'fdconfig.sys', executați:

~~~  
cd \  
edit fdconfig.sys  
~~~

și schimbați linia care începe cu "command.com" în:

~~~  
1234?SHELLHIGH=C:\FDOS\command.com C:\FDOS /D /P=C:\fdauto.bat /K set  
(don't actually change this command, just add "1234?" to the begin of the line (before SHELLHIGH==C:\FDOS\command.com .....  
NOTE it is to read : 1234?`   
~~~

![fdconfig.sys](../images-common/images-qemu-freedos/qemu-boot23.jpg "Edit fdconfig.sys ") 


---

**`NU schimbați nimic altceva, deoarece linia depinde de setarea instalării voastre.`** 

Salvați și ieșiți din "edit" cu:

~~~  
[alt]+[f]  
~~~

După ce apare din nou prompt-ul, puteți părăsi 'qemu'.

Verificați dacă qemu bootează de pe stick-ul USB .

~~~  
qemu -hda /dev/sdb -boot c  
~~~

Stick-ul USB este acum bootabil și conține o instalare completă a FreeDOS de 5.4 MB, pentru 'flashing'. Trebuie să bootați FĂRĂ nici un driver `( opțiunea 4 din menu), încărcarea fișierele 'himem.sys' și 'emm386' poate interfera cu programul de 'flashing' !` :

### Actualizarea BIOS-ului

Presupunând că PC-ul este pornit și funcționează, introduceți stick-ul USB cu FreeDOS, montați-l și descarcați fișierele necesare BIOS-ului, așa cum recomandă producătorul plăcii de bază/BIOS-ului, pe stik-ul USB FreeDOS, apoi demontați stick-ul.

 Opriți PC-ul, introduceți stick-ul cu FreeDOS într-un port USB, porniți PC-ul astfel încât să bootați de pe stick-ul USB cu FreeDOS și urmați procedurile și sfaturile producătorului plăcii de bază/BIOS-ului.

<div id="rev">Content last revised 30/11/2012 0150 UTC</div>
