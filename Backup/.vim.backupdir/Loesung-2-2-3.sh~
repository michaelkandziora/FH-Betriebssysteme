#!/bin/bash - 
#===============================================================================
#
#          FILE: ./Loesung-2-2-3.sh
# 
#         USAGE: ./ 
# 
#   DESCRIPTION: Aufgabe 2.2.3
#								 
#								 Erzeugen Sie eine nach Namen sortierte Liste aller Studierenden
#							   mit der Note HD.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 24.10.2019 14:52
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
#	Datei Inhalt -> Tabelle erstellen(-t),  Trennzeichen(-s,) -> Nur ganze Wörter mit "HD" -> Sortiere Nachname aufsteigend, Vorname aufsteigend
#-------------------------------------------------------------------------------
cat results.csv | column -s, -t | grep -e "HD" -w | sort -k2 -k3
