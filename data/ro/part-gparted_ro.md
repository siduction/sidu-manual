<div id="main-page"></div>
<div class="divider" id="partition"></div>
## Partiţionare Hard Discului folosind Gparted/KDE Partition Manager

##### **`ATENŢIE !: pentru numirea discurilor`**  [Vă rugăm consultaţi UUID, Etichetarea partiţiilor şi fstab, pentru că implicit siduction acum foloseşte UUID](part-uuid-ro.htm) 

##### Rularea programelor de partiționare se face de către administrator (root), deci tipăriți într-un terminal `sux`  apoi parola de root. Pe un Live-ISO nu este setată niciuna deci tipăriți `sux`  apoi apăsați 'enter'. Vedeți și:  [Modul "Live"](live-mode-ro.htm) 


---


::: warning  
**Achtung**  
După redimensionarea unei partiţii NTFS vi se va cere să reporniţi sistemul! NU FACEŢI nici o altă operaţiune pe această partiţie înainte de repornire, în caz contrar vor apare erori. [Vă rugăm CITIȚI aici.](part-gparted-ro.htm#ntfs)   
:::

**`Întotdeauna salvaţi-vă datele!`**

### Informații de bază

Orice partiţie trebuie să aibă un sistem de fişiere. Linux ştie să folosească diferite sisteme de fişiere. Există ReiserFs, Ext4 iar pentru utilizatorii experimentaţi XFS şi JFS. Ext2 este foarte la îndemână ca format de stocare atâta vreme cât există un disc MS Windows&#8482; pentru schimbul de date.  [Ext2 Installable File System For MS Windows](http://www.fs-driver.org/) .

**`Pentru utilizare uzuală recomandăm tipul ext4. Este sistemul de fişiere implicit pentru siduction şi este foarte bine întreţinut.`**

## Utilizarea  *KDE Partition Manager*  &amp;  *Gparted* 

Crearea și administrarea partițiilor nu sunt activități pe care să le executați zilnic. În consecință, ar fi bine să citiți acest ghid o dată și să vă familiarizați cu noțiunile și unele ferestre care vor apare.

### KDE Partition Manager - rulați într-un terminal:

~~~  
sux  
partitionmanager  
~~~

### Gparted - rulați într-un terminal:

~~~  
sux  
gparted  
~~~

+ Când GParted sau KDE Partition Manager rulează, o fereastră se deschide și discurile sunt scanate.
  
   În KDE Partition Manager discurile apar într-o listă în partea stângă.
  
   ![KDE Partition Manager partition information](../images-common/images-kpart/kpart-02.png "KDE Partition Manager partition information") 
  
   În Gparted, dacă dați click pe menu (în stânga-sus), o listă derulantă este prezentată. Puteți alege și împrospătarea afișării discurilor din sistemul vostru.
  
   ![gparted](../images-common/images-gparted/gparted02-en.png "Gparted Devices View") 
  

###### **`Următoarele screenshot-uri sunt ale Gparted. KDE Partition Manager arată foarte asemănător.`** 

+ ### Edit
  
   Meniul Edit are trei funcții care pot fi cruciale entru voi:  
`Undo last operations`   
`Apply`   
`Clear all operations` .
  
+ ### View
  
   <ul>  
   <li>  
   #### Device Information
  
   Fereastra  **Harddisk Information**  afișează detalii despre Hard Disc cum ar fi Model, Mărime (Size) etc. Această fereastră este foarte utilă într-un sistem cu mai multe discuri unde informaţiile sunt folosite să confirme că discul examinat este chiar cel dorit.
  
   ![operation view](../images-common/images-gparted/gparted03-en.png "Gparted Harddisk Information") 
  
+ #### Pending Operations
  
   În bara de jos a ferestrei este lista cu operaţiunile care aşteaptă să fie executate. Informaţia este folositoare pentru că oferă detalii despre numărul de operaţiuni în aşteptare.
  

</li>
<li>
### Device

Meniul Device permite setarea unei etichete de disc. Dacă cea curentă este nepotrivită, puteţi să o schimbaţi folosind această opţiune.

</li>
<li>
### Partition Menu

Acest meniu este de importanţă majoră. Permite să faceţi multe operaţii, unele dintre ele chiar periculoase.

`Delete`  este selectat dacă doriţi să stergeţi o partiţie. Pentru a executa ştergerea, întâi trebuie să selectaţi partiţia.

`Resize/Move`  este o funcţie folositoare.

</li>
<li>
### Crearea unei noi partiţii

În bara de unelte, butonul  **New**  permite să creezi o nouă partiţie, dacă aţi selectat deja un spaţiu nealocat de pe disc. Apare o nouă fereastră care vă lasă să alegeţi mărimea dorită, tipul partiţiei - Primary, Extended sau Logical, precum şi sistemul de fişiere dorit.

![file system](../images-common/images-gparted/gparted07-en.png "Gparted New Partition") 

</li>
<li>
### Dacă aţi făcut o greşeală

Dacă aţi făcut o greşeală puteţi folosi butonul "Delete" pentru a şterge partiţia aleasă sau, dacă nu s-a aplicat încă schimbarea, folosiţi butonul "Undo".

![delete](../images-common/images-gparted/gparted04-en.png "Gparted Delete") 

</li>
<li>
### Redimensionarea /Mutarea

Când doriţi redimensionarea unei partiţii selectate apăsaţi butonul  **Resize/Move** : o nouă fereastră va apare. Folosiţi mouse-ul pentru a reduce (sau creşte) mărimea partiţiei alese sau dacă preferaţi folosiţi săgeţile.

![resize / move](../images-common/images-gparted/gparted05-en.png "Gparted Resize") 

După ce comanda "Resize" a fost dată, apăsaţi pe "Apply" pentru că nici o operaţie nu este făcută pe Hard Disc până când nu apăsaţi acest buton.

![operation view](../images-common/images-gparted/gparted09-en.png "Gparted Apply") 

Durata operaţiilor depinde de noua mărime a partiţiilor.

**`După manipularea tabelei de partiţii vă rugăm ieşiţi din siduction şi reporniţi sistemul în siduction pentru a fi recitită noua tabelă de alocare a partiţiilor.`** 

</li>
</ul>
<div class="divider" id="ntfs"></div>
## Redimensionarea partiţiilor NTFS 


::: warning  
**Achtung**  
După redimensionarea unei partiţii NTFS vi se va cere să reporniţi sistemul! NU FACEŢI nici o altă operaţiune pe această partiţie înainte de repornire, în caz contrar vor apare erori.  
:::

+ După pornirea în MS Windows&#8482;, sistemul vă va arăta un ecran special şi un mesaj despre consistenţa discului: Checking file system on c:  
+ Lăsaţi AUTOCHK să ruleze: NT trebuie să-şi verifice sistemul de fişiere după operaţiunea de redimensionare.  
+ La finalul acestui proces, computerul se va restarta automat pentru a doua oară. Aceasta asigură că totul a mers perfect.  
+ După restart, Windows XP va fi în regulă, dar trebuie să lăsaţi sistemul să termine procesul de pornire şi să asteptaţi ecranul de login!  

 **Documentaţie Completă GParted** :Pentru a citi documentaţia completă, inclusiv Cum Să copiaţi partiţiile, mergeţi la  [GParted](http://gparted.sourceforge.net) 

<div class="divider" id="hd-ntfs3g"></div>
## Scrierea pe partiții NTFS cu ntfs-3g

**` **Atenţie** : Chiar dacă  *'ntfs-3g'*  este considerat ca  *'stable'* , niciodată nu-l folosiţi fără salvarea prealabilă a datelor şi, bineînteles, nu pe sisteme productive! Dacă nu ţineţi cont de aceasta, vina pentru pierderea de date vă aparţine. Folosiţi pe risc propriu!`**

Deschideţi o consolă şi introduceţi următoarele comenzi: Vedeţi și  [Partiţionarea HardDiscurilor - Numirea Discurilor](part-cfdisk-ro.htm) 

~~~  
sux  
apt-get update && apt-get install ntfs-3g  
umount /media/xdxx  
mount -t ntfs-3g /dev/disk/by-uuid/xxyyzz[etc] /media/xdxx  
Pentru a ieși din poziția de  root  tastați:  
exit  
~~~

Acum partiţia NTFS ar trebui să fie mount-ată  **rw**  şi să puteţi scrie date pe ea. Dar, încă o dată, aveţi grijă! `Utilizaţi doar în situaţii de urgentă, nu este recomandat pentru utilizarea zilnică.` 

<div id="rev">Content last revised 30/11/2012 0200 UTC</div>
