<div id="main-page"></div>
<div class="divider" id="privoxy"></div>
## Privoxy

 Privoxy este un proxy de web cu capabilităţi avansate de filtrare pentru protejarea intimităţii, modificarea datelor din paginile web, managementul de cookies, acces controlat, îndepărtarea de ads, bannere, pop-ups şi alte lucruri supărătoare de pe internet. Privoxy are o configurare foarte flexibilă şi poate fi particularizat pentru a satisface orice nevoie personală. Privoxy se potriveşte atât sistemelor stand-alone precum şi reţelelor multi-user. Privoxy are la bază Internet Junkbuster (tm).

Pentru instalarea privoxy:

~~~  
apt-get update  
apt-get install privoxy  
~~~

Instalarea normală ar trebui să ofere un punct de plecare suficient pentru cei mai mulţi utilizatori. Vor exista, fără îndoială, ocazii în care veţi dori să ajustaţi configurarea, dar aceasta poate fi făcută foarte uşor atunci când este nevoie. În cele mai multe cazuri este necesară doar o configurare iniţială minimă sau chiar deloc. 

În fișierul de configurare al lui privoxy va trebui să de-comentați liniile corespunzătoare preferințelor voastre. Ele pot diferi de la un utilizator (user) la altul. 

 [Manualul complet Privoxy cu opţiuni avansate de configurare](http://www.privoxy.org/user-manual/index.html) 

<!--needs go a little deeper in a usable default config (and hints what to set within your browser, kde and environment),

 -->
<div class="divider" id="tor"></div>
## Tor

Tor este o reţea de tuneluri virtuale ce oferă posibilitarea utilizatorilor şi grupurilor de utilizatori să-şi îmbunătăţească securitatea şi intimitatea pe Internet. Deasemeni oferă dezvoltatorilor de soft posibilitatea să creeze noi programe de comunicare pe web cu facilităţi de protejare a intimităţii. Tor este fundaţia unei game foarte largi de aplicaţii ce fac posibilă transmiterea de informatii de către organizaţii sau persoane fizice, prin internet, fără să pună în pericol caracterul privat al acestora.

Va trebui să reţineţi că şi viteza în internet va fi afectată în mod negativ.

Pentru a instala Tor:

~~~  
apt-get update  
apt-get install tor  
~~~

Fișierul implicit  *torrc* , ar trebui să funcționeze bine pentru majoritatea utilizatorilor 'Tor'. Dacă veți avea nevoie să configurați 'Privoxy' ca să utilizeze 'Tor' pe internet, vedeți: [Tor and internet browsing](https://www.torproject.org/docs/tor-doc-unix#privoxy) .

Trebuie să aveți grijă că și viteza în internet va fi afectată negativ.

<!--Pentru browser-ul Iceweasel este disponibil un 'add-on' numit  [Torbutton](https://addons.mozilla.org/en-US/firefox/addon/2275)  .

-->
 [The Tor documentation](https://www.torproject.org/documentation.html.en)  oferă informații cuprinzătoare despre toate aspectele lui 'Tor'. 

'Vidalia' este un program de control grafic (GUI) pentru programul 'Tor' ce vă permite să porniți și să opriți 'Tor', să-i vedeți statul dintr-o privire și să monitorizați lărgimea de bandă utilizată de 'Tor'.

~~~  
apt-get update  
apt-get install vidalia  
~~~

 [Vidalia Homepage](http://www.torproject.org/projects/vidalia.html.en)  

<div id="rev">Content last revised 17/12/2011 1455 UTC</div>
