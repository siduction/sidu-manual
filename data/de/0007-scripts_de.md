% siduction Skripte

## Skripte in siduction

siduction enthält einige Skripte, die administrative Aufgaben unterstützen und bei der Fehlersuche behilflich sind.

### Vom Benutzer ausführbar

- **chroothelper**  
  *Wechsel in eine chroot-Umgebung*

  *chroothelper* vereinfacht den Wechsel in eine chroot-Umgebung auf dem Live-System. Es durchsucht die Festplatten nach installierten Linux Betriebssystemen und bietet einen Wechsel in diese mittels chroot an.

- **sshactivate** und **sshdeactivate**  
  *Startet und aktiviert sshd oder stopt und deaktiviert sshd*

  *sshactivate* erzeugt sshd-Systemschlüssel, startet und aktiviert den ssh-Daemon und fragt nach dem Benutzerpasswort, um den Fernzugriff auf das (Live-)System zu ermöglichen.  
  *sshdeactivate* stoppt und deaktiviert den ssh-Daemon.

- **fw-detect**  
  *Prüft den Firmwarestatus im System.*

  *fw-detect* scannt die geladenen Module auf Ihrem System, prüft, ob sie Firmware benötigen und ob diese im richtigen Verzeichnis vorhanden ist.  
Standardmäßig gibt fw-detect nur Informationen über Module aus, die allem Anschein nach Firmware benötigen.

- **siduction-irc**  
  *Startet eine IRC-Sitzung zu #siduction-de*

  *siduction-irc* startet eine IRC-Sitzung mit folgenden Clients (je nach Umgebung): HEXCHAT, IRSSI, KONVERSATION, KVIRC, WEECHAT, XCHAT und verbindet sich mit unserem IRC-Kanal #siduction-de auf [OFTC](https://www.oftc.net).

- **remove-nonfree**  
  *Für eine DFSG konforme Installation*

  *remove-nonfree* macht die Installation DFSG-konform. Das ausführen, kann zu einem nicht funktionierenden WLAN oder zu Problemen mit der Grafikkarte führen.

- **kernel-remover**  
  *Entfernt siduction Kernel*

  *kernel-remover* entfernt unbenutzte Kernel aus dem laufenden System. Es bietet eine Auswahl der Kernel, entfernt die gewählten und aktualisiert das Bootmenü.

### Im Hintergrund laufend

- **siduction-btrfs**  
  *Überprüft und aktualisiert das Bootmenü*

  *siduction-btrfs* ist eine Zusammenstellung von Skripten und systemd Units, die auf einer Installation in das Btrfs Dateisystem aktiv wird. Nach einem Snapshot oder Rollback wird das Bootmenü überprüft und gegebenenfalls aktualisiert. *siduction-btrfs* arbeitet im Hintergrund ohne Benutzereingaben.

<div id="rev">Zuletzt bearbeitet: 2023-12-08</div>
