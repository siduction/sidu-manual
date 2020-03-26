#!/usr/bin/perl -w
#
# Autor: Axel Konrad (akli)
# Status am 13.02.2020: Zu Testzwecken freigegeben.
# Aufruf: Im LINUX Terminal 'html2md.pl <HTML-DATEI>'
#         Es wird eine .md Datei mit gleichem Namen angelegt.
#         Im Script sind drei Bereiche markiert, die für Testzwecke
#         auszukommentieren sind. Die Ausgabe erfolg dann in die Konsole.
#
# Das Script konvertiert HTML-Inhalte in md um und ist speziell auf die Inhalte des siduction Handbuchs abgestimmt.
#
# ACHTUNG:
# Auf Grund der Verwendung von "/" in HTMH-Tags und "#" in der md-Notation wird
# in den RegEx Suchmustern meist das "+" oder "!" als Trenner verwendet.
#
use strict;
use File::Basename;

my $HEADER = "0";
my ($ZEILE, $TEST, $TEIL, $VOR, $ZAEHLER, $LAGER, $MASKE, $SCHREIBEN);
my (@ZEILE, @ZEILEN, @PRE, @QUELLE, @NEU);
my @KANN_WEG = ( '<table>','</table>', '</body>', '</html>');

open(DATEI, "<$ARGV[0]") || die "$ARGV[0] nicht gefunden\n";
@QUELLE=<DATEI>;
close(DATEI);
my($filename, $dirs, $suffix ) = fileparse($ARGV[0], qr/\.[^.]*/);        # Dateiendung für die neue Datei anlegen.
$SCHREIBEN = $dirs . $filename . ".md";                                   # Für Testzwecke zur Ausgabe auf die Konsole auskommentieren.

#####################################################
######### Beginn inhaltliche Bearbeitung der Dateien.

while (@QUELLE) {                                
    $_ = shift @QUELLE;
    s!(&nbsp;)+! !;                  # Geschützte Leerzeichen ersetzen.
    s!\s+! !g;                       # Mehrfache Spacezeichen entfernen.
    s!<br \/>|<\/br>|<br>!!g;        # Die stören in md.
    s!^\s*!!;                        # Am Anfang der Zeile alle Spacezeichen entfernen.
    s!\s*$!!;                        # Am Ende der Zeile alle Spacezeichen entfernen.
    push @NEU,"$_\n";
}
@QUELLE = @NEU;
$#NEU = -1;

#######################################################
##################   Verarbeitung der einzelnen Zeilen.

NEUE_ZEILE: while (@QUELLE) {
    $_ = shift @QUELLE;
    while ( ! (/<body.*>/) && $HEADER < 1 ) {      ##### Header entfernen.
        if ($#QUELLE < 0) {
            die "FEHLER: War überhaupt ein Header vorhanden?\n";
        }
        next NEUE_ZEILE;
    }
    $HEADER ++;
    if (/<body.*>/) {
        next NEUE_ZEILE;
    }
    
    foreach my $TEST (@KANN_WEG) {                # Zeilen mit nicht benötigten Tag's verwerfen.
        next NEUE_ZEILE if ($_ =~ /$TEST/);
    }
    chomp($_);
    next unless ($_) ;                            # Leerzeilen entfernen
    push @NEU,"$_\n";
}
$HEADER = '';
$TEST = '';
@QUELLE = @NEU;
$#NEU = -1;

########################################################################
##########  Alle Tag auf und in den Zeilen verarbeiten. Zeilen erhalten!

while (@QUELLE) {
    $_ = shift @QUELLE;
    chomp($_);
    if (/<a name/) {
        push @NEU,$_;
        next;
    } elsif ((/<i>/) || (/<em>/) || (/<b>/) || (/<s>/) || (/<strong>/) || (/<span class.*?>/)) {
        $TEST = $_;
        if (/<(\w+)[^>]*>.*<\/\1>/) {                # Kompletter Tag in einer Zeile mit anderen Zeichen davor und/oder dahinter.
            if (/^<(\w+)[^>]*?>[^<]*<\/\1>$/) {      # Findet kompletten Tag allein auf einer Zeile.
                &ZEILE;
            } elsif (/(.*)(<(\w+)[^>]*>[^<]*?<\/\3>)(.*)/) {
                $_ = $2;
                &ZEILE;                              # Den Tag nach md konvertieren
                $_ = $1 . $_ . $4;
            }
        }
        if ("$_" eq "$TEST") {                       # Inlinetag mit fehlerhaftem. oder ohne schließenden Tag
            push @NEU,$_;                            #   landen hier und bleiben unverändert in der Datei.
            next;
        }
        unshift @QUELLE,$_;
        redo;
    } elsif (/<h\d/) {
        until (/<(h\d).*<\/\1>/) {
            chomp($_);
            $_ .= shift @QUELLE;                # Eine neue Zeile holen und anhängen.
            chomp($_);
        }
        &H;
        $_ = "$_\n";
        unshift @QUELLE,$_;
        redo;
    } elsif (/<img/) {
        unless (/<img.*\/>/) {
            chomp($_);
            $_ .= shift @QUELLE;
            chomp($_);
        } else {
        &INL;
        }
        unshift @QUELLE,$_;
        redo;
    }
    push @NEU,"$_\n";
}
$TEST = '';
@QUELLE = @NEU;
$#NEU = -1;

########################################################################
######################  Tag, die über mehrere Zeilen gehen, verarbeiten.

while (@QUELLE) {
    $_ = shift @QUELLE;
    if ((/<pre/) || (/<code/)) {            # Hervorgehobene Absätze
        chomp($_);
        &PRE;
        while (@PRE) {
            $_ = shift @PRE;
            &SONDERZEICHEN;
            push @NEU,$_;
        }
        next;
    }
    push @NEU,$_;
}
@QUELLE = @NEU;
$#NEU = -1;


while (@QUELLE) {
    $_ = shift @QUELLE;                     # <p> Blöcke über mehrere Zeilen
    if (/<p ?[^>]*>/) {
        chomp($_);
        $ZEILE = $_ ;
        until (/<\/p>/) {                   # So lange weiter kein schließender Tag erscheint
            $_ = shift @QUELLE;             #   eine neue Zeile holen und anhängen.
            chomp($_);
            $ZEILE .= "  \n$_";
        }
        $_ = $ZEILE;
        &P;                                 # Nachdem der schließende Tag erschien, die Subroutine aufrufen,
    }
    push @NEU,"$_";     
}
$ZEILE = '';
@QUELLE = @NEU;
$#NEU = -1;


while (@QUELLE) {
    $_ = shift @QUELLE;
    if (/<dl.*?>/) {                        # Definitoinslisten
        chomp($_);
        &DL;
        while (@ZEILEN) {
            $_ = shift @ZEILEN;
            push @NEU,$_;
        }
        push @NEU,"\n";
        next;
    }
    push @NEU,$_;
}
@QUELLE = @NEU;
$#NEU = -1;
        

while (@QUELLE) {
    $_ = shift @QUELLE;
    if ((/<ul.*?>/) || (/<ol.*?>/)) {        # Listen (unnummeriert und numeriert)
        chomp($_);
        &LISTE;
        while (@ZEILEN) {
            $_ = shift @ZEILEN;
            push @NEU,$_;
        }
        push @NEU,"\n";
        next;
    }
    push @NEU,$_;
}
@QUELLE = @NEU;
$#NEU = -1;


while (@QUELLE) {
    $_ = shift @QUELLE;
    if (/<tbody>/) {                        # Tabellen.
        $_ = shift @QUELLE;
        chomp($_);    
        &TABELLE;
        while (@ZEILEN) {
            $_ = shift @ZEILEN;
            push @NEU,$_;
        }
        $_ = '';
    }
    push @NEU,$_;
}
@QUELLE = @NEU;
$#NEU = -1;


while (@QUELLE) {                            # Link
    $_ = shift @QUELLE;
    if (/<a href/) {
        &LNK;
    }
    push @NEU,$_;
}
@QUELLE = @NEU;
$#NEU = -1;


while (@QUELLE) {                            # HTML Blöcke mit <div.
    $_ = shift @QUELLE;
    chomp($_);
    next if ($_ eq "<div>");
    next if ($_ eq "<\/div>");
    if (/<div/) {
        &DIV;
    }
    push @NEU,"$_\n";
}
@QUELLE = @NEU;
$#NEU = -1;

###################################################
#######################  In Ausgabedatei schreiben.        # (Für Testzwecke auf der Konsole auskommentieren.)
                                                
open (DATEI, ">", $SCHREIBEN) || die "Kann Datei nicht anlegen.\n";
foreach (@QUELLE) {
    print DATEI "$_";
}
close(DATEI);
#print "Erledigt:\t$SCHREIBEN\n";

###################################################
##########################  Ab hier die Subroutinen 

sub ZEILE {
    &P;
    &H;
    &DIV;
    &INL;
    &LNK;
}

########################################### Beginn blockbildende HTML Tag
sub P {    
                                                          ##### Anfang <p> - Tag
    if (/<p ?>/) {                                        # <p> - Tag bearbeiten.
        s!<p ?>([\d\D]+?)< ?\/p ?>!$1\n\n!;
    }

    if (/<p class= *"highlight-2">/) {                    # <p> - Tag mit Textauszeichnung
        s!< ?p[^>]*>([\d\D]+?)< ?/p ?>!\*\*`$1`\*\*\n\n!;    # Ergebnis ist farbig und fett (ehemals rot).
    }
    
    if (/<p class= *"highlight-[134]">/) {                # Ergebnis ist farbig (ehemals grün, violett, braun).
        s!< ?p ?[^>]*>([\d\D]+?)< ?/p ?>!`$1`\n\n!;
    }
    
    if (/<p class="warning-box">/) {                      # Warnungen übersetzen.
        $TEIL = "\n::: warning  \n**Achtung**  \n";
        s!<p class="warning-box">([\d\D]+?)</p>!$1!;
        $TEIL = "$TEIL$_  \n:::\n\n";
        $_ = $TEIL;
        $TEIL = '';
    }
}                                                         ##### Ende <p> - Tag


sub H {                                                   ##### Anfang Überschriften
                                        
    if (/<h[1-6]/) {
        s#<h([1-6])[^>]*> ?([\d\D]+)</h\1>#$1$2#;         # HTML Tag entfernen
        $TEST = $1;
        $TEST = "#" x $TEST;
        $_ = $2;
        &INL;
        $_ = $` . "$TEST " . $_ . "$'\n";                 # md Überschrift erstellen.
        $TEST = '';
    }
                                        # Die folgenden zwei Zeilen nur verwenden, wenn die Überschriften
                                        # zusätzlich fett werden sollen. Ersetzungsmuster zuvor: "\*\*$2\*\*"
#    s/[\s]+(\*\*)[\s]+/$1/g;            # Alle Space-Zeichen vor und hinter den ** entfernen.
#    s/(\*\*.*)/ $1/;                    # Nur das eine notwendige Leerzeichen vor den ersten ** einfügen.
}
                                                        ##### Ende Überschriften


sub PRE {                                   ##### Anfang hervorgehobene Absätze.
    
    if ((/<pre ?>/) || (/<code>/)) {
        s+code>+pre>+g;
        push @PRE,"~~~  \n";                # Anfang des Blocks.
        if (/<pre ?>(.+)<\/pre>/) {         # Einzeilige <pre> Tag.
            s!<pre ?>(.+)<\/pre>!$1!;
            &MSK;                           # Spezielle Behandlung von Textauszeichnungszeichen.
            push @PRE,"$MASKE  \n";
            $MASKE = '';
            push @PRE,"~~~\n\n";
            return;
        } elsif (/<pre ?>(.+)/) {           # <pre> Tag mit Text.
            s!<pre ?>(.+)!$1!;
            &MSK;
            push @PRE,"$MASKE  \n";
            $MASKE = '';
        }
        $_ = shift @QUELLE;                 # Neue Zeile hohlen.
        chomp($_);
        s+code>+pre>+g;
        until (/<\/pre>/) {                 # Solange kein </pre> - Tag kommt
            &MSK;                           # Spezielle Behandlung von Textauszeichnungszeichen.
            push @PRE,"$MASKE  \n";
            $MASKE = '';
            $_ = shift @QUELLE;
            chomp($_);
            s+code>+pre>+g;
        }
        if (/^<\/pre>$/) {                  # Kommt nur ein </pre> -Tag,
            push @PRE,"~~~\n\n";            #   die Schlußzeile in das Array laden.
        } else {
            s!(.*)<\/pre>!$1!;              # Sonst Text vom Tag trennen
            &MSK ;                          # Spezielle Behandlung von Textauszeichnungszeichen.
            push @PRE,"$MASKE  \n";         # Text und Schlußzeile in das Array laden.
            push @PRE,"~~~\n\n";
            $MASKE = '';
        }
    }
}                                           ##### Ende hervorgehobene Absätze.



sub DIV {                                   ##### Beginn Tag ohne inhaltliche Änderung. Nur Zeilenumbrüche hinzufügen.

    if ((/<div id="main-page">/) || (/<div class="divider/)) {
        $_ = $_ . "<\/div>";                    # Tag, die erhalten bleiben sollen.
    } elsif ( /div class="screenshot/ ) {       # Das sind Blöcke zum Einbinden von Bildern.
        s!<(div)[^>]*>(.+?)<\/\1>!$2\n!;        # Tag entfernen, Text behalten.
    } elsif (/<div class="spacer.*/) {          # Abstandshalter
        $_ = "\n---\n";                         #   md Notation an Stelle des Tag einfügen.
    } elsif (/<div class="highlight-2">/) {     # Wird rot und fett.
        s!<(div)[^>]*> *(.+?) *<\/\1>!\*\*$2\*\*\n!;
    } elsif (/<div>.+<\/div>/) {                # Gleiche Verarbeitung wie ein <p> Tag.
        s!<div>(.+)</div>!$1\n!;
    }
}                                               ##### Ende Tag ohne inhaltliche Änderung.
##################################################### Ende blockbildende HTML Tag


############################################ Beginn Inline - Tag
sub MSK {
    s![\*`]*\b!!g;                    # Textauszeichnung vor Text entfernen.
    s!\b[\*`]*!!g;                    # Textauszeichnung nach Text entfernen.
    $MASKE = $_;                      # (Anwendung nur in hervorgehobenen Absätzen.)
}


sub INL {
    
    if (/<img/) {                                   ##### Anfang Images
        s!<img (.+)/>!$1!;
        s+src="(.*?)".*title=(".*?").*alt="(.*?)"+![$3]($1 $2)+;
    }
                                                    ##### Ende Images


    if ((/<i ?>/) || (/<em ?>/)) {                  ##### <i> und <em> - Tag
        s+ ?<i ?> *(.*?) *< ?/i ?>+ \*$1\* +g;        
        s+ ?<em ?> *(.*?) *< ?/em ?>+ \*$1\* +g;    # Ergebnis ist kursiv.
    }

                                                    ##### <b> - Tag                                        
    if (/<b ?>/) {
        s+ ?<b ?> *(.*?) *< ?/b ?>+ \*\*$1\*\* +g;  # Ergebnis ist fett.
    }

                                                    ##### <s> - Tag
    if (/<s ?/) {
        s+<s ?> *(.*?) *< ?/s ?>+ ~~$1~~ +g;        # Ergebnis ist durchgestichen.
    }

                                                    ##### <strong> - Tag                                        
    if (/<strong ?>/) {
        s+<strong ?> *(.*?) *< ?/strong ?>+ \*\*`$1`\*\* +g;
        &SONDERZEICHEN;                             # Ergebnis ist farbig und fett.
    }

    if (/\&\#8482/) {                               ##### Trademark Entinity
        s+\&\#8482+(tm)+g;
    }
                                                    ##### Ab hier werden Tag mit "highlight" verarbeitet.
    if (/<span class="highlight-2/) {               # Ergebnis ist farbig und fett (ehemals rot).
        s+<span class=[^>]*> ?(.*?) ?< ?/span ?>+\*\*`$1`\*\* +g;
        &SONDERZEICHEN;
    }
    
    if (/<span class="highlight-[1345]/) {          # Ergebnis ist farbig (ehemals grün, magenta, braun).
        s+<span class=[^>]*> ?(.*?) ?< ?/span ?>+`$1` +g;
        &SONDERZEICHEN;
    }
    
    if (/<span class="\w+/) {                       # Tag entfernen, Test behalten.
        s+<span class=[^>]*> ?(.*?) ?< ?/span ?>+$1+g;
    }
}                                                   ##### Ende der Tag mit "highlight" Verarbeitung.


sub SONDERZEICHEN {                                 ##### Setzen von literalen "&,<,>" innerhalb <pre> und <code>

    if (/(&lt)|(&gt)|(&amp)/) {                     # Umformatieren von "&", "<" und ">", da md innerhalb der hervorgehobenen
        s+&lt;+<+g;                                 #   Absätze keine html Notation auswertet.
        s+&gt;+>+g;
        s+&amp;+&+g;
    }
}


sub LNK {
                                                    ##### Ab hier werden Link verarbeitet.
    if (/<a href/) {                                # Die folgende Zeile konvertiert den Link nach md.
        s+<a href ?= ?("|')(.*?)("|').*?>(.*?)< ?/a ?>+ \[$4\]\($2\) +g;
        s/[\s]+(\]|\))/$1/g;                        # Alle Space-Zeichen unmittelbar innen an den Klammern entfernen.
        s/(\[|\()[\s]+/$1/g;                        # HTML ist da fehlertolerant md nicht!
    }
}                                                   ##### Ende der Linkverarbeitung
####################################################### Ende Inline-TAG


####################################################### Anfang Tabellen und Listen
sub TABELLE {                                ##### Anfang Tabellen

     my ( $TH, $TH_TD, $TD , $TEILZEILE );
         TAB:while (/<tr ?>/) {
        $_ = shift @QUELLE;    
        chomp($_);
        while (/<th ?>/) {                   # Hier werden die Überschriften der Tabellenspalten aufgenommen,
            until (/<\/th>/) {               #   wenn Zelleninhalte die aus mehreren Zeilen
                s+(<th ?>)?(.*)+$2+;         #   bestehen, zusammengefügt.
                $TEILZEILE .= "$2 ";
                $_ = shift @QUELLE;    
                chomp($_);    
            }
            s+(<th ?>)?(.*)</th ?>+$2+;      # von html befreit und zur Weiterverarbeitung gespeichert-
            if ($TEILZEILE) {
                $_ = $TEILZEILE . "$2 ";
            }
            push @ZEILE,$_;
            $_ = shift @QUELLE;              # Holen einer neuen Spaltenüberschrift ...
            chomp($_);                       # |
            if (/<\/tr ?>/) {                #  \... bis die Zeile zu Ende ist.
                $TH = "| ";                  # Anfang zum Aufbau der Splatenüberschriften ...
                $TH_TD = "|";                # |
                while (@ZEILE) {             # |
                    $TH .= shift @ZEILE;     # |
                    $TH .= " | ";            #  \... Zusammensetzen der Spaltenüberschriften und der darunter
                    $TH_TD .= " ---- |";     #       liegenden Trennzeile.
                }
            push @ZEILEN,"$TH\n";            # Die zwei Zeilen zum Zwischenlager hinzufügen.
            push @ZEILEN,"$TH_TD\n";
            $_ = shift @QUELLE;
            chomp($_);
            next TAB;    
            } 
        }
        $TEILZEILE = '';
        while (/<td ?>/) {                   # Sinngemäß die gleiche Prozdur wie oben.
            until (/<\/td>/) {
                s+(<td ?>)?([\d\D]*)+$2+;
                if ($2) {
                    $TEILZEILE .= "$2 ";
                }
                $_ = shift @QUELLE;
                chomp($_);    
            }
            s+(<td ?>)?([\d\D]*)</td>+$2+;
            if ($2) {
                if ($TEILZEILE) {
                    $TEILZEILE = $TEILZEILE . $2;
                } else {
                    $TEILZEILE = $2;
                }
            }
            push @ZEILE , $TEILZEILE;
            $TEILZEILE = '';
            $_ = shift @QUELLE;
            chomp($_);    
            if (/<\/tr>/) {
                $TD = "| ";
                while (@ZEILE) {
                    $TD .= shift @ZEILE;
                    $TD .= " | ";
                }
            push @ZEILEN,"$TD\n";            # Die Zeile zum Zwischenlager hinzufügen.
            $_ = shift @QUELLE;
            chomp($_);
            next TAB;    
            }
        }
    }
}
                                        ##### Ende Tabellen


sub DL {                                ##### Anfang Definitionsliste

    my $EBENE = -1;
    my $EINR = '';
    
    while ((/<\/?dl.*?>/) || (/<\/?dt.*?>/) || (/<\/?dd.*?>/)) {
        s!<\/?ul>!!g;
        s!<\/?li>!!g;
        if (/<\/dl/) {
            if ($EBENE > 0) {
                $EBENE--;
                $EINR = " " x (4*$EBENE);
                $_ = shift @QUELLE;              # Neue Zeile hohlen.
                chomp($_);
                next;
            } else {
            return;
            }
        } elsif (/<dl.*?>/) {
            if ($EBENE > -1) {
                $EBENE++;
            } else {
                $EBENE = 0;
            }
            $EINR = " " x (4*$EBENE);
            $VOR = "+ ";
            $_ = shift @QUELLE;
            chomp($_);
            next;
        } elsif (/<\/?dt.*?>/) {
            $ZEILE = "$EINR$VOR";                  # Den Zeilenstart für den Titel erstellen.
            if (/<dt[^>]*>(.+)< ?\/dt ?>/) {       # Wir haben einen Einzeiler. (Im siduction Handbuch gibt es nur Einzeiler)
                $_ = $1;
                if (/<a name/) {
                    push @ZEILEN,$_;               # Das sind HTML-Anker, die wir brauchen.
                    s!<a name[^>]*?>(.*)</a>!$1!;  # Der Titeltext wird extrahiert.
                }
                &INL;
                &LNK;
                unless (/^ *[\*`].*/) {            # Auf Textauszeichnung prüfen,
                    s!^ *(.*)!\*\*`$1`\*\*!;       #   wenn nicht vorhanden, einfügen.
                }
                $_ = $ZEILE . $_ . "  \n";
                push @ZEILEN,$_;
            }
            $_ = shift @QUELLE;                    # Neue Zeile. Titel ohne Inhalt werden verworfen.
            chomp($_);    
            next;
         
        } elsif (/<\/?dd.*?>/) {
            if (/<dd[^>]*>(.*)< ?\/dd ?>/) {
                $_ = $1;
                &INL;
                $_ = $EINR . $_ . "  \n";
                push @ZEILEN,$_;
                $_ = shift @QUELLE;                # Neue Zeile. Einzelne Tag und solche ohne Inhalt werden verworfen
                chomp($_);    
                next;
            }
        }
        $_ = shift @QUELLE;
        chomp($_);
    }
}
                                                ##### Ende Definitionslisten

                                    
sub LISTE {                                     ##### Anfang Listen (numeriert und unnummeriert)
    
    my $EBENE = -1;
    my $EINR = '';
    
    while ((/<ul.*?>/) || (/<ol.*?>/) || (/<\/ul>/) || (/<\/ol>/) || (/<\/?li/)) {
        if ((/<\/ul>/) || (/<\/ol>/)) {
            if ($EBENE > 0) {
                $EBENE--;
                $EINR = " " x (4*$EBENE);
                $_ = shift @QUELLE;             # Neue Zeile hohlen.
                chomp($_);
                next;
            } else {
            return;
            }
        } elsif ((/<ul.*?>/) || (/<ol.*?>/)) {
            if ($EBENE > -1) {
                $EBENE++;
            } else {
                $EBENE = 0;
            }
            $EINR = " " x (4*$EBENE);
        }
        if (/<ul.*?>/) {                        # Zuweisung des richtigen Prefix.
            $VOR = "+ ";
            $_ = shift @QUELLE;
            chomp($_);
            next;
        } elsif (/<ol.*?>/) {
            $ZAEHLER = 0;                       # Bei <ol> Tag den Zähler starten.
            $VOR = ". ";
            $_ = shift @QUELLE;
            chomp($_);
            next;
        } 
        if ($VOR =~ /\./) {
            $ZAEHLER ++;
            $VOR = "$ZAEHLER. ";
        }
        $ZEILE = "$EINR$VOR";                   # Den Zeilenstart erstellen.
        if (/<li[^>]*>(.*)< ?\/li ?>/) {        # Wir haben einen Einzeiler.
            $_ = $1;
            $_ = $ZEILE . $_ . "  \n";
            push @ZEILEN,$_;
            $_ = shift @QUELLE;                 # Neue Zeile holen
            chomp($_);    
            next;
        }
        s+<li[^>]*>(.*)+$1+;
        unless ($_) {                           # Wenn  nur der Tag vorhanden war
            $_ = shift @QUELLE;                 #   eine neue Zeile holen.
            chomp($_);
        }
        until (/< ?\/li ?>/) {                  # Bei mehrzeilige Listeneinträgen
            $TEIL = $_;
            if ($ZEILE eq "$EINR$VOR") {
                $ZEILE =  $ZEILE . $TEIL . "  \n";
                push @ZEILEN,$ZEILE;
                $_ = shift @QUELLE;
                chomp($_);    
            } else {
                $ZEILE = "$EINR   $TEIL  \n";
                push @ZEILEN,$ZEILE;
                $_ = shift @QUELLE;    
                chomp($_);
            }
        } 
        s+([\d\D]*?)\s*< ?/li ?>+$1+;           # Nachdem </li> gefunden wurde, den Tag entfernen
        if ($_) {                               # Wenn noch Text vor dem Tag war,
            $ZEILE =  "$EINR   $_  \n";         #   diesen hinzufügen.
            push @ZEILEN,$ZEILE;
        }
        $_ = shift @QUELLE;
        chomp($_);
    }
}                                            ##### Ende numerierte und unnummerierte Listen
############################################# Ende Tabellen und Listen

#####################   Ende Subroutinen   ##################
#############################################################


################################################### Werkzeuge
#print "\nNach der Konvertierung:\n----\n";         # Nur für Testzwecke auf der Konsole, sonst auskommentieren.
#foreach (@QUELLE) {                                #     und weiter oben die Ausgabe in Datei kommentieren.
#    print "$_";
#}
#print "\n----\n";

#/^<\w+[^>]*>/                          # Findet öffnenden Tag mit beliebiger Erweiterung darin.
#/^<\w+[^>]*>.*<\/\w>$/                 # Findet öffnenden und schließenden Tag mit irgendetwas dazwischen. Tag müssen nicht zusammenpassen.
#/^<(\w+)[^>]*>[^<]*<\/\1>$/            # Findet öffnenden und passenden schließenden Tag mit irgendetwas ohne Tag dazwischen.
#s!^<(\w+)[^>]*>(.*)<\/\1>$!$2!;        # Entfernt öffnenden und passenden schließenden Tag und behält alles dazwischen.
#s!^<(\w+)[^>]*>([\d\D]*)<\/\1>$!$2!;   # Entfernt öffnenden und passenden schließenden Tag und behält alles dazwischen auch mit Zeilenumbrüchen.
