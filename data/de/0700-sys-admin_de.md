% Systemadministration

# Systemadministration

Dieser Abschnitt beinhaltet Informationen und Hinweise zur/zum

+ [Terminal - Kommandozeile](0701-term-konsole_de.md#terminal---kommandozeile), grundlegende Einführung, Arbeit als root, farbiges Terminal, Hilfe im Terminal und Skripte benutzen.

+ [Doas - Alternative zu Sudo](0703-sys-admin-doas_de.md#doas---alternative-zu-sudo), unsere Empfehlung für all jene, die sudo vermissen.

+ [Systemadministration allgemein](0702-sys-admin-gen_de.md#systemadministration-allgemein) Kurz und knapp, ein Streifzug durch die Systemadministration; Bootoptionen, systemd - Dienste verwalten, Prozesse beenden, Passwörter verwalten, Schriftarten in siduction, das Drucksystem CUPS und Sound in siduction.

+ [Btrfs Dateisystem in siduction](0704-sys-admin-btrfs-snapper_de.md#btrfs). Die Subvolumen nach der Installation. Neue Subvolumen anlegen und verwalten. Snapshot in Btrfs.

+ [Btrfs Snapshots mit Snapper](0704-sys-admin-btrfs-snapper_de.md#snapper) erstellen und verwalten. Die Konfiguration von Snapper und die Zusammenarbeit mit systemd. System Rollback und Wiederherstellung von Dateien.

+ [APT Paketverwaltung](0705-sys-admin-apt_de.md#apt-paketverwaltung), Paketquellen, Pakete verwalten, Aktualisierung des Systems, Programmpakete suchen und warum ausschließlich apt verwendet werden soll. 

+ [Lokaler APT-Mirror](0706-sys-admin-apt-localmirr_de.md#lokaler-apt-mirror); Apt-Cacher, der Proxy-Server für Debian-Pakete. Server installieren und die Client Konfiguration.

+ [Nala für das Paketmanagement](0707-sys-admin-nala_de.md#nala-paketverwaltung), Ein Front-End, dass APT für den Anwender optimiert und beschleunigt.

+ [Neue Kernel installieren](0708-sys-admin-kern-upg_de.md#kernel-upgrade), Kernel-Aktualisierung ohne Systemaktualisierung, 3rd Party Module und alte Kernel entfernen.

+ [Systemd der System- und Dienste-Manager](0710-systemd-start_de.md#systemd-der-system--und-dienste-manager), Konzeption des systemd, Unit Typen, Systemd im Dateisystem und die Handhabung von Diensten.

    + [Die systemd unit-Datei](0711-systemd-unit-datei_de.md#systemd-unit-datei), Verzeichnisse und Hierarchien der Unit-Dateien, die Eingliederung in systemd, der Aufbau der Unit-Datei mit Beschreibung zahlreicher Optionen, die Funktion der Unit-Dateien am Beispiel von CUPS und die Werkzeuge, die systemd bereitstellt,

    + [systemd-service Unit](0712-systemd-service_de.md#systemd-service), eine service-Unit anlegen und die Beschreibung aller wesentlichen Optionen.

    + [systemd-mount Unit](0713-systemd-mount_de.md#systemd-mount), Inhalt der mount-Unit, Inhalt der automount-Unit, Namenskonventionen, Einsatzbereiche und einige Beispiele.

    + [systemd-target - Ziel-Unit](0714-systemd-target_de.md#systemd-target---ziel-unit), von Runlevel zu systemd-target, zu berücksichtigende Besonderheiten. 

    + [systemd-path Unit](0715-systemd-path_de.md#systemd-path), die benötigten Dateien, die Optionen der path-Unit, path-Unit anlegen und eingliedern und das Beispiel "Überwachung von DocumentRoot des Apache Webservers".

    + [systemd-timer Unit](0716-systemd-timer_de.md#systemd-timer), die benötigten Dateien, die Optionen der timer-Unit, timer-Unit anlegen und eingliedern, timer-Unit als cron Ersatz.

+ [Systemjournal](0717-systemd-journald_de.md#systemjournal), der journald lokal und über das Netzwerk, journald konfigurieren, Abfrage des systemd-Journals mit journalctl, die Ausgaben filtern und steuern, Beispiele um journalctl zu beherrschen.

<div id="rev">Zuletzt bearbeitet: 2022-12-21</div>
