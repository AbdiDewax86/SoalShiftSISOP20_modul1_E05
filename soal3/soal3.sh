#!/bin/bash

dupe=$(find . -type f -name "*duplikat*" | wc -l)
kenangan=$(find . -type f -name "*kenangan*" | wc -l)
# echo $dupe
# echo $kenangan
for ((i=1;i<=28;i++))
do
	wget https://loremflickr.com/320/240/cat -O "pdkt_kusuma_$i" -o "wget.log"
	grep 'Location' "wget.log" > locationfull.txt
	cat wget.log >> log.txt

	temploc="$(awk '{print $2}' locationfull.txt)"
	#echo $temploc
	greploc=$(grep "$temploc" location.txt | head -n1)
	#echo $greploc
	
	if [ "$temploc" == "$greploc" ]
	then
		echo "duplikat"
		dupe=$((dupe+1))
		mv "pdkt_kusuma_$i" "duplikat/duplikat_$dupe"
	else
		awk '{print $2}' locationfull.txt >> location.txt
		kenangan=$((kenangan+1))
		mv "pdkt_kusuma_$i" "kenangan/kenangan_$kenangan"
	fi
done
