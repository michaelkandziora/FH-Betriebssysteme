#!/bin/bash - 
#===============================================================================
#
#          FILE: ./Loesung-2-4.sh
# 
#         USAGE: ./ 
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.4
#
#		 Erstellen sie eine nach fallender Größe geordnete Liste aller
#		 Verzeichnisse unterhalb von "/usr". Die jeweils angezeigte
#		 Verzeichnisgröße soll nicht die Größe der Unterverzeichnisse
#		 enthalten. Zeigen Sie die Liste mit dem Pager "less" an.
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
# Zeige Unterverzeichnisse von /usr 1. Ebene(--max-depth=1) mit Größe in SI Einheit(-h) 
#  und nur Größen der einzel Verzeichnisse nicht die Gesamtgröße(-S).
#-------------------------------------------------------------------------------
du -h -S --max-depth=1 /usr | sort -h -r | less
