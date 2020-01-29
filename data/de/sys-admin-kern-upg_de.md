<div class="divider" id="kern-upgrade"></div>

## Neue Kernel installieren

#### `Die Kernel von siduction befinden sich im siduction-Repository als .deb und werden bei einer Systemaktualisierung automatisch berücksichtigt.` 

---

Folgende Kernel sind verfügbar:

+  **siduction-686**  - Kernel für die i686-Prozessorfamilie mit Single/Dual/Multi Core Prozessoren

+  **siduction-amd64**  - Kernel für 64 bit siduction

#### Schritte einer Kernel-Aktualisierung ohne Systemaktualisierung (dist-upgrade):

 **1.**  Aktualisierung der Paketdatenbank:

~~~
apt-get update
~~~

 **2.**  Installation des aktuellen Kernels:

~~~
apt-get install linux-image-siduction-686 linux-headers-siduction-686
~~~

Neustart des Computers, um den neuen Kernel zu laden.

`Falls sich mit dem neuen Kernel Probleme zeigen, kann man nach einem Neustart einen älteren Kernel wählen.` 

#### Module

Mit diesem Befehl können die benötigten Module ermittelt werden (bitte kopieren und in eine Konsole einfügen):

~~~
apt-cache search 3.*-*.towo.*-siduction| awk '/modules/{print $1}'
~~~

Damit erhält man eine ausführliche Beschreibung eines jeden Moduls (bitte kopieren und in eine Konsole einfügen):

~~~
apt-cache search 3.*-*.towo.*-siduction
~~~

So installiert man benötigte Module (zum Beispiel virtual-ose und qc-usb):

~~~
apt-get install virtualbox-ose-modules-3.2.0.towo.7-siduction-686 (BEISPIEL)
apt-get install qc-usb-modules-3.2.0.towo.7-siduction-686 (BEISPIEL)
~~~

So überprüft man, welche Module in den Kernel geladen sind:

~~~
ls /sys/module/
oder
cat /proc/modules
~~~

### Beispiel: Installation des `Moduls speakup`  mit module-assistant

Man stellt sicher, dass `contrib non-free`  in der Quellenliste `/etc/apt/sources.list.d/debian.list`  angefügt ist: 

~~~
apt-cache search speakup-s
speakup-source - Source of the speakup kernel modules
~~~

Vorbereitung des Moduls:

~~~
m-a prepare
m-a a-i speakup-source
~~~

Nun folgt die Aktivierung des "Dynamic Module-Assistant Kernel Module Support" für speakup, sodass bei der nächsten Kernelaktualisierung das Modul speakup ebenfalls vorbereitet wird, ohne dass man eingreifen muss. Dazu fügt man `speakup-source`  in die Konfigurationsdatei `/etc/default/dmakms`  ein. 

~~~
mcedit /etc/default/dmakms
speakup-source
~~~

Dies wiederholt man für jedes Kernelmodul, das zu module-assistant kompatibel ist.

Die Linux-Headers müssen mit dem dazugehörigen Linux-Image installiert sein, damit module-assistand Kernelmodule kompilieren kann.

### Wenn ein Modul nicht lädt

Falls ein Modul - aus welchem Grund auch immer (neue Xorg-Komponente o.a.) - nicht lädt:

~~~
modprobe <module2
~~~

und reboot.

Sollte das Modul nach dem Neustart immer noch nicht laden:

~~~
m-a a-i -f module-source
~~~

Damit wird das Modul neu kompiliert, `danach reboot` .

<div class="divider" id="kern-remove"></div>

## Entfernen alter Kernel (kernel remover)

Nach erfolgreicher Installation eines neuen Kernels können alte Kernel entfernt werden. Es ist jedoch empfohlen, alte Kernel einige Tage zu behalten. Falls mit dem neuen Kernel Probleme auftauchen, kann in einen der alten Kernel gebootet werden, welche im Grub-Startbildschirm gelistet sind.

Zur Entfernung alter Kernel kann das Skript `kernel-remover`  installiert werden:

~~~
apt-get update
apt-get install kernel-remover
~~~

<div id="rev">Page last revised 15/01/2012 1445 UTC</div>
