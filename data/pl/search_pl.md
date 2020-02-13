<div id="main-page"></div>
<div class="divider" id="search-on"></div>
## Wyszukiwanie online

#### Opcja 1

Wpisz jeden lub więcej słów w polu wyszukiwania i kliknij `Szukaj (lub naciśnij Enter)` .


---

<form method="get" action="/cgi-bin/perlfect/search-pl/search.pl">
  
<input type="hidden" name="p" value="1" />  
<input type="hidden" name="lang" value="pl" />  
<input type="hidden" name="include" value="" />  
<input type="hidden" name="exclude" value="" />  
<input type="hidden" name="penalty" value="0" />  
<select name="mode">  
<option value="all">Szukaj wszystkich słów</option>  
<option value="any">Szukaj któregokolwiek słowa</option>  
</select>  
<input type="text" name="q" /><input type="submit" value="Szukaj" />  


</form>

---

###### Opcje wyszukiwania 

Jeśli wybierasz `Szukaj wszystkich słów`  tylko te dokumenty są wyświetlane, które zawierają wszystkie wyszukiwane hasła. Z `Szukaj któregokolwiek słowa`  wszystkie dokumenty są wyświetlane, które zawierają co najmniej jedno z wyszukiwanych haseł. 

Alternatywnie możesz umieścić `znak plus (+)`  przed jednym lub więcej słów aby dostać tylko te pliki, które zawierają wszystkie te słowa. Wyrazy z `znakiem minus (-)`  przed nimi zmieniają wynik tak, aby tylko dokumenty są wyświetlane, które nie zawierają żadnego z tych słów. 

Należy pamiętać, że wyszukiwanie wyrażenia nie jest obsługiwane, tzn. nie ma sensu wyszukiwania w cudzysłów `"tak na przykład"` .

Wyniki są sortowane według trafności z najistotniejszych dokumentów. Znaczenie zależy od liczby i położenia dopasowych słów w dokumentach. 

#### Opcja 2

Aby wyszukać w Internecie, wpisz lub wklej w polu wyszukiwania przeglądarki, co następuje (gdzie `xxxx`  to słowo, które chcesz wyszukać): 

~~~  
xxxxx site:manual.siduction.org/pl  
 </div>  
~~~

<div class="divider" id="search-off"></div>
## Wyszukiwanie Off-line

Przy współpracy z deweloperem Recolla zespół Podręcznika Systemu Operacyjnego siduction stworzył specjalne pliki konfiguracyjne do podstawowego pakietu tego oprogramowania. Recoll jest pełnowymiarowym programem do wyszukiwania tekstu dla systemu Unix/Linux. Bazuje on na bardzo mocnym wnętrzu Xapiana, które gwarantuje bogaty w funkcje i przyjazny dla użytkownika interfejs graficzny QT.  *Bardzo specjalne podziękowania dla Recolla* .

Recoll jest nazwany `Personal Search Tool`  w Debian Menu KDE.

##### Krok 1

Podręcznik jest obecnie dostepny poprzez apt w następujących językach:  
Default - Deutsch (German)  
Default - English (English)  
*Čeština (Czech)  
*Dansk (Danish)  
*Español (Spanish)  
*Français (French)  
*Italiano (Italian)  
*Nihongo (Japanese)  
*Nederlands (Dutch)  
*Polski (Polish)  
*Português (Portuguese BR and PT)  
*Română (Romanian)  
*Русский (Russian)  
*Українска (Ukrainian  


~~~  
apt-get update  
apt-get install siduction-manual-xx (gdzie -xx to żądany język)  
~~~

##### Krok 2

~~~  
apt-get install recoll  
~~~

##### Krok 3

+ Recoll przy pierwszym uruchomieniu zapyta czy ma utworzyć bazę danych, `kliknij na cancel` , kiedy pojawi się okienko konfiguracyjne indeksowania.  
+ W Parametrach Globalnych - okienko nadrzędnych katalogów, kliknij na znak `+ (plus)` , przejdź do `/usr/share/siduction-manual`  i kliknij na żądanym języku, następnie kliknij OK. Potem kliknij na znak`- (minus)`  i usuń wszytkie inne foldery włączając `~ (tilde)` .  
+ Na koniec `File>Update Index`  i wyszukaj potrzebny temat w podręczniku siductiona.  

Jeśli chcesz skasować indeks w Recollu w związku z uaktualnieniem podręcznika siductiona przez apt, `(jako użytkownik $ w kosoli)` :

~~~  
recollindex -z  
~~~

Następnie w Recollu: `File>Update Index` .

Link 'Podgląd' podświetli wszystkie przypadki wystąpienia wyszukiwanego słowa w pliku, podczas gdy 'Otwórz' uruchomi Konquerora, a użycie komendy `Znajdź na tej stronie`  pozwoli uruchomić mikro wyszukiwanie słowa szukanego w Recollu.

 [Strona domowa Recolla](http://www.lesbonscomptes.com/recoll/) .

<div id="rev">Content last revised 25/12/2011 1035 UTC</div>
