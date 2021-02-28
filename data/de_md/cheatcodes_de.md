% Bootoptionen (Cheatcodes)

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

Änderungen 2020-04:

+ Geringe Anpassung an systemd in "Allgemeine Parameter des Linux-Kernels", da die alte Terminologie wohl noch länger erhalten bleibt.
+ Korrektur und Prüfung aller Links
+ Integration von "cheatcodes-vga"
+ sieht gut aus!

Änderungen 2020-12:

+ Für die Verwendung mit pandoc optimiert.
+ Inhalt teilweise überarbeitet.

ENDE   INFOBEREICH FÜR DIE AUTOREN

## Info

Diese Handbuchseite enthält Tabellen zu den Bootoptionen für

1. siduction spezifische Parameter (nur Live-CD)
2. Bootoptionen für den Grafikserver X
3. Allgemeine Parameter des Linux-Kernels
4. Werte für den allgemeinen Parameter **vga**
 
Sofern in dem "Werte"-Feld der Tabellen Werte aufgelistet werden, müssen diese an die betreffende Bootoption mit einem "**=**" Zeichen angehängt werden. Wenn zum Beispiel "1280x1024" der gewünschte Wert für die Bootoption "screen" wäre, dann wird "screen=1280x1024" in die Grub-Befehlszeile eingegeben, für die Sprachauswahl (hier "Deutsch") "lang=de". Die Grub-Befrehlszeile lässt sich editieren, indem man, sobald das Grub-Menue erscheint, die Taste `e` drückt. Danach befindet man sich im Editiermodus. Jetzt kann man mit den Pfeiltasten zur Kernelzeile navigieren und am Ende den oder die gewünschten Cheatcode einfügen. Als Trennzeichen dient das Leerzeichen. Der Bootvorgang wird mit der Tastenkombination `Strg`+`X` oder `F10` fortgesetzt.

[Ausführliche Referenzliste für Kernel-Bootcodes von kernel.org (Englisch, PDF)](http://files.kroah.com/lkn/lkn_pdf/ch09.pdf) 

---

## siduction spezifische Parameter (nur Live-CD)

| Bootoption | Wert | Beschreibung | 
| ---- | ---- | ---- |
|  blacklist  | Name des Moduls | temporäre Deaktivierung von Modulen, bevor udev aktiv wird | 
|  desktop  | kde, gnome, fluxbox | Desktopumgebung auswählen | 
|  fromiso  |  | [bitte lies "Booten 'fromiso'"](hd-install-opts_de.md#fromiso)  | 
|  hostname  | myhostname | ändert den Netzwerknamen (hostname) des Live-CD-Systems | 
|  lang  |  be, bg, cz, da, de, de_CH, el, en, en_AU, en_GB, en_IE, es, fr, fr_BE, ga, hr, hu, it, ja, nl, nl_BE, pl, pt (pt_BR), pt_PT, ro, ru, zh | setzt die Spracheinstellung, die Grundeinstellungen der Lokalisation (locales), das Tastaturlayout (in der Konsole wie in X), die Zeitzone und den Spiegelserver von Debian.  Mit der Langform **lang=ll_cc** oder **lang=ll-cc** bedeutet **ll** die Sprachauswahl und **cc** Tastaturlayout, Spiegelserver und Zeitzonenwahl (z.B. "lang=fr-be" ). Die Grundeinstellung für Englisch ist en_US mit UTC als Zeitzone und für Deutsch, de mit Europe/Berlin als die Zeitzone. Beispiel für eine selbstgewählte Einstellung: "lang=pt_PT tz=Pacific/Auckland"  | 
|  md5sum  |  | testet die Prüfsumme der CD/DVD (zur Kontrolle, ob CD/DVD in Ordnung sind) | 
|  noaptlang  |  | Verhindert die Installation von Lokalisierungspaketen der gewählten Sprache | 
|  nocpufreq  |  | aktiviert kein Speedstep/Powernow  | 
|  nodhcp  |  | kein DHCP (DHCP versucht automatisch Ethernetverbindungen aufzubauen) | 
|  noeject  |  | entfernt CD/DVD nicht aus dem Laufwerk | 
|  nofstab  |  | Verhindert das Schreiben einer neuen fstab | 
|  nointro  |  | überspringt die Ausgabe der index.html beim Start der Live-DVD/CD  | 
|  nomodeset  | radeon.modeset=0 | ermöglicht zusammen mit **xmodule=vesa** ein sauberes Booten nach X bei Radeonkarten im Live-Mode | 
|  nonetwork  |  | verhindert die automatische Konfiguration von Netzwerkschnittstellen beim Booten | 
|  noswap  |  | Keine Aktivierung der Swap-Partition | 
|  persist  |  | [bitte lies "fromiso und persist"](hd-install-opts_de.md#fromiso-persist)  | 
|  smouse  |  | sucht mittels hwinfo nach seriellen Mauseingabegeräten | 
|  tz  | tz=Europe/Dublin | setzt die Zeitzone. Falls die Bios- bzw. Hardwareuhr auf UTC eingestellt ist, wird **utc=yes** angegeben. Eine Liste aller unterstützter Zeitzonen kann eingesehen werden, wenn per copy & paste: **file:///usr/share/zoneinfo/** in den Browser eingegeben wird . | 
|  toram  |  | kopiert die DVD/CD ins RAM und startet aus der RAM-Kopie | 

---

## Bootoptionen für den Grafikserver X

Es sollte zusätzlich auch entweder die Bootoption xandr oder xmodule verwendet werden, wenn man Bootoptionen für den Grafikserver X für die Grafikkarten Radeon, Intel oder MGA einsetzt.

| Bootoption | Wert | Beschreibung | 
| ---- | ---- | ---- |
|  dpi  | auto  *oder*  DPI-Zahl | setzt die gewünschten Pixel pro Zoll für den Monitor. Die DPI für den Monitor erhält man, wenn man die Pixelanzahl der Monitorbreite durch den Zollwert der Diagonale dividiert und mit folgenden Werten multipliziert: 1,25 für einen 4:3-Bildschirm, 1,18 für einen 16:10-Bildschirm oder 1,147 für einen 16:9-Bildschirm. Für einen 24"-Bildschirm mit der Auflösung 1920x1080 ergibt das mittels 1,147x1920/24 dpi=92 oder für einen 15"-Bildschirm mit der Auflösung 1600x1200 ergibt das mittels 1.25x1600/15 dpi=133. | 
|  hsync  | 80 | setzt die horizontale Frequenz des Monitors (in Kilohertz) | 
|  noml  |  | verhindert, dass die X.org-Konfiguration eine Liste von Modelines enthält, und bewirkt dadurch, dass der korrekte Mode automatisch erkannt wird | 
|  noxrandr  |  | verhindert die Verwendung der Erweiterungen von RandR 1.2 durch die neuen X.org-Treiber und nutzt die alten Techniken zur Abfrage der Monitoreigenschaften | 
|  screen  | 1280x1024 | stellt benutzerdefinierte Auflösung für X ein (1280x1024 oder andere Bildschirmauflösungen) | 
|  vsync  | 60 | setzt die vertikale Frequenz des Monitors (in Hertz), der Wert ist ein Beispiel | 
|  xdepth  | Werte: 8 15 16 24 | setzt die Farbtiefe, die von X.org benutzt wird (nicht alle Treiber unterstützen 1 und 4) | 
|  keytable  | z.B. us, de, gb | Tastaturlayout, das von X.org benutzt wird | 
|  xkbmodel  | (z.B.) pc105  | Tastaturtyp, der von X.org benutzt wird (die Zahl bezeichnet die Anzahl der Tasten) | 
|  xkboptions  | (z.B.) grp:alt_shift_toggle | Belegungsvariante der Tastatur, die von X.org benutzt wird | 
|  xkbvariant  | (z.B.) nodeadkeys,  | Setzen einer Belegungsvariante der Tastatur | 
|  xmode  | 800x600 | setzt die Bildschirmauflösung nach dem gegebenen Wert (1024x768, 1600x1200 etc.) | 
|  xmodule or xdriver  | ati, fbdev, i810, intel, mga, nouveau, radeon, savage, vesa | nutzt das gewählte X-Modul | 
|  xrandr  |  | erzwingt X.org-Konfiguration unter Verwendung der neuen RandR-1.2-Erweiterungen der X.org-Treiber | 
|  xrate  | XX | erzwingt eine bevorzugte Wiederholungsfrequenz bei Treibern, die durch RandR 1.2 unterstützt sind. Diese Option muss in Verbindung mit der Bootoption xmode verwendet werden. Eine ausführliche Dokumentation findet sich [hier](http://wiki.debian.org/XStrikeForce/HowToRandR12)  | 
|  xhrefresh  | 75 | setzt die horizontale Frequenz des Monitors für X (in Kilohertz), der Wert ist Beispiel | 
|  xvrefresh  | 60 | setzt die vertikale Frequenz des Monitors für X (in Hertz), der Wert ist Beispiel | 

---

## Allgemeine Parameter des Linux-Kernels

| Bootoption | Wert | Beschreibung | 
| ---- | ---- | ---- |
|  apm  | off | schaltet Advanced Power Managment aus | 
|  1, 3, 5  |  (z.B.) 3  |  Boot-Ziele bzw. Runlevel, die man manuell in der Grub-Bootzeile eingeben kann. Siehe auch die Handbuchseite [Runlevel - Ziel-Unit](sys-admin-gen_de.md#ziel-unit)  | 
|  irqpoll  |  | benutzt IRQ-Polling | 
|  mem  | (z.b) 128M, 1G | benutzt die angegebene Speichergröße | 
|  noagp  |  |  keine AGP-Unterstützung (Accelerated Graphics Port) | 
|  noapic  |  | keine APIC-Abfrage (Advanced Programmable Interrupt Controller) | 
|  nodma  |  | keine Unterstützung für DMA (Direct Memory Access) | 
|  noisapnpbios  |  | führt keine ISA-"Plug and Play"-Abfrage beim Start durch | 
|  nomce  |  | deaktiviert die Kernel-Option "Machine Check Exception" | 
|  nosmp  |  | verwendet keinen Symmetric Multi-Prozessor (mehrere CPUs oder CPUs mit Hyper-Threading) | 
|  pci  | noacpi | kein ACPI für PCI-Geräte | 
|  quiet  |  | es erfolgt keine Ausgabe am Bildschirm | 
|  vga  | normal | mehr zu vga-Codes hier: [VGA-Bootoptionen](cheatcodes_de.md#vga)  | 
|  video  | (z.B.) DVI-0:800x600 | Für Grafikkarten mit aktiviertem KMS. Dies gilt für Intel- und ATI-Grafikkarten (Letztere mit Radeon-Treiber), wobei DVI-X/LVDS-X die Video-Ausgabe ist, die von xrandr gezeigt wird. | 

---

## VGA-Codes

Die folgenden Tabellen listen die Werte, die mit dem allgemeinen Parameter **vga** angegeben werden können.  
Ein Anwendungsbeispiel ist **vga=791** (VESA-Code, Auflösung 1024x768 bei 64000 Farben)

Probleme bei Netbooks oder anderen Bildschirmauflösungen können mit der Eingabe von vga=0 in die Grubzeile gelöst werden.

### Dezimal:

|  Farben  |  640x480  |  800x600  |  1024x768  |  1280x1024  | 
| :----: | :----: | :----: | :----: | :----: |
|  256  | 257 | 259 | 261 | 263 | 
|  32k  | 272 | 275 | 278 | 281 | 
|  64k  | 273 | 276 | 279 | 282 | 
|  16M  | 274 | 277 | 280 | 

---

### Hexadezimal:

|  Farben  |  640x480  |  800x600  |  1024x768  |  1280x1024  | 
| :----: | :----: | :----: | :----: | :----: |
|  256  | 0x101 | 0x103 | 0x105 | 0x107 | 
|  32k  | 0x110 | 0x113 | 0x116 | 0x119 | 
|  64k  | 0x111 | 0x114 | 0x117 | 0x11A | 
|  16M  | 0x112 | 0x115 | 0x118 | 

---

### VESA:

|  Farben  |  640x480  |  800x600  |  1024x768  |  1280x1024  |  1600x1200  | 
| :----: | :----: | :----: | :----: | :----: | :----: 
|  256  | 769 | 771 | 773 | 775 | 796 | 
|  32k  | 784 | 787 | 790 | 793 | 797 | 
|  64k  | 785 | 788 | 791 | 794 | 798 | 
|  16M  | 786 | 789 | 792 | 795 | 

---

<div id="rev">Zuletzt bearbeitet: 2020-12-04</div>
