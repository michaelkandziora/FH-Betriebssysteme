#!/bin/bash - 
#===============================================================================
#
#          FILE: BS_A1
# 
#         USAGE: ./ 
# 
#   DESCRIPTION: Betriebssysteme Praktikums Loesung fuer Kapitel 1
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 07.10.2019 20:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# AUFGABE 1.3
#-------------------------------------------------------------------------------

echo "AUFGABE 1.3"
printf "%s\n" "Hallo,  Welt!"
printf "%8i\n" 4711
printf "%08i\n" 4711

printf "%8.2f\n\n" 47,11

# Im nachfolgenden Quelltext wird eine root-Passwort eingabe benoetigt
echo "SUDO Ausgabe mit 47,11:"
sudo printf "%8.2f\n" 47,11
printf "\n%s\n\n" "Als Super User muss 47,11 als 47.11 geschrieben werden"
echo "SUDO Ausgabe mit 47.11:"
sudo printf "%8.2f\n\n" 47.11


#-------------------------------------------------------------------------------
# AUFGABE 1.4
#-------------------------------------------------------------------------------

# Benutzereingabe fuer das Starten der naechsten Aufgabe abfragen
read -p "Naechste Aufgabe? [y]: " var
if [ $var="y" ]
then
	mkdir /home/student/sub01 /home/student/sub02 /home/student/sub02/sub0201
	echo "Verzeichnisse wurden erfolgreich erstellt."
	
	touch /home/student/test01.dat /home/student/test02.dat /home/student/sub01/test0101.dat /home/student/sub01/test0102.dat 
	touch /home/student/sub02/sub0201/test020101.dat /home/student/sub02/sub0201/test020102.dat /home/student/sub02/sub0201/test020103.dat
	echo "Dateien wurden erfolgreich erstellt."
fi

# Benutzereingabe fuer das Aufraeumen und Beenden der Aufgabe abfragen
read -p "Dateien loeschen? [y]: " var
if [ $var="y" ]
then
	rm /home/student/test01.dat
	echo "Datei test01.dat geloescht."
	rm /home/student/test02.dat
	echo "Datei test02.dat geloescht."
	rm /home/student/sub01/test0101.dat
	echo "Datei ./sub01/test0101.dat geloescht."
	rm /home/student/sub01/test0102.dat
	echo "Datei ./sub01/test0102.dat geloescht."
	rm /home/student/sub02/sub0201/test020101.dat
	echo "Datei ./sub02/sub0201/test020101.dat geloescht."
	rm /home/student/sub02/sub0201/test020102.dat
	echo "Datei ./sub02/sub0201/test020102.dat geloescht."
	rm /home/student/sub02/sub0201/test020103.dat
	echo "Datei ./sub02/sub0201/test020103.dat geloescht."
fi

read -p "Verzeichnisse loeschen? [y] " var
if [ $var="y" ]
then
	rmdir /home/student/sub01
	echo "Verzeichnis ./sub01 geloescht."
	rmdir /home/student/sub02/sub0201
	echo "Verzeichnis ./sub02/sub0201 geloescht."
	rmdir /home/student/sub02
	echo "Verzeichnis ./sub02 geloescht."
fi



