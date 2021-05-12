% menu

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC1**

Änderungen 2021-02

+ Inhalte teilweise aktualisiert und neu gruppiert.
+ Für die Verwendung mit pandoc optimiert.

ENDE   INFOBEREICH FÜR DIE AUTOREN

---

  <!--siduction Operating System Manual menu-version-02.13.2011.09.09 -->
  <!-- menu last updated by 13/01/2011 1300 UTC-->

 [![siduction.org logo](../logos/manual-siduction-logo.png "Zu manual.siduction.org (Online Manual)")](http://manual.siduction.org/) 
 [![Suche](../logos/manual-search-22x22.png "Handbuch Suche") Suche online - offline](manual-search_de.htm#search-on)

 [![lang-switch](../logos/siduction-lang-100x64.png "Wähle eine andere Sprache - Choose another language DE, EN")](../flag-index.html) 
 
+ [siduction-Handbuch](./welcome_de.htm)
   + [Benutzungshinweise](./welcome_de.htm#benutzungshinweise)
   + [Copyright](./welcome_de.htm#copyright-rechts--und-lizenzhinweise)
   + [Inhalt](./menu_de.htm)
   + [Wo es Hilfe gibt](./help_de.htm)
      +  [IRC und siduction-paste](./help_de.htm#irc---interaktiver-livesupport)
   + [siduction Schnellstart](./wel-quickstart_de.htm#welcome-quick)
   + [Das siduction-Team](./credit_de.htm)

+ [ISO's](./cd-dl-burning_de.htm)
   + [Inhalt und Systemanforderungen](./cd-content_de.htm)
   + [Release Notes](./sys-admin-release_de.htm#rolling)
   + [siduction Download](./cd-dl-burning_de.htm#die-siduction-iso-herunterladen)
   + [Checksumme prüfen](./cd-dl-burning_de.htm#md5sum-und-integrit%C3%A4tspr%C3%BCfung-von-heruntergeladenen-dateien)
   + [Brennen mit Windows](./cd-dl-burning_de.htm#eine-live-dvd-mit-windows-brennen)
   + [Brennen mit Linux](./cd-dl-burning_de.htm#die-dvd-mit-linux-brennen)

+ [Live-Modus](live-mode_de.htm)
   + [Eingerichtete User](./live-mode_de.htm#eingerichtete-user-der-live-dvd)
   + [Root-Passwort im Live-Modus](./live-mode_de.htm#mit-root-rechten-auf-der-live-dvd-arbeiten)
   + [Software-Installation im Live-Modus](./live-mode_de.htm#die-installation-von-software-w%C3%A4hrend-einer-live-dvd-sitzung)

+ [Terminal/Konsole](term-konsole_de.htm)
   + [Terminal/Konsole &#8658;](term-konsole_de.htm#term-kon)
      + [Terminal/Konsole](term-konsole_de.htm#term-kon)
      + [Farbige Prompts im Terminal](term-konsole_de.htm#colours)
      + [Hilfe auf der Befehlszeile](term-konsole_de.htm#cli-help)
      + [Tools für den Textmodus (tty) - init 3](help_de.htm#init3-tools)
      + [Linux-Befehlsliste am Terminal](term-konsole_de.htm#term-cmds)

   + [suxterm/sudo](term-konsole_de.htm#suxterm)

+ [Bootoptionen (Bootcodes)](cheatcodes_de.htm)
   + [Bootoptionen für die siduction-Live-ISO](cheatcodes_de.htm#cheatcodes)
   + [Bootoptionen für Linux](cheatcodes_de.htm#cheatcodes-linux)
   + [VGA-Codes](cheatcodes-vga_de.htm#vga)

+ [Partitionierung der Festplatte - traditionell, GPT und LVM](part-gparted_de.htm)
   + [Schreiben auf NTFS Partitionen mit ntfs-3g](part-gparted_de.htm#hd-ntfs3g)
   + [Partitionierung mit LVM - Logical Volume Manager](part-lvm_de.htm#part-lvm)
   + [Partitionieren mit GUI-Programmen &#8658;](part-gparted_de.htm#partition)
      + [Partitionieren mit GParted/KDE Partition Manager](part-gparted_de.htm#partition)
      + [Größenänderung von NTFS-Partitionen mit GParted/KDE Partition Manager](part-gparted_de.htm#ntfs)
   + [Partitionieren im Terminal &#8658;](part-cfdisk_de.htm#partition)
      + [Partitionieren mit cfdisk](part-cfdisk_de.htm#partition)
      + [Formatieren](part-cfdisk_de.htm#formating)
      + [Formatieren nach einer Partitionierung mit gdisk](part-gdisk_de.htm#gdisk-6)
      + [GPT Partitionieren mit gdisk](part-gdisk_de.htm#gdisk-1)
   + [Grundlagen für die Partitionierung &#8658;](part-size-examp_de.htm#part-example)
      + [Partitionierungsbeispiele](part-size-examp_de.htm#part-example)
      + [UUID, Anpassung der fstab und Erstellung neuer Einhängepunkte](part-uuid_de.htm#uuid)
      + [Kurzanleitung zur Benennung von Partitionen](part-cfdisk_de.htm#disknames)

+ [Installationsoptionen - HD, USB, VM und Cryptroot](hd-install_de.htm)
   + [Vorbereitung einer Installation &#8658;](hd-install_de.htm#Inst-prep)
      + [Installationsvorbereitung](hd-install_de.htm#Inst-prep)
      + [Installation auf einer Festplatte](hd-install_de.htm#Installation)
      + [Der erste Start des Systems](hd-install_de.htm#first-hd-boot)
   + [fromiso &#8658;](hd-install-opts_de.htm#fromiso)
      + [fromiso - Überblick](hd-install-opts_de.htm#fromiso)
      + [fromiso mit Grub 2](hd-install-opts_de.htm#grub2-fromiso)
      + [fromiso und persist](hd-install-opts_de.htm#fromiso-persist)
   + [Installation auf USB-Geräte &#8658;](hd-install-opts_de.htm#usb-hd)
      + [Installation auf eine USB-Festplatte (Besonderheiten von siduction, siduction-on-stick)](hd-install-opts_de.htm#usb-hd)
      + [Installation auf USB-Stick/SSD von einem anderen System (Linux. MS Windows, Mac OS X)](hd-ins-opts-oos_de.htm#raw-usb)
   + [Installation auf verschlüsselte Partitionen - cryptroot](hd-install-crypt_de.htm#install-crypt)
   + [Booten über ein Netzwerk](nbdboot_de.htm#nbd1)
   + [Installation auf virtuellen Maschinen](hd-install-vmopts_de.htm#vmopts)

+ [Grafikkarten, Monitore, Xorg &amp; Treiber](gpu_de.htm)
   + [Bildschirmauflösung und Monitore &#8658;](hw-dev-mon_de.htm#mon-res)
      + [Bildschirmauflösung und Monitore](hw-dev-mon_de.htm#mon-res)
      + [Dual-Monitore und xrandr](hw-dev-mon_de.htm#xrandr)
      + [Dual-Monitore (mit proprietären Treibern)](hw-dev-mon_de.htm#mon-binary)
   + [Grafiktreiber &#8658;](gpu_de.htm#foss-xorg)
      + [AMD/ATI 3D-Treiber](gpu_de.htm#ati-3d)
      + [Intel 2D- und 3D-Treiber](gpu_de.htm#intel)
      + [Nvidia 3D-Treiber](gpu_de.htm#nvidia)
      + [Open Source Xorg-Treiber](gpu_de.htm#foss-xorg)
   + [Ermittlung von nicht freier Firmware](nf-firm_de.htm#fw-detect)
   + [non-free der Sources List anfügen](nf-firm_de.htm#non-free-firmware)

+ [Sitzungsmanager](wm-dm_de.htm)
   + [KDE, XFCE und weitere Sitzungsmanager &#8658;](wm-dm_de.htm)
      + [Xfce-Extras](wm-dm_de.htm#xfce-notes)
      + [Zusätzliche KDE-Programme](wm-dm_de.htm#install-add)
      + [Kein Login in KDE](wm-dm_de.htm#kde-login)
      + [Grafik-Themen ändern](wm-dm_de.htm#ch-th)
      + [Wenn der Desktop einfriert](wm-dm_de.htm#desk-freeze)
   + [Installation weiterer Sitzungsmanager](wm-dm_de.htm#dm)

+ [Internetverbindung: WiFi, LAN, sonstige Netzwerke](inet-ceni_de.htm)
   + [Kabelverbindungen &#8658;](inet-ceni_de.htm#netcardconfig)
      + [56k-Modems](inet-ceni_de.htm#dial-mod)
      + [Ceni (Erstellung einer Internetverbindung](inet-ceni_de.htm#netcardconfig)
   + [WIFI-Verbindungen &#8658;](inet-ceni_de.htm#netcardconfig)
      + [Ceni (Erstellung einer Internetverbindung)](inet-ceni_de.htm#netcardconfig)
      + [WiFi: WPA_GUI](inet-wpagui_de.htm#wpa-roaming-gui)
      + [WiFi: Roaming-Konfiguration](inet-setup_de.htm#net-set1)
      + [WiFi und wpasupplicant](inet-wpa_de.htm#wpa)
      + [Wechsel zwischen WiFi und Kabel](inet-ifplug_de.htm#hotswitch)
      + [Network Manager in der Shell](inet-nm-cli_de.htm)
   + [SSL](lamp-apache_de.htm#serv-ssl)
   + [SSH &#8658;](ssh_de.htm#ssh-x)
      + [SSH (Ferneinbindung)](ssh_de.htm#ssh-fs)
      + [SSH mit grafischen Programmen](ssh_de.htm#ssh-x)
      + [SSH via Konqueror](ssh_de.htm#ssh-f)
      + [SSH: Weiterleitung von grafischen Programmen von Windows](ssh_de.htm#ssh-w)
      + [SSH und Sicherheit](ssh_de.htm#ssh)
   + [Firewalls und Datenschutz &#8658;](tor-privoxy_de.htm#tor)
      + [Tor](tor-privoxy_de.htm#tor)
      + [Privoxy](tor-privoxy_de.htm#privoxy)
      + [Firewalls](inet-ceni_de.htm#firewalls)

+ [Server]()
   + [LAMP Webserver für Entwickler &#8658;](lamp-start_de.htm)
      + [LAMP - Apache2](lamp-apache_de.htm)
      + [LAMP - Mariadb (mysql)](lamp-sql_de.htm)
      + [LAMP - PHP](lamp-php_de.htm)
   + [Samba-Server &#8658;](samba_de.htm#setup)
      + [Konfiguration von SAMBA (Windows)](samba_de.htm#configure)
   + [Zeitserver](ntp-server_de.htm#ntp-server)

+ [APT der Paketmanager](sys-admin-apt_de.htm)
   + [APT-Paketquellen](sys-admin-apt_de.htm#liste-der-quellen-sources.list)
   + [Pakete installieren / verwalten](sys-admin-apt_de.htm#pakete-verwalten)
   + [Programmpaket suchen](sys-admin-apt_de.htm#programmpakete-suchen)

+ [Systemaktualisierung]()
   + [Kernelaktualisierung &#8658;](sys-admin-kern-upg_de.htm)
      + [Entfernen eines Kernels](sys-admin-kern-upg_de.htm#kern-remove)
      + [Aktualisierung eines](sys-admin-kern-upg_de.htm#kern-upgrade)
      + [Automatische Installation von Kernelmodulen mit dmakms](sys-admin-kern-upg_de.htm#dmakms)
   + [Aktualisierung eines installierten Systems &#8658;](sys-admin-apt_de.htm#aktualisierung-des-systems)
      + [Aktualisierung nur mit APT!!!](sys-admin-apt_de.htm#gründe-warum-man-nur-apt-für-eine-systemaktualisierung-verwenden-soll)
      + [Aktualisierung mehrerer PCs via LAN](sys-admin-apt-locarmirr_de.htm)

+ [Systemadministration](sys-admin-gen_de.htm)
   + [Aktualisierung des BIOS mittels FreeDOS](bios-freedos_de.htm#bois-prep)
   + [Virus- und Rootkit-Scanner](vir-rkits_de.htm#virus-rkits)
   + [Einen neuen Benutzer hinzufügen](hd-install_de.htm#benutzer-hinzufügen)
   + [Vergessene Root-Passwörter - Erstellung neuer Passwörter](sys-admin-gen_de.htm#passwortverwaltung)
   + [Systemd der System- und Dienste-Manager &#8658;](systemd-start_de.htm)
      + [Dienste aktivieren/deaktivieren](systemd-start_de.htm#handhabung-von-diensten-mittels-systemd)
      + [Stoppen eines Prozesses (pkill)](sys-admin-gen_de.htm#beenden-eines-prozesses)
      + [Systemd - target (Runlevel)](systemd-target_de.htm)
      + [Systemd - path](systemd-path_de.htm)
      + [Systemd - timer](systemd-timer_de.htm)
   + [Sicherung eines Systems &#8658;](sys-admin-rsync_de.htm#rsync)
      + [Sicherung mit rdiff](sys-admin-rdiff_de.htm#rdiff)
      + [Sicherung mit rsync](sys-admin-rsync_de.htm#rsync)
      + [Verschieben von /home](home-move_de.htm)
   + [CUPS, Schriften und Audio &#8658;](sys-admin-gen_de.htm#fonts)
      + [Schriften](sys-admin-gen_de.htm#schriften-in-siduction)
      + [CUPS - Drucken mit siduction](sys-admin-gen_de.htm#cups---das-drucksystem)
      + [Audio-Mischpulte](sys-admin-gen_de.htm#sound-in-siduction)
   + [Grub2 &#8658;](sys-admin-grub2_de.htm#grub2)
      + [Grub2 - Wiederherstellung von Grub durch chroot](sys-admin-grub2_de.htm#chroot)
      + [Grub2 - Falls der MBR-Bootsektor überschrieben wurde](sys-admin-grub2_de.htm#mbr-over-grub2)
      + [Grub2 - Dual- und Multibooting](sys-admin-grub2_de.htm#multi-os)
      + [Grub2 - Aktualisierung von Grub1](sys-admin-grub2_de.htm#grub1-grub2)
      + [Grub2 - Überblick](sys-admin-grub2_de.htm#grub2)

[![Donate](../logos/siduction_donate_75.png "Donate")](http://siduction.org/index.php?module=Content&amp;func=view&amp;pid=3) 

---

<div id="rev">Seite zuletzt aktualisert 2021-02-23</div>
 
