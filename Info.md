### INFO DOKUMENT

## GIT Befehle
# Dateien/Verzeichnisse zum Repository hinzufügen
git add *
git commit -m "Info.md"
git push -u origin master

# Dateien/Verzeichnisse vom Repository entfernen
git rm Aufgabe_1_3.txt
git commit -m "Entfernen von Aufgabe_1_3.txt"
git push -u origin master


## Vokabelheft

# cat [Optionen] [Dateien]
Beschreibung:
  Befehl zum Ausgeben von Datei inhalten.

Optionen:
    -b --number-nonblank	Gibt eine Zeilennummer am Anfang jeder nicht-leeren Zeile aus
    -n --number			Gibt eine Zeilennummer am Anfang jeder Zeile aus - egal ob die Zeile leer ist oder nicht
    -E --show-ends		Gibt ein Dollarzeichen $ am Ende jeder Zeile aus
    -s --squeeze-blank		Die Ausgabe von zusätzlichen Leerzeilen wird unterdrückt, d.h. es wird maximal eine Leerzeile zwischen zwei Textzeilen angezeigt, auch wenn in der Datei mehrere Leerzeilen stehen sollten.
    -T --show-tabs		Tabulatoren werden als ^I angezeigt
    -v --show-nonprinting	Es werden alle Steuerzeichen außer LF (Linefeed) und Tabulatoren angezeigt
    -e				entspricht -vE
    -t				entspricht -vT
    -A --show-all		entspricht -vET
       --help			Hilfe anzeigen
       --version		Versionsnummer anzeigen
       
# column [-tx] [-c columns] [-s sep] [file ...] 
Beschreibung:
  Befehl zum erstellen einer Tabelle aus dem Inhalt einer Datei.
  Als Standardtrennzeichen wird das Leerzeichen verwendet.
 
Optionen:
    -c 		Ausgabe wird formatiert auf die Bildschirmbreite.
    -s 		Definiert ein Trennzeichen der einzelnen Spalten.
    -t 		Definierte die Anzahl der Spalten aus der Eingangsdatei und erstelle eine Tabelle. Als Trennzeichen wird das Leerzeichen verwendet (Standard).
    -x 		Fülle erst Spalten und dann Reihen.

# cut [Option] [Datei]
Beschreibung:
  Extrahiere Spalten aus einer mit Trennzeichen formatierten Textdatei.
  
Optionen:
    -b --bytes			Angabe der Bytepositionen
    -c --characters		Angabe der Zeichenpositionen (entspricht derzeit -b)
    -d --delimiter		Angabe des Trennzeichens (Delimiter) anstelle des Tabulators (Standard)
    -f --fields			Angabe der zu extrahierenden Felder
    -s --only-delimited		Keine Ausgabe von Zeilen ohne Trennzeichen (Delimiter)

# du [OPTIONEN] [DATEIEN]
Beschreibung:
  disk usage gibt den belegten Festplatten-Platz an. 
  Der Befehl df zeigt dagegen den freien Festplattenplatz an.

Optionen:
    -a 		--all 			gibt die Belegung für alle Dateien, nicht nur Verzeichnisse an
		--apparent-size 	gibt die eigentliche Dateigröße an, statt der Belegung der Festplatte. Wenn diese normalerweise kleiner ist, kann sie auch aufgrund von Löchern in "verteilten" Dateien, indirekten Blöcken und Ähnlichem, größer sein
    -B 		--block-size=GRößE 	verwendet GRößE-byte Blöcke
    -b 		--bytes 		entspricht --apparent-size --block-size=1
    -c 		--total 		erstellt die Gesamtgröße
    -D 		--dereference-args 	dereferenziert Dateien, die symbolische Links sind
    -h 		--human-readable 	gibt die Größen in verständlichem Format an (wie 1K 234M oder 2G)
		--si 			wie -h, aber mit Vielfachen von 1000 statt 1024
    -k 					entspricht --block-size=1K (Standard)
    -l 		--count-links 		zählt die Größen mehrmals, wenn es sich um Hard-Links handelt
    -L 		--dereference 		dereferenziert alle symbolischen Links
    -P 		--no-dereference 	symbolischen Links nicht folgen (dies ist die Standardeinstellung)
    -0 		--null 			beendet jede Ausgabezeile mit einem 0 Byte Zeichen, statt mit einem newline
    -S 		--separate-dirs 	die Größe der Unterverzeichnisse nicht miteinbeziehen
    -s 		--summarize 		gibt nur die Gesamtgröße für jedes Argument an
    -x 		--one-file-system 	überspringt Verzeichnisse, die in einem anderen Dateisystem liegen
    -X Datei 	--exclude-from=DATEI 	schließt alle Dateien aus der Untersuchung aus, die auf ein Muster aus DATEI passen
		--exclude=MUSTER 	schließt Dateien aus, auf die MUSTER passt
		--max-depth=N 		gibt die Gesamtgröße eines Verzeichnisses nur aus, wenn es nicht tiefer als N Ebenen unter dem übergebenen Argument liegt. --max-depth=0 entspricht --summarize
    -m 					entspricht --block-size=1M (veraltet)
		--help 			gibt den Hilfe-Text aus
		--version 		gibt die Versionsinformationen aus

# grep [Optionen] Muster [Datei...] ODER grep [Optionen] [-e Muster | -f Datei] [Datei...]
  egrep entspricht grep -E (obige Beschreibung von regular expressions bezog sich auf diese Variante)
  fgrep entspricht grep -F
  rgrep entspricht grep -r 

Beschreibung:
  Befehl zum suchen in Verzeichnissen oder Dateien.

Optionen:
    -A NUM 	--after-context=NUM 	gibt zusätzlich NUM Zeilen nach der passenden Zeile aus.
    -a text 	--text 			Verarbeite eine binäre Datei, als wäre sie Text. Dies entspricht der Option --binary-files=text.
    -B NUM 	--before-context=NUM 	gibt zusätzlich NUM Zeilen vor der passenden Zeile aus.
    -b 		--byte-offset 		gibt den Byte-Offset innerhalb der Datei vor jeder gefundenen Zeile an.
    -C NUM 	--context=NUM 		gibt zusätzlich NUM Zeilen von Kontext aus. Zwischen zusammenhängende Gruppen von Treffern werden Zeilen mit "--" eingefügt.
    -c 		--count 	 	unterdrückt die normale Ausgabe und gibt stattdessen für jede Eingabedatei an, wieviele Zeilen auf die regular expression passen.
    -E 		--extended-regexp 	Verwendet die extended Variante beim Interpretieren der übergebenen regular expression.
    -e Muster 	--regexp=Muster 	verwende Muster als regular expression. Nützlich um Ausdrücke zu schützen, die mit einem - beginnen.
    -F 		--fixed-strings 	interpretiert das übergebene Muster als eine Liste von festen Zeichenketten, die durch Zeilenumbrüche voneinander getrennt sind.
    -f Datei 	--file=Datei 		beziehe die Muster aus Datei, eines je Zeile. Eine leere Datei enthält keine Muster und passt somit auf keinen String.
    -H 		--with-filename 	gibt den Dateinamen vor jedem Treffer aus.
    -h 		--no-filename 		unterdrückt die Ausgabe des Dateinamens, wenn mehrere Dateien durchsucht werden.
    -I 		--binary-files=without-match 	schließt Binärdateien aus.
    -i 		--ignore-case 		unterscheide nicht zwischen Groß- und Kleinschreibung.
    -L 		--files-without-match 	unterdrückt die normale Ausgabe und gibt stattdessen die Dateinamen von allen Dateien, die keine Treffer enthalten aus. Die Bearbeitung stoppt, sobald ein Treffer auftritt.
    -l 		--files-with-match 	unterdrückt die normale Ausgabe und gibt stattdessen die Dateinamen von allen Dateien, die Treffer enthalten aus. Die Bearbeitung stoppt, sobald ein Treffer auftritt.
    -n 		--line-number 		gibt die Zeilennummer vor jedem Treffer aus.
    -o 		--only-matching 	gibt nur die passende Zeichenkette aus.
    -P 		--perl-regexp 		verwendet Perl regular expressions.
    -q 		--quiet, --silent 	schreibt nichts auf die Standardausgabe und stoppt beim ersten Treffer.
    -R -r 	--recursive 		liest alle Dateien unter jedem Verzeichnis rekursiv.
    -v 		--invert-match 		Invertiert die Suche und liefert alle Zeilen die nicht auf das gesuchte Muster passen.
    -w 		--word-regexp 		wählt nur solche Zeilen aus, deren Treffer aus vollständigen Wörtern bestehen.


# head [Option] [Datei] 
Beschreibung:
  Befehl zum Ausgeben von n Zeilen aus einer Datei.
  
Optionen:
		--bytes=[-]K 		Ausgabe der ersten K Bytes der Datei. Mit einem vorangestellten Minuszeichen („-“): Ausgabe aller Zeilen der Datei außer der letzten N Bytes. K darf einen Multiplikator-Anhang haben: b = 512, k = 1024, m = 1024*1024.
    -c 					Ausgabe der ersten c Bytes der Datei. c darf einen Multiplikator-Anhang haben: b = 512, k = 1024, m = 1024*1024.
		--help 			Anzeige der Hilfe
		--lines=[-]N 		Ausgabe der ersten N Zeilen (statt der standardmäßigen 10). Mit einem vorangestellten Minuszeichen („-“): Ausgabe aller Zeilen der Datei außer der letzten N Zeilen.
    -N oder -n N 			Ausgabe der ersten N Zeilen (statt der standardmäßigen 10)
    -q oder 	--quiet oder --silent 	Kopfzeilen mit Dateinamen nicht ausgeben
    -v oder 	--verbose 		Kopfzeilen mit Dateinamen immer ausgeben
		--version 		Ausgabe der Versionsinformationen 

# sort [Option] [Datei]
Beschreibung:
  Befehl zum sortieren.

Optionen:
    -b --ignore leading blanks	Ignoriere Leerzeichen am Zeilenanfang
    -c --check			Überprüfung, ob eine Datei sortiert ist (ohne Sortierung). Ist die Datei nicht sortiert, wird der Wert 1 ausgegeben.
    -d --dictionary-order	Berücksichtige beim Sortieren nur Leerzeichen und alphanummerische Zeichen
    -f --ignore-case		Ignoriere beim Sortieren Groß- und Kleinschreibung
    -g --general-numeric-sort	Anhand des allgemeinen numerischen Wertes vergleichen
    -k --key=POS1[,POS2]	Ein Schlüssel geht von POS1 (beginnend mit 1) bis POS2 (Voreinstellung: Zeilenende)
    -m --merge			Verbinde bereits sortierte Dateien (ohne anschließende Sortierung)
    -n --numeric-sort 		Sortierung von Zahlen gemäß ihrem numerischen Wert
    -o --output=FILE		Ausgabe von sort in eine Datei
    -r --reverse		Sortiere in umgekehrter Reihenfolge
    -u --unique			Sortierung ohne doppelte Zeilen
    -t				Trennzeichen definieren

# tr [OPTION] [ZEICHENFOLGE1] [ZEICHENFOLGE2]
Beschreibung:
  Befehl zum ersetzen von Zeichen/Zeichenfolgen in einer Datei.

Optionen:
    -c, -C --complement 	Komplement der angegebenen Zeichenfolge
    -d 	   --delete 		Löschen (nicht Ersetzen) von Zeichen
    -s 	   --squeeze-repeats 	Mehrere identische aufeinanderfolgende Zeichen durch ein einzelnes ersetzen
    -t 	   --truncate-set1 	Beschneide zunächst den ersten Datensatz auf die Länge des zweiten Datensatzes

# updatedb



