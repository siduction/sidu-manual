<div id="main-page"></div>
<div class="divider" id="cheatcodes"></div>
## Opzioni d'avvio

I valori possibili sono elencati nel campo "Valore" della tabella e devono essere accodati al "Codice" con un segno **`=`** . Per esempio, se il valore desiderato per il codice dello schermo è 1280x1024, digiterete `screen=1280x1024`  nella riga di boot di grub; se la lingua desiderata è l'italiano, digiterete `lang=it` . La riga di boot di grub può essere editata premendo `e`  non appena grub appare sullo schermo. Vi troverete allora nel modo editazione di grub e potrete inserire il codice necessario nella riga di boot del kernel (dopo `quiet` ). Potete anche associare 2 o più codici. Per proseguire nel processo di boot premete `Ctrl -X` .

 [Riferimento per una lista esaustiva di codici d'avvio per il kernel.](http://www.kernel.org/pub/linux/kernel/people/gregkh/lkn/lkn_pdf/ch09.pdf) 

<div class="divider" id="cheatcodes-siduction"></div>
## Opzioni d'avvio specifiche di siduction (solo liveCD)

| Codice | Valore | Descrizione | 
| ---- | ---- | ---- |
|  **blacklist**  | nomemoduli | Disabilita temporaneamente i moduli elencati prima di udev | 
|  **desktop**  | kde | Sceglie l'ambiente grafico | 
|  | fluxbox |  | 
|  **fromiso**  |  | Leggere:  [Come fare il boot con il metodo "fromiso"](hd-install-opts-it.htm)  | 
|  **hostname**  | miohostname | Cambia l'hostname del liveCD | 
|  **lang**  |  be, bg, cz, da, de, de_CH, el, en, en_AU, en_GB, en_IE, es, fr, fr_BE, ga, hr, hu, it, ja, nl, nl_BE, pl, pt (pt_BR), pt_PT, ro, ru, zh | Seleziona la lingua. Configura locale, layout della tastiera (console e X), fuso orario ed un mirror debian. Quando viene utilizzata la forma estesa con `lang=ll_cc`  o `lang=ll-cc` , `ll`  verrà utilizzato per la selezione della lingua e `cc`  per la selezione della tastiera, del mirror e del fuso orario (ad es. `lang=fr-be` ). Il default per l'inglese è en_US con UTC come fuso orario, per il Tedesco de con Europa/Berlino come fuso orario. Esempio: `lang=pt_PT tz=Pacific/Auckland`  | 
|  **md5sum**  |  | Controlla l'integrità del supporto | 
|  **noaptlang**  |  | Disabilita l'installazione dei pacchetti di localizzazione basata sulla scelta della lingua | 
|  **nocpufreq**  |  | Non attiva Speedstep/Powernow | 
|  **nodhcp**  |  | Disabilita l'uso automatico del Dynamic Host Configuration Protocol (che cerca di settare automaticamente la connessione ethernet) | 
|  **noeject**  |  | Non chiede di espellere il CD allo spegnimento | 
|  **nofstab**  |  | Non scrive un nuovo file fstab | 
|  **nointro**  |  | Non mostra index.html sul desktop all'avvio del liveCD | 
|  **nomodeset**  | radeon.modeset=0 | Consente, insieme a `xmodule=vesa` , il boot pulito in X con una scheda Radeon in modalità live | 
|  **nonetwork**  |  | Disabilita la configurazione automatica dei dispositivi di rete al momento del boot | 
|  **noswap**  |  | Non abilita la partizione di swap | 
|  **persist**  |  | Leggere:  [Metodo "fromiso" e "persist"](hd-install-opts-it.htm#fromiso-persist)  | 
|  **smouse**  |  | Testa il collegamento con il mouse seriale tramite hwinfo | 
|  **toram**  |  | Copia il CD nella RAM e fa il boot da lì | 
|  **tz**  | tz=Europe/Dublin | Configura il fuso orario. Se l'orologio del bios/hardware è configurato come UTC, utilizzare `utc=yes` . Un elenco di tutti i fusi orari supportati può essere ottenuto mediante copia/incolla nel vostro browser di: `file:///usr/share/zoneinfo/`  | 


---

###### Cheatcode relativi a X

Entrambi i cheatcode per xrandr o xmodule possono essere utilizzati insieme ad altri relativi a X con una scheda video radeon, intel o mga.

| Codice | Valore | Descrizione | 
| ---- | ---- | ---- |
|  **dpi**  | ad es., auto oppure XXX | Configura i Dots Per Inch dello schermo. Si può ottenere il valore in dpi dello schermo dividendo la larghezza in pixel per la diagonale in pollici e moltiplicando il valore ottenuto per 1,25 nel caso di uno schermo 4:3, 1,18 per uno schermo 16:10, per 1,147 per uno schermo 16:9. Per uno schermo 24" 1920x1080, ad es. si ha 1.147*1920/24, con risultato dpi=92; per uno schermo 15" 1600x1200, 1.25*1600/15, con risultato dpi=133. | 
|  **hsync**  | ad es. 80 | Valore di aggiornamento orizzontale del monitor (in kHz) | 
|  **noml**  |  | Previene la configurazione X.org dal contenere una lista di Modelines e causa il riconoscimento automatico del modo corretto | 
|  **noxrandr**  |  | Disabilita l'uso delle estensioni RandR 1.2 da parte dei nuovi driver X.org e usa le tecniche legacy di test del monitor | 
|  **screen**  | ad es. : 800x600 | Specifica la risoluzione dello schermo, ad es. 1024x768, 1600x1200, etc. | 
|  **vsync**  | ad es. : 60 | Valore di aggiornamento verticale del monitor (in Hz) | 
|  **xdepth**  | valori: 8 15 16 24 | Massimo numero di colori visualizzabili di default da usare da parte di X.org: non tutti i driver supportano 1 e 4 | 
|  **keytable**  | ad es. : us, de, gb | Schema della tastiera per l'uso da parte di X.org | 
|  **xkbmodel**  | ad es. : pc105 | Modello di tastiera per l'uso da parte di X.org | 
|  **xkboptions**  | ad es., grp:alt_shift_toggle | Variante di tastiera che X.org deve utilizzare | 
|  **xkbvariant**  | ad es., nodeadkeys | per impostare una variante di tastiera | 
|  **xmode**  | ad es., 1024x768 | Stabilisce la risoluzione dello schermo, ad es.: 1024x768, 1600x1200, etc. | 
|  **xmodule**  oppure  **xdriver**  | ad es. : ati, fbdev, i810, intel, mga, nv, radeon, savage, vesa | Usa un dato modulo X | 
|  **xrandr**  |  | Forza X.org per essere configurato a usare le estensioni RandR 1.2 dei nuovi driver X.org | 
|  **xrate**  | XX | Forza il valore di aggiornamento preferito di RandR 1.2 supportata dai driver X.org e deve essere usato insieme al codice xmode  [Si veda qui la documentazione completa](http://wiki.debian.org/XStrikeForce/HowToRandR12) . | 
|  **xhrefresh**  | ad es., 80 | Frequenza di aggiornamento orizzontale del monitor in X (kHz) | 
|  **xvrefresh**  | ad es., 60 | Frequenza di aggiornamento verticale del monitor in X (Hz) | 


---

<div class="divider" id="cheatcodes-linux"></div>
## Opzioni d'avvio tipiche del kernel Linux

| Codice | Valore | Descrizione | 
| ---- | ---- | ---- |
|  **apm**  | off | Power-off | 
|  **1, 2, 3, 4, 5**  |  per es., 3  |  **init runlevel**  numeri che possono essere inseriti manualmente nella linea di boot di Grub,  [Si veda runlevel di siduction - init](sys-admin-gen-it.htm#init)  | 
|  **irqpoll**  |  | Usa IRQ poll | 
|  **mem**  | per es., 128M, 1G | Dimensione della RAM da usare | 
|  **noagp**  |  | Disabilita AGP | 
|  **noapic**  |  | Disabilita APIC (Advanced Programmable Interrupt Controller) | 
|  **nodma**  |  | Disabilita l'uso del Direct Memory Access per i dispositivi | 
|  **noisapnpbios**  |  | Disabilita il Plug and Play per il bus ISA | 
|  **nomce**  |  | Disabilita Machine Check Exception | 
|  **nosmp**  |  | Disabilita il supporto per Symmetric Multi Processor | 
|  **pci**  | noacpi | Non usa ACPI per indirizzare gli interrupt PCI | 
|  **quiet**  |  | Non elenca tutto nella console | 
|  **vga**  | normal | Per i codici validi per la VGA si legga:  [Codici d'avvio per la VGA](cheatcodes-vga-it.htm)  | 
|  **video**  | (per es.) DVI-0:800x600  oppure  800x600 | Per le schede abilitate KMS. Si applica alle schede intel e ati (driver radeon), dove DVI-X/LVDS-X è l'output video come mostrato da xrandr. | 

<div id="rev">Page last revised 21/01/2012 0715 UTC</div>
