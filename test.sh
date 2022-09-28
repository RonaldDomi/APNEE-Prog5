#!/bin/bash

if cd programs
then
	echo on est dans le dossier
else echo pas dans dossier
fi
echo "Mauvais parenthesage">../resultat_attendu
cmp=0
for file in *
do
	compteur=0
	for test in ../test/F*
	do
		./$file <../test/$test>../resultat
		cmp -s ../resultat ../resultat_attendu
		if [ $? -ne 0 ]
		then
			let "compteur = compteur + 1"
			#echo $file not ok
		#else echo $file ok
		fi
	done
	for test in ../test/T*
	do
		./$file <../test/$test>../resultat
		cmp -s ../resultat ../resultat_attendu
		if [ $? -eq 0 ]
		then
			let "compteur = compteur + 1"
			#echo $file not ok
		#else echo $file ok
		fi
	done
	if [[ compteur -eq 0 ]] 
	then
		echo $file correct
		let "cmp = cmp + 1"
	#else echo $file pas correct
	fi
done
echo $cmp