#!/bin/bash - 
#===============================================================================
#
#          FILE: Loesung-2-1-6.sh
# 
#         USAGE: ./
# 
#   DESCRIPTION: Betriebssysteme 2 - Praktikum - Aufgabe 2.1.6
#
#		Nur Zeilen mit dem Namen "Hans" und "Wolf" aus der
#		Datei "phone.book" ausgeben.
#		Stellen Sie sicher,  dass genau diese beiden Namen 
#		in der ersten Spalte gesucht werden. 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 23.10.2019 14:59
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
# Gebe nur ganze Wörter mit Hans ohne Bindestrich oder Wolf aus.
#-------------------------------------------------------------------------------
grep -e Hans! -e Wolf! phone.book