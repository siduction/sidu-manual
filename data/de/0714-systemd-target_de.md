% Systemd - target

## systemd-target - Ziel-Unit

Die grundlegenden und einführenden Informationen zu Systemd enthält die Handbuchseite [Systemd-Start](0710-systemd-start_de.md#systemd-der-system--und-dienste-manager) Die alle Unit-Dateien betreffenden Sektionen *[Unit]* und *[Install]* behandelt unsere Handbuchseite [Systemd Unit-Datei](0711-systemd-unit-datei_de.md#systemd-unit-datei).  
Jetzt erklären wir die Funktion der Unit **systemd.target**, die den allgemein bekannten Runleveln ähneln, etwas ausführlicher.

Die verschiedenen Runlevel, in die gebootet oder gewechselt wird, beschreibt systemd als Ziel-Unit. Sie besitzen die Erweiterung ".target".

Mit systemd 258~rc1-1 (August 2025) wurde die Unterstützung der alten sysvinit-Befehle im laufenden System entfernt. Die Anpassung der Kernelbootzeile mit den sysvinit-Befehlen ist weiterhin möglich.

| Ziel-Unit | Beschreibung | 
| --- | -------- |
| **emergency.target** | Startet in eine Notfall-Shell auf der Hauptkonsole. Es ist die minimalste Version eines Systemstarts, um eine interaktive Shell zu erlangen. Mit dieser Unit kann der Bootvorgang Schritt für Schritt begleitet werden.| 
| **rescue.target** | Startet das Basissystem (einschließlich Systemeinhängungen) und eine Notfall-Shell. Im Vergleich zu multi-user.target könnte dieses Ziel als single-user.target betrachtet werden. |
| **multi-user.target** | Mehrbenutzersystem mit funktionierendem Netzwerk, ohne Grafikserver X. Diese Unit wird verwendet, wenn man X stoppen bzw. nicht in X booten möchte. [Auf dieser Unit wird in besonderen Fällen (wenn X selbst oder die Desktop-Umgebung aktualisiert werden) eine Systemaktualisierung (dist-upgrade) durchgeführt](0705-sys-admin-apt_de.md#full-upgrade-ausführen) . |
| **graphical.target** | Die Unit für den Mehrbenutzermodus mit Netzwerkfähigkeit und einem laufenden X-Window-System. |
| **default.target** | Die Vorgabe-Unit, die Systemd beim Systemstart startet. In siduction ist dies ein Symlink auf graphical.target (außer bei der Variante noX). |

Ein Blick in die Dokumentation `man SYSTEMD.SPECIAL(7)` ist obligatorisch um die Zusammenhänge der verschiedenen target-Unit zu verstehen.

### Besonderheiten

Bei den Ziel-Units sind drei Besonderheiten zu beachten:

1. Die Verwendung auf der Kernel-Befehszeile beim Bootvorgang.  
    Um im Bootmanager Grub in den Editiermodus zu gelangen, muss man beim Erscheinen der Bootauswahl die Taste **`e`** drücken. Anschließend hängt man an die Kernel-Befehszeile das gewünschte Ziel mit der folgenden Syntax: "systemd.unit=xxxxxxx.target" an. Die Tabelle listet die Kernel-Befehle und ihre noch gültigen numerischen Entsprechungen auf.

    | Ziel-Unit | Kernel-Befehl | Kernel-Befehl alt |
    | --------- | ------------- | :---: |
    | emergency.target | systemd.unit=emergency.target | - |
    | rescue.target | systemd.unit=rescue.target | 1 |
    | multi-user.target | systemd.unit=multi-user.target | 3 |
    | graphical.target | systemd.unit=graphical.target | 5 |

    Die alten Runlevel 2 und 4 verweisen auf multi-user.target

2. Die Verwendung im Terminal während einer laufenden Sitzung.
    Vorausgesetzt man befindet sich in einer laufenden graphischen Sitzung, kann man mit der Tastenkombination **`CTRL`**+**`ALT`**+**`F3`** zum virtuellen Terminal tty3 wechseln. Hier meldet man sich als User **root** an. Die folgende Tabelle listet die Terminal-Befehle auf, wobei der Ausdruck *"isolate"* dafür sorgt, dass alle Dienste die die Ziel-Unit nicht anfordert, beendet werden.

    | Ziel-Unit | Terminal-Befehl |
    | --------- | --------------- |
    | emergency.target | systemctl isolate emergency.target |
    | rescue.target | systemctl isolate rescue.target |
    | multi-user.target | systemctl isolate multi-user.target |
    | graphical.target | systemctl isolate graphical.target |


3. Ziel-Units, die nicht direkt aufgerufen werden sollen.  
    Eine ganze Reihe von Ziel-Units sind dazu da während des Bootvorgangs oder des .target-Wechsels Zwischenschritte mit Abhängigkeiten zu gruppieren. Die folgende Liste zeigt drei häufig verwendete Kommandos die **nicht** mit der Syntax "isolate xxxxxxx.target" aufgerufen werden sollen.

    | Ziel | Terminal-Befehl |
    | -------- | --------------- |
    | halt | systemctl halt |
    | shutdown | systemctl shutdown |
    | reboot | systemctl reboot |

    *"halt"*, *"shutdown"* und *"reboot"* holen mehrere Units in der richtigen Reihenfolge herein, um das System geordnet zu beenden und ggf. einen Neustart auszuführen.

### Quellen systemd-target

[Manpage systemd.target, de](https://manpages.debian.org/testing/manpages-de/systemd.target.5.de.html)

<div id="rev">Zuletzt bearbeitet: 2025-08-31</div>
