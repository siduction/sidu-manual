% Live-DVD verwenden

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

Änderungen 2020-06

+ 'suxterm' durch 'su' oder 'sudo' ersetzt.
+ Inhalte aktualisiert.
+ Link geprüft und korrigiert.

Änderungen 2020-12:

+ Für die Verwendung mit pandoc optimiert.
+ Inhalt teilweise überarbeitet.

ENDE   INFOBEREICH FÜR DIE AUTOREN

## Live-DVD verwenden

### Eingerichtete User der Live-DVD

Auf der Live-DVD sind die User '**siducer**' und '**root**' (der Systemadministrator) eingerichtet.

Für den User '**siducer**' ist das Passwort '**live**' gesetzt.  
Für den User '**root**' (Systemadministrator) ist kein Passwort gesetzt.

Die Live-Session wird nach geraumer Zeit ohne Eingaben gesperrt. Zum Entsperren bitte den User '**siducer**' mit dem Passwort '**live**' eingeben.

### Mit root-Rechten auf der Live-DVD arbeiten

Wir beschreiben nachfolgend mehrere Möglichkeiten, ein Programm mit root-Rechten auszuführen.

> **Achtung:**
> Wann immer man mit root-Rechten arbeitet, sollte man genau wissen, was man macht. Für das Surfen im Internet und ähnliche Aktionen sind keine root-Rechte nötig.

1.
  Am einfachsten man öffnet ein Terminal und verschafft sich mit der Eingabe "**su**" root-Rechte.  
  Um jetzt ein Programm, das mit graphischer Oberfläche arbeitet zu starten, einfach den Programmnamen eingeben. 

  ~~~
  root@siduction:~# geparted &
  ~~~

  Jetzt wird Gparted mit root-Rechten ausgeführt. Das "&" am Ende des Befehls bringt den Prozess in den Hintergrund und das Terminal bleibt weiter benutzbar.

2.
  Ein Befehlseingabefenster öffnen:  
  Die Tastenkombination `Alt` + `F2` benutzen um eine Programmstartzeile zu erhalten und darin den Befehl

  ~~~
  sudo <Anwendung>  
     oder  
  su-to-root -X -c <Anwendung>
  ~~~

  eingeben.  
  Es öffnet sich ein Terminalfenster, in dem das root-Passwort abgefragt wird. Nun einfach die `Enter`-Taste betätigen, es sei denn, es wurde wie weiter unten beschrieben ein temporäres root-Passwort gesetzt, das einzugeben ist.

3.
  In ein Terminal ohne root-Rechte den Befehl

  ~~~
  sudo <Anwendung> &
     oder
  su-to-root -X -c <Anwendung>
  ~~~

  eingeben.  

  Bitte beachten:  
  *sudo* ist auf Festplatteninstallationen nicht vorkonfiguriert. Wir empfehlen, den echten root-Account direkt zu nutzen.  
Siehe [warum sudo nicht konfiguriert ist](term-konsole_de.md#sudo)

### Ein neues Passwort setzen

Für den Fall, dass man auf einer siduction-*.iso ausgesperrt ist, wechselt man mit der Tastenkombination `Alt` + `Strg` + `F1` auf die erste virtuelle Konsole und gibt den Befehl **su** und anschließend **passwd siducer** ein.

~~~
siducer@siduction:~$ su
root@siduction:~# passwd siducer
Geben Sie ein neues Passwort ein:
Geben Sie das neue Passwort erneut ein:
passwd: Passwort erfolgreich geändert
root@siduction:~# exit
siducer@siduction:~$
~~~

Dieses neue Passwort für **siducer** kann den Rest der Live-Sitzung verwendet werden.  
Mit der Tastenkombination `Alt` + `F7` gelangt man wieder zur graphischen Oberfläche und meldet sich mit dem neuen Passwort an.

Mit der gleichen Prozedur kann man in jedem Terminal auch für root ein Passwort vergeben, allerdings ohne den Benutzernamen 'siducer' einzugeben. Im Anschluss ist eine Anmeldung auf einer virtuellen Konsole als 'root' möglich.

### Die Installation von Software während einer Live-DVD-Sitzung

Die Befehlsfolge für die Installation von Software während einer Live-Sitzung gleicht der bei einer Festplatteninstallation.

~~~
apt update
apt install <das-gewünschtes-paket>
~~~

Allerdings gilt: Wenn Du die Live-DVD herunterfährst, werden keine Änderungen behalten, außer wenn [fromiso und persist](hd-install-opts_de.md#fromiso-persist) aktiviert wird.

<div id="rev">Zuletzt bearbeitet: 2020-12-02</div>
