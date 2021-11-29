% Neue Kernel installieren

## Kernel Upgrade

Siduction stellt folgende Kernel bereit:

+ **linux-image-siduction-amd64  +  linux-headers-siduction-amd64**  - Linux Kernel für 64-bit PCs mit AMD64 oder Intel 64 CPU.
+ 32 bit Kernel stellen wir nicht mehr zur Verfügung, hier kann der Debian Kernel, oder alternativ der Liquorix-Kernel (https://liquorix.net/) verwendet werden.

Die Kernel von siduction befinden sich im siduction-Repository als .deb und werden bei einer Systemaktualisierung automatisch berücksichtigt, sofern die Metapakete für Image und Headers installiert sind.


### Kernel-Aktualisierung ohne Systemaktualisierung

1. Aktualisierung der Paketdatenbank:

  ~~~
  apt update
  ~~~

2. Installation des aktuellen Kernels:

  ~~~
  apt install linux-image-siduction-amd64 linux-headers-siduction-amd64
  ~~~

3. Neustart des Computers, um den neuen Kernel zu laden.

  Falls sich mit dem neuen Kernel Probleme zeigen, kann man nach einem Neustart einen älteren Kernel wählen.


### Module

Der Kernel bringt in der Regel alle benötigten Kernel-Module mit. Für 3rd Party Module wird in siduction dkms empfohlen.
Hierzu ist es notwendig, das Paket **build-essential** zu installieren. Da 3rd Party Module oftmals unfreie Module sind, ist sicherzustellen,
dass contrib und non-free in den Sourcen aktiviert ist.

### Entfernen alter Kernel

Nach erfolgreicher Installation eines neuen Kernels können alte Kernel entfernt werden. Es ist jedoch empfohlen, alte Kernel einige Tage zu behalten. Falls mit dem neuen Kernel Probleme auftauchen, kann in einen der alten Kernel gebootet werden, welche im Grub-Startbildschirm gelistet sind.

Zur Entfernung alter Kernel ist das Skript "kernel-remover"  installiert:

~~~
kernel-remover
~~~

<div id="rev">Seite zuletzt aktualisiert 2021-11-29</div>
