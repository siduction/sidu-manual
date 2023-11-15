% Schnellinstallation

## Schnellinstallation

1) Auf der [siduction Downloadseite](https://siduction.org/installation-media/) das bevorzugte Flavour aussuchen und die ISO-Datei, sowie die Datei mit der zugehörigen Checksumme herunterladen.  
  Anschließend den Download wie [hier beschrieben](0206-iso-dl_de.md#integritätsprüfung) prüfen.

2) Die ISO-Datei auf ein bootbares Medium übertragen.  
  Hilfe bieten die Anleitungen für [einen USB Stick oder eine SD Karte](0207-iso-to-usb-sd_de.md#iso-auf-usb-stick---speicherkarte) oder zum [Brennen auf eine DVD](0208-iso-to-dvd_de.md#iso-brennen).  

3) Das so erstellte siduction Live Medium booten.  
  **Wichtig:**  
  Während des Bootvorgangs das EFI Menü aufrufen (je nach Hersteller eine der Tasten **`Entf`**, **`F2`**, **`F11`**... drücken).  
  Im EFI Menü sowohl den *CSM (Compatibility Support Module)* Modus, als auch *Secure Boot* deaktivieren.  
  Ebenfalls im EFI Menü das Live Medium zum booten auswählen.

4) Im Bootmenü des Live Mediums die gewünschte Sprache einstellen und siduction booten.  
  Der Benutzer im Live Medium ist **siducer** sein Passwort lautet **live**.  
  Für den Benutzer **root** (Systemadministrator) ist im Live Medium kein Passwort gesetzt. Im Terminal entweder **`sudo <Befehl>`** ausführen, oder mit der Eingabe von **`su`** zu root werden.

5) Ein Doppelklick auf das Icon **`System installieren`** startet die Installation auf die Festplatte.  
  Wenn manuell partitioniert wird, darauf achten, dass die erste Partition die EFI System Partition (esp) ist und die Markierungen *boot* und *esp* gesetzt sind. Sie muss unter `/boot/efi/` eingehangen werden.

<div id="rev">Zuletzt bearbeitet: 2023-11-15</div>
