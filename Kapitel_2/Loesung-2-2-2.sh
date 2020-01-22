#!/bin/bash - 
#===========================================================================================
#
#          FILE: Loesung-2-2-2.sh
# 
#         USAGE: ./Loesung-2-2-2.sh 
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.2.2
# 
# 		 Erzeugen Sie eine aufsteigend sortierte Liste aller
#		 vorkommenden Matrikelnummern (aus der Datei: results.csv).
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 24.10.2019 14:41
#      REVISION:  ---
#===========================================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------------------
# Inhalt der Datei -> Prüfe nach Gültigkeit -> Entnehme erstes Feld (Matr.Nr.)
#-------------------------------------------------------------------------------------------
cat results.csv | egrep "^[A-Z][0-9]{1,5},([A-Z -]+,){2}(C|F|D|HD|P|AF),[0-9]+(\.[0-9]{1,3})?,CA18$" | cut -d, -f1

