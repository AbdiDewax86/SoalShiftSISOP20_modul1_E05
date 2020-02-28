#!/bin/bash

filename=$1 # mengambil argument pertama sbg nama file
filename=${filename%.*} # menghilangkan extensi txt
jam=$(date +"%k") # mengambil jam saat ini
# echo $filename | grep -q '[0-9.!@#$%^&*()]'
if [[ "${filename}" =~ [^a-zA-Z] ]]; then
	echo "Invalid input"
else
	for ((x=1; x<=jam; x++))
	do
 		filename=$(echo "$filename" | tr '[A-Za-z]' '[B-ZAb-za]') 
		# iterasi sebanyak jam dan lakukan pergeseran sebesar 1 tiap iterasi
	done

	looper=1
	while [ $looper==1 ]
	do
		string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
		echo $string | grep -q '[A-Z]'
		if [ $? != 0 ]; then
			continue
		fi
		echo $string | grep -q '[a-z]'
		if [ $? != 0 ]; then
			continue
		fi
		echo $string | grep -q '[0-9]'
		if [ $? != 0 ]; then
			continue
		fi
		echo $string > "$filename.txt"
		break
	done
	# cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 25 | head -n 1 >> "$filename.txt" 
	# memasukkan random string sepanjang 28 karakter ke file
fi

