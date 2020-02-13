<div id="main-page"></div>
<div class="divider" id="burning-no-gui"></div>
## Masterizzare CD/DVD senza interfaccia grafica

###### **`MOLTO IMPORTANTE:`** `siduction, nella sua qualità di liveCD Linux, si basa su una tecnologia ad alta compressione: per questo motivo è richiesta particolare attenzione nel masterizzare l'immagine ISO. Utilizzate solo supporti CD (o DVD+RW) di alta qualità e masterizzate in **`modalità DAO (disk-at-once)`**  alla velocità massima di 8x.` 


---

## burniso

`Non è necessaria un'interfaccia grafica per masterizzare un CD/DVD.` 

Problemi di masterizzazione si manifestano per lo più con il front-end (k3b), non altrettanto comunemente con i back-end (growisofs, wodim o cdrdao).

`siduction fornisce uno script già pronto per masterizzare una ISO: 'burniso'.` 

Burniso masterizza, tramite wodim, immagini ISO utilizzando la modalità Disk-At-Once e una velocità di 8x.

~~~  
apt-get install siduction-scripts  
~~~

`come utente ($):` 

~~~  
$ cd /dir/contenente/la/ISO  
~~~

~~~  
$ burniso  
~~~

Tutte le immagini ISO nella directory corrente vengono elencate e la masterizzazione inizia subito dopo la selezione di una di queste: assicuratevi, quindi, di avere un supporto ottico già inserito.

<div class="divider" id="burn-no-gui-gen"></div>
## Quali dispositivi utilizzare come utente ($):

Per verificare le opzioni del dispositivo cd/dvd e le possibilità per i dispositivi ATAPI usare:

~~~  
$ wodim --devices  
wodim: Overview of accessible drives (2 found) :  
---------------------------------------------------------  
0 dev='/dev/hdc' rwrw-- : 'AOPEN' 'CD-RW CRW2440'  
1 dev='/dev/hdd' rwrw-- : '_NEC' 'DVD_RW ND-3540A'  
---------------------------------------------------------  
~~~

Le altre alternative sono:

~~~  
$ wodim dev=/dev/scd0 driveropts=help -checkdrive  
~~~

e

~~~  
$ wodim -prcap  
~~~

#### Ecco alcuni esempi utili utilizzando "scd0":

##### Informazioni su un CD/DVD vuoto:

~~~  
$ wodim dev=/dev/hdc -atip  
~~~

oppure

~~~  
$ cdrdao disk-info --device ATA:1,0,0  
~~~

##### Formattare un disco riscrivibile:

~~~  
$ wodim -blank=fast -v dev=/dev/hdc  
~~~

oppure

~~~  
$ cdrdao blank --device ATA:1,0,0 --blank-mode minimal  
~~~

##### Clonare un cd:

~~~  
$ cdrdao copy --fast-toc --device ATA:1,0,0 --buffers 256 -v2  
~~~

##### Clonare un cd "al volo":

~~~  
$ cdrdao copy --fast-toc --source-device ATA:1,1,0 --device ATA:1,0,0 --on-the-fly --buffers 256 --eject -v2  
~~~

##### Creare un cd audio a velocità 12x partendo da file wave:

~~~  
$ wodim -v -eject -pad -dao speed=12 dev=/dev/hdc defpregap=0 -audio *.wav  
~~~

##### Masterizzare un cd da file bin/cue:

~~~  
$ cdrdao write --speed 24 --device ATA:1,0,0 --eject filenam.cue  
~~~

##### Masterizzare un'immagine ISO:

~~~  
$ wodim dev=/dev/scd0 driveropts=burnfree,noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

Se viene segnalato un errore `driveropts` , ciò è dovuto a `burnfree` , deprecato per alcune periferiche; quindi:

~~~  
$ wodim dev=/dev/scd0 driveropts=noforcespeed fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

oppure

~~~  
$ wodim dev=/dev/scd0 fs=14M speed=8 -dao -eject -overburn -v siduction.iso  
~~~

##### Creare un'immagine ISO con tutti i file (e le sottodirectory) di una directory.

Questa può essere poi masterizzata con il comando precedente (masterizzare un'immagine ISO):

~~~  
$ genisoimage -o miaImmagine.iso -r -J -l directory  
~~~

Se si possiede un masterizzatore DVD si può utilizzare anche growisofs per masterizzare il DVD, nel modo seguente:

~~~  
$ growisofs -dvd-compat -Z /dev/dvd=immagine.iso  
~~~

##### Masterizzare file multipli su DVD:

~~~  
$ growisofs -Z /dev/dvd -R -J file1 file2 file3 ...  
~~~

##### Se è rimasto spazio libero sul DVD si possono aggiungere altri file:

~~~  
$ growisofs -M /dev/dvd -R -J altrofile1 altrofile2...  
~~~

##### Per finalizzare la sessione, usare:

~~~  
$ growisofs -M /dev/dvd=/dev/zero  
~~~

<div id="rev">Page last revised 21/02/2012 0100 UTC</div>
