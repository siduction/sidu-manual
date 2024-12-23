% Release Notes

## Release Notes 2024.1.0  Shine on ...


Das siduction-Team freut sich, euch ein neues Release vorzustellen. Seit dem letzten Release ist einige Zeit vergangen. Der Grund dafür ist, dass wir auf KDE Plasma 6 in Debian Unstable gewartet haben. Plasma 6 erschien zwar bereits Ende Februar 2024, die Freigabe in Unstable wurde aber durch die [t64-Transition in  Debian](https://wiki.debian.org/ReleaseGoals/64bit-time), an die ihr euch bestimmt noch erinnert, um rund vier Monate verzögert. Nun ist es aber so weit und seit rund zwei Wochen ist Plasma 6.2 in Unstable verfügbar.  
User und Passwort für die Live-Session lauten siducer/live

### Was erwartet euch bei siduction 2024.1.0

Zunächst ein paar Worte zum neuen Artwork von siduction 2024.1.0 mit dem Titel »Shine on…«. Das bekannte Album von Pink Floyd stand hier Pate. Und wenn ihr jetzt einen Ohrwurm habt… Gern geschehen :)  
Als Grundlage dient das Wallpaper [Nexus](https://invent.kde.org/plasma/breeze/-/commit/aec3e3d93eb79042c6dbf14c9c1f6fffd2c3a86d) von Krystian Zajdel. Wir haben es für siduction angepasst und huldigen damit den Entwicklern von KDE, die in diesem Jahr wieder enorm viel Arbeit in das Projekt gesteckt haben und es für uns weiterhin zur besten Desktop-Umgebung machen. Wenn ihr das auch so seht, denkt bitte über eine [Spende oder Förderung von KDE](https://kde.org/de/donate/) nach.

### siduction Editionen

Die Flavours, die wir für siduction 2024.1.0 anbieten, sind KDE Plasma 6.2.4.1, LXQt 2.1.0-1, Xfce 4.20, Xorg und noX. GNOME, MATE und Cinnamon haben es wieder nicht geschafft, da es keinen Betreuer innerhalb von siduction dafür gibt. Bei Interesse meldet euch bitte. Vielleicht kommen sie eines Tages zurück oder auch nicht. Natürlich sind sie weiterhin aus dem Repository installierbar.

Die veröffentlichten Images von siduction 2024.1.0 sind ein Schnappschuss von Debian Unstable, das auch den Namen Sid trägt, vom 23.12.2024. Sie sind mit einigen nützlichen Paketen und Skripten, einem auf Calamares basierenden Installer und einer angepassten Version des Linux-Kernels 6.12.6 angereichert, während systemd bei 257.1-3 steht.

**KDE Plasma 6**

Plasma 6 ist mittlerweile fast zu 100 % in Unstable und Testing angekommen und wird somit auch für Debian 13 »Trixie« verfügbar sein. Obwohl Wayland der Standard-Sitzungstyp bei Plasma 6 ist, haben wir uns für X11 als Standard entschieden, weil Calamares unter Wayland derzeit das gewünschte Tastaturlayout nicht übernimmt. Das könnte fatale Auswirkungen bei verschlüsselten Installationen haben. Natürlich könnt ihr im SDDM jederzeit zu Wayland wechseln. Als Bestandsanwender habt ihr ja vermutlich bereits auf Plasma 6 aktualisiert, jetzt steht die aktuelle Plasma-Generation auch für Neuinstallationen bereit.

Bekannte Fehler: Dolphin kann derzeit über smb:// keine Verbindung aufbauen. Als Alternative bietet sich übergangsweise sftp an. Der Fehler liegt in dem Paket kio-extras.

**Xfce 4.20**

Gerade noch so hat es das am 15. Dezember veröffentlichte [Xfce 4.20](https://linuxnews.de/xfce-4-20-wayland-unterstuetzung-und-noch-viel-mehr/) nach Unstable und somit in unser neues Release geschafft. Die neue Veröffentlichung von Xfce konzentriert sich unter anderem auf die initiale, noch experimentelle Bereitstellung von Wayland. Überdies erhielt unter anderem der Dateimanager Thunar wesentliche Verbesserungen.

Bekannte Fehler: Leider ist die Implementierung von Wayland derzeit so experimentell, dass die Sitzung erst gar nicht startet. Wir haben dementsprechend Wayland blockiert. Wenn dieser Fehler behoben wird, werden wir dies in einem Punkt-Release bald wieder freischalten.

**LXQt 2.1**

LXQt ist der leichtgewichtige Bruder von KDE Plasma. Der seit zehn Jahren entwickelte Desktop bietet in [Version 2.1.0](https://linuxnews.de/lxqt-2-1-0-unterstuetzt-sieben-wayland-compositoren/) eine nutzbare, aber ebenfalls noch als experimentell eingestufte Wayland-Sitzung.

### siduction-btrfs verbessert

Bei Verwendung des Btrfs Dateisystems mit siduction ermöglichen wir es, eure Snapshots mit dem bei SUSE entwickelten Tool [Snapper](https://documentation.suse.com/de-de/sles/12-SP5/html/SLES-all/cha-snapper.html) zu verwalten, dem im [siduction Handbuch](https://manual.siduction.org/index_de.html) unter *Systemadministration → Btrfs und Snapper* ein eigenes Kapitel gewidmet ist.

siduction-btrfs kann auf Systemen mit MBR- und GPT-Partitionstabellen verwendet werden, mit oder ohne separate /boot-Partition.  
Seit der Version 0.3.0 verwendet siduction-btrfs das Snapper-Plugin-Verzeichnis.

*Mit dem Bootmanager GRUB*  
Nach einem Rollback wird im Rollbackziel mittels chroot die Datei */boot/grub/grub.cfg* neu erstellt und anschließend wird aus dem Rollbackziel heraus GRUB neu installiert. Dadurch gelangt der User mit einem einfachen Reboot direkt in das Rollbackziel. Alle anderen Subvolumen, auch das zuvor verwendete, sind über das Untermenü *siduction snapshots* erreichbar.  
Wird bei Software Installation oder Upgrade die Datei */boot/grub/grub.cfg* aktualisiert, erweitert das Skript *grub-menu-title* die Menüzeile des Standardbooteintrages um das Flavor und das Subvolumen.

*Mit dem Bootmanager systemd-boot*  
Nach einem Rollback erstellt das Skript *rollback-sd-boot* die Booteinträge. Dabei berücksichtigt es alle im Rollbackziel enthaltenen Kernel. Der Standardbooteintrag wird auf das Standardsubvolumen gesetzt.  
Wird ein Subvolumen gelöscht, für das Booteinträge bestanden, werden diese entfernt.

*Snapper Snapshot Beschreibung*  
Im Anschluss an eine APT Aktion ändert das Skript *snapshot-description* die von Snapper angezeigte Beschreibung (apt) zu einem aussagekräftigeren Text.

**Das Changelog der Änderungen:**

- siduction-btrfs (0.2.0) unstable; urgency=medium
  - Unterstützung für systemd-boot hinzugefügt.
  - Installationsabhängikeiten zu grub-common und grub-btrfs entfernt.  
    Beides ermöglicht den vollständigen Wechsel von GRUB zu systemd-boot.
  - Verbesserte Beschreibung von Schnappschüssen im Snapper.

- siduction-btrfs (0.3.0-1) unstable; urgency=medium
  - Umgeschrieben mit dem Ziel, das Snapper-Plugin-Verzeichnis zu verwenden.
  - Unterstützung für eine Boot-Partition bei Verwendung von GRUB hinzugefügt.

### Non-free and Contrib

Die folgenden non-free und contrib Pakete sind standardmäßig installiert:

**Nonfree:**

- amd64-microcode – Processor microcode firmware for AMD CPUs
- firmware-amd-graphics – Binary firmware for AMD/ATI graphics chips
- firmware-atheros – Binary firmware for Atheros wireless cards
- firmware-bnx2 – Binary firmware for Broadcom NetXtremeII
- firmware-bnx2x – Binary firmware for Broadcom NetXtreme II 10Gb
- firmware-brcm80211 – Binary firmware for Broadcom 802.11 wireless card
- firmware-crystalhd – Crystal HD Video Decoder (firmware)
- firmware-intelwimax – Binary firmware for Intel WiMAX Connection
- firmware-iwlwifi – Binary firmware for Intel Wireless cards
- firmware-libertas – Binary firmware for Marvell Libertas 8xxx wireless car
- firmware-linux-nonfree – Binary firmware for various drivers in the Linux kernel
- firmware-misc-nonfree – Binary firmware for various drivers in the Linux kernel
- firmware-myricom – Binary firmware for Myri-10G Ethernet adapters
- firmware-netxen – Binary firmware for QLogic Intelligent Ethernet (3000)
- firmware-qlogic – Binary firmware for QLogic HBAs
- firmware-realtek – Binary firmware for Realtek wired/wifi/BT adapters
- firmware-ti-connectivity – Binary firmware for TI Connectivity wireless network
- firmware-zd1211 – binary firmware for the zd1211rw wireless driver
- intel-microcode – Processor microcode firmware for Intel CPUs

**Contrib:**

- b43-fwcutter – utility for extracting Broadcom 43xx firmware
- firmware-b43-installer – firmware installer for the b43 driver
- firmware-b43legacy-installer – firmware installer for the b43legacy driver
- iucode-tool – Intel processor microcode

**Non-Free Inhalte entfernen**

Momentan bietet der Installer keine Möglichkeit, Pakete abzuwählen, die nicht mit den DFSG, den Debian-Richtlinien für Freie Software, übereinstimmen. Das bedeutet, dass Pakete wie etwa unfreie Firmware standardmäßig auf dem System installiert werden. Der Befehl vrms wird diese Pakete für dich auflisten. Du kannst nicht erwünschte Pakete manuell deinstallieren oder sie alle entfernen, indem du vor oder nach der Installation apt purge $(vrms -s) eingibst. Andernfalls kann später unser Skript remove-nonfree dies für dich tun.

### Installationshinweise und bekannte Probleme

Wenn ihr eine bestehende Home-Partition (oder eine andere Datenpartition) wiederverwenden möchtet, solltet ihr dies nach der Installation und nicht im Calamares-Installer tun.  
Bei einigen Intel-Grafikprozessoren auf einigen Geräten kann es vorkommen, dass das System kurz nach dem Booten in Live eingefroren ist. Um dies zu beheben, müsst ihr den Kernel-Parameter intel_iommu=igfx_off setzen, bevor ihr erneut bootet.

<div id="rev">Zuletzt bearbeitet: 2024-12-23</div>
