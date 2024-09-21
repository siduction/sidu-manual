% systemd-boot

## systemd-boot

Obwohl bereits vor mehr als zehn Jahren in systemd aufgenommen, findet man den Bootmanager systemd-boot (kurz sd-boot) auf Dektop Systemen selten. Entscheidet man sich bei einem passenden Setup und nach gründlichen Tests für sd-boot, stellt der Umstieg für einen etwas geübten Nutzer keine große Herausforderung dar.

**Besonderheiten**

Der Bootmanager sd-boot wurde mit dem Ziel entwickelt den Bootvorgang schnell, einfach und sicher zu gestalten. Der Anwender erhält ein textbasiertes Bootmenü. Die Anzeige kommt ohne jeglichen Schnickschnack aus.  
Er ist, dem Namen entsprechend, tief in systemd integriert und greift auf dort vorhandene Dienste zu. sd-boot erstellt ein optisch minimalistisches Bootmenü. Jeder Menüeintrag beruht auf einer einzigen, eigenen Textdatei. Die Konfiguration für die Benutzerschnittstelle ist im Vergleich zu GRUB rudimentär und der Installationsumfang, mit 32 Dateien und einem zwanzigstel des Datenvolumens, sehr gering.  
sd-boot ist ausschließlich für UEFI Hardware verfügbar. Dafür benötigt sd-boot zwingend eine ESP (**E**fi **S**ystem **P**artition). Empfohlen wird zusätzlich eine XBOOTLDR Partition.  
Ist nur die ESP vorhanden, wird sie unter `/boot` eingehangen.  
Bei ESP und XBOOTLDR Partition wird die ESP unter `/efi` und die XBOOTLDR Partition unter `/boot` eingehangen.  
Dateisystemtreiber für die XBOOTLDR Partition sind ggf. unterhalb `/efi` abzulegen.  
sd-boot kann nur Betriebssysteme von Partitionen des gleichen Mediums booten. Um Betriebssysteme von weiteren Medien zu booten benutzt man die ChainLoader Technik zu GRUB oder einem anderen Bootloader.

siduction installiert den Bootmanager GRUB automatisch. Eine Auswahl von sd-boot ist während der Installation nicht möglich. Wechselt man später zu sd-boot, so erzeugt sd-boot angepasste initrd für jeden im System vorhandenen Kernel. Nur mit diesen initrd bootet sd-boot.

**Funktionen von sd-boot:**

- Von vollständig verschlüsselter Festplatte booten.
- Unterstützung für die XBOOTLDR Partition
- Laden von Drop-in-Treibern.
- Registrieren von SecureBoot-Schlüsseln.
- Erstellen eines Menüeintrages bei Installation neuer Kernel.
- Boot-Zählung
  In Zusammenhang mit gescheiterten Bootvorgängen kann der Booteintrag automatisch entfernt werden.
- Unterstützung für die Übergabe eines Zufallsseeds an das OS.  
  Es dient dem Schutz vor der Verwendung manipulierter OS-Images.

Darüber hinaus besteht die Möglichkeit vor einem Reboot oder während des Bootvorganges Kommandos an sd-boot zu übergeben. Informationen hierzu gibt `man systemd-boot`.

**Anwendungsszenarien**

Eignung bei unterschiedlichen Systemkonfigurationen und im Vergleich mit GRUB.

| Konfiguration | sd-boot | GRUB | Bemerkung |
| :------ | :-: | :-: | :--------------- |
| Ein immutable OS | ++ | o | Es ist nur ein minimalistischer Bootmanager ohne Menü notwendig. GRUB ist für diesen Zweck überdimensioniert. |
| Ein OS auf einer HD | ++ | o | Bootmenü nur bei mehreren Kerneln notwendig. |
| Mehrere Linux OS auf einer HD | + | + | sd-boot auf allen OS notwendig. GRUB benötigt externes Modul *os-prober*. |
| Dualboot mit WIN / MAC auf einer HD | + | + | Wie zuvor. Bei beiden booten mittels ChainLoader möglich. |
| Mehrere Linux OS auf mehreren HD | - | + | sd-boot kann nur OS von einer HD booten. Zwei Instanzen im UEFI mit Auswahl über die Firmware notwendig. |
| Dualboot mit WIN / MAC auf mehreren HD | - | + | Wie zuvor. |
| Mehrere Varianten eines Linux OS auf einer HD | o | o | Bei sd-boot manuelles Anpassen der Menüeinträge nötig. Bei GRUB die Datei `/etc/default/grub.d/xxxx.cfg` erstellen oder ändern. |
| Linux OS auf Btrfs Dateisystem mit Unterstützung von snapper | - | o | sd-boot erstellt Menüeinträge nur einmalig bei der Installation der Kernel, gleichgültig aus welchem Subvolumen. Andere Subvolumen erhalten keinen Eintrag. GRUB ist je nach Distribution auf unterschiedliche, zusätzliche Software angewiesen. |
| Eine vollverschlüsselte HD | ++ | + | sd-boot reicht die Aufgaben an den Kernel und den User-Space weiter und ist dadurch effizienter. GRUB benötigt zusätzliche Software. |

sd-boot spielt seine Vorteile bei einem einfachen Hardware Setup voll aus, aber scheitert bei Betriebssystemen auf mehreren Medien.  
Grub wiederum ist universeller einsetzbar, dadurch schwergewichtig und benötigt trotzdem externe Software. Für einfache Hardware Setup ist GRUB überdimensioniert.

### systemd-boot installieren

> **Achtung**  
> Unbedingt eine Datensicherung auf einem externen Medium vornehmen.  
> Es sind Arbeiten an Partitionen notwendig um sd-boot den Empfehlungen entsprechend zu installieren.

Die Anleitung basiert auf der Standardinstallation von *siduction* mit einer ESP (**E**fi **S**ystem **P**artition), die unter `/boot/efi` eingehangen ist. Dies ist auch der Standard für Debian und viele Debian Derivate. 
Um zu sd-boot zu wechseln sind nur die zwei Pakete `systemd-boot` und `systemd-boot-efi` notwendig.  
Doch Vorsicht, zuerst sind einige Arbeiten am System notwendig.

### Vorbereitung des Systems

**Partitionierung**

Eine wesentliche Änderung von sd-boot gegenüber der Standardinstallation von siduction mit GRUB ist die Auslagerung des Verzeichnisses `/boot` in eine oder besser zwei separate Partitionen. Die Empfehlungen von sd-boot lauten:

- **Sowohl ESP als auch XBOOTLDR:**  
  *ESP*  
  gdisk Partitionstyp "EF00", Part-GUID code: C12A7328-F81F-11D2-BA4B-00A0C93EC93  
  Dateisystem: VFAT, eingehangen unter /efi/  
  Größe: 100 MB  
  *XBOOTLDR*  
  gdisk Partitionstyp "EA00", Part-GUID code: BC13C2FF-59E6-4262-A352-B275FD6F7172  
  Dateisystem: Jedes, dass die UEFI-Implementierung lesen kann, eingehangen unter /boot/  
  Größe: mind. 1 GB

- **Nur ESP:**  
  (Bedingt empfohlen, siehe unten.)  
  gdisk Partitionstyp "EF00", Part-GUID code: C12A7328-F81F-11D2-BA4B-00A0C93EC93  
  Dateisystem: VFAT, eingehangen unter /boot/  
  Größe: Mind. 1 GB

- **Nicht empfohlen:**  
  ESP eingehangen unter /boot/efi/

Hierzu übersetzte Zitate der [boot_loader_specification](https://uapi-group.org/specifications/specs/boot_loader_specification/).

[Übersetzung Anfang]  
*Hinweis: Diese Partitionen werden von allen Betriebssysteminstallationen auf derselben Festplatte gemeinsam genutzt, sodass alle denselben Ort für Einträge im Bootloader-Menü verwenden.*  
[...]  
*Das Einhängen des ESP in /boot/efi/, wie es traditionell gemacht wurde, wird nicht empfohlen. Eine solche verschachtelte Einrichtung erschwert eine Implementierung über direkte autofs-Einhängungen - wie sie beispielsweise von systemd implementiert werden -, da die Einrichtung des inneren autofs das äußere auslöst. Es wird empfohlen, die beiden Partitionen über autofs zu mounten. Da das einfache VFAT-Dateisystem eine geringe Datenintegrität aufweist, sollte es, wann immer möglich, nicht eingehängt werden.*  
[...]  
*Bei Systemen, bei denen die Firmware in der Lage ist, Dateisysteme direkt zu lesen, muss die ESP - und die GPT-XBOOTLDR-Partition sollte - ein Dateisystem sein, dass von der Firmware gelesen werden kann. Für die meisten Systeme bedeutet dies VFAT (16 oder 32 Bit). Anwendungen, die auf beide Partitionen zugreifen, sollten daher nicht davon ausgehen, dass ausgefeiltere Dateisystemfunktionen wie Symlinks, Hardlinks, Zugriffskontrolle oder Groß-/Kleinschreibung unterstützt werden.*  
[Übersetzung Ende]  

**Mindestgröße**

Hält man sich an die Empfehlungen von sd-boot und benutzt sowohl die ESP als auch die XBOOTLDR Partition, kann man die geringe Größe der ESP beibehalten und für die XBOOTLDR Partition ein leistungsstärkeres Dateisystem verwenden. Notwendige Dateisystemtreiber für die XBOOTLDR Partition sind von [akeo.ie](https://efi.akeo.ie) zu holen und nach `/efi/EFI/systemd/drivers/` zu kopieren.  
Die XBOOTLDR Partition sollte mindestens 1 GB umfassen, da sd-boot alle Kernel und initrd darin doppelt ablegt. So wie es der Standard vorschreibt einmal direkt unter `/boot/` und ein weiteres Mal unter `/boot/<Kennung>/<Version>/`. Damit fallen für einen Kernel mit initrd 70 bis 100 MB an. Der Grund hierfür dürfte in der Verwendung von VFAT, das keine Symlinks unterstützt, liegen. Bei mehreren OS mit jeweils mehreren Kernel ist die Größe von 1 GB grenzwertig und die bisher üblichen 200 bis 300 MB der ESP sind völlig untauglich. Das zieht eine Änderung der Partitionierung nach sich.

Wir behalten die ESP in ihrer bisherigen Größe und erstellen an beliebiger Stelle auf dem gleichen Medium die XBOOTLDR Partition (gdisk Typ EA00). Wie bereits erwähnt mindestens 1 GB groß, besser 2 GB. Wenn sich dabei die UUID einer bereits vorhandenen Partition ändert, muss man die Datei `/etc/fstab` anpassen. Siehe: [Die fstab anpassen](0311-part-uuid_de.md#anpassung-der-fstab).

**Daten kopieren und Dateien anpassen**

Wir öffnen ein Terminal und werden mit `su` zu ROOT.  
Sollte `gdisk` nicht installiert sein, holen wir dies nach und lesen den *Partition GUID code* der ESP und XBOOTLDR Partition aus. Die Gerätedatei kann natürlich auch '/dev/sda' sein und die Ziffer hinter der Option `-i` benennt die Partition auf dem Medium.

~~~
# sgdisk -i1 /dev/nvme0n1
Partition GUID code: C12A7328-F81F-11D2-BA4B-00A0C93EC93B (EFI system partition)
[...]
# sgdisk -i4 /dev/nvme0n1
Partition GUID code: BC13C2FF-59E6-4262-A352-B275FD6F7172 (XBOOTLDR partition)
[...]
~~~

Die jeweils erste Zeile der Ausgabe von `sgdisk` muss wie gezeigt aussehen. Wenn nicht, mit `gdisk` den Partitionstyp zu *EF00* (ESP) und *EA00* (XBOOTLDR) ändern.

Im nächsten Schritt legen wir neue Verzeichnisse an und kopieren das Verzeichnis `/boot`.

~~~
# cd /
# mkdir /efi
# mkdir /grub
# cp -a /boot/* /grub/
# umount /boot/efi/
# rm -r /boot/*
~~~

Mit der Befehlsfolge sicherten wir auch die Daten der ESP.  
Nun passen wir die Datei `/etc/fstab` an. (Zuvor eine Sicherungskopie erstellen.)

~~~
# cp /etc/fstab /etc/fstab_$(date +%F)
~~~

Von der Zeile mit dem Einhängepunkt `/boot/efi` erstellen wir eine Kopie und entfernen aus der ursprünglichen Zeile lediglich den String "/boot".  
In die Kopie schreiben wir die Daten für die XBOOTLDR Partition mit der Einhängung nach `/boot`.  
Schließlich sollten die Änderungen so aussehen.

~~~
[...]
UUID=FA62-156D           /efi    vfat   defaults 0 2
UUID=<uuid_der_xbootldr> /boot   ext4   defaults 0 2
[...]
~~~

Jetzt hängen wir die Partitionen ein und kopieren den Kernel mit Zubehör nach `/boot`. Dann erstellen wir noch das Verzeichnis für die Dateisystemtreiber der XBOOTLDR Partition.

~~~
# systemctl daemon-reload
# mount /boot/
# mount /efi/
# cp -a /grub/vmlinuz-6.8.9-1-siduction-amd64 /boot/
# cp -a /grub/initrd.img-6.8.9-1-siduction-amd64 /boot/
# cp -a /grub/System.map-6.8.9-1-siduction-amd64 /boot/
# cp -a /grub/config-6.8.9-1-siduction-amd64 /boot/
   # oder einfacher: cp -a /grub/*-6.8.9-1-siduction-amd64 /boot/
# mkdir -p /efi/EFI/systemd/drivers/
~~~

Zum Abschluss holen wir die Dateisystemtreiber von der Webseite [akeo.ie](https://efi.akeo.ie) und speichern sie im erstellten Verzeichnis unterhalb `/efi/`. Auf Ausführrechte achten.

**Installation**

Sind die Vorbereitungen abgeschlossen und wurde das Ergebnis z.B. mit den Befehlen `ls -l /boot` `lsblk` oder `sgdisk -i...` überprüft, reicht eine Kommandozeile aus um die zwei benötigten Pakete unserem System hinzuzufügen und sd-boot nach ESP und XBOOTLDR zu installieren. 

~~~
# apt install systemd-boot-efi systemd-boot
[...]
Copied "/usr/lib/systemd/boot/efi/systemd-bootx64.efi" to "/efi/EFI/systemd/systemd-bootx64.efi".
Copied "/usr/lib/systemd/boot/efi/systemd-bootx64.efi" to "/efi/EFI/BOOT/BOOTX64.EFI".
Created "/boot/e5cc6ff820c1450c93a29d8723c78cd1".
! Mount point '/efi' which backs the random seed file is world accessible, which is a security hole!
! Random seed file '/efi/loader/random-seed' is world accessible, which is a security hole!
Random seed file /efi/loader/random-seed successfully installed (32 bytes).
Created EFI boot entry "Linux Boot Manager".
~~~

Im Firmware UEFI Menü finden wir jetzt an erster Stelle den *Linux Boot Manager*, der, wie die Ausgabe zeigt, in die ESP geschrieben wurde. Gleichzeitig hat sd-boot die Booteinträge für den *Linux Boot Manager* in der XBOOTLDR Partition erstellt.  
Für jedes weitere OS auf dem Medium ist die 'Vorbereitung des Systems' und die 'Installation' notwendig.


### Konfiguration

Es gibt nur zwei Orte, an denen die Konfiguration für sd-boot liegt.  
Für den *Linux Boot Manager* ist es die Datei `/efi/loader/loader.conf` und für die *Menüeinträge* sind es die Dateien mit der Erweiterung `.conf` im Verzeichnis `/boot/loader/entries/`.

**Linux Boot Manager**  

Die Konfiguration des *Linux Boot Manager* betrifft nur die Punkte  
- Anzeige des Menüs und Timeout - nein/ja/Dauer  
- Konsole-Modus - Wert  
- Editieren der Kernelzeile - ja/nein  
- Standard Booteintrag festlegen - Wert

Bei nur einem System mit einem Kernel hat die Konfigurationsdatei folgenden Inhalt:

~~~
#timeout 3
#console-mode keep
~~~

Es wird ohne die Anzeige eines Menüs direkt in das Betriebssystem gebootet, denn 'timeout' ist auskommentiert. Der Grund: Bisher existiert nur ein einziger Menüpunkt. Nach entfernen des Kommentarzeichens erscheint das Menü einer siduction XFCE Installation.

~~~
                    siduction XFCE
            Reboot Into Firmware Interface
~~~

Bei mehreren OS auf dem Medium erthält die Datei `/efi/loader/loader.conf` eine zusätzliche Zeile `default <Kennnung>-*` um den Standardeintrag zu definieren.

~~~
timeout 3
#console-mode keep
default e5cc6ff820c1450c93a29d8723c78cd1-*
~~~

**Menüeinträge**  

Die Konfigurationsdateien liegen in dem Verzeichnis `/boot/loader/entries/` und ihr Name entspricht dem Format `<Kennung>-<Kernelversion>.conf`.  
sd-boot fügt dem Menü bei der Installation weiterer Kernel automatisch die Einträge hinzu. Mit einem zusätzlichen Kernel erhalten die Menüpunkte auch die Kernelversion.

~~~
           siduction XFCE (6.8.10-1-siduction-amd64)
           siduction XFCE (6.8.9-1-siduction-amd64)
                Reboot Into Firmware Interface
~~~

Von **mehreren OS** auf unterschiedlichen Partitionen wird nur dasjenige automatisch im Menü aufgeführt, von dem aus sd-boot installiert wurde. Die dort vorhandenen Kernel erscheinen in der Auswahl. Installiert man in jedem OS sd-boot, finden diese Booteinträge auch ihren Weg in das Menü. Hier zum Beispiel UBUNTU.

~~~
           siduction XFCE (6.8.10-1-siduction-amd64)
           siduction XFCE (6.8.9-1-siduction-amd64)
                       Ubuntu 24.04 LTS
                Reboot Into Firmware Interface
~~~

Sollte, aus welchen Gründen auch immer, ein Menüeintrag fehlen, kann die Generierung des Eintrags zu jeder Zeit erneut angestoßen werden. Es ist sicherzustellen, dass sich der Kernel, die vmlinuz und die config- Datei der entsprechenden Version im Verzeichnis `/boot/` befinden.  
Aus dem entsprechenden OS heraus erstellt der Befehl 

~~~
dpkg-reconfigure linux-image-6.8.9-1-siduction-amd64
~~~

auch den gewünschten Menüeintrag.

### GRUB entfernen

sd-boot kann zum jetzigen Zeitpunkt (08-2024) bei der Installation von siduction nicht als Standard Bootmanager ausgewählt werden. Sofern ausführliche Tests mit sd-boot erfolgreich verliefen, müssen wir GRUB aus unserem System entfernen um Fehler beim Update und Upgrade zu vermeiden.

**Pakete**  

Wir öffnen ein Terminal, werden mit `su` zu ROOT und benutzen den Befehl `apt purge` um auch die Konfigurationsdateien zu entfernen.

~~~
01|# apt purge grub*
02| Paketlisten werden gelesen…
03| Abhängigkeitsbaum wird aufgebaut…
04| Statusinformationen werden eingelesen…
05| Die folgenden Pakete werden ENTFERNT:
06|   grub-pc-bin* os-prober* grub-btrfs* siduction-btrfs* grub-efi-amd64-bin*
07|   grub2-common* grub-common* grub-efi-ia32-bin* memtest86+* grub-pc*
08| 0 aktualisiert, 0 neu installiert, 10 zu entfernen.
09| Nach dieser Operation werden 0 B Plattenplatz zusätzlich benutzt.
10| Möchten Sie fortfahren? [J/n] j
11| (Lese Datenbank ... 249262 Dateien und Verzeichnisse sind derzeit installiert.)
12| Löschen der Konfigurationsdateien von grub-btrfs (4.11-0~1siduction3) ...
13| /var/lib/dpkg/info/grub-btrfs.postrm: 23: update-grub: not found
14| dpkg: Fehler beim Bearbeiten des Paketes grub-btrfs (--purge):
15|  »installiertes post-removal-Skript des Paketes grub-btrfs«-Unterprozess gab den Fehlerwert 127 zurück
16| Fehler traten auf beim Bearbeiten von:
17|  grub-btrfs
~~~

Das Paket *grub-btrfs* wirft dabei einen Fehler aus. In Zeile 13 lesen wir, dass das post-removal-Skript den Befehl aus Zeile 23 (update-grub) nicht mehr findet, was natürlich richtig ist, denn *grub-pc-bin* wurde bereits entfernt.  
Folglich kommentieren wir die Zeile aus und bemühen apt noch einmal.

~~~
# sed -i '23s!\(.*\)!#\1!' /var/lib/dpkg/info/grub-btrfs.postrm
# apt purge grub-btrfs
~~~

Nach dieser Aktion sind die von uns erstellten Sicherungskopien und zwei Verzeichnisse von GRUB übrig. Es handelt sich um  
das Verzeichnis `/grub/`,  
die Sicherungsdatei `/etc/fstab_*`,  
das Verzeichnis `/usr/share/grub/`  
und das Verzeichnis `/etc/default/grub.d/`.

Mit

~~~
# rm -r /grub/
# rm /etc/fstab_*
# rm -r /usr/share/grub/
# rm -r /etc/default/grub.d/
~~~

entledigen wir uns der Überbleibsel.

**UEFI bereinigen**  

In der Firmware existiert noch der siduction Booteintrag aus der Installation mit GRUB. Wir lassen uns im Terminal mit ROOT-Rechten den Inhalt anzeigen. (Gekürzt dargestellt.)

~~~
# efibootmgr
 BootCurrent: 0001
 Timeout: 0 seconds
 BootOrder: 0001,0000,0002,2001,2002
 Boot0000* siduction
 Boot0001* Linux Boot Manager
 Boot0002* EFI Hard Drive
 Boot2001* EFI USB Device
 Boot2002  EFI Network RC
~~~

Der erste Befehl entfernt den Eintrag von GRUB.  
Der zweite Befehl löscht anschließenden das zugehörige Verzeichnis aus `/efi/`.

~~~
# efibootmgr -b 0000 -B
# rm -r /efi/EFI/siduction/
~~~

### systemd-boot und Btrfs

Das Dateisystem Btrfs bietet, besonders in Zusammenarbeit mit snapper, die Möglichkeit ein defektes System auf einen vorherigen Stand zurückzusetzen. In diesem Zusammenhang ist die von sd-boot verlangte Auslagerung des Verzeichnisses `/boot` in eine separate Partition hinderlich. Das Verzeichnis `/boot` ist ein wesentlicher Bestandteil des Betriebssystems und man sollte es im Zusammenhang mit Btrfs nicht in eine Partition oder ein Subvolumen auslagern. Denn dort wird es von Snapshots des Wurzeldateisystems nicht erfasst.  
siduction ist mit dem Paket *siduction-btrfs* in der Lage bei einem *Rollback* für alle im Rollbackziel enthaltenen Kernel Menüeinträge zu erstellen. Menüeinträge für andere Snapshot stehen nicht zur Verfügung. Somit kann der Benutzer selbst entscheiden, ob er sd-boot bei einer Installation des Systems auf Btrfs verwenden möchte.

### Weitere Informationen

`man systemd-boot`  
[boot_loader_specification (en)](https://uapi-group.org/specifications/specs/boot_loader_specification/)  
[Dateisystem Treiber von akeo.ie](https://efi.akeo.ie)

<div id="rev">Zuletzt bearbeitet: 2024-09-21</div>
