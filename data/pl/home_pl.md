<div id="main-page"></div>
<div class="divider" id="home-bu"></div>
## Tworzenie kopii zapasowej folderów domowych

Przed przeniesieniem `/home`  powinieneś utworzyć jego kopię zapasową. Można tego dokonać tworząc paczkę tar skompresowaną programem gzip. Aby to zrobić jako root wykonaj: 

~~~  
tar cvzpf gdzieś/home.tar.gz /home  
~~~

Aby rozpakować:

~~~  
tar xvpf gdzieś/home.tar.gz  
~~~

 [Alternatywną metodą tworzenia kopii zapasowej jest wykorzystanie rdiff.](sys-admin-rdiff-pl.htm) 

<!-- [Kilka ciekawych uwag dotyczących przywracania folderów domowych po świeżej instalacji można znaleźć tutaj.](http://wiki.siduction.de/index.php?title=Installation_auf_einer_verschl%C3%Bcsselten_Festplatte) 

-->
<div class="divider" id="home-move"></div>
## Przenoszenie folderów domowych - /home

**`Nie używaj katalogu domowego pochodzącego z innej dystrybucji, gdyż pliki konfiguracyjne mogą konfiliktować z tymi pochodzącymi z siductiona, jeśli używasz tych samych nazw użytkowników na obu dystrybucjach!`** 

Przenoszenie lub używanie isniejącej partycji /home siductiona może być dokonane dwojako, wykorzystując do tego dystrybucję Live, albo systemową linię poleceń. Żaden ze sposobów nie jest trudny.

Ponieważ system korzysta z  [UUID](part-uuid-pl.htm) , musisz odczytać uuid nowej partycji.

Najprostszy sposób polega na dodaniu zakomentowanej informacji do pliku `/etc/fstab`  jeszcze przed przemieszczeniem /home.

Podczas startu komputera w polu GRUB-a należy wpisać "1" (bez cudzysłowów) i potwierdzić Enterem. Spowoduje to uruchomienie systemu w trybie init (runlevel) 1, który jest trybem single user i foldery domowe nie są używane.

Po zalogowaniu się na konto administratora (root), należy zamontować nową partycję dla /home, na przykład:

~~~  
mount /dev/sdxX /media/nowy-home  
(lub jakakolwiek inna partycja, na której powstanie nowy /home)  
cp -pr /home /media/nowy-home  
~~~

Następnie trzeba wyedytować plik `/etc/fstab` , aby odzwierciedlić zmianę w systemie : 

~~~  
mcedit /etc/fstab  
~~~

Teraz wystarczy `odkomentować (usunąć znak "#")`  linię odpowiadającą za montowanie nowego /home i `zakomentować (wstawić znak "#")`  linię odpowiadającą za poprzednie /home. Po zapisaniu zmian ( F2 ) i opuszczeniu programu ( F10 ) należy ponownie uruchomić komputer.

<div id="rev">Content last revised 05/09/2010 0830 UTC</div>
