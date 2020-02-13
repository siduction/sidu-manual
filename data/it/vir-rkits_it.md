<div id="main-page"></div>
<div class="divider" id="virus-rkits"></div>
## Antivirus e Rootkit

<div class="divider" id="av-clam"></div>
### ClamAV

~~~  
apt-get install clamav-docs  
apt-get install clamav  
apt-get install clamav-freshclam ## per scaricare le ultime definizioni  
~~~

###### Per scansionare

~~~  
clamscan  
~~~

###### Per vedere il menu di aiuto

~~~  
man clamscan  
man freshclam  
~~~

###### Se volete usare un'interfaccia utente grafica (GUI) per clamav:

~~~  
apt-get install clamtk  
~~~

 [Il sito di ClamAV](http://www.clamav.net/) 

<div class="divider" id="rtkts-rkh"></div>
### rkhunter

Il cacciatore di "rootkit", cioè di strumenti da amministratore, rkhunter è un programma di scansione che vi aiuta a far sì che il vostro sistema sia pulito da agenti maligni. Controlla la presenza di rootkit, di porte di servizio ("backdoor") e di codice di acquisizione di privilegi o di negazione del servizio ("exploit") a livello locale eseguendo test come:  
- Confronto degli MD5  
- Controllo dei file di default usati dai rootkit  
- Controllo di permessi errati dei file binari  
- Controllo di stringhe sospette nei moduli LKM e KLD  
- Controllo dei file nascosti  
- Scansioni opzionali all'interno di file di testo e binari  


~~~  
apt-get update  
apt-get install rkhunter  
rkhunter --update  
~~~

rkhunter vi chiederà anche se volete impostare cron per eseguire le scansioni in forma programmata.

###### Per eseguire una scansione con rkhunter

~~~  
rkhunter -c  
~~~

Leggete le pagine del manuale per una spiegazione completa di tutte le opzioni:

~~~  
man rkhunter  
~~~

 [Il sito di rkhunter](http://rkhunter.sourceforge.net/) 

<div class="divider" id="rkits-chrk"></div>
### chkrootkit

chkrootkit è uno strumento per cercare indizi della presenza di rootkit a livello locale.

~~~  
apt-get install chkrootkit  
~~~

###### Per eseguire una scansione con chkrootkit

~~~  
chkrootkit  
~~~

chkrootkit fa il controllo di questi tipi di definizioni:

~~~  
ifpromisc.c ## cerca se l'interfaccia è in modo promiscuo  
~~~

~~~  
chklastlog.c ## cerca eventuali eliminazioni del file degli ultimi accessi (lastlog)  
~~~

~~~  
chkwtmp.c ## cerca eventuali eliminazioni del registro di login (wtmp)  
~~~

~~~  
chkproc.c ## cerca indizi della presenza di trojan LKM  
~~~

~~~  
chkdirs.c ## cerca indizi della presenza di trojan LKM  
~~~

~~~  
strings.c ## sostituzione "pronta e sporca" di stringhe  
~~~

~~~  
chkutmp.c ## cerca eventuali eliminazioni del registro di login (utmp)  
~~~

 [Il sito di chkrootkit](http://www.chkrootkit.org/) 

<div id="rev">Page last revised 02/05/2012 0958 UTC</div>
