#!/bin/bash - 
#===============================================================================
#
#          FILE: ./Loesung-2-3.sh
# 
#         USAGE: ./ 
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.3
#
#		 Erstellen Sie aus der /etc/passwd Datei mit Hilfe von cut eine
#		 Datei "benutzer",  die die Liste aller aufsteigend sortierten
#		 Benutzernamen enthält.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 24.10.2019 15:04
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# Entnehme aus der Datei das erste Feld aller Zeilen bis ":" -> Sortiere die Ausgabe -> Schreibe diese in Datei benutzer
#-------------------------------------------------------------------------------
cut -d: -f1 /etc/passwd | sort -h > benutzer
