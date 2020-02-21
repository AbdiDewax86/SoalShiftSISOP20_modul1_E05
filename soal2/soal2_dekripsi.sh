#!/bin/bash

filename=$1 # mengambil argument pertama sbg nama file
jam=$(date -r $filename +"%k") # mengambil last modified hour dari file
filename2="${filename%%.*}" # nama file 2 untuk nama file yang akan disimpan

for ((x=1; x<=26-jam; x++))
do
 	filename2=$(echo "$filename2" | tr '[A-Za-z]' '[B-ZAb-za]') 
	#iterasi sebanyak 26-jam, agar cycle keseluruhan menjadi 26(encrypt+decrypt), sehingga 		nama file kembali ke nama awal
done

cat "$filename" > "$filename2.txt" # masukkan isi string ke decrypted file
