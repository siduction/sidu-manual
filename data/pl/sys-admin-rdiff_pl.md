<div id="main-page"></div>
<div class="divider" id="rdiff"></div>
## Tworzenie kopii zapasowej przy pomocy rdiff-backup

rdiff-backup jest narzędziem do robienia kopii zapasowej twoich plików. (Może działać na wielu różnych portach *nix ).

**`Uruchamiaj polecenia jako root w konsoli, chyba że instrukcje będą inne.`**

*świetne do przywrócenia systemu po nieudanej aktualizacji systemu, kernela itp. (i także do przywrócenia pojedynczych plików).  
*robi kopię zapasową tego co się zmieniło, tak jak rsync (więc każdy backup nie trwa długo).  
*zachowuje historię zmian (co oznacza, że możesz przywrócić plik, który usunąłeś trzy tygodnie temu!)  
*zabezpiecza backupy poprzez sieć (używając ssh).  
*tworzy kopię partycji, gdy są zamontowane (więc łatwo zautomatyzować codzienny backup ... nie potrzebne odmontowywanie).  
*Może odzyskać wszystko, jeśli twój twardy dysk zepsuje się i będziesz musiał kupić nowy.  
*skalowalny do tworzenia kopii zapasowej wielkich sieci i jest używany przez przedsiębiorstwa.  
*jest aplikacją linii poleceń, co jest świetne dla tych, którzy wykonują takie zadania jak automatyczne kopie zapasowe (np. skrypty bash uruchamiane przez cron).  
*zapamiętuje i radzi sobie z uprawnieniami plików, a także obsługuje skróty symboliczne, więc kiedy przywrócisz dane, będą one dokładnie w tej samej postaci.

###### Czego potrzebujesz

rdiff-backup przechowuje całą (nieskompresowaną) kopię plików, a także historię (przyrostowe kopie zapasowe), co oznacza, że miejsce do przechowywania twojej kopii zapasowej musi być większe niż to, co chcesz zachować. Jeśli tworzyć kopię 100 GB danych, możesz potrzebować 120 GB przestrzeni (najlepiej na oddzielnym dysku!).

###### Konfiguracja

Załóżmy, że twój pc ma nastepujące parametry:  
* twardy dysk 100 GB (sda), który jest używany, sda1 używany jako partycja główna, sda5 przechowuje muzykę i inne pliki i sda6 to swap.  
* dodatkowy twardy dysk 200 GB (sdb), który nie jest używany, z jedną partycją sdb1, którą użyjemy na kopie zapasowe.  
* Adres IP 192.168.0.1

Najpierw należy zainstalować rdiff-backup:

~~~  
# apt-get install rdiff-backup  
~~~

Chociaż możesz zrobić kopię zapasową dowolnego katalogu, zakładamy, że zrobimy kopię całej partycji. Chcemy zrobić backup sda1 i sda5 (nie chcemy kopii sda6), a więc stworzymy katalogi do przechowywania danych:

~~~  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/root  
# mkdir -p /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

Musisz użyć adresu IP, ponieważ będzie to przydatne przy tworzeniu kopii zapasowej innego komputera (omówione w dalszej części instrukcji).

###### Tworzenie kopii bezpieczeństwa

rdiff-backup używa składni `rdiff-backup katalog-źródłowy katalog-docelowy` . Uwaga: zawsze określaj nazwy katalogów, a nie nazwy plików.

Aby stworzyć kopię sda5, wykonaj polecenie:

~~~  
# rdiff-backup /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

Aby zrobić kopię partycji głównej, uruchom:

~~~  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
~~~

Wszystkie błędy "AF_UNIX path too long" mogą zostać zignorowane. Proces może potrwać chwilę, ponieważ jest to pierwszy raz, kiedy tworzona jest kopia zapasowa, więc rdiff-backup będzie musiał zrobić kopię całej partycji (nie tylko różnice). Zwróć uwagę, że nie robimy kopii /tmp, ponieważ ciągle się zmienia, ani /proc lub /sys, ponieważ one nie zawierają prawdziwych plików, nie chcemy także tworzyć kopii montowanych zasobów. Jeśli zrobiłbyś kopię /media, wtedy robiłbyć kopię sdb1, co doprowadziłoby do nieskończonej pętli! Sposobem na to jest tworzenie backupów osobno.

Powodem, dla którego należy wpisać '/proc/*' zamiast samego '/proc', jest to, że pierwszy wariant będzie tworzył kopię samej nazwy katalogu /proc, a zignoruje wszystko inne. To samo jest prawdziwe dla /tmp, /sys, oraz dla nazw punktów montowania.

W ten sposób, jeśli zniszczysz partycję główną i dokonasz pełnego przywrócenia partycji, /tmp, /proc, /sys i punkty montowania zostaną stworzone (tak jak powinny). Jeśli /tmp nie będzie istniał, kiedy X zostanie uruchomiony, mogą się pojawić komunikaty o błędach (Patrz: strona man, aby zdobyć więcej informacji o --exclude i --include).

###### Przywracanie katalogów z kopii zapasowej

rdiff-backup używa składni:

~~~  
rdiff-backup -r <skąd> <katalog-źródłowy> <katalog-docelowy>  
~~~

Teraz, jeśli przypadkowo skasowałeś katalog /media/sda7/photos, możesz przywrócić go przy pomocy:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5/photos /media/sda5/photos  
~~~

Opcja "-r now" oznacza przywrócenie z ostatniej kopii bezpieczeństwa. Jeśli tworzyłeś backupy okresowo (np. przez crontab), i nie zauważyłeś, że katalog photos zaginął kilka dni temu, będziesz potrzebował dokonać przywrócenia danych z backupu z przed kilku dni (a nie "now", ponieważ otrzymasz komunikat, że katalog photos nie istnieje). A może po prostu chcesz przywrócić wcześniejszą wersję danych.

Jeśli chcesz przywrócić dane z przed 3 dni, użyj opcji "-r 3D", ale zwróć uwagę:

`"3D" odnosi się do 72 godzin przed czasem obecnym i jeśli nie było żadnego backupu zrobionego w tym czasie, rdiff-backup przywróci stan z wcześniejszego backupu. Na przykład, w powyższym przypadku, jeśli użyta jest opcja "3D" i będą tylko kopie z przed 2 dni i z przed 4 dni, katalog zostanie przywrócony ze stanu z przed 4 dni (więc musisz myśleć o tym przed przywróceniem danych).`

Aby zrobić listę backupów zrobionych dla sda5, wykonaj polecenie:

~~~  
# rdiff-backup -l /media/sdb1/rdiff-backups/192.168.0.1/sda5  
~~~

##### Przywracanie partycji

Możesz także przywrócić całą partycję, przecież punkt montowania jest po prostu katalogiem.

**`UWAGA: Nie przywracaj partycji głównej, kiedy uruchomiłeś z niej system! Przy pomocy jednego polecenia stracisz wszystkie pliki na wszystkich partycjach, włączając w to wszystkie backupy na oddzielnym twardym dysku!! rdiff-backup robi dokładnie to, o co jest proszony. Jeśli backup dla partycji głównej ma puste punkty montowania, aby przywrócić zachowane dane, skasuje wszystko na zamontowanych napędach, żeby wszystko było identyczne z backupem.`**

Aby przywrócić sda5 z ostatniego backupu, po prostu wpisujemy:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/sda5 /media/sda5  
~~~

##### Przywracanie partycji głównej

Przywracanie partycji głównej nie jest takie łatwe. Nie przywracaj partycji głównej, gdy jest zamontowana (patrz powyższe ostrzeżenie). Naprawdę użyteczna jest możliwość przywrócenia partycji głównej, kiedy zepsujesz coś przy instalacji/aktualizacji czy instalowaniu nowego kernela, a przywrócenie stanu poprzedniego potrwa tylko 20 minut.

Jedną z metod przywrócenia partycji głównej jest start z dodatkowej partycji linuksowej, jeśli masz taką na twardym dysku. Wtedy będziesz mógł przywrócić partycję główną, ponieważ nie będzie zamontowana jako root ("/"). Po przywróceniu partycji, wystartuj z niej, a będzie dokładnie taka sama jak poprzednio! To jest najprostsza metoda.

Inną metodą przywrócenia partycji głównej jest wystartowanie z siduction-live cd. rdiff-backup jest włączony do siduction.org. W przypadku, gdy wersja siduction live-cd, którą posiadasz nie zawiera rdiff, możesz wpisać w linii poleceń gruba (Opcje startowe) "unionfs", co spowoduje, że będziesz mógł instalować aplikacje na live cd. Po prostu wystartuj i wpisz następujące polecenia:

~~~  
$ sudo su  
# wget -O /etc/apt/sources.list http://siduction.org/files/misc/sources.list  
# apt-get update  
# apt-get install rdiff-backup  
~~~

###### Teraz dokonajmy przywrócenia partycji:

~~~  
# mount /dev/sda1 /media/sda1  
# mount /dev/sdb1 /media/sdb1  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

Uwaga: Jeśli nie masz siduction CD i twoje Live-CD wspiera klik, możesz zainstalować przy użyciu Klik:

~~~  
$ sudo ~/.zAppRun ~/Desktop/rdiff-backup_0.13.4-5.cmg rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root /media/sda1  
~~~

Zaleca się, aby każdy, kto tworzy kopię zapasową partycji głównej (z intencją przywrócenia jej, jeśli zajdzie taka potrzeba) powinien przetestować proces przywracania. 

If the hard drive has been changed or reformatted, recheck the UUIDs, (or Labels), in `/boot/grub/menu.lst (grub-legacy) or files in /etc/grub.d (grub2)t`  and `/etc/fstab` , and alter accordingly. An easy way to get the information to alter the menu.lst and fstab files, if required, is as root:

~~~  
blkid  
~~~

##### Tworzenie kopii zapasowej dysku innego komputera

Możesz tworzyć kopie zapasowe dysku innego komputera na twoim komputerze, jeśli lokalny komputer może połączyć się z innym przy pomocy ssh (i jeśli masz wolne miejsce na lokalnym komputerze). Serwer ssh (sshd) musi działać na zdalnym pc. Drugi komputer nie musi być w lokalnej sieci.

Załóżmy, że zdalny komputer posiada:  
1) dysk twardy 100 GB (sda), który jest w użyciu, z zamontowanymi zasobami,  
2) sda1 użyte jako partycja główna,  
3) sda5 przechowuje niektóre pliki tymczasowe, których nie chcemy zachowywać,  
4) i sda6 na swap  
5) adres IP to 192.168.0.2

Uwaga: oba dyski 100 GB nie mogą mieć kopii zapasowej na 200 GB dysku przy użyciu rdiff-backup (ponieważ nie będzie miejsca na przyrostowe pliki), ale ponieważ nie robisz kopii sda5 na zdalnym pc (i ponieważ twarde dyski nie są zwykle pełne, chociaż nie polegaj na tym) to możesz założyć, że jest wystarczająco miejsca. Za każdym razem, kiedy rdiff-backup wykona kolejny backup, coraz więcej przyrostowych plików będzie tworzone, i zajmie to coraz więcej miejsca.

Możesz nakazać rdiff-backup, aby zachowywał jedynie backupy nie starsze niż 1 miesiąc (polecenie to będzie pokazane później), a wtedy mniej miejsca będzie wykorzystane na pliki przyrostowe. 

Pierwszą rzeczą jest zainstalowanie rdiff-backup na zdalnej maszynie (każdy komputer, którego dysku chcesz wykonać kopię zapasową musi mieć zainstalowany rdiff-backup).

Aby zrobić kopie zapasową zdalnego pc na lokalnym, uruchom na lokalnym pc (np. 192.168.0.1): `Zwróć uwagę na użycie podwójnych dwukropków ::` 

~~~  
# mkdir /media/sdb1/rdiff-backups/192.168.0.2/root  
# rdiff-backup --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' 192.168.0.2::/ /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Teraz, jeśli chcesz przywrócić katalog na zdalnym pc, uruchom przywracanie albo na lokalnym, albo na zdalnym komputerze.

Tak przywrócisz katalog /usr/local/games na zdalnym komputerze, inicjując proces ze zdalnego komputera:

~~~  
# rdiff-backup -r now 192.168.0.1::/media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games /usr/local/games  
~~~

Tak przywrócisz katalog /usr/local/games na zdalnym komputerze, inicjując proces z lokalnego komputera:

~~~  
# rdiff-backup -r now /media/sdb1/rdiff-backups/192.168.0.1/root/usr/local/games 192.168.0.2::/usr/local/games  
~~~

Użyj taką samą składnię, kiedy przywracasz partycję główną z live cd (zdalny pc został uruchomiony przy pomocy live cd - patrz powyżej).

##### Automatyczne kopie bezpieczeństwa:

Jeśli wykonujesz kopie bezpieczeństwa innego komputera na swojej lokalnej maszynie, najpierw uaktywnij bezhasłowe logowanie ssh przy użyciu kluczy ssh. **`Zwróć uwagę, że mowa o bezhasłowym logowaniu ssh jako root. Można to zrobić w ten sposób, by tylko polecenie rdiff-backup było wykonywane, ale ta kwestia jest poza tematem tej instrukcji - patrz  [Konfiguracja SSH](ssh-pl.htm#ssh-s) `**  Zakładamy pełne zaufanie i ustawimy najprostszy sposób osiągnięcia bezhasłowego logowania ssh.

Z lokalnego pc, wykonaj następujące polecenie:

~~~  
# [ -f /root/.ssh/id_rsa ] || ssh-keygen -t rsa -f /root/.ssh/id_rsa  
~~~

I wciśnij dwa razy enter dla braku hasła. Następnie wykonaj polecenie:

~~~  
# cat /root/.ssh/id_rsa.pub | ssh 192.168.0.2 'mkdir -p /root/.ssh;\<!--dunno if this is wrong-->  
> cat - >>/root/.ssh/authorized_keys2'  
~~~

Zostaniesz poproszony o hasło roota.

Teraz możesz uruchomić ssh na zdalnym komputerze jako root bez wpisywania hasła i rdiff-backup może być automatyzowany.

Następnie, stwórz skrypt basha, który zawiera wszystkie polecenia rdiff-backup. Nasz skrypt basha może wyglądać tak:

~~~  
#!/bin/bash  
RDIFF=/usr/bin/rdiff-backup  
echo  
echo "=======Backing up 192.168.0.1 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' / /media/sdb1/rdiff-backups/192.168.0.1/root  
echo "(and purge increments older than 1 month)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/root  
echo  
echo "=======Backing up 192.168.0.1 mount sda5======="  
${RDIFF} --ssh-no-compression --exclude /media/sda5/myjunk /media/sda5 /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo "(and purge increments older than 1 months)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.1/sda5  
echo  
echo "=======Backing up 192.168.0.2 root======="  
${RDIFF} --ssh-no-compression --exclude '/tmp/*' --exclude '/proc/*' --exclude '/sys/*' --exclude '/media/*/*' --exclude '/mnt/*/*' 192.168.0.2::/media/sdb1/rdiff-backups/192.168.0.2/root  
echo "(and purge increments older than 1 months)"  
${RDIFF} --remove-older-than 1M --force /media/sdb1/rdiff-backups/192.168.0.2/root  
~~~

Teraz możesz nazwać ten skrypt "myrdiff-backups.bash" i umieścić go /usr/local/bin na naszej lokalnej maszynie (backup serwer) i nadać mu atrybut wykonywalności. Uruchom skrypt i sprawdź, czy działa.

Na koniec możesz przy użyciu crona uruchamiać go każdego wieczora o 20:00. Następująca linia w crontabie roota będzie mieć ten skutek:

~~~  
# crontab -e  
i wpisz następującą linię  
0 20 * * * /usr/local/bin/myrdiff-backups.bash  
~~~

<div id="rev">Content last revised 14/08/2010 0100 UTC</div>
