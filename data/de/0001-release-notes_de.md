% Release Notes

## Release Notes 2023.1.0

**"Standing on the Shoulders of Giants"**

Das siduction-Team ist sehr stolz,euch zu einem besonderen Anlass ein außerplanmäßiges Release vorzustellen. Debian GNU/Linux, dessen Unstable-Zweig einige von uns seit über 20 Jahren verfolgen, feiert am 16.8. 2023 seinen dreißigsten Geburtstag und wir finden, das ist aller Ehren wert. 

Debian ist nach Slackware die zweiälteste Distribution, und wird lediglich von den Beteiligten getragen, ohne das ein Unternehmen im Hintergrund steht oder jemand an der Spitze bestimmt, wo es lang geht. Debian gilt wegen der vielen bis heute unterstützten Architekturen als das »universelle Betriebssystem« und die Stabilität der Veröffentlichungen ist legendär.

### Wechselhafte Geschichte

Die Geschichte begann am 16. August 1993, als Ian Murdock sein selbst konzipiertes System »Debian Linux Release« vorstellte. Im gleichen Jahr folgte das [Debian Manifest](https://www.debian.org/doc/manuals/project-history/manifesto.de.html) Die erste stabile Version 1.1 erschien 1996, damals noch von unter 100 Entwicklern zusammengestellt. Das Release trug den Codenamen »Buzz«, ein erster Bezug auf die Figuren aus dem Film-Franchise Toy Story, dem auch heute noch die Codenamen entliehen werden. 

Bisher sind weitere 16 Veröffentlichungen hinzugekommen, deren aktuelle den Codenamen »Bookworm« trägt und die am 10. Juni 2023 freigegeben wurde. Das Motto lautet dabei immer noch: Es wird veröffentlicht, wenn es fertig ist. 

1997 stimmten bereits rund 400 Entwickler mit dem Debian-Gesellschaftsvertrag einem wichtigen Dokument zu, das seit seinem Bestehen erst zwei Mal editiert wurde und das unter der Ziffer 1. konstatiert: **Debian wird zu 100% frei bleiben**. Gleichzeitig wurden als Teil dieses Vertrags die »Debian-Richtlinien für Freie Software« (DFSG) beschlossen.

### Selbstverwaltet

Debian verwaltet sich in Form einer Do-okratie. Dabei bestimmen die heute rund 1.000 Entwickler selbständig und verantwortlich ihre Aufgaben. Dass das unter Tausend Kreativen nicht immer einfach ist, sollte jedem klar sein. Daran erinnern unter anderem Verwerfungen wie die Einführung von Systemd, die Debian bis an die Belastungsgrenze brachte. Heiß diskutiert wurde 2022 auch die Inklusion unfreier Firmware auf den Installationsmedien der Distribution. Die Diskussionen darüber zogen sich über Jahre hin.

Nach außen hin wirkt Debian oft zerstritten, da anstehende Entscheidungen oft hart diskutiert werden. Im Endeffekt scheint das Projekt aber gestärkt aus solchen Phasen hervorzugehen. Diese Verlässlichkeit mag auch ein Grund sein, warum mehr Derivate auf Debian als Basis setzen als auf jede andere Distribution. Derzeit nutzen [122 aktive Distributionen](https://distrowatch.com/search.php?ostype=All&category=All&origin=All&basedon=Debian&notbasedon=None&desktop=All&architecture=All&package=All&rolling=All&isosize=All&netinstall=All&language=All&defaultinit=All&status=Active#simple) Debian als Grundlage. Darunter sind so wegweisende Distributionen wie Knoppix oder Ubuntu. Zählt man nicht mehr aktive Distributionen hinzu, steigt die Zahl auf 414. Imposant!

**Mit Knoppix fing alles an**  
Unsere Zeitleiste beginnt bei Knoppix und ging von Kanotix über sidux und aptosid zu siduction, dass wir nun bereits seit 12 Jahren ausliefern. Debian hat uns nie ednttäuscht, jedoch waren uns die Entscheidungsprozesse manchmal etwas zu langsam. So haben wir beispielsweise Systemd bereits vor Debian eingeführt und auch Firmware liefern wir bereits länger optional aus, um damit aktuelle Hardware auf dem Installationsmedium zu unterstützen. 

Aber ansonsten ist siduction vermutlich zu 98 % Debian Unstable. Dafür bedanken wir uns und wünschen dem Proj́ekt mindestens weiterre 30 Jahre. Standing on the Shoulders of Giants.


### Was erwartet euch bei siduction 2023.1.0

**User und Passwort für die Live-Session lauten siducer/live**

Zunächst einmal erwartet euch ein neues Wallpaper der Künstlerin  [Angevere](https://www.artstation.com/angevere) (Ona Kristensen), das wir mit freundlicher Genehmigung benutzen dürfen.

### Die Flavours

Die Flavours, die wir für siduction 2023.1.0 anbieten, sind KDE Plasma 5.27.7.1, LXQt 1.3.0, Xfce 4.18, Xorg und noX. GNOME, MATE und Cinnamon haben es wieder nicht geschafft, da es keinen Betreuer innerhalb von siduction dafür gibt. Bei Interesse meldet euch bitte. Vielleicht kommen sie irgendwann zurück oder auch nicht. Natürlich sind sie weiterhin aus dem Repository installierbar.

Die veröffentlichten Images von siduction 2023.1.0 sind ein Schnappschuss von Debian Unstable, das auch den Namen Sid trägt, vom 14.08.2023. Sie sind mit einigen nützlichen Paketen und Skripten, einem auf Calamares basierenden Installer und einer angepassten Version des Linux-Kernels 6.4-10 angereichert, während systemd bei 254.1-2 steht.

### Non-free und Contrib
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

Wenn ihr eine bestehende Home-Partition (oder eine andere Datenpartition) wiederverwenden möchtet, solltet ihr dies nach der Installation und nicht im Calamares-Installer tun. Das funktioniert zwar, es ist aber sicherer, dies hinterher zu tun.  
Bei einigen Intel-Grafikprozessoren auf einigen Geräten kann es vorkommen, dass das System kurz nach dem Booten in Live eingefroren ist. Um dies zu beheben, müsst ihr den Kernel-Parameter `intel_iommu=igfx_off` setzen, bevor ihr erneut bootet.

## Credits

### Credits für siduction 2023.1.0

**Core Team:**

Torsten Wohlfarth (towo)  
Hendrik Lehmbruch (hendrikL)  
Ferdinand Thommes (devil)  
Vinzenz Vietzke (vinzv)  
Axel Konrad (akli)

**Früher haben beigetragen:**

Alf Gaida (agaida) (eaten by the cat)  
Axel Beu 2021†  

**Code, Ideen und Unterstützung:**

Markus Meyer (coruja)  
der_bud  
se7en  
davydych  
tuxnix

**Artwork:**

Das Artwork stammt von [Angevere](https://www.artstation.com/angevere) (Ona Kristensen). Wir benutzen es mit freundlicher Genehmigung.

### Vielen Dank an alle Beteiligten

Wir möchten uns bei euch, bei allen Testern und all den Menschen bedanken, die uns über die Jahre hinweg unterstützt haben. Dieses Release ist auch dein Verdienst. Wir möchten zudem dem Geburtstagskind Debian danken, da wir damit auf den Schultern von Giganten stehen.  
Und nun viel Spaß!

Im Namen des siduction-Teams:

Ferdinand Thommes

<div id="rev">Zuletzt bearbeitet: 2023-08-15</div>
