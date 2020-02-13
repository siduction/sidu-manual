<div id="main-page"></div>
<div class="divider" id="search-on"></div>
## Căutare în mod conectat la internet 

#### Varianta 1

Scrie un cuvânt sau mai multe în câmpul de căutare și apasă butonul `*Caută*`  (sau apasă `*Înapoi*` ).


---

<form method="get" action="/cgi-bin/perlfect/search-ro/search.pl">
  
<input type="hidden" name="p" value="1" />  
<input type="hidden" name="lang" value="en" />  
<input type="hidden" name="include" value="" />  
<input type="hidden" name="exclude" value="" />  
<input type="hidden" name="penalty" value="0" />  
<select name="mode">  
<option value="all">Potrivește/Găsește TOATE cuvintele</option>  
<option value="any">Potrivește/Găsește ORICARE dintre cuvinte</option>  
</select>  
<input type="text" name="q" /><input type="submit" value="Caută" />  


</form>

---

###### Opțiuni de căutare

Dacă`Potrivește/Găsește TOATE cuvintele`  este selectat, numai acele documente care conțin TOATE cuvintele alese în  *Caută*  vor fi returnate. Cu `Potrivește/Găsește ORICARE dintre cuvinte` toate documentele care conțin CEL PUȚIN UN CUVÂNT vor fi returnare în  *Caută* . 

Ca o alternativă puteți scrie `"+"`  (semnul plus) direct în fața unuia sau mai multor cuvinte ca să găsiți doar acele fișiere care includ toate cuvintele. Cuvinte cu un `"-"`  (semnul minus) direct înaintea lor rezultatul fiind astfel încât numai documentele ce nu conțin nici unul din acele cuvinte sunt listate.

<!--Observați că dacă sunt fraze căutarea nu este valabilă. De exemplu nu are rost să puneți ghilimele în afara frazei/cuvântului căutat `"cam așa ceva"` .

-->
Rezultatele sunt aduse în ordinea relevanței cu cele mai relevante documente listate mai întâi. Relevanța depinde de numărul și poziția cuvintelor potrivite în documente. 

#### Varianta 2

Pentru căutarea  *'on line'* , scrieți sau lipiți în căsuță de căutare a browser-ului, (unde `xxxx`  este cuvântul pe care doriți să-l căutați), următoarele:

~~~  
xxxxx site:manual.siduction.org/ro  
~~~

<div class="divider" id="search-off"></div>
## Căutare în mod neconectat la internet  *('off line')* 

 Înpreună cu dezvoltatori de la Recoll, echipa de la Manualul Sistemului de Operare siduction a creat câteva configurații speciale ca parte integrantă a programului de bază. Recoll este o unealtă de căutare de text pentru sisteme Unix/Linux. Această unealtă este bazată pe foarte puternicul  *Xapian back-end* , pentru care pune la dispoziție o interfață grafică QT, plină de funcționalități și foarte ușor de utilizat.  *Mulțumiri speciale celor de la Recoll* .

Recoll este denumit ` *Personal Search Tool*`  -Unealtă de căutare personală- în meniul Debian din KDE.

##### Pasul 1

 Manual este disponibil, via  *apt* , în momentul de față în următoarele limbi:  
Default - Deutsch (German, -de)  
Default - English (English, -en)  
*Italiano (Italian, -it)  
*Polski (Polish, -pl)  
*Português (Portuguese , pt-br)  
*Română (Romanian, -ro)  


~~~  
apt-get update  
apt-get install bluewater-manual-xx (unde -xx este codul limbii dvs. De exemplu: bluewater-manual-en, bluewater-manual-de, bluewater-manual-ro, ....)  
~~~

##### Pasul 2

~~~  
apt-get install recoll  
~~~

##### Pasul 3

+ Recoll, la prima pornire, vă va întreba dacă doriți să creați o bază de date, `click  *cancel*` , și va apare un ecran de configurare a indexării.  
+ În  *'Global parameters'*  - partea de sus a ferestrei cu directoare, click pe semnul `+ (plus)` , navigați până la `/usr/share/bluewater-manual` , click pe limba dorită și click  *ok* . Apoi click pe semnul `- (minus)`  și ștergeți ( *delete* ) toate fișierele inclusiv cele care se termină cu `~ (tilda)` .  
+ La final faceți click pe `File ->Update Index`  și căutați subiectul necesar în  *siduction-manual* .  

 Dacă doriți să resetați  *recoll*  ca urmare a unei actualizări a manualului prin  *apt* , `(tastați, ca utilizator, în consolă)` :

~~~  
recollindex -z  
~~~

 După care dați click pe: `Kmenu ->Debian ->Applications ->Data Management ->Personal Search Tool`  și în `Recoll, File ->Update Index` .

În  *Preview*  vor fi marcate toate cuvintele căutăriilor voastre în fișiere. Alegeți  *Open*  și vor fi deschise în  *Konqueror* , apoi utilizați ` *Caută în această pagină*` .

 [Pagina Home Recoll](http://www.lesbonscomptes.com/recoll/) .

<div id="rev">Content last revised 30/11/2012 1350 UTC</div>
