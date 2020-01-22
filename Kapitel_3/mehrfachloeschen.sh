#!/bin/bash - 
#===============================================================================
#
#          FILE: mehrfachloeschen.sh
# 
#         USAGE: ./mehrfachloeschen.sh 
# 
#   DESCRIPTION: Bash Tool, um eine als Parameter
#								 übergebene Datei aus allen Unterverzeichnisse
#								 des aktuellen Verzeichnisses zu loeschen.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 07.11.2019 17:06
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#-------------------------------------------------------------------------------
# Aufruf / Anzahl der Aufrufparameter überprüfen
#-------------------------------------------------------------------------------
if [ ${#} -lt 1 ]
then
	echo -e "\n\tAufruf: $0 Zu_Loeschende_Datei\n"
	exit 1
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu loeschende Datei existiert
#-------------------------------------------------------------------------------
if [ ! -e "$1" ]
then
	echo -e "\n\t$1 existiert nicht.\n"
	exit 2
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu loeschende Datei eine Datei ist
#-------------------------------------------------------------------------------
if [ ! -f "$1" ]
then
	echo -e "\n\t"$1" ist keine Datei.\n"
	exit 3
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu loeschende Datei lesbar ist
#-------------------------------------------------------------------------------
if [ ! -w "$1" ]
then
	echo -e "\n\t"$1" ist nicht schreibbar.\n"
	exit 3
fi

#-------------------------------------------------------------------------------
# Unterverzeichnisse ermitteln
#-------------------------------------------------------------------------------
liste=$(find -type d -name "[^.]*")


#-------------------------------------------------------------------------------
# Kopieren 
#-------------------------------------------------------------------------------
zaehler=0

  for element in $liste 
  do 
    if [ ! -d "$element" ] && [ ! -w "$element" ] && [ ! -w "$1" ]
    then
      echo -e "\n\t"$element" ist kein Ordner oder nicht lesbar.\n"
      exit 4
    fi
    
    rm $element/"$1" && ((zaehler++))
  done

#-------------------------------------------------------------------------------
# Kontrollausgabe
#-------------------------------------------------------------------------------
echo -e "\n${zaehler} Dateien entfernt\n"

