% Doas

## Doas - Alternative zu Sudo

Wir, das siduction Team, haben uns für einen echten Root-Account entschieden und Sudo nicht konfiguriert. Für Benutzer die Sudo gewohnt sind und nicht auf seine Funktionalität verzichten möchten, bietet sich die schlanke Alternative Doas an. Doas ist, im Vergleich zu Sudo mit nur etwa 1/100 an Codezeilen, auf Desktop-Systeme zugeschnitten. Mit *siduction 2021.3 wintersky* wird Doas in Version 6.8.1-3 automatisch installiert, ist jedoch noch nicht vollständig konfiguriert.

### Doas konfigurieren

Um Doas benutzen zu können fehlt einzig die Konfigurationsdatei `/etc/doas.conf`. Sie enthält zeilenweise Regeln, die Aktionen einem Benutzer zuweisen. Eine `#` leitet Kommentare ein. Die Zeilen liest Doas nacheinander, wobei die Aktion der letzten zutreffenden Regel ausgeführt wird. Für das Verständnis der Regeln in der Konfigurationsdatei sind einige Dinge zu beachten.  
- Nur Aktionen, für die mindestens eine Regel zutrifft, werden ausgeführt.
- Dadurch, dass Doas die Regeln zeilenweise nacheinander auswertet, lassen sich Hierarchien aufbauen.
- Bei Regeln die Kommandos mit Argumenten enthalten, sind die Argumente exakt und vollständig anzugeben.
- Regeln mit Kommandos die variable Argumente benötigen sind nicht möglich.
- Doas prüft vor der Ausführung der angeforderten Aktion die Syntax der Konfigurationsdatei. Bei fehlerhaften Regeln erfolgt die Ausgabe `doas: syntax error at line 4` und Doas beendet sich. Der schreibende Zugriff auf die Konfigurationsdatei ist dann nur mit dem Root-Account möglich.

Besonders einfach ist die Konfiguration, wenn auf dem siduction System nur ein User-Account existiert. Eine einzige Zeile reicht um mittels vorangestelltem "doas " Befehle mit root-Rechten auszuführen.  
Melde dich in einem Terminal als root an und führe folgenden Befehl aus, wobei "tux" durch den Namen deines Benutzer-Account zu ersetzen ist. 

~~~txt
tux@sidu:~$ su
Passwort:
root@sidu:/home/tux# echo "permit keepenv nopass tux" > /etc/doas.conf
root@sidu:/home/tux# exit
tux@sidu:~$
~~~

Die Konfigurationszeile setzt sich zusammen aus:  
Der Aktion *permit|deny* (erlauben|verbieten) mit  
der Option *keepenv* (Umgebungsvariablen beibehalten - ermöglicht das Starten von graphischen Programmen wie gparted),  
der Option *nopass|persist* (keine Passwortabfrage|die einmalige Passwort Eingabe bleibt einen begrenzten Zeitraum gültig) und  
dem Benutzer *tux*, auf den die Aktion anzuwenden ist.

Steht der Benutzername für sich allein, so darf *tux* Befehle als beliebiger, auf dem System vorhandener Benutzer ausführen. Die Vorgabe ist *root*. Soll die Ausführung der Aktion nur mit den Rechten eines anderen Benutzers als **root** erlaubt sein, ist der Name innerhalb der Regel anzugeben (z.B. *tux as anne*). Statt des Benutzers kann durch das Voranstellen eines **`:`** eine Gruppe (z.B. *:vboxusers*) Berechtigungen erlangen.

### Doas und mehrere Benutzer

**Beispiel**  
Auf dem Arbeitsplatz-PC dürfen sich außer *tux* drei weitere Benutzer mit den Namen *anne*, *bob* und *lisa* anmelden.  
Anne möchte nur Bob erlauben zwei ihrer Skripte aus ihrem /home Verzeichnis auszuführen. Die Rechte an ihren Skripten hat Anne restriktiv auf 700 gesetzt.  
Lisa ist besonders vertrauenswürdig, weshalb sie für die Systemupgrades zuständig sein soll.

Wir nutzen als *tux* sogleich Doas in einem Terminal um die Konfigurationsdatei zu bearbeiten.

~~~txt
tux@sidu:~$ doas mcedit /etc/doas.conf
~~~

Die zuvor genannten Berechtigungen setzen wir in Regeln um und ergänzen die Datei um einige Kommentare.

~~~txt
# doas config file /etc/doas.conf

# tux erhält root-Rechte
permit keepenv nopass tux

# bob darf script von anne ausführen
permit bob as anne cmd /home/anne/bin/script1 args -n
permit bob as anne cmd /home/anne/bin/script2 args

# lisa darf Systemupgrade ausführen
deny lisa cmd init
permit persist lisa as root cmd init args 3
permit persist lisa as root cmd init args 6
permit persist lisa as root cmd apt args update
permit persist lisa as root cmd apt args full-upgrade
~~~

**Erklärungen**  
**Bob** darf die Skripte *script1* und *script2* innerhalb Annes /home Verzeichnis ausführen. Ersteres ausschließlich mit der Argument *-n*, dem Zweiten darf kein Argument mitgegeben werden. Die Angabe von *args* in der Regelzeile für das *script2* ohne ein folgendes Argument, erzwingt den Aufruf der Datei ohne Argument und damit ohne möglicherweise schädlichen Code. Bob muss dem Aufruf der Skripte mit der Option *-u* den Benutzernamen mitgeben.

~~~txt
bob@sidu:~$ doas -u anne /home/anne/bin/script1 -n
doas (bob@sidu) password:

bob@sidu:~$
~~~

Das Skript wurde nach Eingabe des Benutzerpasswortes von Bob ohne Kommentar ausgeführt.

Damit **Lisa** das Systemupgrade ausführen kann, soll sie zum *multi-user.target* (init 3) wechseln und nach Abschluss einen *systemctl reboot* (init 6) durchführen. Die Regelzeile `deny lisa cmd init` ohne die Angabe von *args* bewirkt, dass alle anderen Aufrufe von init außer denen in den beiden nachfolgenden Regeln, nicht erlaubt sind. Deshalb kann sie nicht direkt vom *multi-user.target* in das *graphical.target* (init 5) wechseln. Hier sehen wir den Aufbau einer Hierarchie.

**Hinweise**  
Wer immer wieder *sudo* eintippt, dem hilft die Zeile `alias sudo="doas"` in seiner .bashrc.  
Doas spielt seinen entscheidenden Vorteil dort aus, wo nur einem User mittels *doas* root-Rechte erteilt werden. Das obige Beispiel mit Lisa zeigt, wie umfangreich die Konfiguration für eine eingeschränkte Rechtevergabe werden kann. Außerdem ist eine Regel für einen Programmaufruf mit variablen Argumenten (z.B. *apt install \<Paketname\>*) nicht möglich.

**Quellen**  
man doas  
man doas.conf  
[github, doas](https://github.com/slicer69/doas)  
[LinuxNews, Linux Rechtemanagement, sudo durch doas ersetzen](https://linuxnews.de/2020/10/linux-rechtemanagement-sudo-durch-doas-ersetzen/)  
[LinuxUser 08.2021, Kleiner Bruder](https://www.linux-community.de/ausgaben/linuxuser/2021/08/mit-doas-statt-sudo-administrative-aufgaben-erledigen/)

<div id="rev">Zuletzt bearbeitet: 2022-02-26</div>
