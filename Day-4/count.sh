#!/bin/bash
# Script Name: count.sh
# Purpose: Counting number of line in files
# Author: Bijehn
# Date: 25-01-2026
###

for file in *.txt
do
	echo "number of lines in $file"
	wc -l "$file"
done

