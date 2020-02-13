<div id="main-page"></div>
<div class="divider" id="part-lvm"></div>
## Partycjonowanie LVM - Logical Volume Manager

**`Oto podstawowe wprowadzenie. To jest twoim zadaniem dowiedzieć się więcej o LVM. Więcej informacji można znaleźć na końcu tej strony - lista nie jest wyczerpująca.`** 

Instrukcje te dotyczą siduction od wersii 2010-03 siduction-apate.

Logiczne wolumeny mogą obejmować kilka dysków i są skalowalne, w przeciwieństwie do tradycyjnej metody partycjonowania dysków twardych. 

Ani tradycyjne metody particjonowania lub particjonowanie z LVM są działania, które są wykonywane bardzo często. Dlatego procedura musi być dobrze przemyślana, aby osiągnąć pożądany efekt. 

Trzech podstawowych pojęć powiniec znać: 

+ `Physical Volumes (woluminy fizyczne):`  To są twoje dyski fizyczne lub partycje dysku, takie jak /dev /sda lub /dev/sdb1, które korzystać podczas montowania/odmontowania. Korzystając z LVM możemy połączyć kilka woluminów fizycznych do grupy woluminów.   
+ `Volume Groups (grupy woluminów):`  Grupa woluminów składa się z rzeczywistych wolumin fizycznych, i jest używana do tworzenia woluminów logicznych, których można tworzyć/zmieniać ich rozmiary/usuwać i używać. Grupa woluminów może być postrzegana jako "wirtualny dysk", który składa się z wielkości fizycznych. Można go podzielić na "wirtualne partycje", które z kolei są woluminy logiczne.   
+ `Logical Volumes (woluminy logiczne):`  Woluminy logiczne są woluminy które są zintegrowane/montowane w systemie. Mogą być zmieniane dynamicznie - jako logiczna wolumin może być większą niż wolumin fizyczna (na przykład logiczny wolumin może się składać z czterech 250GB dysków twardych i zawierać 1 TB).  

### Sześć kroki, które są potrzebne 

`W naszym przykładzie wychodzimy z założenia, że dyski twarde nie są srozdzielone. Należy zauważyć: jeżeli stare partycje zostaną usunięte, wszystkie dane zostaną utracone na zawsze.` 

Ponieważ GParted lub KDE Partition Manager (menedżer partycji, partitionmanager) aktualnie nie wspierają LVM potrzebne jest cfdisk lub fdisk. 

`Krok 1:`  Tworzenie tablicy partycji:

~~~  
cfdisk /dev/sda  
n aby utworzyć nową partycję na dysku  
p ta partycja będzie partycją główną  
1 dać partycji numer 1 jako identyfikator  
`### size allocation  ### pierwszy i ostatni cylinder ustawiać do wartości domyślnych. Naciśnij enter aby używać całą szerokość dysku  
t wybiera typ partycji  
8e jest to kod szesnastkowy (hex code) dla Linux LVM  
W zapisuje zmiany na dysku. ##To polecenie zapisuje tabelę partycji. Jeśli do tej pory popełniłeć błąd, istniejący układ partycjonowania zostanie jaki był, a dane są dalej dostępne.##  
~~~

Jeżeli wolumin ma obejmować dwóch lub więcej dysków, powtórz ten proces na każdym z dysków.

`Krok 2:`  Utwórz wolumin fizyczny (ten krok spowoduje usunięcie wszystkich danych): 

~~~  
pvcreate /dev/sda1  
~~~

Proces ten będzie powtarzany w razie potrzeby dla każdej partycji. 

`Krok 3:`  Utwórz grupę woluminów: 

~~~  
vgcreate vulcan /dev/sda1  
~~~

Jeżeli chcesz używać na przykład trzy dyski, integruj je w vgcreate tak:

~~~  
vgcreate vulcan /dev/sda1 /dev/sdb1 /dev/sdc1  
~~~

Jeśli zrobiłeś to poprawnie będziesz mógł zobaczyć wynik z: 

~~~  
vgscan  
~~~

vgdisplay pokazuje `rozmiar` :

~~~  
vgdisplay vulcan  
~~~

`Krok 4:`  Tworzenie woluminu logicznego. W tym momenciemuszą trzeba decydować, jaki duży powinien być logiczny wolumin na początku. Jedną z zalet LVM jest możliwość dostosowania rozmiaru bez ponownego uruchomienia komputera. 

W naszym przykładzie chcemy wolumin z 300GB o nazwie spock w LVM o nazwie vulcan: 

~~~  
lvcreate -n spock --size 300g vulcan  
~~~

`Krok 5:`  sformatować wolumin (cierpliwość przy formatowaniu, to może trochę potrwać): 

~~~  
mkfs.ext4 /dev/vulcan/spock  
~~~

`Krok 6:` 

~~~  
mkdir /media/spock/  
~~~

Aby montować wolumin w czasie procesu bootowania fstab muszi zostać dostosowany w edytorze tekstu. 

~~~  
mcedit /etc/fstab  
~~~

Zastosowanie `/dev/vulcan/spock`  jest lepszy niż użyć numerów UUID z LVM, ponieważ jest tak łatwiej do klonowania systemu plików (nie ma kolizje-UUID). Zwłaszcza z LVM, można tworzyć systemy plików z tymi samymi numerami UUID (przykład: snapshots).

~~~  
/dev/vulcan/spock /media/spock/ ext4 auto,users,rw,exec,dev,relatime 0 2  
~~~

`Opcjonalne:`  Właściciel wolumina może być zmieniony tak, że inni użytkownicy mogą czytać / zapisać na LVM: 

~~~  
chown root:users /media/spock  
~~~

~~~  
chmod 775 /media/spock  
~~~

Twoje podstawowe LVM powinien być utworzony. 

### Zmiana rozmiaru wolumenu 

`It is highly recommended that you use a live ISO to change the partition sizes. Whilst growing the partition 'on the fly' may be error free, the same can not be said when reducing the volume, as anomalies will cause data loss, particularly if **`/ (root)`**  or **`/home`**  are involved.` 

##### To resize the volume from 300GB to 500GB, as used in this example:

~~~  
umount /media/spock/  
~~~

~~~  
lvextend -L+200g /dev/vulcan/spock  
~~~

Then run the command for the filesystem to be resized:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### To resize the volume from 300GB down to 280GB, as used in this example:

~~~  
umount /media/spock/  
~~~

Then run the command for the filesystem to be resized:

~~~  
e2fsck -f /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock 280g  
~~~

Then resize the volume

~~~  
lvreduce -L-20g /dev/vulcan/spock  
~~~

~~~  
resize2fs /dev/vulcan/spock  
~~~

~~~  
mount /media/spock  
~~~

##### Zarządzanie LVM z programu GUI

`system-config-lvm`  oferuje graficzny interfejs do zarządzania LVMs. Program jest uruchamiany jako root:

~~~  
apt-get install system-config-lvm  
man system-config-lvm `# lekturą obowiązkową`   
~~~

##### Więcej informacji:

+  [Administracja Debian - Krótkie wprowadzenie do pracy z LVM (angielski)](http://www.debian-administration.org/articles/410)   
+  [IBM - Zarządzanie woluminów logicznych (angielski)](http://www.ibm.com/developerworks/linux/library/l-lvm2/)   
+  [IBM - Zmiana rozmiaru partycji Linux - Część 2 (angielski)](http://www.ibm.com/developerworks/linux/library/l-resizing-partitions-2/index.html)   
+   [Red Hat - Przewodnik administracji LVM (angielski)](http://docs.google.com/viewer?a=v&amp;q=cache:1RMpacheCBcJ:www.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/5.4/pdf/Logical_Volume_Manager_Administration.pdf+%22Logical+Volume+Manager+Administration+%22&amp;hl=en&amp;pid=bl&amp;srcid=ADGEEShRiptIjzsnPNsCs4RgyUFNWkYcrDc3SkBSD6cTq39D6wye5JM3tP_ehcn37I5VWs84I_HI45rvG-n6YG4R2fE8hqDByq-KPhNEkha4zwphrR7QIUVnUz6omwY85e-ZEXX723Js&amp;sig=AHIEtbSJyxEst6Wue7_1_TeDYwB480azEw)   
+   [Logical Volume Manager (Linux)(angielski)](http://en.wikipedia.org/wiki/Logical_Volume_Manager_%28Linux%29)   
+   [Ustawianie LVM do zabezpieczenia danych (angielski)](http://thelinuxexperiment.com/guinea-pigs/jon-f/setting-up-an-lvm-for-storage/)   
+   [Ustawianie LVM w Linux (angielski)](http://linuxhelp.blogspot.com/2005/04/creating-lvm-in-linux.html)   
+   [Linux LVM - Logical Volume Manager (angielski)](http://www.linuxconfig.org/Linux_lvm_-_Logical_Volume_Manager)   

<div id="rev">Page last revised 26/07/2011 2325 UTC</div>
