<div id="main-page"></div>
<div class="divider" id="bois-prep"></div>
## Como Atualizar a BIOS com FreeDOS

Você pode querer (ou precisar) atualizar a BIOS de seu PC quando o fabricante da placa-mãe anunciar melhoramentos no software da BIOS. O programa de instalação geralmente oferecido é uma aplicação do MS-DOS.

Eis aqui uma maneira de atualizar a BIOS a partir de uma porta USB no Linux. Deve funcionar com qualquer dispositivo USB, como chaveiros, pendrives e micro/mini cartões SD (estes, desde que tenham os necessários adaptadores, naturalmente).

Antes de mais nada, sua BIOS precisa ser capaz de permitir boot a partir de portas USB - e ser compatível com HDs USB. Algumas BIOS aceitam disquetes, CD-ROMs e ZIP drives por USB; ainda que estes sejam passíveis de utilização, pode ser mais difícil implementar a atualização, mas pode ser também que você não tenha outra opção (especialmente no caso de netbooks).

### Você vai precisar de três coisas:

1. uma pendrive, de preferência &lt;2 GB (FAT16 não permite mais do que 2 GB e uma instalação base do FreeDOS (fdbasecd.iso) ocupa apenas 5.8 MB). `FAT16 é o formato recomendado, de vez que FAT32 não é detectada por toda BIOS` .  

<li>uma mídia de instalação do FreeDOS;  [fdbasecd.iso (8MB)](http://www.freedos.org/freedos/files/)  é o suficiente.</li>
<li>qemu (use 'apt-get install qemu'). O qemu é exigido pelo instalador; basicamente, a BIOS emulada pelo qemu faz com que sua pendrive seja vista pelo FreeDOS como um HD comum, assim você pode fazer a instalação facilmente (e economiza um CD, pois você não vai precisar queimar a ISO).</li>
</ol>
##### **`Atenção, isto é criticamente importante: em nenhum estágio do processo, a pendrive deve estar montada. Tenha bastante cuidado ao selecionar o dispositivo correto, senão todo o conteúdo do disco errado será apagado inapelavelmente (estamos falando aqui de seu HD principal!!).`** 

Conecte sua pendrive e lembre-se de **`não montá-la`** . Verifique no dmesg (as últimas mensagens, se você tiver acabado de conectá-la) qual o nome que foi atribuído a ela; digamos que tenha sido `/dev/sdb` .

Limpe seu dispositivo USB (`todos os dados serão perdidos.` ) Você pode também limpar tudo, não apenas os primeiros 16MB: 

~~~  
$ sux  
Senha (ou Password):  
dd if=/dev/zero of=/dev/sdb bs=1M count=16  
16+0 records in  
16+0 records out  
16777216 bytes (17 MB) copied, 2.35751 s, 7.1 MB/s  
~~~

### Como particionar sua pendrive

Particionar e formatar sua pendrive corretamente talvez sejam as etapas mais difíceis.

Selecione FAT16 para pendrives &lt;2 GB (oferece uma compatibilidade melhor).

A seguir, rode o fdisk para fazer o particionamento:

~~~  
# fdisk /dev/sdb  
fdisk /dev/sdb  
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel [Dispositivo não contém uma tabela de partições DOS válida, nem rótulos Sun, SGI ou OSF]  
Building a new DOS disklabel with disk identifier 0xa8993739. [Montando nova rotulagem DOS com identificador de disco 0xa8993739]  
As alterações permanecerão apenas na memória, até que você se decida a escrevê-las.  
Depois disso, naturalmente, o conteúdo anterior não poderá ser recuperado.  
Atenção: o flag inválido 0x0000 da tabela de partições 4 será corrigido por w(rite) (escrever)  
~~~

Agora, crie uma partição:

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

Para confirmar que a partição foi criada, peça que a tabela de partições seja exibida:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MB, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 1 1018 1956595+ 83 Linux  
~~~

Selecione o rótulo correto, '6' para FAT16:

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

Ative a nova (e única) partição:

~~~  
Command (m for help): a   
Partition number (1-4): 1   
~~~

Reveja a nova tabela de partições e torne a confirmar que a partição está mesmo ativada:

~~~  
Command (m for help): p   
Disk /dev/sdb: 2003 MB, 2003828736 bytes  
62 heads, 62 sectors/track, 1018 cylinders  
Units = cylinders of 3844 * 512 = 1968128 bytes  
Disk identifier: 0xa8993739  
Device Boot Start End Blocks Id System  
/dev/sdb1 * 1 1018 1956595+ 6 FAT16  
~~~

Escreva a nova tabela de partições em sua pendrive e saia do fdisk:

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

Formate a partição recém-criada:

~~~  
mkfs -t vfat -n FreeDOS /dev/sdb1  
exit  
~~~

A fase preparatória está completa. Você particionou e formatou seu dispositivo USB. Nada mais há a fazer aqui, portanto vamos para o processo de instalação.

### Como dar o boot no FreeDOS com o qemu

Como o DOS não faz nem ideia do que seja dispositivo USB, teremos de encontrar um meio de persuadir o instalador do FreeDOS a reconhecer a pendrive como um HD comum. Em uma inicialização do tipo live, a BIOS do sistema faz isso para nós - porém, com o qemu teremos de ser inventivos:

~~~  
como usuário:  
qemu -hda /dev/sdb -cdrom /path/to/fdbasecd.iso -boot d  
~~~

`ctrl-alt`  alterna mouse e teclado, de forma a permitir que você troque de telas do desktop para reler quaisquer instruções em cada passo.

![QEMU FreeDOS](../images-common/images-qemu-freedos/qemu-boot01.jpg "QEMU FreeDOS") 

Com isso, damos o boot no CD do FreeDOS e estabelecemos a pendrive como o HD Master primário (aqui, a BIOS emulada pelo qemu habilmente faz a pendrive ser vista pelo DOS como um HD comum). Vamos selecionar o instalador no menu do boot virtual do FreeDOS:

~~~  
1) Continue to boot FreeDOS from CD-ROM  
1   
enter  
~~~


---

Continue a escolher as opções padrão `1`  e/ou `Yes`  quando solicitado.


---

![freedos-inst1](../images-common/images-qemu-freedos/qemu-boot02.jpg "Freedos Installation - 1") 


---

![freedos-inst2](../images-common/images-qemu-freedos/qemu-boot04.jpg "Freedos Installation - 2") 


---


---

![freedos-inst3](../images-common/images-qemu-freedos/qemu-boot09.jpg "Freedos Installation - 3") 


---

O instalador vai pedir que o computador seja reiniciado - `mas não o faça ainda, pois teremos primeiro de sanar dois erros existentes no instalador, um referente à MBR e outro ao menu de boot` . Digite `**n**` .


---

![freedos-do not reboot type n](../images-common/images-qemu-freedos/qemu-boot18.jpg "Freedos Installation - do not reboot type n") 


---

### Como escrever um setor de boot ('bootsector') em seu dispositivo USB

O primeiro erro a ser corrigido é o da MBR:

~~~  
fdisk /mbr 1  
~~~

O segundo é o do menu de boot em seu novo fdconfig.sys. Digite:

~~~  
cd \  
edit fdconfig.sys  
~~~

... e altere a linha que começa com "command.com" (sem as aspas!) para:

~~~  
1234?SHELLHIGH=C:\FDOS\command.com C:\FDOS /D /P=C:\fdauto.bat /K set  
* na verdade, não mude este comando, apenas adicione "1234?" no início da linha (antes de SHELLHIGH==C:\FDOS\command.com .....)  
NOTA: é para ficar assim: 1234?SHELLHIGH=C:....`   
~~~

![fdconfig.sys](../images-common/images-qemu-freedos/qemu-boot23.jpg "Edit fdconfig.sys ") 


---

**`Não altere mais nada, pois a linha depende do que foi configurado em toda sua instalação.`** 

Salve e saia do "edit":

~~~  
[alt]+[f]  
~~~

Assim que voltar ao prompt, você pode sair do qemu.

Faça o teste para confirmar que o qemu vai dar o boot pela pendrive:

~~~  
qemu -hda /dev/sdb -boot c  
~~~

Seu dispositivo USB agora é capaz de dar boots e contém uma instalação completa do FreeDOS, com 5.4MB. Você deve dar o boot sem quaisquer drivers `(opção 4 do menu). Carregar os arquivos himem.sys 3 emm386 podem interferir em seus programas flash` !

### Como atualizar a BIOS

Assumindo que seu PC está rodando sem problemas, conecte a pendrive com o FreeDOS, monte-a, baixe para ela os arquivos da BIOS necessários, conforme recomendado pelo fabricante de sua placa-mãe/BIOS, e então desmonte-a e remova-a.

Desligue sua máquina, conecte a pendrive, volte a ligar o computador para dar o boot pelo FreeDOS e siga as instruções do fabricante de sua placa-mãe/BIOS.

<div id="rev">Content last revised 13/01/2012 2330 UTC</div>
