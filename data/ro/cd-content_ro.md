<div id="main-page"></div>
<div class="divider" id="cd-content"></div>
## Conţinutul Live ISO-ului

`siduction furnizează doar Debian dfsg-free software pe live-ISO,  [vă rugăm să verificaţi acest link pentru informaţii suplimentare despre surse non-free pentru firmware .](nf-firm-ro.htm#non-free-firmware) `

Imaginea ISO este complet bazată pe Debian Sid (2011-12-31), îmbunătăţită şi stabilizată cu scripturi şi pachete concepute exclusiv de echipa siduction . Vine cu ultimul și cel mai bun kernel siduction, bazat pe cel mai recent  [vanilla kernel 3.1.6](http://www.kernel.org/) . ACPI şi DMA sunt activate implicit.

`O descriere completă a fiecărei versiunî (manifest) este inclusă în fiecare locație de descărcare:`  [Locații siduction, Descărcare și ardere](cd-dl-burning-ro.htm#download-siduction) .

<div class="divider" id="release-vari"></div>
## Variante ale versiunii ISO

siduction oferă 5 up-to-date live-ISO variante bazate pe Debian Sid a căror instalare nu durează mai mult de 10-20 minute.

###### Variantele sunt:

1.  **KDE 32 bit** , live-ISO de aproximativ 600MB:  
   conține un set mediu de aplicații pentru KDE4 desktop. Puteți adăuga ușor mai multe aplicații conform nevoilor voastre utilizând 'apt'.  
2.  **KDE 64 bit** , live-ISO de aproximativ 600MB:  
   conține un set mediu de aplicații pentru KDE4 desktop. Puteți adăuga ușor mai multe aplicații conform nevoilor voastre utilizând 'apt'.  
3.  **XFCE 32 bit** , live-ISO de aproximativ 500MB:  
   conține un mediu Desktop complet (nu minimal), avănd toate aplicațiile necesare pentru a fi productiv imediat. Ocupă mai puțin loc decăt KDE4.  
4.  **XFCE 64 bit** , live-ISO de aproximativ 500MB: conține un mediu Desktop complet (nu minimal), avănd toate aplicațiile necesare pentru a fi productiv imediat. Ocupă mai puțin loc decăt KDE4.  
5.  **LXDE 32 bit** , live-ISO de aproximativ 650MByte: conţine un mediu Desktop uşor. Are o amprenta pe disk chiar mai mică decât XFCE.  
6.  **LXDE 64 bit** , live-ISO de aproximativ 650MByte: conţine un mediu Desktop uşor. Are o amprenta pe disk chiar mai mică decât XFCE.  

 [Aplicații și unelte](cd-content-ro.htm#apps-tools) 

<div class="divider" id="system-requirements"></div>
## Cerințe de sistem minimale pentru KDE4 și XFCE

### AMD64

+ ##### Procesor CPU:
  
   <ul>  
   <li>AMD64  
+ Intel Core2  
+ Intel Atom Series (2xx/ 3xx, N4xx/ D4xx/ D5xx; the N2xx series does not support EM64T)  
+ VIA Nano  
+ orice procesor x86-64/ EM64T sau mai nou  
+ noile procesoare pe 64 bit (AMD Sempron și Intel Pentium 4) (căutați specificația "lm" în /proc/cpuinfo sau utilizați 'infobash -v3').  

</li>
<li>
##### Memorie RAM :

+  **KDE:** &ge;512 MB RAM (&ge;1 GB RAM recomandat), &ge;1 GB RAM pentru a rula liveapt.  
+  **XFCE:**  &ge;512 MB RAM.  

</li>
<li>Plăci grafice VGA cu rezoluție de cel puțin 640x480 pixeli.</li>
<li>Unitate optică (CD/DVD) sau un mediu USB.</li>
<li>&ge;minim 3 GB spațiu pe disc, &ge;10+ GB recomandat.</li>
</ul>
### i686

+ ##### Procesor (CPU):
  
   <ul>  
   <li>Intel Pentium pro/ Pentium II  
+ AMD K7 Athlon (nu K5/ K6)  
+ Intel Atom Series (Z5xx/ Z6xx, N2xx)  
+ VIA C3-2 (Nehemiah, nu C3 Samuel sau Ezra)/ C7  
+ orice procesor x86-64/ EM64T sau mai nou  
+ setul complet de comenzi i686 .  

</li>
<li>
##### Memorie RAM :

+  **KDE:**  &ge;512 MB RAM (&ge;1 GB RAM recomandat), &ge;1 GB RAM pentru  *liveapt* .  
+  **XFCE:**  &ge;512 MB RAM.  
+ With i686, only 3.1 to 3.4 GB RAM is accessible, amd64 (x86-64/ EM64T) is strongly recommended for 64 bit capable hardware.  

</li>
<li>Placă grafică VGA cu rezoluție de cel puțin 640x480 pixeli.</li>
<li>Unitate optică (CD/DVD) sau un mediu USB.</li>
<li>&ge;minim 3 GB spațiu pe disc, &ge;10+ GB recomandat.</li>
</ul>
<div class="divider" id="apps-tools"></div>
## Aplicaţii şi Unelte

ISO-ul siduction conţine o diversitate de programe şi unelte care acoperă aproape orice nevoie a unui utilizator de computer în viaţa de zi cu zi.

Choice of 2 major cutting edge Desktop Managers to access programs/applications:  
 [KDE4 (en + de),](http://www.kde.org/)  un desktop manager de top  
 [Xfce4 (en + de),](http://www.xfce.org/)  un desktop manager care cere resurse mai puține decât KDE.

 [Fluxbox (en + de)](http://fluxbox.org/)  este inclus în ambele variante ca alternativă fiind un desktop manager ușor. 

Pentru a naviga pe Internet, funcție de variantă (KDE sau XFCE, puteți folosi  [Konqueror](http://www.konqueror.org/)  și  [iceweasel](http://www.mozilla.com/) .

Office Productivity applications (again depending on the ISO variation range from  [LibreOffice](http://www.libreoffice.org/) ,  [Abiword](http://www.abisource.com/) ,  [Gnumeric](http:http://projects.gnome.org/gnumeric/) , through to file managers like Dolphin and Thunar, (to name only a few).

Pentru a configura conexiunea la rețea (Network) și Internet sunt  [Ceni](inet-ceni-ro.htm#netcardconfig)  iar pentru WIFI vedeți documentația  [WIFI Roaming](inet-wpagui-ro.htm)  .

Informații despre Non-free driver este  [aici](nf-firm-ro.htm#non-free-firmware) .

Pentru partiționarea hard disk-ului, punem la distoziție  [cfdisk](part-cfdisk-ro.htm#disknames)  și  [GParted](http://gparted.sourceforge.net/)  iar gparted are și capacitatea de a redimensiona partiții ntfs.

Unelte de Diagnosticare ca  [Memtest86+](http://www.memtest.org/) , un puternic instrument de diagnosticare a memoriei.

`Toate variantele ISO conțin un set complet de instrumente utilizabile în linie de comandă(CLI) . Un inventar complet al pachetelor (manifest) al fiecărei variante a versiunii este inclus în fiecare locație (download mirror):`  [Conținutul ISO , Versiuni, Locații de Download și Inscripționare](cd-dl-burning-ro.htm#download-siduction) .

###### Disclaimer

Acest software este experimental. Este folosit pe risc propriu. Proiectul siduction, dezvoltatorii săi şi membrii echipei nu pot fi făcuţi vinovaţi în nici o circumstanţă pentru deteriorarea de hardware sau software, pierderea de date sau orice alte distrugeri directe sau indirecte rezultate din folosirea acestui software. Dacă nu sunteţi de acord cu aceşti termeni şi condiţii nu vă este permis să folosiţi sau să distribuiţi mai departe acest software.

<div id="rev">Content last revised 30/11/2012 0815 UTC</div>
