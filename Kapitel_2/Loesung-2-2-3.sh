#!/bin/bash - 
#===============================================================================
#
#          FILE: ./Loesung-2-2-3.sh
# 
#         USAGE: ./ 
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.2.3
# 
#		 Erzeugen Sie eine nach Namen sortierte Liste aller Studierenden
#		 mit der Note HD.
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
# Datei Inhalt -> Tabelle erstellen(-t),  Trennzeichen(-s,) -> Nur ganze Wörter mit "HD" -> Sortiere Nachname aufsteigend, Vorname aufsteigend
#-------------------------------------------------------------------------------
cat results.csv | egrep "^[A-Z][0-9]{1,5},([A-Z -]+,){2}(HD),[0-9]+(\.[0-9]{1,3})?,CA18$" | sort -t, -k2 -k3 | column -s, -t
