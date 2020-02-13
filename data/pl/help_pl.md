<div id="main-page"></div>
<div class="divider" id="help-gen"></div>
## Gdzie szukać pomocy?

Otrzymanie pomocy na czas może oszczędzić wielu łez i pozwolić na zajęcie się tym, co naprawdę jest ważne w życiu. Temat ten opisuje środki, jakie siduction udostępnia swoim użytkownikom, gdy potrzebują oni pomocy.

+  [Fora i Wiki](help-pl.htm#for-wiki)   
+  [IRC](help-pl.htm#irc)    
+  [Przydatne narzędzia init 3 i trybie tekstowym (tty)](help-pl.htm#init3-tools)    
+  [Używanie IRC w trybie tekstowym i/lub w init 3](help-pl.htm#irc-init3)    
+  [Przeglądanie sieci w trybie tekstowym i/lub w init 3](help-pl.htm#init3-web)    
+  [inxi](help-pl.htm#inxi)   

<div class="divider" id="for-wiki"></div>
## Fora

Fora są miejscem do zadawania pytań. Pamiętaj, aby przed wysłaniem pytania przeszukać najpierw fora - być może ktoś już zadał podobne pytanie.  [Fora](http://siduction.org)  są prowadzone w języku niemieckim i angielskim.

## Wiki

Wiki jest dostępne do użytku i edycji dla wszystkich użytkowników siduction.org. Mamy nadzieję, że będzie ono rosło wraz z rozwojem projektu.

 Liczymy na to, że użytkownicy na każdym poziomie umiejętności będą tworzyć wiki, ponieważ jest ono przeznaczone do tego, aby pomagać użytkownikom o zróżnicowanej wiedzy. Kilka minut, które poświęcisz dla wiki, może oszczędzić godziny innym użytkownikom, potrzebne na znalezienie rozwiązania.  [Wiki](http://wiki.siduction.de/index.php?title=Hauptseite)  posiada wersję w języku niemieckim i angielskim. 

<div class="divider" id="irc"></div>
## Interaktywna pomoc poprzez IRC

### Protokół zachowania na IRC 

**`Nigdy nie korzystaj z IRC jako "root". Jesteś mile widziany na IRC jako zwykły użytkownik, ale nie administrator. Jeśli masz kłopoty z uruchomieniem IRC jako zwykły użytkownik, natychmiast o tym powiedz.`**

### Kanał #siduction 

 Są dwa sposoby otrzymania interaktywnej pomocy poprzez IRC:  
1) Kliknięcie skrótu `siduction-irc`  na pulpicie lub użycie innego klienta IRC  
2) Kliknięcie w link `Meet the Team`  w menu na stronie  [siduction.org](http://siduction.org) 

#### Konversation

Najłatwiejszym sposobem jest skorzystanie ze skrótu `siduction-irc`  umieszczonego na pulpicie lub poprzez Kmenu, w którym znajduje się prekonfigurowany Konversation.

Jeśli wolisz innego klienta IRC, ustaw serwer na:

~~~  
irc.oftc.net  
port 6667  
~~~

#### Klient IRC ze strony siduction.org

 Wejdź na stronę  [siduction.org](http://siduction.org)  kliknij link Chat w menu. Uruchomi to w twojej przeglądarce klienta `Meet the Team`  in the menu list. To pozwoli ci na opcjonalne użycie Chat (cgi) lub Chat (java) opartego na sieci klienta ircowego chata.

Wpisz wybrany przez ciebie nick (pseudomin) w pole nickname i #siduction w pole channel.

<div class="divider" id="paste"></div>
## !paste

**`!paste będzie twoim dobrym przyjacielem na kanale #siduction, ponieważ umożliwi ci udostępienie na IRC dłuższych tekstów, np. komunikatów z konsoli, bez ryzyka "zaśmiecania" kanału.`**  Jeśli zostaniesz poproszony o użycie !paste, wpisz `!paste`  w okno twojego klienta IRC (lub ktoś zrobi to za ciebie), co wyświetli następującą informację:

~~~  
"paste" is <a href="http://paste.debian.net/">  
http://paste.debian.net/</a> :please choose no  
syntax highlighting;make your paste;  
then give #siduction the link to your paste..  
.  
~~~

Teraz wystarczy, że klikniesz na link, który zabierze cię na stronę, gdzie będziesz mógł wkleić swój tekst. Następnie kliknij na przycisk `send` .

Po tym przekonasz się, że to co wprowadziłeś znalazło się w bazie danych z kilkoma opcjami linkowania do IRC, co jest adresem potrzebnego kanału. (Przykład: `To link to your entry use: http://paste.debian.net/524`  ). Debain paste może ustawić wyświtelanie informacji przez określony czas - do 72 godzin). Możesz także wykasować wklejone dane.

### siduction-paste

siduction-paste pozwala ci na wklejanie wyjścia zbioru z terminala i konsoli tty, w związku z tym jest to idealne narzędzie jeśli masz kłopoty i jesteś w init 3. siduction-paste używa http://rafb.net jako linka, a wyjście jest osiąglane w ciagu 24 godzin. 

Możesz być zalogowany jako użytkownik albo root aby udostępnić siduction paste, jakkolwiek zauważ, że niektóre żądania wyjścia potrzebują praw roota.

~~~  
siduction-paste <file>  
lub  
siduction-paste -c "command1 --options parameters ; command2"  
~~~

###### Przykład z siduction-paste &lt;file&gt;

~~~  
siduction-paste /etc/fstab  
Your paste can be seen here: http://rafb.net/p/n8miQp85.html  
~~~

Link `http://rafb.net/p/n8miQp85.html`  jest tym czego potrzebujesz, aby dostać się do #siduction na IRC

###### Przykład z siduction-paste -c

~~~  
siduction-paste -c "fdisk -l; cat /etc/fstab"  
Your paste can be seen here:http://rafb.net/p/ZrhlVc59.html  
~~~

Link `http://rafb.net/p/ZrhlVc59.html`  jest tym czego potrzebujesz, aby dostac się do #siduction on IRC

<div class="divider" id="init3-tools"></div>
## Pomocne narzędzia w trybie tekstowym (tty) i init 3 

Zwykle jesteś w trybie tekstowym/init 3 ponieważ aktualizujesz system lub coś złego stało się z nim.

#### gpm

Dobrym narzędziem, które masz do dyspozycji w trybie tekstowym jest `gpm` . Pozwala na użycie myszki do kopiowania i wklejania tekstu między terminalami/konsolami.

`Aby zainstalować gpm:`  

~~~  
gpm -t imps2 -m /dev/input/mice  
~~~

Upewnij się, że istnieje plik /etc/gpm.conf. 

~~~  
/etc/init.d/gpm restart  
~~~

Skoro już możesz korzystać w trybie tekstowym z myszki (tty), 

#### Przeglądanie plików i edycja tekstu

Midnight Commander jest pełnoekranowym managerem plików i edytorem tekstu działającym tybie tekstowym, zainstalowanym domyślnie i dosyć prostym w użyciu.

Oprócz normalnych komend wydawanych z klawiatury reaguje także na klikanie myszką w celu nawigacji dzięki gpm.

`mc`  wyświetla pliki systemowe a `mcedit`  wyświetla pusty plik lub umożliwia bezpośrednią edycję pliku.

Przykład bezpośredniego dostępu do edycji pliku:

~~~  
mcedit /etc/apt/sources.list.d/debian.list  
~~~

Teraz możesz edytować plik aby zmienić parametry i zapisać modyfikację osiągając natychmiastowy efekt.

Przeczytaj:

~~~  
man mc  
~~~

<div class="divider" id="irc-init3"></div>
### Wejście na kanał #siduction w trybie tekstowym i/lub init 3 

**`Nigdy nie korzystaj z IRC jako "root". Jesteś mile widziany na IRC jako zwykły użytkownik, ale nie administrator. Jeśli masz kłopoty z uruchomieniem IRC jako zwykły użytkownik, natychmiast o tym powiedz.`**

#### irc w trybie tekstowym i/lub w init 3

Domyślnym w siductionzie jest irssi.

Kiedy jesteś w init 3, możesz przełączyć się na inny terminal/konsolę przez:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <username> <password> (nie jako użytkownik root)    
następnie wpisz    
$ siduction-irc (to wywoła irssi)    
~~~
  
albo możesz zainstalować innego klinta jak np. weechat:

~~~  
#apt-get install weechat-curses  
~~~

Kiedy jesteś w trybie init 3, możesz zmieniać terminale/konsole poprzez:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <username> <password> (nie jako root)    
następnie wpisz    
$ weechat-curses    
~~~
  
Teraz połącz się z serwerem irc.oftc.net on, port 6667. Gdy połączysz się z serwerem, zmień swój pseudonim (nick):

~~~  
/nick wybrany_nick  
~~~

Aby dołączyć do kanału siduction.org:

~~~  
/join #siduction  
~~~

Jeśli chcesz połączyć się z innym serwerem:

~~~  
/server nazwa.serwera  
~~~

W dolnym pasku narzędziowym wyświetlają się liczby, gdy pojawia się nowa wypowiedź na którymś z kanałów. Aby przejść na ten kanał, wciśnij na klawiaturze: ALT-1 ALT-2 ALT-3 ALT-4 itp...

Aby zakończyć program:

~~~  
/exit  
~~~

Jeśli aktualizujesz system i chcesz sprawdzić postęp: 

~~~  
powrót do aktualizacji  
$ CTRL-ALT-F1  
i przejście do konsoli z irc  
# CTRL-ALT-F2  
~~~

 [dokumentacja irssi](http://irssi.org/documentation) 

 [dokumentacja WeeChata](http://www.weechat.org/) 

<div class="divider" id="init3-web"></div>
#### Przeglądanie stron internetowych w trybie tekstowym i/lub init 3

w3m pozwala na przeglądanie stron internetowych w terminalu/konsoli lub w trybie tekstowym i/lub init 3.  


Sprawdź, czy w3m jest zainstalowany. Jeśli nie, wpisz:

~~~  
apt-get update  
apt-get install w3m  
~~~

Następnie otwórz terminal/konsolę:

~~~  
$w3m URL  
lub  
w3m ?  
lub  
w3m siduction.org  
~~~

Kiedy zobaczysz czarny ekran, `nie wpadaj w panikę,`  użyj kombinacji klawiszy:

~~~  
SHIFT+U  
~~~

Pojawi się wtedy w dole ekranu napis: Goto URL: file:///home/username/$. Po prostu wykasuj go aż do GOTO URL i wpisz:

~~~  
http://siduction.org  
~~~

Możesz teraz przeglądać stronę  [siduction.org](http://siduction.org)  lub jakąkolwiek inną którą wybierzesz.

Jeśli jesteś w trybie init 3:

~~~  
# CTRL-ALT-F2  
$ siductionbox login: <username> <password> (nie jako root)    
następnie napisz    
$ w3m siduction.org    
Aby wrócić do aktualizacji    
$ CTRL-ALT-F1    
~~~
  
Aby przejść bezpośrednio do instrukcji: 

~~~  
$w3m manual.siduction.org  
~~~

 [strona domowa w3m](http://w3m.sourceforge.net/) 

###### `Wskazanym jest zaznajomić się z używaniem elinks/w3m, irssi/weechat i midnight commander przed wystąpieniem zagrożenia, gdyby miałoby się zdarzyć. To może być dobra strona do druku jako źródło pomocy w stanach zagrożenia systemu.` 

<div class="divider" id="inxi"></div>
## inxi

inxi jest skryptem informacji o systemie, który działa niezależnie od klienta IRC. Skrypt może wyświetlić informacje od twoim sprzęcie i oprogramowaniu, aby inni użytkownicy przebywający na kanale mogli pomóc ci zdiagnozować problem... albo abyś sam mógł podziwiać specyfikację twojego systemu i wersję zainstalowanego kernela.

Aby użyć skrypt inxi w Konversation wpisz w oknie chata:

~~~  
/cmd inxi -v2  
~~~

Aby użyć skrypt inxi innych klientach pisz w oknie czata:

~~~  
/exec -o inxi -v2  
lub  
/inxi -v2  
~~~

W konsoli napisz:

~~~  
inxi -v2  
~~~

<!--
Przeczytaj cały przewodnik o inxi

~~~  
man inxi  
~~~

-->
<div class="divider" id="links"></div>
## Użyteczne linki

###### Ogólna dokumentacja linuksa

 [debian.org/doc/user-manuals](http://www.debian.org/doc/user-manuals#apt-howto) 

 [Debian Reference Card - do wydruku na pojedynczej kartce](http://www.debian.org/doc/user-manuals#refcard) 

 [debian.org/doc/#howtos](http://www.debian.org/doc/#howtos) 

 [Podstawy Debiana, instalacja i administracja systemem](http://qref.sourceforge.net/index.en.php)  dokument dostępny w HTML, text, PDF lub PS w wielu różnych językach.

 [linuxbasics](http://linuxbasics.org/) 

Centrum Pomocy KDE w siductionzie mieści pomoc dla drukowania/CUPS, możesz też skorzystać z  [Common Unix Printing System CUPS](http://www.cups.org/) 

 [LibreOffice](http://pl.libreoffice.org/) 

<div id="rev">Strona ostatnio modyfikowana 30/10/2011 0740 UTC </div>
