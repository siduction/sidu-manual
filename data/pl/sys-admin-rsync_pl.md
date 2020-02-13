<div id="main-page"></div>
<div class="divider" id="rsync"></div>
## Kopia zapasowa przy pomocy rsync

rsync is a tool used to backup and synchronise your files. (It can be run on a variety of *nix ports).

**`Jednym z ograniczeń rsync jest to, że nie może kopiować ze zdalnego systemu na inny zdalny system. Jeśli chcesz to zrobić, to będziesz musiał skopiować dane ze zdalnego systemu na lokalny, a następnie z lokalnego na drugi zdalny.`**

With siduction you have choices how to initiate the proccess, DIY or via a deb package in Debian sid:

##### For the deb package:

~~~  
apt-get install luckybackup  
~~~

 [Homepage of luckybackup.](http://luckybackup.sourceforge.net/) 

###### What follows from here is the DIY version

Instrukcja ta da ci wiedzę na temat działania programu rsync, przedstawione zostaną także przykładowe zastosowania, które przydadzą się do stworzenia własnego skryptu tworzenia kopii zapasowej.

rsync jest bardzo łatwym w użyciu programem do tworzenia kopii zapasowych, może też robić backup plików i katalogów. Jest to realizowane przy pomocy bardzo sprytnej procedury sprawdzania, kiedy pliki były zmieniane, bowiem tylko takie pliki wybrane są do kopiowania. rsync używa także narzędzia kompresującego do przyspieszenia procesu kopiowania <span class=" highlight-3">(jeśli wywołany z opcją -z)</span>. Jego działanie może być wyjaśnione bardzo łatwo:

Program rsync wykrywa pliki i katalogi, które muszą być kopiowane, ponieważ jeden lub więcej z ich atrybutów się zmienił (na przykład data/czas ostatniej modyfikacji, lub wielkość pliku), w obu przypadkach, coś nie jest już takie same, jak wcześniejsza kopia zapasowa. Wybór ten jest bardzo szybki.

Kiedy rsync skończy tworzenie listy plików, kopia zmienionych plików robiona jest o wiele szybciej, ponieważ wykonywana jest procedura kompresji podczas procesu kopiowania. rsync kompresuje przed wysłaniem i dekompresuje na końcu, “w locie”.

rsync może kopiować pliki z:  
* lokalnego systemu do lokalnego systemu,  
* lokalnego systemu do zdalnego systemu,  
* zdalnego systemu do lokalnego systemu.

Używa do tego albo domyślnego klienta  [ssh](ssh-pl.htm) , albo działającego demona rsync na obu systemach: źródłowym i docelowym. Strona man rsync stwierdza, że jeśli możesz połączyć się przy pomocy ssh, to rsync również będzie w stanie z niego skorzystać.

`Jednym z ograniczeń rsync jest to, że nie może kopiować ze zdalnego systemu na inny zdalny system. Jeśli chcesz to zrobić, to będziesz musiał skopiować dane ze zdalnego systemu na lokalny, a następnie z lokalnego na drugi zdalny.`

Aby dać przykład, powiedzmy, że mamy trzy systemy;

~~~  
neo – lokalny system  
morpheus – zdalny system  
trinity – zdalny system  
~~~

Masz zamiar użyć rsync do kopiowania katalogów /home/[user]/Data. Każdy system jest "własnością" określonego użytkownika, innymi słowy, określony użytkownik używa systemu w specjalny sposób, więc ten system powinien być "źródłem" dla dwóch pozostałych systemów. rsync jest uruchamiany tylko na lokalnym systemie - neo:

~~~  
głównym użytkownikiem neo jest cuddles,  
głównym użytkownikiem morpheusa jest tartie i  
głównym użytkownikiem trinity jest taylar.  
~~~

Więc, chciałbyś zrobić kopię zapasową, lub synchronizację, następującego:

~~~  
z komputera neo, katalog /home/cuddles/Data na komputery: morpheus i trinity,  
z komputera morpheus, katalog /home/tartie/Data na komputery: neo i trinity,  
z komputera trinity, katalog /home/taylar/Data na komputery: neo i morpheus.  
~~~

Problemem rsync jest to, że nie jest w stanie skopiować z jednego zdalnego systemu na drugi zdalny, w tym przykładzie, kiedy będziemy chcieli skopiować trinity do morpheusa, lub morpheusa do trinity (oba źródła i cele są zdalne) np.

~~~  
neo --> morpheus – w porządku, lokalny do zdalnego  
neo --> trinity – w porządku, lokalny do zdalnego  
morpheus --> neo – w porządku, zdalny do lokalnego  
trinity --> neo – w porządku, zdalny do lokalnego  
morpheus --> trinity – zdalny do zdalnego - nie działa  
trinity --> morpheus – zdalny do zdalnego - nie działa  
~~~

Aby ominąć te ograniczenie, musisz zmienić schemat działania. Następująca procedura rozwiąże problem:

~~~  
morpheus --> trinity – zmieniamy na: morpheus --> neo & neo --> trinity  
trinity --> morpheus – zmieniamy na: trinity --> neo & neo --> morpheus  
~~~

Jest to dodatkowy krok, ale uwzględniając to, że chcesz mieć te pliki również na neo, to tylko zmiana źródła pochodzenia plików. Zakłada się, że nasze kopie zapasowe są poprawne i niczego nie brakuje.

`Te ograniczenie rsync musi być brane pod uwagę, kiedy projektuje się proces tworzenia kopii zapasowej.`

##### Użycie nazw hostów w rsync

Jak opisano powyżej, użycie neo, morpheusa, lub trinity w tłumaczeniu fizycznego adresu IP, jest łatwym sposobem, aby zapis był o wiele bardziej czytelny. Uzyskanie możliwości korzystania z nazw hostów jest bardzo proste.

Edytuj plik /etc/hosts, i dodaj nazwy hostów i adresy IP, które się do nich odnoszą. To jest kilka linii /etc/hosts ukazującą translację adresów:

~~~  
192.168.1.15 neo  
192.168.1.16 morpheus  
192.168.1.17 trinity  
~~~

Pierwsza linia tłumaczy adres IP 192.168.1.15 na nazwę “neo”, druga - 192.168.1.16 na nazwę “morpheus” i ostatnia - 192.168.1.17 na nazwę “trinity”. Po dodaniu powyższego i zapisaniu pliku /etc/hosts, możesz używać nazwy zamiast adresu IP, albo możesz dalej używać adresu IP. Rozwiązanie to jest szczególnie przydatne, kiedy zmienisz adres IP. Aby dać przykład takiej zmiany, powiedzmy, że neo zmienia swój adres IP z 192.168.1.15 na 192.168.1.25

Jeśli wszystkie twoje skrypty używają adresu IP, będziesz musiał znaleźć wszystkie wystąpienia adresu i zmienić je na nowy. Jeśli, z drugiej strony, twoje skrypty będą używały nazwy, wystarczy, że zmienisz plik /etc/hosts, aby odzwierciedlał zmianę i wszystkie twoje skrypty będą działać. To może być bardzo przydatne jeśli masz wiele skryptów, które łączą się z innymi systemami, lub vice-versa. Metoda "nazwy” czyni twoje skrypty łatwiejsze w czytaniu, ponieważ nie używasz adresu IP, ale rozpoznawalną nazwę skojarzoną z IP.

#### Dwa sposoby korzystania z rsync.

Jeden ze sposobów to  **“pchanie”**  plików do celu, a drugi to  **“ciągnięcie”**  ich ze źródła. Każdy posiada swoje zalety i kilka wad. Spójrzmy na każdy z nich (załóżmy, że jeden z systemów jest lokalny, a drugi zdalny. W ten sposób, powinieneś łatwiej zrozumieć terminologię)

 **“pchanie”**  - lokalny system posiada pliki źródłowe i katalogi, a docelową lokalizacją jest zdalny system. Polecenie rsync jest uruchamiane na lokalnym systemie i “pcha” pliki do docelowego systemu.

Zalety:  
* Możesz zrobić kopię zapasową więcej niż jednego systemu na jednym docelowym systemie.  
* Proces tworzenia kopii zapasowej jest dystrybuowany na wszystkie systemy komputerowe.  
* Jeśli jeden z systemów jest szybszy niż inne, może skończyć przed nimi i wykonywać inne zadania.

Wady:  
* Jeśli używasz skryptu i zaplanujesz jego wykonanie przy pomocy crona, będzie to wymagało aktualizacji i zmiany wielu crontabów na każdym systemie, jak również aktualizacji wielu wersji skryptu.  
* Twój backup nie może sprawdzić, czy system docelowy ma zamontowaną docelową partycję i może próbować tworzyć kopię bez żadnego celu.

 **“ciągnięcie”**  - zdalny system ma pliki źródłowe i katalogi i docelowa lokalizacja jest na lokalnym systemie. Polecenie rsync jest wykonywane na lokalnym systemie i "ściąga" pliki ze źródłowego systemu.

Zalety:  
* Jeden system jest serwerem, kontroluje wszystkie backupy dla wszystkich innych systemów. Centralizacja kopii zapasowych.  
* jeśli używasz skryptu, jest on umieszczony na jednym systemie i aktualizacja i modyfikacja jest prosta. Umożliwia to także kontrolowanie tylko jednego pliku crontab do planowania wywoływania skryptu.  
* Twój skrypt może sprawdzić i zamontować, jeśli to będzie konieczne, docelową partycję.

###### Składnia rsync:

~~~  
rsync [OPTION]... SRC [SRC]... DEST  
rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST  
rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST  
rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST  
rsync [OPTION]... SRC  
rsync [OPTION]... [USER@]HOST:SRC [DEST]  
rsync [OPTION]... [USER@]HOST::SRC [DEST]  
rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]  
~~~

##### Działające przykłady polecenia rsync:

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Przyjrzyjmy się częściom tego polecenia:

~~~  
ścieżka do źródła: morpheus:/home/tartie  
a celem jest: /media/sda7/SysBackups/morpheus/home  
~~~

wszystko z /home/tartie... będzie skopiowane w /media/sda7/SysBackups/morpheus/home, co będzie wyglądało tak:

~~~  
/media/sda7/SysBackups/morpheus/home/tartie...  
~~~

Należy zwrócić uwagę, że jedynym powodem, dla którego /tartie jest w /home, jest określenie celu, a nie istnienie katalogu w systemie źródłowym. “Źródło” jedynie wybiera, skąd pliki pochodzą, nie gdzie podążają. "Cel” informuje rsync, gdzie umieścić pliki, które otrzymuje ze “źródła”. Weź następujący przykład:

~~~  
rsync [...] /home/user/data/files /media/sda7/SysBackups/neo  
~~~

W powyższym poleceniu tylko katalog źródłowy /files, i to co poniżej niego, będzie w docelowym katalogu /neo – a nie to /media/sda7/SysBackups/neo/home/user/data/files

Upewnij się, że rozważyłeś te zasady, kiedy tworzysz kopię zapasową przy pomocy rsync.

##### Wyjaśnienie opcji:

~~~  
-a jest używane w trybie archiwizującym. Na stronie man jest ona wyjaśniona jako  
“sposób na zrobienie kopii zapasowej rekursywnie i na zachowanie 'prawie' wszystkiego".  
Wspomina się jeszcze, że nie są zachowane hardlinki ze względu na złożoność przetwarzania.  
Opcja -a jest równoważna następującej: -rlptgoD, która oznacza:  
-r = recursive – przetwarzaj podkatalogi i pliki znalezione w lokalizacji źródłowej.  
-l = links – jeśli zostaną napotkane dowiązania symboliczne, odtwórz je w docelowej lokalizacji.  
-p = permissions – informuje rsync, aby ustawił docelowe uprawnienia tak jak w źródle.  
-t = times – informuje rsync, aby ustawił docelowe czasy na takie jak w źródle.  
-q = quiet – informuje rsync, aby komunikatywność programu była minimalna,  
chociaż możemy dodać poziom komunikatywności programu przy pomocy -v.  
Aby proces był zupełnie "cichy”, usuń “v” z powyższego polecenia.  
-o = owner – informuje rsync, że jeśli jest uruchomiony jako root, ma ustawić właściciela plików na tego samego, co w źródle.  
-D = jest to ekwiwalent dwóch poleceń: --devices --specials  
--devices = powoduje, że rsync transferuje pliki urządzeń do zdalnego systemu, aby je później odtworzyć.  
Niestety, jeśli nie dołączysz także opcji --super w tej samej linii poleceń, nie da żadnego efektu.  
--specials = powoduje, że rsync transferuje pliki specjalne takie jak nazwy gniazd i kolejki.  
-g jest używane, aby zachować “grupę” źródłowego pliku.  
-E jest używane, aby zachować atrybut “wykonywalny” źródłowego pliku.  
-v jest używany, aby zwiększyć komunikatywność programu. Po tym, jak jesteśmy pewni,  
że wykonujemy kopię zapasową tego, co chcemy, opcja “v” może być usunięta.  
Ja zachowałem ją, ponieważ uruchamiam proces z crona i chcę "widzieć", co zrobił.  
-z jest używany, aby kompresować dane, które musi “przenieść” lub skopiować, opcja czyni  
proces kopiowania szybszym, ponieważ dane przenoszone są mniejsze niż ich rzeczywisty rozmiar.  
--delete-after = docelowe pliki/katalogi, których już nie ma w źródle są  
kasowane po transferze, nie przed. To “after” (przed) jest używane w przypadku problemów  
lub awarii, a “delete” (usuń) jest używane, aby usunąć docelowe pliki, które już  
nie istnieją na źródłowym systemie.  
--exclude = wzór używany do wyłączenia plików lub folderów. W przykładzie  
--exclude=“*~” zostaną wyłączone wszystkie pliki lub katalogi kończące się  
znakiem “~” z kopii zapasowej. Tylko jeden wzór może być umieszczony w poleceniu  
przy pomocy opcji --exclude, więc jeśli potrzebujesz więcej niż jeden, musisz  
dołączyć dodatkowe linie do polecenia.  
~~~

Dodatkowo, są inne, użyteczne opcje polecenia:

~~~  
-c – które dodaje poziom porównywania danych ze źródła i celu, po procesie kopiowania,  
ale zwiększa to czas kopiowania, a rsync już wykonuje porównania źródła i celu w czasie przetwarzania,  
więc ta opcja nie jest dołączona z powodu wydłużenia procesu i jest formą dodatkowego zabezpieczenia, które nie jest konieczne.  
--super – który, jak opisuje to strona man, próbuje wykonywać czynności administratora na docelowym systemie  
--dry-run – pokaże, co zostałoby transferowane. Opcja jest podobna do  
-s stosowanej z apt-get install, lub apt-get dist-upgrade.  
~~~

Resztą naszego polecenia jest źródłowy plik/katalog i nasz katalog docelowy.

##### Przykładowe polecenia:

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

To polecenie dokona backupu wszystkich plików i katalogów w /home/tartie na systemie nazywanym “morpheus” i umieszczonych w katalogu /media/sda7/SysBackups/morpheus/home – zachowując strukturę katalogów z katalogu tartie.

~~~  
rsync -agEvz --delete-after --exclude=”*~” /home/tartie neo:/media/sda7/SysBackups/morpheus/home  
~~~

To polecenie jest przeciwieństwem poprzedniego, będzie “pchać” katalog /home/tartie, jego zawartość i podkatalogi do systemu nazwanego neo do tego samego katalogu – zwróć uwagę, że system jest uważany za zdalny, kiedy użyty jest “:” (dwukropek) przed ścieżką.

~~~  
rsync -agEvz --delete-after --exclude=”*~” /home/cuddles /media/sda7/SysBackups/neo/home  
~~~

To polecenie wykona backup lokalny, zwróć uwagę, że nie ma dwukropka ani po stronie źródła, ani celu. To polecenie zrobi kopię zapasową lokalnie katalogu /home/cuddles na tym samym systemie w katalogu /media/sda7/SysBackups/neo/home.

Zobaczmy, jak wygląda polecenie rsync z wieloma wyłączeniami:

~~~  
rsync -agEvz --delete-after --exclude=”*~” --exclude=”*.c” --exclude=”*.o” "/*" /media/sda7/SysBackups/neo  
~~~

Powyższe polecenie wykona kopię wszystkiego z katalogu głównego lokalnego systemu i wszystkich jego plików/katalogów, umieszczając dane w katalogu docelowym /media/sda7/SysBackups/neo – a wykluczy wszystkie pliki lub katalogi, które kończą się “~”, “.c”, lub “.o”

**`Poniżej jest przykładowe polecenie rsync, które zakończy się błędem, i którego należy unikać. Jest to przykład polecenia rsync mającego za źródło i cel zdalny system:`**

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie trinity:/home  
~~~

**`Jak wcześniej wspomniano jest to ograniczenie rsync.`**

Ostatnie przykładowe polecenie, zobaczmy jak będzie wyglądać rsync ze zdalnego źródła do lokalnego celu, jeśli zamienimy nazwy hostów adresami IP.

Pierwsze polecenie jest zapisane przy pomocy metody "nazw", a drugie jest równoznaczne, ale przy użyciu adresów IP

~~~  
rsync -agEvz --delete-after --exclude=”*~” morpheus:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

~~~  
rsync -agEvz --delete-after --exclude=”*~” 192.168.1.16:/home/tartie /media/sda7/SysBackups/morpheus/home  
~~~

Jak wyżej wspomniano, nie musisz używać nazw hostów, ale w pierwszym przypadku łatwiej możesz określić, co się dzieje, niż w przypadku drugim.

Teraz powinieneś umieć napisać proste polecenie, albo na podstawie podanych przykładów, albo przez testowanie opisanych parametrów, aby uzyskać to, czego oczekujesz.

<div id="rev">Strona ostatnio modyfikowana 14/08/2010 0100 UTC</div>
