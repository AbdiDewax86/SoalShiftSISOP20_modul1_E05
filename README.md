# SoalShiftSISOP20_modul1_E05
## Soal 1
Code:
```
#!/bin/bash

awk -f SM1soal1a.awk Sample-Superstore.tsv | sort -g | head -n1 | awk 'BEGIN{print "Region dengan profit terendah:"} {print $2}' # soal 1a

awk -f SM1soal1b.awk Sample-Superstore.tsv | sort -g | head -n2 | awk 'BEGIN{print "State dengan profit terendah:"} {print $2}' # soal 1b

awk -f SM1soal1cCombined.awk Sample-Superstore.tsv | sort -g | head -n10 | awk 'BEGIN{FS=";"; print "Produk dengan profit terendah:"} {print $2}' # soal 1c
```

Soal no 1 memanggil semua file SC awk yang khusus untuk no. 1 a, b, dan c. Code untuk file awk adalah sebagai berikut:

Code 1a:
