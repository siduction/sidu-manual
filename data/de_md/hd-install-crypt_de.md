% Installation auf eine verschlüsselte root-Partition


ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

Änderungen 2021-04
+ Angepasst für pandoc

ENDE INFOBEREICH FÜR DIE AUTOREN



# Installation auf eine verschlüsselte root-Partition

~~~note
Anmerkung:
 Es gibt Wichtiges zu beachten, wenn Root- oder Datenpartitionen verschlüsselt werden. Darunter;  
~~~

+  Folgende Anleitung beinhaltet nur Grundlegendes. Wir raten, mehr über LUKS, cryptsetup und Verschlüsselung in Erfahrung zu bringen. Weitere Quellen sind am Ende dieser Seite verlinkt. Die gelisteten Informationen sind nur erste weitere Schritte. Englischkenntnisse sind notwendig. 
+  cryptsetup kann keine existierende Datenpartition verschlüsseln, daher muss eine neue Partition erstellt werden, die mit cryptsetup aufgesetzt wird. Im Anschluss können Daten auf diese Partition geschrieben werden. 
+  Es können auch Schlüsseldateien verwendet werden. Für Daten können Mehrfachschlüssel verwendet werden (bis zu maximal acht). Dies wird in dieser Anleitung nicht erläutert. 
+  Bitte vergiss nicht Deine Passwörter! Ohne sie kann auf die Daten nicht mehr zugegriffen werden! Auch mittels chroot mit Passwörtern kann nur auf /boot zugegriffen werden.
+  Das Passwort wird früh im Bootprozess abgefragt und das System startet danach wie vorgesehen. 

## Verschlüsselungsbeispiele:

+  [Verschlüsselung innerhalb von LVM-Gruppen](hd-install-crypt-de.htm#lvm) . 
+  [Anmerkungen zur Verschlüsselung mit traditioneller Partitionierung](hd-install-crypt-de.htm#simple) . 

## Verschlüsselung innerhalb von LVM-Gruppen

~~~note
Anmerkung:
 Dieses Beispiel nutzt die Verschlüsselung innerhalb des LVM-Volumens, um /home von `/` abzutrennen 
 und eine Swap-Partition zu haben, ohne multiple Passwörter verwenden zu müssen.
~~~

Bevor der Installer gestartet werden kann, muss das Dateisystem, welches für die Installation verwendet wird, vorbereitet werden. Eine einfache Anleitung dazu findet sich im Kapitel [Logical Volume Manager - LVM-Partitionierung](part-lvm-de.htm#part=lvm) . 

Man benötigt zumindest ein nicht verschlüsseltes `/boot` -Dateisystem und ein verschlüsseltes Dateisystem für **`/`** . Ferner sind verschlüsselte Dateisysteme für `/home und swap`  anzulegen. 

1.  Falls nicht geplant ist, eine existierende LVM-Gruppe zu verwenden, wird eine normale LVM-Gruppe angelegt. In diesem Beispiel wird angenommen, dass die LVM-Gruppe `vg`  benannt ist und Boot sowie verschlüsselte Daten beinhaltet.

2.  Ein LVM wird für /boot und die verschlüsselten Daten benötigt. Mit `lvcreate`  werden LVMs in `vg`  mit gewünschter Größe erstellt:      

    ~~~sh
    lvcreate -n boot --size 250m vg
    lvcreate -n crypt --size 300g vg
    ~~~
    Mit diesen Befehlen wurden die LVMs "boot" und "crypt" benannt, ihre Größen sind 250MByte bzw. 300GByte. 

3.  Nun wird das Dateisystem für `/boot`  erstellt, damit es im Installer vorhanden ist:

    ~~~sh
    mkfs.ext4 /dev/mapper/vg-boot
    ~~~

4.  `cryptsetup`  wird nun verwendet, um `vg-crypt`  zu verschlüsseln. Dabei wird die schnellere Option xts mit dem stärksten Schlüssel (Länge: 512bit) verwendet. Danach wird das Dateisystem geöffnet. Es wird zweimal nach dem Passwort gefragt, um es zu setzen, und ein drittes Mal, um das Dateisystem zu öffnen. Geöffnet wird es mit den Default-Bootoptionen von cryptopt und dem Zielnamen cryptroot:      
    ~~~sh
    cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/mapper/vg-crypt
    ~~~
        
    ~~~sh
    cryptsetup luksOpen /dev/mapper/vg-crypt cryptroot
    ~~~

5.  Nun wird die LVM innerhalb des verschlüsselten Dateisystems verwendet, um eine zweite LVM-Gruppe zu erstellen, welche für `/swap`  und `/home`  verwendet wird. Man verwendet `pvcreate`  cryptroot zur Erstellung eines physischen LVM und `vgcreate` , um eine weitere LVM-Gruppe zu erstellen. Wir nennen sie `cryptvg` :

    ~~~sh
    pvcreate /dev/mapper/cryptroot
    vgcreate cryptvg /dev/mapper/cryptroot
    ~~~

6.  Als nächstes verwenden wir `lvcreate`  mit der neuen verschlüsselten LVM-Gruppe `cryptvg` , um die LVMs **`/`** , `/swap` und `/home` mit der gewünschten Größe zu erstellen:

    ~~~sh
    lvcreate -n swap --size 2g cryptvg
    lvcreate -n root --size 40g cryptvg
    lvcreate -n home --size 80g cryptvg
    ~~~

    Nun wurden die LVMs swap, root und home mit den Größen 2GB, 40GB bzw. 80GB erstellt. 

7.  Nun werden die Dateisysteme für cryptvg-swap, cryptvg-root und cryptvg-home erstellt, damit sie für den Installer vorhanden sind:      
    
    ~~~sh
    mkswap /dev/mapper/cryptvg-swap
    mkfs.ext4 /dev/mapper/cryptvg-root
    mkfs.ext4 /dev/mapper/cryptvg-home
    ~~~

8.   **Der Installer kann nun gestartet werden, in dem folgende Optionen benutzt werden sollen:**  

        `vg-boot` für `/boot`,  
        
        `cryptvg-root` für `/`,  
        
        `cryptvg-home` für `/home`,  
        
        und `cryptvg-swap` für `swap` sollten automatisch erkannt werden. 

Das installierte System sollte eine Kernel-Befehlszeile mit folgenden Optionen aufweisen:

~~~sh
root=/dev/mapper/cryptvg-root cryptopts=source=/dev/mapper/vg-crypt,target=cryptroot,lvm=cryptvg-root
~~~

crypt und boot sind innerhalb der LVM-Gruppe vg und root, home wie swap sind innerhalb der LVM-Gruppe vgcrypt (innerhalb des passwortgeschützten verschlüsselten Bereichs).

~~~note
Falls auf ein bereits verschlüsseltes LVM-Volume installiert wird, muss dem Installer diese Information bereitgestellt werden:
~~~

~~~sh
cryptsetup luksOpen /dev/mapper/cryptvg-root cryptvg
vgchange -a y
~~~

## Anmerkungen zu crypt mit traditioneller Partitionierung

Als erstes muss das Layout der Festplatte festgelegt werden. Es werden mindestens zwei Partitionen benötigt, eine normale Partition für `/boot`  und eine für die verschlüsselten Daten.

Falls swap benötigt wird (swap sollte auch verschlüsselt sein), wird eine dritte Partition benötigt. Das Passwort für swap muss während des Bootvorgangs extra eingegeben werden (es gibt zwei Passwortabfragen). 

Es ist möglich, für swap Schlüssel von innerhalb des verschlüsselten Systems zu benutzen, dann jedoch ist ein suspend-to-disk nicht möglich. Aus diesem Grund ist es langfristig besser, LVMs mit voll verschlüsselten Partitionen und Schlüsseln zu verwenden..

###  Grundannahmen:

+ Es gibt nur drei Partitionen auf der Festplatte:

    `/boot`  mit 250MB  
    `/swap`  mit 2GB  
    **`/`**  und `/home`  vereint: Rest. 

+ Es werden zwei Passwörter verwendet, eines für swap, das andere für die gemeinsame Partition für **`/`**  und `/home` . 

Nach Abschluss der Partitionierung müssen die verschlüsselten Partitionen vorbereitet werden, damit sie vom Installer erkannt werden.

Falls ein Partitionierungsprogramm mit graphischer Oberfläche benutzt wurde, muss dieses beendet werden und ein Terminal geöffnet, da die Verschlüsselungsbefehle über die Befehlszeile eingegeben werden.

### Die Partition /boot

Die Partition `/boot` wird mit ext4 formatiert, falls dies noch nicht erledigt wurde:

~~~sh
/sbin/mkfs.ext4 /dev/sda1
~~~

### Verschlüsselte swap-Partition

Für die `verschlüsselte swap`  muss das Gerät `/dev/sda2`  zunächst formatiert und als verschlüsseltes Gerät geöffnet werden - wie vg-crypt oben, aber unter einem anderen Namen: swap.

   ~~~sh
    cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda2
    ~~~
 
    ~~~sh
    cryptsetup luksOpen /dev/sda2 swap
    ~~~
 
    ~~~sh
    echo "swap UUID=$(blkid -o value -s UUID /dev/sda2) none luks" >> /etc/crypttab
    ~~~

Die erstellte `/dev/mapper/swap`  wird formatiert, damit der Installer sie erkennen kann:

~~~sh
/sbin/mkswap /dev/mapper/swap
~~~

### Verschlüsselte Partition / 

Für die `verschlüsselte /`  muss das Gerät `/dev/sda3`  zunächst formatiert und als verschlüsseltes Gerät geöffnet werden - wie vg-crypt oben.

~~~sh
cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda3
~~~

~~~sh
cryptsetup luksOpen /dev/sda3 cryptroot
~~~

Die erstellte `/dev/mapper/cryptroot`  wird formatiert, damit der Installer sie sehen kann:

~~~sh
/sbin/mkfs.ext4 /dev/mapper/cryptroot
~~~

### Start des Installers

 **Nun kann der Installer geöffent werden und folgende Optionen sind zu benutzen:**  
`sda1`  für `/boot`   
`cryptroot`  für **`/`**  und `/home`   
`swap`  sollten automatisch erkannt werden.

Das installierte System sollte eine Kernel-Befehlszeile mit folgenden Optionen aufweisen (UUID wird benutzt):

~~~sh
root=/dev/mapper/cryptroot cryptopts=source=UUID=12345678-1234-1234-1234-1234567890AB, target=cryptroot
~~~

/boot ist nun eine normale Partition, die swap-Partition ist verschlüsselt wie eine gemeinsame Partition für root und /home.

### Weitere Informationen:

Unbedingt zu lesen:

~~~sh
man cryptsetup
~~~

[LUKS](http://code.google.com/p/cryptsetup/)  (Englisch)  
[Redhat](http://www.redhat.com/)  und [Fedora](http://www.redhat.com/Fedora/)  
[Protect Your Stuff With Encrypted Linux Partitions](http://www.enterprisenetworkingplanet.com/netsecur/article.php/3683011)  (Englisch)  
[KVM how to use encrypted images](http://blog.bodhizazen.net/linux/kvm-how-to-use-encrypted-images/)  (Englisch)  
[siduction-WIKI-Eintrag](http://wiki.siduction.de/index.php?title=Installation_auf_einer_verschl%C3%Bcsselten_Festplatte)   


<div id="rev">Page last revised 2021-04-14</div>
