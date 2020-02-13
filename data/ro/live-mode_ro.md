<div id="main-page"></div>
<div class="divider" id="rootpw"></div>
## siduction-*.iso - Parola de  *root*  în Live Mode 

<p class='highlight-2'>Atenţie : Întotdeauna când executaţi ceva cu permisiuni de  *root*  trebuie să știţi foarte bine ce faceţi! Doar pentru navigare pe internet sau în reţeaua locală nu este nevoie de permisiune  *root* .</p>
### siduction-*.iso parola implicită (default)

Pe siduction LiveCD implicit nu este setată nici o parolă de  *root* . Ca să rulaţi un program care cere privilegii de  *root*  aveţi câteva posibilităţi :

Metoda cea mai simplă= tipăriți în terminal:

~~~  
sux  
~~~

###### Setarea ( temporară ) a unei parole de  *root*  

Deschideţi o consolă / terminal :

~~~  
siduction@0[siduction]$ sudo passwd  
Enter new UNIX password:  
Retype new UNIX password:  
passwd: password updated successfully  
siduction@0[siduction]$  
~~~

acum puteţi folosi această parolă pentru restul sesiunii live.

`'sudo' nu funcționează imlicit într-o instalare pe hard disk; vedeți`  [sudo](term-konsole-ro.htm#sudo)  and  [sux](term-konsole-ro.htm#sux) .

###### Rularea unui program ca  *root*  dintr-o consolă

Tastarea comenzii `sux`  vă va da privilegii de  *root*  pentru aplicații X.

Deschideţi o consolă / shell:

~~~  
siduction@0[siduction]$ sux  
root@0[siduction]# gparted  *( sau orice altceva doriţi...)*   
~~~

O altă opțiune generică pentru toate Desktop Manager-ele mai cunoscute este:

~~~  
Alt+F2 su-to-root -X -c  *<Application>*   
~~~

De examplu:

~~~  
Alt+F2 su-to-root -X -c gparted  
~~~

`Pentru a termina sesiunea de  *root*  în konsolă tastaţi :`

~~~  
exit  
~~~

sau daţi click pe colţul din dreapta sus pentru a închide konsola.

**`În cazul unei blocări a siduction-*.iso trebuie să executați următoarele operațiuni și să urmați ceea ce vi se va cere pentru a seta o parolă:`** 

~~~  
alt+ctrl+F1  
sudo passwd  
~~~

După ce parola este activă, procedați astfel:

~~~  
alt+ctrl+F7  
~~~

<div class="divider" id="live-cd-installsoft"></div>
## Instalarea programelor când rulaţi de pe Live-CD

~~~  
apt-get update  
apt-get install  *<nume_program>*   
~~~

 **Reţineţi:**  când veţi opri lucrul de pe Live-CD toate schimbările se vor pierde. Folosiți un email ca să vă salvați lucrările, cu excepția cazului în care ați pornit cu opțiunile  [*fromiso*  și  *persist*](hd-install-opts-ro.htm#fromiso-persist) .

<div id="rev"> Content last revised 30/11/2012 0900 UTC</div>
