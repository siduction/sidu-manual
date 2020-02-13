<div id="main-page"></div>
<div class="divider" id="home-bu"></div>
## Salvataggio della partizione /home

Prima di spostare la vostra `/home`  dovreste salvare, come root, tutto quello che contiene:

~~~  
tar cvzpf in_qualche_dir/home.tar.gz /home  
~~~

Per estrarlo:

~~~  
tar xvpf in_qualche_dir/home.tar.gz  
~~~

 [Un metodo alternativo per il salvataggio consiste nell'utilizzare rdiff](sys-admin-rdiff-it.htm) 

<div class="divider" id="home-move"></div>
## Spostare la /home

**`Non usate e non condividete una $home esistente di un'altra distribuzione perché i file di configurazione andranno in conflitto se si utilizza lo stesso nome utente in distribuzioni diverse.`** 

Si può muovere o utilizzare una /home siduction esistente in due modi: con il liveCD; con la linea di comando. In nessuno dei due casi l'operazione è difficile.

Poiché il sistema necessita dell' [informazione UUID](part-uuid-it.htm) , dovrete cercare l'uuid della nuova partizione, a meno che non l'abbiate già annotata in precedenza.

Il metodo più semplice è aggiungere questa nuova informazione mettendo in `/etc/fstab`  il commento (#) sul vecchio rigo prima di muovere la /home.

Avviate il PC e nel rigo di grub del menu scrivete 1 e premete il tasto Invio. Ciò avvierà il sistema in init 1, cioè nella modalità singolo utente che non utilizza la home corrente: in tal modo è sicuro operare su di essa.

Non appena nella console tty, fate il login come root e montate la nuova partizione /home, per esempio:

~~~  
mount /dev/sdxX /media/nuova-home  
(o qualsiasi partizione la nuova home utilizzerà)  
cp -pr /home /media/nuova-home  
~~~

Poi modificate `/etc/fstab`  in accordo al cambiamento della posizione della nuova /home:

~~~  
mcedit /etc/fstab  
~~~

Adesso `togliete il commento ()#)`  dal rigo dove si trova la nuova /home e `inseritelo`  nel rigo della vecchia /home. Salvate con F2 e uscite con F10. Riavviate.

<div id="rev">Content last revised 06/02/2012 2100 UTC</div>
