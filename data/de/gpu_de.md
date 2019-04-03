
##Open Source Xorg-Treiber für ATI/AMD , Intel & nVidia

Das Grafiksystem unter Linux splittet sich in 4 separate Teile:

+ Kernel Treiber 
 
        - radeon/amdgpu (ATI/AMD Grafik)
        - i915 (Intel Grafik)
        - nouveau (nVidia Grafik)

+ Direct Rendering Manager 

        - libdrm-foo 


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

Falls man von einem proprietären Treiber auf einen freien Treiber wechseln möchte, kann man mit einem Texteditor den Stub der /etc/X11/xorg.conf.d/xx-xxxx.conf löschen.

Um vom proprietären Treiber von Nvidia auf nouveau zu wechseln, siehe den [Eintrag im siduction Wiki.](http://wiki.siduction.de/index.php?title=Wie_entferne_ich_propriet%C3%A4re_nVidia-Treiber%3F)

Mehr Informationen zu [Intel](http://www.x.org/wiki/IntelGraphicsDriver)    [ATI/AMD](http://www.x.org/wiki/radeon)   [nouveau](http://nouveau.freedesktop.org/wiki/FeatureMatrix)  [X.Org](http://xorg.freedesktop.org/)

##2D Videotreiber

So ziemlich jede Grafikkarte, welche einen [KMS](https://wiki.debian.org/KernelModesetting) Treiber kernelseitig benutzt, ist für den 2D Betrieb unter allen Oberflächen geeignet. In aller Regel (bis auf wenige Ausnahmen exotischer oder alter Hardware) ist auch 3D Beschleunigung vorhanden.  
##3D Treiber

3D Beschleunigung steht unter Linux für Intel-, AMD- und nVidia-Grafikkarten zur Verfügung. Wie gut die freien Treiber 3D implementiert haben, hängt ein wenig von der Grafikkarte selbst ab. Generell ist anzumerken, das fast alle Grafikkarten nicht freie Firmware benötigen, um einen problemlosen Betrieb zu ermöglichen. Diese Firmware gibt es bei Debian nur im non-free Repository, das diese Firmware nict DFSG konform ist. Ist die korrekte Firmware installiert, ist 3D Support mit Intel oder AMD Grafikkarten ohne weiteres Zutun verfügbar. Bei nVidia Grafik sieht die Geschichte etwas anders aus. Ältere Karten, welche seitens nVidia als legacy Karten eingestuft sind, funktionieren relativ gut, auch wenn immer mit Problemen zu rechnen ist, da auch der verwendete Desktop eine Rolle spielt. Der freie nouveau-Treiber wird ohne Unterstützung von nVidia per [reverse engineering](https://de.wikipedia.org/wiki/Reverse_Engineering) entwickelt.

##Binäre, nicht quelloffene Treiber für nVidia mit dkms & xorg.conf.d

nVidia teilt seine Grafikkarten Generationen in 7 Generationen auf:

1. Riva TNT, TNT2, GeForce, und einige GeForce 2000 GPUs
2. GeForce 2000 bis GeForce 4000 series GPUs
3. GeForce 5000 series GPUs
4. GeForce 6000 and 7000 series GPUs
5. GeForce 8000 and 9000 series GPUs
6. GeForce 400 und 500 series GPUs (Fermi GF1xx)
7. Geforce 600, 700, 800 (Kepler GK1xx GK2xx, Maxwell GM1xx GM2xx, );  
   Geforce 10xx (Pascal GP1xx), Geforce 16xx/20xx  

Karten der Generationen 1 - 4 werden seitens nVidia nicht mehr unterstützt, es gibt hierfür nur alte Treiber-Versionen, die weder mit aktuellen Kerneln, noch mit aktuellen Versionen des Xorg-Servers funktionieren.