#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-3.sh
# 
#         USAGE: ./
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.1.3
#
#		 Nur die Straßen aus der Datei "phone.book" ausgeben.
#		 (3. Spalte der Tabelle)
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:56
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
# Datei Inhalt -> Entnehme 3. Spalte -> Entferne leere Zeilen
#-------------------------------------------------------------------------------
cat phone.book | cut -d! -f3 | grep -v ^$
