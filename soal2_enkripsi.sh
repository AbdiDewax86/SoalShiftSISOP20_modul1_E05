#!/bin/bash

filename=$1 # mengambil argument pertama sbg nama file
filename=${filename%%.*} # menghilangkan extensi txt
jam=$(date +"%k") # mengambil jam saat ini

for ((x=1; x<=jam; x++))
do
 	filename=$(echo "$filename" | tr '[A-Za-z]' '[B-ZAb-za]') 
	# iterasi sebanyak jam dan lakukan pergeseran sebesar 1 tiap iterasi
done

cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1 > "$filename.txt" # memasukkan random string sepanjang 28 karakter ke file
