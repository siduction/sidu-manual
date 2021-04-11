% siduction Release Notes

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC3**

Änderungen 2021-02:

+ Übersetzung aus [siduction News](https://news.siduction.org/)

ENDE   INFOBEREICH FÜR DIE AUTOREN

##  siduction 2021.1.1 »C-Blues« Point Release

Um den Fehler zu umgehen, dass der Calamares-Installer im EFI-Mode keine GPT Partitionen erstellen kann, haben wir siduction 2021.1.1 veröffentlicht.  
Für die fachlich interessierten Nutzer unter uns möchte ich den Hintergrund [dieses Bug](https://github.com/calamares/calamares/issues/1637) etwas erläutern. Die neue Version 4.2 der [dosfstools](https://github.com/dosfstools/dosfstools) verhindert, dass das von Calamares genutzte und im Kern des KDE-Partition-Managers agierende [kpmcore](https://github.com/KDE/kpmcore), GPT Partitionen erstellt. 

### Dosfstools ist die Ursache

Leere Labels sind in Dosfstools nicht mehr erlaubt, gleichzeitig wurde die Art, Labels zurückzusetzen geändert. In dem Spezialfall, eine fat32 EFI System Partition zu erstellen, ist noch kein Label vorhanden das zurückgesetzt werden kann, weil die Partition zu diesem Zeitpunkt noch nicht existiert. Aus diesem Grund scheitert die Installation. Wird Calamares eine bereits zuvor erstellte Partition zugewiesen, funktioniert alles wie erwartet.

### Die Abhilfe: Downgrade

Bis zur Bereitstellung einer fehlerbereinigten Version von dosfstools in den Repositorien wird wohl noch einige Zeit vergehen, deshalb haben wir uns dazu entschlossen, dosfstools auf die Version 4.1.2 zu downgraden. Das Paket trägt jetzt die Bezeichnung *dosfstools 4.2-1.1~really4.1-2* .  
Das Release wird nur bei einer Neuinstallation mit Calamares benötigt. Deshalb erhielt noX auch kein Update, denn es hat nur den CLI-Installer und kein Calamares. Benutzer, die siduction bereits installiert haben, betrifft dieses Release nicht.

---

##  Release Notes für siduction 2021.1.0 »C-Blues«

Das siduction Team ist stolz darauf, euch siduction 2021.1.0 zu präsentieren. Nach einer langen Pause von fast 3 Jahren freuen wir uns mit einem offiziellen Release wieder zurück zu sein. Wir nennen es »C-Blues«, und man kann leicht erraten wofür das »C« in dieser turbulenten Zeit steht. 

### Was gibt´s Neues?

Wir bieten mit siduction 2021.1.0 die Desktop-Varianten  
KDE Plasma 5.20.5,  
LXQt 0.16.0-1,  
Cinnamon 4.8.6,  
Xfce 4.16,  
Lxde 10+nmu1,  
Xorg und noX,  
GNOME und MATE zur Zeit leider nicht. Sie kommen eventuell später. Selbsverständlich sind sie aus den Repositorien installierbar.

Die Abbilder des Release sind ein Snapshot  von Debian unstable (auch als Sid bekannt) vom 14.02.2021, die wir um einige nützliche Pakete und Scripte, den auf Calamares basierenden Installer und einen speziell angepassten Linux Kernel 5.10.15 erweiterten. Systemd steht bei Version 247.3 

### Plasma

Plasma, das im vergangenen Jahr eine erstaunliche Entwicklung durchgemacht hat, ist immer noch unser Haupt-Desktop. Wir haben es mit einigen der aktuellen Neuerungen ausgestattet, die in das kommende Plasma 5.21 einfließen werden. Zum Beispiel der neue *system monitor* als Nachfolger von *ksysguard*, der Konferenz-Kalender *Kongress* und schließlich, nach Jahren der Entwicklung, *kio-fuse*.  
Letzteres ermöglicht Remote-Verzeichnisse in die Root-Hierarchie des lokalen Dateisystems einzuhängen, was die Einsatzmöglichkeiten von KDE abdeckt um Zugriffe auf Ressourcen wie SSH, SAMBA/Windows, FTP, TAR/GZip/BZip2, WebDav und andere zu POSIX kompatieble Anwendungen wie Firefox, OpenOffice, GNOME, Shell Werkzeuge zu erhalten. Ein sehr nützliches Werkzeug.

### iNet WiFi Daemon

Die Varianten Xorg und noX kommen mit einem neuen Programm um sich mit WiFi-Hardware zu verbinden. Intels  [iNet wireless daemon](https://wiki.debian.org/NetworkManager/iwd) (iwd) schickt den WPA-Supplicant in den wohlverdienten Ruhestand. Nur ein Zehntel so groß und viel schneller; ist iwd der Nachfolger. Weiterführende Informationen bietet das [Arch Linux wiki](https://wiki.archlinux.org/index.php/Iwd).

Wer in Xorg und noX weiterhin *wpa_supplicant* anstatt *iwd* nutzen möchte, befolgt die folgende Anleitung:

+ Den iwd.service stoppen und maskieren.
+ Den NetworkManager.service stoppen.
+ Die Datei /etc/NetworkManger/conf.d/nm.conf umbenennen.
+ Demaskieren und starten des wpa_supplicant.service.
+ Den NetworkManager.service wieder starten.

~~~
# systemctl stop iwd.service
# systemctl mask iwd.service
# sudo systemctl stop NetworkManager.service
# sudo mv /etc/NetworkManager/conf.d/nm.conf /etc/NetworkManager/conf.d/nm.conf~
# systemctl unmask wpa_supplicant.service
# systemctl enable –now wpa_supplicant.service
# systemctl start NetworkManager.service
~~~

Jetzt wird wpa_supplicant für die Verbindung mit der WiFi-Hardware benutzt.

### iwd installieren

Wer möchte, kann iwd auch in den anderen Varianten nutzen, entweder eigenständig, oder in Verbindung mit dem NetworkManager. 

Einfach die folgenden Befehle als root im Terminal ausführen, um iwd zu nutzen:

~~~
# apt update
# apt install iwd
# systemctl stop wpa_supplicant.service
# systemctl mask wpa_supplicant.service
# systemctl stop NetworkManager.service
# touch /etc/NetworkManager/conf.d/nm.conf
# echo -e '[device]\nwifi.backend=iwd' > /etc/NetworkManager/conf.d/nm.conf
# touch /etc/iwd/main.conf
# echo -e '[General]\nEnableNetworkConfiguration=true\n\n[Network]\nNameResolvingService=systemd' > /etc/iwd/main.conf
# systemctl enable -now iwd.service
# systemctl start NetworkManager.service
~~~

Jetzt ist man in der Lage im Terminal mit dem Befehl **`iwctl`** eine interaktive Shell zu starten. Die Eingabe von "help" gibt alle Optionen aus um WiFi Hardware anzuzeigen, zu konfigurieren und sich mit einem Netzwerk zu verbinden. Auch kann man **`nmtui`** oder **`nmcli`** im Terminal bzw. den NetworkManager in der graphischen Oberfläche benutzen.

### Warum gab es seit 2018 kein Release?

Als die Pandemie uns erreichte, waren wir in der frühen Entwicklungsphase für ein neues Release. Die Änderungen an der Infrastruktur waren größten Teils erledigt. Kurz danach, im April 2020, verschwand Alf (agaida), unser Hauptentwickler, von der Erdoberfläche und wurde seither nicht gesehen. Wir haben keine Ahnung was passiert sein könnte, denn alle Anfragen und Kontaktversuche zu ihm blieben unbeantwortet. Hallo Alf, wenn du dies liest, komm vorbei und sag was. Wir vermissen dich.

Nachdem sich agaida für fast ein Jahr in Luft aufgelöst hatte, dachten wir, es sei an der Zeit, eine neue Version ohne ihn zu machen, aber basierend auf seiner früheren Arbeit, bevor er verschwand. Also haben wir unseren eigenen Corona-Blues abgeschüttelt und - tada - hier ist es, brandneu und noch warm vom   
Server

### Offizielle Releases und Isobuilds

Zwischen den offiziellen Releases erstellten wir von Zeit zu Zeit neue Abbilkder, um die Nachfrage nach aktueller Software für neue Installationen zu befriedigen. Diese Abbilder auf *isobuilds* sind inoffiziell, wurden und werden aber weiterhin erstellt. Sie werden von uns gebooted und installiert, weitere Tests erfahren diese Abbilder nicht. So weit keine Probleme auftreten, ist es uns möglich etwa monatlich aktuelle Releases von GNOME und MATE neben den anderen zu präsentieren.

### Non-free und contrib Pakete

Die folgenden *non-free* und *contrib* Pakete werden automatisch installiert:

#### Non-Free

+ amd64-microcode - Processor microcode firmware for AMD CPUs  
+ firmware-amd-graphics - Binary firmware for AMD/ATI graphics chips  
+ firmware-atheros - Binary firmware for Atheros wireless cards  
+ firmware-bnx2 - Binary firmware for Broadcom NetXtremeII  
+ firmware-bnx2x - Binary firmware for Broadcom NetXtreme II 10Gb  
+ firmware-brcm80211 - Binary firmware for Broadcom 802.11 wireless card  
+ firmware-crystalhd - Crystal HD Video Decoder (firmware)  
+ firmware-intelwimax - Binary firmware for Intel WiMAX Connection  
+ firmware-iwlwifi - Binary firmware for Intel Wireless cards  
+ firmware-libertas - Binary firmware for Marvell Libertas 8xxx wireless car  
+ firmware-linux-nonfree - Binary firmware for various drivers in the Linux kernel  
+ firmware-misc-nonfree - Binary firmware for various drivers in the Linux kernel  
+ firmware-myricom - Binary firmware for Myri-10G Ethernet adapters  
+ firmware-netxen - Binary firmware for QLogic Intelligent Ethernet (3000)  
+ firmware-qlogic - Binary firmware for QLogic HBAs  
+ firmware-realtek - Binary firmware for Realtek wired/wifi/BT adapters  
+ firmware-ti-connectivity - Binary firmware for TI Connectivity wireless network  
+ firmware-zd1211 - binary firmware for the zd1211rw wireless driver  
+ intel-microcode - Processor microcode firmware for Intel CPUs  

#### Contrib

+ b43-fwcutter - utility for extracting Broadcom 43xx firmware  
+ firmware-b43-installer - firmware installer for the b43 driver  
+ firmware-b43legacy-installer - firmware installer for the b43legacy driver  
+ iucode-tool - Intel processor microcode  

### Non-Free-Software entfernen

Zur Zeit bietet der Installer keine Möglichkeit Pakete, die nicht mit den Anforderungen der DFSG (Debian Free Software Guidelines) übereinstimmen, von der Installation auszuschließen. Das bedeutet, dass non-free Pakete wie unfreie Firmware, standardmäßig mit installiert werden. Der Befehl **`vrms`** gibt eine Liste mit diesen Paketen aus. So kann man unerwünschte Pakete manuell entfernen. Alternativ benutzt man den Befehl **`apt purge $(vrms -s)`** oder unser Script **`remove-nonfree`** nach der Installation.

### Installationshinweise und bekannte Probleme

+ Möchte man eine bereits existierende /home- (oder andere Daten-) Partition weiter nutzen, sollte man dies nach der Installation und nicht mit dem Calamares Installer tun. Hinweise hierzu bitte in der Handbuchseite [Das Verzeichnis /home verschieben](https://manual.siduction.org/home-move_de.htm) nachlesen.
+ Verschlüsselungs-Setup mit LUKS oder ähnlichem unterstützt Calamares zur Zeit nicht. Das Verschlüsselungs-Setup sollte besser im Voraus erstellt und der **`cli-installer`** im Terminal benutzt werden.
+ Mit einigen Intel GPUs bei einigen Geräten kann das System kurz nach dem Boot einfrieren. Um dieses Verhalten zu umgehen, ist es nötig, im Bootmenü an die Kernelzeile den Parameter **`intel_iommu=igfx_off`** anzuhängen.

## Credits für siduction 2021.1.0

### Das Core Team

Alf Gaida (agaida)  
Axel Beu (ab)  
Torsten Wohlfarth (towo)  
Hendrik Lehmbruch (hendrikL)  
Ferdinand Thommes (devil)

### Code, Ideen and Unterstützung:

der_bud  
Markus Meyer (coruja)  
Axel Konrad (akli) für seine Arbeit bei der Erneuerung des Handbuches

### Danke!

Wir möchten allen, die zu siduction beigetragen haben und weiter beitragen, danken. Es ist eure Leistung und euer Verdienst. Natürlich gilt unser Dank ebenfalls der großartigen Debian Gemeinschaft, der Basis von siduction.

Und nun viel Spaß!

Im Namen des siduction Team:

**Ferdinand Thommes**

---

<div id="rev">Zuletzt bearbeitet: 2021-02-25</div>
