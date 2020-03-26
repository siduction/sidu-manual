<div class="divider" id="cheatcodes">

## Bootoptionen (Cheatcodes)

 Wenn die möglichen Werte in dem "Werte"-Feld der Tabelle aufgelistet werden, müssen diese an die "Bootoption" mit einem  **`=`**  Zeichen angehängt werden. Wenn zum Beispiel 1280x1024 der gewünschte Wert für die Bootoption "screen" wäre, dann wird  `screen=1280x1024`  in die Grub-Befehlszeile eingegeben, für die Sprachauswahl (hier "Deutsch")  `lang=de` . Die Grub-Befrehlszeile lässtsich editieren, indem man, sobald man die Grub-Anzeige sieht, die Taste  `e`  drückt. Dann befindet man sich im Editiermodus. Jetzt kann man an die Kernelzeile (hinter  `quiet` ) den gewünschten Cheatcode einfügen. Der Bootvorgang wird mit  `Strg - X`  fortgesetzt. Man kann auch mehrere Cheatcodes hintereinander schreiben.

[Ausführliche Referenzliste für Kernel-Bootcodes von kernel.org (Englisch, PDF)](http://files.kroah.com/lkn/lkn_pdf/ch09.pdf) 

---

<div class="divider" id="cheatcodes-siduction">

## siduction spezifische Parameter (nur Live-CD)

| Bootoption | Wert | Beschreibung | 
| ---- | ---- | ---- |
|  **blacklist**  | Name des Moduls | temporäre Deaktivierung von Modulen, bevor udev aktiv wird | 
|  **desktop**  | kde | Desktopumgebung auswählen | 
|  | fluxbox |  | 
|  **fromiso**  |  | [bitte lies "Booten 'fromiso'"](hd-install-opts-de.htm#fromiso)  | 
|  **hostname**  | myhostname | ändert den Netzwerknamen (hostname) des Live-CD-Systems | 
|  **lang**  |  be, bg, cz, da, de, de_CH, el, en, en_AU, en_GB, en_IE, es, fr, fr_BE, ga, hr, hu, it, ja, nl, nl_BE, pl, pt (pt_BR), pt_PT, ro, ru, zh | setzt die Spracheinstellung, die Grundeinstellungen der Lokalisation (locales), das Tastaturlayout (in der Konsole wie in X), die Zeitzone und den Spiegelserver von Debian.  Mit der Langform  `lang=ll_cc`  oder  `lang=ll-cc`  bedeutet  `ll`  die Sprachauswahl und  `cc`  Tastaturlayout, Spiegelserver und Zeitzonenwahl (z.B.  `lang=fr-be` ). Die Grundeinstellung für Englisch ist en_US mit UTC als Zeitzone und für Deutsch, de mit Europe/Berlin als die Zeitzone. Beispiel für eine selbstgewählte Einstellung:  `lang=pt_PT tz=Pacific/Auckland`  | 
|  **md5sum**  |  | testet die Prüfsumme der CD/DVD (zur Kontrolle, ob CD/DVD in Ordnung sind) | 
|  **noaptlang**  |  | Verhindert die Installation von Lokalisierungspaketen der gewählten Sprache | 
|  **nocpufreq**  |  | aktiviert kein Speedstep/Powernow  | 
|  **nodhcp**  |  | kein DHCP (DHCP versucht automatisch Ethernetverbindungen aufzubauen) | 
|  **noeject**  |  | entfernt CD/DVD nicht aus dem Laufwerk | 
|  **nofstab**  |  | Verhindert das Schreiben einer neuen fstab | 
|  **nointro**  |  | überspringt die Ausgabe der index.html beim Start der Live-DVD/CD  | 
|  **nomodeset**  | radeon.modeset=0 | ermöglicht zusammen mit  `xmodule=vesa`  ein sauberes Booten nach X bei Radeonkarten im Live-Mode | 
|  **nonetwork**  |  | verhindert die automatische Konfiguration von Netzwerkschnittstellen beim Booten | 
|  **noswap**  |  | Keine Aktivierung der Swap-Partition | 
|  **persist**  |  | [bitte lies "fromiso und persist"](hd-install-opts-de.htm#fromiso-persist)  | 
|  **smouse**  |  | sucht mittels hwinfo nach seriellen Mauseingabegeräten | 
|  **tz**  | tz=Europe/Dublin | setzt die Zeitzone. Falls die Bios- bzw. Hardwareuhr auf UTC eingestellt ist, wird  `utc=yes`  angegeben. Eine Liste aller unterstützter Zeitzonen kann eingesehen werden, wenn per copy & paste:  `file:///usr/share/zoneinfo/`  in den Browser eingegeben wird . | 
|  **toram**  |  | kopiert die DVD/CD ins RAM und startet aus der RAM-Kopie | 

---

#### Bootoptionen für den Grafikserver X

Es sollte zusätzlich auch entweder die Bootoption xandr oder xmodule verwendet werden, wenn man Bootoptionen für den Grafikserver X für die Grafikkarten Radeon, Intel oder MGA einsetzt.

| Bootoption | Wert | Beschreibung | 
| ---- | ---- | ---- |
|  **dpi**  | auto  *oder*  DPI-Zahl | setzt die gewünschten Pixel pro Zoll für den Monitor. Die DPI für den Monitor erhält man, wenn man die Pixelanzahl der Monitorbreite durch den Zollwert der Diagonale dividiert und mit folgenden Werten multipliziert: 1,25 für einen 4:3-Bildschirm, 1,18 für einen 16:10-Bildschirm oder 1,147 für einen 16:9-Bildschirm. Für einen 24"-Bildschirm mit der Auflösung 1920x1080 ergibt das mittels 1,147*1920/24 dpi=92 oder für einen 15"-Bildschirm mit der Auflösung 1600x1200 ergibt das mittels 1.25*1600/15 dpi=133. | 
|  **hsync**  | 80 | setzt die horizontale Frequenz des Monitors (in Kilohertz) | 
|  **noml**  |  | verhindert, dass die X.org-Konfiguration eine Liste von Modelines enthält, und bewirkt dadurch, dass der korrekte Mode automatisch erkannt wird | 
|  **noxrandr**  |  | verhindert die Verwendung der Erweiterungen von RandR 1.2 durch die neuen X.org-Treiber und nutzt die alten Techniken zur Abfrage der Monitoreigenschaften | 
|  **screen**  | 1280x1024 | stellt benutzerdefinierte Auflösung für X ein (1280x1024 oder andere Bildschirmauflösungen) | 
|  **vsync**  | 60 | setzt die vertikale Frequenz des Monitors (in Hertz), der Wert ist ein Beispiel | 
|  **xdepth**  | Werte: 8 15 16 24 | setzt die Farbtiefe, die von X.org benutzt wird (nicht alle Treiber unterstützen 1 und 4) | 
|  **keytable**  | z.B. us, de, gb | Tastaturlayout, das von X.org benutzt wird | 
|  **xkbmodel**  | (z.B.) pc105  | Tastaturtyp, der von X.org benutzt wird (die Zahl bezeichnet die Anzahl der Tasten) | 
|  **xkboptions**  | (z.B.) grp:alt_shift_toggle | Belegungsvariante der Tastatur, die von X.org benutzt wird | 
|  **xkbvariant**  | (z.B.) nodeadkeys,  | Setzen einer Belegungsvariante der Tastatur | 
|  **xmode**  | 800x600 | setzt die Bildschirmauflösung nach dem gegebenen Wert (1024x768, 1600x1200 etc.) | 
|  **xmodule**  or  **xdriver**  | ati, fbdev, i810, intel, mga, nouveau, radeon, savage, vesa | nutzt das gewählte X-Modul | 
|  **xrandr**  |  | erzwingt X.org-Konfiguration unter Verwendung der neuen RandR-1.2-Erweiterungen der X.org-Treiber | 
|  **xrate**  | XX | erzwingt eine bevorzugte Wiederholungsfrequenz bei Treibern, die durch RandR 1.2 unterstützt sind. Diese Option muss in Verbindung mit der Bootoption xmode verwendet werden. Eine ausführliche Dokumentation findet sich [hier](http://wiki.debian.org/XStrikeForce/HowToRandR12)  | 
|  **xhrefresh**  | 75 | setzt die horizontale Frequenz des Monitors für X (in Kilohertz), der Wert ist Beispiel | 
|  **xvrefresh**  | 60 | setzt die vertikale Frequenz des Monitors für X (in Hertz), der Wert ist Beispiel | 

---

<div class="divider" id="cheatcodes-linux">

## Allgemeine Parameter des Linux-Kernels

| Bootoption | Wert | Beschreibung | 
| ---- | ---- | ---- |
|  **apm**  | off | schaltet Advanced Power Managment aus | 
|  **target**  |  (z.B.) systemd.unit=multi-user.target  |  Boot-Ziele , die man manuell in der Grub-Bootzeile eingeben kann [Siehe auch siduction Runlevels - Ziel-Unit](sys-admin-gen-de.htm#ziel-unit)  | 
|  **irqpoll**  |  | benutzt IRQ-Polling | 
|  **mem**  | (z.b) 128M, 1G | benutzt die angegebene Speichergröße | 
|  **noagp**  |  |  keine AGP-Unterstützung (Accelerated Graphics Port) | 
|  **noapic**  |  | keine APIC-Abfrage (Advanced Programmable Interrupt Controller) | 
|  **nodma**  |  | keine Unterstützung für DMA (Direct Memory Access) | 
|  **noisapnpbios**  |  | führt keine ISA-"Plug and Play"-Abfrage beim Start durch | 
|  **nomce**  |  | deaktiviert die Kernel-Option "Machine Check Exception" | 
|  **nosmp**  |  | verwendet keinen Symmetric Multi-Prozessor (mehrere CPUs oder CPUs mit Hyper-Threading) | 
|  **pci**  | noacpi | kein ACPI für PCI-Geräte | 
|  **quiet**  |  | es erfolgt keine Ausgabe am Bildschirm | 
|  **vga**  | normal | mehr zu vga-Codes hier: [VGA-Bootoptionen](cheatcodes-vga-de.htm#vga)  | 
|  **video**  | (z.B.) DVI-0:800x600 | Für Grafikkarten mit aktiviertem KMS. Dies gilt für Intel- und ATI-Grafikkarten (Letztere mit Radeon-Treiber), wobei DVI-X/LVDS-X die Video-Ausgabe ist, die von xrandr gezeigt wird. | 

<div id="rev">Page last revised 17/11/2014 19:20 UTC</div>
