#!/bin/bash - 
#===============================================================================
#
#          FILE: user-add-2.sh
# 
#         USAGE: ./user-add-2.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Your Name (), 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 15.11.2019 00:01
#      REVISION:  ---
#==============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# Prüfe ob das Skript als root ausgeführt wird
#-------------------------------------------------------------------------------
if [ $(id -u) != 0 ]
then 
	echo -e "\n\tDieses Skript muss als root ausgeführt werden.\n"
	exit 1
else
	echo -e "Du bist als root angemeldet."
fi


#-------------------------------------------------------------------------------
#	Prüfe ob die Eingabedatei eine Datei ist und lesbar ist
#-------------------------------------------------------------------------------
file="$1"

if [ ! -f "$file" ]
then
	echo -e "\n\t"$file" ist keine Datei oder nicht lesbar.\n"
	exit 2
fi


#-------------------------------------------------------------------------------
# Klartextpasswort der Länge 8 erzeugen und einer Variable zuweisen
#-------------------------------------------------------------------------------








#-------------------------------------------------------------------------------
# Benutzer anlegen
#-------------------------------------------------------------------------------

#egrep "^$username" /etc/passwd > /dev/null
#if  [ $? -eq 0 ];
#then
#	echo -e "\n\tBenutzer "$username" existiert bereits.\n"
#	exit 3
#fi

# DEFAULT PARAMETER
d_shell="/bin/ksh"
d_gid=10
d_com="Student"
d_homedir="/home/fhswf/"

# USER PARAMETER
u_count=0
u_uid=0
u_gid=0
u_loginname=""
u_password=""
u_homedir=""
u_shell=""
u_com=""

# Erstelle default Home-Directory
mkdir $d_homedir

while read -a line; do
	
	# User-ID
	u_uid=$(awk -F: '$3<60000 { print $3 }' /etc/passwd | sort -n | tail -1)
	((u_uid++))
	
	# Baue den Login-Namen des zu erstellenden Nutzers
	u_loginname="$(echo ${line[1]} | tr "[A-Z]" "[a-z]")"
	
	# Erzeuge ein Random Passwort
	u_password=$(pwgen 8 1)
	
	# GROUP-ID
	u_gid=${gid:-$d_gid}
	
	# Baue das Home-Directory des zu erstellenden Nutzers
	u_homedir=${home:-$d_homedir${line[2]}}
	
	# Benutzershell
	u_shell=${shell:-$d_shell}
	
	# Kommentar
	u_com=${com:-${line[0]}_${line[1]}_\"$d_com\"}
	
	
	
	# Debug Ausgabe der Variablen für User u_xxx
	#printf "%d:\tLog: %s\tUid: %d\tGid: %d\tShell: %s\tCom: %s\thome-> %s\n" $u_count  $u_loginname $u_uid $u_gid $u_shell $u_com $u_homedir
	
	
	# Erstelle den Benutzer
	useradd -u "$u_uid" -g "$u_gid" -c "$u_com" -s "$u_shell" -d "$u_homedir" "$u_loginname"
	if [ $? == 0 ] 
	then
	  echo "$u_loginname" erfolgreich angelegt.
	  ((u_count++))
	  
	  # Erstelle HomeDir
	  mkdir $u_homedir 
	  chown $u_uid:$u_gid $u_homedir
	  
	  # Weise dem Benutzer das Passwort zu
	  echo ${u_loginname}:${u_password} | chpasswd 2>/dev/null
	  [ $? == 0 ] && echo Passwort "$u_password" erfolgreich zugewiesen.
	
	  # Speichere das Passwort in einer Datei
	  echo ${u_loginname}:${u_password} >> ./user+password.txt
	else
	  echo -e "Benutzer konnte nicht erstellt werden."
	  exit 3
	fi
	
done < $file

echo "$u_count" von $(cat "$file" | wc -l) Benutzer erfolgreich erstellt

