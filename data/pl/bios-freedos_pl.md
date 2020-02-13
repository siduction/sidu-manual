<div id="main-page"></div>
<div class="divider" id="bois-prep"></div>
## Aktualizacja BIOS za pomocą FreeDOS Zdarza się,
  
że mamy potrzebę, lub też musimy zaktualizować BIOS naszego komputera. Niestety program  
dostarczany przez producenta płyty głównej jest zazwyczaj aplikacją przeznaczoną do pracy w MS-DOS.

Przedstawiamy tutaj metodę aktualizacji BIOS w Linuksie za pomocą nośnika USB oraz karty pamięci micro/mini/SD  
(przy wykorzystaniu odpowiedniego adaptera). 

Zanim zaczniesz, musisz się upewnić, że BIOS twojego komputera pozwala na uruchamianie komputera  
z USB i jest kompatybilny z dyskami twardymi na USB. Niektóre BIOS-y akceptują stacje dyskietek,  
napędy CD-ROM oraz napędy ZIP podpinane do USB. One również mogą być wykorzystane, jednak będzie  
to znacznie trudniejsze niż w przypadku zwykłego nośnika USB. Często to jedyna możliwość (netbook).


<span class="highlight-3">FAT16 jest zalecanym systemem plików, ponieważ na dyskach USB z FAT32 może
nie zostać wykryty sektor startowy przez niektóre BIOS-y.</span>.</li>
<li>Obraz instalacyjny FreeDOS -  [fdbasecd.iso (8MB)](http://www.freedos.org/freedos/files/) .</li>
<li>qemu (apt-get install qemu), który jest wymagany przez instalator.
Emulowany BIOS qemu sprawia, że dysk USB jest rozpoznawany przez FreeDOS
jako standardowy dysk twardy, więc można na nim instalować jak na normalnym
dysku (przy okazji oszczędzając na wypalaniu płyty z FreeDOS).</li>
</ol>
<h5><span class="highlight-2">BARDZO WAŻNE: Na żadnym etapie nośnik USB nie może zostać
zamontowany. Bądź ostrożny przy wybieraniu węzła (engl. device node), w przeciwnym wypadku wszelkie dane ze
źle wybranego dysku przepadną.</span></h5>

---

Podłącz dysk USB do komputera <span  
class="highlight-2">nie montując go w systemie</span> i sprawdź do którego  
węzła został przypisany (ostatnie komunikaty dmesg).  
W tym przewodniku przyjmiemy, że jest to  
`/dev/sdb`  .

Wyczyść nośnik USB, <span class="highlight-3">wszystkie zapisane na nim dane  
zostaną utracone</span>. Można wyczyśćić cały nośnik USB, nie tylko pierwsze 16 MByte jak w przykładzie. 

~~~  
 $ sux Passwort: dd if=/dev/zero of=/dev/sdb bs=1M count=16 16+0 records  
in 16+0 records out 16777216 bytes (17 MByte) copied, 2.35751 s, 7.1 MByte/s   
~~~

### Partycjonowanie nośnika USB

Poprawne partycjonowanie i formatowanie nośnika USB jest prawdopodobnie najtrudniejszym etapem aktualizacji.

Jeśli pojemność dysku jest mniejsza od 2GB, ustaw system FAT16 (oferuje większą kompatybilność).

Następnie poleceniem fdisk wyświetl informację o urządzeniu:

~~~  
# fdisk /dev/sdb  
fdisk /dev/sdb  
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel  
Building a new DOS disklabel with disk identifier 0xa8993739.  
Changes will remain in memory only, until you decide to write them.  
After that, of course, the previous content won't be recoverable.  
Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)  
~~~

Teraz utwórz nową partycję:

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

Potwierdź poprawne utworzenie nowej partycji poprzez wyświetlenie tabeli partycji:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MByte, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 1 1018 1956595+ 83 Linux  
~~~

Ustaw poprawną etykietę dla partycji, '6' dla FAT16:

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

Aktywuj nową partycję:

~~~  
Command (m for help): a   
Partition number (1-4): 1   
~~~

Wyświetl ponownie tabelę partycji i sprawdź czy partycja rzeczywiście została aktywowana:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MB, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 * 1 1018 1956595+ 6 FAT16  
~~~

Zapisz tabelę partycji i wyjdź z fdisk:

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

Sformatuj nowo powstałą partycje:

~~~  
mkfs -t vfat -n FreeDOS /dev/sdb1  
exit  
~~~

Przygotowania zakończone. Utworzyłeś partycję i sformatowałeś, wiec nie pozostało nic więcej jak przejść prosto do procesu instalacji.

### Uruchomienie FreeDOS pod qemu

Ponieważ DOS nie rozpoznaje nośnika USB,  
trzeba znaleźć sposób, aby nakłonić instalatora FreeDOS do rozpoznania nośnika USB jako zwykły "dysk twardy".  
Podczas "Live-Boot" tą funkcje przejmuje systemowy BIOS, ale w naszym przypadku trzeba użyć qemu:

~~~  
jako zwykły użytkownik$:  
qemu -hda /dev/sdb -cdrom /path/to/fdbasecd.iso -boot d  
~~~

`ctrl-alt`  Przełacza myszę i klawiaturę pomiędzy qemu i systemem na którym jest uruchomiony. Dzięki temu można przełączać pulpity by ponownie wyświetlić wszelkie instrukcje na każdym z etapów.

![QEMU FreeDOS](../images-common/images-qemu-freedos/qemu-boot01.jpg "QEMU FreeDOS") 

To uruchomi FreeDOS CD i ustawi surowy nośnik USB jako podstawowy,  
główny dysk twardy (tutaj emulowany BIOS w programie qemu sprawi że nośnik USB pojawi się jako zwykły dysk  
twardy). Teraz w "Start-Menu" wirtualnego FreeDOS wybierz instalatora:

~~~  
1) Continue to boot FreeDOS from CD-ROM  
1   
enter  
~~~


---

Pozostaw domyślny wybór `1`  i wybierz `Yes`  kiedy zapyta.


---

![freedos-inst1](../images-common/images-qemu-freedos/qemu-boot02.jpg "Freedos Installation - 1") 


---

![freedos-inst2](../images-common/images-qemu-freedos/qemu-boot04.jpg "Freedos Installation - 2") 


---


---

![freedos-inst3](../images-common/images-qemu-freedos/qemu-boot09.jpg "Freedos Installation - 3") 


---

Instalator poprosi o restart - `lecz nie restartuj teraz, ponieważ trzeba naprawić dwa błedy instalatora FreeDOS, mbr i start-menu` . Daj literę `**n**` .


---

![freedos-do not reboot type n](../images-common/images-qemu-freedos/qemu-boot18.jpg "Freedos Installation - do not reboot type n") 


---

### Zapisanie sektora rozruchowego na dysk USB 

Naprawa mbr następuje poprzez:

~~~  
fdisk /mbr 1  
~~~

Drugim błedem, który wymaga naprawy jest start-menu w nowym fdconfig.sys, uruchom:

~~~  
cd \  
edit fdconfig.sys  
~~~

by zmienić linię uruchamiającą command.com w nastepujący sposób:

~~~  
1234?SHELLHIGH=C:\FDOS\command.com C:\FDOS /D /P=C:\fdauto.bat /K set  
(don't actually change this command, just add "1234?" to the begin of the line (before SHELLHIGH==C:\FDOS\command.com .....  
NOTE it is to read: 1234?`   
~~~

![fdconfig.sys](../images-common/images-qemu-freedos/qemu-boot23.jpg "Edit fdconfig.sys ") 


---

**`Nie zmieniaj nic innego, jako że ta linia zależy od konfiguracji instalacji.`** 

Zapisz i wyjdź z "edit":

~~~  
[alt]+[f]  
~~~

Po powrocie do wiersza polecenia, można opuścić qemu.

Teraz test dla sprawdzenia, czy qemu uruchomi dysk USB.

~~~  
qemu -hda /dev/sdb -boot c  
~~~

Nośnik USB jest teraz uruchamialny i zawiera pełną instalację FreeDOS z 5.4 MB, gotową do aktualizacji BIOS. Powinien się załadować bez żadnych dodatkowych sterowników `(menu option 4), wczytanie plików himem.sys i emm386 mogłoby kolidować z programami flashujacymi!` :

### Aktualizacja BIOS

Zakładając, że komputer jest uruchomiony, podłącz nośnik USB FreeDOS. Zamontuj go i pobierz potrzebne pliki BIOS, zgodnie z zaleceniami producenta płyty głównej i systemu BIOS, na nośnik USB FreeDOS. Następnie odmontuj nośnika USB.

Wyłacz komputer, podłącz nośnika USB FreeDOS, włącz komputer tak aby wystartować FreeDOS z dysku USB i postępuj zgodnie z zaleceniami producenta płyty głównej i systemu BIOS.

<div id="rev">Treść ostatnio zmieniona 22/01/2012 1900 UTC</div>
