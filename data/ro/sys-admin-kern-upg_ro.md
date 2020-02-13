<div id="main-page"></div>
<div class="divider" id="kern-upgrade"></div>
## Instalarea de noi kernel-uri

##### `Kernel-urile siduction sunt acum în repositoriul siduction ca .deb și incluse automat într-o actualizare cu 'dist-upgrade'.` 


---

Kernelurile sunt disponibile in urmatoarele forme:

+  **siduction-686**  siduction-686 - kernelul pentru i686 Procesor de familie cu miezul singular/dublu sau cu mai muti CPUs  
+  **siduction-amd64**  kernel pentru 64 bits siduction  

##### Pașii de urmat într-o instalare manuală (fără 'dist-upgrade') sunt:

 **1.**  În consolă ca 'root':

~~~  
apt-get update  
~~~

 **2.** Instalarea ultimei versiuni de kernel:

~~~  
apt-get install linux-image-siduction-686 linux-headers-siduction-686  
~~~

Reboot-ați pentru a folosi noul kernel

`Dacă noul kernel este problematic, puteți să rebutați și să alegeți un kernel mai vechi.` 

##### Module

Ca să aflați de care module aveți nevoie, următoarea comandă vă va oferi lista modulelor curente, la zi. Copiati această linie pe consola/terminal:

~~~  
apt-cache search 3._.towo.*-siduction| awk '/modules/{print $1}'  
~~~

Pentru o descriere totala a fiecarui modul, copiază această linie pe consola/terminal:

~~~  
apt-cache search 3._.towo.*-siduction  
~~~

Pentru instalarea modulelor necesare (de exemplu virtual-ose, și qc-usb):

~~~  
apt-get install virtualbox-ose-modules-3.1-4.towo.2-siduction-686 (EXAMPLE)  
apt-get install qc-usb-modules-3.1-4.towo.2-siduction-686 (EXAMPLE)  
~~~

Pentru verificarea modulelor încărcate în kernel:

~~~  
ls /sys/module/  
sau  
cat /proc/modules  
~~~

Numele pachetelor compatibile cu 'module-assistant' trebuie adăugate la `/etc/default/dmakms` , astfel încât procesul să prepare și să instaleze automat aceleași module pentru fiecare nou kernel instalat.

#### Examplu: Instalarea `speakup module`  cu 'module-assistant'

Asigurați-vă că lista de surse are `contrib non-free`  adăugată la linia voastră de surse în: `/etc/apt/sources.list.d/debian.list`  

~~~  
apt-cache search speakup-s  
speakup-source - Source of the speakup kernel modules  
~~~

Apoi pregătiți modulul:

~~~  
m-a prepare  
m-a a-i speakup-source  
~~~

#### Eșuarea încărcării unui Modul

Modulul poate eșua să se încarce din diverse motive [componente noi ale xorg, o problemă a fs sau dacă X nu pornește după reboot] caz în care:

~~~  
modprobe <module>  
~~~

Apoi reboot-ați computerul.

Dacă modulul continuă să eșueze încărcarea:

~~~  
m-a a-i -f module-source  
~~~

Cu aceasta se reconstruiește modulul `apoi reboot-ați.` 

<div class="divider" id="kern-remove"></div>
## Înlocuirea de kernel-uri vechi

După instalarea cu succes a noului kernel,vechile kernel-uri pot fi șterse (deleted), însă se recomandă să le păstrați câteva zile, în cazul în care aveți probleme și deci puteți să boot-ati cu un kernel vechi, după cum este arătat în ecranul grub

Kernel-urile vechi pot fi șterse din sistem. Pentru asta instalați `kernel-remover` :

~~~  
apt-get update  
apt-get install kernel-remover  
~~~

<div id="rev">Page last revised 30/11/2012 1025 UTC</div>
