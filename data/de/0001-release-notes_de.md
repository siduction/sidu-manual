% Release Notes

## Release Notes 2026.1.0 Big Crime

Das siduction-Team freut sich, euch endlich wieder ein neues Release vorzustellen. Seit dem letzten Release ist mehr Zeit vergangen als geplant.

Eigentlich sollte Big Crime traditionsgemäß zwischen den Jahren erscheinen. Fehlende Zeit bei den Beteiligten führten dazu, dass die Veröffentlichung erst jetzt erscheint. Das neue Abbild steht [zum Download]() bereit.

### Was erwartet euch bei siduction 2026.1.0?

Zunächst ein paar Worte zum neuen Artwork von siduction 2026.1.0 mit dem Titel »Big Crime«. Als Vorlage dient der gleichnamige Song von Neil Young, in dem er die Politik der derzeitigen US-Regierung scharf kritisiert. Das Wallpaper wurde mit Gemini-KI erzeugt.

### siduction Editionen

Die Flavors, die wir für siduction 2026.1.0 anbieten, sind KDE Plasma 6.7, LXQt 2.3.0, Xfce 4.20, Xorg und NOX. GNOME, MATE und Cinnamon haben es wieder nicht geschafft, da es keinen Betreuer innerhalb von siduction dafür gibt. Bei Interesse meldet euch bitte. Vielleicht kommen sie eines Tages zurück. Natürlich sind sie weiterhin aus dem Repository installierbar.  
Die veröffentlichten Images von siduction 2026.1.0 sind ein Schnappschuss von Debian Unstable, das auch den Namen Sid trägt, vom xx.07.2026. Sie sind mit einigen nützlichen Paketen und Skripten, einem auf Calamares basierenden Installer, dem überarbeiteten cli-installer und einer angepassten Version des Linux-Kernels 7.x.x angereichert, während systemd bei v261~rc3-1 steht.

+ **KDE Plasma 6.7**  
  Wir haben mit der Veröffentlichung schlussendlich noch auf Plasma 6.7 gewartet. Diese neue Hauptversion bildet einen Einschnitt insofern, als es die letzte Hauptversion von KDE Plasma ist, die noch eine X11-Sitzung bietet. Mit Plasma 6.8, dessen Veröffentlichung Anfang 2027 erfolgen soll, ist Wayland der alleinige Standard.  
  Anwender, die dann noch Probleme mit einzelnen Anwendungen unter Wayland haben, können auf Xfce ausweichen, das bisher standardmäßig noch nicht auf Wayland setzt.  
  Auf GitHub wird derzeit ein Fork namens [SonicDE](https://github.com/Sonic-DE) entwickelt, der bereits jetzt in Unstable installierbar ist, den wir aber noch nicht getestet haben. Erfahrungen damit könnt ihr gerne im Forum kundtun.

+ **Xfce 4.20**  
  Xfce bleibt seinem langsamen Turnus treu und steht, wie beim letzten Release, immer noch bei [Xfce 4.20](https://linuxnews.de/xfce-4-20-wayland-unterstuetzung-und-noch-viel-mehr/). Es bietet noch experimentelle Bereitstellung von Wayland, die seit der Veröffentlichung weiter ausgebaut wurde. Überdies erhielt unter anderem der Dateimanager Thunar wesentliche Verbesserungen.

+ **LXQt 2.3.0**  
  LXQt ist der leichtgewichtige Bruder von KDE Plasma. Der seit zehn Jahren entwickelte Desktop bietet in [Version 2.3.0](https://linuxnews.de/lxqt-2-3-0-mit-mehr-wayland-unterstuetzung/) ebenfalls eine noch als experimentell eingestufte Wayland-Sitzung. Die Verbesserung der Wayland-Unterstützung wurde insbesondere im LXQt-Panel fortgesetzt, dessen Desktop-Umschalter nun für die Tiling-Compositoren labwc und niri aktiviert ist, und es gibt ein neues, auf IPC (Interprozesskommunikation) basierendes Backend für Wayfire.

+ **Xorg**  
  Text einfügen
  
+ **NOX**  
  Mit dem überarbeiteten cli-installer (siehe unten) ist die Installation in ein UEFI GPT System möglich. Zusätzlich kann der Benutzer zwischen den Bootmanagern *systemd-boot* und *GRUB* wählen.

### cli-installer

Für siduction 2026.1.0 wurde der cli-installer komplett modernisiert. Er ist in allen Flavours enthalten.  
Mit der Aufnahme von Calamares als graphisches Installationsprogramm verlor der zugrundeliegende fll-installer zunehmend an Bedeutung. Das führte dazu, dass der cli- und der fll-installer seit 2018 nahezu unverändert blieben. Da siduction auch weiterhin ein NOX Flavour bereitstellen möchte, bedurfte das Gespann cli- und fll-installer einer grundlegenden Überarbeitung mit der Integration aktueller Features.

Zum Verständnis: Während der *cli-installer* die Benutzeroberfläche für den Nutzer bietet, ist der *fll-installer* das eigentliche Werkzeug im Hintergrund, das die Daten auf die Festplatte schreibt. 

Das besondere Highlight ist der integrierte Bootmanager systemd-boot, der somit in allen Flavours zur Installation bereit steht. Wer über ein einfaches Hardware Setup verfügt ist mit systemd-boot gut beraten.  
Der überarbeitete cli-installer führt den Benutzer durch die Konfiguration, bietet sinnvolle Aktionen an, prüft Abhängigkeiten und Bedingungen und informiert über vorgenommene Einstellungen. Ein Abbruch des Programms ist zu jeder Zeit möglich.

**Die wichtigsten Änderungen:**  
+ Aktualisierung veralteter Befehle, Abfragen und Dialoge.  
+ Nonfree Sourcen als Opt-in.  
+ Vollständige Unterstützung von UEFI GPT.  
+ Unterstützung des Btrfs Dateisystems mit dem Anlegen der bei siduction üblichen Subvolumen.  
+ Auswahl der Bootmanager systemd-boot und GRUB.  
+ Einheitliches Aussehen der Benutzerschnittstelle für alle Dialoge.  
+ Programmteile der graphischen Oberfläche wurden entfernt.

### Btrfs-Dateisystem

Bei Verwendung des Btrfs-Dateisystems mit siduction ermöglichen wir es, eure Snapshots mit dem bei SUSE entwickelten Tool [Snapper](https://documentation.suse.com/de-de/sles/12-SP5/html/SLES-all/cha-snapper.html) zu verwalten, dem im [siduction Handbuch](https://manual.siduction.org/index_de.html) unter *Systemadministration → Btrfs und Snapper* ein eigenes Kapitel gewidmet ist. Neu hinzugekommen ist das Programm *Btrfs Assistant*, welches den Benutzern in den graphischen Oberflächen zur Verfügung steht und *snapper-gui* ersetzt.

**Auszug aus der info-md von siduction-btrfs:**

siduction-btrfs kann auf Systemen mit MBR- und GPT-Partitionstabellen verwendet werden, mit oder ohne separate /boot-Partition.

Seit der Version 0.3.0 verwendet siduction-btrfs das Snapper-Plugin-Verzeichnis.

*Bei Verwendung des Bootmanagers GRUB*  
Nach einem Rollback wird im Rollbackziel mittels chroot die Datei */boot/grub/grub.cfg* neu erstellt und anschließend aus dem Rollbackziel heraus GRUB neu installiert. Dadurch gelangt der User mit einem einfachen Reboot direkt in das Rollbackziel. Alle anderen Subvolumen, auch das zuvor verwendete, sind über das Untermenü *siduction snapshots* erreichbar.  
Wird bei Software Installation oder Upgrade die Datei */boot/grub/grub.cfg* aktualisiert, erweitert das Skript *grub-menu-title* die Menüzeile des Standardbooteintrages um das Flavor und das Subvolumen.

*Bei Verwendung des Bootmanagers systemd-boot*  
Nach einem Rollback erstellt das Skript *rollback-sd-boot* die Booteinträge. Dabei berücksichtigt es alle im neuen Snapshot enthaltenen Kernel. Der Standardbooteintrag wird auf das Standardsubvolumen gesetzt.  
Wird ein Subvolumen gelöscht für das Booteinträge bestanden, werden diese entfernt.

*Snapper Snapshot Beschreibung*  
Im Anschluss an eine APT Aktion ändert das Skript *snapshot-description* die von Snapper angezeigte Beschreibung (apt) zu einem aussagekräftigeren Text.

**Das Changelog der Änderungen:**

*siduction-btrfs (0.2.0) unstable; urgency=medium*  
+ Unterstützung für systemd-boot hinzugefügt.
+ Installationsabhängigkeiten zu grub-common und grub-btrfs entfernt.
    + Beides ermöglicht den vollständigen Wechsel von GRUB zu systemd-boot.
+ Verbesserte Beschreibung von Schnappschüssen im Snapper.

*siduction-btrfs (0.3.0-1) unstable; urgency=medium*  
+ Umgeschrieben mit dem Ziel, das Snapper-Plugin-Verzeichnis zu verwenden.
+ Unterstützung für eine Boot-Partition bei Verwendung von GRUB hinzugefügt.

### Non-free and Contrib

Die folgenden non-free und contrib Pakete sind standardmäßig installiert:

**Nonfree:**

+ amd64-microcode – Processor microcode firmware for AMD CPUs
+ firmware-amd-graphics – Binary firmware for AMD/ATI graphics chips
+ firmware-atheros – Binary firmware for Atheros wireless cards
+ firmware-bnx2 – Binary firmware for Broadcom NetXtremeII
+ firmware-bnx2x – Binary firmware for Broadcom NetXtreme II 10Gb
+ firmware-brcm80211 – Binary firmware for Broadcom 802.11 wireless card
+ firmware-crystalhd – Crystal HD Video Decoder (firmware)
+ firmware-intelwimax – Binary firmware for Intel WiMAX Connection
+ firmware-iwlwifi – Binary firmware for Intel Wireless cards
+ firmware-libertas – Binary firmware for Marvell Libertas 8xxx wireless car
+ firmware-linux-nonfree – Binary firmware for various drivers in the Linux kernel
+ firmware-misc-nonfree – Binary firmware for various drivers in the Linux kernel
+ firmware-myricom – Binary firmware for Myri-10G Ethernet adapters
+ firmware-netxen – Binary firmware for QLogic Intelligent Ethernet (3000)
+ firmware-qlogic – Binary firmware for QLogic HBAs
+ firmware-realtek – Binary firmware for Realtek wired/wifi/BT adapters
+ firmware-ti-connectivity – Binary firmware for TI Connectivity wireless network
+ firmware-zd1211 – binary firmware for the zd1211rw wireless driver
+ firmware-sof-signed - Intel audio firmware
+ intel-microcode – Processor microcode firmware for Intel CPUs

**Contrib:**

+ b43-fwcutter – utility for extracting Broadcom 43xx firmware
+ firmware-b43-installer – firmware installer for the b43 driver
+ firmware-b43legacy-installer – firmware installer for the b43legacy driver
+ iucode-tool – Intel processor microcode

**Non-Free Inhalte entfernen**

Momentan bietet der Installer keine Möglichkeit, Pakete abzuwählen, die nicht mit den DFSG, den Debian-Richtlinien für Freie Software, übereinstimmen. Das bedeutet, dass Pakete wie etwa unfreie Firmware standardmäßig auf dem System installiert werden. Der Befehl vrms wird diese Pakete für dich auflisten. Du kannst nicht erwünschte Pakete manuell deinstallieren oder sie alle entfernen, indem du vor oder nach der Installation `apt purge $(vrms -s)` eingibst. Andernfalls kann später unser Skript `remove-nonfree` dies für dich tun.

### Installationshinweise und bekannte Probleme

Wenn ihr eine bestehende Home-Partition (oder eine andere Datenpartition) wiederverwenden möchtet, solltet ihr dies nach der Installation und nicht im Calamares-Installer tun. Bei einigen Intel-Grafikprozessoren auf einigen Geräten kann es vorkommen, dass das System kurz nach dem Booten in Live eingefroren ist. Um dies zu beheben, müsst ihr den Kernel-Parameter `intel_iommu=igfx_off` setzen, bevor ihr erneut bootet.

<div id="rev">Zuletzt bearbeitet: 2026-07-08</div>
