#!/bin/bash - 
#===============================================================================
#
#          FILE: cd_mount.sh
# 
#         USAGE: ./cd_mount.sh <MOUNT DESTINATION DIR> <IMAGE DIR> <IMAGE TYPE>
# 
#   DESCRIPTION: Bindet ein Image ein.
#
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 09.01.2020 16:04
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# Variablen / Konstanten
#-------------------------------------------------------------------------------

image_dir=$HOME/CDs/
mount_dir=$image_dir"mount/"
file_type="image"
file_name=""

#-------------------------------------------------------------------------------
# Aufruf Parameter abarbeiten
#-------------------------------------------------------------------------------
if [ ${#} -gt 0 ]
then
  echo "Nutzung: $0 <MOUNT DESTINATION DIR> <IMAGE DIR> <IMAGE TYPE>"
  
  # Ein Parameter: <MOUNT DESTINATION DIR>
  if [ ${#} -eq 1 ]
  then
    if [ ! -d $1 ]
    then
      echo $1 "wird als Image Typ interpretiert."
      file_type=$1
    else
      mount_dir=$1
    fi
  fi
  
  # Zwei Parameter: <MOUNT DESTINATION DIR> <IMAGE DIR>
  if [ ${#} -eq 2 ]
  then
    if [ ! -d $1 ]
    then
      echo $1 "wird als Image Typ interpretiert."
      file_type=$1
    else
      mount_dir=$1
    fi
    
    if [ ! -d $2 ]
    then
      echo $2 "wird als Image Typ interpretiert."
      file_type=$2
    else
      image_dir=$2
    fi
  fi
  
  # Drei Parameter: <MOUNT DESTINATION DIR> <IMAGE DIR> <IMAGE TYPE>
  if [ ${#} -eq 3 ]
  then
    if [ ! -d $1 ]
    then
      echo "Uebergebener Parameter ist kein Verzeichnis"
      exit 2
    else
      mount_dir=$1
    fi
    
    if [ ! -d $2 ]
    then
      echo "Uebergebener Parameter ist kein Verzeichnis"
      exit 2
    else
      image_dir=$2
    fi
  
    file_type=$3
  fi
fi

#-------------------------------------------------------------------------------
# Images ermitteln
#-------------------------------------------------------------------------------
liste=$(find $image_dir -type f -name "[^.]*.$file_type")
if [ -z "$liste" ]
then
  echo -e "\n Keine Images vom Typ " $file_type " gefunden.\n"
  exit 3
fi

#-------------------------------------------------------------------------------
# Gefundene Images einhaengen 
#-------------------------------------------------------------------------------
zaehler=0


  for image in $liste 
  do 
    if [ ! -f "$image" ] || [ ! -r "$image" ]
    then
      echo -e "\n"$image" ist kein Image oder nicht lesbar.\n"
      exit 4
    fi
    
    echo "Gefundenes Image: " $image
    file_name=$(echo $image | sed -e 's:[^*]*/::g' | sed -e "s:.$file_type::g")
		
    if [ -d "$mount_dir" ]
    then
      echo "Mount Ordner gefunden: $mount_dir"
    else
      echo -e "Mount Ordner nicht gefunden."
      mkdir $mount_dir
      
      if [ $? -eq 0 ]
      then
	echo "Mount Ordner wurde erstellt."
      fi
    fi
    
    
    # Überprüfen, ob dieses Verzeichnis bereits ein Mountpoint ist und gegebenenfalls mounten
    if grep --quiet "^fuseiso $mount_dir$file_name fuse" /proc/mounts
    then
	echo -e "Das Image \"$file_name.$file_type\" ist bereits gemountet auf $mount_dir$file_name !"
    else
	if [ ! -d "$mount_dir$file_name" ]
	then
	  echo "Mountpoint $mount_dir$file_name wurde nicht gefunden. Wird erstellt."
	  
	  mkdir $mount_dir$file_name
	  if [ $? -eq 0 ]
	  then
	      echo "Mountpoint erstellt: $mount_dir$file_name"
	  fi
	fi
	
	fuseiso "$image" "$mount_dir$file_name"
	if [ $? -eq 0 ]
	then
	    ((zaehler++))
	fi
    fi
  done


#-------------------------------------------------------------------------------
# Kontrollausgabe
#-------------------------------------------------------------------------------
echo -e "\n${zaehler} Images wurden eingehaengt.\n"

