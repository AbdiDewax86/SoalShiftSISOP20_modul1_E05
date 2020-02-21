# SoalShiftSISOP20_modul1_E05
## Soal 1
###### Code:
```
#!/bin/bash

awk -f SM1soal1a.awk Sample-Superstore.tsv | sort -g | head -n1 | awk 'BEGIN{print "Region dengan profit terendah:"} {print $2}' # soal 1a

awk -f SM1soal1b.awk Sample-Superstore.tsv | sort -g | head -n2 | awk 'BEGIN{print "State dengan profit terendah:"} {print $2}' # soal 1b

awk -f SM1soal1cCombined.awk Sample-Superstore.tsv | sort -g | head -n10 | awk 'BEGIN{FS=";"; print "Produk dengan profit terendah:"} {print $2}' # soal 1c
```

Soal no 1 memanggil semua file SC awk yang khusus untuk no. 1 a, b, dan c. Hasil dari ketiga code tersebut lalu di sort, dicari n hasil pertama, dan diprint hasilnya. Code untuk file awk adalah sebagai berikut:

###### Code 1a:
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

###### Code 1b:
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

###### Code 1c:
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
Dari soal 1b, diketahui bahwa dua sstate dengan profit paling sedikit adalah Texas dan Illinois, maka kedua state tersebut dijadikan kondisi untuk pengelompokan selanjutnya. Pengelompokan selanjutnya berdasarkan produk, lalu di print profit dan produk sesuai hasilnya. Code ini menampilkan produk dengan profit terendah dari kedua state.

