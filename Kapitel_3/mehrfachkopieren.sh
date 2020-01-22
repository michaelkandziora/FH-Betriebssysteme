#!/bin/bash - 
#===============================================================================
#
#          FILE: mehrfachkopieren.sh
# 
#         USAGE: ./mehrfachkopieren.sh 
# 
#   DESCRIPTION: Bash Tool, um eine als Parameter
#								 übergebene Datei auf alle Unterverzeichnisse
#								 des aktuellen Verzeichnisses zu kopieren.
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
	echo -e "\n\tAufruf: $0 Zu_Kopierende_Datei\n"
	exit 1
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu kopierende Datei existiert
#-------------------------------------------------------------------------------
if [ ! -e "$1" ]
then
	echo -e "\n\t"$1" existiert nicht.\n"
	exit 2
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu kopierende Datei eine Datei ist
#-------------------------------------------------------------------------------
if [ ! -f "$1" ]
then
	echo -e "\n\t"$1" ist keine Datei.\n"
	exit 3
fi

#-------------------------------------------------------------------------------
# Prüfe, ob die zu kopierende Datei lesbar ist
#-------------------------------------------------------------------------------
if [ ! -r "$1" ]
then
	echo -e "\n\t"$1" ist nicht lesbar.\n"
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
    if [ ! -d "$element" ] && [ ! -w "$element" ]
    then
      echo -e "\n\t"$element" ist kein Ordner oder nicht lesbar.\n"
      exit 4
    fi
    
    cp "$1" $element/"$1" && ((zaehler++))
  done


#-------------------------------------------------------------------------------
# Kontrollausgabe
#-------------------------------------------------------------------------------
echo -e "\n${zaehler} Dateien erstellt\n"

