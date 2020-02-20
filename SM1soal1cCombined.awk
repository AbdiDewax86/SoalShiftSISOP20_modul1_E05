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
