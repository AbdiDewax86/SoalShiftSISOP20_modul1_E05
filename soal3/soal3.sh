#!/bin/bash

dupe=$(find . -type f -name "*duplicate*" | wc -l)
kenangan=$(find . -type f -name "*kenangan*" | wc -l)
# echo $dupe
# echo $kenangan
for ((i=1;i<=28;i++))
do
	/usr/bin/wget https://loremflickr.com/320/240/cat -O "/home/dimasadh/Documents/Praktikum1/soal3/pdkt_kusuma_$i" -o "/home/dimasadh/Documents/Praktikum1/soal3/wget.log"
	grep 'Location' "/home/dimasadh/Documents/Praktikum1/soal3/wget.log" > /home/dimasadh/Documents/Praktikum1/soal3/locationfull.txt
	cat /home/dimasadh/Documents/Praktikum1/soal3/wget.log >> /home/dimasadh/Documents/Praktikum1/soal3/log.bak

	temploc="$(awk '{print $2}' /home/dimasadh/Documents/Praktikum1/soal3/locationfull.txt)"
	#echo $temploc
	greploc=$(grep "$temploc" /home/dimasadh/Documents/Praktikum1/soal3/location.txt | head -n1)
	#echo $greploc
	
	if [ "$temploc" == "$greploc" ]
	then
		# echo "duplicate"
		dupe=$((dupe+1))
		mv "/home/dimasadh/Documents/Praktikum1/soal3/pdkt_kusuma_$i" "/home/dimasadh/Documents/Praktikum1/soal3/duplicate/duplicate_$dupe"
	else
		awk '{print $2}' /home/dimasadh/Documents/Praktikum1/soal3/locationfull.txt >> /home/dimasadh/Documents/Praktikum1/soal3/location.txt
		kenangan=$((kenangan+1))
		mv "/home/dimasadh/Documents/Praktikum1/soal3/pdkt_kusuma_$i" "/home/dimasadh/Documents/Praktikum1/soal3/kenangan/kenangan_$kenangan"
	fi
done
