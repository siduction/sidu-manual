<div id="main-page"></div>
<div class="divider" id="search-on"></div>
## Ricerca On-Line

#### Opzione 1

Scrivete una o più parole nel campo di ricerca e premete `Cerca (oppure Invio)` .


---

<form method="get" action="/cgi-bin/perlfect/search-it/search.pl">
  
<input type="hidden" name="p" value="1" />  
<input type="hidden" name="lang" value="it" />  
<input type="hidden" name="include" value="" />  
<input type="hidden" name="exclude" value="" />  
<input type="hidden" name="penalty" value="0" />  
<select name="mode">  
<option value="all">Cerca TUTTE le parole</option>  
<option value="any">Cerca QUALSIASI parola</option>  
</select>  
<input type="text" name="q" /><input type="submit" value="Cerca" />  


</form>

---

###### Opzioni di ricerca

Se è selezionato `Cerca TUTTE le parole` , verranno visualizzati i documenti che contengono "tutte" le parole della ricerca; se è selezionato `Cerca QUALSIASI parola` , verranno visualizzati i documenti che contengono almeno una parola della ricerca.

In alternativa potete mettere un `segno più (+)`  davanti a una o più parole per trovare solo quei file che includono tutte quelle parole. Scrivendo invece le parole con un `segno meno (-)`  davanti modifica il risultato in modo che saranno visualizzati solo i documenti che non contengono nessuna di quelle parole.

Si noti che la ricerca di frasi non è supportata, ad es. non ha senso mettere gli apici (') o i doppi apici (") per delimitare una frase `"cerca questa frase"` .

I risultati sono ordinati per rilevanza con i documenti maggiormente attinenti per primi. La rilevanza dipende dal numero e dalla posizione delle parole trovate nei documenti.

#### Opzione 2

Per fare ricerche in linea, scrivete o incollate dentro la casella di ricerca del browser (dove `xxxx`  indica la parola che si vuole cercare) la seguente riga:

~~~  
xxxxx site:manual.siduction.com/it  
~~~

<div class="divider" id="search-off"></div>
## Ricerca Off-line

Trevor Walkley (bluewater) ha creato alcune configurazioni speciali insieme allo sviluppatore di Recoll come parte del pacchetto predefinito. Recoll è uno strumento di ricerca personale di testo per Unix/Linux. Si basa sul solido backend di Xapian per il quale fornisce un'interfaccia grafica sviluppata con QT, semplice ma piena di funzioni.  *Un ringraziamento speciale a Recoll* .

Recoll è indicato come `Strumento di Ricerca Personale`  nel menu Debian di KDE.

##### Passo 1

Il manuale è attualmente disponibile attraverso apt per le seguenti lingue: de, en, pt-br.

~~~  
apt-get update  
apt-get install bluewater-manual-xx (dove -xx è la lingua richiesta)  
~~~

##### Passo 2

~~~  
apt-get install recoll  
~~~

##### Passo 3

+ Recoll al primo avvio vi chiederà se volete costruire il database: `premete cancel` , comparirà una finestra per la configurazione dell'indice.  
+ In Global parameters - Top directories box, premete sul segno `+ (più)`  e andate su `/usr/share/bluewater-manual` , scegliete la lingua e premete ok. Poi premete sul segno `- (meno)`  e cancellate tutte le directory, compresa `~ (tilde)` .  
+ Infine `File > Update Index`  e cercate l'argomento di cui avete bisogno nel Manuale di siduction.  

Se avete necessità di riinizializzare l'indice di Recoll a seguito dell'aggiornamento del manuale di bluewater attraverso apt, `digitate nella console come utente $` :

~~~  
recollindex -z  
~~~

Quindi, in Recoll: `File>Update Index` .

Il collegamento 'Preview' evidenzierà tutte le ricorrenze della parola cercata nel file, mentre 'Open' aprirà Konqueror, e utilizzando `Cerca in questa pagina`  potrete fare una microricerca della parola che è stata cercata con Recoll.

 [Il sito web di Recoll](http://www.lesbonscomptes.com/recoll/) 

<div id="rev">Content last revised 15/03/2012 2145 UTC</div>
