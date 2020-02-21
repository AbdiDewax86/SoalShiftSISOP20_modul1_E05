#!/bin/bash

for ((i=1;i<=5;i++))
do
	wget https://loremflickr.com/320/240/cat -O "pdkt_kusuma_$i" -o wget.log
done
