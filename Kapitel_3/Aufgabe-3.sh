#!/bin/bash - 
#===============================================================================
#
#          FILE: Aufgabe-3.sh
# 
#         USAGE: ./Aufgabe-3.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Michael Kandziora, kandziora.michael@fh-swf.de 
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 14.11.2019 10:10
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#-------------------------------------------------------------------------------
# 
#-------------------------------------------------------------------------------
	echo "Aufgabe 3.1"
	echo "------------------"

	echo "BENUTZER STUDENT"
	printf "Gruppen: \t" && groups student
	printf "UID: \t" && id -u student
	printf "GID: \t" && id -g student
	echo ""

	echo "BENUTZER ROOT"
	printf "Gruppen: \t" && groups root
	printf "UID: \t" && id -u root
	printf "GID: \t" && id -g root
	echo ""

read -p "Weiter zu Aufgabe 3.2 ? [y]: " var
if [ $var!="y" ]
then
	echo "Aufgabe 3.2"
	echo "------------------"
	read -p "ps aux | wc -l" 
	ps aux | wc -l	

	read -p "yes > /dev/null &"
	yes > /dev/null &

	read -p "ps | grep 'yes': "
	ps | grep 'yes'

	read -p "kill \$(pidof yes): "
	kill $(pidof yes)

	read -p "ps" && ps
fi

read -p "Weiter zu Aufgabe 3.3.2 ? [y]: " var
if [ $var!="y" ]
then
	echo "Aufgabe 3.3.2"
	echo "------------------"

	mkdir ./3-3-2
	cd ./3-3-2
	touch feb86 jan12.89 jan19.89 jan26.89 jan5.89 jan85 jan86 jan87 jan88 mar88 memo1 memo10 memo2 memo2.sv

	read -p "echo *"
	echo *

	read -p "echo *[^0-9]"
	echo *[^0-9]

	read -p "echo m[a-df-z]*"
	echo m[a-df-z]*

	read -p "echo jan*"
	echo jan*

	read -p "echo *.*"
	echo *.*

	read -p "echo ?????"
	echo ?????

	read -p "echo *89"
	echo *89

	read -p "echo jan?? feb?? mar??"
	echo jan?? feb?? mar??

	read -p "echo [fjm][ae][bnr]*"
	echo [fjm][ae][bnr]*

	cd /home/student/BS/Kapitel_3 
fi

read -p "Weiter zu Aufgabe 3.3.3 ? [y]: " var
if [ $var!="y" ]
then
	echo "Aufgabe 3.3.3"
	echo "------------------"

	mkdir ./3-3-3
	cd ./3-3-3

	read -p "touch 'stars*' stars1 stars2"
	touch "stars*" stars1 stars2

	read -p "touch ./-top"
	touch ./-top

	read -p "touch 'hello my friend'"
	touch "hello my friend"

	read -p "touch ''goodbye''"
	touch '"goodbye"'

	echo ""
	read -p "ls -l" && ls -l

	read -p "rm 'stars*' stars1 stars2"
	rm "stars*" stars1 stars2

	read -p "rm ./-top"
	rm ./-top

	read -p "rm 'hello my friend'"
	rm "hello my friend"

	read -p "rm ''goodbye''"
	rm '"goodbye"'

	echo ""
	read -p "ls -l" && ls -l

	cd /home/student/BS/Kapitel_3 
fi

read -p "Weiter zu Aufgabe 3.3.4 ? [y]: " var
if [ $var!="y" ]
then
	echo "Aufgabe 3.3.4"
	echo "------------------"
	
	read -p "echo $LANG" && echo $LANG

	read -p "echo $LANG"
	su -l root && echo $LANG

	mkdir ./3-3-4
	cd ./3-3-4

	read -p "touch a b c x y z A B C X Y Z ä ö ü Ä Ö Ü" && touch a b c x y z A B C X Y Z ä ö ü Ä Ö Ü
	echo "Ausgaben des Benutzers Student"
	read -p "echo *" && echo *
	read -p "echo [a-z]*" && echo [a-z]
	read -p "echo [A-Z]*" && echo [A-Z]
	read -p "find *" && find *
	
	echo "Ausgaben des Benutzers Root"
	read -p "echo *"
	su -l root && echo *
	read -p "echo [a-z]*"
	su -l root && echo [a-z]
	read -p "echo [A-Z]"
	su -l root && echo [A-Z]
	read -p "sudo find *"
	su -l root && find *
fi

read -p "Weiter zu Aufgabe 3.3.5 ? [y]: " var
if [ $var!="y" ]
then
	echo "Aufgabe 3.3.5"
	echo "------------------"

	read -p "cut -d: -s -f1 /etc/passwd | sort > benutzerliste.txt" 
	cut -d: -s -f1 /etc/passwd | sort > benutzerliste.txt

	read -p "cat benutzerliste.txt"
	cat benutzerliste.txt

	read -p "grep [*]* < /etc/passwd"
	grep [*]* < /etc/passwd

	read -p "grep [*]* /etc/passwd"
	grep [*]* /etc/passwd

	read -p "grep -n [*]* /etc/passwd | less"
	grep -n [*]* /etc/passwd | less

fi
	




