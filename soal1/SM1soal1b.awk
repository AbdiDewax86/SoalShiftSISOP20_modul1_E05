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
