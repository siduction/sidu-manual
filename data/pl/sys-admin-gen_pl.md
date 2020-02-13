<div id="main-page"></div>
<div class="divider" id="start-services"></div>
## Aktywacja usług w siductionzie

### insserv (Pontos 2008-04 i późniejsze ): Aby wystartować/zatrzymać już zainstalowane usługi:

**`Czytaj `/usr/share/doc/insserv/README.Debian` , uwagi do wydania i opisy w man pages bardzo uważnie:`** 

~~~  
$ man insserv  
$ man invoke-rc.d  
$ man update-rc.d  
google LSB headers  
~~~

Aby wykonać 'start':

~~~  
/etc/init.d/<service> start  
~~~

Aby wykonać 'stop':

~~~  
/etc/init.d/<service> stop  
~~~

Aby wykonać 'restart:

~~~  
/etc/init.d/<service> restart  
~~~

Aby zapobiec uruchamianiu usługi przy starcie systemu

~~~  
update-rc.d <service> remove  
[usunie wszystkie startowe linki]  
~~~

Aby upewnić się, że usługa pracuje przy starcie systemu [nie zawsze potrzebne]

~~~  
update-rc.d <service> defaults  
[utworzy linki startowe]  
~~~

Aby przeczytać listę uruchomionych usług:

~~~  
ls /etc/rc5.d  
~~~

`S`  oznacza wystartowanie usługi.  
`K`  oznacza brak startu.

### Starsze instalacje (przed Pontos 2008-04)

### insserv na zainstalowanych systemach przed Pontos 2008-04

 **`Uwaga: Starsze instalacje nie uruchomią insserv automatycznie, z powodu własnych skryptów startowych użytkowników lub dowiązań symbolicznych. NIE zaleca się instalowania insserv na systemach wcześniejszych niż Pontos. Pakiet ten powinien być stosowany z ostrożnością, ponieważ nieprawidłowe lub brakujące zależności LSB istniejących skryptów instalacyjnych może prowadzić do uniemożliwienia rozruchu systemu. Instalacja insserv na istniejącej instalacji może wymagać dokonania ręcznych zmian.`** 

**`Czytaj  [uwagi dokumentacji Debiana](http://wiki.debian.org/LSBInitScripts/DependencyBasedBoot) , i uwagi do wydania przed instalacja i włączeniem insserv.`** 

<div class="divider" id="bum"></div>
## Menedżer Boot-Up (bum) - Graficzne narzędzie konfiguracji usług

Jeśli logika kolejności startu systemu debiana nie jest bardzo jasne i znana Ci, nie powinieneś igrać z dowiązaniami symbolicznymi, uprawnieniami i tak dalej. W celu uniknięcia zamieszania w systemie, Boot-menedżer pomoże zautomatyzować konfigurację.

Bootmenedżer jest graficznym (GUI) edytorem konfiguracji poziomów startowych, pozwalającym skonfigurować, jakie usługi inicjalizacyjne są wywoływane podczas uruchamiania systemu, lub restartu. Wyświetla listę wszystkich usług, które można uruchomić podczas startu systemu. Możesz przełączać poszczególne usługi - włączać i wyłączać.

~~~  
apt-get install bum  
~~~

Aby używać Graficznego Boot-Up Menegera:

~~~  
$ sux  
password:  
bum  
~~~

  [Szczegółowa dokumentacja na temat Boot-Up Menegera (bum)](http://www.marzocca.net/linux/bumdocs.html) . 

<div class="divider" id="pkill"></div>
## Kończenie usługi lub procesu

`pkill`  jest bardzo użyteczny ze względu na łatwość użycia i możliwość wykorzystania przez użytkownika i administratora w terminalu lub tty.

~~~  
pkill -n usługa  
~~~

Jeśli nie jesteś pewny poprawnej pisowni nazwy procesu lub usługi, które chcesz zakończyć, `pkill <tab> <tab>`  dostarczy listę. 

htop jest także dobrym wyborem. (killall -9 jest ostatnią z możliwości).

<div class="divider" id="init"></div>
## Poziomy uruchamiania siduction - init

To jest lista poziomów uruchamiania systemu operacyjnego siduction, zwróć uwagę, że różni się od poziomów uruchamiania debiana stable:

| Runlevel | siduction | Debian | 
| ---- | ---- | ---- |
|  **init 0**  |  Wyłącza zasilanie PC. |  Wyłącza zasilanie PC. | 
|  **init 1**  | Tryb jednego użytkownika [root] (tryb bezpieczeństwa lub ratunkowy). Demony jak apache i sshd są zatrzymane. Nie wchodź w ten poziom przez zdalny dostęp. | Tryb jednego użytkownika, zatrzymuje usługi (tryb bezpieczeństwa lub ratunkowy). Nie wchodź w ten poziom przez zdalny dostęp. | 
|  **init 2**  |  Tryb wielu-użytkowników z działającą siecią, graficzny system X-Window nie działa, i/lub by nie wchodzić w X-Window System. | Domyślny runlevel Debiana dla trybu Wielu-użytkowników z działającą siecią i systemem X-Window. | 
|  **init 3**  |  Tryb wielo-użytkownikowy z działającą siecią, nie działającym systemem X-Window, i/lub by zatrzymać lub nie wchodzić w system X-Window.  [Tu dokonuje się aktualizacji systemu poprzez dist-upgrade](sys-admin-apt-pl.htm#apt-upgrade) . | Tak jak runlevel 2 / init 2. | 
|  **init 4**  |  Tryb wielo-użytkownikowy z działającą siecią, nie działającym systemem X-Window, i/lub by zatrzymać lub nie wchodzić w system X-Window. | Tak jak runlevel 2 / init 2. | 
|  **init 5**  | Domyślny tryb siductiona wielo-użytkownikowy z działającą siecią, działającym systemem X-Window, i/lub by wystartować system X-Window. | Tak jak as runlevel 2 / init 2. | 
|  **init 6**  | Restart/reboot ponowne uruchomienie systemu. | Restart/reboot ponowne uruchomienie systemu. | 
|  **init S**  | To tu usługi wczesnej fazy startu systemu są uruchamiane na zasadzie "tylko raz". Nie można przełączyć się do niego po tym został jak został już uruchomiony. | To tu usługi wczesnej fazy startu systemu są uruchamiane na zasadzie "tylko raz". Nie można przełączyć się do niego po tym został jak został już uruchomiony. | 


---

Aby upewnić się co do aktualnego poziomu uruchomienia (init) w jakim jesteś:

~~~  
who -r  
~~~

Wymaganą lekturą dla każdego administratora systemu poziomów siductiona i Debiana jest:

~~~  
man init  
~~~

<div class="divider" id="pw-lost"></div>
## Utracone hasło roota

Nie możesz odzyskać utraconego hasła, ale możesz ustawić nowe.

Najpierw wystartuj system z Live-CD.

Jako root zamontuj swoją partycję główną (na przykład /dev/sdb2)

~~~  
mount /dev/sdb2 /media/sdb2  
~~~

Teraz podmień główny katalog na swoją starą partycję główną przy pomocy chroot i ustaw nowe hasło:

~~~  
chroot /media/sdb2 passwd  
~~~

<div class="divider" id="pw-new"></div>
## Ustawianie nowych haseł

Aby zmienić hasło twojego 'użytkonika', wykonaj jako `$ użytkownik` :

~~~  
$ passwd  
~~~

Aby zmienić hasło twojego 'superużytkownika' (root), wykonaj jako `# root` :

~~~  
passwd  
~~~

Aby zmienić hasło użytkownika jako administrator, wykonaj jako `# root` :

~~~  
passwd <użytkownik>  
~~~

<div class="divider" id="fonts"></div>
## Czcionki w siductionzie

##### Poprawne ustawienia dpi - podstawy

Ustawienia DPI są trudne do zgadnięcia, ale są właściwie doskonale wykryte przez X.

##### Poprawna rozdzielczość i częstotliwość odświeżania

Każdy monitor posiada własną, doskonałą kombinację ustawień, ale niestety nie każdy przekazuje właściwe wartości DCC, a czasem istnieje potrzeba poprawy wartości przez użytkownika.

<!--##### Właściwe sterowniki karty graficznej

Niektóre nowsze karty ATI i Nvidia nie działają dobrze z wolnymi sterownikami i jedynym, sensownym rozwiązaniem w takim przypadku są komercyjne sterowniki z zamkniętymi źródłami. siduction nie preinstaluje ich ze względów prawnych,  [sposoby instalacji można znaleźć tutaj.](gpu-pl.htm) 

-->
##### Domyślny wybór czcionek, rendering i rozmiary

siduction używa wolnych czcionek, które dowiodły swojej wszechstronności, twój własny wybór czcionek może pogorszyć jakość renderingu. Jest jednak kilka potężnych opcji w Debianie (oprócz KDE>systemsettings ), które mogą pomóc dostarczyć idealnego renderingu również z innymi czcionkami. Bądź jednak świadomy, że każda czcionka ma tylko kilka idealnych rozmiarów, inne rozmiary mogą nie wyglądać tak dobrze.

Zmiana dpi również może prowadzić do poprawy wyglądu czcionki:

~~~  
fix-dpi-kdm  
~~~

Polecenie powinno pokazać DPI dla twojego rozmiaru ekranu, ale możesz również manipulować tym parametrem. Aby zmiany przyniosły efekt, musisz przejść do trybu init 3, nastepnie wrócić do init 5, albo uruchomić ponownie system.

 Po zmianie typu czcionki albo DPI (w X lub Firefox/Iceweasel), możesz potrzebować kilku ponownych regulacji, aby otrzymać zadowalający efekt, szczególnie po zmianie z czcionki bitmapowej na True Type, lub odwrotnie:

~~~  
dpkg-reconfigure fontconfig-config  
~~~

Wybierz "native" i "autohinter" w konfiguratorze. Można też spróbować innych ustawień.

Jeśli to nie będzie działać, możesz potrzebować utworzyć ponownie cache czcionek poprzez:

~~~  
apt-get install --reinstall --yes -o DPkg::Options::=--force-confmiss -o DPkg::Options::=--force-confnew fontconfig fontconfig-config  
~~~

##### Aplikacje oparte na GTK, takie jak Firefox/Icewasel

Aplikacje oparte na GTK generalnie sprawiają problemy z domyślnymi ustawieniami KDE. Można to naprawić przy pomocy:

~~~  
apt-get install gtk2-engines system-config-gtk-kde gtk-qt-engine gtk2-engines-qtcurve  
~~~

W `Ustawienia >Wygląd`  znajdziesz nową pozycję menu nazwaną `Style i Czcionki GTK` . Ustaw 'Style GTK' na 'Clearlooks' a 'Czcionki GTK' ustaw na 'Czcionki KDE' `lub`  eksperymentuj z wieloma opcjami by zadowolić swoje preferencje.

To może naprawić rendering czcionek w aplikacjach gtk.

<div class="divider" id="cups"></div>
## CUPS - serwer wydruków

KDE posiada rozbudowaną pomoc na ten temat, ale aktualizacja systemu często powoduje, że cups nie działa poprawnie, to jest jedno ze znanych rozwiązań:

~~~  
modprobe lp  
echo lp >> /etc/modules  
apt-get remove --purge cupsys cups  
apt-get install cups  
LUB  
apt-get install cups cups-driver-gutenprint hplip  
~~~

Upewnij się, że CUPS działa :

~~~  
/etc/init.d/cups restart  
~~~

 Następnie w przeglądarce internetowej: 

~~~  
http://localhost:631  
~~~

Innym problemem jest próba ustawienia cups przez GUI, kiedy pojawia się okno proszące o twoje hasło, podczas gdy ty chcesz użyć uprawnień **`roota`**  i wpisać **`hasło roota`** .

 [The OpenPrinting database](http://www.linuxfoundation.org/collaborate/workgroups/openprinting/database/databaseintro)  zawiera mnóstwo informacji o konkretnych drukarkach, wraz z dużą ilością informacji o strownikach, samych sterownikach, podstawowe dane techniczne i związane z tym zestawy narzędzi konfiguracyjnych. 

<div class="divider" id="sound"></div>
## Dżwięk w siductionie

`Dźwięk jest domyslnie wyciszony w siductionzie.` 

Wersja KDE używa Kmix a XFCE używa Mixer.

Często jest to tylko kwestia kliknięcia na ikonę dźwięku na pasku zadań i odznaczenie pola "Mute".

###### Kmix

W kmix musisz włączyć opcje, które preferujesz dla opcji kanału, `Kmix>Ustawienia>Konfiguracja Kanałów.`  Albo w konsoli:

~~~  
$ kmix  
~~~

###### XFCE

W XFCE uruchom mixer i dodaj kilka kontrolek przez `Multimedia>Mixer`  i kliknij na `Wybierz Controls box.`  Lub w terminalu:

~~~  
$ xfce4-mixer  
~~~

### Alsamixer

 Jeśli wolisz używać Alsamixera, znajduje się on w pakiecie alsa-utils:

~~~  
apt-get update  
apt-get install alsa-utils  
exit  
~~~

Ustaw preferowane ustawienia dźwięku jako **`$użytkownik`**  w terminalu:

~~~  
$ alsamixer  
~~~

<!-- Then as root:

~~~  
alsactl store  
-->  
~~~

<!--
 [Zobacz także siduction wiki.]() 

-->
<div id="rev">Content last revised 20/04/2011 0830 UTC </div>
