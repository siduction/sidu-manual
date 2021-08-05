% Inhalt der Live-ISO

## Inhalt der Live-ISO

### Hinweis zur Software auf dem Live-ISO

siduction stellt auf der Live-ISO DFSG-freie Software zur Verfügung als auch nicht freie Firmware. Zur Deinstallation proprietärer Software benutzt man den Befehl **`apt purge $(vrms -s)`** oder unser Script **`remove-nonfree`** nach der Installation.

Das ISO basiert ausschließlich auf zum Veröffentlichungszeitpunkt jeweils aktuellem Debian Sid, bereichert und stabilisiert durch eigene Pakete und Skripte aus den siduction-Repositories. Als Kernel wird der jeweils aktuelle Vanilla Mainline Kernel verwendet und mit Patches versehen. ACPI und DMA sind aktiviert.

Eine komplette Manifest-Datei mit der Auflistung aller installierten Programme für jede einzelne Veröffentlichungs-Variante von siduction findet man auf jedem Download-Spiegelserver.

### Varianten der ISO

siduction bietet sieben aktuelle Images mit verschiedenen Desktop-Umgebungen (zwei auch ohne) in 64-Bit als Live-ISO zum Einstieg in Debian Sid. Üblicherweise dauert eine Installation zwischen 1 und 10 Minuten, je nach Hardware.  
Die Varianten sind:

1. **KDE 64 Bit** , live-ISO mit etwa 2,8 GByte:
    - Qt basierter Plasma Desktop und KDE-Frameworks. Mit einer repräsentativen Auswahl der KDE Applications.  
    - Die Installation zusätzlicher Anwendungen ist ohne Probleme via apt möglich.

2. **Cinnamon mit 64 Bit** , live-ISO mit etwa 2.3 GByte:
     - GTK-basierter Desktop mit einer repräsentativen Auswahl an nützlicher Software.  
     - Die Installation zusätzlicher Anwendungen ist ohne Probleme via apt möglich.

3.  **XFCE 64 Bit** , live-ISO mit etwa 2,3 GByte:
    - umfasst eine GTK basierte Desktop-Umgebung mit allen Features (keine Minimalversion!) und alle Anwendungen um sofort produktiv tätig sein zu können.  
    - Der Ressourcenaufwand ist geringer als mit KDE.  
    - Die Installation zusätzlicher Anwendungen ist ohne Probleme via apt möglich.

4.  **LXQt mit 64 Bit** ,  live-ISO mit etwa 2,2 GByte:
     - umfasst eine Desktopumgebung mit einer Auswahl an Qt-Applikationen.  
     - Der Fußabdruck ist etwas schmaler als bei XFCE
     - Die Installation zusätzlicher Anwendungen ist ohne Probleme via apt möglich.

5.  **LXde mit 64 Bit** ,  live-ISO mit etwa 2,2 GByte:
     - umfasst eine Desktopumgebung mit einer Auswahl an GTK-Applikationen.  
     - Der Fußabdruck ist schmaler als bei XFCE
     - geeignet für ältere Hardware
     - Die Installation zusätzlicher Anwendungen ist ohne Probleme via apt möglich.

6.  **Xorg mit 64 Bit** ,  live ISO mit etwa 1,8 GByte:
      - Ein ISO-Image mit einem Xorg-Stack und dem spartanischen Fenstermanager Fluxbox.  
      - Für Anwender, die sich ihr System nach eigenen Vorstellungen aufbauen wollen

7.  **NoX mit 64 Bit** ,  live-ISO mit etwa 800 MByte: 
      - Wie der Name andeutet: kein vorinstallierter Xorg-Stack

**32 Bit ISO's** bieten wir standardmäßig nicht mehr an.  
Wenn ein 32Bit IOS gewünscht ist, wird ein solches auf Anfrage im IRC gerne erstellt. Testen können wir ein solches ISO leider nicht.

### Minimale Systemanforderungen

für: KDE-Plasma, Mate, XFCE, LXQt, Lxde, Cinnamon, Xorg und NoX

#### Prozessoranforderungen: 64Bit CPU

    AMD64  
    Intel Core2  
    Intel Atom 330  
    jede x86-64/ EM64T fähige CPU oder neuer  
    neuere 64 bit fähige AMD Sempron and Intel Pentium 4 CPUs  
    (achten Sie auf das "lm"-Flag in /proc/cpuinfo oder nutzt inxi -v3).

#### Speicheranforderungen

    KDE-Plasma: ≥ 4 GByte RAM
    Mate:       ≥ 4 GByte RAM
    Cinnamon:   ≥ 4 GByte RAM
    XFCE:       ≥ 4 GByte RAM
    LXQT:       ≥ 512 MByte RAM
    Lxde        ≥ 512 MByte RAM
    Xorg:       ≥ 512 MByte RAM
    NoX:        ≥ 256 MByte RAM

    ≥ 5 GByte Festplattenspeicher für NOX
    ≥10 GByte Festplattenspeicher für alle Anderen

#### Sonstiges

    VGA Grafikkarte mit mindestens 640x480 Pixel Auflösung.
    optisches Laufwerk oder USB Medien.

### Anwendungen und Hilfsprogramme

Als Internetbrowser werden (je nach Variante) [Firefox](https://mozilla.org), oder [Chromium](https://chromium.woolyss.com/download/de/#linux) mitgeliefert.

Als Bürosoftware ist Libreoffice vorinstalliert. Als Dateimanager stehen unter anderem Dolphin,Thunar und PCManFM zur Verfügung.

Zur Netzwerk- und Internetkonfiguration steht Connman oder Network-Manager zur Verfügung.

Xorg und nox werden mit [IWD](0502-inet-iwd_de.md#iwd-statt-wpa_supplicant) als ausgeliefert, dieser kann via [nmtui/nmcli](0501-inet-nm-cli_de.md#network-manager-kommandline-tool) oder [iwctl](0502-inet-iwd_de.md#iwd-statt-wpa_supplicant) konfiguriert werden. 

Zur Partitionierung von Festplatten werden [cfdisk](./part-cfdisk_de.md#partitionieren-mit-fdisk), [gdisk und cgdisk](./part-gdisk_de.md#partitionieren-mit-gdisk) und [GParted](./part-gparted_de.md#partitionieren-mit-gparted) mitgeliefert. Gparted bietet auch die Möglichkeit, die Größe von NTFS-Partitionen zu ändern.

Tools zur Systemanalyse wie [Memtest86+](http://www.memtest.org/) (ein Tool zur umfassenden Speicheranalyse) werden ebenso mitgeliefert.

Jede ISO-Variante enthält eine umfangreiche Auswahl an Anwendungen für die Befehlszeile. Eine komplette Manifest-Datei mit den installierten Programmen für jede einzele Veroffentlichungs-Variante von siduction findet man auf jedem Download-Spiegelserver.

### Haftungsausschluss_Disclaimer

siduction ist experimentelle Software. Benutzung auf eigene Gefahr. Das siduction-Projekt, seine Entwickler und Team-Mitglieder können unter keinen Umständen wegen Beschädigung von Hardware oder Software, verlorener Daten oder anderer direkter oder indirekter Schäden des Nutzers durch Nutzung dieser Software zur Rechenschaft gezogen werden. Wer diesen Bedingungen nicht zustimmt, darf diese Software weder verwenden noch verteilen.

<div id="rev">Zuletzt bearbeitet: 2021-04-12</div>
