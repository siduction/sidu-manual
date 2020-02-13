<div id="main-page"></div>
<div class="divider" id="bios-prep"></div>
## Aggiornare il BIOS con FreeDOS

Può prospettarsi il desiderio o la necessità di aggiornare il BIOS del PC ogni qualvolta il produttore della scheda madre ne annuncia specifici miglioramenti. Il programma che viene fornito per l'aggiornamento generalmente funziona in ambiente MS-DOS.

Quanto segue illustra un modo per aggiornare il BIOS mediante un dispositivo USB da Linux. Funziona sia con chiavette USB che con schede micro/mini/SD (mediante apposito adattatore).

Quale condizione preliminare, il BIOS deve consentire l'avvio da USB ed essere compatibile con gli hard disk USB. Alcuni BIOS accettano come periferiche USB sia dispositivi Floppy, che CD-ROM e drive ZIP, ma anche se ognuno di questi può essere utilizzato potrebbe risultare poi più difficile implementare gli aggiornamenti. Si potrebbe peraltro non avere altra scelta (in particolare per i netbook).

### C'è bisogno di tre cose:

1. Una chiavetta USB, preferibilmente &lt;2 GByte (FAT16 non permette più di 2 GByte); l'installazione base di FreeDOS (fdbasecd.iso) di per sé usa solo 5,8 MByte; `FAT16 è il formato raccomandato dal momento che FAT32 non è riconosciuto come avviabile da tutti i BIOS` ;  
2. Un mezzo di installazione di FreeDOS:  [fdbasecd.iso (8MByte)](http://www.freedos.org/freedos/files/) ;  
3. qemu (apt-get install qemu) è necessario per l'installatore: in poche parole, il BIOS emulato di qemu fa apparire a FreeDOS la chiavetta USB come un normale hard disk: in questo modo l'installazione può aver luogo in maniera usuale (e ciò evita di masterizzare il CD di FreeDOS).  

###### **`Aspetto di importanza fondamentale: la chiavetta USB non deve essere montata in nessun modo. Fate attenzione a selezionare il dispositivo corretto, altrimenti tutti i dati in quello erroneamente selezionato, ad es. l'hard disk principale, saranno cancellati senza preavviso.`** 

Inserite la chiavetta USB, **`ricordando di non montarla`** . Controllate con dmesg (tra gli ultimi messaggi, se la chiavetta è stata appena inserita) quale nome di periferica le è stato assegnato, per esempio: `/dev/sdb` .

Cancellate i contenuti della chiavetta, `tutti i dati saranno persi` ; la si può "ripulire" interamente anziché solo nei primi 16 MByte.

~~~  
$ sux  
Password:  
dd if=/dev/zero of=/dev/sdb bs=1M count=16  
16+0 records in  
16+0 records out  
16777216 bytes (17 MB) copied, 2.35751 s, 7.1 MB/s  
~~~

### Partizionare la chiavetta USB

Partizionare e formattare correttamente la chiavetta USB è probabilmente la parte più difficile.

Selezionate per la partizione il filesystem FAT16 su chiavette &lt;2 GB (ciò offre maggiore compatibilità).

Eseguite fdisk sulla partizione:

~~~  
# fdisk /dev/sdb  
fdisk /dev/sdb  
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel  
Building a new DOS disklabel with disk identifier 0xa8993739.  
Changes will remain in memory only, until you decide to write them.  
After that, of course, the previous content won't be recoverable.  
Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)  
~~~

Adesso create una partizione:

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

Verificatene la creazione stampando la tabella delle partizioni:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MB, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 1 1018 1956595+ 83 Linux  
~~~

Selezionate il tipo corretto per la partizione, '6' per FAT16:

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

Attivate la nuova e unica partizione:

~~~  
Command (m for help): a   
Partition number (1-4): 1   
~~~

Visualizzate di nuovo la tabella delle partizioni, riverificate che la partizione sia stata attivata:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MB, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 * 1 1018 1956595+ 6 FAT16  
~~~

Scrivete la nuova tabella delle partizioni nella chiavetta USB e uscite da fdisk:

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

Formattate la chiavetta USB:

~~~  
mkfs -t vfat -n FreeDOS /dev/sdb1  
exit  
~~~

La fase di preparazione adesso è completa. La chiavetta USB è stata partizionata e formattata, non è rimasto altro da fare e si può procedere con il processo di installazione.

### Avviare FreeDOS con qemu

Poiché il DOS non ha idea di cosa sia una chiavetta USB, è necessario trovare un modo per convincere il programma di installazione di FreeDOS a riconoscere la periferica USB come un normale "hard disk"; nell'avvio live, il BIOS di sistema lo fa per noi, ma qui bisogna essere inventivi con qemu:

~~~  
come utente ($):  
qemu -hda /dev/sdb -cdrom /percorso/verso/fdbasecd.iso -boot d  
~~~

`ctrl-alt`  commuterà il controllo del mouse e della tastiera, permettendo quindi a ogni passo di cambiare desktop per rileggere le istruzioni.

![QEMU FreeDOS](../images-common/images-qemu-freedos/qemu-boot01.jpg "QEMU FreeDOS") 

L'istruzione precedente avvia il CD di FreeDOS e collega la chiavetta USB come disco fisso master primario (qui la capacità di qemu di emulare il BIOS permette alla chiavetta USB di apparire al DOS come un normale disco fisso). Selezionate l'installatore dal menu di avvio virtualizzato di FreeDOS:

~~~  
1) Continue to boot FreeDOS from CD-ROM  
1   
enter  
~~~


---

Mantenete la scelta di default, `1` , e/o scegliete `Yes`  quando richiesto.


---

![freedos-inst1](../images-common/images-qemu-freedos/qemu-boot02.jpg "Freedos Installation - 1") 


---

![freedos-inst2](../images-common/images-qemu-freedos/qemu-boot04.jpg "Freedos Installation - 2") 


---


---

![freedos-inst3](../images-common/images-qemu-freedos/qemu-boot09.jpg "Freedos Installation - 3") 


---

L'installatore vi chiederà di riavviare - `ma non fatelo ancora poiché è necessario correggere due errori dell'installatore FreeDOS per il mbr e il menù di avvio` . Premete la lettera `**n**` .


---

![freedos-do not reboot type n](../images-common/images-qemu-freedos/qemu-boot18.jpg "Freedos Installation - do not reboot type n") 


---

### Scrivere un settore d'avvio nella chiavetta USB

Il primo errore da correggere è il mbr con:

~~~  
fdisk /mbr 1  
~~~

Il secondo errore che deve essere corretto è il menù d'avvio nel nuovo fdconfig.sys; eseguite:

~~~  
cd \  
edit fdconfig.sys  
~~~

e cambiate la linea che avvia command.com in:

~~~  
1234?SHELLHIGH=C:\FDOS\command.com C:\FDOS /D /P=C:\fdauto.bat /K set  
(non va in effetti cambiato questo comando, basta aggiungere "1234?" all'inizio della linea prima di SHELLHIGH=C:\FDOS\command.com .....)  
NOTA - è da leggere: 1234?`   
~~~

![fdconfig.sys](../images-common/images-qemu-freedos/qemu-boot23.jpg "Edit fdconfig.sys ") 


---

**`Non cambiate altro dal momento che la linea dipende dal setup dell'installazione.`** 

Salvate e uscite da "edit":

~~~  
[alt]+[f]  
~~~

Non appena si è di nuovo al prompt dei comandi si può uscire da qemu.

Provate se qemu avvia dalla chiavetta USB.

~~~  
qemu -hda /dev/sdb -boot c  
~~~

La chiavetta adesso è avviabile e contiene una installazione completa di FreeDOS di 5,4 MByte, pronta per l'aggiornamento. Bisogna avviare senza nessun driver `(opzione menu: 4): caricare himem.sys e emm386 può interferire con il programma che scrive il BIOS!`  

### Aggiornare il BIOS

Assumendo che il PC sia acceso e in funzione, inserite la chiavetta USB con FreeDOS, montatela e scaricatevi i file del BIOS necessari come raccomandato dal produttore della vostra scheda madre, quindi smontatela.

Spegnete il PC, inserite la chiavetta USB con FreeDOS, accendete, avviate dalla chiavetta USB e seguite le procedure del produttore della scheda madre.

<div id="rev">Content last revised 19/01/2012 1900 UTC</div>
