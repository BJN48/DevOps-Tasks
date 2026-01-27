#!/bin/bash
# Script Name: file_condition.sh
# Purpose: Storing values into varible
# Author: Bijehn
# Date: 25-01-2026
#
read -p " Enter file name: " file

if [ -e "$file" ]

then
	echo "File exists"
else
	echo "File not found"
fi

