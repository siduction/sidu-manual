<div id="main-page"></div>
<div class="divider" id="live-cd-upgrade"></div>
## Aktualizacja przy pomocy Live-cd

Funkcja aktualizacji siduction.org przy pomocy "live-cd' nie istnieje. Przed rozpoczęciem instalacji siduction.org **`WYKONAJ KOPIĘ BEZPIECZEŃSTWA SWOICH DANYCH! Włączając w to zakładki i maile.`** 

`Zaleca się utworzenie osobnej partycji na dane. Zalety takiego rozwiązania w trakcie odzyskiwania danych w przypadku awarii są niemierzalne.`

Dlatego $HOME został miejscem, gdzie są przechowywane pliki konfiguracyjne aplikacji.

**`ZAWSZE WYKONUJ KOPIĘ ZAPASOWĄ SWOICH DANYCH włączając w to zakładki i maile!`**

<div class="divider" id="hd-upgrade"></div>
## Aktualizacja zainstalowanego na dysku siduction.org

Zainstalowałeś najnowszą wersję siduction.org i chcesz sprawdzić, czy masz na nim najnowsze wersję pakietów oraz aktualizacje bezpieczeństwa.

W siduksie nazywa się to 'dist-upgrade' i wykonuje się przez sieć.

` **Jedyną wspieraną metodą to dist-upgrade jest następująca procedura:** `

<div class="box block">
**NIGDY nie wykonuj dist-upgrade podczas sesji X<div class="highlight-4"> Zawsze sprawdzaj bieżące ostrzeżenia na głównej stronie  [siduction.org](http://siduction.org) . Ostrzeżenie te wynikają z natury niestabilnej gałęzi dystrybucji i są aktualizowane codziennie.**

~~~  
## Wyloguj się z KDE.  
## Przejdź do trybu tekstowego poprzez kombinację klawiszy Ctrl+Alt+F1  
## Zaloguj się jako root i wpis:  
z init 3  
apt-get update  
apt-get dist-upgrade  
apt-get clean  
init 5 && exit  
~~~

**NIGDY NIE DOKONUJ DIST-UPGRADE [lub UPGRADE] przy pomocy adept, synaptic lub aptitude  [PATRZ: Aktualizacja zainstalowanego systemu](sys-admin-apt-pl.htm#apt-upgrade) :**


---

#### Powody, dla których powinieneś używać tylko apt-get do dist-upgrade

Menadżery pakietów takie jak adept, aptitude, synaptic i kpackage nie zawsze są w stanie wziąć pod uwagę wielką ilość zmian, która ma miejsce w Sidzie (zmiany zależności, zmiany nazw, zmiany skryptów, ...). Nie jest to jednak wina twórców tych narzędzi, piszą oni wspaniałe programy, które świetnie działają w stabilnej gałęzi debiana, nie są one po prostu odpowiednie dla specjalnych potrzeb Debiana Sid.

Używaj, czego chcesz, do wyszukiwania pakietów, ale pozostań przy apt-get do właściwego instalowania/usuwania/aktualizacji.

Menadżery pakietów takie jak adept, aptitude, synaptic i kpackage nie są przewidywalne (w przypadu kompleksowego wyboru pakietów). Połącz to z szybko poruszającym się celem, jakim jest sid, i nawet gorszymi zewnętrznymi repozytoriami o kwestionowanej jakości (nie używamy ich, ani nie polecamy, ale są rzeczywistością na systemach użytkowników), a będziesz zabiegał o katastrofę. Inną kwestią jest to, że wszystkie te graficzne menadżery pakietów muszą działać w trybie init 5, w X, a wykonywanie dist-upgrade w trybie init 5 (lub nawet 'upgrade' co jest niezalecane) może zakończyć się uszkodzeniem twojego systemu bez możliwości naprawy, może nie dziś lub jutro, ale w dalszej przyszłości.

Z drugiej strony apt-get robi dokładnie to, o co jest proszony, jeśli następuje awaria możesz ją zlokalizować i znaleźć komunikaty o błędach/naprawić je, jeśli apt-get chce usunąć połowę systemu (z powodu zmian w bibliotekach) jest czas na reakcję administratora (czyli ciebie).

To jest powód, dla którego deweloperzy debiana używają apt-get, a nie inne menadżery pakietów.

<div id="rev">Strona ostatnio modyfikowana 14/08/2010 0100 UTC</div>
