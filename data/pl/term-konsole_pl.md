<div id="main-page"></div>
<div class="divider" id="term-kon"></div>
## Definicja terminala/konsoli

Terminal, zwany także konsolą, jest programem umożliwiającym bezpośrednie oddziaływanie na system operacyjny linux poprzez wywoływanie różnych poleceń, które są natychmiast wykonywane. Często używa się też określeń `'shell' lub 'linia poleceń'` , terminal jest bardzo potężnym narzędziem i warto zdobyć się na wysiłek zrozumienia podstaw jego użycia.

W siductionzie możesz znaleźć terminal/konsolę blisko K-menu (ikona symbolizująca monitor PC). Możesz również znaleźć tą samą ikonę w K-menu w menu "System".

Kiedy otworzysz okno terminala, zobaczysz znak zachęty terminala, który ma następujący format:

~~~  
username@hostname:~$  
~~~

Powinieneś rozpoznać username jako twoją własną nazwę logowania. Znak `~ (tylda)`  wskazuje, że jesteś w katalogu domowym, a `$`  informuje, że jesteś zalogowany z uprawnieniami zwykłego użytkownika. Na końcu jest twój kursor. To jest linia poleceń, gdzie będziesz wpisywał polecenia, które mają być wykonane.

Wiele poleceń potrzebuje uprawnień roota. Aby uzyskać to uprawnienie, wpisz `sux`  i wciśnij enter. Będziesz poproszony o hasło roota. Wpisz hasło i wciśnij enter ponownie (zwróć uwagę, że kiedy wpisujesz hasło, nic nie pojawia się na ekranie).

Jeśli hasło jest poprawne, znak zachęty zmieni się na:

~~~  
root@hostname:/home/username#  
~~~

**`UWAGA: Gdy jesteś zalogowany jako root, system nie powstrzyma cię przed zrobieniem potencjalnie niebezpiecznych rzeczy jak usunięcie ważnych plików itp., musisz być absolutnie pewny, co robisz, ponieważ istnieje możliwość uszkodzenia systemu.`**

Zwróć uwagę, że znak `$`  zmienił się na `#`  (hash). W terminalu/konsoli `#`  zawsze wskazuje, że jesteś zalogowany z uprawnieniami roota. `W tej instrukcji będziemy opuszczać wszystko przed $ lub #. Więc takie polecenie:` 

~~~  
# apt-get install coś  
~~~

oznacza: otwórz terminal, zostań rootem (sux) i wpisz polecenie po znaku zachęty #. `(Nie wpisuj #)` 

Czasami konsola lub terminal może niepoprawnie wyświetlać znaki, wpisz wtedy:

~~~  
reset  
~~~

i wciśnij klawisz enter.

Jeśli obraz wyświetlany przez konsolę/terminal będzie zniekształcony, możesz temu często zaradzić przez wciśnięcie `ctrl+l,`  co ponownie wyświetli okno terminala. To zniekształcenie pojawia się w większości przypadków z programami używającymi interfejsu ncurses, takich jak irssi

Konsola i/lub terminal czasami mogą sprawiać wrażenie zawieszonych, jednak nie jest to prawda i wszystko co wpiszesz, będzie przetworzone. Może to zostać spowodowane przez przypadkowe wciśnięcie `ctrl+s` . W tym przypadku spróbuj `ctrl+q`  aby odblokować terminal.

<div class="divider" id="colours"></div>
### `Podkolorowane konsolowe znaki zachęty`  `user:~` `$`  oraz **`root:`** `#`  `:` 

Podkolorowane podpowiedzi konsoli mogą ochronić Cię od dokonania kłopotliwych i być może katastrofalnych błędów jako **`root #`**  podczas gdy w rzeczywistości chciałeś być `user~$` , lub pozwalają używać kolorów podpowiedzi jako znaczników dla komend, które wykonałeś kilka setek linii temu.

Domyślnie, obydwa znaki zachęty user~$ i root# mają taki sam kolor i bardzo łatwo zmienić te kolory dla obydwu kont.

Podstawowymi kolorami są:

~~~  
(the syntax is 00;XX)  
[00;30] Black  
[00;31] Red  
[00;32] Green  
[00;33] Yellow  
[00;34] Blue  
[00;35] Magenta  
[00;36] Cyan  
[00;37] White  
[Replace [00;XX] with [01;XX] to get a colour variation].  
~~~

###### Aby zmienić kolor zachęty twojego użytkownika ~$ :

Jako $ user, za pomocą twojego ulubionego edytora tekstowego:

~~~  
$ <editor> ~/.bashrc  
~~~

Idź do linii 39 i odkomentuj ją, w ten sposób:

~~~  
force_color_prompt=yes  
~~~

Idź do linii 53 i tam gdzie ma ona 01;32m, (dla przykładu), zmień na kolor, który tobie odpowiada.

Jako przykład, dla znaku zachęty ~:$ użytkownika podkolorowanego `cyan` , [01;36m\], potrzebujesz zmienić kod [01;XXm\] w trzech miejscach ze składnią:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[01;36m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '  
~~~

Nowy wygląd będzie dostępny dopiero w nowej sesji konsoli.

###### By zmienić kolor znaku zachety root# :

~~~  
sux  
<editor> /root/.bashrc  
~~~

Idź do linii 39 i odkomentuj ją, w ten sposób:

~~~  
force_color_prompt=yes  
~~~

Idź do linii 53 i tam gdzie jest 01;32m, (dla przykładu), zmień na kolor, który tobie odpowiada.

Dla przykładu, dla znaku zachęty :# superużytkownika (root) **`red`** , [01;31m\], potrzebujesz zmienić kod [01;XXm\] w trzech miejscach ze składnią:

~~~  
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[01;31m\]:\[\033[01;31m\]\w\[\033[00m\]\$ '  
~~~

Nowy wygląd będzie dostępny dopiero w nowej sesji konsoli.

###### Terminal Kolory tła terminala

Aby zmienić kolor tła i opcje czcionek w terminalu, zapoznaj się z opcjami menu terminala. 

![Terminal colours](../images-common/images-terminal/terminal-colour-0.1.png "Terminal colours") 

Istnieje nadmiar dostępnych opcji dla zmiany kolorów, zaleca się jednak przestrzegać prostoty.

<div class="divider" id="sux"></div>
## sux

Wiele poleceń wymaga uruchomienia z prawami roota. Aby to osiągnąć, wpisz:

~~~  
sux  
~~~

Popularnym poleceniem, aby stać się rootem jest 'su' ale użycie `sux`  pozwala dodatkowo uruchamiać aplikacje GUI / X11 z linii poleceń, ponieważ współpracuje ze standardowym poleceniem su, jednak dodatkowo transferuje uprawnienia do serwera X dla docelowego użytkownika. (See also  [sudo](#sudo) ).

Przykładem uruchomienia aplikacji X11 przez sux jest użycie edytora tekstu jak kwrite lub kate, aby zmienić plik należący do roota, partycjonowanie przy pomocy gparted lub praca z menadżerem plików takim jak dolphin lub thunar. <!--Możesz także zmieniać pliki należące do roota poprzez kliknięcie na nie prawym klawiszem myszy i wybranie 'edit-as-root', a następnie wpisanie hasła roota, co wywoła w tle kdesu.-->

Niektóre aplikacje KDE wymagają `dbus-launch`  przed aplikacją:

~~~  
dbus-launch <Application>  
~~~

###### Opcje klawiatury dla KDE

Aby uruchomic krunner w KDE:

~~~  
Alt+F2  
~~~

lub kliknij prawym klawiszem myszy na pulpicie i wybierz:

~~~  
Run Command  
~~~

następnie:

~~~  
kdesu <Application>  
~~~

###### Opcje klawiatury dla Xfce

Aby wywołać "Uruchom komendę" w Xfce:

~~~  
Alt+F2  
~~~

lub kliknij prawym klawiszem myszy na pulpicie i wybierz:

~~~  
Run Command  
~~~

następnie:

~~~  
gksu <Application>  
~~~

###### Inne opcje Menedżedra Okien Pulpitu

Inną opcją klawiaturową właściwą dla wszystkich głównych Menadżerów Pulpitu jest:

~~~  
Alt+F2  
~~~

następnie:

~~~  
su-to-root -X -c <Application>  
~~~

`Wszystkie powyższe opcje klawiaturowe mogą być uruchomione w terminalu.` 

<div class="divider" id="sudo"></div>
## sudo nie jest wspierane

sudo nie jest włączony domyślnie w instalacji na dysku twardym. Jest możliwe użycie go na live-ISO ponieważ nie jest ustawione hasło roota. Należy rozumieć to w ten sposób, że jeśli atakujący przejmie hasło użytkownika, nie dostanie natychmiast pełnych uprawnień superużytkownika i nie zdoła wprowadzić potencjalnie niszczycielskich zmian do twojego systemu.

Innym zagadnieniem dotyczączym sudo jest to, że sudo prowadzi do uruchomienia aplikacji roota z konfiguracją użytkownika, co może nadpisać lub zmienić uprawnienia. W paru przypadkach, to może spowodować, że aplikacja stanie się bezużyteczna dla uzytkownika. Używaj `[sux](#sux) , kdesu, gksu lub su-to-root -X -c`  jako zalecanych!

## Działanie w powłoce roota

**`UWAGA: Kiedy jesteś zalogowany jako root, system nie powstrzyma cię do zrobienia potencjalnie niebezpiecznych rzeczy takich jak usuwanie ważnych plików itp., musisz absolutnie pewnym, co robisz, ponieważ jest bardzo prawdopodobne, że możesz poważnie uszkodzić swój system. `**

**`W żadnym wypadku nie powinieneś uruchamiać jako root aplikacji, które zwykły użytkownik wykorzystuje na codzień, takich jak klient poczty, arkusz kalkulacyjny, czy przeglądarka internetowa. `**

<div class="divider" id="cli-help"></div>
## Pomoc linii poleceń

Większość poleceń/programów linuksa posiada własną instrukcję zwaną "stroną man", dostępną z linii poleceń. Składnia jest następująca:

~~~  
$ man "polecenie"  
~~~

lub

~~~  
$ man -k <keyword>  
~~~

Otworzy to stronę instrukcji dla tego polecenia. Nawiguj przy pomocy klawiszy kursora. Na przykład spróbuj:

~~~  
$ man apt-get  
~~~

Aby wyjść ze stron mana wpisz `q` 

Innym użytecznym narzędziem jest polecenie "apropos". Apropos umożliwia przeszukiwanie stron mana, jeśli np. nie pamiętasz pełnej składni. Jako przykład możesz spróbować:

~~~  
$ apropos apt-  
~~~

Wylistuje to wszystkie polecenia dla menadżera pakietów 'apt'. 'Apropos' jest całkiem potężnym narzędziem, ale opisywanie go szczegółowo jest poza tematem tej instrukcji. Dla poznania szczegółów jego działania, przeczytaj stronę jego mana.

<div class="divider" id="term-cmds"></div>
## Lista poleceń terminala linuksa

To jest wspaniały przewodnik o używaniu BASH-a  [z linuxcommand.org](http://linuxcommand.org/) 

`Listę 687 poleceń w kolejności alfabetycznej z  [Linux in a Nutshell, 5th Edition : O'Reilly Publications](http://www.linuxdevcenter.com/linux/cmd/#a)  można znaleźć tutaj. Koniecznie dodaj ją do ulubionych.`

Istnieje wiele różnych poradników w internecie. Jeden bardzo dobry dla początkujących to:  [A Beginner's Bash](http://linux.org.mt/article/terminal) 

Wykorzystaj swoją ulubioną wyszukiwarkę, aby znaleźć więcej.

<div class="divider" id="shell-scripts"></div>
## Skrypty, sposób użycia

Skrypt shellowy jest wygodnym sposobem, aby umieścić wiele poleceń w jednym pliku. Po uruchomieniu skryptu przez wpisanie jego nazwy, każde polecenie będzie uruchamiane w kolejności występowania w pliku. siduction udostępnia wiele użytecznych skryptów, aby ułatwić życie użytkowników. 

Jeśli skrypt jest w twoim *bieżącym katalogu*

~~~  
./name_of_shell-script  
~~~

`Niektóre skrypty wymagają uprawnień roota (sux), a inne nie, zależy to od celu skryptu.`

##### Procedura instalacji i wykonania skryptu

Użyj wget, aby pobrać plik skryptu, umieść go tam, gdzie jest to zalecane przez autora `(np. możesz zostać poproszony o umieszczenie go w /usr/local/bin)` , możesz użyć funkcji kopiuj i wklej nazwę pliku bezpośrednio do okna konsoli, po zalogowaniu się jako root używając `sux` 

###### Przykład użycia wget, który wymaga `uprawnień roota (sux)` 

~~~  
sux  
cd /usr/local/bin  
wget script-name  
~~~

Następnie musisz uczynić plik wykonywalnym

~~~  
chmod +x script-name  
~~~

Możesz także wykorzystać swoją przeglądarkę internetową do pobrania skryptu, a następnie umieszczenia w miejscu, w którym jest to rekomendowane, ale i tak musisz uczynić go wykonywalnym.

<!--
###### Przykład użycia wget jako użytkownik

Aby umieścić plik w twoim `$HOME jako użytkownik '$'` :

~~~  
$ wget http://bluewater.siduction.org/shell-script-test/test-script.sh  
~~~

~~~  
$ chmod +x test-script.sh  
~~~

Aby uruchomić skrypt, otwórz terminal/konsolę, i uruchom wpisując nazwę skryptu:

~~~  
$ ./test-script.sh  
~~~

Powinieneś wtedy zobaczyć to:

~~~  
Congratulations user  
You successfully downloaded and executed a bash script!  
Welcome to siduction-manuals http://manual.siduction.org  
~~~

-->
<div id="rev">Strona ostatnio modyfikowana 14/08/2010 0100 UTC</div>
