<div id="main-page"></div>
<div class="divider" id="install-crypt"></div>
## Instalacja na zaszyfrowanej partycji cryptroot

**`Uwagi: Istnieje kilka zastrzeżeń co do stosowania tej instrukcji w celu szyfrowania partycji z głównym katalogiem (root) lub partycji z danymi. Są nimi:`**  

+ Można ją stosować do siduction-2010-03-apate i późniejszych.  
+ To jest podstawowy przewodnik z którym można zacząć. Twoją odpowiedzialnością jest dowiedzieć się więcej na temat LUKS, cryptsetupu i szyfrowania. Odnośniki do żródeł i pomocnych zasobów znajdują się na dole tej strony, jednakże ich lista nie jest definitywnie wyczerpująca.  
+ cryptsetup nie potrafi zaszyfrować istniejącej partycji z danymi, dlatego trzeba utworzyć nową partycję, dokonać jej ustawień za pomocą cryptsetup, a następnie przenieść na nią potrzebne dane.  
+ Można także używać plików kluczowych i posiadać wiele kluczy dla danych, (do 8, włączając usuwanie kluczy), co jest już poza zakresem tego poradnika.  
+ `Należy nie zapomninać haseł kluczowych pod rygorem utraty dostępu do wszystkiego! Nawet użycie polecenia chroot bez znajomości haseł kluczowych zda się na nic, za wyjątkiem kartoteki /boot.`   
+ Na wczesnym etapie uruchamiania systemu zostaniesz poproszony o hasło kluczowe szyfrowania i system zostanie uruchomiony zgodnie z oczekiwaniem.  

### Przykłady szyfrowania:

+  [Użycie szyfrowania dla grup woluminów LVM](hd-install-crypt-pl.htm#lvm) .  
+  [Uwagi do szyfrowania dla tradycyjnych sposobów partycjonowania](hd-install-crypt-pl.htm#simple) .  

<div class="divider" id="lvm"></div>
## Szyfrowanie w grupie woluminu LVM

<span class= "highlight-3">Ten przykład stosuje szyfrwewnątrz woluminu LVM dla umożliwienia przyzwolenia na rozdział kartoteki home od <span class= "highlight-2"> / </span> oraz posiadanie partycji wymiany (swap) bez konieczności posiadania wielu haseł i ma zastosowanie do siduction-2010-03-apate i późniejszych.</span>

Przed uruchomieniem instalatora trzeba przygotować systemy plików, które będą używane przy instalacji. Podstawowe wskazówki partycjonowania grup wolumenów LVM, znajdziesz w  [Menedżer Woluminów Logicznych - LVM partycjonowanie](part-lvm-pl.htm#part=lvm) . 

Potrzebna ci będzie co najmniej niezaszyfrowany system plików <span class= "highlight-3">/boot </span> i zaszyfrowany główny system plików <span class= "highlight-2"> / </span> a także utworzenie zaszyfrowananych systemów plików <span class= "highlight-3">/home i swap</span>. 

1. Jeśli nie planujesz użyć istniejącego wolumenu grup lvm, utwórz zwyczajny wolumen grup lvm. Ten przykład zakłada, że wolumen grupy nazwany <span class= "highlight-3">vg</span> będzie zawierał system plików boot i zaszyfrowane dane.  
2. Bedziesz potrzebował logiczny wolumen dla /boot i zaszyfrowanych danych, dlatego użyj <span class= "highlight-3">lvcreate</span> aby utworzyć wolumeny logiczne w wolumenie grup <span class= "highlight-3">vg</span> z żądaną wielkością:  
   ~~~    
   lvcreate -n boot --size 250m vg    
   lvcreate -n crypt --size 300g vg    
   ~~~
  
   Tutaj zostały nazwane wolumeny logiczne boot i crypt z przydzielonymi odpowiednio 250Mb i 300Gb.  
3. Utworzenie systemu plików dla <span class= "highlight-3">/boot</span> będzie dostepne w instalatorze:  
   ~~~    
   mkfs.ext4 /dev/mapper/vg-boot    
   ~~~
  
4. Użyj <span class= "highlight-3">cryptsetup</span> aby zaszyfrować <span class= "highlight-3">vg-crypt</span> przy użyciu szybszej opcji xts posiadającej najwyższej mocy klucz długości 512 bitów a następnie owtórz ją. Zostanie dwukrotnie zadane pytanie o hasło, aby je ustawić, a trzeci raz dla otwarcia. Otwórz ją przy pomocy domyślnych opcji startowych cryptopts wskazując nazwę gałęzi cryptroot:  
   ~~~    
   cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/mapper/vg-crypt    
   ~~~
  
   ~~~    
   cryptsetup luksOpen /dev/mapper/vg-crypt cryptroot    
   ~~~
  
5. Teraz użyj lvm wewnątrz zaszyfrowanego urządzenia aby utworzyć drugi wolumen grupy, który będzie używany dla urzadzeń <span class= "highlight-3">/swap</span> i <span class= "highlight-3">/home</span>. Uzyj <span class= "highlight-3">pvcreate</span> aby cryptroot uczynić wolumenem fizycznym, a następnie użyj <span class= "highlight-3">vgcreate</span> aby utworzyć kolejny wolumen grupy, nazwany tutaj <span class= "highlight-3">cryptvg</span>:  
   ~~~    
   pvcreate /dev/mapper/cryptroot    
   vgcreate cryptvg /dev/mapper/cryptroot    
   ~~~
  
6. Nastepnie użyj <span class= "highlight-3">lvcreate</span> dla nowo zaszyfrowanego wolumenu grup <span class= "highlight-3">cryptvg</span> aby utworzyć wolumeny logiczne <span class= "highlight-2"> / </span>, <span class= "highlight-3">/swap</span> i <span class= "highlight-3">/home </span> o potrzebnych wielkościach:  
   ~~~    
   lvcreate -n swap --size 2g cryptvg    
   lvcreate -n root --size 40g cryptvg    
   lvcreate -n home --size 80g cryptvg    
   ~~~
  
   Oto zostały nazwane wolumeny logiczne swap, root i home i ustanowione odpowiednio jako 2Gb, 40Gb i 80Gb.  
7. Utwórz systemy plików dla cryptvg-swap, cryptvg-root i cryptvg-home tak aby dostępne w instalatorze:  
   ~~~    
   mkswap /dev/mapper/cryptvg-swap    
   mkfs.ext4 /dev/mapper/cryptvg-root    
   mkfs.ext4 /dev/mapper/cryptvg-home    
   ~~~
  
8.  **W tym momencie istnieje gotowość aby uruchomić instalator z użyciem:**   
   <span class= "highlight-3">vg-boot</span> dla <span class= "highlight-3">/boot</span>,  
   <span class= "highlight-3">cryptvg-root</span> dla <span class= "highlight-2"> /</span>,  
   <span class= "highlight-3">cryptvg-home</span> dla <span class= "highlight-3">/home</span>,  
   i <span class= "highlight-3">cryptvg-swap</span> dla <span class= "highlight-3">swap</span> co powinno być automatycznie rozpoznane.  

Instalację kończymy linią komendy jądra z załączeniem następujących opcji:

~~~  
root=/dev/mapper/cryptvg-root cryptopts=source=/dev/mapper/vg-crypt,target=cryptroot,lvm=cryptvg-root  
~~~

Teraz masz crypt i boot pod wolumenem grup lvm - vg oraz root, home i swap wewnątrz wolumenu grup lvm - vgcrypt, który jest zaszyfrowanym urządzeniem wewnętrznie zabezpieczonym hasłem.

~~~  
cryptsetup luksOpen /dev/mapper/cryptvg-root cryptvg  
vgchange -a y  
~~~

<div class="divider" id="simple"></div>
## Uwagi co do szyfrowania dla tradycyjnych metod partycjonowania

Najpierw zdecyduj się jakiego chcesz układu dysku. Będziesz potrzebował co najmniej 2 partycje, normalną partycję dla `/boot`  i jedną dla danych zaszyfrowanych. 

Zakładając, że będziesz potrzebował partycji danych (która także powinna być zaszyfrowana) potrzebna będzie trzecia partycja i potrzeba oddzielnego wprowadzenia hasła dla niej (swap) podczas startu systemu (dlatego pojawi się podwójne żądanie wprowadzenia hasła). 

Możliwe jest stosowanie kluczy dla partycji wymiany (swap) od wewnątrz szyfrowanego systemu z tradycyjnym partycjonowaniem, jednak nie będziesz mógł wstrzymać systemu (suspend) na dysku. Ze względu na te problemy, lepszym rozwiązaniem na dłuższą metę jest użycie woluminów LVM z w pełni szyfrowanymi partycjami i kluczami. 

<!--It is possible to use keys for the swap from inside the encrypted system with traditional partitioning, however you will not be able to suspend to disk. Due to these issues, LVM volumes with fully encrypted partitions with keys is definitely the better option in the long term.

-->
###### Podstawowe założenia:

+  Istnieją tylko 3 zwykłe partycje na tym dysku:  
   `/boot` , z 250mb  
   `swap` , z 2 gig  
   **`/`**  i `/home`  połączone (dla przykładu, równoważne).  

Teraz, gdy już zostało wykonane partycjonowanie, należy przygotować szyfrowane partycje tak, by zostały one rozpoznane przez instalatora. 

Jeśli był używany program do partycjonowania z GUI, należy go zamknąć i otworzyć terminal, ponieważ polecenia szyfrowania muszą być wykonane z linii poleceń. 

##### Partycja /boot

Utwórz na partycji `/boot`  system plików ext4, jeśli to nie zostało już zrobione:

~~~  
/sbin/mkfs.ext4 /dev/sda1  
~~~

##### Zaszyfrowana partycja swap

Dla `zaszyfrowanej partycji swap`  musisz najpierw sformatować i otworzyć urządzenie w trybie raw, `/dev/sda2` , jako urządzenie zaszyfrowane, podobnie jak urządzenie vg-crypt powyżej, lecz otwierając je pod inną nazwą - swap.


cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda2  
</li>  
~~~

~~~  
cryptsetup luksOpen /dev/sda2 swap  
</li>  
~~~

~~~  
echo "swap UUID=$(blkid -o value -s UUID /dev/sda2) none luks" >> /etc/crypttab  
</li>  
~~~

</ol>
Dokonaj formatu utworzonego `/dev/mapper/swap`  tak, aby został rozpoznany przez instalatora:

~~~  
/sbin/mkswap /dev/mapper/swap  
~~~

##### Zaszyfrowana partycja /

Dla `zaszyfrowanej partycji /`  musisz najpierw sformatować i otworzyć urządzenie w trybie raw, `/dev/sda3` , jako urządzenie zaszyfrowane, podobnie jak urządzenie vg-crypt powyżej.

~~~  
cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda3  
~~~

~~~  
cryptsetup luksOpen /dev/sda3 cryptroot  
~~~

Dokonaj formatu utworzonego `/dev/mapper/cryptroot`  tak, aby został rozpoznany przez instalatora:

~~~  
/sbin/mkfs.ext4 /dev/mapper/cryptroot  
~~~

### Uruchomienie instalatora

 **Teraz jesteś gotowy do uruchomienia instalatora, gdzie powinieneś użyć:**   
<span class= "highlight-3">sda1</span> dla <span class= "highlight-3">/boot</span>,  
<span class= "highlight-3">cryptroot</span> dla <span class= "highlight-2"> /</span> oraz <span class= "highlight-3"> /home</span>  
<span class= "highlight-3">swap</span> powinien zostać rozpoznany automatycznie.

Instalacja powinna zakończyć się linią poleceń jądra, z następującymi opcjami (z użyciem twojego UUID): 

~~~  
root=/dev/mapper/cryptroot cryptopts=source=UUID=12345678-1234-1234-1234-1234567890AB,target=cryptroot  
~~~

Teraz masz /boot na zwykłej partycji, zaszyfrowaną hasłem partycję wymiany (swap) oraz zaszyfrowane root i /home. 

### Źródła i zasoby

Wymagana literatura:

~~~  
man cryptsetup  
~~~

 [LUKS](http://code.google.com/p/cryptsetup/) .

 [Redhat](http://www.redhat.com/)  and  [Fedora](http://www.redhat.com/Fedora/) .

 [Protect Your Stuff With Encrypted Linux Partitions](http://www.enterprisenetworkingplanet.com/netsecur/article.php/3683011) .

 [KVM how to use encrypted images](http://blog.bodhizazen.net/linux/kvm-how-to-use-encrypted-images/) .

 [siduction wiki](http://wiki.siduction.de/index.php?title=Installation_auf_einer_verschl%C3%Bcsselten_Festplatte) .

<div id="rev">Page last revised 06/09/2011 0920 UTC</div>
