<div class="divider" id="rootpw"></div>

## siduction-*.iso - Das root-Passwort auf der Live-CD

**`Achtung:`** `Wann immer man mit root-Rechten arbeitet, sollte man wissen, was man macht. Für das Surfen im Internet sind keine root-Rechte nötig.Sollte eine Live-session gesperrt sein, hilft die Eingabe von` **`siducer`** `als User und` **`Live`** `als Passwort zum Entsperren`
### Passwort auf siduction-*.iso

Auf der Live-CD ist kein root-Passwort gesetzt. Es gibt mehrere Möglichkeiten, ein Programm mit root-Rechten auszuführen.

Am einfachsten ist diese Eingabe:

~~~
su
~~~

### Ein (temporäres) root-Passwort setzen

Eine Konsole öffnen:

~~~
siduction@0[siduction]$ sudo passwd
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
siduction@0[siduction]$
~~~

Dieses Passwort kann den Rest der Live-Sitzung verwendet werden.

`sudo ist auf Festplatteninstallationen nicht vorkonfiguriert. Wir empfehlen, den echten root-account direkt zu nutzen.`

Siehe [sudo](term-konsole-de.htm#sudo)  und [suxterm](term-konsole-de.htm#suxterm) .

### Starten eines Programms aus einer Root-Konsole

Die Eingabe von `suxterm`  ermöglicht root mit Xapp-Privilegien (Start von Programmen mit graphischer Oberfläche).

Man öffnet ein Terminal/eine Konsole:

~~~
siduction@0[siduction]$ suxterm
root@0[siduction]# gparted &  *(oder das gewünschte Programm)* 
~~~

Eine andere Möglichkeit für alle Desktop-Umgebungen ist:

~~~
Alt+F2 su-to-root -X -c <Anwendung2
~~~

Zum Beispiel:

~~~
Alt+F2 su-to-root -X -c gparted
~~~

 `Um den root-Modus zu verlassen, tippt man in die Konsole:`

~~~
exit
~~~

oder man klickt das "x" in der rechten oberen Ecke zum Schließen des Konsolenfensters.

**`Falls man auf einer siduction-*.iso ausgesperrt ist, gibt man folgenden Befehl ein und folgt den Anweisungen, um ein Passwort zu setzen:`** 

~~~
alt+ctrl+F1
sudo passwd
~~~

Wenn das Passwort aktiv ist, wird folgende Aktion durchgeführt:

~~~
alt+ctrl+F7
~~~

<div class="divider" id="live-cd-installsoft"></div>

### Die Installation von Software während einer Live-CD-Sitzung

~~~
apt-get update
apt-get install ihr-gewünschtes-paket
~~~

Achtung: Wenn Du die Live-CD herunterfährst, werden keine Änderungen behalten, außer wenn [fromiso und persist](hd-install-opts-de.htm#fromiso-persist)  aktiviert wird.

<div id="rev">Page last revised 26/11/2014 2000 UTC</div>
