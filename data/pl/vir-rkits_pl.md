<div id="main-page"></div>
<div class="divider" id="virus-rkits"></div>
## Różne skanery wirusów i rootkitów

<div class="divider" id="av-clam"></div>
### Clamav

~~~  
apt-get install clamav-docs  
apt-get install clamav  
apt-get install clamav-freshclam  
~~~

~~~  
apt-get install clamav-freshclam  
aby pobrać najnowsze sygnatury  
~~~

###### Aby skanować dysk:

~~~  
clamscan  
~~~

Pomoc dla clamav:

~~~  
man clamscan  
man freshclam  
~~~

###### If you wish to use a GUI front end for clamav:

~~~  
apt-get install clamtk  
~~~

 [Strona domowa clamav](http://www.clamav.net/) 

<div class="divider" id="rtkts-rkh"></div>
### rkhunter

Skaner rootitów rkhunter jest narzędziem pomagającym w sprawdzeniu, czy twój system nie jest opanowany przez niechciane programy takie jak rootkity i konie trojańskie. Dokonuje to poprzez wykonanie testów takich jak:  
- porównanie sumy kontrolnej MD5  
- wyszukiwanie domyślnych plików używanych przez rootkity  
- wyszukiwanie błędnych uprawnień dla plików binarnych  
- wyszukiwanie podejrzanych łańcuchów tekstowych w modułach LKM i KLD  
- wyszukiwanie ukrytych plików  
- opcjonalnie skanowanie wśród plików tekstowych i binarnych  
- 

~~~  
apt-get update  
apt-get install rkhunter  
rkhunter --update  
~~~

rkhunter spyta także, czy chcesz ustawić cron, aby skanować system z określoną regularnością.

###### Aby skanować przy pomocy rkhunter

~~~  
rkhunter -c  
~~~

Please read the man pages for a full explanation of the all the options:

~~~  
man rkhunter  
~~~

 [Strona rkhuntera](http://rkhunter.sourceforge.net/) 

<div class="divider" id="rkits-chrk"></div>
### chkrootkit

chkrootkit jest narzędziem, które lokalnie szuka śladów istnienia rootkitów.

~~~  
apt-get install chkrootkit  
~~~

###### Aby skanować dysk przy pomocy chkrootkit

~~~  
chkrootkit  
~~~

chkrootkit sprawdza te typy definicji:

~~~  
ifpromisc.c  
sprawdza, czy interfejs jest w trybie promiscuous (nasłuchu).  
~~~

~~~  
chklastlog.c  
wyświetla informacje z ostatniego loga o usuniętych plikach  
~~~

~~~  
chkwtmp.c  
sprawdza usunięte wtmp  
~~~

~~~  
chkproc.c  
szuka śladów trojanów LKM  
~~~

~~~  
chkdirs.c  
szuka śladów trojanów LKM  
~~~

~~~  
strings.c  
zamiana łańcuchów tekstowych  
~~~

~~~  
chkutmp.c  
sprawdza usunięte utmp  
~~~

 [Strona chkrootkit](http://www.chkrootkit.org/) 

<div id="rev">Strona ostatnio modyfikowana 06/08/2011 1425 UTC</div>
