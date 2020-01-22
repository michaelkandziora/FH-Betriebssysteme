#!/bin/bash - 
#===============================================================================
#
#          FILE: remove_dirs.sh
# 
#         USAGE: ./remove_dirs.sh number_of_dirs
# 
#   DESCRIPTION: Unterverzeichnisse d0 d1 ... loeschen
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 07.11.2019 16:53
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


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
    
    rm -r $element && ((zaehler++))
  done


#-------------------------------------------------------------------------------
# Kontrollausgabe
#-------------------------------------------------------------------------------
echo -e "\n${zaehler} Verzeichnisse entfernt\n"
