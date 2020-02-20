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
