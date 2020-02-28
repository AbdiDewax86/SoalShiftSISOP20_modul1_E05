# SoalShiftSISOP20_modul1_E05
## Soal 1
#### Code:
```
#!/bin/bash

awk -f SM1soal1a.awk Sample-Superstore.tsv | sort -g | head -n1 | awk 'BEGIN{print "Region dengan profit terendah:"} {print $2}' # soal 1a

awk -f SM1soal1b.awk Sample-Superstore.tsv | sort -g | head -n2 | awk 'BEGIN{print "State dengan profit terendah:"} {print $2}' # soal 1b

awk -f SM1soal1cCombined.awk Sample-Superstore.tsv | sort -g | head -n10 | awk 'BEGIN{FS=";"; print "Produk dengan profit terendah:"} {print $2}' # soal 1c
```

Soal no 1 memanggil semua file SC awk yang khusus untuk no. 1 a, b, dan c. Hasil dari ketiga code tersebut lalu di sort, dicari n hasil pertama, dan diprint hasilnya. Code untuk file awk adalah sebagai berikut:

#### Code 1a:
```
#!/bin/bash

BEGIN{
FS="\t"
} 

{
if(NR!=1){
	arr[$13]+=$21
	}
} 

END {
for (i in arr) {
	print arr[i],i
	}
}
```
Dalam file Sample-Superstore.tsv, Field Separator adalah tab, maka dilakukan FS="\t".
Dalam mencari nilai tiap region, dilakukan pengelompokan berdasarkan region dan penambahan nilai profit berdasarkan region ke dalam bentuk array. Kondisi NR!=1 dilakukan agar baris pertama "Region" tidak masuk ke dalam array.
Setelah seluruh file dilalui, di print hasil profit dan nama region.

#### Code 1b:
```
#!/bin/bash

BEGIN{
FS="\t"
} 

{
if($13=="Central"){
	arr[$11]+=$21
	}
}

END {
for (i in arr) {
	print arr[i], i
	}
}
```
Dari soal 1a, diketahui bahwa region dengan profit paling sedikit adalah Central, maka region Central dijadikan kondisi untuk pengelompokan selanjutnya. Pengelompokan berdasarkan State, dan di print hasil profit dan state sesuai hasilnya.

#### Code 1c:
```
#!/bin/bash

BEGIN{
FS="\t";
OFS=";"
} 

{
if($11=="Texas" || $11=="Illinois"){
	arr[$17]+=$21
	}
}

END {
for (i in arr) {
	print arr[i], i
	}
}
```
Dari soal 1b, diketahui bahwa dua state dengan profit paling sedikit adalah Texas dan Illinois, maka kedua state tersebut dijadikan kondisi untuk pengelompokan selanjutnya. Pengelompokan selanjutnya berdasarkan produk, lalu di print profit dan produk sesuai hasilnya. Code ini menampilkan produk dengan profit terendah dari kedua state.

## Soal 2
#### Code untuk Encrypt (a,b,c):
```
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
```
Dalam code enkripsi ini, yang pertama dilakukan adalah mengambil argumen pertama sebagai nama file, dan menghilangkan ekstensi txt untuk sementara.
Nama file lalu dicek apakah hanya berisi alphabet. Jika terdapat karakter lain, maka file tidak akan terproses dan keluar "Invalid Input".
Untuk menetukan berapa banyak shift yang dilakukan, maka diambil jam saat file tersebut dibuat dengan command date.
Untuk enkripsi, dilakukan loop dan tr setiap kali loop. Loop diulang sebanyak jam, dan setiap loop dilakukan pergeseran 1 huruf, sehingga tergeser sebanyak nilai jam setelah loop selesai.
Untuk mengisi file txt dengan random string, digunakan /dev/urandom. Command tr digunakan untuk menspesifikasi agar string dalam bentuk alphanumeric. Fold dilakukan untuk membuat enter setiap 28 huruf, sehingga nantinya random string bisa diambil baris pertama menggunakan head. Hasil random string lalu dicek satu persatu apakah memiliki minimal 1 huruf besar, 1 huruf kecil, dan 1 angka. Jika tidak memiliki salah satu, maka akan dibuat string baru hingga memenuhi semua kondisi. Setelah itu, hasil random string dimasukkan ke file.

#### Code untuk Decrypt
```
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
```
Code dekripsi ini hampir sama dengan enkripsi, dengan perbedaan di jam, loop, dan pengisian file txt.
Setelah didapat nama file, disimpan lagi ke variabel lain tanpa ekstensi txt. Ini bertujuan untuk menyimpan nama file asal dan nama file tujuan.
Jam didapat dari jam terakhir suatu file diubah (last modified hour). Hasil tersebut lalu dipakai untuk loop, yaitu dengan cara 26-jam, agar didapat pergeseran yang harus dilakukan agar terjadi 1 kali cycle, sehingga nama file kembali ke semula.
Terakhir, command cat dipanggil untuk mendapatkan isi file enkripsi dan mengisi file yang telah di dekrip.

## Soal 3
#### Code
```
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
```
Hal yang pertama kali dilakukan dalam code ini adalah mencari index dari gambar terakhir duplicate dan kenangan dan menyimpannya ke suatu variabel. Kedua variabel tersebut digunakan untuk melanjutkan index jika gambar dipindah ke duplicate dan kenangan. Di dalam loop, didownload file dengan wget, dan disimpan dengan nama pdkt_kusuma_index dan log disimpan ke wget.log dan diappend ke log.bak. Wget.log di awk ke locationfull, yang meyimpan log file yang baru saja didownload, sehingga location gambar tersebut bisa diambil dan dibandingkan dengan location lain. Location gambar yang baru saja didownload disimpan di temploc, dan location gambar yang sudah didownload di simpan di location.txt, dan digrep dengan greploc. Jika sudah pernah didownload, maka greploc akan menyimpan lokasi download. Dalam kondisi, dibandingkan temploc dengan greploc. Jika temploc dan greploc sama, maka terdapat duplicate. Variabel dupe (counter untuk duplicate) diincrement, dan dijadikan index selanjutnya untuk duplicate, dan file pdkt_kusuma_i dipindah ke folder duplicate dan direname. Jika tidak sama, maka tidak terjadi duplicate. Variabel kenangan (counter untuk kenangan) diincrement, dan dijadikan index kenangan. File pdkt_kusuma_2 lalu dipindah ke folder kenangan dan direname
Full directory digunakan agar dapat dijalankan melalui crontab

#### Cronjob
Untuk cronjob, command yang dilakukan adalah sebagai berikut
```
 5 6-23/8 * * 0-5 "/home/jiahstrike/Sisop/soal/Modul 1/3/soal3.sh"
```
Command ini akan mengeksekusi script tiap menit ke 5, tiap 8 jam setelah jam 6, dan setiap hari dalam seminggu kecuali hari Sabtu
