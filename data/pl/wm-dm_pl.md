<div id="main-page"></div>
<div class="divider" id="install-add"></div>
## Kilka użytecznych aplikacji KDE nie preinstalowanych na KDE Lite

 `Możliwe, że potrzebujesz włączyć repozytoria non-free w /etc/apt/sources.list.d/debian.list` 

###### konq-plugins - wtyczki dla Konquerora. 

Pakiet ten zawiera wiele użytecznych wtyczek do Konquerora, menedżer plików, przeglądarkę internetową i przeglądarkę dokumentów dla KDE. Wiele z tych wtyczek pojawi się w menu Narzędzia programu Konqueror.

~~~  
apt-get install konq-plugins  
~~~

Najciekawsze wtyczki do przeglądania stron www to: tłumaczenie strony internetowej, archiwizacja stron internetowych, auto-odświeżanie, analiza strukturalna HTML i css, pasek wyszukiwania, powiadomienia o nowościach, szybki dostęp do często używanych opcji, skryptozakładki, monitor awarii, wskaźnik dostępności mikroformatu, doskonały pasek zakładek i integracja z aKregatorem czytnikiem RSS.

Najciekawsze wtyczki do przeglądania katalogów udostępniają: filtrowanie katalogów, tworzenie galerii zdjęć, kompresję i wypakowanie archiwów, szybkie kopiowanie / przenoszenie, odtwarzacz multimedialny paska bocznego, pasek/metabar informacji o pliku, pomocnika folderu media, graficzny wskażnik użycia dysku, konwersji i transformacji obrazów. 

###### KDE Deskop Search - Narzędzie do wyszukiwania (Nepomuk i Strigi) 

Nepomuk - narzędzie KDE do semantycznego wyszukiwania pulpitu nie jest włączone w siduction-kde.iso. Aby je uzyskać wykonaj:

Instalacja pakietów virtuoso-minimal i strigi-client:

~~~  
apt-get install virtuoso-minimal strigi-client  
~~~

Wejdź do Ustawień &gt; Ustawienia systemowe &gt; Zaawansowane &gt; Zaawansowane ustawienia uzytkownika &gt; Menadżer usług, zaznacz pole `Moduł wyszukiwania Nepomuka` , i kliknj na `Zastosuj` .

W zaawansowanych ustawieniach użytkownika wejdź w &gt; Wyszukiwanie na pulpicie &gt; Podstawowe ustawienia i zaznacz pole `Włącz pulpit semantyczny Nepomuk`  i `Włącz moduł indeksowania plików Strigi` , a następnie kliknij `Zastosuj` . Należy pamiętać, że ilość pamięci przeznaczonej dla bazy danych Nepomuka można regulować w zakładce `Ustawienia zaawansowane` .

Sesja KDE musi zostać zrestartowana, aby usługa indeksowania stała się skuteczna. Należy spodziewać się, że pierwsza iteracja indeksowania może zająć dużo czasu.  [Więcej informacji na temat Nepomuka](http://nepomuk.kde.org/) . 

<div class="divider" id="kde-login"></div>
## Problemy z logowaniem do KDE

Zawartość katalogu /tmp jest normalnie czyszczona przy każdym starcie systemu, więc niektóre katalogi i gniazda potrzebne przez serwer X są także kasowane.

Zwykle, podczas procesu startu systemu, skrypt x11-common dla X-Org odtwarza je.

Możliwe, że skrypty te nie zostały wywołane podczas startu. Aby odtworzyć potrzebne linki uruchom polecenie:

~~~  
# dpkg-reconfigure x11-common  
~~~

KDE potrzebuje 5% alokacji partycji, na której w katalogu /tmp znajdują się na pliki tymczasowe, które powstaną podczas logowania. Jeśli korzystasz z partycji zapełnionej w 95% nie będziesz w stanie zalogować się do KDE i będziesz przemieszczony do tty (terminala).

To samo dotyczy zapętlenia w kdm, nie pozwalającego zalogować się. Rozwiązaniem jest zalogowanie się do tty, dzięki czemu można usunąć i/lub wyczyścić niektóre nie potrzebne już programy i pliki.

Alternatywnie możesz użyć takiego menedżera okien, który nie wymaga tak wiele miejsca w systemie (na przykład fluxbox, który jest już obecny w instalacji siductiona) lub polecenia chroot z siduction live-CD/DVD do czyszczenia partycji, co pozwoli na wystartowanie KDE.

Zajętość 85% jest zalecanym absolutnym maksimum, na partycji, na której KDE uzyskuje dostęp do plików /tmp. (15% wolnego miejsca).

<div class="divider" id="ch-th"></div>
## Instalacja motywów i tematów KDE siductiona

Aby zainstalować najświeższy motyw siductiona na istniejącej instalacji:

~~~  
apt-get install siduction-art-kde-xxxx siduction-art-wallpaper-xxxx  
(Where xxxx is the name of the release for example siduction-art-kde-$release)  
~~~

To zainstaluje tapetę siductiona i tematy.

#### Aby zmienić Tapetę:

`Kliknij prawym klawiszem` na pulpicie i wybierz `Ustawienia Pulpitu` . Po nagłówkiem zatytułowanym `Tapeta`  będzie etykieta nazwana `Obrazek`  która posiada rozwijaną listę dla wyboru tapety do wyświetlenia. Możesz także kliknąć klawisz Open, aby użyć obrazka znajdującego sie w pliku gdziekolwiek na komputerze.

#### Aby zmienić ekran logowania:

Aby zmienić ekran logowania, otwórz najpierw `ustawienia systemowe`  z uprawnieniami roota/administratora:

~~~  
Alt + F2 (aby wywołać krunner)  
~~~

~~~  
kdesu systemsettings  
~~~

Następnie kliknij na `Zaawansowane`  a tam kliknij na `Menedżer Logowania` , idź do zakładki `Tematy`  i wybierz ulubiony temat. `Aby zaktywować nowy Menedżer Logowania potrzebujesz ponownie uruchomić komputer.` .

 [Więcej informacji i linków](http://kde.org)  

<div class="divider" id="xfce-notes"></div>
## Użyteczne dodatki dla Xfce

<div class="divider" id="xfce-notes-1"></div>
### Instalacja szaty graficznej siduction Xfce oraz Tematów

By zainstalować najnowszą szatę graficzną siduction-art należy w konsoli wprowadzić następujące polecenie:

~~~  
apt-get install siduction-art-xfce-xxxx siduction-art-wallpaper-xxxx  
(gdzie xxxx jest nazwą wydania, np. siduction-art-xfce-uranos)  
~~~

W wyniku którego zainstalowane zostaną wybrane temat i tapeta danego wydania siduction. Teraz wystarczy zmienić domyślne ustawienia w Settings menu Xfce.

<!--This will install the siduction wallpaper and themes, then actualise your defaults in the Settings entry point of the xfce menu.

-->
 [Dokumentacja Xfce](http://www.xfce.org/documentation) 

 [Wiki Xfce](http://wiki.xfce.org) 

<div class="divider" id="dm"></div>
## Instalacja innego środowiska pulpitu do już zainstalowanego:

Jeśli kiedykolwiek instalujesz inne środowisko graficzne do bieżącej instalacji (na przykład zainstalowałeś siduction-kde.iso i chcesz zainstalować środowisko graficzne Xfce lub LXDE), to najprawdopodobniej zostanie instalowany wraz z nim menedżer wyświetlania (dm), lub może wymagać on samodzielnego zainstalowania, (gdm, slim lub inny pakiet dm).

Problem polega na tym, że zakończysz w domyślnej konfiguracji poziomu działania (runlevel) Debiana, w związku z czym trzeba będzie zatrzymać X ręcznie w runlevel 3 przed przystąpieniem do dist-upgrade'u.

Rozwiązaniem jest:

~~~  
apt-get update  
apt-get install --reinstall distro-defaults  
update-rc.d <dm> remove  
update-rc.d <dm> defaults  
~~~

Przykład dla `update-rc.d <dm> defaults` , przy tym zwróć uwagę na kropki **`.`**  :

~~~  
update-rc.d kdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d gdm start 24 5 . stop 01 0 1 2 3 4 6 .  
~~~

~~~  
update-rc.d slim start 01 5 . stop 01 0 1 2 3 4 6 .  
~~~

<div class="divider" id="desk-freeze"></div>
## Zawieszenie

W takiej sytuacji nie zawsze musisz skorzystać z przycisku reset. Może to uszkodzić system plików lub doprowadzić do utraty danych. W każdym razie system plików nie będzie czysty po twardym resecie (komunikat: filesystem not clean)

Najpierw spróbuj przejść do konsoli tekstowej `alt-ctl-F1`  albo zrestartować serwer X `alt-ctl-backspace` , (jeśli żadna z tych opcji nie działa, wciąż jest nadzieja):

Klawisz SYSRQ (klawisz Print Scrn, po lewej górnej stronie klawiatury) może pomóc czysto uruchomić ponownie zawieszony system.

Są możliwe następujące sekwencje kombinacji klawiszy:  
*`alt+sysrq+r/`  (powinna przywrócić kontrolę nad klawiaturą)  
*`alt+sysrq+s`  (powoduje synchronizację)  
*`alt+sysrq+e`  (wysyła sygnał term (zakończ) do wszystkich procesów z wyjątkiem init)  
*`alt+sysrq+i/`  (wysyła sygnał kill ("zabij") do wszystkich procesów z wyjątkiem init)(systemy plików są zamontowane tylko do odczytu, zapobiega wywołaniu fsck po ponownym starcie)  
*`alt+sysrq+b/`  (uruchamia ponownie system, bez wcześniejszych kroków jest to twardy reset).

Najlepiej dać każdemu zadaniu kilka sekund, aby upewnić się, że zostało zakończone, np. zakończenie wszystkich procesów może chwilę potrwać. Potrzebne litery mogą być łatwo zapamiętane przy pomocy zdania:  
 **"**`R`** eboot **`S`** ystem **`E`** ven **`I`** f **`U`** tterly **`B`** roken"** 

Inny sposób na zapamiętanie:  
 **"**`R`** aising **`S`** kinny **`E`** lephants **`I`** s **`U`** tterly **`B`** oring"** 

<div id="rev">Page last revised 01/05/2011 1215 UTC </div>
