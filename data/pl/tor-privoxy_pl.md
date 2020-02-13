<div id="main-page"></div>
<div class="divider" id="privoxy"></div>
## Privoxy

 Privoxy to serwer proxy z zaawansowanymi możliwościami filtrującymi do ochrony prywatności, modyfikowania zawartości stron internetowych, zarządzania ciasteczkami, kontrolowania dostępu i usuwania reklam, banerów, wyskakujących okien i innych niepożądanych treści. Privoxy posiada bardzo elastyczną konfigurację i może być dostosowany do indywidualnych potrzeb. Privoxy ma zastosowanie zarówno w pojedynczych systemach, jak i w sieciach z wieloma użytkownikami. Privoxy jest oparty na Internet Junkbuster (tm).

Aby zainstalować privoxy:

~~~  
apt-get update  
apt-get install privoxy  
~~~

Domyślna instalacja powinna dostarczyć sensownego punktu startowego dla większości użytkowników. Niewątpliwie będą okazje, kiedy zechcesz modyfikować konfigurację, ale może to następować w miarę narastania potrzeb. W większości przypadków na początek nie jest potrzebna specjalna konfiguracja. 

In the privoxy config you may need to uncomment lines and this will depend on your preferences, and it will differ for every user. 

 [Pełna instrukcja Privoxy z tematami dotyczącymi zaawansowanej konfiguracji.](http://www.privoxy.org/user-manual/index.html) 

<!--needs go a little deeper in a usable default config (and hints what to set within your browser, kde and environment),

 -->
<div class="divider" id="tor"></div>
## Tor

Tor siecią wirtualnych tuneli, które pozwalają na poprawę prywatności i bezpieczeństwa w internecie. Umożliwia także programistom tworzenie nowych narzędzi komunikacyjnych z wbudowanymi funkcjami chroniącymi prywatność. Tor udostępnia podstawę dla wielu aplikacji, które pozwalają organizacjom i osobom dzielić informacje poprzez publiczną sieć bez narażania swojej prywatności.

Powinieneś być świadomy, że oprogramowanie to ma negatywny wpływ na szybkość przesyłu danych.

Aby zainstalować Tor:

~~~  
apt-get update  
apt-get install tor  
~~~

The default torrc file should work out of the box for most Tor users. You will need to configure Privoxy to use Tor on the internet, see: [Tor and internet browsing](https://www.torproject.org/docs/tor-doc-unix#privoxy) .

You should also be aware that internet throughput speeds will be negatively affected.

<!--For the Iceweasel brower there is a  [Torbutton](https://addons.mozilla.org/en-US/firefox/addon/2275)  add-on available.

-->
 [The Tor documentation](https://www.torproject.org/documentation.html.en)  offers comprehensive on all aspects of Tor. 

Vidalia is a controller GUI for the Tor software and allows you to start and stop Tor, view the status of Tor at a glance,and monitor Tor's bandwidth usage.

~~~  
apt-get update  
apt-get install vidalia  
~~~

 [Vidalia Homepage](http://www.vidalia-project.net)  

<div id="rev">Content last revised 17/12/2011 1455 UTC</div>
