<div id="main-page"></div>
<div class="divider" id="install-crypt"></div>
## Installare in una directory root criptata

**`Ecco alcune avvertenze da tenere ben presenti nell'utilizzare questa guida per criptare le partizioni root e dati:`**  

+ È applicabile solo da siduction-2011.1-onestepbeyond.iso in poi.  
+ È una guida di base. Sarà vostra cura saperne di più riguardo a LUKS, cryptsetup e crittografia. Le Fonti e le Risorse che potrebbero esservi utili sono elencate alla fine di questa pagina, ma la lista non è certamente esaustiva.  
+ cryptsetup non può crittografare una partizione dati esistente: quindi si deve sempre creare una nuova partizione, configurarla con cryptsetup e spostarvi i dati.  
+ Potete anche utilizzare file chiave e avere chiavi multiple per i dati (fino a 8 includendo la rimozione delle chiavi), ma questo va oltre lo scopo di questa guida.  
+ `Non dimenticate le frasi di accesso, in assenza delle quali si perderebbe l'accesso a ogni cosa! Persino un chroot senza conoscere le frasi di accesso non può essere di aiuto se non per la directory /boot.`   
+ Durante il processo d'avvio iniziale verrà richiesta la frase di accesso per la periferica criptata e il sistema si avvierà normalmente.  

### Esempi di crittografia:

+  [Utilizzare la crittografia con i gruppi LVM](hd-install-crypt-it.htm#lvm) .  
+  [Note per la crittografia con i metodi di partizionamento tradizionali](hd-install-crypt-it.htm#simple) .  

<div class="divider" id="lvm"></div>
## Utilizzare la crittografia con i gruppi LVM

<span class= "highlight-3">Questo esempio, applicabile da siduction-11.1-onestepbeyond.iso in poi, utilizza la crittografia nel volume LVM e vi permette di separare la home da <span class= "highlight-2"> / </span> e avere una partizione di swap senza necessità di password multiple.</span>

Prima di avviare il programma di installazione preparate i filesystem che verranno utilizzati per l'installazione. Per le linee guida base per il partizionamento LVM, fate riferimento a  [Logical Volume Manager - partizionamento LVM](part-lvm-it.htm#part=lvm) .

Avrete bisogno di almeno una partizione con filesystem non criptato <span class= "highlight-3">/boot </span> e una partizione con filesystem criptato <span class= "highlight-2"> / </span>, e inoltre di altri filesystem criptati <span class= "highlight-3">/home e swap</span>.

1. Se non prevedete di utilizzare un gruppo di volumi lvm esistente create un gruppo normale di volumi lvm. L'esempio che segue suppone che il gruppo di volumi che conterrà l'avvio e i dati criptati si chiami <span class= "highlight-3">vg</span>.  
2. Avrete bisogno di un volume logico per /boot e i dati criptati, quindi utilizzate <span class= "highlight-3">lvcreate</span> per creare i volumi logici nel gruppo di volumi <span class= "highlight-3">vg</span> con le dimensioni volute:  
   ~~~    
   lvcreate -n boot --size 250m vg    
   lvcreate -n crypt --size 300g vg    
   ~~~
  
   Qui avete chiamato i volumi logici boot e crypt e avete dato loro dimensioni rispettivamente di 250Mb e 300Gb.  
3. Create il filesystem per <span class= "highlight-3">/boot</span> in modo che sia disponibile per il programma di installazione:  
   ~~~    
   mkfs.ext4 /dev/mapper/vg-boot    
   ~~~
  
4. Utilizzate <span class= "highlight-3">cryptsetup</span> per criptare <span class= "highlight-3">vg-crypt</span> usando l'opzione più veloce xts con la lunghezza della chiave più sicura (512bit), e quindi apritela. Vi verrà richiesta la password due volte per impostarla e una terza volta per aprirla. Apritela con le impostazioni di default di cryptopts usando come nome cryptroot:  
   ~~~    
   cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/mapper/vg-crypt    
   ~~~
  
   ~~~    
   cryptsetup luksOpen /dev/mapper/vg-crypt cryptroot    
   ~~~
  
5. Adesso utilizzate lvm nella periferica criptata per creare un secondo gruppo di volumi che verrà usato per le periferiche <span class= "highlight-3">/swap</span> e <span class= "highlight-3">/home</span>. <span class= "highlight-3">pvcreate</span> cryptroot per farne un volume fisico e utilizzatela con <span class= "highlight-3">vgcreate</span> per creare un altro gruppo di volumi che chiameremo <span class= "highlight-3">cryptvg</span>:  
   ~~~    
   pvcreate /dev/mapper/cryptroot    
   vgcreate cryptvg /dev/mapper/cryptroot    
   ~~~
  
6. Utilizzate poi <span class= "highlight-3">lvcreate</span> nel nuovo gruppo di volumi criptato <span class= "highlight-3">cryptvg</span> per creare i volumi logici <span class= "highlight-2"> / </span>, <span class= "highlight-3">/swap</span> e <span class= "highlight-3">/home </span> delle dimensioni volute:  
   ~~~    
   lvcreate -n swap --size 2g cryptvg    
   lvcreate -n root --size 40g cryptvg    
   lvcreate -n home --size 80g cryptvg    
   ~~~
  
   Si hanno così i volumi logici swap, root e home rispettivamente di 2Gb, 40Gb e 80Gb.  
7. Create i filesystems per cryptvg-swap, cryptvg-root e cryptvg-home in modo da renderli disponibili nel programma di installazione:  
   ~~~    
   mkswap /dev/mapper/cryptvg-swap    
   mkfs.ext4 /dev/mapper/cryptvg-root    
   mkfs.ext4 /dev/mapper/cryptvg-home    
   ~~~
  
8.  **Adesso siete pronti per avviare il programma di installazione dove dovreste utilizzare:**   
   <span class= "highlight-3">vg-boot</span> per <span class= "highlight-3">/boot</span>,  
   <span class= "highlight-3">cryptvg-root</span> per <span class= "highlight-2"> /</span>,  
   <span class= "highlight-3">cryptvg-home</span> per <span class= "highlight-3">/home</span>,  
   e <span class= "highlight-3">cryptvg-swap</span> per <span class= "highlight-3">swap</span> dovrebbe essere riconosciuto automaticamente.  

Il sistema installato infine dovrebbe avere una linea di comando per il kernel includente le seguenti opzioni:

~~~  
root=/dev/mapper/cryptvg-root cryptopts=source=/dev/mapper/vg-crypt,target=cryptroot,lvm=cryptvg-root  
~~~

Adesso sono disponibili la crypt e la boot nel gruppo di volumi vg, e la root, home e swap nel gruppo di volumi vgcrypt che si trova nella periferica criptata protetta da password.

<span class= "highlight-3">Nota:</span> Se reinstallate su un volume lvm precedentemente criptato, il programma di installazione deve essere informato della criptazione:

~~~  
cryptsetup luksOpen /dev/mapper/cryptvg-root cryptvg  
vgchange -a y  
~~~

<div class="divider" id="simple"></div>
## Note per la crittografia con i metodi di partizionamento tradizionali

Prima cosa da decidere è come si vuole partizionare il disco. Avrete bisogno di almeno 2 partizioni: una partizione normale per `/boot`  e una per i dati criptati.

Assumendo che abbiate bisogno di swap servirà una terza partizione (criptata a sua volta) e dovrete inserire la password per swap separatamente durante l'avvio (le richieste di password saranno quindi due).

È possibile utilizzare chiavi per il swap dall'interno del sistema criptato con il partizionamento tradizionale, ma non sarà allora possibile la sospensione su disco. In ragione di questi problemi, l'opzione migliore nel lungo termine è utilizzare i volumi lvm con partizioni e chiavi completamente criptate.

<!--È possibile utilizzare chiavi per il swap dall'interno del sistema criptato con il partizionamento tradizionale, ma non sarà allora possibile la sospensione su disco. In ragione di questi problemi, l'opzione migliore nel lungo termine è decisamente l'uso di volumi lvm con partizioni interamente criptate con chiavi

-->
###### Assunzioni essenziali:

+ Vi sono giusto 3 partizioni in questo disco:  
   `/boot` , di 250Mb  
   `swap` , di 2Gb  
   **`/`**  e `/home`  combinate (per esempio, bilanciate).  
+ Saranno richieste 2 frasi di accesso, 1 per swap e l'altra per **`/`**  e `/home`  combinate.  

Una volta completato il partizionamento, si dovranno preparare le partizioni criptate in modo che siano riconosciute dal programma di installazione.

Se avete utilizzato un'applicazione grafica per il partizionamento, chiudetela e aprite un terminale, dato che i comandi per la crittografia devono essere eseguiti dalla linea di comando.

##### La partizione /boot

Create la partizione `/boot`  come ext4, se non lo si è ancora fatto:

~~~  
/sbin/mkfs.ext4 /dev/sda1  
~~~

##### Partizione swap criptata

Per quanto concerne la partizione `swap criptata`  dovrete per prima cosa formattare e aprire la periferica grezza, `/dev/sda2` , come una periferica criptata, in modo simile alla periferica vg-crypt di cui sopra, ma con nome differente, swap.


cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda2  
</li>  
~~~

~~~  
cryptsetup luksOpen /dev/sda2 swap  
</li>  
~~~

~~~  
echo "swap UUID=$(blkid -o value -s UUID /dev/sda2) none luks" >> /etc/crypttab  
</li>  
~~~

</ol>
Formattate `/dev/mapper/swap`  in modo che sia riconosciuto dal programma di installazione:

~~~  
/sbin/mkswap /dev/mapper/swap  
~~~

##### Partizione / criptata

Per quanto concerne la partizione `/ criptata`  dovrete per prima cosa formattare e aprire la periferica grezza, `/dev/sda3` , come una periferica criptata, in modo simile alla periferica vg-crypt di cui sopra.

~~~  
cryptsetup --verify-passphrase --cipher aes-xts-plain:sha512 luksFormat /dev/sda3  
~~~

~~~  
cryptsetup luksOpen /dev/sda3 cryptroot  
~~~

Formattate `/dev/mapper/cryptroot`  in modo che sia visualizzato nel programma di installazione:

~~~  
/sbin/mkfs.ext4 /dev/mapper/cryptroot  
~~~

### Aprire il programma di installazione

 **Siete ora pronti per avviare il programma di installazione ove dovrete usare:**   
<span class= "highlight-3">sda1</span> per <span class= "highlight-3">/boot</span>,  
<span class= "highlight-3">cryptroot</span> per <span class= "highlight-2"> / </span> e <span class= "highlight-3"> /home</span>  
<span class= "highlight-3">swap</span> dovrebbe essere automaticamente riconosciuto.

Il sistema installato infine dovrebbe avere una linea di comando per il kernel includente le seguenti opzioni (sebbene verrà utilizzato l'UUID esistente):

~~~  
root=/dev/mapper/cryptroot cryptopts=source=UUID=12345678-1234-1234-1234-1234567890AB,target=cryptroot  
~~~

A questo punto avrete /boot in una partizione semplice, uno swap criptato protetto da password e una partizione criptata con / e /home.

### Fonti e Risorse:

Letture necessarie:

~~~  
man cryptsetup  
~~~

 [LUKS](http://code.google.com/p/cryptsetup/) .

 [Redhat](http://www.redhat.com/)  e  [Fedora](http://www.redhat.com/Fedora/) .

 [Protect Your Stuff With Encrypted Linux Partitions ()Proteggete le cose vostre con partizioni Linux criptate)](http://www.enterprisenetworkingplanet.com/netsecur/article.php/3683011) .

 [KVM how to use encrypted images ()KVM come usare immagini criptate)](http://blog.bodhizazen.net/linux/kvm-how-to-use-encrypted-images/) .

 [siduction wiki](http://siduction.com/index.php?module=wikula&amp;tag=FullDiskEncryptionTheDebianWay) .

<div id="rev">Page last revised 22/01/2012 1700 UTC</div>
