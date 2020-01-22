#!/bin/bash - 
#===============================================================================
#
#          FILE:  make-html.sh
# 
#         USAGE:  ./make-html.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Dr.-Ing. Fritz Mehner (fgm), mehner@fh-swf.de
#       COMPANY:  Fachhochschule Südwestfalen, Iserlohn
#       VERSION:  1.0
#       CREATED:  20.03.2009 17:20:40 CET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

vim -c  ':helptags . | q'

if  [ -r tags ]; then
	./vim2html.pl tags *.txt	
else
	exit 1
fi

liste='\
	awksupport.html 	\
	bashsupport.html 	\
	csupport.html 		\
	gitsupport.html 	\
	latexsupport.html	\
	perlsupport.html 	\
	vimsupport.html 	\
	'

for file in $liste; do
	if  [ -r $file ]; then
		echo -e "<$file>"
		filter-vimtags.pl	-i $file -o $file
	fi
done

