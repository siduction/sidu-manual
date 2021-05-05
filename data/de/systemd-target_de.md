% Systemd - target

ANFANG   INFOBEREICH FÜR DIE AUTOREN  
Dieser Bereich ist vor der Veröffentlichung zu entfernen !!!  
**Status: RC2**

Änderungen 2021-02:

+ Neu "Init-System - .target Ziel-Unit"
+ Für die Verwendung mit pandoc optimiert.

ENDE   INFOBEREICH FÜR DIE AUTOREN

## systemd-target - Ziel-Unit

Die grundlegenden und einführenden Informationen zu Systemd enthält die Handbuchseite [Systemd-Start](./systemd-start_de.md#systemd-der-system--und-dienste-manager) Die alle Unit-Dateien betreffenden Sektionen *[Unit]* und *[Install]* behandelt unsere Handbuchseite [Systemd Unit-Datei](./11-systemd-unit-datei_de.md#systemd-unit-datei).  
Jetzt erklären wir die Funktion der Unit **systemd.target**, die den allgenein bekannten Runleveln ähneln, etwas ausführlicher.

Die verschiedenen Runlevel, in die gebootet oder gewechselt wird, beschreibt systemd als **Ziel-Unit**. Sie besitzen die Erweiterung **.target**.

Die alten sysvinit-Befehle werden weiterhin unterstützt. (Hierzu ein Zitat aus *man systemd*: "... wird aus Kompatibilitätsgründen und da es leichter zu tippen ist, bereitgestellt.")

| Ziel-Unit | Beschreibung | 
| --- | -------- |
| **emergency.target** | Startet in eine Notfall-Shell auf der Hauptkonsole. Es ist die minimalste Version eines Systemstarts, um eine interaktive Shell zu erlangen. Mit dieser Unit kann der Bootvorgang Schritt für Schritt begleitet werden.| 
| **rescue.target** | Startet das Basissystem (einschließlich Systemeinhängungen) und eine Notfall-Shell. Im Vergleich zu multi-user.target könnte dieses Ziel als single-user.target betrachtet werden. |
| **multi-user.target** | Mehrbenutzersystem mit funktionierendem Netzwerk, ohne Grafikserver X. Diese Unit wird verwendet, wenn man X stoppen bzw. nicht in X booten möchte. [Auf dieser Unit wird eine Systemaktualisierung (dist-upgrade) durchgeführt](sys-admin-apt_de.md#full-upgrade-ausführen) . |
| **graphical.target** | Die Unit für den Mehrbenutzermodus mit Netzwerkfähigkeit und einem laufenden X-Window-System. |
| **default.target** | Die Vorgabe-Unit, die Systemd beim Systemstart startet. In siduction ist dies ein Symlink auf graphical.target (außer NoX). |

Ein Blick in die Dokumentation "*man SYSTEMD.SPECIAL(7)*" ist obligatorisch um die Zusammenhänge der verschiedenen *.target-Unit* zu verstehen.

### Besonderheiten

Bei den Ziel-Unit sind drei Besonderheiten zu beachten:

1. Die Verwendung auf der **Kernel-Befehszeile** beim Bootvorgang.  
    Um im Bootmanager Grub in den Editiermodus zu gelangen, muss man beim Erscheinen der Bootauswahl die Taste `e` drücken. Anschließend hängt man an die Kernel-Befehszeile das gewünschte Ziel mit der folgenden Syntax: "systemd.unit=xxxxxxx.target" an. Die Tabelle listet die Kernel-Befehle und ihre noch gültigen Entsprechungen auf.

    | Ziel-Unit | Kernel-Befehl | Kernel-Befehl alt |
    | --------- | ------------- | :---: |
    | emergency.target | systemd.unit=emergency.target | - |
    | rescue.target | systemd.unit=rescue.target | 1 |
    | multi-user.target | systemd.unit=multi-user.target | 3 |
    | graphical.target | systemd.unit=graphical.target | 5 |

    Die alten Runlevel 2 und 4 verweisen auf multi-user.target

2. Die Verwendung im **Terminal** während einer laufenden Sitzung.
    Vorrausgesetzt man befindet sich in einer laufenden graphischen Sitzung, kann man mit der Tastenkombination **`CTRL`** + **`ALT`** + **`F2`** zum virtuellen Terminal tty2 wechseln. Hier meldet man sich als User **root** an. Die folgende Tabelle listet die **Terminal-Befehle** auf, wobei der Ausdruck *isolate* dafür sorgt, dass alle Dienste die die Ziel-Unit nicht anfordert, beendet werden.

    | Ziel-Unit | Terminal-Befehl | init-Befehl alt |
    | --------- | --------------- | :----: |
    | emergency.target | systemctl isolate emergency.target | - |
    | rescue.target | systemctl isolate rescue.target | init 1 |
    | multi-user.target | systemctl isolate multi-user.target | init 3 |
    | graphical.target | systemctl isolate graphical.target | init 5 |


3. Ziel-Unit, die **nicht direkt aufgerufen** werden sollen.  
    Eine ganze Reihe von Ziel-Unit sind dazu da während des Bootvorgangs oder des .target-Wechsels Zwischenschritte mit Abhängigkeiten zu gruppieren. Die folgende Liste zeigt drei häufig verwendete Kommandos die **nicht** mit der Syntax "isolate xxxxxxx.target" aufgerufen werden sollen.

    | Ziel | Terminal-Befehl | init-Befehl alt |
    | -------- | --------------- | :--------: |
    | halt | systemctl halt | - |
    | poweroff | systemctl poweroff | init 0 |
    | reboot | systemctl reboot | init 6 |

    *halt*, *poweroff* und *reboot* holen mehrere Unit in der richtigen Reihenfolge herein, um das System geordnet zu beenden und ggf. einen Neustart auszuführen.

### Quellen systemd-target

[Manpage systemd.target, de](https://manpages.debian.org/testing/manpages-de/systemd.target.5.de.html)

<div id="rev">Seite zuletzt aktualisert 2021-02-14</div>
