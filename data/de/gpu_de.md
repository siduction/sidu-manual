## Open Source Xorg-Treiber für ATI/AMD , Intel & nVidia

Wir gehen hier im Handbuch nur auf die verbreitetsten Grafikkarten ein. Exotische oder relative alte Grafikhardware, sowie Server-Grafik findet hier keine Beachtung.  

Das Grafiksystem unter Linux splittet sich in 4 separate Teile:

+ Kernel Treiber 
    - radeon/amdgpu (ATI/AMD Grafik)
    - i915 (Intel Grafik)
    - nouveau (nVidia Grafik)
---

+ Direct Rendering Manager  
    - libdrm-foo 
---

+ DDX Treiber 
    - xserver-xorg-video-radeon/amdgpu
    - xserver-xorg-video-intel
    - xserver-xorg-video-nouveau
    
_Xorg kann auch den modesetting-ddx verwenden, welcher mittlerweile Bestandteil des Xservers selbst ist. Dieser wird automatisch für Intel Grafik benutzt und auch dann, wenn kein spezielles xserver-xorgvideo-foo Paket installiert ist._

+ dri/mesa 
    - libgl1-mesa-glx
    - libgl1-mesa-dri
    - libgl1-mesa-drivers
_Dieser Teil von Xorg ist die freie OpenGL Schnittstelle für Xorg._

Open Source Xorg-Treiber für nVidia (modesetting/nouveau), ATI/AMD (modesetting/radeon/amdgpu), Intel (modesetting/intel) und weitere sind mit siduction vorinstalliert.

Anmerkung: xorg.conf wird für Open-Source-Treiber in der Regel nicht mehr benötigt Ausnahmen sind z.B. Mehrschirmbetrieb.

Welche Grafikhardware verbaut ist erfährt man relativ einfach

    inxi -G
    lspci | egrep -i "vga|3d|display"

Diese Information ist auch überaus wichtig, sollte man Probleme mit der Grafik haben und Hilfe im Forum oder dem IRC suchen.

### Propritäre Treiber

Propritäre Treiber gibt es faktisch nur noch für nVidia Grafikkarten. AMD hat zwar auch einen propritären Treiber namens amdgpu-pro, dieser unterstützt aber offiziell nur Ubuntu in bestimmten Versionen und liegt in Debian nicht paketiert vor. Außerdem ist dieser Treiber eher für professionelle Karten denn für Desktop Karten konzipiert.

Um vom proprietären Treiber von Nvidia auf nouveau zu wechseln, siehe den [Eintrag im siduction Wiki.](http://wiki.siduction.de/index.php?title=Wie_entferne_ich_propriet%C3%A4re_nVidia-Treiber%3F)

Mehr Informationen zu [Intel](http://www.x.org/wiki/IntelGraphicsDriver)    [ATI/AMD](http://www.x.org/wiki/radeon)   [nouveau](http://nouveau.freedesktop.org/wiki/FeatureMatrix)  [X.Org](http://xorg.freedesktop.org/).

## 2D Videotreiber

So ziemlich jede Grafikkarte, welche einen [KMS](https://wiki.debian.org/KernelModesetting) Treiber kernelseitig benutzt, ist für den 2D Betrieb unter allen Oberflächen geeignet. In aller Regel (bis auf wenige Ausnahmen exotischer oder alter Hardware) ist auch 3D Beschleunigung vorhanden.  
## 3D Treiber

3D Beschleunigung steht unter Linux für Intel-, AMD- und nVidia-Grafikkarten zur Verfügung. Wie gut die freien Treiber 3D implementiert haben, hängt ein wenig von der Grafikkarte selbst ab. Generell ist anzumerken, das fast alle Grafikkarten nicht-freie Firmware benötigen, um einen problemlosen Betrieb zu ermöglichen. Diese Firmware gibt es bei Debian nur im non-free Repository, das diese Firmware nict DFSG konform ist. Ist die korrekte Firmware installiert, ist 3D Support mit Intel oder AMD Grafikkarten ohne weiteres Zutun verfügbar. Bei nVidia Grafik sieht die Geschichte etwas anders aus. Ältere Karten, welche seitens nVidia als legacy Karten eingestuft sind, funktionieren relativ gut, auch wenn immer mit Problemen zu rechnen ist, da auch der verwendete Desktop eine Rolle spielt. Der freie nouveau-Treiber wird ohne Unterstützung von nVidia per [reverse engineering](https://de.wikipedia.org/wiki/Reverse_Engineering) entwickelt.

Da für den korrekten Betrieb in der Regel (AMD, Intel ab Skylake und Nvidia ab Fermi) die nicht-freie Firmware benötigt wird, sollte in /etc/apt/sources.list/debian.list ein Eintrag analog

    deb     http://deb.debian.org/debian/ unstable main contrib non-free 

gesetzt sein. Um sich nachfolgende Probleme mit WLAN, Netzwerk, Bluetooth oder Ähnliches zu ersparen, ist ein 

    apt update && apt install firmware-linux-nonfree

sinnvoll. Damit installiert man zwar mehr Firmwares, als man evtl. benötigt, das sollte aber kein Nachteil sein.

## Binäre, nicht quelloffene Treiber für nVidia mit dkms & xorg.conf.d

nVidia teilt seine Grafikkarten-Treiber in 7 Generationen auf:

1. Riva TNT, TNT2, GeForce, und einige GeForce 2000 GPUs
2. GeForce 2000 bis GeForce 4000 series GPUs
3. GeForce 5000 series GPUs
4. GeForce 6000 and 7000 series GPUs
5. GeForce 8000 and 9000 series GPUs
6. GeForce 400 und 500 series GPUs (Fermi GF1xx)
7. Geforce 600, 700, 800 (Kepler GK1xx GK2xx, Maxwell GM1xx GM2xx, );  
   Geforce 10xx (Pascal GP1xx), Geforce 16xx/20xx  (Turing TU1xx)

Karten der Generationen 1 - 4 werden seitens nVidia nicht mehr unterstützt, es gibt hierfür nur alte Treiber-Versionen, die weder mit aktuellen Kerneln, noch mit aktuellen Versionen des Xorg-Servers funktionieren. Für eine komplette und aktuelle Liste unterstützter Grafikchips konsultiere bitte "Supported Products List" auf der [Downloadseite für NVIDIA-Linux Grafiktreiber](http://www.nvidia.com/object/unix.html).  

Debian stellt folgende Versionen der binären Treiber zur Verfügung:

    - nvidia-legacy-304xx-driver (für 4.)
    - nvidia-legacy-340xx-driver (für 5.)
    - nvidia-legacy-390xx-driver (für 6.)
    - nvidia-driver (für 7.)

Da es sich hier aber um propritäre Treiber handelt, muss in den Sources contrib und non-free aktiviert sein (wie auch für die Firmware für freie Treiber). Es ist im Vorfeld sicher zu stellen, dass die kernel-header passend zum laufenden Kernel installiert sind. Das ist automatisch der Fall, sobald linux-image-siduction-amd64 und linux-headers-siduction-amd64 installiert sind. Außerdem sind die Pakete gcc, make und dkms notwendig. NAchdem man nun mit den genannten Befehlen herausgefunden hat, welche nVidia Karte, bzw welchen nVidia Chip man hat, kann man den Treiber wie folgt installieren:  

**GeForce 8000 and 9000 series**

    apt update && apt install nvidia-legacy-340xx-driver  

**GeForce GF1xx Chipsatz, Fermi Cards**

    apt update && apt install nvidia-legacy-390xx-driver

**Kepler, Maxwell, Pascal und neuer (GKxxx, GMxxx, GPxxx, TU1xx)**

    apt update && apt install nvidia-driver

Wenn das fehlerfrei durchgelaufen ist noch ein

    mkdir -p /etc/X11/xorg.conf.d; echo -e 'Section "Device"\n\tIdentifier "My GPU"\n\tDriver "nvidia"\nEndSection' > /etc/X11/xorg.conf.d/20-nvidia.conf  

ausführen, um Xorg mitzuteilen, diesen installierten Treiber zu benutzen. Nach einem Reboot sollte das System hoffentlich bis in den Desktop starten. Sollten Probleme auftreten, sprich der Desktop nicht starten, so sollte man /var/log/Xorg.0.log konsultieren.  

Problematisch sind Notebooks mit Hybridgrafik Intel/nVidia, sogenannte Optimus Hardware. Hier wurde früher auf [Bumblebee](https://wiki.debian.org/Bumblebee) verwiesen, diese Lösung ist aber alles Andere, als optimal. nVidia selbst empfielt hingegen diese Setups per [PRIME](https://devtalk.nvidia.com/default/topic/957814/linux/prime-and-prime-synchronization/) zu konfigurieren. Unsere Empfehlung ist aber, solche Hardware, wenn es geht, zu vermeiden. Tipps zur Einrichtung für Optimus Hardware können wir hier nicht geben.
